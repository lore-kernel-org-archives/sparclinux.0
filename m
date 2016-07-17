From: kpusukur <kishore.kumar.pusukuri@oracle.com>
Date: Sun, 17 Jul 2016 19:35:20 +0000
Subject: RFC: using worker threadpool to speed up clear_huge_page() by up to 5x
Message-Id: <b869a544-4684-ea9c-a1a6-84cfea3fec56@oracle.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------202558784D3898EBC808EBC8"
List-Id: <sparclinux.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------202558784D3898EBC808EBC8
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

A prototype implementation of multi-threaded clear_huge_page() function 
based on the kernel work queue mechansim speeds up the function by up to 
5x. The existing code requires 320ms to clear a 2Gb huge page on a Sparc 
M7 processor, while the multi-threaded version achieves this in 65ms 
using 16 threads. 8Mb huge pages see a 3.7x improvement, from 1400us to 
380us. Even though the M7 has a vast number of CPUs at its disposal, 
this idea could be utilized even on small multicore systems with just a 
few CPUs to achieve a significant performance gain. For instance, on a 
x86_64 system (ie, with an Intel E5-2630 v2), while it speeds up the 
function by 3.8x using 4 threads in clearing 1GB page, 3.7x using 4 
threads in clearing 2MB page. The principal application we have in mind 
that would benefit from this is an in-memory database which uses 
hundreds of huge pages, and starts up 2.5x faster using this 
implementation. In other words, it improves database down-times by 2.5x.

Here is a table which shows speedups in clearing 2GB huge pages on Sparc 
M7 (by default it takes 320 milliseconds). Time is in milliseconds.
#workers    Time
2    166
4    87
8    70
16    65
32    66
64    66

Please see attached patch for an implementation, which serves to 
illustrate the idea. There are many ways to improve it and tune it for 
different sized systems, and some of the issues we are thinking about are:
  1) How many tasks (workers) to use? There is just so much memory 
bandwidth, so scaling is not stellar, so it might be satisfactory to 
shoot for modest performance without tying up too many processors.
  2) The system load needs to be taken into account somehow..
  3) Numa issues might/should influence which cpus are chosen for the work.

We would welcome feedback and discussion of potential problems.

We would also like to hear ideas for other areas in the kernel where a 
similar technique could be employed. For example, we've also applied 
this idea to copy on write operations for huge pages and it achieves 
around 20x speedup.

Thank you.

Best
Kishore Pusukuri

--------------202558784D3898EBC808EBC8
Content-Type: text/x-patch;
 name="uek4_clear_huge_page_with_workqueues.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="uek4_clear_huge_page_with_workqueues.patch"

From 3a4365422d594d161c96d967f7bd3384a576f7eb Mon Sep 17 00:00:00 2001
From: Kishore Pusukuri <kishore.kumar.pusukuri@oracle.com>
Date: Thu, 14 Jul 2016 20:02:42 -0400
Subject: [PATCH] Speeds up clearing huge pages using work queue

The idea is to exploit parallelsim available in large multicore
systems such as SPARC T7/M7 to fill a huge page with zeros
using multiple worker threads.

Signed-off-by: Kishore Kumar Pusukuri <kishore.kumar.pusukuri@oracle.com>
Reviewed-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Reviewed-by: Nitin Gupta <nitin.m.gupta@oracle.com>
Reviewed-by: Rob Gardner <rob.gardner@oracle.com>
---
 mm/memory.c |  113 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 113 insertions(+), 0 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 22e037e..a1e4ca0 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -61,6 +61,8 @@
 #include <linux/string.h>
 #include <linux/dma-debug.h>
 #include <linux/debugfs.h>
+#include <linux/sched.h>
+#include <linux/workqueue.h>
 
 #include <asm/io.h>
 #include <asm/pgalloc.h>
@@ -3779,10 +3781,121 @@ static void clear_gigantic_page(struct page *page,
 		clear_user_highpage(p, addr + i * PAGE_SIZE);
 	}
 }
+
+struct clear_huge_page_work {
+	struct work_struct ws;
+	int index;
+	struct page *page;
+	unsigned long addr;
+	unsigned int pages_per_worker;
+	int is_gigantic_page;
+};
+
+static void clear_mem(struct work_struct *work)
+{
+	int i;
+	struct page *p;
+	struct clear_huge_page_work *w = (struct clear_huge_page_work *)work;
+	unsigned int start, end;
+
+	/* assume total number of pages is divisible by number of workers */
+	start = w->index * w->pages_per_worker;
+	end = (w->index + 1) * w->pages_per_worker;
+
+	might_sleep();
+	if (w->is_gigantic_page) {
+		p = mem_map_offset(w->page, start);
+		for (i = start; i < end; i++, p = mem_map_next(p, w->page, i)) {
+			cond_resched();
+			clear_user_highpage(p, w->addr + (i * PAGE_SIZE));
+		}
+	} else {
+		for (i = start; i < end; i++) {
+			cond_resched();
+			clear_user_highpage((w->page + i),
+						w->addr + (i * PAGE_SIZE));
+		}
+	}
+}
+
+/* use work queue to clear huge pages in parallel */
+static int wq_clear_huge_page(struct page *page, unsigned long addr,
+			unsigned int pages_per_huge_page, int num_workers)
+{
+	int i;
+	struct clear_huge_page_work *work;
+	struct workqueue_struct *wq;
+	unsigned int pages_per_worker;
+	int is_gigantic_page = 0;
+
+	if (unlikely(pages_per_huge_page > MAX_ORDER_NR_PAGES))
+		is_gigantic_page = 1;
+
+	pages_per_worker = pages_per_huge_page/num_workers;
+
+	wq = alloc_workqueue("wq_clear_huge_page", WQ_UNBOUND, num_workers);
+	if (!wq)
+		return -1;
+
+	work = kcalloc(num_workers, sizeof(*work), GFP_KERNEL);
+	if (!work) {
+		destroy_workqueue(wq);
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < num_workers; i++) {
+		INIT_WORK(&work[i].ws, clear_mem);
+		work[i].index = i;
+		work[i].page = page;
+		work[i].addr = addr;
+		work[i].pages_per_worker = pages_per_worker;
+		work[i].is_gigantic_page = is_gigantic_page;
+		queue_work(wq, &work[i].ws);
+	}
+
+	flush_workqueue(wq);
+	destroy_workqueue(wq);
+
+	kfree(work);
+
+	return 0;
+}
+
+
+int derive_num_workers(unsigned int pages_per_huge_page)
+{
+	int num_workers;
+	unsigned long huge_page_size;
+
+	huge_page_size = pages_per_huge_page * PAGE_SIZE;
+
+	/* less than 8MB */
+	if (huge_page_size < 8*1024*1024)
+		num_workers = 4;
+	else	/* 8MB and larger */
+		num_workers = 16;
+
+	return num_workers;
+}
+
+
 void clear_huge_page(struct page *page,
 		     unsigned long addr, unsigned int pages_per_huge_page)
 {
 	int i;
+	int num_workers;
+
+	/* If the number of vCPUs or hardware threads is greater than 16 then
+	 * use multiple threads to clear huge pages. Although we could also
+	 * consider overall system load as a factor in deciding this, for now,
+	 * let us have a simple implementation.
+	 */
+	if (num_online_cpus() >= 16) {
+		num_workers = derive_num_workers(pages_per_huge_page);
+		if (wq_clear_huge_page(page, addr, pages_per_huge_page,
+			num_workers) == 0)
+			return;
+	}
 
 	if (unlikely(pages_per_huge_page > MAX_ORDER_NR_PAGES)) {
 		clear_gigantic_page(page, addr, pages_per_huge_page);
-- 
1.7.1


--------------202558784D3898EBC808EBC8--

From: David Miller <davem@davemloft.net>
Date: Sat, 12 Dec 2009 06:55:53 +0000
Subject: [PATCH 8/10]: sparc64: Use free_bootmem_late() in mdesc_lmb_free().
Message-Id: <20091211.225553.59659092.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/mdesc.c |   21 ++++++---------------
 1 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/arch/sparc/kernel/mdesc.c b/arch/sparc/kernel/mdesc.c
index 938da19..cdc91d9 100644
--- a/arch/sparc/kernel/mdesc.c
+++ b/arch/sparc/kernel/mdesc.c
@@ -10,6 +10,7 @@
 #include <linux/slab.h>
 #include <linux/mm.h>
 #include <linux/miscdevice.h>
+#include <linux/bootmem.h>
 
 #include <asm/cpudata.h>
 #include <asm/hypervisor.h>
@@ -108,25 +109,15 @@ static struct mdesc_handle * __init mdesc_lmb_alloc(unsigned int mdesc_size)
 
 static void mdesc_lmb_free(struct mdesc_handle *hp)
 {
-	unsigned int alloc_size, handle_size = hp->handle_size;
-	unsigned long start, end;
+	unsigned int alloc_size;
+	unsigned long start;
 
 	BUG_ON(atomic_read(&hp->refcnt) != 0);
 	BUG_ON(!list_empty(&hp->list));
 
-	alloc_size = PAGE_ALIGN(handle_size);
-
-	start = (unsigned long) hp;
-	end = start + alloc_size;
-
-	while (start < end) {
-		struct page *p;
-
-		p = virt_to_page(start);
-		ClearPageReserved(p);
-		__free_page(p);
-		start += PAGE_SIZE;
-	}
+	alloc_size = PAGE_ALIGN(hp->handle_size);
+	start = __pa(hp);
+	free_bootmem_late(start, alloc_size);
 }
 
 static struct mdesc_mem_ops lmb_mdesc_ops = {
-- 
1.6.5


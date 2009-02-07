From: David Miller <davem@davemloft.net>
Date: Sat, 07 Feb 2009 07:23:52 +0000
Subject: Re: Sunfire V880 and 480R 2.6.27.x startup hangs
Message-Id: <20090206.232352.74134222.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20081219085622.GA20721@lemon.iwr.uni-heidelberg.de>
In-Reply-To: <20081219085622.GA20721@lemon.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
Date: Fri, 6 Feb 2009 11:28:25 +0100

> I bisected meanwhile the complete versions from 2.6.26 to 2.6.27 series:
> 
> <2.6.26.8	boots
>  2.6.27-rc1	compile fails (see below)
> >2.6.27-rc2	hangs at boot
> 
> Any chance that one of the last memory related patches will fix
> this problem ? Thanks.

It is possible.

Here are two seperate things you can try:

1) Boot with "memQ2m" on the kernel boot command line.

2) Try booting with the patch below.

Thanks!

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 51daae5..c9ab51a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -46,6 +46,7 @@
 #include <linux/page-isolation.h>
 #include <linux/memcontrol.h>
 #include <linux/debugobjects.h>
+#include <linux/nmi.h>
 
 #include <asm/tlbflush.h>
 #include <asm/div64.h>
@@ -707,7 +708,26 @@ static int move_freepages(struct zone *zone,
 	 * Remove at a later date when no bug reports exist related to
 	 * grouping pages by mobility
 	 */
-	BUG_ON(page_zone(start_page) != page_zone(end_page));
+	if (unlikely(page_zone(start_page) != page_zone(end_page))) {
+		printk(KERN_ERR "move_freepages: Bogus zones: "
+		       "start_page[%p] end_page[%p] zone[%p]\n",
+		       start_page, end_page, zone);
+		printk(KERN_ERR "move_freepages: "
+		       "start_zone[%p] end_zone[%p]\n",
+		       page_zone(start_page), page_zone(end_page));
+		printk(KERN_ERR "move_freepages: "
+		       "start_pfn[0x%lx] end_pfn[0x%lx]\n",
+		       page_to_pfn(start_page), page_to_pfn(end_page));
+		printk(KERN_ERR "move_freepages: "
+		       "start_nid[%d] end_nid[%d]\n",
+		       page_to_nid(start_page), page_to_nid(end_page));
+		spin_unlock(&zone->lock);
+		local_irq_enable();
+		while (1) {
+			barrier();
+			touch_nmi_watchdog();
+		}
+	}
 #endif
 
 	for (page = start_page; page <= end_page;) {
@@ -2583,6 +2603,7 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
 	unsigned long end_pfn = start_pfn + size;
 	unsigned long pfn;
 	struct zone *z;
+	int tmp;
 
 	z = &NODE_DATA(nid)->node_zones[zone];
 	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
@@ -2594,7 +2615,8 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
 		if (context = MEMMAP_EARLY) {
 			if (!early_pfn_valid(pfn))
 				continue;
-			if (!early_pfn_in_nid(pfn, nid))
+			tmp = early_pfn_to_nid(pfn);
+			if (tmp > -1 && tmp != nid)
 				continue;
 		}
 		page = pfn_to_page(pfn);
@@ -2961,8 +2983,9 @@ int __meminit early_pfn_to_nid(unsigned long pfn)
 			return early_node_map[i].nid;
 	}
 
-	return 0;
+	return -1;
 }
+
 #endif /* CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID */
 
 /* Basic iterator support to walk early_node_map[] */

From: David Miller <davem@davemloft.net>
Date: Sun, 14 Sep 2008 07:41:49 +0000
Subject: Re: psycho_irq_build: Wacky INO [3c]
Message-Id: <20080914.004149.14266467.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0809101731591.28457@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0809101731591.28457@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@ut.ee>
Date: Sun, 14 Sep 2008 10:27:21 +0300 (EEST)

> Calibrating delay using timer specific routine.. 801.65 BogoMIPS (lpj@08283)
> Mount-cache hash table entries: 512
> Fast Data Access MMU Miss
> {7} ok 

That's very very strange.  What's the most odd is that the firmware message
and error is from cpu #7, which from your e3500 prtconf we shouldn't even
be running on yet.  The system should boot on cpu #6.  So I suspect that
perhaps we are somehow corrupting some piece of firmware state on cpu #6
and this is why cpu #7 crashes us out to the firmware prompt.

The next non-trivial thing done in the boot sequence is mem_init() and that
prints a log message, which we aren't seeing here.

So here is a debugging patch that will trace the execution of mem_init() so
that we can perhaps figure out which part causes this crash.

Another thing you can do is type ".registers" when you get that firmware
prompt after the crash.  It will spit out some cpu state.

diff --git a/arch/sparc64/mm/init.c b/arch/sparc64/mm/init.c
index a41df7b..cb45e12 100644
--- a/arch/sparc64/mm/init.c
+++ b/arch/sparc64/mm/init.c
@@ -1894,6 +1894,9 @@ void __init mem_init(void)
 	unsigned long addr, last;
 	int i;
 
+#if 1
+	prom_printf("mem_init(): ENTER\n");
+#endif
 	i = last_valid_pfn >> ((22 - PAGE_SHIFT) + 6);
 	i += 1;
 	sparc64_valid_addr_bitmap = (unsigned long *) alloc_bootmem(i << 3);
@@ -1901,6 +1904,10 @@ void __init mem_init(void)
 		prom_printf("mem_init: Cannot alloc valid_addr_bitmap.\n");
 		prom_halt();
 	}
+#if 1
+	prom_printf("mem_init(): memset() on sparc64_valid_addr_bitmap(%p)\n",
+		sparc64_valid_addr_bitmap);
+#endif
 	memset(sparc64_valid_addr_bitmap, 0, i << 3);
 
 	addr = PAGE_OFFSET + kern_base;
@@ -1910,10 +1917,16 @@ void __init mem_init(void)
 		addr += PAGE_SIZE;
 	}
 
+#if 1
+	prom_printf("mem_init(): setup_valid_addr_bitmap_from_pavail()\n");
+#endif
 	setup_valid_addr_bitmap_from_pavail();
 
 	high_memory = __va(last_valid_pfn << PAGE_SHIFT);
 
+#if 1
+	prom_printf("mem_init(): free_bootmem()\n");
+#endif
 #ifdef CONFIG_NEED_MULTIPLE_NODES
 	for_each_online_node(i) {
 		if (NODE_DATA(i)->node_spanned_pages != 0) {
@@ -1935,6 +1948,9 @@ void __init mem_init(void)
 	 * Set up the zero page, mark it reserved, so that page count
 	 * is not manipulated when freeing the page from user ptes.
 	 */
+#if 1
+	prom_printf("mem_init(): Allocate mem_map_zero()\n");
+#endif
 	mem_map_zero = alloc_pages(GFP_KERNEL|__GFP_ZERO, 0);
 	if (mem_map_zero = NULL) {
 		prom_printf("paging_init: Cannot alloc zero page.\n");

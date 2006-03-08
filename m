From: "David S. Miller" <davem@davemloft.net>
Date: Wed, 08 Mar 2006 22:08:37 +0000
Subject: Re: Best bet for SPARC SMP and Sunfire V240
Message-Id: <20060308.140837.101496420.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <a728f9f90603071426g547ba79at30c36e545db70f01@mail.gmail.com>
In-Reply-To: <a728f9f90603071426g547ba79at30c36e545db70f01@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Richard Mortimer <richm@oldelvet.org.uk>
Date: Wed, 08 Mar 2006 21:54:54 +0000

> I'm not sure if you noticed this (but neither you or Dave mentioned it)
> so I'll mention it. But there is an earlier error in your log...
> 
> [   13.886016] BUG: spinlock wrong CPU on CPU#1, swapper/0
> [   13.886023]  lock: 00000000006bfa40, .magic: dead4ead, .owner: swapper/0, .owner_cpu: 0
> [   13.886029] Call Trace:
> [   13.886034]  [00000000006cc838] start_kernel+0x1d8/0x200
> [   13.886050]  [00000000004043f4] tlb_fixup_done+0x5c/0x64
> [   13.886060]  [0000000000000000] _start+0xffffffffffbfc000/0x12
> 
> Could that have been the start of things going wrong?

No, it's an unrelated bug... to be sure we should track it down,
but one thing at a time :)

I think the following patch will fix the problem Josh is
seeing.

Josh please give this a test as soon as you can, thanks a lot:

--- a/arch/sparc64/mm/init.c.~1~	2006-03-08 02:19:32.000000000 -0800
+++ b/arch/sparc64/mm/init.c	2006-03-08 14:07:25.000000000 -0800
@@ -1324,8 +1324,7 @@
 		    min_low_pfn, bootmap_pfn, max_low_pfn);
 #endif
 	bootmap_size = init_bootmem_node(NODE_DATA(0), bootmap_pfn,
-					 (phys_base >> PAGE_SHIFT),
-					 end_pfn);
+					 min_low_pfn, end_pfn);
 
 	/* Now register the available physical memory with the
 	 * allocator.
@@ -1569,7 +1568,7 @@
 	pages_avail = 0;
 	last_valid_pfn = end_pfn = bootmem_init(&pages_avail, phys_base);
 
-	max_mapnr = last_valid_pfn - (phys_base >> PAGE_SHIFT);
+	max_mapnr = last_valid_pfn;
 
 #ifdef CONFIG_DEBUG_PAGEALLOC
 	kernel_physical_mapping_init();
@@ -1578,18 +1577,17 @@
 	{
 		unsigned long zones_size[MAX_NR_ZONES];
 		unsigned long zholes_size[MAX_NR_ZONES];
-		unsigned long npages;
 		int znum;
 
 		for (znum = 0; znum < MAX_NR_ZONES; znum++)
 			zones_size[znum] = zholes_size[znum] = 0;
 
-		npages = end_pfn - (phys_base >> PAGE_SHIFT);
-		zones_size[ZONE_DMA] = npages;
-		zholes_size[ZONE_DMA] = npages - pages_avail;
+		zones_size[ZONE_DMA] = end_pfn;
+		zholes_size[ZONE_DMA] = end_pfn - pages_avail;
 
 		free_area_init_node(0, &contig_page_data, zones_size,
-				    phys_base >> PAGE_SHIFT, zholes_size);
+				    __pa(PAGE_OFFSET) >> PAGE_SHIFT,
+				    zholes_size);
 	}
 
 	device_scan();

From: Keith M Wesolowski <wesolows@foobazco.org>
Date: Mon, 03 May 2004 05:51:20 +0000
Subject: Re: Found the cause of my 2.6.6-rc boot failures
Message-Id: <20040503055120.GA2314@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040430015234.GH27793@artsapartment.org>
In-Reply-To: <20040430015234.GH27793@artsapartment.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Apr 29, 2004 at 08:52:34PM -0500, Art Haas wrote:

> The 1.69->1.70 changes in fs/dcache.c are the problem keeping my system
> from booting. This change introduced the bit of code where the global
> 'mempages' variable is reduced by calling nr_free_pages() and
> subtracting that result. By commenting out the change to on line 1634

Nice work, thanks.  This patch should solve the problem.  Please test.

=== arch/sparc/mm/init.c 1.27 vs edited ==--- 1.27/arch/sparc/mm/init.c	Sun Mar 21 14:43:34 2004
+++ edited/arch/sparc/mm/init.c	Sun May  2 22:42:14 2004
@@ -400,6 +400,7 @@
 	int codepages = 0;
 	int datapages = 0;
 	int initpages = 0; 
+	int reservedpages = 0;
 	int i;
 
 	highmem_start_page = pfn_to_page(highstart_pfn);
@@ -434,12 +435,14 @@
 	max_mapnr = last_valid_pfn - pfn_base;
 	high_memory = __va(max_low_pfn << PAGE_SHIFT);
 
-	num_physpages = totalram_pages = free_all_bootmem();
+	totalram_pages = free_all_bootmem();
 
 	for (i = 0; sp_banks[i].num_bytes != 0; i++) {
 		unsigned long start_pfn = sp_banks[i].base_addr >> PAGE_SHIFT;
 		unsigned long end_pfn = (sp_banks[i].base_addr + sp_banks[i].num_bytes) >> PAGE_SHIFT;
 
+		num_physpages += sp_banks[i].num_bytes >> PAGE_SHIFT;
+
 		if (end_pfn <= highstart_pfn)
 			continue;
 
@@ -458,13 +461,20 @@
 	initpages = (((unsigned long) &__init_end) - ((unsigned long) &__init_begin));
 	initpages = PAGE_ALIGN(initpages) >> PAGE_SHIFT;
 
-	printk(KERN_INFO "Memory: %dk available (%dk kernel code, %dk data, %dk init, %ldk highmem) [%08lx,%08lx]\n",
-	       nr_free_pages() << (PAGE_SHIFT-10),
+	/* Ignore memory holes for the purpose of counting reserved pages */
+	for (i=0; i < max_low_pfn; i++)
+		if (test_bit(i >> (20 - PAGE_SHIFT), sparc_valid_addr_bitmap)
+		    && PageReserved(pfn_to_page(i)))
+			reservedpages++;
+
+	printk(KERN_INFO "Memory: %luk/%luk available (%dk kernel code, %dk reserved, %dk data, %dk init, %ldk highmem)\n",
+	       (unsigned long) nr_free_pages() << (PAGE_SHIFT-10),
+	       num_physpages << (PAGE_SHIFT - 10),
 	       codepages << (PAGE_SHIFT-10),
+	       reservedpages << (PAGE_SHIFT - 10),
 	       datapages << (PAGE_SHIFT-10), 
 	       initpages << (PAGE_SHIFT-10),
-	       totalhigh_pages << (PAGE_SHIFT-10),
-	       (unsigned long)PAGE_OFFSET, (last_valid_pfn << PAGE_SHIFT));
+	       totalhigh_pages << (PAGE_SHIFT-10));
 }
 
 void free_initmem (void)


-- 
Keith M Wesolowski

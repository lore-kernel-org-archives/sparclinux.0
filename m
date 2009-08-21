From: David Miller <davem@davemloft.net>
Date: Fri, 21 Aug 2009 09:09:14 +0000
Subject: [BUGGY PATCH]: Validate D-tlb linear kernel faults
Message-Id: <20090821.020914.177118155.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


[ Please retain sparclinux@vger.kernel.org on all of your replies.  If
  you don't I will totally ignore your email, as I've warned about it
  and it's important for threads to stay on the list so everyone can
  see all parts of the discussion.  Thanks.  ]

This is a draft patch that implements the fix for the problem
that we don't validate the physical address that a linear
mapping translates to.

This patch is good enough to bootup but when I log into X on
my ultra45 random apps start crashing and then the machine
basically wedges.  So there are still some bugs to work out.

The nastiest problem is that we have to handle the case of
taking a TLB miss on the valid physical address bitmap itself.
So I just check if the fault is within the range of the table
and skip trying to load from the bitmap if so.  Otherwise we
fault recursively forever and reset the machine.

I noticed that kern_valid_addr() was buggy in that it didn't
check against last_valid_pfn before trying to index into the
valid address bitmap.  We only allocate the bitmap for that
much memory, so it's easy to feed kern_valid_addr() a bogus
address which will access past the bitmap memory.

Lastly, this sort of duplicates DEBUG_PAGEALLOC's functionality
so we can probably ifdef out these validation checks when
that debugging feature is enabled in the config.

diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index b049abf..e6d36ee 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -726,11 +726,18 @@ extern unsigned long pte_file(pte_t);
 extern pte_t pgoff_to_pte(unsigned long);
 #define PTE_FILE_MAX_BITS	(64UL - PAGE_SHIFT - 1UL)
 
+extern unsigned long last_valid_pfn;
 extern unsigned long *sparc64_valid_addr_bitmap;
 
 /* Needs to be defined here and not in linux/mm.h, as it is arch dependent */
-#define kern_addr_valid(addr)	\
-	(test_bit(__pa((unsigned long)(addr))>>22, sparc64_valid_addr_bitmap))
+static inline bool kern_addr_valid(unsigned long addr)
+{
+	unsigned long paddr = __pa(addr);
+
+	if ((paddr >> PAGE_SHIFT) > last_valid_pfn)
+		return false;
+	return test_bit(paddr >> 22, sparc64_valid_addr_bitmap);
+}
 
 extern int page_in_phys_avail(unsigned long paddr);
 
diff --git a/arch/sparc/kernel/ktlb.S b/arch/sparc/kernel/ktlb.S
index cef8def..05b5cb4 100644
--- a/arch/sparc/kernel/ktlb.S
+++ b/arch/sparc/kernel/ktlb.S
@@ -151,12 +151,52 @@ kvmap_dtlb_4v:
 	 * Must preserve %g1 and %g6 (TAG).
 	 */
 kvmap_dtlb_tsb4m_miss:
-	sethi		%hi(kpte_linear_bitmap), %g2
+	/* Clear the PAGE_OFFSET top virtual bits, shift
+	 * down to get PFN, and make sure PFN is in range.
+	 */
+	sllx		%g4, 21, %g5
+	sethi		%hi(last_valid_pfn), %g2
+	srlx		%g5, 21 + PAGE_SHIFT, %g7
+	ldx		[%g2 + %lo(last_valid_pfn)], %g2
+	cmp		%g7, %g2
+	bgu,pn		%xcc, kvmap_dtlb_longpath /* too large */
+
+	/* Check to see if we know about valid memory at the 4MB
+	 * chunk this physical address will reside within.  This
+	 * bitmap will not be allocated early in the boot process,
+	 * and thus this will be NULL and we have to bypass this
+	 * safety check.
+	 *
+	 * Another further complication is that we don't want to
+	 * recurse endlessly on the bitmap itself, which is also
+	 * mapped into the linear kernel mapping ranage.
+	 */
+	 sethi		%hi(sparc64_valid_addr_bitmap), %g7
+	ldx		[%g7 + %lo(sparc64_valid_addr_bitmap)], %g7
+	brz,pn		%g7, 2f /* early boot, bypass check */
+	 cmp		%g7, %g4
+	bgu,pt		%xcc, 1f
+	 srlx		%g2, ((22 - PAGE_SHIFT) + 6), %g2
+	add		%g2, 1, %g2
+	sllx		%g2, 3, %g2
+	add		%g7, %g2, %g2
+	cmp		%g2, %g4
+	bgu,pn		%xcc, 2f /* don't recurse on bitmap */
+
+1:	 srlx		%g5, 21 + 22, %g2
+	srlx		%g2, 6, %g5
+	and		%g2, 63, %g2
+	sllx		%g5, 3, %g5
+	ldx		[%g7 + %g5], %g5
+	mov		1, %g7
+	sllx		%g7, %g2, %g7
+	andcc		%g5, %g7, %g0
+	be,pn		%xcc, kvmap_dtlb_longpath
+
+2:	 sethi		%hi(kpte_linear_bitmap), %g2
 	or		%g2, %lo(kpte_linear_bitmap), %g2
 
-	/* Clear the PAGE_OFFSET top virtual bits, then shift
-	 * down to get a 256MB physical address index.
-	 */
+	/* Get the 256MB physical address index. */
 	sllx		%g4, 21, %g5
 	mov		1, %g7
 	srlx		%g5, 21 + 28, %g5
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index ed6be6b..cf3ab7d 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -145,6 +145,12 @@ static void __init read_obp_memory(const char *property,
 	     cmp_p64, NULL);
 }
 
+/* Set this to infinity so that linear area TLB misses work before
+ * we finish setting up bootmem.
+ */
+unsigned long last_valid_pfn __read_mostly = ~0UL;
+EXPORT_SYMBOL(last_valid_pfn);
+
 unsigned long *sparc64_valid_addr_bitmap __read_mostly;
 EXPORT_SYMBOL(sparc64_valid_addr_bitmap);
 
@@ -1673,7 +1679,6 @@ void __cpuinit sun4v_ktsb_register(void)
 
 /* paging_init() sets up the page tables */
 
-static unsigned long last_valid_pfn;
 pgd_t swapper_pg_dir[2048];
 
 static void sun4u_pgprot_init(void);
@@ -1874,7 +1879,7 @@ static int pavail_rescan_ents __initdata;
  * memory list again, and make sure it provides at least as much
  * memory as 'pavail' does.
  */
-static void __init setup_valid_addr_bitmap_from_pavail(void)
+static void __init setup_valid_addr_bitmap_from_pavail(unsigned long *bitmap)
 {
 	int i;
 
@@ -1897,8 +1902,7 @@ static void __init setup_valid_addr_bitmap_from_pavail(void)
 
 				if (new_start <= old_start &&
 				    new_end >= (old_start + PAGE_SIZE)) {
-					set_bit(old_start >> 22,
-						sparc64_valid_addr_bitmap);
+					set_bit(old_start >> 22, bitmap);
 					goto do_next_page;
 				}
 			}
@@ -1922,26 +1926,32 @@ static void __init setup_valid_addr_bitmap_from_pavail(void)
 void __init mem_init(void)
 {
 	unsigned long codepages, datapages, initpages;
-	unsigned long addr, last;
+	unsigned long addr, last, *bitmap;
 	int i;
 
 	i = last_valid_pfn >> ((22 - PAGE_SHIFT) + 6);
 	i += 1;
-	sparc64_valid_addr_bitmap = (unsigned long *) alloc_bootmem(i << 3);
-	if (sparc64_valid_addr_bitmap = NULL) {
+	bitmap = (unsigned long *) alloc_bootmem(i << 3);
+	if (bitmap = NULL) {
 		prom_printf("mem_init: Cannot alloc valid_addr_bitmap.\n");
 		prom_halt();
 	}
-	memset(sparc64_valid_addr_bitmap, 0, i << 3);
+	memset(bitmap, 0, i << 3);
 
 	addr = PAGE_OFFSET + kern_base;
 	last = PAGE_ALIGN(kern_size) + addr;
 	while (addr < last) {
-		set_bit(__pa(addr) >> 22, sparc64_valid_addr_bitmap);
+		set_bit(__pa(addr) >> 22, bitmap);
 		addr += PAGE_SIZE;
 	}
 
-	setup_valid_addr_bitmap_from_pavail();
+	setup_valid_addr_bitmap_from_pavail(bitmap);
+
+	/* We can only set this pointer after we've fully filled in the
+	 * bitmap, because once it's non-NULL the TLB miss handling
+	 * framework uses this to validate kernel fault addresses.
+	 */
+	sparc64_valid_addr_bitmap = bitmap;
 
 	high_memory = __va(last_valid_pfn << PAGE_SHIFT);
 

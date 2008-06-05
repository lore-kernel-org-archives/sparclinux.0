From: Adrian Bunk <bunk@kernel.org>
Date: Thu, 05 Jun 2008 18:26:27 +0000
Subject: [RFC: 2.6 patch] sparc/mm/: possible cleanups
Message-Id: <20080605182625.GH1469@cs181133002.pp.htv.fi>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This patch contains the following possible cleanups:
- make the following needlessly global code static:
  - fault.c: force_user_fault()
  - init.c: calc_max_low_pfn()
  - init.c: pgt_cache_water[]
  - init.c: map_high_region()
  - srmmu.c: hwbug_bitmask
  - srmmu.c: srmmu_swapper_pg_dir
  - srmmu.c: srmmu_context_table
  - srmmu.c: is_hypersparc
  - srmmu.c: srmmu_cache_pagetables
  - srmmu.c: srmmu_nocache_size
  - srmmu.c: srmmu_nocache_end
  - srmmu.c: srmmu_get_nocache()
  - srmmu.c: srmmu_free_nocache()
  - srmmu.c: srmmu_early_allocate_ptable_skeleton()
  - srmmu.c: srmmu_nocache_calcsize()
  - srmmu.c: srmmu_nocache_init()
  - srmmu.c: srmmu_alloc_thread_info()
  - srmmu.c: early_pgtable_allocfail()
  - srmmu.c: srmmu_early_allocate_ptable_skeleton()
  - srmmu.c: srmmu_allocate_ptable_skeleton()
  - srmmu.c: srmmu_inherit_prom_mappings()
  - sunami.S: tsunami_copy_1page
- remove the following unused code:
  - init.c: struct sparc_aliases

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---

 arch/sparc/mm/fault.c    |    2 +-
 arch/sparc/mm/init.c     |    8 +++-----
 arch/sparc/mm/srmmu.c    |   38 +++++++++++++++++++++-----------------
 arch/sparc/mm/tsunami.S  |    1 -
 include/asm-sparc/mbus.h |    2 --
 include/asm-sparc/page.h |    2 --
 6 files changed, 25 insertions(+), 28 deletions(-)

19cf3983357196148353ec303f43e843f885a922 diff --git a/arch/sparc/mm/fault.c b/arch/sparc/mm/fault.c
index 0a3cd8f..3604c2e 100644
--- a/arch/sparc/mm/fault.c
+++ b/arch/sparc/mm/fault.c
@@ -451,7 +451,7 @@ asmlinkage void do_sun4c_fault(struct pt_regs *regs, int text_fault, int write,
 }
 
 /* This always deals with user addresses. */
-inline void force_user_fault(unsigned long address, int write)
+static void force_user_fault(unsigned long address, int write)
 {
 	struct vm_area_struct *vma;
 	struct task_struct *tsk = current;
diff --git a/arch/sparc/mm/init.c b/arch/sparc/mm/init.c
index 7794ecb..8f94a2d 100644
--- a/arch/sparc/mm/init.c
+++ b/arch/sparc/mm/init.c
@@ -128,7 +128,7 @@ unsigned long calc_highpages(void)
 	return nr;
 }
 
-unsigned long calc_max_low_pfn(void)
+static unsigned long calc_max_low_pfn(void)
 {
 	int i;
 	unsigned long tmp = pfn_base + (SRMMU_MAXMEM >> PAGE_SHIFT);
@@ -292,7 +292,7 @@ unsigned long __init bootmem_init(unsigned long *pages_avail)
  *
  * We simply copy the 2.4 implementation for now.
  */
-int pgt_cache_water[2] = { 25, 50 };
+static int pgt_cache_water[2] = { 25, 50 };
 
 void check_pgt_cache(void)
 {
@@ -356,8 +356,6 @@ void __init paging_init(void)
 	device_scan();
 }
 
-struct cache_palias *sparc_aliases;
-
 static void __init taint_real_pages(void)
 {
 	int i;
@@ -375,7 +373,7 @@ static void __init taint_real_pages(void)
 	}
 }
 
-void map_high_region(unsigned long start_pfn, unsigned long end_pfn)
+static void map_high_region(unsigned long start_pfn, unsigned long end_pfn)
 {
 	unsigned long tmp;
 
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 23d3291..c624e04 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -50,7 +50,7 @@
 #include <asm/btfixup.h>
 
 enum mbus_module srmmu_modtype;
-unsigned int hwbug_bitmask;
+static unsigned int hwbug_bitmask;
 int vac_cache_size;
 int vac_line_size;
 
@@ -60,7 +60,7 @@ extern unsigned long last_valid_pfn;
 
 extern unsigned long page_kernel;
 
-pgd_t *srmmu_swapper_pg_dir;
+static pgd_t *srmmu_swapper_pg_dir;
 
 #ifdef CONFIG_SMP
 #define FLUSH_BEGIN(mm)
@@ -83,12 +83,12 @@ BTFIXUPDEF_CALL(void, local_flush_page_for_dma, unsigned long)
 char *srmmu_name;
 
 ctxd_t *srmmu_ctx_table_phys;
-ctxd_t *srmmu_context_table;
+static ctxd_t *srmmu_context_table;
 
 int viking_mxcc_present;
 static DEFINE_SPINLOCK(srmmu_context_spinlock);
 
-int is_hypersparc;
+static int is_hypersparc;
 
 /*
  * In general all page table modifications should use the V8 atomic
@@ -112,11 +112,11 @@ static inline int srmmu_device_memory(unsigned long x)
 	return ((x & 0xF0000000) != 0);
 }
 
-int srmmu_cache_pagetables;
+static int srmmu_cache_pagetables;
 
 /* these will be initialized in srmmu_nocache_calcsize() */
-unsigned long srmmu_nocache_size;
-unsigned long srmmu_nocache_end;
+static unsigned long srmmu_nocache_size;
+static unsigned long srmmu_nocache_end;
 
 /* 1 bit <=> 256 bytes of nocache <=> 64 PTEs */
 #define SRMMU_NOCACHE_BITMAP_SHIFT (PAGE_SHIFT - 4)
@@ -324,7 +324,7 @@ static unsigned long __srmmu_get_nocache(int size, int align)
 	return (SRMMU_NOCACHE_VADDR + (offset << SRMMU_NOCACHE_BITMAP_SHIFT));
 }
 
-unsigned inline long srmmu_get_nocache(int size, int align)
+static unsigned long srmmu_get_nocache(int size, int align)
 {
 	unsigned long tmp;
 
@@ -336,7 +336,7 @@ unsigned inline long srmmu_get_nocache(int size, int align)
 	return tmp;
 }
 
-void srmmu_free_nocache(unsigned long vaddr, int size)
+static void srmmu_free_nocache(unsigned long vaddr, int size)
 {
 	int offset;
 
@@ -369,7 +369,8 @@ void srmmu_free_nocache(unsigned long vaddr, int size)
 	bit_map_clear(&srmmu_nocache_map, offset, size);
 }
 
-void srmmu_early_allocate_ptable_skeleton(unsigned long start, unsigned long end);
+static void srmmu_early_allocate_ptable_skeleton(unsigned long start,
+						 unsigned long end);
 
 extern unsigned long probe_memory(void);	/* in fault.c */
 
@@ -377,7 +378,7 @@ extern unsigned long probe_memory(void);	/* in fault.c */
  * Reserve nocache dynamically proportionally to the amount of
  * system RAM. -- Tomas Szepe <szepe@pinerecords.com>, June 2002
  */
-void srmmu_nocache_calcsize(void)
+static void srmmu_nocache_calcsize(void)
 {
 	unsigned long sysmemavail = probe_memory() / 1024;
 	int srmmu_nocache_npages;
@@ -398,7 +399,7 @@ void srmmu_nocache_calcsize(void)
 	srmmu_nocache_end = SRMMU_NOCACHE_VADDR + srmmu_nocache_size;
 }
 
-void __init srmmu_nocache_init(void)
+static void __init srmmu_nocache_init(void)
 {
 	unsigned int bitmap_bits;
 	pgd_t *pgd;
@@ -645,7 +646,7 @@ static void srmmu_unmapiorange(unsigned long virt_addr, unsigned int len)
  * mappings on the kernel stack without any special code as we did
  * need on the sun4c.
  */
-struct thread_info *srmmu_alloc_thread_info(void)
+static struct thread_info *srmmu_alloc_thread_info(void)
 {
 	struct thread_info *ret;
 
@@ -1045,13 +1046,14 @@ extern void hypersparc_setup_blockops(void);
  *       around 8mb mapped for us.
  */
 
-void __init early_pgtable_allocfail(char *type)
+static void __init early_pgtable_allocfail(char *type)
 {
 	prom_printf("inherit_prom_mappings: Cannot alloc kernel %s.\n", type);
 	prom_halt();
 }
 
-void __init srmmu_early_allocate_ptable_skeleton(unsigned long start, unsigned long end)
+static void __init srmmu_early_allocate_ptable_skeleton(unsigned long start,
+							unsigned long end)
 {
 	pgd_t *pgdp;
 	pmd_t *pmdp;
@@ -1081,7 +1083,8 @@ void __init srmmu_early_allocate_ptable_skeleton(unsigned long start, unsigned l
 	}
 }
 
-void __init srmmu_allocate_ptable_skeleton(unsigned long start, unsigned long end)
+static void __init srmmu_allocate_ptable_skeleton(unsigned long start,
+						  unsigned long end)
 {
 	pgd_t *pgdp;
 	pmd_t *pmdp;
@@ -1116,7 +1119,8 @@ void __init srmmu_allocate_ptable_skeleton(unsigned long start, unsigned long en
  * looking at the prom's page table directly which is what most
  * other OS's do.  Yuck... this is much better.
  */
-void __init srmmu_inherit_prom_mappings(unsigned long start,unsigned long end)
+static void __init srmmu_inherit_prom_mappings(unsigned long start,
+					       unsigned long end)
 {
 	pgd_t *pgdp;
 	pmd_t *pmdp;
diff --git a/arch/sparc/mm/tsunami.S b/arch/sparc/mm/tsunami.S
index db0d6de..4e55e8f 100644
--- a/arch/sparc/mm/tsunami.S
+++ b/arch/sparc/mm/tsunami.S
@@ -93,7 +93,6 @@ tsunami_flush_tlb_page_out:
 	ldd	[src + offset + 0x00], t2; \
 	std	t2, [dst + offset + 0x00];
 
-	.globl	tsunami_copy_1page
 tsunami_copy_1page:
 /* NOTE: This routine has to be shorter than 70insns --jj */
 	or	%g0, (PAGE_SIZE >> 8), %g1
diff --git a/include/asm-sparc/mbus.h b/include/asm-sparc/mbus.h
index bb5ae61..69f07a0 100644
--- a/include/asm-sparc/mbus.h
+++ b/include/asm-sparc/mbus.h
@@ -43,8 +43,6 @@ extern unsigned int viking_rev, swift_rev, cypress_rev;
 #define HWBUG_SUPERSCALAR_BAD        0x00000080
 #define HWBUG_PACINIT_BITROT         0x00000100
 
-extern unsigned int hwbug_bitmask;
-
 /* First the module type values. To find out which you have, just load
  * the mmu control register from ASI_M_MMUREG alternate address space and
  * shift the value right 28 bits.
diff --git a/include/asm-sparc/page.h b/include/asm-sparc/page.h
index 6aa9e4c..14de518 100644
--- a/include/asm-sparc/page.h
+++ b/include/asm-sparc/page.h
@@ -58,8 +58,6 @@ struct cache_palias {
 	int context;
 };
 
-extern struct cache_palias *sparc_aliases;
-
 /* passing structs on the Sparc slow us down tremendously... */
 
 /* #define STRICT_MM_TYPECHECKS */


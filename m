From: David Miller <davem@davemloft.net>
Date: Sat, 12 May 2012 07:40:53 +0000
Subject: [PATCH] sparc32: Trivial removal of sun4c references in comments.
Message-Id: <20120512.034053.443801685170789037.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


I left some around, like the ones in the openprom headers, since
we need to think about which pieces of those datastructures and
code we can completely toss now.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/dma.h        |    3 +--
 arch/sparc/include/asm/machines.h   |    2 +-
 arch/sparc/include/asm/pgtable_32.h |    6 +-----
 arch/sparc/kernel/ioport.c          |    5 -----
 arch/sparc/kernel/irq.h             |    2 +-
 arch/sparc/kernel/irq_64.c          |    2 +-
 arch/sparc/mm/fault_32.c            |    4 ----
 arch/sparc/mm/init_32.c             |    5 ++---
 arch/sparc/mm/srmmu.c               |    3 +--
 9 files changed, 8 insertions(+), 24 deletions(-)

diff --git a/arch/sparc/include/asm/dma.h b/arch/sparc/include/asm/dma.h
index b554927..67e017f 100644
--- a/arch/sparc/include/asm/dma.h
+++ b/arch/sparc/include/asm/dma.h
@@ -123,8 +123,7 @@ BTFIXUPDEF_CALL(void,  mmu_release_scsi_sgl, struct device *, struct scatterlist
  * Second mapping is for device visible address, or "bus" address.
  * The bus address is returned at '*pba'.
  *
- * These functions seem distinct, but are hard to split. On sun4c,
- * at least for now, 'a' is equal to bus address, and retured in *pba.
+ * These functions seem distinct, but are hard to split.
  * On sun4m, page attributes depend on the CPU type, so we have to
  * know if we are mapping RAM or I/O, so it has to be an additional argument
  * to a separate mapping function for CPU visible mappings.
diff --git a/arch/sparc/include/asm/machines.h b/arch/sparc/include/asm/machines.h
index 597c478..fd6ddb0 100644
--- a/arch/sparc/include/asm/machines.h
+++ b/arch/sparc/include/asm/machines.h
@@ -19,7 +19,7 @@ struct Sun_Machine_Models {
  * ---------------
  *  7    4 3    0
  *
- * The ARCH field determines the architecture line (sun4, sun4c, etc).
+ * The ARCH field determines the architecture line (sun4m, etc).
  * The MACH field determines the machine make within that architecture.
  */
 
diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
index 9f3ab0a..9de855c 100644
--- a/arch/sparc/include/asm/pgtable_32.h
+++ b/arch/sparc/include/asm/pgtable_32.h
@@ -304,8 +304,7 @@ BTFIXUPDEF_CALL(pte_t *, pte_offset_kernel, pmd_t *, unsigned long)
 #define pte_offset_kernel(dir,addr) BTFIXUP_CALL(pte_offset_kernel)(dir,addr)
 
 /*
- * This shortcut works on sun4m (and sun4d) because the nocache area is static,
- * and sun4c is guaranteed to have no highmem anyway.
+ * This shortcut works on sun4m (and sun4d) because the nocache area is static.
  */
 #define pte_offset_map(d, a)		pte_offset_kernel(d,a)
 #define pte_unmap(pte)		do{}while(0)
@@ -367,7 +366,6 @@ static inline pte_t pgoff_to_pte(unsigned long pgoff)
 
 /*
  * This is made a constant because mm/fremap.c required a constant.
- * Note that layout of these bits is different between sun4c.c and srmmu.c.
  */
 #define PTE_FILE_MAX_BITS 24
 
@@ -471,10 +469,8 @@ static inline int io_remap_pfn_range(struct vm_area_struct *vma,
 #endif /* !(__ASSEMBLY__) */
 
 #define VMALLOC_START           _AC(0xfe600000,UL)
-/* XXX Alter this when I get around to fixing sun4c - Anton */
 #define VMALLOC_END             _AC(0xffc00000,UL)
 
-
 /* We provide our own get_unmapped_area to cope with VA holes for userland */
 #define HAVE_ARCH_UNMAPPED_AREA
 
diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
index 21bd739..9b93da1 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -381,11 +381,6 @@ static int sbus_map_sg(struct device *dev, struct scatterlist *sg, int n,
 		       enum dma_data_direction dir, struct dma_attrs *attrs)
 {
 	mmu_get_scsi_sgl(dev, sg, n);
-
-	/*
-	 * XXX sparc64 can return a partial length here. sun4c should do this
-	 * but it currently panics if it can't fulfill the request - Anton
-	 */
 	return n;
 }
 
diff --git a/arch/sparc/kernel/irq.h b/arch/sparc/kernel/irq.h
index 8b946b1..593e7a5 100644
--- a/arch/sparc/kernel/irq.h
+++ b/arch/sparc/kernel/irq.h
@@ -78,7 +78,7 @@ void handler_irq(unsigned int pil, struct pt_regs *regs);
 /* Dave Redman (djhr@tadpole.co.uk)
  * changed these to function pointers.. it saves cycles and will allow
  * the irq dependencies to be split into different files at a later date
- * sun4c_irq.c, sun4m_irq.c etc so we could reduce the kernel size.
+ * sun4m_irq.c etc so we could reduce the kernel size.
  * Jakub Jelinek (jj@sunsite.mff.cuni.cz)
  * Changed these to btfixup entities... It saves cycles :)
  */
diff --git a/arch/sparc/kernel/irq_64.c b/arch/sparc/kernel/irq_64.c
index dff2c3d..9bcbbe2 100644
--- a/arch/sparc/kernel/irq_64.c
+++ b/arch/sparc/kernel/irq_64.c
@@ -799,7 +799,7 @@ static void kill_prom_timer(void)
 	prom_limit0 = prom_timers->limit0;
 	prom_limit1 = prom_timers->limit1;
 
-	/* Just as in sun4c/sun4m PROM uses timer which ticks at IRQ 14.
+	/* Just as in sun4c PROM uses timer which ticks at IRQ 14.
 	 * We turn both off here just to be paranoid.
 	 */
 	prom_timers->limit0 = 0;
diff --git a/arch/sparc/mm/fault_32.c b/arch/sparc/mm/fault_32.c
index dd020b2..5d37f1f 100644
--- a/arch/sparc/mm/fault_32.c
+++ b/arch/sparc/mm/fault_32.c
@@ -235,10 +235,6 @@ asmlinkage void do_sparc_fault(struct pt_regs *regs, int text_fault, int write,
 retry:
 	down_read(&mm->mmap_sem);
 
-	/*
-	 * The kernel referencing a bad kernel pointer can lock up
-	 * a sun4c machine completely, so we must attempt recovery.
-	 */
 	if(!from_user && address >= PAGE_OFFSET)
 		goto bad_area;
 
diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
index 21342db..753676c 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -289,9 +289,8 @@ unsigned long __init bootmem_init(unsigned long *pages_avail)
  * check_pgt_cache
  *
  * This is called at the end of unmapping of VMA (zap_page_range),
- * to rescan the page cache for architecture specific things,
- * presumably something like sun4/sun4c PMEGs. Most architectures
- * define check_pgt_cache empty.
+ * to rescan the page cache for architecture specific things.
+ * Most architectures define check_pgt_cache empty.
  *
  * We simply copy the 2.4 implementation for now.
  */
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index d85da15..564269d 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -647,8 +647,7 @@ static void srmmu_unmapiorange(unsigned long virt_addr, unsigned int len)
  * pool.  As a side effect we are putting a little too much pressure
  * on the gfp() subsystem.  This setup also makes the logic of the
  * iommu mapping code a lot easier as we can transparently handle
- * mappings on the kernel stack without any special code as we did
- * need on the sun4c.
+ * mappings on the kernel stack without any special code.
  */
 struct thread_info *alloc_thread_info_node(struct task_struct *tsk, int node)
 {
-- 
1.7.10


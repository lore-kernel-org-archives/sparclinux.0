From: Adam Buchbinder <adam.buchbinder@gmail.com>
Date: Fri, 04 Mar 2016 19:21:18 +0000
Subject: [PATCH] sparc: Fix misspellings in comments.
Message-Id: <1457119278-15335-1-git-send-email-adam.buchbinder@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Adam Buchbinder <adam.buchbinder@gmail.com>
---
 arch/sparc/include/asm/pgtable_64.h   | 2 +-
 arch/sparc/include/asm/processor_64.h | 2 +-
 arch/sparc/include/asm/tsb.h          | 2 +-
 arch/sparc/kernel/entry.S             | 2 +-
 arch/sparc/kernel/ioport.c            | 6 +++---
 arch/sparc/kernel/leon_kernel.c       | 2 +-
 arch/sparc/kernel/sysfs.c             | 2 +-
 arch/sparc/net/bpf_jit_comp.c         | 2 +-
 8 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index 7a38d6a..f089cfa 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -218,7 +218,7 @@ extern pgprot_t PAGE_KERNEL_LOCKED;
 extern pgprot_t PAGE_COPY;
 extern pgprot_t PAGE_SHARED;
 
-/* XXX This uglyness is for the atyfb driver's sparc mmap() support. XXX */
+/* XXX This ugliness is for the atyfb driver's sparc mmap() support. XXX */
 extern unsigned long _PAGE_IE;
 extern unsigned long _PAGE_E;
 extern unsigned long _PAGE_CACHE;
diff --git a/arch/sparc/include/asm/processor_64.h b/arch/sparc/include/asm/processor_64.h
index 6924bde..ce2595c 100644
--- a/arch/sparc/include/asm/processor_64.h
+++ b/arch/sparc/include/asm/processor_64.h
@@ -201,7 +201,7 @@ unsigned long get_wchan(struct task_struct *task);
 #define KSTK_ESP(tsk)  (task_pt_regs(tsk)->u_regs[UREG_FP])
 
 /* Please see the commentary in asm/backoff.h for a description of
- * what these instructions are doing and how they have been choosen.
+ * what these instructions are doing and how they have been chosen.
  * To make a long story short, we are trying to yield the current cpu
  * strand during busy loops.
  */
diff --git a/arch/sparc/include/asm/tsb.h b/arch/sparc/include/asm/tsb.h
index ecb49cf..c6a155c 100644
--- a/arch/sparc/include/asm/tsb.h
+++ b/arch/sparc/include/asm/tsb.h
@@ -149,7 +149,7 @@ extern struct tsb_phys_patch_entry __tsb_phys_patch, __tsb_phys_patch_end;
 	 * page size in question.  So for PMD mappings (which fall on
 	 * bit 23, for 8MB per PMD) we must propagate bit 22 for a
 	 * 4MB huge page.  For huge PUDs (which fall on bit 33, for
-	 * 8GB per PUD), we have to accomodate 256MB and 2GB huge
+	 * 8GB per PUD), we have to accommodate 256MB and 2GB huge
 	 * pages.  So for those we propagate bits 32 to 28.
 	 */
 #define KERN_PGTABLE_WALK(VADDR, REG1, REG2, FAIL_LABEL)	\
diff --git a/arch/sparc/kernel/entry.S b/arch/sparc/kernel/entry.S
index 33c02b1..9544193 100644
--- a/arch/sparc/kernel/entry.S
+++ b/arch/sparc/kernel/entry.S
@@ -1238,7 +1238,7 @@ flush_patch_exception:
 kuw_patch1_7win:	sll	%o3, 6, %o3
 
 	/* No matter how much overhead this routine has in the worst
-	 * case scenerio, it is several times better than taking the
+	 * case scenario, it is several times better than taking the
 	 * traps with the old method of just doing flush_user_windows().
 	 */
 kill_user_windows:
diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
index 28fed53..ffd5ff4 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -131,7 +131,7 @@ void __iomem *ioremap(unsigned long offset, unsigned long size)
 EXPORT_SYMBOL(ioremap);
 
 /*
- * Comlimentary to ioremap().
+ * Complementary to ioremap().
  */
 void iounmap(volatile void __iomem *virtual)
 {
@@ -233,7 +233,7 @@ _sparc_ioremap(struct resource *res, u32 bus, u32 pa, int sz)
 }
 
 /*
- * Comlimentary to _sparc_ioremap().
+ * Complementary to _sparc_ioremap().
  */
 static void _sparc_free_io(struct resource *res)
 {
@@ -532,7 +532,7 @@ static void pci32_unmap_page(struct device *dev, dma_addr_t ba, size_t size,
 }
 
 /* Map a set of buffers described by scatterlist in streaming
- * mode for DMA.  This is the scather-gather version of the
+ * mode for DMA.  This is the scatter-gather version of the
  * above pci_map_single interface.  Here the scatter gather list
  * elements are each tagged with the appropriate dma address
  * and length.  They are obtained via sg_dma_{address,length}(SG).
diff --git a/arch/sparc/kernel/leon_kernel.c b/arch/sparc/kernel/leon_kernel.c
index 42efcf8..33cd171 100644
--- a/arch/sparc/kernel/leon_kernel.c
+++ b/arch/sparc/kernel/leon_kernel.c
@@ -203,7 +203,7 @@ static struct irq_chip leon_irq = {
 
 /*
  * Build a LEON IRQ for the edge triggered LEON IRQ controller:
- *  Edge (normal) IRQ           - handle_simple_irq, ack=DONT-CARE, never ack
+ *  Edge (normal) IRQ           - handle_simple_irq, ack=DON'T-CARE, never ack
  *  Level IRQ (PCI|Level-GPIO)  - handle_fasteoi_irq, ack=1, ack after ISR
  *  Per-CPU Edge                - handle_percpu_irq, ack=0
  */
diff --git a/arch/sparc/kernel/sysfs.c b/arch/sparc/kernel/sysfs.c
index 7f41d40..fa8e21a 100644
--- a/arch/sparc/kernel/sysfs.c
+++ b/arch/sparc/kernel/sysfs.c
@@ -1,4 +1,4 @@
-/* sysfs.c: Toplogy sysfs support code for sparc64.
+/* sysfs.c: Topology sysfs support code for sparc64.
  *
  * Copyright (C) 2007 David S. Miller <davem@davemloft.net>
  */
diff --git a/arch/sparc/net/bpf_jit_comp.c b/arch/sparc/net/bpf_jit_comp.c
index 3e6e05a..a6d9204 100644
--- a/arch/sparc/net/bpf_jit_comp.c
+++ b/arch/sparc/net/bpf_jit_comp.c
@@ -351,7 +351,7 @@ do {	*prog++ = BR_OPC | WDISP22(OFF);		\
  *
  * Sometimes we need to emit a branch earlier in the code
  * sequence.  And in these situations we adjust "destination"
- * to accomodate this difference.  For example, if we needed
+ * to accommodate this difference.  For example, if we needed
  * to emit a branch (and it's delay slot) right before the
  * final instruction emitted for a BPF opcode, we'd use
  * "destination + 4" instead of just plain "destination" above.
-- 
2.7.0.rc3.207.g0ac5344


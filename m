From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 14 May 2012 20:29:51 +0000
Subject: [RFC PATCH] sparc32,leon: always include leon code in build
Message-Id: <20120514202951.GA4439@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From c1caf78ed4ce33bc15ba5e1f186938a1c6668049 Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 14 May 2012 22:22:26 +0200
Subject: [PATCH] sparc32,leon: always include leon code in build

Numerous times I have hit situations where my changes failed
to build on LEON.
Update so we always include leon code in the build.

The resulting kernel will NOT boot on leon, but in this way we
avoid introducing regressions in leon specific parts of the code.

As leon and sun4x uses different values for ASI_M_MMUREGS
I do not expect the same kernel to actually boot both
on leon and sun boxes.
At least I see no way around this right now.

All other differences looks manageable if we can find a way around
the ASI_M_MMUREGS issue.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Konrad Eisele <konrad@gaisler.com>
Cc: Daniel Hellstrom <daniel@gaisler.com>
---
 arch/sparc/include/asm/leon.h      |   19 +------------------
 arch/sparc/include/asm/leon_amba.h |    4 ----
 arch/sparc/include/asm/pgtsrmmu.h  |   16 ----------------
 arch/sparc/kernel/Makefile         |    4 ++--
 arch/sparc/kernel/entry.S          |    3 ---
 arch/sparc/kernel/leon_smp.c       |    4 ----
 arch/sparc/mm/Makefile             |    2 +-
 arch/sparc/mm/leon_mm.c            |    2 +-
 arch/sparc/mm/srmmu.c              |   18 ++++++++++++++++--
 9 files changed, 21 insertions(+), 51 deletions(-)

diff --git a/arch/sparc/include/asm/leon.h b/arch/sparc/include/asm/leon.h
index 8095be2..7a5c396 100644
--- a/arch/sparc/include/asm/leon.h
+++ b/arch/sparc/include/asm/leon.h
@@ -8,8 +8,6 @@
 #ifndef LEON_H_INCLUDE
 #define LEON_H_INCLUDE
 
-#ifdef CONFIG_SPARC_LEON
-
 #define ASI_LEON_NOCACHE	0x01
 
 #define ASI_LEON_DCACHE_MISS	0x1
@@ -278,7 +276,7 @@ static inline int sparc_leon3_cpuid(void)
 #define LEON2_CFG_SSIZE_MASK 0x00007000UL
 
 #ifndef __ASSEMBLY__
-extern unsigned long srmmu_swprobe(unsigned long vaddr, unsigned long *paddr);
+extern unsigned long leon_srmmu_swprobe(unsigned long vaddr, unsigned long *paddr);
 extern void leon_flush_icache_all(void);
 extern void leon_flush_dcache_all(void);
 extern void leon_flush_cache_all(void);
@@ -326,7 +324,6 @@ extern void leon_trans_init(struct device_node *dp);
 extern void leon_node_init(struct device_node *dp, struct device_node ***nextp);
 extern void leon_init_IRQ(void);
 extern void leon_init(void);
-extern unsigned long srmmu_swprobe(unsigned long vaddr, unsigned long *paddr);
 extern void init_leon(void);
 extern void poke_leonsparc(void);
 extern void leon3_getCacheRegs(struct leon3_cacheregs *regs);
@@ -367,18 +364,4 @@ extern int leon_ipi_irq;
 #define _pfn_valid(pfn)	 ((pfn < last_valid_pfn) && (pfn >= PFN(phys_base)))
 #define _SRMMU_PTE_PMASK_LEON 0xffffffff
 
-#else /* defined(CONFIG_SPARC_LEON) */
-
-/* nop definitions for !LEON case */
-#define leon_init() do {} while (0)
-#define leon_switch_mm() do {} while (0)
-#define leon_init_IRQ() do {} while (0)
-#define init_leon() do {} while (0)
-#define leon_smp_done() do {} while (0)
-#define leon_boot_cpus() do {} while (0)
-#define leon_boot_one_cpu(i) 1
-#define leon_init_smp() do {} while (0)
-
-#endif /* !defined(CONFIG_SPARC_LEON) */
-
 #endif
diff --git a/arch/sparc/include/asm/leon_amba.h b/arch/sparc/include/asm/leon_amba.h
index e50f326..f3034ed 100644
--- a/arch/sparc/include/asm/leon_amba.h
+++ b/arch/sparc/include/asm/leon_amba.h
@@ -87,8 +87,6 @@ struct amba_prom_registers {
 #define LEON3_GPTIMER_CONFIG_NRTIMERS(c) ((c)->config & 0x7)
 #define LEON3_GPTIMER_CTRL_ISPENDING(r)  (((r)&LEON3_GPTIMER_CTRL_PENDING) ? 1 : 0)
 
-#ifdef CONFIG_SPARC_LEON
-
 #ifndef __ASSEMBLY__
 
 struct leon3_irqctrl_regs_map {
@@ -264,6 +262,4 @@ extern unsigned int sparc_leon_eirq;
 
 #define amba_device(x) (((x) >> 12) & 0xfff)
 
-#endif /* !defined(CONFIG_SPARC_LEON) */
-
 #endif
diff --git a/arch/sparc/include/asm/pgtsrmmu.h b/arch/sparc/include/asm/pgtsrmmu.h
index f6ae2b2..065e036 100644
--- a/arch/sparc/include/asm/pgtsrmmu.h
+++ b/arch/sparc/include/asm/pgtsrmmu.h
@@ -267,22 +267,6 @@ static inline void srmmu_flush_tlb_page(unsigned long page)
 
 }
 
-#ifndef CONFIG_SPARC_LEON
-static inline unsigned long srmmu_hwprobe(unsigned long vaddr)
-{
-	unsigned long retval;
-
-	vaddr &= PAGE_MASK;
-	__asm__ __volatile__("lda [%1] %2, %0\n\t" :
-			     "=r" (retval) :
-			     "r" (vaddr | 0x400), "i" (ASI_M_FLUSH_PROBE));
-
-	return retval;
-}
-#else
-#define srmmu_hwprobe(addr) srmmu_swprobe(addr, 0)
-#endif
-
 static inline int
 srmmu_get_pte (unsigned long addr)
 {
diff --git a/arch/sparc/kernel/Makefile b/arch/sparc/kernel/Makefile
index bfb93c3..aca3044 100644
--- a/arch/sparc/kernel/Makefile
+++ b/arch/sparc/kernel/Makefile
@@ -53,8 +53,8 @@ obj-y                   += of_device_common.o
 obj-y                   += of_device_$(BITS).o
 obj-$(CONFIG_SPARC64)   += prom_irqtrans.o
 
-obj-$(CONFIG_SPARC_LEON)+= leon_kernel.o
-obj-$(CONFIG_SPARC_LEON)+= leon_pmc.o
+obj-$(CONFIG_SPARC32)   += leon_kernel.o
+obj-$(CONFIG_SPARC32)   += leon_pmc.o
 
 obj-$(CONFIG_SPARC64)   += reboot.o
 obj-$(CONFIG_SPARC64)   += sysfs.o
diff --git a/arch/sparc/kernel/entry.S b/arch/sparc/kernel/entry.S
index 3215b6d..8ea040c 100644
--- a/arch/sparc/kernel/entry.S
+++ b/arch/sparc/kernel/entry.S
@@ -388,7 +388,6 @@ linux_trap_ipi15_sun4d:
 	/* FIXME */
 1:	b,a	1b
 
-#ifdef CONFIG_SPARC_LEON
 	.globl	smpleon_ipi
 	.extern leon_ipi_interrupt
 	/* SMP per-cpu IPI interrupts are handled specially. */
@@ -419,8 +418,6 @@ linux_trap_ipi15_leon:
 	b	ret_trap_lockless_ipi
 	 clr	%l6
 
-#endif /* CONFIG_SPARC_LEON */
-
 #endif /* CONFIG_SMP */
 
 	/* This routine handles illegal instructions and privileged
diff --git a/arch/sparc/kernel/leon_smp.c b/arch/sparc/kernel/leon_smp.c
index 29325ba..0c1b358 100644
--- a/arch/sparc/kernel/leon_smp.c
+++ b/arch/sparc/kernel/leon_smp.c
@@ -48,8 +48,6 @@
 
 #include "kernel.h"
 
-#ifdef CONFIG_SPARC_LEON
-
 #include "irq.h"
 
 extern ctxd_t *srmmu_ctx_table_phys;
@@ -512,5 +510,3 @@ void __init leon_init_smp(void)
 
 	sparc32_ipi_ops = &leon_ipi_ops;
 }
-
-#endif /* CONFIG_SPARC_LEON */
diff --git a/arch/sparc/mm/Makefile b/arch/sparc/mm/Makefile
index 69ffd31..389aebd 100644
--- a/arch/sparc/mm/Makefile
+++ b/arch/sparc/mm/Makefile
@@ -9,7 +9,7 @@ obj-y                   += fault_$(BITS).o
 obj-y                   += init_$(BITS).o
 obj-$(CONFIG_SPARC32)   += extable.o srmmu.o iommu.o io-unit.o
 obj-$(CONFIG_SPARC32)   += hypersparc.o viking.o tsunami.o swift.o
-obj-$(CONFIG_SPARC_LEON)+= leon_mm.o
+obj-$(CONFIG_SPARC32)   += leon_mm.o
 
 # Only used by sparc64
 obj-$(CONFIG_HUGETLB_PAGE) += hugetlbpage.o
diff --git a/arch/sparc/mm/leon_mm.c b/arch/sparc/mm/leon_mm.c
index 13c2169..ec866eb 100644
--- a/arch/sparc/mm/leon_mm.c
+++ b/arch/sparc/mm/leon_mm.c
@@ -18,7 +18,7 @@
 int leon_flush_during_switch = 1;
 int srmmu_swprobe_trace;
 
-unsigned long srmmu_swprobe(unsigned long vaddr, unsigned long *paddr)
+unsigned long leon_srmmu_swprobe(unsigned long vaddr, unsigned long *paddr)
 {
 
 	unsigned int ctxtbl;
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 765b1a5..b569ecf 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -928,6 +928,22 @@ static void __init srmmu_allocate_ptable_skeleton(unsigned long start,
 	}
 }
 
+static unsigned long srmmu_hwprobe(unsigned long vaddr)
+{
+	if (sparc_cpu_model != sparc_leon) {
+		unsigned long retval;
+
+		vaddr &= PAGE_MASK;
+		__asm__ __volatile__("lda [%1] %2, %0\n\t" :
+				     "=r" (retval) :
+				     "r" (vaddr | 0x400), "i" (ASI_M_FLUSH_PROBE));
+
+		return retval;
+	} else {
+		return leon_srmmu_swprobe(vaddr, 0);
+	}
+}
+
 /*
  * This is much cleaner than poking around physical address space
  * looking at the prom's page table directly which is what most
@@ -1801,7 +1817,6 @@ static void __init init_viking(void)
 	poke_srmmu = poke_viking;
 }
 
-#ifdef CONFIG_SPARC_LEON
 static void leon_flush_cache_mm(struct mm_struct *mm)
 {
 	leon_flush_cache_all();
@@ -1880,7 +1895,6 @@ void __init init_leon(void)
 
 	leon_flush_during_switch = leon_flush_needed();
 }
-#endif
 
 /* Probe for the srmmu chip version. */
 static void __init get_srmmu_type(void)
-- 
1.6.0.6


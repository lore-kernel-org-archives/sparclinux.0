From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 26 May 2012 07:20:12 +0000
Subject: [PATCH 08/15] sparc32,leon: clean up leon.h
Message-Id: <1338016819-22245-8-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

- Drop unused stuff accumulated over time
- Drop non-leon stuff
- Include almost all of the header unconditionally

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Daniel Hellstrom <daniel@gaisler.com>
Cc: Konrad Eisele <konrad@gaisler.com>
---
 arch/sparc/include/asm/leon.h     |   67 +-----------------------------------
 arch/sparc/include/asm/pgtsrmmu.h |    1 +
 arch/sparc/kernel/leon_kernel.c   |    1 +
 3 files changed, 4 insertions(+), 65 deletions(-)

diff --git a/arch/sparc/include/asm/leon.h b/arch/sparc/include/asm/leon.h
index 0765912..00530a5 100644
--- a/arch/sparc/include/asm/leon.h
+++ b/arch/sparc/include/asm/leon.h
@@ -8,8 +8,6 @@
 #ifndef LEON_H_INCLUDE
 #define LEON_H_INCLUDE
 
-#ifdef CONFIG_SPARC_LEON
-
 /* mmu register access, ASI_LEON_MMUREGS */
 #define LEON_CNR_CTRL		0x000
 #define LEON_CNR_CTXP		0x100
@@ -62,15 +60,6 @@
 
 #ifndef __ASSEMBLY__
 
-/* do a virtual address read without cache */
-static inline unsigned long leon_readnobuffer_reg(unsigned long paddr)
-{
-	unsigned long retval;
-	__asm__ __volatile__("lda [%1] %2, %0\n\t" :
-			     "=r"(retval) : "r"(paddr), "i"(ASI_LEON_NOCACHE));
-	return retval;
-}
-
 /* do a physical address bypass write, i.e. for 0x80000000 */
 static inline void leon_store_reg(unsigned long paddr, unsigned long value)
 {
@@ -87,47 +76,16 @@ static inline unsigned long leon_load_reg(unsigned long paddr)
 	return retval;
 }
 
-static inline void leon_srmmu_disabletlb(void)
-{
-	unsigned int retval;
-	__asm__ __volatile__("lda [%%g0] %2, %0\n\t" : "=r"(retval) : "r"(0),
-			     "i"(ASI_LEON_MMUREGS));
-	retval |= LEON_CNR_CTRL_TLBDIS;
-	__asm__ __volatile__("sta %0, [%%g0] %2\n\t" : : "r"(retval), "r"(0),
-			     "i"(ASI_LEON_MMUREGS) : "memory");
-}
-
-static inline void leon_srmmu_enabletlb(void)
-{
-	unsigned int retval;
-	__asm__ __volatile__("lda [%%g0] %2, %0\n\t" : "=r"(retval) : "r"(0),
-			     "i"(ASI_LEON_MMUREGS));
-	retval = retval & ~LEON_CNR_CTRL_TLBDIS;
-	__asm__ __volatile__("sta %0, [%%g0] %2\n\t" : : "r"(retval), "r"(0),
-			     "i"(ASI_LEON_MMUREGS) : "memory");
-}
-
 /* macro access for leon_load_reg() and leon_store_reg() */
 #define LEON3_BYPASS_LOAD_PA(x)	    (leon_load_reg((unsigned long)(x)))
 #define LEON3_BYPASS_STORE_PA(x, v) (leon_store_reg((unsigned long)(x), (unsigned long)(v)))
-#define LEON3_BYPASS_ANDIN_PA(x, v) LEON3_BYPASS_STORE_PA(x, LEON3_BYPASS_LOAD_PA(x) & v)
-#define LEON3_BYPASS_ORIN_PA(x, v)  LEON3_BYPASS_STORE_PA(x, LEON3_BYPASS_LOAD_PA(x) | v)
 #define LEON_BYPASS_LOAD_PA(x)      leon_load_reg((unsigned long)(x))
 #define LEON_BYPASS_STORE_PA(x, v)  leon_store_reg((unsigned long)(x), (unsigned long)(v))
-#define LEON_REGLOAD_PA(x)          leon_load_reg((unsigned long)(x)+LEON_PREGS)
-#define LEON_REGSTORE_PA(x, v)      leon_store_reg((unsigned long)(x)+LEON_PREGS, (unsigned long)(v))
-#define LEON_REGSTORE_OR_PA(x, v)   LEON_REGSTORE_PA(x, LEON_REGLOAD_PA(x) | (unsigned long)(v))
-#define LEON_REGSTORE_AND_PA(x, v)  LEON_REGSTORE_PA(x, LEON_REGLOAD_PA(x) & (unsigned long)(v))
-
-/* macro access for leon_readnobuffer_reg() */
-#define LEON_BYPASSCACHE_LOAD_VA(x) leon_readnobuffer_reg((unsigned long)(x))
 
 extern void leon_init(void);
 extern void leon_switch_mm(void);
 extern void leon_init_IRQ(void);
 
-extern unsigned long last_valid_pfn;
-
 static inline unsigned long sparc_leon3_get_dcachecfg(void)
 {
 	unsigned int retval;
@@ -230,9 +188,6 @@ static inline int sparc_leon3_cpuid(void)
 #error cannot determine LEON_PAGE_SIZE_LEON
 #endif
 
-#define PAGE_MIN_SHIFT   (12)
-#define PAGE_MIN_SIZE    (1UL << PAGE_MIN_SHIFT)
-
 #define LEON3_XCCR_SETS_MASK  0x07000000UL
 #define LEON3_XCCR_SSIZE_MASK 0x00f00000UL
 
@@ -258,15 +213,6 @@ struct leon3_cacheregs {
 	unsigned long dccr;	/* 0x0c - Data Cache Configuration Register */
 };
 
-/* struct that hold LEON2 cache configuration register
- * & configuration register
- */
-struct leon2_cacheregs {
-	unsigned long ccr, cfg;
-};
-
-#ifdef __KERNEL__
-
 #include <linux/interrupt.h>
 
 struct device_node;
@@ -292,24 +238,15 @@ extern void leon_smp_done(void);
 extern void leon_boot_cpus(void);
 extern int leon_boot_one_cpu(int i, struct task_struct *);
 void leon_init_smp(void);
-extern void cpu_idle(void);
-extern void init_IRQ(void);
-extern void cpu_panic(void);
-extern int __leon_processor_id(void);
 void leon_enable_irq_cpu(unsigned int irq_nr, unsigned int cpu);
 extern irqreturn_t leon_percpu_timer_interrupt(int irq, void *unused);
 
-extern unsigned int real_irq_entry[];
 extern unsigned int smpleon_ipi[];
-extern unsigned int patchme_maybe_smp_msg[];
-extern unsigned int t_nmi[], linux_trap_ipi15_leon[];
-extern unsigned int linux_trap_ipi15_sun4m[];
+extern unsigned int linux_trap_ipi15_leon[];
 extern int leon_ipi_irq;
 
 #endif /* CONFIG_SMP */
 
-#endif /* __KERNEL__ */
-
 #endif /* __ASSEMBLY__ */
 
 /* macros used in leon_mm.c */
@@ -317,7 +254,7 @@ extern int leon_ipi_irq;
 #define _pfn_valid(pfn)	 ((pfn < last_valid_pfn) && (pfn >= PFN(phys_base)))
 #define _SRMMU_PTE_PMASK_LEON 0xffffffff
 
-#else /* defined(CONFIG_SPARC_LEON) */
+#ifndef CONFIG_SPARC_LEON
 
 /* nop definitions for !LEON case */
 #define leon_init() do {} while (0)
diff --git a/arch/sparc/include/asm/pgtsrmmu.h b/arch/sparc/include/asm/pgtsrmmu.h
index cb82870..394fe25 100644
--- a/arch/sparc/include/asm/pgtsrmmu.h
+++ b/arch/sparc/include/asm/pgtsrmmu.h
@@ -139,6 +139,7 @@
 	 restore %g0, %g0, %g0;
 
 #ifndef __ASSEMBLY__
+extern unsigned long last_valid_pfn;
 
 /* This makes sense. Honest it does - Anton */
 /* XXX Yes but it's ugly as sin.  FIXME. -KMW */
diff --git a/arch/sparc/kernel/leon_kernel.c b/arch/sparc/kernel/leon_kernel.c
index 77c1b91..e34e2c4 100644
--- a/arch/sparc/kernel/leon_kernel.c
+++ b/arch/sparc/kernel/leon_kernel.c
@@ -23,6 +23,7 @@
 #include <asm/smp.h>
 #include <asm/setup.h>
 
+#include "kernel.h"
 #include "prom.h"
 #include "irq.h"
 
-- 
1.6.0.6


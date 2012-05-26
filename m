From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 26 May 2012 07:20:14 +0000
Subject: [PATCH 10/15] sparc32,leon: always include leon_smp + leon_mm in build
Message-Id: <1338016819-22245-10-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix-up leon specific assembler to use ASI_LEON_MMUREGS

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Daniel Hellstrom <daniel@gaisler.com>
Cc: Konrad Eisele <konrad@gaisler.com>
---
 arch/sparc/include/asm/leon.h     |   12 ------------
 arch/sparc/kernel/entry.S         |    3 ---
 arch/sparc/kernel/head_32.S       |    3 ---
 arch/sparc/kernel/leon_smp.c      |    4 ----
 arch/sparc/kernel/trampoline_32.S |    6 +-----
 arch/sparc/mm/Makefile            |    2 +-
 6 files changed, 2 insertions(+), 28 deletions(-)

diff --git a/arch/sparc/include/asm/leon.h b/arch/sparc/include/asm/leon.h
index 95fa931..995c4e0 100644
--- a/arch/sparc/include/asm/leon.h
+++ b/arch/sparc/include/asm/leon.h
@@ -254,16 +254,4 @@ extern int leon_ipi_irq;
 #define _pfn_valid(pfn)	 ((pfn < last_valid_pfn) && (pfn >= PFN(phys_base)))
 #define _SRMMU_PTE_PMASK_LEON 0xffffffff
 
-#ifndef CONFIG_SPARC_LEON
-
-/* nop definitions for !LEON case */
-#define leon_switch_mm() do {} while (0)
-#define init_leon() do {} while (0)
-#define leon_smp_done() do {} while (0)
-#define leon_boot_cpus() do {} while (0)
-#define leon_boot_one_cpu(i, t) 1
-#define leon_init_smp() do {} while (0)
-
-#endif /* !defined(CONFIG_SPARC_LEON) */
-
 #endif
diff --git a/arch/sparc/kernel/entry.S b/arch/sparc/kernel/entry.S
index 2dbe180..8550f10 100644
--- a/arch/sparc/kernel/entry.S
+++ b/arch/sparc/kernel/entry.S
@@ -393,7 +393,6 @@ linux_trap_ipi15_sun4d:
 	/* FIXME */
 1:	b,a	1b
 
-#ifdef CONFIG_SPARC_LEON
 	.globl	smpleon_ipi
 	.extern leon_ipi_interrupt
 	/* SMP per-cpu IPI interrupts are handled specially. */
@@ -424,8 +423,6 @@ linux_trap_ipi15_leon:
 	b	ret_trap_lockless_ipi
 	 clr	%l6
 
-#endif /* CONFIG_SPARC_LEON */
-
 #endif /* CONFIG_SMP */
 
 	/* This routine handles illegal instructions and privileged
diff --git a/arch/sparc/kernel/head_32.S b/arch/sparc/kernel/head_32.S
index 6c6b8c2..cdc7f29 100644
--- a/arch/sparc/kernel/head_32.S
+++ b/arch/sparc/kernel/head_32.S
@@ -387,12 +387,9 @@ execute_in_high_mem:
 #ifdef CONFIG_SMP
 		ldub	[%g2 + %lo(boot_cpu_id)], %g1
 		cmp	%g1, 0xff		! unset means first CPU
-#ifdef CONFIG_SPARC_LEON
-		/* XXX Hack to allow build - remove ifdef later */
 		bne	leon_smp_cpu_startup	! continue only with master
 		 nop
 #endif
-#endif
 		/* Get CPU-ID from most significant 4-bit of ASR17 */
 		rd     %asr17, %g1
 		srl    %g1, 28, %g1
diff --git a/arch/sparc/kernel/leon_smp.c b/arch/sparc/kernel/leon_smp.c
index a469090..218c2f0 100644
--- a/arch/sparc/kernel/leon_smp.c
+++ b/arch/sparc/kernel/leon_smp.c
@@ -48,8 +48,6 @@
 
 #include "kernel.h"
 
-#ifdef CONFIG_SPARC_LEON
-
 #include "irq.h"
 
 extern ctxd_t *srmmu_ctx_table_phys;
@@ -507,5 +505,3 @@ void __init leon_init_smp(void)
 
 	sparc32_ipi_ops = &leon_ipi_ops;
 }
-
-#endif /* CONFIG_SPARC_LEON */
diff --git a/arch/sparc/kernel/trampoline_32.S b/arch/sparc/kernel/trampoline_32.S
index 7364ddc..af27aca 100644
--- a/arch/sparc/kernel/trampoline_32.S
+++ b/arch/sparc/kernel/trampoline_32.S
@@ -149,8 +149,6 @@ sun4d_cpu_startup:
 
 	b,a	smp_do_cpu_idle
 
-#ifdef CONFIG_SPARC_LEON
-
 	__CPUINIT
 	.align	4
         .global leon_smp_cpu_startup, smp_penguin_ctable
@@ -161,7 +159,7 @@ leon_smp_cpu_startup:
         ld [%g1+4],%g1
         srl %g1,4,%g1
         set 0x00000100,%g5 /* SRMMU_CTXTBL_PTR */
-	sta %g1, [%g5] ASI_M_MMUREGS
+	sta %g1, [%g5] ASI_LEON_MMUREGS
 
 	/* Set up a sane %psr -- PIL<0xf> S<0x1> PS<0x1> CWP<0x0> */
 	set	(PSR_PIL | PSR_S | PSR_PS), %g1
@@ -207,5 +205,3 @@ leon_smp_cpu_startup:
 	 nop
 
 	b,a	smp_do_cpu_idle
-
-#endif
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
-- 
1.6.0.6


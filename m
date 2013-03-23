From: Kirill Tkhai <tkhai@yandex.ru>
Date: Sat, 23 Mar 2013 11:44:55 +0000
Subject: [PATCH] sparc64: Move offset calculation of several structures to asm-offset.c
Message-Id: <1631521364039095@web14d.yandex.ru>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

1)Calculate offset of members of thread_info, trap_per_cpu and tsb_config
in asm-offset.c
2)Replace DEFINE(*, offsetof(...)) with OFFSET(...)
3)Inify using of asm-offset.h in header files

Signed-off-by: Kirill Tkhai <tkhai@yandex.ru>
CC: David Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/hibernate.h      |    8 +++
 arch/sparc/include/asm/mmu_64.h         |   13 ++---
 arch/sparc/include/asm/thread_info_64.h |   29 +++--------
 arch/sparc/include/asm/trap_block.h     |   27 ++--------
 arch/sparc/kernel/asm-offsets.c         |   75 +++++++++++++++++++++++----
 arch/sparc/kernel/traps_64.c            |   84 -------------------------------
 arch/sparc/power/hibernate_asm.S        |    2 +-
 7 files changed, 92 insertions(+), 146 deletions(-)
diff --git a/arch/sparc/include/asm/hibernate.h b/arch/sparc/include/asm/hibernate.h
index 2ec34f8..7d6edfb 100644
--- a/arch/sparc/include/asm/hibernate.h
+++ b/arch/sparc/include/asm/hibernate.h
@@ -7,6 +7,8 @@
 #ifndef ___SPARC_HIBERNATE_H
 #define ___SPARC_HIBERNATE_H
 
+#ifndef __ASSEMBLY__
+
 struct saved_context {
 	unsigned long fp;
 	unsigned long cwp;
@@ -20,4 +22,10 @@ struct saved_context {
 	unsigned long g6;
 };
 
+#else /* (__ASSEMBLY__) */
+
+#include <asm/asm-offsets.h>
+
+#endif /* (__ASSEMBLY__) */
+
 #endif
diff --git a/arch/sparc/include/asm/mmu_64.h b/arch/sparc/include/asm/mmu_64.h
index 76092c4..3e886b5 100644
--- a/arch/sparc/include/asm/mmu_64.h
+++ b/arch/sparc/include/asm/mmu_64.h
@@ -98,13 +98,10 @@ typedef struct {
 	struct hv_tsb_descr	tsb_descr[MM_NUM_TSBS];
 } mm_context_t;
 
-#endif /* !__ASSEMBLY__ */
-
-#define TSB_CONFIG_TSB		0x00
-#define TSB_CONFIG_RSS_LIMIT	0x08
-#define TSB_CONFIG_NENTRIES	0x10
-#define TSB_CONFIG_REG_VAL	0x18
-#define TSB_CONFIG_MAP_VADDR	0x20
-#define TSB_CONFIG_MAP_PTE	0x28
+#else /* __ASSEMBLY__ */
+
+#include <asm/asm-offsets.h>
+
+#endif /* __ASSEMBLY__ */
 
 #endif /* __MMU_H */
diff --git a/arch/sparc/include/asm/thread_info_64.h b/arch/sparc/include/asm/thread_info_64.h
index 269bd92..f9c8b68 100644
--- a/arch/sparc/include/asm/thread_info_64.h
+++ b/arch/sparc/include/asm/thread_info_64.h
@@ -66,35 +66,20 @@ struct thread_info {
 	unsigned long		fpregs[0] __attribute__ ((aligned(64)));
 };
 
-#endif /* !(__ASSEMBLY__) */
+#endif /* (!__ASSEMBLY__) */
+
+#ifndef _ASM_OFFSETS_C /* This is used from !__ASSEMBLY code too (switch_to) */
+
+#include <asm/asm-offsets.h>
 
-/* offsets into the thread_info struct for assembly code access */
-#define TI_TASK		0x00000000
-#define TI_FLAGS	0x00000008
 #define TI_FAULT_CODE	(TI_FLAGS + TI_FLAG_BYTE_FAULT_CODE)
 #define TI_WSTATE	(TI_FLAGS + TI_FLAG_BYTE_WSTATE)
 #define TI_CWP		(TI_FLAGS + TI_FLAG_BYTE_CWP)
 #define TI_FPDEPTH	(TI_FLAGS + TI_FLAG_BYTE_FPDEPTH)
 #define TI_WSAVED	(TI_FLAGS + TI_FLAG_BYTE_WSAVED)
 #define TI_SYS_NOERROR	(TI_FLAGS + TI_FLAG_BYTE_NOERROR)
-#define TI_FPSAVED	0x00000010
-#define TI_KSP		0x00000018
-#define TI_FAULT_ADDR	0x00000020
-#define TI_KREGS	0x00000028
-#define TI_EXEC_DOMAIN	0x00000030
-#define TI_PRE_COUNT	0x00000038
-#define TI_NEW_CHILD	0x0000003c
-#define TI_CURRENT_DS	0x0000003d
-#define TI_CPU		0x0000003e
-#define TI_UTRAPS	0x00000040
-#define TI_REG_WINDOW	0x00000048
-#define TI_RWIN_SPTRS	0x000003c8
-#define TI_GSR		0x00000400
-#define TI_XFSR		0x00000438
-#define TI_RESTART_BLOCK 0x00000470
-#define TI_KUNA_REGS	0x000004a0
-#define TI_KUNA_INSN	0x000004a8
-#define TI_FPREGS	0x000004c0
+
+#endif /* (_ASM_OFFSETS_C) */
 
 /* We embed this in the uppermost byte of thread_info->flags */
 #define FAULT_CODE_WRITE	0x01	/* Write access, implies D-TLB	   */
diff --git a/arch/sparc/include/asm/trap_block.h b/arch/sparc/include/asm/trap_block.h
index 7e26b2d..8877653 100644
--- a/arch/sparc/include/asm/trap_block.h
+++ b/arch/sparc/include/asm/trap_block.h
@@ -81,30 +81,11 @@ extern struct sun4v_2insn_patch_entry __sun4v_2insn_patch,
 	__sun4v_2insn_patch_end;
 
 
-#endif /* !(__ASSEMBLY__) */
-
-#define TRAP_PER_CPU_THREAD		0x00
-#define TRAP_PER_CPU_PGD_PADDR		0x08
-#define TRAP_PER_CPU_CPU_MONDO_PA	0x10
-#define TRAP_PER_CPU_DEV_MONDO_PA	0x18
-#define TRAP_PER_CPU_RESUM_MONDO_PA	0x20
-#define TRAP_PER_CPU_RESUM_KBUF_PA	0x28
-#define TRAP_PER_CPU_NONRESUM_MONDO_PA	0x30
-#define TRAP_PER_CPU_NONRESUM_KBUF_PA	0x38
-#define TRAP_PER_CPU_FAULT_INFO		0x40
-#define TRAP_PER_CPU_CPU_MONDO_BLOCK_PA	0xc0
-#define TRAP_PER_CPU_CPU_LIST_PA	0xc8
-#define TRAP_PER_CPU_TSB_HUGE		0xd0
-#define TRAP_PER_CPU_TSB_HUGE_TEMP	0xd8
-#define TRAP_PER_CPU_IRQ_WORKLIST_PA	0xe0
-#define TRAP_PER_CPU_CPU_MONDO_QMASK	0xe8
-#define TRAP_PER_CPU_DEV_MONDO_QMASK	0xec
-#define TRAP_PER_CPU_RESUM_QMASK	0xf0
-#define TRAP_PER_CPU_NONRESUM_QMASK	0xf4
-#define TRAP_PER_CPU_PER_CPU_BASE	0xf8
+#else /* (__ASSEMBLY__) */
 
 #define TRAP_BLOCK_SZ_SHIFT		8
 
+#include <asm/asm-offsets.h>
 #include <asm/scratchpad.h>
 
 #define __GET_CPUID(REG)				\
@@ -179,7 +160,7 @@ extern struct sun4v_2insn_patch_entry __sun4v_2insn_patch,
 	add	REG2, REG1, REG2;			\
 	ldx	[REG2 + TRAP_PER_CPU_PER_CPU_BASE], DEST;
 
-#else
+#else /* !(CONFIG_SMP) */
 
 #define TRAP_LOAD_TRAP_BLOCK(DEST, TMP)		\
 	sethi	%hi(trap_block), DEST;		\
@@ -204,4 +185,6 @@ extern struct sun4v_2insn_patch_entry __sun4v_2insn_patch,
 
 #endif /* !(CONFIG_SMP) */
 
+#endif /* (__ASSEMBLY__) */
+
 #endif /* _SPARC_TRAP_BLOCK_H */
diff --git a/arch/sparc/kernel/asm-offsets.c b/arch/sparc/kernel/asm-offsets.c
index 961b87f..44eaf48 100644
--- a/arch/sparc/kernel/asm-offsets.c
+++ b/arch/sparc/kernel/asm-offsets.c
@@ -6,27 +6,84 @@
  * generate asm statements containing #defines,
  * compile this file to assembler, and then extract the
  * #defines from the assembly-language output.
- *
- * On sparc, thread_info data is static and TI_XXX offsets are computed by hand.
  */
 
+#define _ASM_OFFSETS_C
+
 #include <linux/sched.h>
-// #include <linux/mm.h>
 #include <linux/kbuild.h>
 
-#include <asm/hibernate.h>
-
 #ifdef CONFIG_SPARC32
 int sparc32_foo(void)
 {
-	DEFINE(AOFF_thread_fork_kpsr,
-			offsetof(struct thread_struct, fork_kpsr));
+	OFFSET(AOFF_thread_fork_kpsr, thread_struct, fork_kpsr);
 	return 0;
 }
 #else
+#include <asm/hibernate.h>
+#include <asm/trap_block.h>
+
 int sparc64_foo(void)
 {
+	/* thread_info */
+	BLANK();
+	OFFSET(TI_TASK, thread_info, task);
+	OFFSET(TI_FLAGS, thread_info, flags);
+	OFFSET(TI_FPSAVED, thread_info, fpsaved);
+	OFFSET(TI_KSP, thread_info, ksp);
+	OFFSET(TI_FAULT_ADDR, thread_info, fault_address);
+	OFFSET(TI_KREGS, thread_info, kregs);
+	OFFSET(TI_EXEC_DOMAIN, thread_info, exec_domain);
+	OFFSET(TI_PRE_COUNT, thread_info, preempt_count);
+	OFFSET(TI_NEW_CHILD, thread_info, new_child);
+	OFFSET(TI_CURRENT_DS, thread_info, current_ds);
+	OFFSET(TI_CPU, thread_info, cpu);
+	OFFSET(TI_UTRAPS, thread_info, utraps);
+	OFFSET(TI_REG_WINDOW, thread_info, reg_window);
+	OFFSET(TI_RWIN_SPTRS, thread_info, rwbuf_stkptrs);
+	OFFSET(TI_GSR, thread_info, gsr);
+	OFFSET(TI_XFSR, thread_info, xfsr);
+	OFFSET(TI_RESTART_BLOCK, thread_info, restart_block);
+	OFFSET(TI_KUNA_REGS, thread_info, kern_una_regs);
+	OFFSET(TI_KUNA_INSN, thread_info, kern_una_insn);
+	OFFSET(TI_FPREGS, thread_info, fpregs);
+	BUILD_BUG_ON(offsetof(struct thread_info, fpregs) & (64 - 1));
+
+	/* trap_per_cpu */
+	BLANK();
+	OFFSET(TRAP_PER_CPU_THREAD, trap_per_cpu, thread);
+	OFFSET(TRAP_PER_CPU_PGD_PADDR, trap_per_cpu, pgd_paddr);
+	OFFSET(TRAP_PER_CPU_CPU_MONDO_PA, trap_per_cpu, cpu_mondo_pa);
+	OFFSET(TRAP_PER_CPU_DEV_MONDO_PA, trap_per_cpu, dev_mondo_pa);
+	OFFSET(TRAP_PER_CPU_RESUM_MONDO_PA, trap_per_cpu, resum_mondo_pa);
+	OFFSET(TRAP_PER_CPU_RESUM_KBUF_PA, trap_per_cpu, resum_kernel_buf_pa);
+	OFFSET(TRAP_PER_CPU_NONRESUM_MONDO_PA, trap_per_cpu, nonresum_mondo_pa);
+	OFFSET(TRAP_PER_CPU_NONRESUM_KBUF_PA, trap_per_cpu,
+							nonresum_kernel_buf_pa);
+	OFFSET(TRAP_PER_CPU_FAULT_INFO, trap_per_cpu, fault_info);
+	OFFSET(TRAP_PER_CPU_CPU_MONDO_BLOCK_PA, trap_per_cpu,
+							cpu_mondo_block_pa);
+	OFFSET(TRAP_PER_CPU_CPU_LIST_PA, trap_per_cpu, cpu_list_pa);
+	OFFSET(TRAP_PER_CPU_TSB_HUGE, trap_per_cpu, tsb_huge);
+	OFFSET(TRAP_PER_CPU_TSB_HUGE_TEMP, trap_per_cpu, tsb_huge_temp);
+	OFFSET(TRAP_PER_CPU_IRQ_WORKLIST_PA, trap_per_cpu, irq_worklist_pa);
+	OFFSET(TRAP_PER_CPU_CPU_MONDO_QMASK, trap_per_cpu, cpu_mondo_qmask);
+	OFFSET(TRAP_PER_CPU_DEV_MONDO_QMASK, trap_per_cpu, dev_mondo_qmask);
+	OFFSET(TRAP_PER_CPU_RESUM_QMASK, trap_per_cpu, resum_qmask);
+	OFFSET(TRAP_PER_CPU_NONRESUM_QMASK, trap_per_cpu, nonresum_qmask);
+	OFFSET(TRAP_PER_CPU_PER_CPU_BASE, trap_per_cpu, __per_cpu_base);
+
+	/*  tsb_config */
+	BLANK();
+	OFFSET(TSB_CONFIG_TSB, tsb_config, tsb);
+	OFFSET(TSB_CONFIG_RSS_LIMIT, tsb_config, tsb_rss_limit);
+	OFFSET(TSB_CONFIG_NENTRIES, tsb_config, tsb_nentries);
+	OFFSET(TSB_CONFIG_REG_VAL, tsb_config, tsb_reg_val);
+	OFFSET(TSB_CONFIG_MAP_VADDR, tsb_config, tsb_map_vaddr);
+	OFFSET(TSB_CONFIG_MAP_PTE, tsb_config, tsb_map_pte);
+
 #ifdef CONFIG_HIBERNATION
+	/*  saved_context */
 	BLANK();
 	OFFSET(SC_REG_FP, saved_context, fp);
 	OFFSET(SC_REG_CWP, saved_context, cwp);
@@ -46,9 +103,9 @@ int sparc64_foo(void)
 int foo(void)
 {
 	BLANK();
-	DEFINE(AOFF_task_thread, offsetof(struct task_struct, thread));
+	OFFSET(AOFF_task_thread, task_struct, thread);
 	BLANK();
-	DEFINE(AOFF_mm_context, offsetof(struct mm_struct, context));
+	OFFSET(AOFF_mm_context, mm_struct, context);
 
 	/* DEFINE(NUM_USER_SEGMENTS, TASK_SIZE>>28); */
 	return 0;
diff --git a/arch/sparc/kernel/traps_64.c b/arch/sparc/kernel/traps_64.c
index 8d38ca9..6f7e192 100644
--- a/arch/sparc/kernel/traps_64.c
+++ b/arch/sparc/kernel/traps_64.c
@@ -2667,90 +2667,6 @@ extern void tsb_config_offsets_are_bolixed_dave(void);
 /* Only invoked on boot processor. */
 void __init trap_init(void)
 {
-	/* Compile time sanity check. */
-	BUILD_BUG_ON(TI_TASK != offsetof(struct thread_info, task) ||
-		     TI_FLAGS != offsetof(struct thread_info, flags) ||
-		     TI_CPU != offsetof(struct thread_info, cpu) ||
-		     TI_FPSAVED != offsetof(struct thread_info, fpsaved) ||
-		     TI_KSP != offsetof(struct thread_info, ksp) ||
-		     TI_FAULT_ADDR != offsetof(struct thread_info,
-					       fault_address) ||
-		     TI_KREGS != offsetof(struct thread_info, kregs) ||
-		     TI_UTRAPS != offsetof(struct thread_info, utraps) ||
-		     TI_EXEC_DOMAIN != offsetof(struct thread_info,
-						exec_domain) ||
-		     TI_REG_WINDOW != offsetof(struct thread_info,
-					       reg_window) ||
-		     TI_RWIN_SPTRS != offsetof(struct thread_info,
-					       rwbuf_stkptrs) ||
-		     TI_GSR != offsetof(struct thread_info, gsr) ||
-		     TI_XFSR != offsetof(struct thread_info, xfsr) ||
-		     TI_PRE_COUNT != offsetof(struct thread_info,
-					      preempt_count) ||
-		     TI_NEW_CHILD != offsetof(struct thread_info, new_child) ||
-		     TI_CURRENT_DS != offsetof(struct thread_info,
-						current_ds) ||
-		     TI_RESTART_BLOCK != offsetof(struct thread_info,
-						  restart_block) ||
-		     TI_KUNA_REGS != offsetof(struct thread_info,
-					      kern_una_regs) ||
-		     TI_KUNA_INSN != offsetof(struct thread_info,
-					      kern_una_insn) ||
-		     TI_FPREGS != offsetof(struct thread_info, fpregs) ||
-		     (TI_FPREGS & (64 - 1)));
-
-	BUILD_BUG_ON(TRAP_PER_CPU_THREAD != offsetof(struct trap_per_cpu,
-						     thread) ||
-		     (TRAP_PER_CPU_PGD_PADDR !-		      offsetof(struct trap_per_cpu, pgd_paddr)) ||
-		     (TRAP_PER_CPU_CPU_MONDO_PA !-		      offsetof(struct trap_per_cpu, cpu_mondo_pa)) ||
-		     (TRAP_PER_CPU_DEV_MONDO_PA !-		      offsetof(struct trap_per_cpu, dev_mondo_pa)) ||
-		     (TRAP_PER_CPU_RESUM_MONDO_PA !-		      offsetof(struct trap_per_cpu, resum_mondo_pa)) ||
-		     (TRAP_PER_CPU_RESUM_KBUF_PA !-		      offsetof(struct trap_per_cpu, resum_kernel_buf_pa)) ||
-		     (TRAP_PER_CPU_NONRESUM_MONDO_PA !-		      offsetof(struct trap_per_cpu, nonresum_mondo_pa)) ||
-		     (TRAP_PER_CPU_NONRESUM_KBUF_PA !-		      offsetof(struct trap_per_cpu, nonresum_kernel_buf_pa)) ||
-		     (TRAP_PER_CPU_FAULT_INFO !-		      offsetof(struct trap_per_cpu, fault_info)) ||
-		     (TRAP_PER_CPU_CPU_MONDO_BLOCK_PA !-		      offsetof(struct trap_per_cpu, cpu_mondo_block_pa)) ||
-		     (TRAP_PER_CPU_CPU_LIST_PA !-		      offsetof(struct trap_per_cpu, cpu_list_pa)) ||
-		     (TRAP_PER_CPU_TSB_HUGE !-		      offsetof(struct trap_per_cpu, tsb_huge)) ||
-		     (TRAP_PER_CPU_TSB_HUGE_TEMP !-		      offsetof(struct trap_per_cpu, tsb_huge_temp)) ||
-		     (TRAP_PER_CPU_IRQ_WORKLIST_PA !-		      offsetof(struct trap_per_cpu, irq_worklist_pa)) ||
-		     (TRAP_PER_CPU_CPU_MONDO_QMASK !-		      offsetof(struct trap_per_cpu, cpu_mondo_qmask)) ||
-		     (TRAP_PER_CPU_DEV_MONDO_QMASK !-		      offsetof(struct trap_per_cpu, dev_mondo_qmask)) ||
-		     (TRAP_PER_CPU_RESUM_QMASK !-		      offsetof(struct trap_per_cpu, resum_qmask)) ||
-		     (TRAP_PER_CPU_NONRESUM_QMASK !-		      offsetof(struct trap_per_cpu, nonresum_qmask)) ||
-		     (TRAP_PER_CPU_PER_CPU_BASE !-		      offsetof(struct trap_per_cpu, __per_cpu_base)));
-
-	BUILD_BUG_ON((TSB_CONFIG_TSB !-		      offsetof(struct tsb_config, tsb)) ||
-		     (TSB_CONFIG_RSS_LIMIT !-		      offsetof(struct tsb_config, tsb_rss_limit)) ||
-		     (TSB_CONFIG_NENTRIES !-		      offsetof(struct tsb_config, tsb_nentries)) ||
-		     (TSB_CONFIG_REG_VAL !-		      offsetof(struct tsb_config, tsb_reg_val)) ||
-		     (TSB_CONFIG_MAP_VADDR !-		      offsetof(struct tsb_config, tsb_map_vaddr)) ||
-		     (TSB_CONFIG_MAP_PTE !-		      offsetof(struct tsb_config, tsb_map_pte)));
-
 	/* Attach to the address space of init_task.  On SMP we
 	 * do this in smp.c:smp_callin for other cpus.
 	 */
diff --git a/arch/sparc/power/hibernate_asm.S b/arch/sparc/power/hibernate_asm.S
index 7994216..8b20337 100644
--- a/arch/sparc/power/hibernate_asm.S
+++ b/arch/sparc/power/hibernate_asm.S
@@ -6,7 +6,7 @@
 
 #include <linux/linkage.h>
 
-#include <asm/asm-offsets.h>
+#include <asm/hibernate.h>
 #include <asm/cpudata.h>
 #include <asm/page.h>
 

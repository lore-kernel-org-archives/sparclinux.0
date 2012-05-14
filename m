From: David Miller <davem@davemloft.net>
Date: Mon, 14 May 2012 03:56:11 +0000
Subject: [PATCH] sparc32: Move cache and TLB flushes over to method ops.
Message-Id: <20120513.235611.828382132525916634.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


This eliminated most of the remaining users of btfixup.

There are some complications because of the special cases we
have for sun4d, leon, and some flavors of viking.

It was found that there are no cases where a flush_page_for_dma
method was not hooked up to something, so the "noflush" iommu
methods were removed.

Add some documentation to the viking_sun4d_smp_ops to describe exactly
the hardware bug which causes us to need special TLB flushing on
sun4d.

Signed-off-by: David S. Miller <davem@davemloft.net>
---

Sam, I don't want to push this out until someone at least smoke
tests a sun4m boot on at least one piece of hardware.  Can you
do a quick test boot for me?

We're really close to killing off btfixup after this one.  I think
for things like the hard_smp_processor_id() thing I'll use a
special ELF section of insn patchups as I do on sparc64.  The
rest can be ops, maybe we need three sets: smp_ipi_ops, clk_ops,
and irq_ops.  Something like that.

Thanks!

 arch/sparc/include/asm/cacheflush_32.h |   73 ++---
 arch/sparc/include/asm/cachetlb_32.h   |   29 ++
 arch/sparc/include/asm/tlbflush_32.h   |   56 +---
 arch/sparc/kernel/leon_kernel.c        |    2 +-
 arch/sparc/kernel/leon_smp.c           |   26 +-
 arch/sparc/kernel/smp_32.c             |  122 --------
 arch/sparc/kernel/sun4d_irq.c          |    3 +-
 arch/sparc/kernel/sun4d_smp.c          |   26 +-
 arch/sparc/kernel/sun4m_irq.c          |    2 +-
 arch/sparc/kernel/sun4m_smp.c          |   22 +-
 arch/sparc/mm/btfixup.c                |   11 +-
 arch/sparc/mm/iommu.c                  |   38 +--
 arch/sparc/mm/srmmu.c                  |  534 ++++++++++++++++++++++----------
 13 files changed, 466 insertions(+), 478 deletions(-)
 create mode 100644 arch/sparc/include/asm/cachetlb_32.h

diff --git a/arch/sparc/include/asm/cacheflush_32.h b/arch/sparc/include/asm/cacheflush_32.h
index 68431b4..bb014c2 100644
--- a/arch/sparc/include/asm/cacheflush_32.h
+++ b/arch/sparc/include/asm/cacheflush_32.h
@@ -1,56 +1,18 @@
 #ifndef _SPARC_CACHEFLUSH_H
 #define _SPARC_CACHEFLUSH_H
 
-#include <linux/mm.h>		/* Common for other includes */
-// #include <linux/kernel.h> from pgalloc.h
-// #include <linux/sched.h>  from pgalloc.h
-
-// #include <asm/page.h>
-#include <asm/btfixup.h>
-
-/*
- * Fine grained cache flushing.
- */
-#ifdef CONFIG_SMP
-
-BTFIXUPDEF_CALL(void, local_flush_cache_all, void)
-BTFIXUPDEF_CALL(void, local_flush_cache_mm, struct mm_struct *)
-BTFIXUPDEF_CALL(void, local_flush_cache_range, struct vm_area_struct *, unsigned long, unsigned long)
-BTFIXUPDEF_CALL(void, local_flush_cache_page, struct vm_area_struct *, unsigned long)
-
-#define local_flush_cache_all() BTFIXUP_CALL(local_flush_cache_all)()
-#define local_flush_cache_mm(mm) BTFIXUP_CALL(local_flush_cache_mm)(mm)
-#define local_flush_cache_range(vma,start,end) BTFIXUP_CALL(local_flush_cache_range)(vma,start,end)
-#define local_flush_cache_page(vma,addr) BTFIXUP_CALL(local_flush_cache_page)(vma,addr)
-
-BTFIXUPDEF_CALL(void, local_flush_page_to_ram, unsigned long)
-BTFIXUPDEF_CALL(void, local_flush_sig_insns, struct mm_struct *, unsigned long)
-
-#define local_flush_page_to_ram(addr) BTFIXUP_CALL(local_flush_page_to_ram)(addr)
-#define local_flush_sig_insns(mm,insn_addr) BTFIXUP_CALL(local_flush_sig_insns)(mm,insn_addr)
-
-extern void smp_flush_cache_all(void);
-extern void smp_flush_cache_mm(struct mm_struct *mm);
-extern void smp_flush_cache_range(struct vm_area_struct *vma,
-				  unsigned long start,
-				  unsigned long end);
-extern void smp_flush_cache_page(struct vm_area_struct *vma, unsigned long page);
-
-extern void smp_flush_page_to_ram(unsigned long page);
-extern void smp_flush_sig_insns(struct mm_struct *mm, unsigned long insn_addr);
-
-#endif /* CONFIG_SMP */
-
-BTFIXUPDEF_CALL(void, flush_cache_all, void)
-BTFIXUPDEF_CALL(void, flush_cache_mm, struct mm_struct *)
-BTFIXUPDEF_CALL(void, flush_cache_range, struct vm_area_struct *, unsigned long, unsigned long)
-BTFIXUPDEF_CALL(void, flush_cache_page, struct vm_area_struct *, unsigned long)
-
-#define flush_cache_all() BTFIXUP_CALL(flush_cache_all)()
-#define flush_cache_mm(mm) BTFIXUP_CALL(flush_cache_mm)(mm)
-#define flush_cache_dup_mm(mm) BTFIXUP_CALL(flush_cache_mm)(mm)
-#define flush_cache_range(vma,start,end) BTFIXUP_CALL(flush_cache_range)(vma,start,end)
-#define flush_cache_page(vma,addr,pfn) BTFIXUP_CALL(flush_cache_page)(vma,addr)
+#include <asm/cachetlb_32.h>
+
+#define flush_cache_all() \
+	sparc32_cachetlb_ops->cache_all()
+#define flush_cache_mm(mm) \
+	sparc32_cachetlb_ops->cache_mm(mm)
+#define flush_cache_dup_mm(mm) \
+	sparc32_cachetlb_ops->cache_mm(mm)
+#define flush_cache_range(vma,start,end) \
+	sparc32_cachetlb_ops->cache_range(vma, start, end)
+#define flush_cache_page(vma,addr,pfn) \
+	sparc32_cachetlb_ops->cache_page(vma, addr)
 #define flush_icache_range(start, end)		do { } while (0)
 #define flush_icache_page(vma, pg)		do { } while (0)
 
@@ -67,11 +29,12 @@ BTFIXUPDEF_CALL(void, flush_cache_page, struct vm_area_struct *, unsigned long)
 		memcpy(dst, src, len);				\
 	} while (0)
 
-BTFIXUPDEF_CALL(void, __flush_page_to_ram, unsigned long)
-BTFIXUPDEF_CALL(void, flush_sig_insns, struct mm_struct *, unsigned long)
-
-#define __flush_page_to_ram(addr) BTFIXUP_CALL(__flush_page_to_ram)(addr)
-#define flush_sig_insns(mm,insn_addr) BTFIXUP_CALL(flush_sig_insns)(mm,insn_addr)
+#define __flush_page_to_ram(addr) \
+	sparc32_cachetlb_ops->page_to_ram(addr)
+#define flush_sig_insns(mm,insn_addr) \
+	sparc32_cachetlb_ops->sig_insns(mm, insn_addr)
+#define flush_page_for_dma(addr) \
+	sparc32_cachetlb_ops->page_for_dma(addr)
 
 extern void sparc_flush_page_to_ram(struct page *page);
 
diff --git a/arch/sparc/include/asm/cachetlb_32.h b/arch/sparc/include/asm/cachetlb_32.h
new file mode 100644
index 0000000..efb1988
--- /dev/null
+++ b/arch/sparc/include/asm/cachetlb_32.h
@@ -0,0 +1,29 @@
+#ifndef _SPARC_CACHETLB_H
+#define _SPARC_CACHETLB_H
+
+struct mm_struct;
+struct vm_area_struct;
+
+struct sparc32_cachetlb_ops {
+	void (*cache_all)(void);
+	void (*cache_mm)(struct mm_struct *);
+	void (*cache_range)(struct vm_area_struct *, unsigned long,
+			    unsigned long);
+	void (*cache_page)(struct vm_area_struct *, unsigned long);
+
+	void (*tlb_all)(void);
+	void (*tlb_mm)(struct mm_struct *);
+	void (*tlb_range)(struct vm_area_struct *, unsigned long,
+			  unsigned long);
+	void (*tlb_page)(struct vm_area_struct *, unsigned long);
+
+	void (*page_to_ram)(unsigned long);
+	void (*sig_insns)(struct mm_struct *, unsigned long);
+	void (*page_for_dma)(unsigned long);
+};
+extern const struct sparc32_cachetlb_ops *sparc32_cachetlb_ops;
+#ifdef CONFIG_SMP
+extern const struct sparc32_cachetlb_ops *local_ops;
+#endif
+
+#endif /* SPARC_CACHETLB_H */
diff --git a/arch/sparc/include/asm/tlbflush_32.h b/arch/sparc/include/asm/tlbflush_32.h
index fe0a71a..a5c4142 100644
--- a/arch/sparc/include/asm/tlbflush_32.h
+++ b/arch/sparc/include/asm/tlbflush_32.h
@@ -1,52 +1,16 @@
 #ifndef _SPARC_TLBFLUSH_H
 #define _SPARC_TLBFLUSH_H
 
-#include <linux/mm.h>
-// #include <asm/processor.h>
-
-/*
- * TLB flushing:
- *
- *  - flush_tlb() flushes the current mm struct TLBs	XXX Exists?
- *  - flush_tlb_all() flushes all processes TLBs
- *  - flush_tlb_mm(mm) flushes the specified mm context TLB's
- *  - flush_tlb_page(vma, vmaddr) flushes one page
- *  - flush_tlb_range(vma, start, end) flushes a range of pages
- *  - flush_tlb_kernel_range(start, end) flushes a range of kernel pages
- */
-
-#ifdef CONFIG_SMP
-
-BTFIXUPDEF_CALL(void, local_flush_tlb_all, void)
-BTFIXUPDEF_CALL(void, local_flush_tlb_mm, struct mm_struct *)
-BTFIXUPDEF_CALL(void, local_flush_tlb_range, struct vm_area_struct *, unsigned long, unsigned long)
-BTFIXUPDEF_CALL(void, local_flush_tlb_page, struct vm_area_struct *, unsigned long)
-
-#define local_flush_tlb_all() BTFIXUP_CALL(local_flush_tlb_all)()
-#define local_flush_tlb_mm(mm) BTFIXUP_CALL(local_flush_tlb_mm)(mm)
-#define local_flush_tlb_range(vma,start,end) BTFIXUP_CALL(local_flush_tlb_range)(vma,start,end)
-#define local_flush_tlb_page(vma,addr) BTFIXUP_CALL(local_flush_tlb_page)(vma,addr)
-
-extern void smp_flush_tlb_all(void);
-extern void smp_flush_tlb_mm(struct mm_struct *mm);
-extern void smp_flush_tlb_range(struct vm_area_struct *vma,
-				  unsigned long start,
-				  unsigned long end);
-extern void smp_flush_tlb_page(struct vm_area_struct *mm, unsigned long page);
-
-#endif /* CONFIG_SMP */
-
-BTFIXUPDEF_CALL(void, flush_tlb_all, void)
-BTFIXUPDEF_CALL(void, flush_tlb_mm, struct mm_struct *)
-BTFIXUPDEF_CALL(void, flush_tlb_range, struct vm_area_struct *, unsigned long, unsigned long)
-BTFIXUPDEF_CALL(void, flush_tlb_page, struct vm_area_struct *, unsigned long)
-
-#define flush_tlb_all() BTFIXUP_CALL(flush_tlb_all)()
-#define flush_tlb_mm(mm) BTFIXUP_CALL(flush_tlb_mm)(mm)
-#define flush_tlb_range(vma,start,end) BTFIXUP_CALL(flush_tlb_range)(vma,start,end)
-#define flush_tlb_page(vma,addr) BTFIXUP_CALL(flush_tlb_page)(vma,addr)
-
-// #define flush_tlb() flush_tlb_mm(current->active_mm)	/* XXX Sure? */
+#include <asm/cachetlb_32.h>
+
+#define flush_tlb_all() \
+	sparc32_cachetlb_ops->tlb_all()
+#define flush_tlb_mm(mm) \
+	sparc32_cachetlb_ops->tlb_mm(mm)
+#define flush_tlb_range(vma, start, end) \
+	sparc32_cachetlb_ops->tlb_range(vma, start, end)
+#define flush_tlb_page(vma, addr) \
+	sparc32_cachetlb_ops->tlb_page(vma, addr)
 
 /*
  * This is a kludge, until I know better. --zaitcev XXX
diff --git a/arch/sparc/kernel/leon_kernel.c b/arch/sparc/kernel/leon_kernel.c
index e57435f..aeb411c 100644
--- a/arch/sparc/kernel/leon_kernel.c
+++ b/arch/sparc/kernel/leon_kernel.c
@@ -427,7 +427,7 @@ void __init leon_init_timers(void)
 		 */
 		local_irq_save(flags);
 		patchme_maybe_smp_msg[0] = 0x01000000; /* NOP out the branch */
-		local_flush_cache_all();
+		local_ops->cache_all();
 		local_irq_restore(flags);
 	}
 #endif
diff --git a/arch/sparc/kernel/leon_smp.c b/arch/sparc/kernel/leon_smp.c
index 356dfc4..f3e3630 100644
--- a/arch/sparc/kernel/leon_smp.c
+++ b/arch/sparc/kernel/leon_smp.c
@@ -75,8 +75,8 @@ void __cpuinit leon_callin(void)
 {
 	int cpuid = hard_smpleon_processor_id();
 
-	local_flush_cache_all();
-	local_flush_tlb_all();
+	local_ops->cache_all();
+	local_ops->tlb_all();
 	leon_configure_cache_smp();
 
 	notify_cpu_starting(cpuid);
@@ -87,8 +87,8 @@ void __cpuinit leon_callin(void)
 	calibrate_delay();
 	smp_store_cpu_info(cpuid);
 
-	local_flush_cache_all();
-	local_flush_tlb_all();
+	local_ops->cache_all();
+	local_ops->tlb_all();
 
 	/*
 	 * Unblock the master CPU _only_ when the scheduler state
@@ -99,8 +99,8 @@ void __cpuinit leon_callin(void)
 	 */
 	do_swap(&cpu_callin_map[cpuid], 1);
 
-	local_flush_cache_all();
-	local_flush_tlb_all();
+	local_ops->cache_all();
+	local_ops->tlb_all();
 
 	/* Fix idle thread fields. */
 	__asm__ __volatile__("ld [%0], %%g6\n\t" : : "r"(&current_set[cpuid])
@@ -143,8 +143,8 @@ void __init leon_configure_cache_smp(void)
 		}
 	}
 
-	local_flush_cache_all();
-	local_flush_tlb_all();
+	local_ops->cache_all();
+	local_ops->tlb_all();
 }
 
 void leon_smp_setbroadcast(unsigned int mask)
@@ -199,7 +199,7 @@ void __init leon_boot_cpus(void)
 	leon_smp_setbroadcast(1 << LEON3_IRQ_TICKER);
 
 	leon_configure_cache_smp();
-	local_flush_cache_all();
+	local_ops->cache_all();
 
 }
 
@@ -226,7 +226,7 @@ int __cpuinit leon_boot_one_cpu(int i)
 	/* whirrr, whirrr, whirrrrrrrrr... */
 	printk(KERN_INFO "Starting CPU %d : (irqmp: 0x%x)\n", (unsigned int)i,
 	       (unsigned int)&leon3_irqctrl_regs->mpstatus);
-	local_flush_cache_all();
+	local_ops->cache_all();
 
 	/* Make sure all IRQs are of from the start for this new CPU */
 	LEON_BYPASS_STORE_PA(&leon3_irqctrl_regs->mask[i], 0);
@@ -251,7 +251,7 @@ int __cpuinit leon_boot_one_cpu(int i)
 		leon_enable_irq_cpu(leon_ipi_irq, i);
 	}
 
-	local_flush_cache_all();
+	local_ops->cache_all();
 	return 0;
 }
 
@@ -271,7 +271,7 @@ void __init leon_smp_done(void)
 		}
 	}
 	*prev = first;
-	local_flush_cache_all();
+	local_ops->cache_all();
 
 	/* Free unneeded trap tables */
 	if (!cpu_present(1)) {
@@ -337,7 +337,7 @@ static void __init leon_ipi_init(void)
 	local_irq_save(flags);
 	trap_table = &sparc_ttable[SP_TRAP_IRQ1 + (leon_ipi_irq - 1)];
 	trap_table->inst_three += smpleon_ipi - real_irq_entry;
-	local_flush_cache_all();
+	local_ops->cache_all();
 	local_irq_restore(flags);
 
 	for_each_possible_cpu(cpu) {
diff --git a/arch/sparc/kernel/smp_32.c b/arch/sparc/kernel/smp_32.c
index 7c11439..8cd5c79 100644
--- a/arch/sparc/kernel/smp_32.c
+++ b/arch/sparc/kernel/smp_32.c
@@ -171,128 +171,6 @@ void smp_call_function_interrupt(void)
 	irq_exit();
 }
 
-void smp_flush_cache_all(void)
-{
-	xc0((smpfunc_t) BTFIXUP_CALL(local_flush_cache_all));
-	local_flush_cache_all();
-}
-
-void smp_flush_tlb_all(void)
-{
-	xc0((smpfunc_t) BTFIXUP_CALL(local_flush_tlb_all));
-	local_flush_tlb_all();
-}
-
-void smp_flush_cache_mm(struct mm_struct *mm)
-{
-	if(mm->context != NO_CONTEXT) {
-		cpumask_t cpu_mask;
-		cpumask_copy(&cpu_mask, mm_cpumask(mm));
-		cpumask_clear_cpu(smp_processor_id(), &cpu_mask);
-		if (!cpumask_empty(&cpu_mask))
-			xc1((smpfunc_t) BTFIXUP_CALL(local_flush_cache_mm), (unsigned long) mm);
-		local_flush_cache_mm(mm);
-	}
-}
-
-void smp_flush_tlb_mm(struct mm_struct *mm)
-{
-	if(mm->context != NO_CONTEXT) {
-		cpumask_t cpu_mask;
-		cpumask_copy(&cpu_mask, mm_cpumask(mm));
-		cpumask_clear_cpu(smp_processor_id(), &cpu_mask);
-		if (!cpumask_empty(&cpu_mask)) {
-			xc1((smpfunc_t) BTFIXUP_CALL(local_flush_tlb_mm), (unsigned long) mm);
-			if(atomic_read(&mm->mm_users) = 1 && current->active_mm = mm)
-				cpumask_copy(mm_cpumask(mm),
-					     cpumask_of(smp_processor_id()));
-		}
-		local_flush_tlb_mm(mm);
-	}
-}
-
-void smp_flush_cache_range(struct vm_area_struct *vma, unsigned long start,
-			   unsigned long end)
-{
-	struct mm_struct *mm = vma->vm_mm;
-
-	if (mm->context != NO_CONTEXT) {
-		cpumask_t cpu_mask;
-		cpumask_copy(&cpu_mask, mm_cpumask(mm));
-		cpumask_clear_cpu(smp_processor_id(), &cpu_mask);
-		if (!cpumask_empty(&cpu_mask))
-			xc3((smpfunc_t) BTFIXUP_CALL(local_flush_cache_range), (unsigned long) vma, start, end);
-		local_flush_cache_range(vma, start, end);
-	}
-}
-
-void smp_flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
-			 unsigned long end)
-{
-	struct mm_struct *mm = vma->vm_mm;
-
-	if (mm->context != NO_CONTEXT) {
-		cpumask_t cpu_mask;
-		cpumask_copy(&cpu_mask, mm_cpumask(mm));
-		cpumask_clear_cpu(smp_processor_id(), &cpu_mask);
-		if (!cpumask_empty(&cpu_mask))
-			xc3((smpfunc_t) BTFIXUP_CALL(local_flush_tlb_range), (unsigned long) vma, start, end);
-		local_flush_tlb_range(vma, start, end);
-	}
-}
-
-void smp_flush_cache_page(struct vm_area_struct *vma, unsigned long page)
-{
-	struct mm_struct *mm = vma->vm_mm;
-
-	if(mm->context != NO_CONTEXT) {
-		cpumask_t cpu_mask;
-		cpumask_copy(&cpu_mask, mm_cpumask(mm));
-		cpumask_clear_cpu(smp_processor_id(), &cpu_mask);
-		if (!cpumask_empty(&cpu_mask))
-			xc2((smpfunc_t) BTFIXUP_CALL(local_flush_cache_page), (unsigned long) vma, page);
-		local_flush_cache_page(vma, page);
-	}
-}
-
-void smp_flush_tlb_page(struct vm_area_struct *vma, unsigned long page)
-{
-	struct mm_struct *mm = vma->vm_mm;
-
-	if(mm->context != NO_CONTEXT) {
-		cpumask_t cpu_mask;
-		cpumask_copy(&cpu_mask, mm_cpumask(mm));
-		cpumask_clear_cpu(smp_processor_id(), &cpu_mask);
-		if (!cpumask_empty(&cpu_mask))
-			xc2((smpfunc_t) BTFIXUP_CALL(local_flush_tlb_page), (unsigned long) vma, page);
-		local_flush_tlb_page(vma, page);
-	}
-}
-
-void smp_flush_page_to_ram(unsigned long page)
-{
-	/* Current theory is that those who call this are the one's
-	 * who have just dirtied their cache with the pages contents
-	 * in kernel space, therefore we only run this on local cpu.
-	 *
-	 * XXX This experiment failed, research further... -DaveM
-	 */
-#if 1
-	xc1((smpfunc_t) BTFIXUP_CALL(local_flush_page_to_ram), page);
-#endif
-	local_flush_page_to_ram(page);
-}
-
-void smp_flush_sig_insns(struct mm_struct *mm, unsigned long insn_addr)
-{
-	cpumask_t cpu_mask;
-	cpumask_copy(&cpu_mask, mm_cpumask(mm));
-	cpumask_clear_cpu(smp_processor_id(), &cpu_mask);
-	if (!cpumask_empty(&cpu_mask))
-		xc2((smpfunc_t) BTFIXUP_CALL(local_flush_sig_insns), (unsigned long) mm, insn_addr);
-	local_flush_sig_insns(mm, insn_addr);
-}
-
 int setup_profiling_timer(unsigned int multiplier)
 {
 	return -EINVAL;
diff --git a/arch/sparc/kernel/sun4d_irq.c b/arch/sparc/kernel/sun4d_irq.c
index 15593ee..b2fdb3d 100644
--- a/arch/sparc/kernel/sun4d_irq.c
+++ b/arch/sparc/kernel/sun4d_irq.c
@@ -15,6 +15,7 @@
 #include <asm/sbi.h>
 #include <asm/cacheflush.h>
 #include <asm/setup.h>
+#include <asm/oplib.h>
 
 #include "kernel.h"
 #include "irq.h"
@@ -411,7 +412,7 @@ static void __init sun4d_fixup_trap_table(void)
 	trap_table->inst_two = lvl14_save[1];
 	trap_table->inst_three = lvl14_save[2];
 	trap_table->inst_four = lvl14_save[3];
-	local_flush_cache_all();
+	local_ops->cache_all();
 	local_irq_restore(flags);
 #endif
 }
diff --git a/arch/sparc/kernel/sun4d_smp.c b/arch/sparc/kernel/sun4d_smp.c
index 576fe74..f17fd28 100644
--- a/arch/sparc/kernel/sun4d_smp.c
+++ b/arch/sparc/kernel/sun4d_smp.c
@@ -10,12 +10,14 @@
 #include <linux/interrupt.h>
 #include <linux/profile.h>
 #include <linux/delay.h>
+#include <linux/sched.h>
 #include <linux/cpu.h>
 
 #include <asm/cacheflush.h>
 #include <asm/switch_to.h>
 #include <asm/tlbflush.h>
 #include <asm/timer.h>
+#include <asm/oplib.h>
 #include <asm/sbi.h>
 #include <asm/mmu.h>
 
@@ -60,8 +62,8 @@ void __cpuinit smp4d_callin(void)
 	/* Enable level15 interrupt, disable level14 interrupt for now */
 	cc_set_imsk((cc_get_imsk() & ~0x8000) | 0x4000);
 
-	local_flush_cache_all();
-	local_flush_tlb_all();
+	local_ops->cache_all();
+	local_ops->tlb_all();
 
 	notify_cpu_starting(cpuid);
 	/*
@@ -75,13 +77,13 @@ void __cpuinit smp4d_callin(void)
 
 	calibrate_delay();
 	smp_store_cpu_info(cpuid);
-	local_flush_cache_all();
-	local_flush_tlb_all();
+	local_ops->cache_all();
+	local_ops->tlb_all();
 
 	/* Allow master to continue. */
 	sun4d_swap((unsigned long *)&cpu_callin_map[cpuid], 1);
-	local_flush_cache_all();
-	local_flush_tlb_all();
+	local_ops->cache_all();
+	local_ops->tlb_all();
 
 	while ((unsigned long)current_set[cpuid] < PAGE_OFFSET)
 		barrier();
@@ -101,8 +103,8 @@ void __cpuinit smp4d_callin(void)
 	atomic_inc(&init_mm.mm_count);
 	current->active_mm = &init_mm;
 
-	local_flush_cache_all();
-	local_flush_tlb_all();
+	local_ops->cache_all();
+	local_ops->tlb_all();
 
 	local_irq_enable();	/* We don't allow PIL 14 yet */
 
@@ -124,7 +126,7 @@ void __init smp4d_boot_cpus(void)
 	smp4d_ipi_init();
 	if (boot_cpu_id)
 		current_set[0] = NULL;
-	local_flush_cache_all();
+	local_ops->cache_all();
 }
 
 int __cpuinit smp4d_boot_one_cpu(int i)
@@ -150,7 +152,7 @@ int __cpuinit smp4d_boot_one_cpu(int i)
 
 	/* whirrr, whirrr, whirrrrrrrrr... */
 	printk(KERN_INFO "Starting CPU %d at %p\n", i, entry);
-	local_flush_cache_all();
+	local_ops->cache_all();
 	prom_startcpu(cpu_node,
 		      &smp_penguin_ctable, 0, (char *)entry);
 
@@ -168,7 +170,7 @@ int __cpuinit smp4d_boot_one_cpu(int i)
 		return -ENODEV;
 
 	}
-	local_flush_cache_all();
+	local_ops->cache_all();
 	return 0;
 }
 
@@ -185,7 +187,7 @@ void __init smp4d_smp_done(void)
 		prev = &cpu_data(i).next;
 	}
 	*prev = first;
-	local_flush_cache_all();
+	local_ops->cache_all();
 
 	/* Ok, they are spinning and ready to go. */
 	smp_processors_ready = 1;
diff --git a/arch/sparc/kernel/sun4m_irq.c b/arch/sparc/kernel/sun4m_irq.c
index 93f4603..32d3a5c 100644
--- a/arch/sparc/kernel/sun4m_irq.c
+++ b/arch/sparc/kernel/sun4m_irq.c
@@ -431,7 +431,7 @@ static void __init sun4m_init_timers(void)
 		trap_table->inst_two = lvl14_save[1];
 		trap_table->inst_three = lvl14_save[2];
 		trap_table->inst_four = lvl14_save[3];
-		local_flush_cache_all();
+		local_ops->cache_all();
 		local_irq_restore(flags);
 	}
 #endif
diff --git a/arch/sparc/kernel/sun4m_smp.c b/arch/sparc/kernel/sun4m_smp.c
index 29f8ace..afcf674 100644
--- a/arch/sparc/kernel/sun4m_smp.c
+++ b/arch/sparc/kernel/sun4m_smp.c
@@ -8,12 +8,14 @@
 #include <linux/interrupt.h>
 #include <linux/profile.h>
 #include <linux/delay.h>
+#include <linux/sched.h>
 #include <linux/cpu.h>
 
 #include <asm/cacheflush.h>
 #include <asm/switch_to.h>
 #include <asm/tlbflush.h>
 #include <asm/timer.h>
+#include <asm/oplib.h>
 
 #include "irq.h"
 #include "kernel.h"
@@ -38,8 +40,8 @@ void __cpuinit smp4m_callin(void)
 {
 	int cpuid = hard_smp_processor_id();
 
-	local_flush_cache_all();
-	local_flush_tlb_all();
+	local_ops->cache_all();
+	local_ops->tlb_all();
 
 	notify_cpu_starting(cpuid);
 
@@ -48,8 +50,8 @@ void __cpuinit smp4m_callin(void)
 	calibrate_delay();
 	smp_store_cpu_info(cpuid);
 
-	local_flush_cache_all();
-	local_flush_tlb_all();
+	local_ops->cache_all();
+	local_ops->tlb_all();
 
 	/*
 	 * Unblock the master CPU _only_ when the scheduler state
@@ -61,8 +63,8 @@ void __cpuinit smp4m_callin(void)
 	swap_ulong(&cpu_callin_map[cpuid], 1);
 
 	/* XXX: What's up with all the flushes? */
-	local_flush_cache_all();
-	local_flush_tlb_all();
+	local_ops->cache_all();
+	local_ops->tlb_all();
 
 	/* Fix idle thread fields. */
 	__asm__ __volatile__("ld [%0], %%g6\n\t"
@@ -88,7 +90,7 @@ void __init smp4m_boot_cpus(void)
 {
 	smp4m_ipi_init();
 	sun4m_unmask_profile_irq();
-	local_flush_cache_all();
+	local_ops->cache_all();
 }
 
 int __cpuinit smp4m_boot_one_cpu(int i)
@@ -117,7 +119,7 @@ int __cpuinit smp4m_boot_one_cpu(int i)
 
 	/* whirrr, whirrr, whirrrrrrrrr... */
 	printk(KERN_INFO "Starting CPU %d at %p\n", i, entry);
-	local_flush_cache_all();
+	local_ops->cache_all();
 	prom_startcpu(cpu_node, &smp_penguin_ctable, 0, (char *)entry);
 
 	/* wheee... it's going... */
@@ -132,7 +134,7 @@ int __cpuinit smp4m_boot_one_cpu(int i)
 		return -ENODEV;
 	}
 
-	local_flush_cache_all();
+	local_ops->cache_all();
 	return 0;
 }
 
@@ -149,7 +151,7 @@ void __init smp4m_smp_done(void)
 		prev = &cpu_data(i).next;
 	}
 	*prev = first;
-	local_flush_cache_all();
+	local_ops->cache_all();
 
 	/* Ok, they are spinning and ready to go. */
 }
diff --git a/arch/sparc/mm/btfixup.c b/arch/sparc/mm/btfixup.c
index 1b7aa56..dcbb7ff 100644
--- a/arch/sparc/mm/btfixup.c
+++ b/arch/sparc/mm/btfixup.c
@@ -38,7 +38,6 @@ static char insn_s[] __initdata = "Fixup s %p doesn't refer to an OR at %p[%08x]
 static char insn_h[] __initdata = "Fixup h %p doesn't refer to a SETHI at %p[%08x]\n";
 static char insn_a[] __initdata = "Fixup a %p doesn't refer to a SETHI nor OR at %p[%08x]\n";
 static char insn_i[] __initdata = "Fixup i %p doesn't refer to a valid instruction at %p[%08x]\n";
-static char fca_und[] __initdata = "flush_cache_all undefined in btfixup()\n";
 static char wrong_setaddr[] __initdata = "Garbled CALL/INT patch at %p[%08x,%08x,%08x]=%08x\n";
 
 #ifdef BTFIXUP_OPTIMIZE_OTHER
@@ -75,7 +74,6 @@ void __init btfixup(void)
 	unsigned insn;
 	unsigned *addr;
 	int fmangled = 0;
-	void (*flush_cacheall)(void);
 	
 	if (!visited) {
 		visited++;
@@ -311,13 +309,8 @@ void __init btfixup(void)
 			p = q + count;
 	}
 #ifdef CONFIG_SMP
-	flush_cacheall = (void (*)(void))BTFIXUPVAL_CALL(local_flush_cache_all);
+	local_ops->cache_all();
 #else
-	flush_cacheall = (void (*)(void))BTFIXUPVAL_CALL(flush_cache_all);
+	sparc32_cachetlb_ops->cache_all();
 #endif
-	if (!flush_cacheall) {
-		prom_printf(fca_und);
-		prom_halt();
-	}
-	(*flush_cacheall)();
 }
diff --git a/arch/sparc/mm/iommu.c b/arch/sparc/mm/iommu.c
index c64f81e..720bea2 100644
--- a/arch/sparc/mm/iommu.c
+++ b/arch/sparc/mm/iommu.c
@@ -39,8 +39,6 @@
 
 /* srmmu.c */
 extern int viking_mxcc_present;
-BTFIXUPDEF_CALL(void, flush_page_for_dma, unsigned long)
-#define flush_page_for_dma(page) BTFIXUP_CALL(flush_page_for_dma)(page)
 extern int flush_page_for_dma_global;
 static int viking_flush;
 /* viking.S */
@@ -216,11 +214,6 @@ static u32 iommu_get_scsi_one(struct device *dev, char *vaddr, unsigned int len)
 	return busa + off;
 }
 
-static __u32 iommu_get_scsi_one_noflush(struct device *dev, char *vaddr, unsigned long len)
-{
-	return iommu_get_scsi_one(dev, vaddr, len);
-}
-
 static __u32 iommu_get_scsi_one_gflush(struct device *dev, char *vaddr, unsigned long len)
 {
 	flush_page_for_dma(0);
@@ -238,19 +231,6 @@ static __u32 iommu_get_scsi_one_pflush(struct device *dev, char *vaddr, unsigned
 	return iommu_get_scsi_one(dev, vaddr, len);
 }
 
-static void iommu_get_scsi_sgl_noflush(struct device *dev, struct scatterlist *sg, int sz)
-{
-	int n;
-
-	while (sz != 0) {
-		--sz;
-		n = (sg->length + sg->offset + PAGE_SIZE-1) >> PAGE_SHIFT;
-		sg->dma_address = iommu_get_one(dev, sg_page(sg), n) + sg->offset;
-		sg->dma_length = sg->length;
-		sg = sg_next(sg);
-	}
-}
-
 static void iommu_get_scsi_sgl_gflush(struct device *dev, struct scatterlist *sg, int sz)
 {
 	int n;
@@ -426,17 +406,6 @@ static void iommu_unmap_dma_area(struct device *dev, unsigned long busa, int len
 }
 #endif
 
-static const struct sparc32_dma_ops iommu_dma_noflush_ops = {
-	.get_scsi_one		= iommu_get_scsi_one_noflush,
-	.get_scsi_sgl		= iommu_get_scsi_sgl_noflush,
-	.release_scsi_one	= iommu_release_scsi_one,
-	.release_scsi_sgl	= iommu_release_scsi_sgl,
-#ifdef CONFIG_SBUS
-	.map_dma_area		= iommu_map_dma_area,
-	.unmap_dma_area		= iommu_unmap_dma_area,
-#endif
-};
-
 static const struct sparc32_dma_ops iommu_dma_gflush_ops = {
 	.get_scsi_one		= iommu_get_scsi_one_gflush,
 	.get_scsi_sgl		= iommu_get_scsi_sgl_gflush,
@@ -461,12 +430,7 @@ static const struct sparc32_dma_ops iommu_dma_pflush_ops = {
 
 void __init ld_mmu_iommu(void)
 {
-	viking_flush = (BTFIXUPVAL_CALL(flush_page_for_dma) = (unsigned long)viking_flush_page);
-
-	if (!BTFIXUPVAL_CALL(flush_page_for_dma)) {
-		/* IO coherent chip */
-		sparc32_dma_ops = &iommu_dma_noflush_ops;
-	} else if (flush_page_for_dma_global) {
+	if (flush_page_for_dma_global) {
 		/* flush_page_for_dma flushes everything, no matter of what page is it */
 		sparc32_dma_ops = &iommu_dma_gflush_ops;
 	} else {
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index dc398e5..cba05fa 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -65,24 +65,20 @@ extern unsigned long last_valid_pfn;
 
 static pgd_t *srmmu_swapper_pg_dir;
 
+const struct sparc32_cachetlb_ops *sparc32_cachetlb_ops;
+
 #ifdef CONFIG_SMP
+const struct sparc32_cachetlb_ops *local_ops;
+
 #define FLUSH_BEGIN(mm)
 #define FLUSH_END
 #else
-#define FLUSH_BEGIN(mm) if((mm)->context != NO_CONTEXT) {
+#define FLUSH_BEGIN(mm) if ((mm)->context != NO_CONTEXT) {
 #define FLUSH_END	}
 #endif
 
-BTFIXUPDEF_CALL(void, flush_page_for_dma, unsigned long)
-#define flush_page_for_dma(page) BTFIXUP_CALL(flush_page_for_dma)(page)
-
 int flush_page_for_dma_global = 1;
 
-#ifdef CONFIG_SMP
-BTFIXUPDEF_CALL(void, local_flush_page_for_dma, unsigned long)
-#define local_flush_page_for_dma(page) BTFIXUP_CALL(local_flush_page_for_dma)(page)
-#endif
-
 char *srmmu_name;
 
 ctxd_t *srmmu_ctx_table_phys;
@@ -1126,7 +1122,7 @@ void __init srmmu_paging_init(void)
 	srmmu_set_ctable_ptr((unsigned long)srmmu_ctx_table_phys);
 #ifdef CONFIG_SMP
 	/* Stop from hanging here... */
-	local_flush_tlb_all();
+	local_ops->tlb_all();
 #else
 	flush_tlb_all();
 #endif
@@ -1284,6 +1280,20 @@ static void __cpuinit poke_hypersparc(void)
 	clear = srmmu_get_fstatus();
 }
 
+static const struct sparc32_cachetlb_ops hypersparc_ops = {
+	.cache_all	= hypersparc_flush_cache_all,
+	.cache_mm	= hypersparc_flush_cache_mm,
+	.cache_page	= hypersparc_flush_cache_page,
+	.cache_range	= hypersparc_flush_cache_range,
+	.tlb_all	= hypersparc_flush_tlb_all,
+	.tlb_mm		= hypersparc_flush_tlb_mm,
+	.tlb_page	= hypersparc_flush_tlb_page,
+	.tlb_range	= hypersparc_flush_tlb_range,
+	.page_to_ram	= hypersparc_flush_page_to_ram,
+	.sig_insns	= hypersparc_flush_sig_insns,
+	.page_for_dma	= hypersparc_flush_page_for_dma,
+};
+
 static void __init init_hypersparc(void)
 {
 	srmmu_name = "ROSS HyperSparc";
@@ -1292,21 +1302,7 @@ static void __init init_hypersparc(void)
 	init_vac_layout();
 
 	is_hypersparc = 1;
-
-	BTFIXUPSET_CALL(flush_cache_all, hypersparc_flush_cache_all, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(flush_cache_mm, hypersparc_flush_cache_mm, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(flush_cache_range, hypersparc_flush_cache_range, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(flush_cache_page, hypersparc_flush_cache_page, BTFIXUPCALL_NORM);
-
-	BTFIXUPSET_CALL(flush_tlb_all, hypersparc_flush_tlb_all, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(flush_tlb_mm, hypersparc_flush_tlb_mm, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(flush_tlb_range, hypersparc_flush_tlb_range, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(flush_tlb_page, hypersparc_flush_tlb_page, BTFIXUPCALL_NORM);
-
-	BTFIXUPSET_CALL(__flush_page_to_ram, hypersparc_flush_page_to_ram, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(flush_sig_insns, hypersparc_flush_sig_insns, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(flush_page_for_dma, hypersparc_flush_page_for_dma, BTFIXUPCALL_NOP);
-
+	sparc32_cachetlb_ops = &hypersparc_ops;
 
 	poke_srmmu = poke_hypersparc;
 
@@ -1352,25 +1348,24 @@ static void __cpuinit poke_cypress(void)
 	srmmu_set_mmureg(mreg);
 }
 
+static const struct sparc32_cachetlb_ops cypress_ops = {
+	.cache_all	= cypress_flush_cache_all,
+	.cache_mm	= cypress_flush_cache_mm,
+	.cache_page	= cypress_flush_cache_page,
+	.cache_range	= cypress_flush_cache_range,
+	.tlb_all	= cypress_flush_tlb_all,
+	.tlb_mm		= cypress_flush_tlb_mm,
+	.tlb_page	= cypress_flush_tlb_page,
+	.tlb_range	= cypress_flush_tlb_range,
+	.page_to_ram	= cypress_flush_page_to_ram,
+	.sig_insns	= cypress_flush_sig_insns,
+	.page_for_dma	= cypress_flush_page_for_dma,
+};
+
 static void __init init_cypress_common(void)
 {
 	init_vac_layout();
-
-	BTFIXUPSET_CALL(flush_cache_all, cypress_flush_cache_all, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(flush_cache_mm, cypress_flush_cache_mm, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(flush_cache_range, cypress_flush_cache_range, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(flush_cache_page, cypress_flush_cache_page, BTFIXUPCALL_NORM);
-
-	BTFIXUPSET_CALL(flush_tlb_all, cypress_flush_tlb_all, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(flush_tlb_mm, cypress_flush_tlb_mm, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(flush_tlb_page, cypress_flush_tlb_page, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(flush_tlb_range, cypress_flush_tlb_range, BTFIXUPCALL_NORM);
-
-
-	BTFIXUPSET_CALL(__flush_page_to_ram, cypress_flush_page_to_ram, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(flush_sig_insns, cypress_flush_sig_insns, BTFIXUPCALL_NOP);
-	BTFIXUPSET_CALL(flush_page_for_dma, cypress_flush_page_for_dma, BTFIXUPCALL_NOP);
-
+	sparc32_cachetlb_ops = &cypress_ops;
 	poke_srmmu = poke_cypress;
 }
 
@@ -1421,6 +1416,20 @@ static void __cpuinit poke_swift(void)
 	srmmu_set_mmureg(mreg);
 }
 
+static const struct sparc32_cachetlb_ops swift_ops = {
+	.cache_all	= swift_flush_cache_all,
+	.cache_mm	= swift_flush_cache_mm,
+	.cache_page	= swift_flush_cache_page,
+	.cache_range	= swift_flush_cache_range,
+	.tlb_all	= swift_flush_tlb_all,
+	.tlb_mm		= swift_flush_tlb_mm,
+	.tlb_page	= swift_flush_tlb_page,
+	.tlb_range	= swift_flush_tlb_range,
+	.page_to_ram	= swift_flush_page_to_ram,
+	.sig_insns	= swift_flush_sig_insns,
+	.page_for_dma	= swift_flush_page_for_dma,
+};
+
 #define SWIFT_MASKID_ADDR  0x10003018
 static void __init init_swift(void)
 {
@@ -1471,21 +1480,7 @@ static void __init init_swift(void)
 		break;
 	}
 
-	BTFIXUPSET_CALL(flush_cache_all, swift_flush_cache_all, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(flush_cache_mm, swift_flush_cache_mm, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(flush_cache_page, swift_flush_cache_page, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(flush_cache_range, swift_flush_cache_range, BTFIXUPCALL_NORM);
-
-
-	BTFIXUPSET_CALL(flush_tlb_all, swift_flush_tlb_all, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(flush_tlb_mm, swift_flush_tlb_mm, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(flush_tlb_page, swift_flush_tlb_page, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(flush_tlb_range, swift_flush_tlb_range, BTFIXUPCALL_NORM);
-
-	BTFIXUPSET_CALL(__flush_page_to_ram, swift_flush_page_to_ram, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(flush_sig_insns, swift_flush_sig_insns, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(flush_page_for_dma, swift_flush_page_for_dma, BTFIXUPCALL_NORM);
-
+	sparc32_cachetlb_ops = &swift_ops;
 	flush_page_for_dma_global = 0;
 
 	/*
@@ -1618,26 +1613,25 @@ static void __cpuinit poke_turbosparc(void)
 	srmmu_set_mmureg(mreg);
 }
 
+static const struct sparc32_cachetlb_ops turbosparc_ops = {
+	.cache_all	= turbosparc_flush_cache_all,
+	.cache_mm	= turbosparc_flush_cache_mm,
+	.cache_page	= turbosparc_flush_cache_page,
+	.cache_range	= turbosparc_flush_cache_range,
+	.tlb_all	= turbosparc_flush_tlb_all,
+	.tlb_mm		= turbosparc_flush_tlb_mm,
+	.tlb_page	= turbosparc_flush_tlb_page,
+	.tlb_range	= turbosparc_flush_tlb_range,
+	.page_to_ram	= turbosparc_flush_page_to_ram,
+	.sig_insns	= turbosparc_flush_sig_insns,
+	.page_for_dma	= turbosparc_flush_page_for_dma,
+};
+
 static void __init init_turbosparc(void)
 {
 	srmmu_name = "Fujitsu TurboSparc";
 	srmmu_modtype = TurboSparc;
-
-	BTFIXUPSET_CALL(flush_cache_all, turbosparc_flush_cache_all, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(flush_cache_mm, turbosparc_flush_cache_mm, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(flush_cache_page, turbosparc_flush_cache_page, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(flush_cache_range, turbosparc_flush_cache_range, BTFIXUPCALL_NORM);
-
-	BTFIXUPSET_CALL(flush_tlb_all, turbosparc_flush_tlb_all, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(flush_tlb_mm, turbosparc_flush_tlb_mm, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(flush_tlb_page, turbosparc_flush_tlb_page, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(flush_tlb_range, turbosparc_flush_tlb_range, BTFIXUPCALL_NORM);
-
-	BTFIXUPSET_CALL(__flush_page_to_ram, turbosparc_flush_page_to_ram, BTFIXUPCALL_NORM);
-
-	BTFIXUPSET_CALL(flush_sig_insns, turbosparc_flush_sig_insns, BTFIXUPCALL_NOP);
-	BTFIXUPSET_CALL(flush_page_for_dma, turbosparc_flush_page_for_dma, BTFIXUPCALL_NORM);
-
+	sparc32_cachetlb_ops = &turbosparc_ops;
 	poke_srmmu = poke_turbosparc;
 }
 
@@ -1652,6 +1646,20 @@ static void __cpuinit poke_tsunami(void)
 	srmmu_set_mmureg(mreg);
 }
 
+static const struct sparc32_cachetlb_ops tsunami_ops = {
+	.cache_all	= tsunami_flush_cache_all,
+	.cache_mm	= tsunami_flush_cache_mm,
+	.cache_page	= tsunami_flush_cache_page,
+	.cache_range	= tsunami_flush_cache_range,
+	.tlb_all	= tsunami_flush_tlb_all,
+	.tlb_mm		= tsunami_flush_tlb_mm,
+	.tlb_page	= tsunami_flush_tlb_page,
+	.tlb_range	= tsunami_flush_tlb_range,
+	.page_to_ram	= tsunami_flush_page_to_ram,
+	.sig_insns	= tsunami_flush_sig_insns,
+	.page_for_dma	= tsunami_flush_page_for_dma,
+};
+
 static void __init init_tsunami(void)
 {
 	/*
@@ -1662,22 +1670,7 @@ static void __init init_tsunami(void)
 
 	srmmu_name = "TI Tsunami";
 	srmmu_modtype = Tsunami;
-
-	BTFIXUPSET_CALL(flush_cache_all, tsunami_flush_cache_all, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(flush_cache_mm, tsunami_flush_cache_mm, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(flush_cache_page, tsunami_flush_cache_page, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(flush_cache_range, tsunami_flush_cache_range, BTFIXUPCALL_NORM);
-
-
-	BTFIXUPSET_CALL(flush_tlb_all, tsunami_flush_tlb_all, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(flush_tlb_mm, tsunami_flush_tlb_mm, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(flush_tlb_page, tsunami_flush_tlb_page, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(flush_tlb_range, tsunami_flush_tlb_range, BTFIXUPCALL_NORM);
-
-	BTFIXUPSET_CALL(__flush_page_to_ram, tsunami_flush_page_to_ram, BTFIXUPCALL_NOP);
-	BTFIXUPSET_CALL(flush_sig_insns, tsunami_flush_sig_insns, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(flush_page_for_dma, tsunami_flush_page_for_dma, BTFIXUPCALL_NORM);
-
+	sparc32_cachetlb_ops = &tsunami_ops;
 	poke_srmmu = poke_tsunami;
 
 	tsunami_setup_blockops();
@@ -1688,7 +1681,7 @@ static void __cpuinit poke_viking(void)
 	unsigned long mreg = srmmu_get_mmureg();
 	static int smp_catch;
 
-	if(viking_mxcc_present) {
+	if (viking_mxcc_present) {
 		unsigned long mxcc_control = mxcc_get_creg();
 
 		mxcc_control |= (MXCC_CTL_ECE | MXCC_CTL_PRE | MXCC_CTL_MCE);
@@ -1725,6 +1718,52 @@ static void __cpuinit poke_viking(void)
 	srmmu_set_mmureg(mreg);
 }
 
+static struct sparc32_cachetlb_ops viking_ops = {
+	.cache_all	= viking_flush_cache_all,
+	.cache_mm	= viking_flush_cache_mm,
+	.cache_page	= viking_flush_cache_page,
+	.cache_range	= viking_flush_cache_range,
+	.tlb_all	= viking_flush_tlb_all,
+	.tlb_mm		= viking_flush_tlb_mm,
+	.tlb_page	= viking_flush_tlb_page,
+	.tlb_range	= viking_flush_tlb_range,
+	.page_to_ram	= viking_flush_page_to_ram,
+	.sig_insns	= viking_flush_sig_insns,
+	.page_for_dma	= viking_flush_page_for_dma,
+};
+
+#ifdef CONFIG_SMP
+/* On sun4d the cpu broadcasts local TLB flushes, so we can just
+ * perform the local TLB flush and all the other cpus will see it.
+ * But, unfortunately, there is a bug in the sun4d XBUS backplane
+ * that requires that we add some synchronization to these flushes.
+ *
+ * The bug is that the fifo which keeps track of all the pending TLB
+ * broadcasts in the system is an entry or two too small, so if we
+ * have too many going at once we'll overflow that fifo and lose a TLB
+ * flush resulting in corruption.
+ *
+ * Our workaround is to take a global spinlock around the TLB flushes,
+ * which guarentees we won't ever have too many pending.  It's a big
+ * hammer, but a semaphore like system to make sure we only have N TLB
+ * flushes going at once will require SMP locking anyways so there's
+ * no real value in trying any harder than this.
+ */
+static struct sparc32_cachetlb_ops viking_sun4d_smp_ops = {
+	.cache_all	= viking_flush_cache_all,
+	.cache_mm	= viking_flush_cache_mm,
+	.cache_page	= viking_flush_cache_page,
+	.cache_range	= viking_flush_cache_range,
+	.tlb_all	= sun4dsmp_flush_tlb_all,
+	.tlb_mm		= sun4dsmp_flush_tlb_mm,
+	.tlb_page	= sun4dsmp_flush_tlb_page,
+	.tlb_range	= sun4dsmp_flush_tlb_range,
+	.page_to_ram	= viking_flush_page_to_ram,
+	.sig_insns	= viking_flush_sig_insns,
+	.page_for_dma	= viking_flush_page_for_dma,
+};
+#endif
+
 static void __init init_viking(void)
 {
 	unsigned long mreg = srmmu_get_mmureg();
@@ -1742,76 +1781,101 @@ static void __init init_viking(void)
 		 * This is only necessary because of the new way in
 		 * which we use the IOMMU.
 		 */
-		BTFIXUPSET_CALL(flush_page_for_dma, viking_flush_page, BTFIXUPCALL_NORM);
-
+		viking_ops.page_for_dma = viking_flush_page;
+#ifdef CONFIG_SMP
+		viking_sun4d_smp_ops.page_for_dma = viking_flush_page;
+#endif
 		flush_page_for_dma_global = 0;
 	} else {
 		srmmu_name = "TI Viking/MXCC";
 		viking_mxcc_present = 1;
-
 		srmmu_cache_pagetables = 1;
-
-		/* MXCC vikings lack the DMA snooping bug. */
-		BTFIXUPSET_CALL(flush_page_for_dma, viking_flush_page_for_dma, BTFIXUPCALL_NOP);
 	}
 
-	BTFIXUPSET_CALL(flush_cache_all, viking_flush_cache_all, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(flush_cache_mm, viking_flush_cache_mm, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(flush_cache_page, viking_flush_cache_page, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(flush_cache_range, viking_flush_cache_range, BTFIXUPCALL_NORM);
-
+	sparc32_cachetlb_ops = (const struct sparc32_cachetlb_ops *)
+		&viking_ops;
 #ifdef CONFIG_SMP
-	if (sparc_cpu_model = sun4d) {
-		BTFIXUPSET_CALL(flush_tlb_all, sun4dsmp_flush_tlb_all, BTFIXUPCALL_NORM);
-		BTFIXUPSET_CALL(flush_tlb_mm, sun4dsmp_flush_tlb_mm, BTFIXUPCALL_NORM);
-		BTFIXUPSET_CALL(flush_tlb_page, sun4dsmp_flush_tlb_page, BTFIXUPCALL_NORM);
-		BTFIXUPSET_CALL(flush_tlb_range, sun4dsmp_flush_tlb_range, BTFIXUPCALL_NORM);
-	} else
+	if (sparc_cpu_model = sun4d)
+		sparc32_cachetlb_ops = (const struct sparc32_cachetlb_ops *)
+			&viking_sun4d_smp_ops;
 #endif
-	{
-		BTFIXUPSET_CALL(flush_tlb_all, viking_flush_tlb_all, BTFIXUPCALL_NORM);
-		BTFIXUPSET_CALL(flush_tlb_mm, viking_flush_tlb_mm, BTFIXUPCALL_NORM);
-		BTFIXUPSET_CALL(flush_tlb_page, viking_flush_tlb_page, BTFIXUPCALL_NORM);
-		BTFIXUPSET_CALL(flush_tlb_range, viking_flush_tlb_range, BTFIXUPCALL_NORM);
-	}
-
-	BTFIXUPSET_CALL(__flush_page_to_ram, viking_flush_page_to_ram, BTFIXUPCALL_NOP);
-	BTFIXUPSET_CALL(flush_sig_insns, viking_flush_sig_insns, BTFIXUPCALL_NOP);
 
 	poke_srmmu = poke_viking;
 }
 
 #ifdef CONFIG_SPARC_LEON
+static void leon_flush_cache_mm(struct mm_struct *mm)
+{
+	leon_flush_cache_all();
+}
 
-void __init poke_leonsparc(void)
+static void leon_flush_cache_page(struct vm_area_struct *vma, unsigned long page)
 {
+	leon_flush_pcache_all(vma, page);
 }
 
-void __init init_leon(void)
+static void leon_flush_cache_range(struct vm_area_struct *vma,
+				   unsigned long start,
+				   unsigned long end)
 {
+	leon_flush_cache_all();
+}
 
-	srmmu_name = "LEON";
+static void leon_flush_tlb_mm(struct mm_struct *mm)
+{
+	leon_flush_tlb_all();
+}
+
+static void leon_flush_tlb_page(struct vm_area_struct *vma,
+				unsigned long page)
+{
+	leon_flush_tlb_all();
+}
 
-	BTFIXUPSET_CALL(flush_cache_all, leon_flush_cache_all,
-			BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(flush_cache_mm, leon_flush_cache_all,
-			BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(flush_cache_page, leon_flush_pcache_all,
-			BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(flush_cache_range, leon_flush_cache_all,
-			BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(flush_page_for_dma, leon_flush_dcache_all,
-			BTFIXUPCALL_NORM);
-
-	BTFIXUPSET_CALL(flush_tlb_all, leon_flush_tlb_all, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(flush_tlb_mm, leon_flush_tlb_all, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(flush_tlb_page, leon_flush_tlb_all, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(flush_tlb_range, leon_flush_tlb_all, BTFIXUPCALL_NORM);
-
-	BTFIXUPSET_CALL(__flush_page_to_ram, leon_flush_cache_all,
-			BTFIXUPCALL_NOP);
-	BTFIXUPSET_CALL(flush_sig_insns, leon_flush_cache_all, BTFIXUPCALL_NOP);
+static void leon_flush_tlb_range(struct vm_area_struct *vma,
+				 unsigned long start,
+				 unsigned long end)
+{
+	leon_flush_tlb_all();
+}
+
+static void leon_flush_page_to_ram(unsigned long page)
+{
+	leon_flush_cache_all();
+}
+
+static void leon_flush_sig_insns(struct mm_struct *mm, unsigned long page)
+{
+	leon_flush_cache_all();
+}
+
+static void leon_flush_page_for_dma(unsigned long page)
+{
+	leon_flush_dcache_all();
+}
+
+void __init poke_leonsparc(void)
+{
+}
+
+static const struct sparc32_cachetlb_ops leon_ops = {
+	.cache_all	= leon_flush_cache_all,
+	.cache_mm	= leon_flush_cache_mm,
+	.cache_page	= leon_flush_cache_page,
+	.cache_range	= leon_flush_cache_range,
+	.tlb_all	= leon_flush_tlb_all,
+	.tlb_mm		= leon_flush_tlb_mm,
+	.tlb_page	= leon_flush_tlb_page,
+	.tlb_range	= leon_flush_tlb_range,
+	.page_to_ram	= leon_flush_page_to_ram,
+	.sig_insns	= leon_flush_sig_insns,
+	.page_for_dma	= leon_flush_page_for_dma,
+};
 
+void __init init_leon(void)
+{
+	srmmu_name = "LEON";
+	sparc32_cachetlb_ops = &leon_ops;
 	poke_srmmu = poke_leonsparc;
 
 	srmmu_cache_pagetables = 0;
@@ -1925,10 +1989,152 @@ static void __init get_srmmu_type(void)
 /* Local cross-calls. */
 static void smp_flush_page_for_dma(unsigned long page)
 {
-	xc1((smpfunc_t) BTFIXUP_CALL(local_flush_page_for_dma), page);
-	local_flush_page_for_dma(page);
+	xc1((smpfunc_t) local_ops->page_for_dma, page);
+	local_ops->page_for_dma(page);
+}
+
+static void smp_flush_cache_all(void)
+{
+	xc0((smpfunc_t) local_ops->cache_all);
+	local_ops->cache_all();
+}
+
+static void smp_flush_tlb_all(void)
+{
+	xc0((smpfunc_t) local_ops->tlb_all);
+	local_ops->tlb_all();
+}
+
+static void smp_flush_cache_mm(struct mm_struct *mm)
+{
+	if (mm->context != NO_CONTEXT) {
+		cpumask_t cpu_mask;
+		cpumask_copy(&cpu_mask, mm_cpumask(mm));
+		cpumask_clear_cpu(smp_processor_id(), &cpu_mask);
+		if (!cpumask_empty(&cpu_mask))
+			xc1((smpfunc_t) local_ops->cache_mm, (unsigned long) mm);
+		local_ops->cache_mm(mm);
+	}
+}
+
+static void smp_flush_tlb_mm(struct mm_struct *mm)
+{
+	if (mm->context != NO_CONTEXT) {
+		cpumask_t cpu_mask;
+		cpumask_copy(&cpu_mask, mm_cpumask(mm));
+		cpumask_clear_cpu(smp_processor_id(), &cpu_mask);
+		if (!cpumask_empty(&cpu_mask)) {
+			xc1((smpfunc_t) local_ops->tlb_mm, (unsigned long) mm);
+			if (atomic_read(&mm->mm_users) = 1 && current->active_mm = mm)
+				cpumask_copy(mm_cpumask(mm),
+					     cpumask_of(smp_processor_id()));
+		}
+		local_ops->tlb_mm(mm);
+	}
+}
+
+static void smp_flush_cache_range(struct vm_area_struct *vma,
+				  unsigned long start,
+				  unsigned long end)
+{
+	struct mm_struct *mm = vma->vm_mm;
+
+	if (mm->context != NO_CONTEXT) {
+		cpumask_t cpu_mask;
+		cpumask_copy(&cpu_mask, mm_cpumask(mm));
+		cpumask_clear_cpu(smp_processor_id(), &cpu_mask);
+		if (!cpumask_empty(&cpu_mask))
+			xc3((smpfunc_t) local_ops->cache_range,
+			    (unsigned long) vma, start, end);
+		local_ops->cache_range(vma, start, end);
+	}
+}
+
+static void smp_flush_tlb_range(struct vm_area_struct *vma,
+				unsigned long start,
+				unsigned long end)
+{
+	struct mm_struct *mm = vma->vm_mm;
+
+	if (mm->context != NO_CONTEXT) {
+		cpumask_t cpu_mask;
+		cpumask_copy(&cpu_mask, mm_cpumask(mm));
+		cpumask_clear_cpu(smp_processor_id(), &cpu_mask);
+		if (!cpumask_empty(&cpu_mask))
+			xc3((smpfunc_t) local_ops->tlb_range,
+			    (unsigned long) vma, start, end);
+		local_ops->tlb_range(vma, start, end);
+	}
 }
 
+static void smp_flush_cache_page(struct vm_area_struct *vma, unsigned long page)
+{
+	struct mm_struct *mm = vma->vm_mm;
+
+	if (mm->context != NO_CONTEXT) {
+		cpumask_t cpu_mask;
+		cpumask_copy(&cpu_mask, mm_cpumask(mm));
+		cpumask_clear_cpu(smp_processor_id(), &cpu_mask);
+		if (!cpumask_empty(&cpu_mask))
+			xc2((smpfunc_t) local_ops->cache_page,
+			    (unsigned long) vma, page);
+		local_ops->cache_page(vma, page);
+	}
+}
+
+static void smp_flush_tlb_page(struct vm_area_struct *vma, unsigned long page)
+{
+	struct mm_struct *mm = vma->vm_mm;
+
+	if (mm->context != NO_CONTEXT) {
+		cpumask_t cpu_mask;
+		cpumask_copy(&cpu_mask, mm_cpumask(mm));
+		cpumask_clear_cpu(smp_processor_id(), &cpu_mask);
+		if (!cpumask_empty(&cpu_mask))
+			xc2((smpfunc_t) local_ops->tlb_page,
+			    (unsigned long) vma, page);
+		local_ops->tlb_page(vma, page);
+	}
+}
+
+static void smp_flush_page_to_ram(unsigned long page)
+{
+	/* Current theory is that those who call this are the one's
+	 * who have just dirtied their cache with the pages contents
+	 * in kernel space, therefore we only run this on local cpu.
+	 *
+	 * XXX This experiment failed, research further... -DaveM
+	 */
+#if 1
+	xc1((smpfunc_t) local_ops->page_to_ram, page);
+#endif
+	local_ops->page_to_ram(page);
+}
+
+static void smp_flush_sig_insns(struct mm_struct *mm, unsigned long insn_addr)
+{
+	cpumask_t cpu_mask;
+	cpumask_copy(&cpu_mask, mm_cpumask(mm));
+	cpumask_clear_cpu(smp_processor_id(), &cpu_mask);
+	if (!cpumask_empty(&cpu_mask))
+		xc2((smpfunc_t) local_ops->sig_insns,
+		    (unsigned long) mm, insn_addr);
+	local_ops->sig_insns(mm, insn_addr);
+}
+
+static struct sparc32_cachetlb_ops smp_cachetlb_ops = {
+	.cache_all	= smp_flush_cache_all,
+	.cache_mm	= smp_flush_cache_mm,
+	.cache_page	= smp_flush_cache_page,
+	.cache_range	= smp_flush_cache_range,
+	.tlb_all	= smp_flush_tlb_all,
+	.tlb_mm		= smp_flush_tlb_mm,
+	.tlb_page	= smp_flush_tlb_page,
+	.tlb_range	= smp_flush_tlb_range,
+	.page_to_ram	= smp_flush_page_to_ram,
+	.sig_insns	= smp_flush_sig_insns,
+	.page_for_dma	= smp_flush_page_for_dma,
+};
 #endif
 
 /* Load up routines and constants for sun4m and sun4d mmu */
@@ -1942,44 +2148,30 @@ void __init load_mmu(void)
 
 #ifdef CONFIG_SMP
 	/* El switcheroo... */
+	local_ops = sparc32_cachetlb_ops;
 
-	BTFIXUPCOPY_CALL(local_flush_cache_all, flush_cache_all);
-	BTFIXUPCOPY_CALL(local_flush_cache_mm, flush_cache_mm);
-	BTFIXUPCOPY_CALL(local_flush_cache_range, flush_cache_range);
-	BTFIXUPCOPY_CALL(local_flush_cache_page, flush_cache_page);
-	BTFIXUPCOPY_CALL(local_flush_tlb_all, flush_tlb_all);
-	BTFIXUPCOPY_CALL(local_flush_tlb_mm, flush_tlb_mm);
-	BTFIXUPCOPY_CALL(local_flush_tlb_range, flush_tlb_range);
-	BTFIXUPCOPY_CALL(local_flush_tlb_page, flush_tlb_page);
-	BTFIXUPCOPY_CALL(local_flush_page_to_ram, __flush_page_to_ram);
-	BTFIXUPCOPY_CALL(local_flush_sig_insns, flush_sig_insns);
-	BTFIXUPCOPY_CALL(local_flush_page_for_dma, flush_page_for_dma);
-
-	BTFIXUPSET_CALL(flush_cache_all, smp_flush_cache_all, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(flush_cache_mm, smp_flush_cache_mm, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(flush_cache_range, smp_flush_cache_range, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(flush_cache_page, smp_flush_cache_page, BTFIXUPCALL_NORM);
-	if (sparc_cpu_model != sun4d &&
-	    sparc_cpu_model != sparc_leon) {
-		BTFIXUPSET_CALL(flush_tlb_all, smp_flush_tlb_all, BTFIXUPCALL_NORM);
-		BTFIXUPSET_CALL(flush_tlb_mm, smp_flush_tlb_mm, BTFIXUPCALL_NORM);
-		BTFIXUPSET_CALL(flush_tlb_range, smp_flush_tlb_range, BTFIXUPCALL_NORM);
-		BTFIXUPSET_CALL(flush_tlb_page, smp_flush_tlb_page, BTFIXUPCALL_NORM);
+	if (sparc_cpu_model = sun4d || sparc_cpu_model = sparc_leon) {
+		smp_cachetlb_ops.tlb_all = local_ops->tlb_all;
+		smp_cachetlb_ops.tlb_mm = local_ops->tlb_mm;
+		smp_cachetlb_ops.tlb_range = local_ops->tlb_range;
+		smp_cachetlb_ops.tlb_page = local_ops->tlb_page;
 	}
-	BTFIXUPSET_CALL(__flush_page_to_ram, smp_flush_page_to_ram, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(flush_sig_insns, smp_flush_sig_insns, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(flush_page_for_dma, smp_flush_page_for_dma, BTFIXUPCALL_NORM);
 
 	if (poke_srmmu = poke_viking) {
 		/* Avoid unnecessary cross calls. */
-		BTFIXUPCOPY_CALL(flush_cache_all, local_flush_cache_all);
-		BTFIXUPCOPY_CALL(flush_cache_mm, local_flush_cache_mm);
-		BTFIXUPCOPY_CALL(flush_cache_range, local_flush_cache_range);
-		BTFIXUPCOPY_CALL(flush_cache_page, local_flush_cache_page);
-		BTFIXUPCOPY_CALL(__flush_page_to_ram, local_flush_page_to_ram);
-		BTFIXUPCOPY_CALL(flush_sig_insns, local_flush_sig_insns);
-		BTFIXUPCOPY_CALL(flush_page_for_dma, local_flush_page_for_dma);
+		smp_cachetlb_ops.cache_all = local_ops->cache_all;
+		smp_cachetlb_ops.cache_mm = local_ops->cache_mm;
+		smp_cachetlb_ops.cache_range = local_ops->cache_range;
+		smp_cachetlb_ops.cache_page = local_ops->cache_page;
+
+		smp_cachetlb_ops.page_to_ram = local_ops->page_to_ram;
+		smp_cachetlb_ops.sig_insns = local_ops->sig_insns;
+		smp_cachetlb_ops.page_for_dma = local_ops->page_for_dma;
 	}
+
+	/* It really is const after this point. */
+	sparc32_cachetlb_ops = (const struct sparc32_cachetlb_ops *)
+		&smp_cachetlb_ops;
 #endif
 
 	if (sparc_cpu_model = sun4d)
-- 
1.7.10


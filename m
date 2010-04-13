From: David Miller <davem@davemloft.net>
Date: Tue, 13 Apr 2010 06:43:00 +0000
Subject: [PATCH 7/7] sparc64: Add function graph tracer support.
Message-Id: <20100412.234300.212396783.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/Kconfig              |    2 +
 arch/sparc/kernel/Makefile      |    1 +
 arch/sparc/kernel/ftrace.c      |   58 ++++++++++++++++++++++++++++++++++++
 arch/sparc/kernel/irq_64.c      |    3 +-
 arch/sparc/kernel/kgdb_64.c     |    3 +-
 arch/sparc/kernel/pcr.c         |    3 +-
 arch/sparc/kernel/smp_64.c      |   11 ++++---
 arch/sparc/kernel/time_64.c     |    3 +-
 arch/sparc/kernel/vmlinux.lds.S |    1 +
 arch/sparc/lib/mcount.S         |   62 +++++++++++++++++++++++++++++++++++----
 10 files changed, 132 insertions(+), 15 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 035304c..9908d47 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -37,6 +37,8 @@ config SPARC64
 	def_bool 64BIT
 	select ARCH_SUPPORTS_MSI
 	select HAVE_FUNCTION_TRACER
+	select HAVE_FUNCTION_GRAPH_TRACER
+	select HAVE_FUNCTION_GRAPH_FP_TEST
 	select HAVE_FUNCTION_TRACE_MCOUNT_TEST
 	select HAVE_KRETPROBES
 	select HAVE_KPROBES
diff --git a/arch/sparc/kernel/Makefile b/arch/sparc/kernel/Makefile
index 1b35ed6..0c2dc1f 100644
--- a/arch/sparc/kernel/Makefile
+++ b/arch/sparc/kernel/Makefile
@@ -93,6 +93,7 @@ obj-$(CONFIG_KGDB)        += kgdb_$(BITS).o
 
 
 obj-$(CONFIG_DYNAMIC_FTRACE) += ftrace.o
+obj-$(CONFIG_FUNCTION_GRAPH_TRACER) += ftrace.o
 
 obj-$(CONFIG_EARLYFB) += btext.o
 obj-$(CONFIG_STACKTRACE)     += stacktrace.o
diff --git a/arch/sparc/kernel/ftrace.c b/arch/sparc/kernel/ftrace.c
index 2ea6e4f..03ab022 100644
--- a/arch/sparc/kernel/ftrace.c
+++ b/arch/sparc/kernel/ftrace.c
@@ -91,3 +91,61 @@ int __init ftrace_dyn_arch_init(void *data)
 	return 0;
 }
 #endif
+
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+
+#ifdef CONFIG_DYNAMIC_FTRACE
+extern void ftrace_graph_call(void);
+
+int ftrace_enable_ftrace_graph_caller(void)
+{
+	unsigned long ip = (unsigned long)(&ftrace_graph_call);
+	u32 old, new;
+
+	old = *(u32 *) &ftrace_graph_call;
+	new = ftrace_call_replace(ip, (unsigned long) &ftrace_graph_caller);
+	return ftrace_modify_code(ip, old, new);
+}
+
+int ftrace_disable_ftrace_graph_caller(void)
+{
+	unsigned long ip = (unsigned long)(&ftrace_graph_call);
+	u32 old, new;
+
+	old = *(u32 *) &ftrace_graph_call;
+	new = ftrace_call_replace(ip, (unsigned long) &ftrace_stub);
+
+	return ftrace_modify_code(ip, old, new);
+}
+
+#endif /* !CONFIG_DYNAMIC_FTRACE */
+
+/*
+ * Hook the return address and push it in the stack of return addrs
+ * in current thread info.
+ */
+unsigned long prepare_ftrace_return(unsigned long parent,
+				    unsigned long self_addr,
+				    unsigned long frame_pointer)
+{
+	unsigned long return_hooker = (unsigned long) &return_to_handler;
+	struct ftrace_graph_ent trace;
+
+	if (unlikely(atomic_read(&current->tracing_graph_pause)))
+		return parent + 8UL;
+
+	if (ftrace_push_return_trace(parent, self_addr, &trace.depth,
+				     frame_pointer) = -EBUSY)
+		return parent + 8UL;
+
+	trace.func = self_addr;
+
+	/* Only trace if the calling function expects to */
+	if (!ftrace_graph_entry(&trace)) {
+		current->curr_ret_stack--;
+		return parent + 8UL;
+	}
+
+	return return_hooker;
+}
+#endif /* CONFIG_FUNCTION_GRAPH_TRACER */
diff --git a/arch/sparc/kernel/irq_64.c b/arch/sparc/kernel/irq_64.c
index e1cbdb9..af5c76c 100644
--- a/arch/sparc/kernel/irq_64.c
+++ b/arch/sparc/kernel/irq_64.c
@@ -20,6 +20,7 @@
 #include <linux/delay.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
+#include <linux/ftrace.h>
 #include <linux/irq.h>
 
 #include <asm/ptrace.h>
@@ -721,7 +722,7 @@ static __attribute__((always_inline)) void restore_hardirq_stack(void *orig_sp)
 	__asm__ __volatile__("mov %0, %%sp" : : "r" (orig_sp));
 }
 
-void handler_irq(int irq, struct pt_regs *regs)
+void __irq_entry handler_irq(int irq, struct pt_regs *regs)
 {
 	unsigned long pstate, bucket_pa;
 	struct pt_regs *old_regs;
diff --git a/arch/sparc/kernel/kgdb_64.c b/arch/sparc/kernel/kgdb_64.c
index f5a0fd4..0a2bd0f 100644
--- a/arch/sparc/kernel/kgdb_64.c
+++ b/arch/sparc/kernel/kgdb_64.c
@@ -5,6 +5,7 @@
 
 #include <linux/kgdb.h>
 #include <linux/kdebug.h>
+#include <linux/ftrace.h>
 
 #include <asm/kdebug.h>
 #include <asm/ptrace.h>
@@ -108,7 +109,7 @@ void gdb_regs_to_pt_regs(unsigned long *gdb_regs, struct pt_regs *regs)
 }
 
 #ifdef CONFIG_SMP
-void smp_kgdb_capture_client(int irq, struct pt_regs *regs)
+void __irq_entry smp_kgdb_capture_client(int irq, struct pt_regs *regs)
 {
 	unsigned long flags;
 
diff --git a/arch/sparc/kernel/pcr.c b/arch/sparc/kernel/pcr.c
index 2d94e7a..c4a6a50 100644
--- a/arch/sparc/kernel/pcr.c
+++ b/arch/sparc/kernel/pcr.c
@@ -8,6 +8,7 @@
 #include <linux/irq.h>
 
 #include <linux/perf_event.h>
+#include <linux/ftrace.h>
 
 #include <asm/pil.h>
 #include <asm/pcr.h>
@@ -34,7 +35,7 @@ unsigned int picl_shift;
  * Therefore in such situations we defer the work by signalling
  * a lower level cpu IRQ.
  */
-void deferred_pcr_work_irq(int irq, struct pt_regs *regs)
+void __irq_entry deferred_pcr_work_irq(int irq, struct pt_regs *regs)
 {
 	struct pt_regs *old_regs;
 
diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index eb14844..1011fbf 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -22,6 +22,7 @@
 #include <linux/profile.h>
 #include <linux/bootmem.h>
 #include <linux/vmalloc.h>
+#include <linux/ftrace.h>
 #include <linux/cpu.h>
 
 #include <asm/head.h>
@@ -822,13 +823,13 @@ void arch_send_call_function_single_ipi(int cpu)
 		      &cpumask_of_cpu(cpu));
 }
 
-void smp_call_function_client(int irq, struct pt_regs *regs)
+void __irq_entry smp_call_function_client(int irq, struct pt_regs *regs)
 {
 	clear_softint(1 << irq);
 	generic_smp_call_function_interrupt();
 }
 
-void smp_call_function_single_client(int irq, struct pt_regs *regs)
+void __irq_entry smp_call_function_single_client(int irq, struct pt_regs *regs)
 {
 	clear_softint(1 << irq);
 	generic_smp_call_function_single_interrupt();
@@ -964,7 +965,7 @@ void flush_dcache_page_all(struct mm_struct *mm, struct page *page)
 	put_cpu();
 }
 
-void smp_new_mmu_context_version_client(int irq, struct pt_regs *regs)
+void __irq_entry smp_new_mmu_context_version_client(int irq, struct pt_regs *regs)
 {
 	struct mm_struct *mm;
 	unsigned long flags;
@@ -1148,7 +1149,7 @@ void smp_release(void)
  */
 extern void prom_world(int);
 
-void smp_penguin_jailcell(int irq, struct pt_regs *regs)
+void __irq_entry smp_penguin_jailcell(int irq, struct pt_regs *regs)
 {
 	clear_softint(1 << irq);
 
@@ -1364,7 +1365,7 @@ void smp_send_reschedule(int cpu)
 		      &cpumask_of_cpu(cpu));
 }
 
-void smp_receive_signal_client(int irq, struct pt_regs *regs)
+void __irq_entry smp_receive_signal_client(int irq, struct pt_regs *regs)
 {
 	clear_softint(1 << irq);
 }
diff --git a/arch/sparc/kernel/time_64.c b/arch/sparc/kernel/time_64.c
index f25858e..c7bbe6c 100644
--- a/arch/sparc/kernel/time_64.c
+++ b/arch/sparc/kernel/time_64.c
@@ -35,6 +35,7 @@
 #include <linux/clocksource.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/ftrace.h>
 
 #include <asm/oplib.h>
 #include <asm/timer.h>
@@ -717,7 +718,7 @@ static struct clock_event_device sparc64_clockevent = {
 };
 static DEFINE_PER_CPU(struct clock_event_device, sparc64_events);
 
-void timer_interrupt(int irq, struct pt_regs *regs)
+void __irq_entry timer_interrupt(int irq, struct pt_regs *regs)
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
 	unsigned long tick_mask = tick_ops->softint_mask;
diff --git a/arch/sparc/kernel/vmlinux.lds.S b/arch/sparc/kernel/vmlinux.lds.S
index 4e59925..c4f5758 100644
--- a/arch/sparc/kernel/vmlinux.lds.S
+++ b/arch/sparc/kernel/vmlinux.lds.S
@@ -46,6 +46,7 @@ SECTIONS
 		SCHED_TEXT
 		LOCK_TEXT
 		KPROBES_TEXT
+		IRQENTRY_TEXT
 		*(.gnu.warning)
 	} = 0
 	_etext = .;
diff --git a/arch/sparc/lib/mcount.S b/arch/sparc/lib/mcount.S
index 153c80e..3753e3c 100644
--- a/arch/sparc/lib/mcount.S
+++ b/arch/sparc/lib/mcount.S
@@ -26,22 +26,42 @@ mcount:
 #else
 	sethi		%hi(function_trace_stop), %g1
 	lduw		[%g1 + %lo(function_trace_stop)], %g2
-	brnz,pn		%g2, 1f
+	brnz,pn		%g2, 2f
 	 sethi		%hi(ftrace_trace_function), %g1
 	sethi		%hi(ftrace_stub), %g2
 	ldx		[%g1 + %lo(ftrace_trace_function)], %g1
 	or		%g2, %lo(ftrace_stub), %g2
 	cmp		%g1, %g2
 	be,pn		%icc, 1f
-	 mov		%i7, %g2
+	 mov		%i7, %g3
 	save		%sp, -128, %sp
-	mov		%g2, %o1
+	mov		%g3, %o1
 	jmpl		%g1, %o7
 	 mov		%i7, %o0
 	ret
 	 restore
 	/* not reached */
 1:
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	sethi		%hi(ftrace_graph_return), %g1
+	ldx		[%g1 + %lo(ftrace_graph_return)], %g3
+	cmp		%g2, %g3
+	bne,pn		%xcc, 5f
+	 sethi		%hi(ftrace_graph_entry_stub), %g2
+	sethi		%hi(ftrace_graph_entry), %g1
+	or		%g2, %lo(ftrace_graph_entry_stub), %g2
+	ldx		[%g1 + %lo(ftrace_graph_entry)], %g1
+	cmp		%g1, %g2
+	be,pt		%xcc, 2f
+	 nop
+5:	mov		%i7, %g2
+	mov		%fp, %g3
+	save		%sp, -128, %sp
+	mov		%g2, %l0
+	ba,pt		%xcc, ftrace_graph_caller
+	 mov		%g3, %l1
+#endif
+2:
 #endif
 #endif
 	retl
@@ -62,18 +82,48 @@ ftrace_stub:
 ftrace_caller:
 	sethi		%hi(function_trace_stop), %g1
 	mov		%i7, %g2
-	lduw		[%g1 + %lo(function_trace_stop)], %g3
-	brnz,pn		%g3, ftrace_stub
-	 nop
+	lduw		[%g1 + %lo(function_trace_stop)], %g1
+	brnz,pn		%g1, ftrace_stub
+	 mov		%fp, %g3
 	save		%sp, -128, %sp
 	mov		%g2, %o1
+	mov		%g2, %l0
+	mov		%g3, %l1
 	.globl		ftrace_call
 ftrace_call:
 	call		ftrace_stub
 	 mov		%i7, %o0
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	.globl		ftrace_graph_call
+ftrace_graph_call:
+	call		ftrace_stub
+	 nop
+#endif
 	ret
 	 restore
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	.size		ftrace_graph_call,.-ftrace_graph_call
+#endif
 	.size		ftrace_call,.-ftrace_call
 	.size		ftrace_caller,.-ftrace_caller
 #endif
 #endif
+
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+ENTRY(ftrace_graph_caller)
+	mov		%l0, %o0
+	mov		%i7, %o1
+	call		prepare_ftrace_return
+	 mov		%l1, %o2
+	ret
+	 restore	%o0, -8, %i7
+END(ftrace_graph_caller)
+
+ENTRY(return_to_handler)
+	save		%sp, -128, %sp
+	call		ftrace_return_to_handler
+	 mov		%fp, %o0
+	jmpl		%o0 + 8, %g0
+	 restore
+END(return_to_handler)
+#endif
-- 
1.7.0.4


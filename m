From: Petr Mladek <pmladek@suse.com>
Date: Fri, 27 Nov 2015 15:38:04 +0000
Subject: Re: [PATCH v2 1/5] printk/nmi: Generic solution for safe printk in NMI
Message-Id: <20151127153804.GC2648@pathway.suse.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <1448622572-16900-2-git-send-email-pmladek@suse.com>
 <201511271919.aEZuZKNe%fengguang.wu@intel.com>
In-Reply-To: <201511271919.aEZuZKNe%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri 2015-11-27 19:49:48, kbuild test robot wrote:
> Hi Petr,
> 
> [auto build test WARNING on powerpc/next]
> [also build test WARNING on v4.4-rc2 next-20151127]
> [cannot apply to tip/x86/core]
> 
> url:    https://github.com/0day-ci/linux/commits/Petr-Mladek/Cleaning-printk-stuff-in-NMI-context/20151127-191620
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
> config: mn10300-asb2364_defconfig (attached as .config)
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=mn10300 
> 
> All warnings (new ones prefixed by >>):
> 
> warning: (MN10300) selects HAVE_NMI_WATCHDOG which has unmet direct dependencies (HAVE_NMI)

MN10300 has its own implementation for entering and exiting NMI
handlers. It does not call nmi_enter() and nmi_exit().
Please, find below an updated patch that adds printk_nmi_enter()
and printk_nmi_exit() to the custom entry points.
Then we could add HAVE_NMI to arch/mn10300/Kconfig and avoid
the above warning.

The updated patch also fixes includes in kernel/printk/nmi.c
and kernel/printk/printk.h to fix the other build errors
found by kbuild test robot.

The kbuild test robot is really cool thing!


From 1689f635cc423ff9887c6774ad6b59a1ea885e4b Mon Sep 17 00:00:00 2001
From: Petr Mladek <pmladek@suse.com>
Date: Thu, 2 Jul 2015 13:17:17 +0200
Subject: [PATCH 1/5] printk/nmi: Generic solution for safe printk in NMI

printk() takes some locks and could not be used a safe way in NMI
context.

The chance of a deadlock is real especially when printing
stacks from all CPUs. This particular problem has been addressed
on x86 by the commit a9edc8809328 ("x86/nmi: Perform a safe NMI stack
trace on all CPUs").

This patch reuses most of the code and makes it generic. It is
useful for all messages and architectures that support NMI.

The alternative printk_func is set when entering and is reseted when
leaving NMI context. It queues IRQ work to copy the messages into
the main ring buffer in a safe context.

__printk_nmi_flush() copies all available messages and reset
the buffer. Then we could use a simple cmpxchg operations to
get synchronized with writers. There is also used a spinlock
to get synchronized with other flushers.

We do not longer use seq_buf because it depends on external lock.
It would be hard to make all supported operations safe for
a lockless use. It would be confusing and error prone to
make only some operations safe.

The code is put into separate printk/nmi.c as suggested by
Steven Rostedt. It needs a per-CPU buffer and is compiled only
on architectures that call nmi_enter(). This is achieved by
the new HAVE_NMI Kconfig flag.

One exception is arm where the deferred printing is used for
printing backtraces even without NMI. For this purpose,
we define NEED_PRINTK_NMI Kconfig flag. The alternative
printk_func is explicitly set when IPI_CPU_BACKTRACE is
handled.

Second exception is MN10300 architecture that has its own
implementation of entering and exiting NMI handlers.
It even has a separate optimized implementation for
NMI watchdog. This patch adds printk_nmi_enter() and
printk_nmi_exit() to these custom entry points.
Note that we have to define HAVE_NMI here. Otherwise,
Kconfig complains about unmet direct dependencies for
HAVE_NMI_WATCHDOG.

Last exception is Xtensa architecture that uses just a
fake NMI.

The patch is heavily based on the draft from Peter Zijlstra,
see https://lkml.org/lkml/2015/6/10/327

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 arch/Kconfig                           |   7 ++
 arch/arm/Kconfig                       |   2 +
 arch/arm/kernel/smp.c                  |   2 +
 arch/avr32/Kconfig                     |   1 +
 arch/blackfin/Kconfig                  |   1 +
 arch/cris/Kconfig                      |   1 +
 arch/mips/Kconfig                      |   1 +
 arch/mn10300/Kconfig                   |   1 +
 arch/mn10300/kernel/mn10300-watchdog.c |   4 +
 arch/mn10300/kernel/smp.c              |   3 +
 arch/powerpc/Kconfig                   |   1 +
 arch/s390/Kconfig                      |   1 +
 arch/sh/Kconfig                        |   1 +
 arch/sparc/Kconfig                     |   1 +
 arch/tile/Kconfig                      |   1 +
 arch/x86/Kconfig                       |   1 +
 arch/x86/kernel/apic/hw_nmi.c          |   1 -
 include/linux/hardirq.h                |   2 +
 include/linux/percpu.h                 |   3 -
 include/linux/printk.h                 |  12 +-
 init/Kconfig                           |   5 +
 init/main.c                            |   1 +
 kernel/printk/Makefile                 |   1 +
 kernel/printk/nmi.c                    | 202 +++++++++++++++++++++++++++++++++
 kernel/printk/printk.c                 |  19 +---
 kernel/printk/printk.h                 |  44 +++++++
 lib/nmi_backtrace.c                    |  89 +--------------
 27 files changed, 301 insertions(+), 107 deletions(-)
 create mode 100644 kernel/printk/nmi.c
 create mode 100644 kernel/printk/printk.h

diff --git a/arch/Kconfig b/arch/Kconfig
index 4e949e58b192..7ce5101c2472 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -187,7 +187,14 @@ config HAVE_OPTPROBES
 config HAVE_KPROBES_ON_FTRACE
 	bool
 
+config HAVE_NMI
+	bool
+
+config NEED_PRINTK_NMI
+	bool
+
 config HAVE_NMI_WATCHDOG
+	depends on HAVE_NMI
 	bool
 #
 # An arch should select this if it provides all these things:
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 0365cbbc9179..f0465e420762 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -63,6 +63,8 @@ config ARM
 	select HAVE_KRETPROBES if (HAVE_KPROBES)
 	select HAVE_MEMBLOCK
 	select HAVE_MOD_ARCH_SPECIFIC
+	select HAVE_NMI if (!CPU_V7M)
+	select NEED_PRINTK_NMI if (CPU_V7M)
 	select HAVE_OPROFILE if (HAVE_PERF_EVENTS)
 	select HAVE_OPTPROBES if !THUMB2_KERNEL
 	select HAVE_PERF_EVENTS
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index b26361355dae..a960adb9bd7d 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -648,7 +648,9 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
 
 	case IPI_CPU_BACKTRACE:
 		irq_enter();
+		printk_nmi_enter();
 		nmi_cpu_backtrace(regs);
+		printk_nmi_exit();
 		irq_exit();
 		break;
 
diff --git a/arch/avr32/Kconfig b/arch/avr32/Kconfig
index b6878eb64884..9dc3e2b1180b 100644
--- a/arch/avr32/Kconfig
+++ b/arch/avr32/Kconfig
@@ -17,6 +17,7 @@ config AVR32
 	select GENERIC_CLOCKEVENTS
 	select HAVE_MOD_ARCH_SPECIFIC
 	select MODULES_USE_ELF_RELA
+	select HAVE_NMI
 	help
 	  AVR32 is a high-performance 32-bit RISC microprocessor core,
 	  designed for cost-sensitive embedded applications, with particular
diff --git a/arch/blackfin/Kconfig b/arch/blackfin/Kconfig
index af76634f8d98..47c0a55acafd 100644
--- a/arch/blackfin/Kconfig
+++ b/arch/blackfin/Kconfig
@@ -40,6 +40,7 @@ config BLACKFIN
 	select HAVE_MOD_ARCH_SPECIFIC
 	select MODULES_USE_ELF_RELA
 	select HAVE_DEBUG_STACKOVERFLOW
+	select HAVE_NMI
 
 config GENERIC_CSUM
 	def_bool y
diff --git a/arch/cris/Kconfig b/arch/cris/Kconfig
index e086f9e93728..62148eaf0189 100644
--- a/arch/cris/Kconfig
+++ b/arch/cris/Kconfig
@@ -69,6 +69,7 @@ config CRIS
 	select GENERIC_CLOCKEVENTS if ETRAX_ARCH_V32
 	select GENERIC_SCHED_CLOCK if ETRAX_ARCH_V32
 	select HAVE_DEBUG_BUGVERBOSE if ETRAX_ARCH_V32
+	select HAVE_NMI
 
 config HZ
 	int
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 71683a853372..35ae01fe980a 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -63,6 +63,7 @@ config MIPS
 	select HAVE_IRQ_TIME_ACCOUNTING
 	select GENERIC_TIME_VSYSCALL
 	select ARCH_CLOCKSOURCE_DATA
+	select HAVE_NMI
 
 menu "Machine selection"
 
diff --git a/arch/mn10300/Kconfig b/arch/mn10300/Kconfig
index 4434b54e1d87..468d8d0e8773 100644
--- a/arch/mn10300/Kconfig
+++ b/arch/mn10300/Kconfig
@@ -7,6 +7,7 @@ config MN10300
 	select HAVE_ARCH_KGDB
 	select GENERIC_ATOMIC64
 	select HAVE_NMI_WATCHDOG if MN10300_WD_TIMER
+	select HAVE_NMI
 	select VIRT_TO_BUS
 	select GENERIC_CLOCKEVENTS
 	select MODULES_USE_ELF_RELA
diff --git a/arch/mn10300/kernel/mn10300-watchdog.c b/arch/mn10300/kernel/mn10300-watchdog.c
index a2d8e6938d67..d712cec61deb 100644
--- a/arch/mn10300/kernel/mn10300-watchdog.c
+++ b/arch/mn10300/kernel/mn10300-watchdog.c
@@ -144,6 +144,8 @@ void watchdog_interrupt(struct pt_regs *regs, enum exception_code excep)
 	nmi_count(smp_processor_id())++;
 	kstat_incr_irq_this_cpu(irq);
 
+	printk_nmi_enter();
+
 	for_each_online_cpu(cpu) {
 
 		sum = irq_stat[cpu].__irq_count;
@@ -198,6 +200,8 @@ void watchdog_interrupt(struct pt_regs *regs, enum exception_code excep)
 		}
 	}
 
+	printk_nmi_exit();
+
 	WDCTR = wdt | WDCTR_WDRST;
 	tmp = WDCTR;
 	WDCTR = wdt | WDCTR_WDCNE;
diff --git a/arch/mn10300/kernel/smp.c b/arch/mn10300/kernel/smp.c
index f984193718b1..9c26e4cefbb6 100644
--- a/arch/mn10300/kernel/smp.c
+++ b/arch/mn10300/kernel/smp.c
@@ -537,8 +537,11 @@ void smp_nmi_call_function_interrupt(void)
 	 */
 	smp_mb();
 	cpumask_clear_cpu(smp_processor_id(), &nmi_call_data->started);
+	printk_nmi_enter();
+
 	(*func)(info);
 
+	printk_nmi_exit();
 	if (wait) {
 		smp_mb();
 		cpumask_clear_cpu(smp_processor_id(),
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index db49e0d796b1..1bd8a7503a48 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -156,6 +156,7 @@ config PPC
 	select NO_BOOTMEM
 	select HAVE_GENERIC_RCU_GUP
 	select HAVE_PERF_EVENTS_NMI if PPC64
+	select HAVE_NMI if PERF_EVENTS
 	select EDAC_SUPPORT
 	select EDAC_ATOMIC_SCRUB
 	select ARCH_HAS_DMA_SET_COHERENT_MASK
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 3a55f493c7da..9a8a76829508 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -159,6 +159,7 @@ config S390
 	select TTY
 	select VIRT_CPU_ACCOUNTING
 	select VIRT_TO_BUS
+	select HAVE_NMI
 
 
 config SCHED_OMIT_FRAME_POINTER
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index d514df7e04dd..ff8093b574f1 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -44,6 +44,7 @@ config SUPERH
 	select OLD_SIGSUSPEND
 	select OLD_SIGACTION
 	select HAVE_ARCH_AUDITSYSCALL
+	select HAVE_NMI
 	help
 	  The SuperH is a RISC processor targeted for use in embedded systems
 	  and consumer electronics; it was also used in the Sega Dreamcast
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 56442d2d7bbc..e05ea973fd6a 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -80,6 +80,7 @@ config SPARC64
 	select NO_BOOTMEM
 	select HAVE_ARCH_AUDITSYSCALL
 	select ARCH_SUPPORTS_ATOMIC_RMW
+	select HAVE_NMI
 
 config ARCH_DEFCONFIG
 	string
diff --git a/arch/tile/Kconfig b/arch/tile/Kconfig
index 106c21bd7f44..050468c41dc6 100644
--- a/arch/tile/Kconfig
+++ b/arch/tile/Kconfig
@@ -29,6 +29,7 @@ config TILE
 	select HAVE_DEBUG_STACKOVERFLOW
 	select ARCH_WANT_FRAME_POINTERS
 	select HAVE_CONTEXT_TRACKING
+	select HAVE_NMI if USE_PMC
 	select EDAC_SUPPORT
 	select GENERIC_STRNCPY_FROM_USER
 	select GENERIC_STRNLEN_USER
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index db3622f22b61..e83f99194c4c 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -126,6 +126,7 @@ config X86
 	select HAVE_MEMBLOCK
 	select HAVE_MEMBLOCK_NODE_MAP
 	select HAVE_MIXED_BREAKPOINTS_REGS
+	select HAVE_NMI
 	select HAVE_OPROFILE
 	select HAVE_OPTPROBES
 	select HAVE_PCSPKR_PLATFORM
diff --git a/arch/x86/kernel/apic/hw_nmi.c b/arch/x86/kernel/apic/hw_nmi.c
index 045e424fb368..7788ce643bf4 100644
--- a/arch/x86/kernel/apic/hw_nmi.c
+++ b/arch/x86/kernel/apic/hw_nmi.c
@@ -18,7 +18,6 @@
 #include <linux/nmi.h>
 #include <linux/module.h>
 #include <linux/delay.h>
-#include <linux/seq_buf.h>
 
 #ifdef CONFIG_HARDLOCKUP_DETECTOR
 u64 hw_nmi_get_sample_period(int watchdog_thresh)
diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
index dfd59d6bc6f0..a477e0766d2e 100644
--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -67,10 +67,12 @@ extern void irq_exit(void);
 		preempt_count_add(NMI_OFFSET + HARDIRQ_OFFSET);	\
 		rcu_nmi_enter();				\
 		trace_hardirq_enter();				\
+		printk_nmi_enter();				\
 	} while (0)
 
 #define nmi_exit()						\
 	do {							\
+		printk_nmi_exit();				\
 		trace_hardirq_exit();				\
 		rcu_nmi_exit();					\
 		BUG_ON(!in_nmi());				\
diff --git a/include/linux/percpu.h b/include/linux/percpu.h
index caebf2a758dc..04c68b9f56f8 100644
--- a/include/linux/percpu.h
+++ b/include/linux/percpu.h
@@ -135,7 +135,4 @@ extern phys_addr_t per_cpu_ptr_to_phys(void *addr);
 	(typeof(type) __percpu *)__alloc_percpu(sizeof(type),		\
 						__alignof__(type))
 
-/* To avoid include hell, as printk can not declare this, we declare it here */
-DECLARE_PER_CPU(printk_func_t, printk_func);
-
 #endif /* __LINUX_PERCPU_H */
diff --git a/include/linux/printk.h b/include/linux/printk.h
index 9729565c25ff..7aba6b92d020 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -122,7 +122,17 @@ static inline __printf(1, 2) __cold
 void early_printk(const char *s, ...) { }
 #endif
 
-typedef __printf(1, 0) int (*printk_func_t)(const char *fmt, va_list args);
+#ifdef CONFIG_PRINTK_NMI
+extern void printk_nmi_init(void);
+extern void printk_nmi_enter(void);
+extern void printk_nmi_exit(void);
+extern void printk_nmi_flush(void);
+#else
+static inline void printk_nmi_init(void) { }
+static inline void printk_nmi_enter(void) { }
+static inline void printk_nmi_exit(void) { }
+static inline void printk_nmi_flush(void) { }
+#endif /* PRINTK_NMI */
 
 #ifdef CONFIG_PRINTK
 asmlinkage __printf(5, 0)
diff --git a/init/Kconfig b/init/Kconfig
index c24b6f767bf0..c1c0b6a2d712 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1456,6 +1456,11 @@ config PRINTK
 	  very difficult to diagnose system problems, saying N here is
 	  strongly discouraged.
 
+config PRINTK_NMI
+	def_bool y
+	depends on PRINTK
+	depends on HAVE_NMI || NEED_PRINTK_NMI
+
 config BUG
 	bool "BUG() support" if EXPERT
 	default y
diff --git a/init/main.c b/init/main.c
index 9e64d7097f1a..45c1e05125dc 100644
--- a/init/main.c
+++ b/init/main.c
@@ -591,6 +591,7 @@ asmlinkage __visible void __init start_kernel(void)
 	timekeeping_init();
 	time_init();
 	sched_clock_postinit();
+	printk_nmi_init();
 	perf_event_init();
 	profile_init();
 	call_function_init();
diff --git a/kernel/printk/Makefile b/kernel/printk/Makefile
index 85405bdcf2b3..abb0042a427b 100644
--- a/kernel/printk/Makefile
+++ b/kernel/printk/Makefile
@@ -1,2 +1,3 @@
 obj-y	= printk.o
+obj-$(CONFIG_PRINTK_NMI)		+= nmi.o
 obj-$(CONFIG_A11Y_BRAILLE_CONSOLE)	+= braille.o
diff --git a/kernel/printk/nmi.c b/kernel/printk/nmi.c
new file mode 100644
index 000000000000..01aef64613ea
--- /dev/null
+++ b/kernel/printk/nmi.c
@@ -0,0 +1,202 @@
+/*
+ * nmi.c - Safe printk in NMI context
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/preempt.h>
+#include <linux/spinlock.h>
+#include <linux/smp.h>
+#include <linux/cpumask.h>
+#include <linux/irq_work.h>
+#include <linux/printk.h>
+
+#include "printk.h"
+
+/*
+ * printk() could not take logbuf_lock in NMI context. Instead,
+ * it uses an alternative implementation that temporary stores
+ * the strings into a per-CPU buffer. The content of the buffer
+ * is later flushed into the main ring buffer via IRQ work.
+ *
+ * The alternative implementation is chosen transparently
+ * via @printk_func per-CPU variable.
+ *
+ * The implementation allows to flush the strings also from another CPU.
+ * There are situations when we want to make sure that all buffers
+ * were handled or when IRQs are blocked.
+ */
+DEFINE_PER_CPU(printk_func_t, printk_func) = vprintk_default;
+
+struct nmi_seq_buf {
+	atomic_t		len;	/* length of written data */
+	struct irq_work		work;	/* IRQ work that flushes the buffer */
+	unsigned char		buffer[PAGE_SIZE - sizeof(atomic_t) -
+				       sizeof(struct irq_work)];
+};
+static DEFINE_PER_CPU(struct nmi_seq_buf, nmi_print_seq);
+
+/*
+ * Safe printk() for NMI context. It uses a per-CPU buffer to
+ * store the message. NMIs are not nested, so there is always only
+ * one writer running. But the buffer might get flushed from another
+ * CPU, so we need to be careful.
+ */
+static int vprintk_nmi(const char *fmt, va_list args)
+{
+	struct nmi_seq_buf *s = this_cpu_ptr(&nmi_print_seq);
+	int add = 0, len;
+
+again:
+	len = atomic_read(&s->len);
+
+	if (len >=  sizeof(s->buffer))
+		return 0;
+
+	/*
+	 * Make sure that all old data have been read before the buffer was
+	 * reseted. This is not needed when we just append data.
+	 */
+	if (!len)
+		smp_rmb();
+
+	add = vsnprintf(s->buffer + len, sizeof(s->buffer) - len, fmt, args);
+
+	/*
+	 * Do it once again if the buffer has been flushed in the meantime.
+	 * Note that atomic_cmpxchg() is an implicit memory barrier that
+	 * makes sure that the data were written before updating s->len.
+	 */
+	if (atomic_cmpxchg(&s->len, len, len + add) != len)
+		goto again;
+
+	/* Get flushed in a more safe context. */
+	if (add)
+		irq_work_queue(&s->work);
+
+	return add;
+}
+
+/*
+ * printk one line from the temporary buffer from @start index until
+ * and including the @end index.
+ */
+static void print_nmi_seq_line(struct nmi_seq_buf *s, int start, int end)
+{
+	const char *buf = s->buffer + start;
+
+	printk("%.*s", (end - start) + 1, buf);
+}
+
+/*
+ * Flush data from the associated per_CPU buffer. The function
+ * can be called either via IRQ work or independently.
+ */
+static void __printk_nmi_flush(struct irq_work *work)
+{
+	static raw_spinlock_t read_lock +		__RAW_SPIN_LOCK_INITIALIZER(read_lock);
+	struct nmi_seq_buf *s = container_of(work, struct nmi_seq_buf, work);
+	int len, size, i, last_i;
+
+	/*
+	 * The lock has two functions. First, one reader has to flush all
+	 * available message to make the lockless synchronization with
+	 * writers easier. Second, we do not want to mix messages from
+	 * different CPUs. This is especially important when printing
+	 * a backtrace.
+	 */
+	raw_spin_lock(&read_lock);
+
+	i = 0;
+more:
+	len = atomic_read(&s->len);
+
+	/*
+	 * This is just a paranoid check that nobody has manipulated
+	 * the buffer an unexpected way. If we printed something then
+	 * @len must only increase.
+	 */
+	WARN_ON(i && i >= len);
+
+	if (!len)
+		goto out; /* Someone else has already flushed the buffer. */
+
+	/* Make sure that data has been written up to the @len */
+	smp_rmb();
+
+	size = min_t(int, len, sizeof(s->buffer));
+	last_i = i;
+
+	/* Print line by line. */
+	for (; i < size; i++) {
+		if (s->buffer[i] = '\n') {
+			print_nmi_seq_line(s, last_i, i);
+			last_i = i + 1;
+		}
+	}
+	/* Check if there was a partial line. */
+	if (last_i < size) {
+		print_nmi_seq_line(s, last_i, size - 1);
+		pr_cont("\n");
+	}
+
+	/*
+	 * Check that nothing has got added in the meantime and truncate
+	 * the buffer. Note that atomic_cmpxchg() is an implicit memory
+	 * barrier that makes sure that the data were copied before
+	 * updating s->len.
+	 */
+	if (atomic_cmpxchg(&s->len, len, 0) != len)
+		goto more;
+
+out:
+	raw_spin_unlock(&read_lock);
+}
+
+/**
+ * printk_nmi_flush - flush all per-cpu nmi buffers.
+ *
+ * The buffers are flushed automatically via IRQ work. This function
+ * is useful only when someone wants to be sure that all buffers have
+ * been flushed at some point.
+ */
+void printk_nmi_flush(void)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		__printk_nmi_flush(&per_cpu(nmi_print_seq, cpu).work);
+}
+
+void __init printk_nmi_init(void)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		struct nmi_seq_buf *s = &per_cpu(nmi_print_seq, cpu);
+
+		init_irq_work(&s->work, __printk_nmi_flush);
+	}
+}
+
+void printk_nmi_enter(void)
+{
+	this_cpu_write(printk_func, vprintk_nmi);
+}
+
+void printk_nmi_exit(void)
+{
+	this_cpu_write(printk_func, vprintk_default);
+}
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 2ce8826f1053..88641c74163d 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -54,6 +54,7 @@
 
 #include "console_cmdline.h"
 #include "braille.h"
+#include "printk.h"
 
 int console_printk[4] = {
 	CONSOLE_LOGLEVEL_DEFAULT,	/* console_loglevel */
@@ -1867,14 +1868,6 @@ int vprintk_default(const char *fmt, va_list args)
 }
 EXPORT_SYMBOL_GPL(vprintk_default);
 
-/*
- * This allows printk to be diverted to another function per cpu.
- * This is useful for calling printk functions from within NMI
- * without worrying about race conditions that can lock up the
- * box.
- */
-DEFINE_PER_CPU(printk_func_t, printk_func) = vprintk_default;
-
 /**
  * printk - print a kernel message
  * @fmt: format string
@@ -1898,21 +1891,11 @@ DEFINE_PER_CPU(printk_func_t, printk_func) = vprintk_default;
  */
 asmlinkage __visible int printk(const char *fmt, ...)
 {
-	printk_func_t vprintk_func;
 	va_list args;
 	int r;
 
 	va_start(args, fmt);
-
-	/*
-	 * If a caller overrides the per_cpu printk_func, then it needs
-	 * to disable preemption when calling printk(). Otherwise
-	 * the printk_func should be set to the default. No need to
-	 * disable preemption here.
-	 */
-	vprintk_func = this_cpu_read(printk_func);
 	r = vprintk_func(fmt, args);
-
 	va_end(args);
 
 	return r;
diff --git a/kernel/printk/printk.h b/kernel/printk/printk.h
new file mode 100644
index 000000000000..dc97c1c4d53b
--- /dev/null
+++ b/kernel/printk/printk.h
@@ -0,0 +1,44 @@
+/*
+ * printk.h - printk internal definitions
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+#include <linux/percpu.h>
+
+typedef __printf(1, 0) int (*printk_func_t)(const char *fmt, va_list args);
+
+int __printf(1, 0) vprintk_default(const char *fmt, va_list args);
+
+#ifdef CONFIG_PRINTK_NMI
+
+/*
+ * printk() could not take logbuf_lock in NMI context. Instead,
+ * it temporary stores the strings into a per-CPU buffer.
+ * The alternative implementation is chosen transparently
+ * via per-CPU variable.
+ */
+DECLARE_PER_CPU(printk_func_t, printk_func);
+static inline __printf(1, 0) int vprintk_func(const char *fmt, va_list args)
+{
+	return this_cpu_read(printk_func)(fmt, args);
+}
+
+#else /* CONFIG_PRINTK_NMI */
+
+static inline __printf(1, 0) int vprintk_func(const char *fmt, va_list args)
+{
+	return vprintk_default(fmt, args);
+}
+
+#endif /* CONFIG_PRINTK_NMI */
diff --git a/lib/nmi_backtrace.c b/lib/nmi_backtrace.c
index 6019c53c669e..26caf51cc238 100644
--- a/lib/nmi_backtrace.c
+++ b/lib/nmi_backtrace.c
@@ -16,33 +16,14 @@
 #include <linux/delay.h>
 #include <linux/kprobes.h>
 #include <linux/nmi.h>
-#include <linux/seq_buf.h>
 
 #ifdef arch_trigger_all_cpu_backtrace
 /* For reliability, we're prepared to waste bits here. */
 static DECLARE_BITMAP(backtrace_mask, NR_CPUS) __read_mostly;
-static cpumask_t printtrace_mask;
-
-#define NMI_BUF_SIZE		4096
-
-struct nmi_seq_buf {
-	unsigned char		buffer[NMI_BUF_SIZE];
-	struct seq_buf		seq;
-};
-
-/* Safe printing in NMI context */
-static DEFINE_PER_CPU(struct nmi_seq_buf, nmi_print_seq);
 
 /* "in progress" flag of arch_trigger_all_cpu_backtrace */
 static unsigned long backtrace_flag;
 
-static void print_seq_line(struct nmi_seq_buf *s, int start, int end)
-{
-	const char *buf = s->buffer + start;
-
-	printk("%.*s", (end - start) + 1, buf);
-}
-
 /*
  * When raise() is called it will be is passed a pointer to the
  * backtrace_mask. Architectures that call nmi_cpu_backtrace()
@@ -52,8 +33,7 @@ static void print_seq_line(struct nmi_seq_buf *s, int start, int end)
 void nmi_trigger_all_cpu_backtrace(bool include_self,
 				   void (*raise)(cpumask_t *mask))
 {
-	struct nmi_seq_buf *s;
-	int i, cpu, this_cpu = get_cpu();
+	int i, this_cpu = get_cpu();
 
 	if (test_and_set_bit(0, &backtrace_flag)) {
 		/*
@@ -68,17 +48,6 @@ void nmi_trigger_all_cpu_backtrace(bool include_self,
 	if (!include_self)
 		cpumask_clear_cpu(this_cpu, to_cpumask(backtrace_mask));
 
-	cpumask_copy(&printtrace_mask, to_cpumask(backtrace_mask));
-
-	/*
-	 * Set up per_cpu seq_buf buffers that the NMIs running on the other
-	 * CPUs will write to.
-	 */
-	for_each_cpu(cpu, to_cpumask(backtrace_mask)) {
-		s = &per_cpu(nmi_print_seq, cpu);
-		seq_buf_init(&s->seq, s->buffer, NMI_BUF_SIZE);
-	}
-
 	if (!cpumask_empty(to_cpumask(backtrace_mask))) {
 		pr_info("Sending NMI to %s CPUs:\n",
 			(include_self ? "all" : "other"));
@@ -94,73 +63,25 @@ void nmi_trigger_all_cpu_backtrace(bool include_self,
 	}
 
 	/*
-	 * Now that all the NMIs have triggered, we can dump out their
-	 * back traces safely to the console.
+	 * Force flush any remote buffers that might be stuck in IRQ context
+	 * and therefore could not run their irq_work.
 	 */
-	for_each_cpu(cpu, &printtrace_mask) {
-		int len, last_i = 0;
+	printk_nmi_flush();
 
-		s = &per_cpu(nmi_print_seq, cpu);
-		len = seq_buf_used(&s->seq);
-		if (!len)
-			continue;
-
-		/* Print line by line. */
-		for (i = 0; i < len; i++) {
-			if (s->buffer[i] = '\n') {
-				print_seq_line(s, last_i, i);
-				last_i = i + 1;
-			}
-		}
-		/* Check if there was a partial line. */
-		if (last_i < len) {
-			print_seq_line(s, last_i, len - 1);
-			pr_cont("\n");
-		}
-	}
-
-	clear_bit(0, &backtrace_flag);
-	smp_mb__after_atomic();
+	clear_bit_unlock(0, &backtrace_flag);
 	put_cpu();
 }
 
-/*
- * It is not safe to call printk() directly from NMI handlers.
- * It may be fine if the NMI detected a lock up and we have no choice
- * but to do so, but doing a NMI on all other CPUs to get a back trace
- * can be done with a sysrq-l. We don't want that to lock up, which
- * can happen if the NMI interrupts a printk in progress.
- *
- * Instead, we redirect the vprintk() to this nmi_vprintk() that writes
- * the content into a per cpu seq_buf buffer. Then when the NMIs are
- * all done, we can safely dump the contents of the seq_buf to a printk()
- * from a non NMI context.
- */
-static int nmi_vprintk(const char *fmt, va_list args)
-{
-	struct nmi_seq_buf *s = this_cpu_ptr(&nmi_print_seq);
-	unsigned int len = seq_buf_used(&s->seq);
-
-	seq_buf_vprintf(&s->seq, fmt, args);
-	return seq_buf_used(&s->seq) - len;
-}
-
 bool nmi_cpu_backtrace(struct pt_regs *regs)
 {
 	int cpu = smp_processor_id();
 
 	if (cpumask_test_cpu(cpu, to_cpumask(backtrace_mask))) {
-		printk_func_t printk_func_save = this_cpu_read(printk_func);
-
-		/* Replace printk to write into the NMI seq */
-		this_cpu_write(printk_func, nmi_vprintk);
 		pr_warn("NMI backtrace for cpu %d\n", cpu);
 		if (regs)
 			show_regs(regs);
 		else
 			dump_stack();
-		this_cpu_write(printk_func, printk_func_save);
-
 		cpumask_clear_cpu(cpu, to_cpumask(backtrace_mask));
 		return true;
 	}
-- 
1.8.5.6


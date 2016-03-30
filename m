From: Petr Mladek <pmladek@suse.com>
Date: Wed, 30 Mar 2016 15:53:30 +0000
Subject: [PATCH v4 5/5] printk/nmi: flush NMI messages on the system panic
Message-Id: <1459353210-20260-6-git-send-email-pmladek@suse.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1459353210-20260-1-git-send-email-pmladek@suse.com>
In-Reply-To: <1459353210-20260-1-git-send-email-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

In NMI context, printk() messages are stored into per-CPU buffers to avoid
a possible deadlock.  They are normally flushed to the main ring buffer via
an IRQ work.  But the work is never called when the system calls panic() in
the very same NMI handler.

This patch tries to flush NMI buffers before the crash dump is generated.
In this case it does not risk a double release and bails out when the
logbuf_lock is already taken.  The aim is to get the messages into the main
ring buffer when possible.  It makes them better accessible in the vmcore.

Then the patch tries to flush the buffers second time when other CPUs are
down.  It might be more aggressive and reset logbuf_lock. The aim is to
get the messages available for the consequent kmsg_dump() and
console_flush_on_panic() calls.

The patch causes vprintk_emit() to be called even in NMI context again. But
we do not want to call consoles in this case.  They might use internal
locks and we could not prevent a deadlock easily.  We only want to have the
messages in the main ring buffer for crash dump and kmsg_dump().  The
consoles are explicitly called later by console_flush_on_panic().

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 include/linux/printk.h   |  4 ++++
 kernel/kexec_core.c      |  1 +
 kernel/panic.c           |  6 +++++-
 kernel/printk/internal.h |  2 ++
 kernel/printk/nmi.c      | 35 +++++++++++++++++++++++++++++++++++
 kernel/printk/printk.c   | 14 +++++++++++---
 6 files changed, 58 insertions(+), 4 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 51dd6b824fe2..2da06c2a63c3 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -123,15 +123,19 @@ void early_printk(const char *s, ...) { }
 #endif
 
 #ifdef CONFIG_PRINTK_NMI
+#define deferred_console_in_nmi() in_nmi()
 extern void printk_nmi_init(void);
 extern void printk_nmi_enter(void);
 extern void printk_nmi_exit(void);
 extern void printk_nmi_flush(void);
+extern void printk_nmi_flush_on_panic(void);
 #else
+#define deferred_console_in_nmi() 0
 static inline void printk_nmi_init(void) { }
 static inline void printk_nmi_enter(void) { }
 static inline void printk_nmi_exit(void) { }
 static inline void printk_nmi_flush(void) { }
+static inline void printk_nmi_flush_on_panic(void) { }
 #endif /* PRINTK_NMI */
 
 #ifdef CONFIG_PRINTK
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 8d34308ea449..1dc3fe8495e0 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -893,6 +893,7 @@ void crash_kexec(struct pt_regs *regs)
 	old_cpu = atomic_cmpxchg(&panic_cpu, PANIC_CPU_INVALID, this_cpu);
 	if (old_cpu = PANIC_CPU_INVALID) {
 		/* This is the 1st CPU which comes here, so go ahead. */
+		printk_nmi_flush_on_panic();
 		__crash_kexec(regs);
 
 		/*
diff --git a/kernel/panic.c b/kernel/panic.c
index 535c96510a44..8aa74497cc5a 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -160,8 +160,10 @@ void panic(const char *fmt, ...)
 	 *
 	 * Bypass the panic_cpu check and call __crash_kexec directly.
 	 */
-	if (!crash_kexec_post_notifiers)
+	if (!crash_kexec_post_notifiers) {
+		printk_nmi_flush_on_panic();
 		__crash_kexec(NULL);
+	}
 
 	/*
 	 * Note smp_send_stop is the usual smp shutdown function, which
@@ -176,6 +178,8 @@ void panic(const char *fmt, ...)
 	 */
 	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
 
+	/* Call flush even twice. It tries harder with a single online CPU */
+	printk_nmi_flush_on_panic();
 	kmsg_dump(KMSG_DUMP_PANIC);
 
 	/*
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 341bedccc065..7fd2838fa417 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -22,6 +22,8 @@ int __printf(1, 0) vprintk_default(const char *fmt, va_list args);
 
 #ifdef CONFIG_PRINTK_NMI
 
+extern raw_spinlock_t logbuf_lock;
+
 /*
  * printk() could not take logbuf_lock in NMI context. Instead,
  * it temporary stores the strings into a per-CPU buffer.
diff --git a/kernel/printk/nmi.c b/kernel/printk/nmi.c
index bf08557d7e3d..69b0c67ca2b2 100644
--- a/kernel/printk/nmi.c
+++ b/kernel/printk/nmi.c
@@ -194,6 +194,41 @@ void printk_nmi_flush(void)
 		__printk_nmi_flush(&per_cpu(nmi_print_seq, cpu).work);
 }
 
+/**
+ * printk_nmi_flush_on_panic - flush all per-cpu nmi buffers when the system
+ *	goes down.
+ *
+ * Similar to printk_nmi_flush() but it can be called even in NMI context when
+ * the system goes down. It does the best effort to get NMI messages into
+ * the main ring buffer.
+ *
+ * Note that it could try harder when there is only one CPU online.
+ */
+void printk_nmi_flush_on_panic(void)
+{
+	if (in_nmi()) {
+		/*
+		 * Make sure that we could access the main ring buffer.
+		 * Do not risk a double release when more CPUs are up.
+		 */
+		if (raw_spin_is_locked(&logbuf_lock)) {
+			if (num_online_cpus() > 1)
+				return;
+
+			debug_locks_off();
+			raw_spin_lock_init(&logbuf_lock);
+		}
+
+		/*
+		 * Flush the messages using the default printk handler
+		 * to store them into the main ring buffer.
+		 */
+		this_cpu_write(printk_func, vprintk_default);
+	}
+
+	printk_nmi_flush();
+}
+
 void __init printk_nmi_init(void)
 {
 	int cpu;
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index e38579d730f4..bf84df2eb3b6 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -245,7 +245,7 @@ __packed __aligned(4)
  * within the scheduler's rq lock. It must be released before calling
  * console_unlock() or anything else that might wake up a process.
  */
-static DEFINE_RAW_SPINLOCK(logbuf_lock);
+DEFINE_RAW_SPINLOCK(logbuf_lock);
 
 #ifdef CONFIG_PRINTK
 DECLARE_WAIT_QUEUE_HEAD(log_wait);
@@ -1764,8 +1764,16 @@ asmlinkage int vprintk_emit(int facility, int level,
 	lockdep_on();
 	local_irq_restore(flags);
 
-	/* If called from the scheduler, we can not call up(). */
-	if (!in_sched) {
+	/*
+	 * Console calls must be deferred when called from the scheduler.
+	 *
+	 * Many architectures never call vprintk_emit() in NMI context,
+	 * see vprintk_nmi(). The only exception is when the NMI buffers
+	 * are flushed on panic. In this case, the consoles are called
+	 * later explicitly only when crashdump does not work, see
+	 * console_flush_on_panic().
+	 */
+	if (!in_sched && !deferred_console_in_nmi()) {
 		lockdep_off();
 		/*
 		 * Try to acquire and then immediately release the console
-- 
1.8.5.6


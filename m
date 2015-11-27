From: Petr Mladek <pmladek@suse.com>
Date: Fri, 27 Nov 2015 11:09:30 +0000
Subject: [PATCH v2 3/5] printk/nmi: Try hard to print Oops message in NMI context
Message-Id: <1448622572-16900-4-git-send-email-pmladek@suse.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1448622572-16900-1-git-send-email-pmladek@suse.com>
In-Reply-To: <1448622572-16900-1-git-send-email-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Oops messages are important for debugging. We should try hard to get
them directly into the ring buffer and print them to the console
even in NMI context. This is problematic because the needed locks
might already be taken.

What we can do, though, is to zap all printk locks. We already do this
when a printk recursion is detected. This should be safe because
the system is crashing and there shouldn't be any printk caller
that would cause the deadlock.

We should also flush the printk NMI buffers when Oops begins.
bust_spinlocks() might sound like a bad location but
it already does several other printk-related operations.

Finally, we have to serialize the printing to do not mix backtraces
from different CPUs. A simple spinlock is enough. It has already been
used for this purpose, see the commit a9edc88093287183a ("x86/nmi:
Perform a safe NMI stack trace on all CPUs").

Signed-off-by: Petr Mladek <pmladek@suse.cz>
---
 arch/s390/mm/fault.c   | 1 +
 kernel/printk/nmi.c    | 6 +++++-
 kernel/printk/printk.c | 7 +++++++
 lib/bust_spinlocks.c   | 1 +
 lib/nmi_backtrace.c    | 8 ++++++++
 5 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index ec1a30d0d11a..6566344db263 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -80,6 +80,7 @@ void bust_spinlocks(int yes)
 {
 	if (yes) {
 		oops_in_progress = 1;
+		printk_nmi_flush();
 	} else {
 		int loglevel_save = console_loglevel;
 		console_unblank();
diff --git a/kernel/printk/nmi.c b/kernel/printk/nmi.c
index 05b4c09110f9..34ba760ae794 100644
--- a/kernel/printk/nmi.c
+++ b/kernel/printk/nmi.c
@@ -202,7 +202,11 @@ void __init printk_nmi_init(void)
 
 void printk_nmi_enter(void)
 {
-	this_cpu_write(printk_func, vprintk_nmi);
+	/*
+	 * We try hard to print the messages directly when Oops is in progress.
+	 */
+	if (!oops_in_progress)
+		this_cpu_write(printk_func, vprintk_nmi);
 }
 
 void printk_nmi_exit(void)
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 88641c74163d..e970b623ae26 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1705,6 +1705,13 @@ asmlinkage int vprintk_emit(int facility, int level,
 	}
 
 	lockdep_off();
+	/*
+	 * Messages are passed from NMI context using an extra buffer.
+	 * The only exception is when Oops is in progress. In this case
+	 * we try hard to get them out directly.
+	 */
+	if (unlikely(oops_in_progress && in_nmi()))
+		zap_locks();
 	raw_spin_lock(&logbuf_lock);
 	logbuf_cpu = this_cpu;
 
diff --git a/lib/bust_spinlocks.c b/lib/bust_spinlocks.c
index f8e0e5367398..7a98098b0fef 100644
--- a/lib/bust_spinlocks.c
+++ b/lib/bust_spinlocks.c
@@ -20,6 +20,7 @@ void __attribute__((weak)) bust_spinlocks(int yes)
 {
 	if (yes) {
 		++oops_in_progress;
+		printk_nmi_flush();
 	} else {
 #ifdef CONFIG_VT
 		unblank_screen();
diff --git a/lib/nmi_backtrace.c b/lib/nmi_backtrace.c
index 26caf51cc238..026e9f16e742 100644
--- a/lib/nmi_backtrace.c
+++ b/lib/nmi_backtrace.c
@@ -74,14 +74,22 @@ void nmi_trigger_all_cpu_backtrace(bool include_self,
 
 bool nmi_cpu_backtrace(struct pt_regs *regs)
 {
+	static arch_spinlock_t lock = __ARCH_SPIN_LOCK_UNLOCKED;
 	int cpu = smp_processor_id();
 
 	if (cpumask_test_cpu(cpu, to_cpumask(backtrace_mask))) {
+		/* Serialize backtraces when printing directly. */
+		if (unlikely(oops_in_progress))
+			arch_spin_lock(&lock);
+
 		pr_warn("NMI backtrace for cpu %d\n", cpu);
 		if (regs)
 			show_regs(regs);
 		else
 			dump_stack();
+
+		if (unlikely(oops_in_progress))
+			arch_spin_unlock(&lock);
 		cpumask_clear_cpu(cpu, to_cpumask(backtrace_mask));
 		return true;
 	}
-- 
1.8.5.6


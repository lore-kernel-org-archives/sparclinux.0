From: Dave Kleikamp <dave.kleikamp@oracle.com>
Date: Mon, 29 Dec 2014 23:23:10 +0000
Subject: [PATCH] sparc64: fatal trap should stop all cpus
Message-Id: <54A1E25E.3020806@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

"echo c > /proc/sysrq-trigger" does not result in a system crash. There
are two problems. One is that the trap handler ignores the global
variable, panic_on_oops. The other is that smp_send_stop() is a no-op
which leaves the other cpus running normally when one cpu panics.

Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
---
 arch/sparc/kernel/smp_64.c   |   12 +++++++++---
 arch/sparc/kernel/traps_64.c |    2 ++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index 32d4b3b..37d5789 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -1406,11 +1406,17 @@ void __irq_entry smp_receive_signal_client(int irq, struct pt_regs *regs)
 	scheduler_ipi();
 }
 
-/* This is a nop because we capture all other cpus
- * anyways when making the PROM active.
- */
+void stop_this_cpu(void *dummy)
+{
+	set_cpu_online(smp_processor_id(), false);
+
+	local_irq_disable();
+	while (1) ;
+}
+
 void smp_send_stop(void)
 {
+	smp_call_function(stop_this_cpu, NULL, 0);
 }
 
 /**
diff --git a/arch/sparc/kernel/traps_64.c b/arch/sparc/kernel/traps_64.c
index e7ecf15..720be08 100644
--- a/arch/sparc/kernel/traps_64.c
+++ b/arch/sparc/kernel/traps_64.c
@@ -2408,6 +2408,8 @@ void die_if_kernel(char *str, struct pt_regs *regs)
 		}
 		user_instruction_dump ((unsigned int __user *) regs->tpc);
 	}
+	if (panic_on_oops)
+		panic("Fatal exception");
 	if (regs->tstate & TSTATE_PRIV)
 		do_exit(SIGKILL);
 	do_exit(SIGSEGV);
-- 
1.7.1


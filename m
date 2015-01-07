From: Dave Kleikamp <dave.kleikamp@oracle.com>
Date: Wed, 07 Jan 2015 00:31:39 +0000
Subject: [PATCH V3] sparc64: fatal trap should stop all cpus
Message-Id: <54AC7E6B.1020709@oracle.com>
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
 arch/sparc/kernel/smp_64.c   |   27 ++++++++++++++++++++++++---
 arch/sparc/kernel/traps_64.c |    2 ++
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index da6f1a7..61139d9 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -1406,11 +1406,32 @@ void __irq_entry smp_receive_signal_client(int irq, struct pt_regs *regs)
 	scheduler_ipi();
 }
 
-/* This is a nop because we capture all other cpus
- * anyways when making the PROM active.
- */
+static void stop_this_cpu(void *dummy)
+{
+	prom_stopself();
+}
+
 void smp_send_stop(void)
 {
+	int cpu;
+
+	if (tlb_type = hypervisor) {
+		for_each_online_cpu(cpu) {
+			if (cpu = smp_processor_id())
+				continue;
+#ifdef CONFIG_SUN_LDOMS
+			if (ldom_domaining_enabled) {
+				unsigned long hv_err;
+				hv_err = sun4v_cpu_stop(cpu);
+				if (hv_err)
+					printk(KERN_ERR "sun4v_cpu_stop() "
+					       "failed err=%lu\n", hv_err);
+			} else
+#endif
+				prom_stopcpu_cpuid(cpu);
+		}
+	} else
+		smp_call_function(stop_this_cpu, NULL, 0);
 }
 
 /**
diff --git a/arch/sparc/kernel/traps_64.c b/arch/sparc/kernel/traps_64.c
index 981a769..5555dd6 100644
--- a/arch/sparc/kernel/traps_64.c
+++ b/arch/sparc/kernel/traps_64.c
@@ -2427,6 +2427,8 @@ void __noreturn die_if_kernel(char *str, struct pt_regs *regs)
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


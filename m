From: Dave Kleikamp <dave.kleikamp@oracle.com>
Date: Mon, 05 Jan 2015 23:17:23 +0000
Subject: [PATCH V2] sparc64: fatal trap should stop all cpus
Message-Id: <54AB1B83.6070800@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 01/04/2015 10:58 PM, David Miller wrote:

> However I also have to wonder if we should be doing a hypervisor
> or firmware CPU stop call in that handler.
> 
> That's what the XEN x86 implementation does.

That probably makes sense. I had created the patch a while back and
had forgotten about it. I don't remember exactly what I followed as
an example.

> It should logically do something like:
> 
> 	if (tlb_type = hypervisor) {
> 		if (ldom_domaining_enabled)
> 			sun4v_stop_cpu(cpuid);
> 		else
> 			prom_stopcpu_cpuid(cpuid);
> 	} else
> 		smp_call_function(wrapper_around_prom_stopself, NULL, 0);
> 
The below patch works with the hypervisor. I'm not sure if the calls
to set_cpu_online are really needed, but I left them in for now.


"echo c > /proc/sysrq-trigger" does not result in a system crash. There
are two problems. One is that the trap handler ignores the global
variable, panic_on_oops. The other is that smp_send_stop() is a no-op
which leaves the other cpus running normally when one cpu panics.

Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
---
 arch/sparc/kernel/smp_64.c   |   30 +++++++++++++++++++++++++++---
 arch/sparc/kernel/traps_64.c |    2 ++
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index da6f1a7..0064e3f 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -1406,11 +1406,35 @@ void __irq_entry smp_receive_signal_client(int irq, struct pt_regs *regs)
 	scheduler_ipi();
 }
 
-/* This is a nop because we capture all other cpus
- * anyways when making the PROM active.
- */
+static void stop_this_cpu(void *dummy)
+{
+	set_cpu_online(smp_processor_id(), false);
+
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
+			set_cpu_online(cpu, false);
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


From: Frans Pop <elendil@planet.nl>
Date: Sat, 06 Feb 2010 18:16:43 +0000
Subject: Re: [PATCH 09/16 v2] sparc: remove trailing space in messages
Message-Id: <201002061916.44473.elendil@planet.nl>
List-Id: <sparclinux.vger.kernel.org>
References: <201002061844.45212.elendil@planet.nl> <1265478443-31072-9-git-send-email-elendil@planet.nl>
In-Reply-To: <1265478443-31072-9-git-send-email-elendil@planet.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: sparclinux@vger.kernel.org, "David S. Miller" <davem@davemloft.net>

Also fixes a typo in one message.

Signed-off-by: Frans Pop <elendil@planet.nl>
Cc: sparclinux@vger.kernel.org
Cc: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/leon_kernel.c |    2 +-
 arch/sparc/kernel/leon_smp.c    |    4 ++--
 arch/sparc/kernel/sun4d_smp.c   |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

Change relative to v1:
- spelling correction in first chunk (with thanks to Josip Rodin)

P.S. I like the "whirrr, whirrr, whirrrrrrrrr..." :-)

diff --git a/arch/sparc/kernel/leon_kernel.c b/arch/sparc/kernel/leon_kernel.c
index 87f1760..771072b 100644
--- a/arch/sparc/kernel/leon_kernel.c
+++ b/arch/sparc/kernel/leon_kernel.c
@@ -124,7 +124,7 @@ void __init leon_init_timers(irq_handler_t counter_fn)
 
 		if (!(LEON3_BYPASS_LOAD_PA(&leon3_gptimer_regs->config) &
 		      (1<<LEON3_GPTIMER_SEPIRQ))) {
-			prom_printf("irq timer not configured with seperate irqs \n");
+			prom_printf("irq timer not configured with separate irqs\n");
 			BUG();
 		}
 
diff --git a/arch/sparc/kernel/leon_smp.c b/arch/sparc/kernel/leon_smp.c
index 05c0dad..8578757 100644
--- a/arch/sparc/kernel/leon_smp.c
+++ b/arch/sparc/kernel/leon_smp.c
@@ -177,7 +177,7 @@ void __init leon_boot_cpus(void)
 	int nrcpu = leon_smp_nrcpus();
 	int me = smp_processor_id();
 
-	printk(KERN_INFO "%d:(%d:%d) cpus mpirq at 0x%x \n", (unsigned int)me,
+	printk(KERN_INFO "%d:(%d:%d) cpus mpirq at 0x%x\n", (unsigned int)me,
 	       (unsigned int)nrcpu, (unsigned int)NR_CPUS,
 	       (unsigned int)&(leon3_irqctrl_regs->mpstatus));
 
@@ -226,7 +226,7 @@ int __cpuinit leon_boot_one_cpu(int i)
 			break;
 		udelay(200);
 	}
-	printk(KERN_INFO "Started CPU %d \n", (unsigned int)i);
+	printk(KERN_INFO "Started CPU %d\n", (unsigned int)i);
 
 	if (!(cpu_callin_map[i])) {
 		printk(KERN_ERR "Processor %d is stuck.\n", i);
diff --git a/arch/sparc/kernel/sun4d_smp.c b/arch/sparc/kernel/sun4d_smp.c
index 68791ca..482f2ab 100644
--- a/arch/sparc/kernel/sun4d_smp.c
+++ b/arch/sparc/kernel/sun4d_smp.c
@@ -194,7 +194,7 @@ int __cpuinit smp4d_boot_one_cpu(int i)
 			smp_penguin_ctable.reg_size = 0;
 
 			/* whirrr, whirrr, whirrrrrrrrr... */
-			SMP_PRINTK(("Starting CPU %d at %p \n", i, entry));
+			SMP_PRINTK(("Starting CPU %d at %p\n", i, entry));
 			local_flush_cache_all();
 			prom_startcpu(cpu_node,
 				      &smp_penguin_ctable, 0, (char *)entry);
-- 
1.6.6.1


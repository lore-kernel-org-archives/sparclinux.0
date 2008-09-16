From: David Miller <davem@davemloft.net>
Date: Tue, 16 Sep 2008 18:46:21 +0000
Subject: Re: psycho_irq_build: Wacky INO [3c]
Message-Id: <20080916.114621.143043583.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0809101731591.28457@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0809101731591.28457@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@ut.ee>
Date: Mon, 15 Sep 2008 00:38:27 +0300 (EEST)

> > Something is wrong with some debugging feature.
> > 
> > Please turn off CONFIG_STACK_DEBUG and let's see if that makes
> > the problem go away.
> 
> Turned of that and two more debugging options (sysrq check and something 
> else) and it started booting up to the same oops that I already 
> reported.

Ok, the patch below should fix the OOPS with the debugging
features enabled.  Please give it a test and let me know if
it works.

Thanks.

sparc64: Fix SMP bootup with CONFIG_STACK_DEBUG or ftrace.

Based upon a report by Meelis Roos.

Any function call can try to access the current
thread register via the _mcount hooks when the kernel
is built with -pg (via ftrace or STACK_DEBUG).

That can't be setup properly very early on during
the bootup of other cpus for sun4u and some early
sun4v systems.

So add notrace markers to these specific functions, so
that _mcount doesn't get invoked too early.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc64/kernel/irq.c   |    5 +++--
 arch/sparc64/kernel/traps.c |    3 ++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/sparc64/kernel/irq.c b/arch/sparc64/kernel/irq.c
index 2396388..7495bc7 100644
--- a/arch/sparc64/kernel/irq.c
+++ b/arch/sparc64/kernel/irq.c
@@ -7,6 +7,7 @@
 
 #include <linux/module.h>
 #include <linux/sched.h>
+#include <linux/linkage.h>
 #include <linux/ptrace.h>
 #include <linux/errno.h>
 #include <linux/kernel_stat.h>
@@ -866,7 +867,7 @@ static void kill_prom_timer(void)
 	: "g1", "g2");
 }
 
-void init_irqwork_curcpu(void)
+void notrace init_irqwork_curcpu(void)
 {
 	int cpu = hard_smp_processor_id();
 
@@ -897,7 +898,7 @@ static void __cpuinit register_one_mondo(unsigned long paddr, unsigned long type
 	}
 }
 
-void __cpuinit sun4v_register_mondo_queues(int this_cpu)
+void __cpuinit notrace sun4v_register_mondo_queues(int this_cpu)
 {
 	struct trap_per_cpu *tb = &trap_block[this_cpu];
 
diff --git a/arch/sparc64/kernel/traps.c b/arch/sparc64/kernel/traps.c
index 3d92412..c824df1 100644
--- a/arch/sparc64/kernel/traps.c
+++ b/arch/sparc64/kernel/traps.c
@@ -10,6 +10,7 @@
 
 #include <linux/module.h>
 #include <linux/sched.h>
+#include <linux/linkage.h>
 #include <linux/kernel.h>
 #include <linux/signal.h>
 #include <linux/smp.h>
@@ -2453,7 +2454,7 @@ struct trap_per_cpu trap_block[NR_CPUS];
 /* This can get invoked before sched_init() so play it super safe
  * and use hard_smp_processor_id().
  */
-void init_cur_cpu_trap(struct thread_info *t)
+void notrace init_cur_cpu_trap(struct thread_info *t)
 {
 	int cpu = hard_smp_processor_id();
 	struct trap_per_cpu *p = &trap_block[cpu];
-- 
1.5.6.5


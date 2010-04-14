From: David Miller <davem@davemloft.net>
Date: Wed, 14 Apr 2010 09:04:49 +0000
Subject: Re: [PATCH 7/7] sparc64: Add function graph tracer support.
Message-Id: <20100414.020449.01759787.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100412.234300.212396783.davem@davemloft.net>
In-Reply-To: <20100412.234300.212396783.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Tue, 13 Apr 2010 18:59:31 -0700 (PDT)

> From: David Miller <davem@davemloft.net>
> Date: Tue, 13 Apr 2010 16:56:39 -0700 (PDT)
> 
>> I'll dig further.
> 
> Ok Frederic, I think I figured it out.  We only save 128 bytes
> of stack space in the mcount stubs, but that's not enough.

Ok, one more fix after this one.

The other problem I seem to be hitting is that we overrun the main
kernel stack with tracing enabled.

Let's run NMIs on the hardirq stack to abate this problem for now,
patch below which I'll also push to sparc-2.6

The only remaining issue I have is that one of the cpus can get stuck
in the scheduler load balancer.  Whatever NOHZ cpu gets selected to
balance idle domains can get stuck because the time it takes to
rebalance domains with tracing enabled exceeds the interval of the
scheduler tick, so it just balances endlessly and never makes any
forward progress from the initial timer interrupt.

I think I might jack up the scheduler domain min intervals to make
that less of an issue, but long term this expensive set of
calculations needs to be fixed.  I have made Peter Z. aware of this
and hopefully between he and myself we maybe can come up with some
better fix long-term.

--------------------
sparc64: Run NMIs on the hardirq stack.

Otherwise we can overflow the main stack with the function tracer
enabled.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/irq_64.c |   19 +------------------
 arch/sparc/kernel/kstack.h |   19 +++++++++++++++++++
 arch/sparc/kernel/nmi.c    |    7 +++++++
 3 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/arch/sparc/kernel/irq_64.c b/arch/sparc/kernel/irq_64.c
index 2b04c72..830d70a 100644
--- a/arch/sparc/kernel/irq_64.c
+++ b/arch/sparc/kernel/irq_64.c
@@ -47,6 +47,7 @@
 
 #include "entry.h"
 #include "cpumap.h"
+#include "kstack.h"
 
 #define NUM_IVECS	(IMAP_INR + 1)
 
@@ -713,24 +714,6 @@ void ack_bad_irq(unsigned int virt_irq)
 void *hardirq_stack[NR_CPUS];
 void *softirq_stack[NR_CPUS];
 
-static __attribute__((always_inline)) void *set_hardirq_stack(void)
-{
-	void *orig_sp, *sp = hardirq_stack[smp_processor_id()];
-
-	__asm__ __volatile__("mov %%sp, %0" : "=r" (orig_sp));
-	if (orig_sp < sp ||
-	    orig_sp > (sp + THREAD_SIZE)) {
-		sp += THREAD_SIZE - 192 - STACK_BIAS;
-		__asm__ __volatile__("mov %0, %%sp" : : "r" (sp));
-	}
-
-	return orig_sp;
-}
-static __attribute__((always_inline)) void restore_hardirq_stack(void *orig_sp)
-{
-	__asm__ __volatile__("mov %0, %%sp" : : "r" (orig_sp));
-}
-
 void __irq_entry handler_irq(int irq, struct pt_regs *regs)
 {
 	unsigned long pstate, bucket_pa;
diff --git a/arch/sparc/kernel/kstack.h b/arch/sparc/kernel/kstack.h
index 5247283..53dfb92 100644
--- a/arch/sparc/kernel/kstack.h
+++ b/arch/sparc/kernel/kstack.h
@@ -61,4 +61,23 @@ check_magic:
 
 }
 
+static inline __attribute__((always_inline)) void *set_hardirq_stack(void)
+{
+	void *orig_sp, *sp = hardirq_stack[smp_processor_id()];
+
+	__asm__ __volatile__("mov %%sp, %0" : "=r" (orig_sp));
+	if (orig_sp < sp ||
+	    orig_sp > (sp + THREAD_SIZE)) {
+		sp += THREAD_SIZE - 192 - STACK_BIAS;
+		__asm__ __volatile__("mov %0, %%sp" : : "r" (sp));
+	}
+
+	return orig_sp;
+}
+
+static inline __attribute__((always_inline)) void restore_hardirq_stack(void *orig_sp)
+{
+	__asm__ __volatile__("mov %0, %%sp" : : "r" (orig_sp));
+}
+
 #endif /* _KSTACK_H */
diff --git a/arch/sparc/kernel/nmi.c b/arch/sparc/kernel/nmi.c
index 75a3d1a..a4bd7ba 100644
--- a/arch/sparc/kernel/nmi.c
+++ b/arch/sparc/kernel/nmi.c
@@ -23,6 +23,8 @@
 #include <asm/ptrace.h>
 #include <asm/pcr.h>
 
+#include "kstack.h"
+
 /* We don't have a real NMI on sparc64, but we can fake one
  * up using profiling counter overflow interrupts and interrupt
  * levels.
@@ -92,6 +94,7 @@ static void die_nmi(const char *str, struct pt_regs *regs, int do_panic)
 notrace __kprobes void perfctr_irq(int irq, struct pt_regs *regs)
 {
 	unsigned int sum, touched = 0;
+	void *orig_sp;
 
 	clear_softint(1 << irq);
 
@@ -99,6 +102,8 @@ notrace __kprobes void perfctr_irq(int irq, struct pt_regs *regs)
 
 	nmi_enter();
 
+	orig_sp = set_hardirq_stack();
+
 	if (notify_die(DIE_NMI, "nmi", regs, 0,
 		       pt_regs_trap_type(regs), SIGINT) = NOTIFY_STOP)
 		touched = 1;
@@ -124,6 +129,8 @@ notrace __kprobes void perfctr_irq(int irq, struct pt_regs *regs)
 		pcr_ops->write(pcr_enable);
 	}
 
+	restore_hardirq_stack(orig_sp);
+
 	nmi_exit();
 }
 
-- 
1.7.0.4


From: "David S. Miller" <davem@davemloft.net>
Date: Fri, 24 Sep 2004 20:44:53 +0000
Subject: Re: Ultra 2 Enterprise: All 2.6.xx SMP kernels hardlock
Message-Id: <20040924134453.60c1194b.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <703d4eaa04092018404389859@mail.gmail.com>
In-Reply-To: <703d4eaa04092018404389859@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Jason, see if this patch gets your SB100 working again.
Thanks.

=== arch/sparc64/kernel/time.c 1.60 vs edited ==--- 1.60/arch/sparc64/kernel/time.c	2004-09-10 17:51:01 -07:00
+++ edited/arch/sparc64/kernel/time.c	2004-09-24 12:41:11 -07:00
@@ -910,10 +910,10 @@
 }
 
 /* This is gets the master TICK_INT timer going. */
-static unsigned long sparc64_init_timers(irqreturn_t (*cfunc)(int, void *, struct pt_regs *))
+static unsigned long sparc64_init_timers(void)
 {
-	unsigned long pstate, clock;
-	int node, err;
+	unsigned long clock;
+	int node;
 #ifdef CONFIG_SMP
 	extern void smp_tick_init(void);
 #endif
@@ -946,6 +946,14 @@
 	smp_tick_init();
 #endif
 
+	return clock;
+}
+
+static void sparc64_start_timers(irqreturn_t (*cfunc)(int, void *, struct pt_regs *))
+{
+	unsigned long pstate;
+	int err;
+
 	/* Register IRQ handler. */
 	err = request_irq(build_irq(0, 0, 0UL, 0UL), cfunc, SA_STATIC_ALLOC,
 			  "timer", NULL);
@@ -971,8 +979,6 @@
 			     : "r" (pstate));
 
 	local_irq_enable();
-
-	return clock;
 }
 
 struct freq_table {
@@ -1036,10 +1042,15 @@
 #define SPARC64_NSEC_PER_CYC_SHIFT	30UL
 void __init time_init(void)
 {
-	unsigned long clock = sparc64_init_timers(timer_interrupt);
+	unsigned long clock = sparc64_init_timers();
 
 	sparc64_cpu_interpolator.frequency = clock;
 	register_time_interpolator(&sparc64_cpu_interpolator);
+
+	/* Now that the interpolator is registered, it is
+	 * safe to start the timer ticking.
+	 */
+	sparc64_start_timers(timer_interrupt);
 
 	timer_ticks_per_nsec_quotient  		(((NSEC_PER_SEC << SPARC64_NSEC_PER_CYC_SHIFT) +

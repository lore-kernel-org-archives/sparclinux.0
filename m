From: Rusty Russell <rusty@rustcorp.com.au>
Date: Thu, 16 Apr 2015 04:55:32 +0000
Subject: [PATCH] cpumask: remove __first_cpu / __next_cpu
Message-Id: <87k2xcr8cr.fsf@rustcorp.com.au>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>

[ Final grep before push to Linus revealed sparc used these directly,
  please Ack.  Against my cpumask-next tree. ]

They were for use by the deprecated first_cpu() and next_cpu() wrappers,
but sparc used them directly.

They're now replaced by cpumask_first / cpumask_next.  And __next_cpu_nr
is completely obsolete.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff --git a/arch/sparc/kernel/time_32.c b/arch/sparc/kernel/time_32.c
index 18147a5523d9..8caf45ee81d9 100644
--- a/arch/sparc/kernel/time_32.c
+++ b/arch/sparc/kernel/time_32.c
@@ -194,7 +194,7 @@ static __init int setup_timer_cs(void)
 static void percpu_ce_setup(enum clock_event_mode mode,
 			struct clock_event_device *evt)
 {
-	int cpu = __first_cpu(evt->cpumask);
+	int cpu = cpumask_first(evt->cpumask);
 
 	switch (mode) {
 		case CLOCK_EVT_MODE_PERIODIC:
@@ -214,7 +214,7 @@ static void percpu_ce_setup(enum clock_event_mode mode,
 static int percpu_ce_set_next_event(unsigned long delta,
 				    struct clock_event_device *evt)
 {
-	int cpu = __first_cpu(evt->cpumask);
+	int cpu = cpumask_first(evt->cpumask);
 	unsigned int next = (unsigned int)delta;
 
 	sparc_config.load_profile_irq(cpu, next);
diff --git a/lib/cpumask.c b/lib/cpumask.c
index ba379d12bb57..75379b759d3f 100644
--- a/lib/cpumask.c
+++ b/lib/cpumask.c
@@ -5,27 +5,6 @@
 #include <linux/export.h>
 #include <linux/bootmem.h>
 
-int __first_cpu(const cpumask_t *srcp)
-{
-	return min_t(int, NR_CPUS, find_first_bit(srcp->bits, NR_CPUS));
-}
-EXPORT_SYMBOL(__first_cpu);
-
-int __next_cpu(int n, const cpumask_t *srcp)
-{
-	return min_t(int, NR_CPUS, find_next_bit(srcp->bits, NR_CPUS, n+1));
-}
-EXPORT_SYMBOL(__next_cpu);
-
-#if NR_CPUS > 64
-int __next_cpu_nr(int n, const cpumask_t *srcp)
-{
-	return min_t(int, nr_cpu_ids,
-				find_next_bit(srcp->bits, nr_cpu_ids, n+1));
-}
-EXPORT_SYMBOL(__next_cpu_nr);
-#endif
-
 /**
  * cpumask_next_and - get the next cpu in *src1p & *src2p
  * @n: the cpu prior to the place to search (ie. return will be > @n)

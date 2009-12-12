From: David Miller <davem@davemloft.net>
Date: Sat, 12 Dec 2009 06:55:57 +0000
Subject: [PATCH 9/10]: sparc64: Use clock{source,events}_calc_mult_shift().
Message-Id: <20091211.225557.115913303.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/time_64.c |   24 ++----------------------
 1 files changed, 2 insertions(+), 22 deletions(-)

diff --git a/arch/sparc/kernel/time_64.c b/arch/sparc/kernel/time_64.c
index 63f73ae..c310875 100644
--- a/arch/sparc/kernel/time_64.c
+++ b/arch/sparc/kernel/time_64.c
@@ -774,26 +774,9 @@ void __devinit setup_sparc64_timer(void)
 static struct clocksource clocksource_tick = {
 	.rating		= 100,
 	.mask		= CLOCKSOURCE_MASK(64),
-	.shift		= 16,
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
-static void __init setup_clockevent_multiplier(unsigned long hz)
-{
-	unsigned long mult, shift = 32;
-
-	while (1) {
-		mult = div_sc(hz, NSEC_PER_SEC, shift);
-		if (mult && (mult >> 32UL) = 0UL)
-			break;
-
-		shift--;
-	}
-
-	sparc64_clockevent.shift = shift;
-	sparc64_clockevent.mult = mult;
-}
-
 static unsigned long tb_ticks_per_usec __read_mostly;
 
 void __delay(unsigned long loops)
@@ -828,9 +811,7 @@ void __init time_init(void)
 		clocksource_hz2mult(freq, SPARC64_NSEC_PER_CYC_SHIFT);
 
 	clocksource_tick.name = tick_ops->name;
-	clocksource_tick.mult -		clocksource_hz2mult(freq,
-				    clocksource_tick.shift);
+	clocksource_calc_mult_shift(&clocksource_tick, freq, 4);
 	clocksource_tick.read = clocksource_tick_read;
 
 	printk("clocksource: mult[%x] shift[%d]\n",
@@ -839,8 +820,7 @@ void __init time_init(void)
 	clocksource_register(&clocksource_tick);
 
 	sparc64_clockevent.name = tick_ops->name;
-
-	setup_clockevent_multiplier(freq);
+	clockevents_calc_mult_shift(&sparc64_clockevent, freq, 4);
 
 	sparc64_clockevent.max_delta_ns  		clockevent_delta2ns(0x7fffffffffffffffUL, &sparc64_clockevent);
-- 
1.6.5


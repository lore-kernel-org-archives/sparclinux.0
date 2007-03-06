From: David Miller <davem@davemloft.net>
Date: Tue, 06 Mar 2007 05:37:52 +0000
Subject: [PATCH 1/4]: [SPARC64]: Synchronize RTC clock via timer just like
Message-Id: <20070305.213752.108983663.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org


From 8c59ccd3f9906c95a62b3157285093d203881ae4 Mon Sep 17 00:00:00 2001
From: David S. Miller <davem@sunset.davemloft.net>
Date: Thu, 22 Feb 2007 04:16:21 -0800
Subject: [PATCH] [SPARC64]: Synchronize RTC clock via timer just like x86.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc64/kernel/time.c |   66 ++++++++++++++++++++++++++++++++------------
 1 files changed, 48 insertions(+), 18 deletions(-)

diff --git a/arch/sparc64/kernel/time.c b/arch/sparc64/kernel/time.c
index f84da4f..d457079 100644
--- a/arch/sparc64/kernel/time.c
+++ b/arch/sparc64/kernel/time.c
@@ -435,22 +435,56 @@ static unsigned long timer_ticks_per_nsec_quotient __read_mostly;
 
 #define TICK_SIZE (tick_nsec / 1000)
 
-static inline void timer_check_rtc(void)
+#define USEC_AFTER	500000
+#define USEC_BEFORE	500000
+
+static void sync_cmos_clock(unsigned long dummy);
+
+static DEFINE_TIMER(sync_cmos_timer, sync_cmos_clock, 0, 0);
+
+static void sync_cmos_clock(unsigned long dummy)
 {
-	/* last time the cmos clock got updated */
-	static long last_rtc_update;
-
-	/* Determine when to update the Mostek clock. */
-	if (ntp_synced() &&
-	    xtime.tv_sec > last_rtc_update + 660 &&
-	    (xtime.tv_nsec / 1000) >= 500000 - ((unsigned) TICK_SIZE) / 2 &&
-	    (xtime.tv_nsec / 1000) <= 500000 + ((unsigned) TICK_SIZE) / 2) {
-		if (set_rtc_mmss(xtime.tv_sec) = 0)
-			last_rtc_update = xtime.tv_sec;
-		else
-			last_rtc_update = xtime.tv_sec - 600;
-			/* do it again in 60 s */
+	struct timeval now, next;
+	int fail = 1;
+
+	/*
+	 * If we have an externally synchronized Linux clock, then update
+	 * CMOS clock accordingly every ~11 minutes. Set_rtc_mmss() has to be
+	 * called as close as possible to 500 ms before the new second starts.
+	 * This code is run on a timer.  If the clock is set, that timer
+	 * may not expire at the correct time.  Thus, we adjust...
+	 */
+	if (!ntp_synced())
+		/*
+		 * Not synced, exit, do not restart a timer (if one is
+		 * running, let it run out).
+		 */
+		return;
+
+	do_gettimeofday(&now);
+	if (now.tv_usec >= USEC_AFTER - ((unsigned) TICK_SIZE) / 2 &&
+	    now.tv_usec <= USEC_BEFORE + ((unsigned) TICK_SIZE) / 2)
+		fail = set_rtc_mmss(now.tv_sec);
+
+	next.tv_usec = USEC_AFTER - now.tv_usec;
+	if (next.tv_usec <= 0)
+		next.tv_usec += USEC_PER_SEC;
+
+	if (!fail)
+		next.tv_sec = 659;
+	else
+		next.tv_sec = 0;
+
+	if (next.tv_usec >= USEC_PER_SEC) {
+		next.tv_sec++;
+		next.tv_usec -= USEC_PER_SEC;
 	}
+	mod_timer(&sync_cmos_timer, jiffies + timeval_to_jiffies(&next));
+}
+
+void notify_arch_cmos_timer(void)
+{
+	mod_timer(&sync_cmos_timer, jiffies + 1);
 }
 
 irqreturn_t timer_interrupt(int irq, void *dev_id)
@@ -483,8 +517,6 @@ irqreturn_t timer_interrupt(int irq, void *dev_id)
 				     : "r" (pstate));
 	} while (time_after_eq(ticks, compare));
 
-	timer_check_rtc();
-
 	write_sequnlock(&xtime_lock);
 
 	return IRQ_HANDLED;
@@ -497,8 +529,6 @@ void timer_tick_interrupt(struct pt_regs *regs)
 
 	do_timer(1);
 
-	timer_check_rtc();
-
 	write_sequnlock(&xtime_lock);
 }
 #endif
-- 
1.5.0


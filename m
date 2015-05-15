From: Xunlei Pang <xlpang@126.com>
Date: Fri, 15 May 2015 09:31:32 +0000
Subject: [PATCH 2/2] sparc: time: Provide update_persistent_clock64()
Message-Id: <1431682292-29732-2-git-send-email-xlpang@126.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1431682292-29732-1-git-send-email-xlpang@126.com>
In-Reply-To: <1431682292-29732-1-git-send-email-xlpang@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>, John Stultz <john.stultz@linaro.org>, Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Xunlei Pang <pang.xunlei@linaro.org>

From: Xunlei Pang <pang.xunlei@linaro.org>

As part of addressing "y2038 problem" for in-kernel uses, this patch
converts update_persistent_clock() to update_persistent_clock64()
using timespec64 for both 32-bit and 64-bit sparc, since timekeeping
had already supported update_persistent_clock64().

Signed-off-by: Xunlei Pang <pang.xunlei@linaro.org>
---
 arch/sparc/kernel/time_32.c | 27 ++++++++++-----------------
 arch/sparc/kernel/time_64.c |  2 +-
 2 files changed, 11 insertions(+), 18 deletions(-)

diff --git a/arch/sparc/kernel/time_32.c b/arch/sparc/kernel/time_32.c
index 18147a5..47b295f 100644
--- a/arch/sparc/kernel/time_32.c
+++ b/arch/sparc/kernel/time_32.c
@@ -65,8 +65,6 @@ DEFINE_PER_CPU(struct clock_event_device, sparc32_clockevent);
 DEFINE_SPINLOCK(rtc_lock);
 EXPORT_SYMBOL(rtc_lock);
 
-static int set_rtc_mmss(unsigned long);
-
 unsigned long profile_pc(struct pt_regs *regs)
 {
 	extern char __copy_user_begin[], __copy_user_end[];
@@ -87,9 +85,17 @@ EXPORT_SYMBOL(profile_pc);
 
 volatile u32 __iomem *master_l10_counter;
 
-int update_persistent_clock(struct timespec now)
+int update_persistent_clock64(struct timespec64 now)
 {
-	return set_rtc_mmss(now.tv_sec);
+	struct rtc_device *rtc = rtc_class_open("rtc0");
+	int err = -1;
+
+	if (rtc) {
+		err = rtc_set_mmss(rtc, now.tv_sec);
+		rtc_class_close(rtc);
+	}
+
+	return err;
 }
 
 irqreturn_t notrace timer_interrupt(int dummy, void *dev_id)
@@ -362,16 +368,3 @@ void __init time_init(void)
 		sbus_time_init();
 }
 
-
-static int set_rtc_mmss(unsigned long secs)
-{
-	struct rtc_device *rtc = rtc_class_open("rtc0");
-	int err = -1;
-
-	if (rtc) {
-		err = rtc_set_mmss(rtc, secs);
-		rtc_class_close(rtc);
-	}
-
-	return err;
-}
diff --git a/arch/sparc/kernel/time_64.c b/arch/sparc/kernel/time_64.c
index edbbeb1..7c8f819 100644
--- a/arch/sparc/kernel/time_64.c
+++ b/arch/sparc/kernel/time_64.c
@@ -394,7 +394,7 @@ static struct sparc64_tick_ops hbtick_operations __read_mostly = {
 
 static unsigned long timer_ticks_per_nsec_quotient __read_mostly;
 
-int update_persistent_clock(struct timespec now)
+int update_persistent_clock64(struct timespec64 now)
 {
 	struct rtc_device *rtc = rtc_class_open("rtc0");
 	int err = -1;
-- 
1.9.1



From: David Miller <davem@davemloft.net>
Date: Fri, 29 Aug 2008 06:09:46 +0000
Subject: [PATCH 10/12]: sparc64: Use generic sun4v RTC driver.
Message-Id: <20080828.230946.133295698.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc64: Use generic sun4v RTC driver.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc64/Kconfig       |    1 +
 arch/sparc64/kernel/time.c |   76 +------------------------------------------
 2 files changed, 3 insertions(+), 74 deletions(-)

diff --git a/arch/sparc64/Kconfig b/arch/sparc64/Kconfig
index a4ec899..16149ce 100644
--- a/arch/sparc64/Kconfig
+++ b/arch/sparc64/Kconfig
@@ -23,6 +23,7 @@ config SPARC64
 	select RTC_DRV_M48T59
 	select RTC_DRV_CMOS
 	select RTC_DRV_BQ4802
+	select RTC_DRV_SUN4V
 
 config GENERIC_TIME
 	bool
diff --git a/arch/sparc64/kernel/time.c b/arch/sparc64/kernel/time.c
index 5e199a0..1b7a52a 100644
--- a/arch/sparc64/kernel/time.c
+++ b/arch/sparc64/kernel/time.c
@@ -424,48 +424,6 @@ static int starfire_set_time(u32 val)
 	return 0;
 }
 
-static u32 hypervisor_get_time(void)
-{
-	unsigned long ret, time;
-	int retries = 10000;
-
-retry:
-	ret = sun4v_tod_get(&time);
-	if (ret = HV_EOK)
-		return time;
-	if (ret = HV_EWOULDBLOCK) {
-		if (--retries > 0) {
-			udelay(100);
-			goto retry;
-		}
-		printk(KERN_WARNING "SUN4V: tod_get() timed out.\n");
-		return 0;
-	}
-	printk(KERN_WARNING "SUN4V: tod_get() not supported.\n");
-	return 0;
-}
-
-static int hypervisor_set_time(u32 secs)
-{
-	unsigned long ret;
-	int retries = 10000;
-
-retry:
-	ret = sun4v_tod_set(secs);
-	if (ret = HV_EOK)
-		return 0;
-	if (ret = HV_EWOULDBLOCK) {
-		if (--retries > 0) {
-			udelay(100);
-			goto retry;
-		}
-		printk(KERN_WARNING "SUN4V: tod_set() timed out.\n");
-		return -EAGAIN;
-	}
-	printk(KERN_WARNING "SUN4V: tod_set() not supported.\n");
-	return -EOPNOTSUPP;
-}
-
 unsigned long cmos_regs;
 EXPORT_SYMBOL(cmos_regs);
 
@@ -653,13 +611,8 @@ static int __init clock_init(void)
 		                        -xtime.tv_sec, -xtime.tv_nsec);
 		return 0;
 	}
-	if (tlb_type = hypervisor) {
-		xtime.tv_sec = hypervisor_get_time();
-		xtime.tv_nsec = (INITIAL_JIFFIES % HZ) * (NSEC_PER_SEC / HZ);
-		set_normalized_timespec(&wall_to_monotonic,
-		                        -xtime.tv_sec, -xtime.tv_nsec);
+	if (tlb_type = hypervisor)
 		return 0;
-	}
 
 	(void) of_register_driver(&rtc_driver, &of_platform_bus_type);
 	(void) of_register_driver(&mostek_driver, &of_platform_bus_type);
@@ -1037,24 +990,6 @@ static int starfire_set_rtc_time(struct rtc_time *time)
 	return starfire_set_time(seconds);
 }
 
-static void hypervisor_get_rtc_time(struct rtc_time *time)
-{
-	u32 seconds = hypervisor_get_time();
-
-	to_tm(seconds, time);
-	time->tm_year -= 1900;
-	time->tm_mon -= 1;
-}
-
-static int hypervisor_set_rtc_time(struct rtc_time *time)
-{
-	u32 seconds = mktime(time->tm_year + 1900, time->tm_mon + 1,
-			     time->tm_mday, time->tm_hour,
-			     time->tm_min, time->tm_sec);
-
-	return hypervisor_set_time(seconds);
-}
-
 struct mini_rtc_ops {
 	void (*get_rtc_time)(struct rtc_time *);
 	int (*set_rtc_time)(struct rtc_time *);
@@ -1065,11 +1000,6 @@ static struct mini_rtc_ops starfire_rtc_ops = {
 	.set_rtc_time = starfire_set_rtc_time,
 };
 
-static struct mini_rtc_ops hypervisor_rtc_ops = {
-	.get_rtc_time = hypervisor_get_rtc_time,
-	.set_rtc_time = hypervisor_set_rtc_time,
-};
-
 static struct mini_rtc_ops *mini_rtc_ops;
 
 static inline void mini_get_rtc_time(struct rtc_time *time)
@@ -1192,9 +1122,7 @@ static int __init rtc_mini_init(void)
 {
 	int retval;
 
-	if (tlb_type = hypervisor)
-		mini_rtc_ops = &hypervisor_rtc_ops;
-	else if (this_is_starfire)
+	if (this_is_starfire)
 		mini_rtc_ops = &starfire_rtc_ops;
 	else
 		return -ENODEV;
-- 
1.5.6.5.GIT


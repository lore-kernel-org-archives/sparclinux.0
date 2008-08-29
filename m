From: David Miller <davem@davemloft.net>
Date: Fri, 29 Aug 2008 06:09:53 +0000
Subject: [PATCH 12/12]: sparc64: Use generic starfire RTC driver.
Message-Id: <20080828.230953.122754608.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc64: Use generic starfire RTC driver.

Also, delete the mini RTC driver, no longer used.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc64/Kconfig       |    1 +
 arch/sparc64/kernel/time.c |  293 ++------------------------------------------
 2 files changed, 9 insertions(+), 285 deletions(-)

diff --git a/arch/sparc64/Kconfig b/arch/sparc64/Kconfig
index 16149ce..4a90809 100644
--- a/arch/sparc64/Kconfig
+++ b/arch/sparc64/Kconfig
@@ -24,6 +24,7 @@ config SPARC64
 	select RTC_DRV_CMOS
 	select RTC_DRV_BQ4802
 	select RTC_DRV_SUN4V
+	select RTC_DRV_STARFIRE
 
 config GENERIC_TIME
 	bool
diff --git a/arch/sparc64/kernel/time.c b/arch/sparc64/kernel/time.c
index 1b7a52a..f531462 100644
--- a/arch/sparc64/kernel/time.c
+++ b/arch/sparc64/kernel/time.c
@@ -403,27 +403,6 @@ int update_persistent_clock(struct timespec now)
 	return -1;
 }
 
-/* davem suggests we keep this within the 4M locked kernel image */
-static u32 starfire_get_time(void)
-{
-	static char obp_gettod[32];
-	static u32 unix_tod;
-
-	sprintf(obp_gettod, "h# %08x unix-gettod",
-		(unsigned int) (long) &unix_tod);
-	prom_feval(obp_gettod);
-
-	return unix_tod;
-}
-
-static int starfire_set_time(u32 val)
-{
-	/* Do nothing, time is set using the service processor
-	 * console on this platform.
-	 */
-	return 0;
-}
-
 unsigned long cmos_regs;
 EXPORT_SYMBOL(cmos_regs);
 
@@ -602,15 +581,16 @@ static struct of_platform_driver mostek_driver = {
 	},
 };
 
+static struct platform_device rtc_starfire_device = {
+	.name		= "rtc-starfire",
+	.id		= -1,
+};
+
 static int __init clock_init(void)
 {
-	if (this_is_starfire) {
-		xtime.tv_sec = starfire_get_time();
-		xtime.tv_nsec = (INITIAL_JIFFIES % HZ) * (NSEC_PER_SEC / HZ);
-		set_normalized_timespec(&wall_to_monotonic,
-		                        -xtime.tv_sec, -xtime.tv_nsec);
-		return 0;
-	}
+	if (this_is_starfire)
+		return platform_device_register(&rtc_starfire_device);
+
 	if (tlb_type = hypervisor)
 		return 0;
 
@@ -887,265 +867,8 @@ unsigned long long sched_clock(void)
 		>> SPARC64_NSEC_PER_CYC_SHIFT;
 }
 
-#define RTC_IS_OPEN		0x01	/* means /dev/rtc is in use	*/
-static unsigned char mini_rtc_status;	/* bitmapped status byte.	*/
-
-#define FEBRUARY	2
-#define	STARTOFTIME	1970
-#define SECDAY		86400L
-#define SECYR		(SECDAY * 365)
-#define	leapyear(year)		((year) % 4 = 0 && \
-				 ((year) % 100 != 0 || (year) % 400 = 0))
-#define	days_in_year(a) 	(leapyear(a) ? 366 : 365)
-#define	days_in_month(a) 	(month_days[(a) - 1])
-
-static int month_days[12] = {
-	31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31
-};
-
-/*
- * This only works for the Gregorian calendar - i.e. after 1752 (in the UK)
- */
-static void GregorianDay(struct rtc_time * tm)
-{
-	int leapsToDate;
-	int lastYear;
-	int day;
-	int MonthOffset[] = { 0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334 };
-
-	lastYear = tm->tm_year - 1;
-
-	/*
-	 * Number of leap corrections to apply up to end of last year
-	 */
-	leapsToDate = lastYear / 4 - lastYear / 100 + lastYear / 400;
-
-	/*
-	 * This year is a leap year if it is divisible by 4 except when it is
-	 * divisible by 100 unless it is divisible by 400
-	 *
-	 * e.g. 1904 was a leap year, 1900 was not, 1996 is, and 2000 was
-	 */
-	day = tm->tm_mon > 2 && leapyear(tm->tm_year);
-
-	day += lastYear*365 + leapsToDate + MonthOffset[tm->tm_mon-1] +
-		   tm->tm_mday;
-
-	tm->tm_wday = day % 7;
-}
-
-static void to_tm(int tim, struct rtc_time *tm)
-{
-	register int    i;
-	register long   hms, day;
-
-	day = tim / SECDAY;
-	hms = tim % SECDAY;
-
-	/* Hours, minutes, seconds are easy */
-	tm->tm_hour = hms / 3600;
-	tm->tm_min = (hms % 3600) / 60;
-	tm->tm_sec = (hms % 3600) % 60;
-
-	/* Number of years in days */
-	for (i = STARTOFTIME; day >= days_in_year(i); i++)
-		day -= days_in_year(i);
-	tm->tm_year = i;
-
-	/* Number of months in days left */
-	if (leapyear(tm->tm_year))
-		days_in_month(FEBRUARY) = 29;
-	for (i = 1; day >= days_in_month(i); i++)
-		day -= days_in_month(i);
-	days_in_month(FEBRUARY) = 28;
-	tm->tm_mon = i;
-
-	/* Days are what is left over (+1) from all that. */
-	tm->tm_mday = day + 1;
-
-	/*
-	 * Determine the day of week
-	 */
-	GregorianDay(tm);
-}
-
-/* Both Starfire and SUN4V give us seconds since Jan 1st, 1970,
- * aka Unix time.  So we have to convert to/from rtc_time.
- */
-static void starfire_get_rtc_time(struct rtc_time *time)
-{
-	u32 seconds = starfire_get_time();
-
-	to_tm(seconds, time);
-	time->tm_year -= 1900;
-	time->tm_mon -= 1;
-}
-
-static int starfire_set_rtc_time(struct rtc_time *time)
-{
-	u32 seconds = mktime(time->tm_year + 1900, time->tm_mon + 1,
-			     time->tm_mday, time->tm_hour,
-			     time->tm_min, time->tm_sec);
-
-	return starfire_set_time(seconds);
-}
-
-struct mini_rtc_ops {
-	void (*get_rtc_time)(struct rtc_time *);
-	int (*set_rtc_time)(struct rtc_time *);
-};
-
-static struct mini_rtc_ops starfire_rtc_ops = {
-	.get_rtc_time = starfire_get_rtc_time,
-	.set_rtc_time = starfire_set_rtc_time,
-};
-
-static struct mini_rtc_ops *mini_rtc_ops;
-
-static inline void mini_get_rtc_time(struct rtc_time *time)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&rtc_lock, flags);
-	mini_rtc_ops->get_rtc_time(time);
-	spin_unlock_irqrestore(&rtc_lock, flags);
-}
-
-static inline int mini_set_rtc_time(struct rtc_time *time)
-{
-	unsigned long flags;
-	int err;
-
-	spin_lock_irqsave(&rtc_lock, flags);
-	err = mini_rtc_ops->set_rtc_time(time);
-	spin_unlock_irqrestore(&rtc_lock, flags);
-
-	return err;
-}
-
-static int mini_rtc_ioctl(struct inode *inode, struct file *file,
-			  unsigned int cmd, unsigned long arg)
-{
-	struct rtc_time wtime;
-	void __user *argp = (void __user *)arg;
-
-	switch (cmd) {
-
-	case RTC_PLL_GET:
-		return -EINVAL;
-
-	case RTC_PLL_SET:
-		return -EINVAL;
-
-	case RTC_UIE_OFF:	/* disable ints from RTC updates.	*/
-		return 0;
-
-	case RTC_UIE_ON:	/* enable ints for RTC updates.	*/
-	        return -EINVAL;
-
-	case RTC_RD_TIME:	/* Read the time/date from RTC	*/
-		/* this doesn't get week-day, who cares */
-		memset(&wtime, 0, sizeof(wtime));
-		mini_get_rtc_time(&wtime);
-
-		return copy_to_user(argp, &wtime, sizeof(wtime)) ? -EFAULT : 0;
-
-	case RTC_SET_TIME:	/* Set the RTC */
-	    {
-		int year, days;
-
-		if (!capable(CAP_SYS_TIME))
-			return -EACCES;
-
-		if (copy_from_user(&wtime, argp, sizeof(wtime)))
-			return -EFAULT;
-
-		year = wtime.tm_year + 1900;
-		days = month_days[wtime.tm_mon] +
-		       ((wtime.tm_mon = 1) && leapyear(year));
-
-		if ((wtime.tm_mon < 0 || wtime.tm_mon > 11) ||
-		    (wtime.tm_mday < 1))
-			return -EINVAL;
-
-		if (wtime.tm_mday < 0 || wtime.tm_mday > days)
-			return -EINVAL;
-
-		if (wtime.tm_hour < 0 || wtime.tm_hour >= 24 ||
-		    wtime.tm_min < 0 || wtime.tm_min >= 60 ||
-		    wtime.tm_sec < 0 || wtime.tm_sec >= 60)
-			return -EINVAL;
-
-		return mini_set_rtc_time(&wtime);
-	    }
-	}
-
-	return -EINVAL;
-}
-
-static int mini_rtc_open(struct inode *inode, struct file *file)
-{
-	lock_kernel();
-	if (mini_rtc_status & RTC_IS_OPEN) {
-		unlock_kernel();
-		return -EBUSY;
-	}
-
-	mini_rtc_status |= RTC_IS_OPEN;
-	unlock_kernel();
-
-	return 0;
-}
-
-static int mini_rtc_release(struct inode *inode, struct file *file)
-{
-	mini_rtc_status &= ~RTC_IS_OPEN;
-	return 0;
-}
-
-
-static const struct file_operations mini_rtc_fops = {
-	.owner		= THIS_MODULE,
-	.ioctl		= mini_rtc_ioctl,
-	.open		= mini_rtc_open,
-	.release	= mini_rtc_release,
-};
-
-static struct miscdevice rtc_mini_dev -{
-	.minor		= RTC_MINOR,
-	.name		= "rtc",
-	.fops		= &mini_rtc_fops,
-};
-
-static int __init rtc_mini_init(void)
-{
-	int retval;
-
-	if (this_is_starfire)
-		mini_rtc_ops = &starfire_rtc_ops;
-	else
-		return -ENODEV;
-
-	printk(KERN_INFO "Mini RTC Driver\n");
-
-	retval = misc_register(&rtc_mini_dev);
-	if (retval < 0)
-		return retval;
-
-	return 0;
-}
-
-static void __exit rtc_mini_exit(void)
-{
-	misc_deregister(&rtc_mini_dev);
-}
-
 int __devinit read_current_timer(unsigned long *timer_val)
 {
 	*timer_val = tick_ops->get_tick();
 	return 0;
 }
-
-module_init(rtc_mini_init);
-module_exit(rtc_mini_exit);
-- 
1.5.6.5.GIT


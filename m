From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Sun, 06 Jan 2008 22:40:13 +0000
Subject: gettimeofday not monotonous on sun4m
Message-Id: <20080106224013.GA22464@palantir8>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="x+6KMIRAuhnl3hBn"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Best wishes for 2008 to you all.

I noticed the gettimeofday02 test from LTP fails as follows on both SS20 and 
SS10:
gettimeofday02    0  INFO  :  checking if gettimeofday is monotonous, takes 30s
gettimeofday02    1  FAIL  :  Time is going backwards: old 1197574068.852502 vs new 1197574068.842505!

Changing the test a bit shows time decreasing 684 times in a 30 second period,
while incrementing 6993105 times. The second count is always incrementing,
it is the microsecond count that decreases sometimes.

The microseconds are determined by:
    (xtime.tv_nsec / 1000) + (l10_counter >> 10)
I dumped both variables with a simple kernel module (first 2 attachments),
which shows that xtime is monotonous, but l10_counter looks random to me.

I do not know the problem here, and cannot find details on the operation
of this counter property on sun4m. Maybe this l10_counter needs to be
callibrated?
I understand from include/asm-sparc/timer.h that l10_counter should count
down on sun4m, which makes the current code all the more puzzling.

The 3rd attachment has a patch that ignores l10_counter in the calculation,
and shows the old code. Not sure if this is the right solution, but at least 
it fixes the problem. Moreover, I only have sun4m machines so cannot test
this on other sparc32 machine types.

Cheers,
-- 
Martin

	Signed-off-by: Martin Habets <errandir_news@mph.eclipse.co.uk>

--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="l10_counter.out"

palantir9:/tmp# insmod ./mod.ko 
l10_limit = 10241024    10001
0
l10_counter     shr(10) xtime
 5350912        5225    1199657069.356481
2157306368      9592    1199657069.366483
 6301184        6153    1199657069.396487
2148020736      524     1199657069.396487
2153432064      5809    1199657069.406489
 2461184        2403    1199657069.416490
2154276864      6634    1199657069.426492
 3438592        3358    1199657069.446495
 7822336        7639    1199657069.456496
 2065920        2017    1199657069.466497
2153841664      6209    1199657069.466497
 2906112        2838    1199657069.486500
 7368704        7196    1199657069.496502
 1619968        1582    1199657069.506503
 6078464        5936    1199657069.516505
  328192        320     1199657069.526506
 3745280        3657    1199657069.536508
2155530752      7858    1199657069.536508
 4595200        4487    1199657069.556511
 9043968        8832    1199657069.566512
 3302912        3225    1199657069.576514
 7769600        7587    1199657069.586515
 2007552        1960    1199657069.596517
 6480384        6328    1199657069.606518
  689152        673     1199657069.616520
insmod: error inserting './mod.ko': -1 No such device

--x+6KMIRAuhnl3hBn
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="tmod.c"

#include <linux/module.h>
//#include <linux/moduleparam.h>
#include <linux/time.h>
#include <asm/timer.h>

MODULE_AUTHOR("Martin Habets");
MODULE_LICENSE("GPL");

static int __init tmod_init(void)
{
	int	i, c;

	c = sun4m_timers->l10_timer_limit;
	printk(KERN_INFO "l10_limit = %u\t%u\n%x\n", c, c >> 10,
	       sun4m_timers->cfg);

	printk(KERN_INFO "l10_counter\tshr(10)\txtime\n");
	for (i=0; i<25; i++) {
		c = sun4m_timers->l10_cur_count;
		printk(KERN_INFO "%8u\t%u\t%lu.%lu\n",
		       c, (c>>10)&0x1fffff,
		       xtime.tv_sec, xtime.tv_nsec/1000);
	}

	return(-ENODEV);
}

static void __exit tmod_exit(void)
{
}

module_init(tmod_init);
module_exit(tmod_exit);


--x+6KMIRAuhnl3hBn
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="gettimeofday.patch"

Index: 2.6/arch/sparc/kernel/time.c
===================================================================
--- 2.6.orig/arch/sparc/kernel/time.c	2007-12-14 21:16:45.000000000 +0000
+++ 2.6/arch/sparc/kernel/time.c	2007-12-14 21:17:58.000000000 +0000
@@ -425,58 +425,57 @@
 
 void __init time_init(void)
 {
 #ifdef CONFIG_PCI
 	extern void pci_time_init(void);
 	if (pcic_present()) {
 		pci_time_init();
 		return;
 	}
 #endif
 	sbus_time_init();
 }
 
 static inline unsigned long do_gettimeoffset(void)
 {
-	return (*master_l10_counter >> 10) & 0x1fffff;
+	return (xtime.tv_nsec / 1000);
 }
 
 /* Ok, my cute asm atomicity trick doesn't work anymore.
  * There are just too many variables that need to be protected
  * now (both members of xtime, et al.)
  */
 void do_gettimeofday(struct timeval *tv)
 {
 	unsigned long flags;
 	unsigned long seq;
 	unsigned long usec, sec;
 	unsigned long max_ntp_tick = tick_usec - tickadj;
 
 	do {
 		seq = read_seqbegin_irqsave(&xtime_lock, flags);
 		usec = do_gettimeoffset();
 
 		/*
 		 * If time_adjust is negative then NTP is slowing the clock
 		 * so make sure not to go into next possible interval.
 		 * Better to lose some accuracy than have time go backwards..
 		 */
 		if (unlikely(time_adjust < 0))
 			usec = min(usec, max_ntp_tick);
 
 		sec = xtime.tv_sec;
-		usec += (xtime.tv_nsec / 1000);
 	} while (read_seqretry_irqrestore(&xtime_lock, seq, flags));
 
 	while (usec >= 1000000) {
 		usec -= 1000000;
 		sec++;
 	}
 
 	tv->tv_sec = sec;
 	tv->tv_usec = usec;
 }
 
 EXPORT_SYMBOL(do_gettimeofday);
 
 int do_settimeofday(struct timespec *tv)
 {

--x+6KMIRAuhnl3hBn--

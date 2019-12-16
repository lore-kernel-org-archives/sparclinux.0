From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 16 Dec 2019 14:48:53 +0000
Subject: [PATCH v2] y2038: sparc: remove use of struct timex
Message-Id: <20191216144907.1931511-1-arnd@arndb.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: Julian Calaby <julian.calaby@gmail.com>, Arnd Bergmann <arnd@arndb.de>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Deepa Dinamani <deepa.kernel@gmail.com>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

'struct timex' is one of the last users of 'struct timeval' and is
only referenced in one place in the kernel any more, to convert the
user space timex into the kernel-internal version on sparc64, with a
different tv_usec member type.

As a preparation for hiding the time_t definition and everything
using that in the kernel, change the implementation once more
to only convert the timeval member, and then enclose the
struct definition in an #ifdef.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: send a version that it at least build tested this time

If this looks ok to you, please queue it in the sparc git for v5.6

 arch/sparc/kernel/sys_sparc_64.c | 33 ++++++++++++++++----------------
 include/uapi/linux/timex.h       |  2 ++
 2 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/arch/sparc/kernel/sys_sparc_64.c b/arch/sparc/kernel/sys_sparc_64.c
index 9f41a6f5a032..34917617f258 100644
--- a/arch/sparc/kernel/sys_sparc_64.c
+++ b/arch/sparc/kernel/sys_sparc_64.c
@@ -548,34 +548,35 @@ SYSCALL_DEFINE2(getdomainname, char __user *, name, int, len)
 	return err;
 }
 
-SYSCALL_DEFINE1(sparc_adjtimex, struct timex __user *, txc_p)
+SYSCALL_DEFINE1(sparc_adjtimex, struct __kernel_timex __user *, txc_p)
 {
-	struct timex txc;		/* Local copy of parameter */
-	struct __kernel_timex *kt = (void *)&txc;
+	struct __kernel_timex txc;
+	struct __kernel_old_timeval *tv = (void *)&txc_p->time;
 	int ret;
 
 	/* Copy the user data space into the kernel copy
 	 * structure. But bear in mind that the structures
 	 * may change
 	 */
-	if (copy_from_user(&txc, txc_p, sizeof(struct timex)))
+	if (copy_from_user(&txc, txc_p, sizeof(txc)))
 		return -EFAULT;
 
 	/*
 	 * override for sparc64 specific timeval type: tv_usec
 	 * is 32 bit wide instead of 64-bit in __kernel_timex
 	 */
-	kt->time.tv_usec = txc.time.tv_usec;
-	ret = do_adjtimex(kt);
-	txc.time.tv_usec = kt->time.tv_usec;
+	txc.time.tv_usec = tv->tv_usec;
+	ret = do_adjtimex(&txc);
+	tv->tv_usec = txc.time.tv_usec;
 
-	return copy_to_user(txc_p, &txc, sizeof(struct timex)) ? -EFAULT : ret;
+	return copy_to_user(txc_p, &txc, sizeof(txc)) ? -EFAULT : ret;
 }
 
-SYSCALL_DEFINE2(sparc_clock_adjtime, const clockid_t, which_clock,struct timex __user *, txc_p)
+SYSCALL_DEFINE2(sparc_clock_adjtime, const clockid_t, which_clock,
+		struct __kernel_timex __user *, txc_p)
 {
-	struct timex txc;		/* Local copy of parameter */
-	struct __kernel_timex *kt = (void *)&txc;
+	struct __kernel_timex txc;
+	struct __kernel_old_timeval *tv = (void *)&txc_p->time;
 	int ret;
 
 	if (!IS_ENABLED(CONFIG_POSIX_TIMERS)) {
@@ -590,18 +591,18 @@ SYSCALL_DEFINE2(sparc_clock_adjtime, const clockid_t, which_clock,struct timex _
 	 * structure. But bear in mind that the structures
 	 * may change
 	 */
-	if (copy_from_user(&txc, txc_p, sizeof(struct timex)))
+	if (copy_from_user(&txc, txc_p, sizeof(txc)))
 		return -EFAULT;
 
 	/*
 	 * override for sparc64 specific timeval type: tv_usec
 	 * is 32 bit wide instead of 64-bit in __kernel_timex
 	 */
-	kt->time.tv_usec = txc.time.tv_usec;
-	ret = do_clock_adjtime(which_clock, kt);
-	txc.time.tv_usec = kt->time.tv_usec;
+	txc.time.tv_usec = tv->tv_usec;
+	ret = do_clock_adjtime(which_clock, &txc);
+	tv->tv_usec = txc.time.tv_usec;
 
-	return copy_to_user(txc_p, &txc, sizeof(struct timex)) ? -EFAULT : ret;
+	return copy_to_user(txc_p, &txc, sizeof(txc)) ? -EFAULT : ret;
 }
 
 SYSCALL_DEFINE5(utrap_install, utrap_entry_t, type,
diff --git a/include/uapi/linux/timex.h b/include/uapi/linux/timex.h
index 9f517f9010bb..bd627c368d09 100644
--- a/include/uapi/linux/timex.h
+++ b/include/uapi/linux/timex.h
@@ -57,6 +57,7 @@
 
 #define NTP_API		4	/* NTP API version */
 
+#ifndef __KERNEL__
 /*
  * syscall interface - used (mainly by NTP daemon)
  * to discipline kernel clock oscillator
@@ -91,6 +92,7 @@ struct timex {
 	int  :32; int  :32; int  :32; int  :32;
 	int  :32; int  :32; int  :32;
 };
+#endif
 
 struct __kernel_timex_timeval {
 	__kernel_time64_t       tv_sec;
-- 
2.20.0

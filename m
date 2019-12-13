From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 13 Dec 2019 20:53:52 +0000
Subject: [PATCH v2 24/24] y2038: sparc: remove use of struct timex
Message-Id: <20191213205417.3871055-15-arnd@arndb.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20191213204936.3643476-1-arnd@arndb.de>
In-Reply-To: <20191213204936.3643476-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: y2038@lists.linaro.org, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Stephen Boyd <sboyd@kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, "Eric W. Biederman" <ebiederm@xmission.com>, sparclinux@vger.kernel.org

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
 arch/sparc/kernel/sys_sparc_64.c | 29 +++++++++++++++--------------
 include/uapi/linux/timex.h       |  2 ++
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/arch/sparc/kernel/sys_sparc_64.c b/arch/sparc/kernel/sys_sparc_64.c
index 9f41a6f5a032..1c85b0af4dfd 100644
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
+	__kernel_old_timeval *tv = (void *)&txc->time;
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
+	kt->time.tv_usec = tv->tv_usec;
 	ret = do_adjtimex(kt);
-	txc.time.tv_usec = kt->time.tv_usec;
+	tv->tv_usec = kt->time.tv_usec;
 
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
+	__kernel_old_timeval *tv = (void *)&txc->time;
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
+	kt->time.tv_usec = tv->tv_usec;
 	ret = do_clock_adjtime(which_clock, kt);
-	txc.time.tv_usec = kt->time.tv_usec;
+	tv->tv_usec = kt->time.tv_usec;
 
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

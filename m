From: Xunlei Pang <xlpang@126.com>
Date: Fri, 29 May 2015 14:46:18 +0000
Subject: [PATCH v2 4/4] cris: time: Cleanup of persistent clock stuff
Message-Id: <1432910778-314-4-git-send-email-xlpang@126.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1432910778-314-1-git-send-email-xlpang@126.com>
In-Reply-To: <1432910778-314-1-git-send-email-xlpang@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>, John Stultz <john.stultz@linaro.org>, Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-cris-kernel@axis.com, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Xunlei Pang <pang.xunlei@linaro.org>

From: Xunlei Pang <pang.xunlei@linaro.org>

- Remove update_persistent_clock(), as it does nothing now.
- Remove read_persistent_clock(), let it fall back to the weak version.

Signed-off-by: Xunlei Pang <pang.xunlei@linaro.org>
---
 arch/cris/Kconfig       |  1 -
 arch/cris/kernel/time.c | 25 -------------------------
 2 files changed, 26 deletions(-)

diff --git a/arch/cris/Kconfig b/arch/cris/Kconfig
index 0314e32..982d562 100644
--- a/arch/cris/Kconfig
+++ b/arch/cris/Kconfig
@@ -46,7 +46,6 @@ config CRIS
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select GENERIC_IRQ_SHOW
 	select GENERIC_IOMAP
-	select GENERIC_CMOS_UPDATE
 	select MODULES_USE_ELF_RELA
 	select CLONE_BACKWARDS2
 	select OLD_SIGSUSPEND
diff --git a/arch/cris/kernel/time.c b/arch/cris/kernel/time.c
index 7780d37..2dda6da 100644
--- a/arch/cris/kernel/time.c
+++ b/arch/cris/kernel/time.c
@@ -39,31 +39,6 @@
 extern unsigned long loops_per_jiffy; /* init/main.c */
 unsigned long loops_per_usec;
 
-int set_rtc_mmss(unsigned long nowtime)
-{
-	D(printk(KERN_DEBUG "set_rtc_mmss(%lu)\n", nowtime));
-	return 0;
-}
-
-/* grab the time from the RTC chip */
-unsigned long get_cmos_time(void)
-{
-	return 0;
-}
-
-
-int update_persistent_clock(struct timespec now)
-{
-	return set_rtc_mmss(now.tv_sec);
-}
-
-void read_persistent_clock(struct timespec *ts)
-{
-	ts->tv_sec = 0;
-	ts->tv_nsec = 0;
-}
-
-
 extern void cris_profile_sample(struct pt_regs* regs);
 
 void
-- 
1.9.1



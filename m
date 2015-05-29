From: Xunlei Pang <xlpang@126.com>
Date: Fri, 29 May 2015 14:46:15 +0000
Subject: [PATCH v2 1/4] NTP: rtc: Add CONFIG_RTC_SYSTOHC_DEVICE for NTP synchronization
Message-Id: <1432910778-314-1-git-send-email-xlpang@126.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>, John Stultz <john.stultz@linaro.org>, Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-cris-kernel@axis.com, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Xunlei Pang <pang.xunlei@linaro.org>

From: Xunlei Pang <pang.xunlei@linaro.org>

Currently, CONFIG_RTC_SYSTOHC uses CONFIG_RTC_HCTOSYS_DEVICE which
is originally used by CONFIG_RTC_HCTOSYS, but this rtc device has
some limiations, for example, it must be battery-backed, be able
to work with irq off and through system suspension, etc.

So add CONFIG_RTC_SYSTOHC_DEVICE used exclusively for CONFIG_RTC_SYSTOHC,
it is more lenient compared to CONFIG_RTC_HCTOSYS_DEVICE, and could
be assigned any available RTC in the system. Default value is "rtc0".

After this patch, NTP will sync up "rtc0" by default.

Signed-off-by: Xunlei Pang <pang.xunlei@linaro.org>
---
 drivers/rtc/Kconfig   | 28 +++++++++++++++++++---------
 drivers/rtc/systohc.c |  2 +-
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 0fe4ad8..f429e9a 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -25,17 +25,9 @@ config RTC_HCTOSYS
 	  the value read from a specified RTC device. This is useful to avoid
 	  unnecessary fsck runs at boot time, and to network better.
 
-config RTC_SYSTOHC
-	bool "Set the RTC time based on NTP synchronization"
-	default y
-	help
-	  If you say yes here, the system time (wall clock) will be stored
-	  in the RTC specified by RTC_HCTOSYS_DEVICE approximately every 11
-	  minutes if userspace reports synchronized NTP status.
-
 config RTC_HCTOSYS_DEVICE
 	string "RTC used to set the system time"
-	depends on RTC_HCTOSYS = y || RTC_SYSTOHC = y
+	depends on RTC_HCTOSYS = y
 	default "rtc0"
 	help
 	  The RTC device that will be used to (re)initialize the system
@@ -56,6 +48,24 @@ config RTC_HCTOSYS_DEVICE
 	  sleep states. Do not specify an RTC here unless it stays powered
 	  during all this system's supported sleep states.
 
+config RTC_SYSTOHC
+	bool "Set the RTC time based on NTP synchronization"
+	default y
+	help
+	  If you say yes here, the system time (wall clock) will be stored
+	  in the RTC specified by RTC_HCTOSYS_DEVICE approximately every 11
+	  minutes if userspace reports synchronized NTP status.
+
+config RTC_SYSTOHC_DEVICE
+	string "RTC used to synchronize NTP adjustment"
+	depends on RTC_SYSTOHC = y
+	default "rtc0"
+	help
+	  The RTC device used for NTP synchronization. The main difference
+	  between RTC_HCTOSYS_DEVICE and RTC_SYSTOHC_DEVICE is that this
+	  one can sleep when setting time, because it runs in the workqueue
+	  context.
+
 config RTC_DEBUG
 	bool "RTC debug support"
 	help
diff --git a/drivers/rtc/systohc.c b/drivers/rtc/systohc.c
index 7728d5e..b4a68ff 100644
--- a/drivers/rtc/systohc.c
+++ b/drivers/rtc/systohc.c
@@ -31,7 +31,7 @@ int rtc_set_ntp_time(struct timespec64 now)
 	else
 		rtc_time64_to_tm(now.tv_sec + 1, &tm);
 
-	rtc = rtc_class_open(CONFIG_RTC_HCTOSYS_DEVICE);
+	rtc = rtc_class_open(CONFIG_RTC_SYSTOHC_DEVICE);
 	if (rtc) {
 		/* rtc_hctosys exclusively uses UTC, so we call set_time here,
 		 * not set_mmss. */
-- 
1.9.1



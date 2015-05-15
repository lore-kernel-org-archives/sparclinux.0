From: Xunlei Pang <xlpang@126.com>
Date: Fri, 15 May 2015 09:31:31 +0000
Subject: [PATCH 1/2] drivers/rtc/interface.c: Change rtc_set_mmss() to use time64_t
Message-Id: <1431682292-29732-1-git-send-email-xlpang@126.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>, John Stultz <john.stultz@linaro.org>, Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Xunlei Pang <pang.xunlei@linaro.org>

From: Xunlei Pang <pang.xunlei@linaro.org>

rtc_set_mmss() uses "unsigned long" as its second parameter which
may have y2038 problem on 32-bit systems.

Change it to use time64_t.

All its call sites will be changed later(there are no problems
leaving these call sites untouched).

Signed-off-by: Xunlei Pang <pang.xunlei@linaro.org>
---
 drivers/rtc/interface.c | 2 +-
 include/linux/rtc.h     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index d43ee40..480ee3c 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -90,7 +90,7 @@ int rtc_set_time(struct rtc_device *rtc, struct rtc_time *tm)
 }
 EXPORT_SYMBOL_GPL(rtc_set_time);
 
-int rtc_set_mmss(struct rtc_device *rtc, unsigned long secs)
+int rtc_set_mmss(struct rtc_device *rtc, time64_t secs)
 {
 	int err;
 
diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index 8dcf682..9c3180e 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -161,7 +161,7 @@ extern void devm_rtc_device_unregister(struct device *dev,
 
 extern int rtc_read_time(struct rtc_device *rtc, struct rtc_time *tm);
 extern int rtc_set_time(struct rtc_device *rtc, struct rtc_time *tm);
-extern int rtc_set_mmss(struct rtc_device *rtc, unsigned long secs);
+extern int rtc_set_mmss(struct rtc_device *rtc, time64_t secs);
 extern int rtc_set_ntp_time(struct timespec64 now);
 int __rtc_read_alarm(struct rtc_device *rtc, struct rtc_wkalrm *alarm);
 extern int rtc_read_alarm(struct rtc_device *rtc,
-- 
1.9.1



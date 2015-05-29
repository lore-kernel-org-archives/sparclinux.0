From: Xunlei Pang <xlpang@126.com>
Date: Fri, 29 May 2015 14:46:17 +0000
Subject: [PATCH v2 3/4] drivers/rtc/interface.c: Remove rtc_set_mmss()
Message-Id: <1432910778-314-3-git-send-email-xlpang@126.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1432910778-314-1-git-send-email-xlpang@126.com>
In-Reply-To: <1432910778-314-1-git-send-email-xlpang@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>, John Stultz <john.stultz@linaro.org>, Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-cris-kernel@axis.com, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Xunlei Pang <pang.xunlei@linaro.org>

From: Xunlei Pang <pang.xunlei@linaro.org>

Now rtc_set_mmss() has no users, just remove it.

We still have rtc_set_time() doing similar things.

Signed-off-by: Xunlei Pang <pang.xunlei@linaro.org>
---
 drivers/rtc/interface.c | 45 ---------------------------------------------
 include/linux/rtc.h     |  1 -
 2 files changed, 46 deletions(-)

diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index 166fc60..b511aa1 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -91,51 +91,6 @@ int rtc_set_time(struct rtc_device *rtc, struct rtc_time *tm)
 }
 EXPORT_SYMBOL_GPL(rtc_set_time);
 
-int rtc_set_mmss(struct rtc_device *rtc, unsigned long secs)
-{
-	int err;
-
-	err = mutex_lock_interruptible(&rtc->ops_lock);
-	if (err)
-		return err;
-
-	if (!rtc->ops)
-		err = -ENODEV;
-	else if (rtc->ops->set_mmss64)
-		err = rtc->ops->set_mmss64(rtc->dev.parent, secs);
-	else if (rtc->ops->set_mmss)
-		err = rtc->ops->set_mmss(rtc->dev.parent, secs);
-	else if (rtc->ops->read_time && rtc->ops->set_time) {
-		struct rtc_time new, old;
-
-		err = rtc->ops->read_time(rtc->dev.parent, &old);
-		if (err = 0) {
-			rtc_time64_to_tm(secs, &new);
-
-			/*
-			 * avoid writing when we're going to change the day of
-			 * the month. We will retry in the next minute. This
-			 * basically means that if the RTC must not drift
-			 * by more than 1 minute in 11 minutes.
-			 */
-			if (!((old.tm_hour = 23 && old.tm_min = 59) ||
-				(new.tm_hour = 23 && new.tm_min = 59)))
-				err = rtc->ops->set_time(rtc->dev.parent,
-						&new);
-		}
-	} else {
-		err = -EINVAL;
-	}
-
-	pm_stay_awake(rtc->dev.parent);
-	mutex_unlock(&rtc->ops_lock);
-	/* A timer might have just expired */
-	schedule_work(&rtc->irqwork);
-
-	return err;
-}
-EXPORT_SYMBOL_GPL(rtc_set_mmss);
-
 static int rtc_read_alarm_internal(struct rtc_device *rtc, struct rtc_wkalrm *alarm)
 {
 	int err;
diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index 8dcf682..e8f2c3c 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -161,7 +161,6 @@ extern void devm_rtc_device_unregister(struct device *dev,
 
 extern int rtc_read_time(struct rtc_device *rtc, struct rtc_time *tm);
 extern int rtc_set_time(struct rtc_device *rtc, struct rtc_time *tm);
-extern int rtc_set_mmss(struct rtc_device *rtc, unsigned long secs);
 extern int rtc_set_ntp_time(struct timespec64 now);
 int __rtc_read_alarm(struct rtc_device *rtc, struct rtc_wkalrm *alarm);
 extern int rtc_read_alarm(struct rtc_device *rtc,
-- 
1.9.1



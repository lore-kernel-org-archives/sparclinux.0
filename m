From: Nishanth Aravamudan <nacc@us.ibm.com>
Date: Wed, 26 Jan 2005 00:43:46 +0000
Subject: [PATCH 31/33] sbus/vfc_i2c: remove sleep_on() usage
Message-Id: <20050126004346.GW12649@us.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org

Hi,

Please consider applying.

Description: Use wait-queue directly instead of the deprecated sleep_on()
function. This required adding a local wait-queue. Also use new (added in
separate patch to K-J) usecs to jiffies function to convert value.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

--- 2.6.11-rc2-kj-v/drivers/sbus/char/vfc_i2c.c	2005-01-24 09:28:41.000000000 -0800
+++ 2.6.11-rc2-kj/drivers/sbus/char/vfc_i2c.c	2005-01-25 16:42:26.000000000 -0800
@@ -88,14 +88,16 @@ void vfc_i2c_delay_wakeup(struct vfc_dev
 
 void vfc_i2c_delay_no_busy(struct vfc_dev *dev, unsigned long usecs) 
 {
+	DEFINE_WAIT(wait);
 	init_timer(&dev->poll_timer);
-	dev->poll_timer.expires = jiffies + 
-		((unsigned long)usecs*(HZ))/1000000;
+	dev->poll_timer.expires = jiffies + usecs_to_jiffies(usecs);
 	dev->poll_timer.data=(unsigned long)dev;
 	dev->poll_timer.function=(void *)(unsigned long)vfc_i2c_delay_wakeup;
 	add_timer(&dev->poll_timer);
-	sleep_on(&dev->poll_wait);
+	prepare_to_wait(&dev->poll_timer, &wait, TASK_UNINTERRUPTIBLE);
+	schedule();
 	del_timer(&dev->poll_timer);
+	finish_wait(&dev->poll_wait, &wait);
 }
 
 void inline vfc_i2c_delay(struct vfc_dev *dev) 

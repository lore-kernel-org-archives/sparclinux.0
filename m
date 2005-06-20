From: domen@coderock.org
Date: Mon, 20 Jun 2005 21:50:35 +0000
Subject: [patch 4/4] sbus/vfc_i2c: remove sleep_on() usage
Message-Id: <20050620215035.462595000@nd47.coderock.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Nishanth Aravamudan <nacc@us.ibm.com>



Use wait-queue directly instead of the deprecated sleep_on()
function. This required adding a local wait-queue. Also use new (added in
separate patch to K-J) usecs to jiffies function to convert value.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---
 vfc_i2c.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

Index: quilt/drivers/sbus/char/vfc_i2c.c
=================================--- quilt.orig/drivers/sbus/char/vfc_i2c.c
+++ quilt/drivers/sbus/char/vfc_i2c.c
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
+	prepare_to_wait(&dev->poll_wait, &wait, TASK_UNINTERRUPTIBLE);
+	schedule();
 	del_timer(&dev->poll_timer);
+	finish_wait(&dev->poll_wait, &wait);
 }
 
 void inline vfc_i2c_delay(struct vfc_dev *dev) 

--

From: domen@coderock.org
Date: Sun, 06 Mar 2005 22:29:07 +0000
Subject: [patch 4/4] sbus/vfc_i2c: remove sleep_on() usage
Message-Id: <20050306222907.E088C1ED3D@trashy.coderock.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org



Use wait-queue directly instead of the deprecated sleep_on()
function. This required adding a local wait-queue. Also use new (added in
separate patch to K-J) usecs to jiffies function to convert value.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/sbus/char/vfc_i2c.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff -puN drivers/sbus/char/vfc_i2c.c~sleep_on-drivers_sbus_char_vfc_i2c drivers/sbus/char/vfc_i2c.c
--- kj/drivers/sbus/char/vfc_i2c.c~sleep_on-drivers_sbus_char_vfc_i2c	2005-03-05 16:11:50.000000000 +0100
+++ kj-domen/drivers/sbus/char/vfc_i2c.c	2005-03-05 16:11:50.000000000 +0100
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
_

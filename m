From: Joerg Friedrich <Joerg.Friedrich@friedrich-kn.de>
Date: Thu, 15 Feb 2007 21:08:55 +0000
Subject: [Patch] kenvctrld causes very high cpu load
Message-Id: <20070215210855.GA22572@stardust.friedrich-kn.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="YiEDa0DAkWCtVeE4"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi!

I recently got a Sun Blade 1000.
I encountered the same problem described at
http://ubuntuforums.org/showthread.php?t=297474

The mentioned solution (removing the msleep) and switch to polling mode
is imho no good option.

Problem:
kthread kenvctrld calls wait_for_pin(), attaches itself to the
wait_queue and sets itself INTERRUPTIBLE (unneccesary because
msleep_interruptible does the same). Then it checks if the i2c-query is
already done. Usually this is not the case at first check.

Then kenvctrl calles msleep_interruptible(250). Usually 1 or 2 ms later
the i2c-bus signals by interrupt that the desired operation is done.
The interrupt-handler wakes up all tasks in the wq.
Know kenvctrld is reset to TASK_RUNNING and does about 248 ms sleeping
at kernel priority :-(


the patch attached will switch this to wait_event_interruptible_timeout.
It might be possible to change this line:

	if ((val != -ERESTARTSYS) && (val > 0))  {

to

	if (val > 0)  {

but I was not sure if I can rely on errror codes <0


Please check this patch since I do not know exactly how to proceed.


-- 
Jörg Friedrich

There are only 10 types of people:
Those who understand binary and those who don't.

--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="bbc_i2c.c.diff"

--- linux-2.6.20/drivers/sbus/char/bbc_i2c.c.orig	2007-02-15 21:26:56.000000000 +0100
+++ linux-2.6.20/drivers/sbus/char/bbc_i2c.c	2007-02-15 21:28:36.000000000 +0100
@@ -187,19 +187,18 @@
 	bp->waiting = 1;
 	add_wait_queue(&bp->wq, &wait);
 	while (limit-- > 0) {
-		u8 val;
+		long val;
 
-		set_current_state(TASK_INTERRUPTIBLE);
-		*status = val = readb(bp->i2c_control_regs + 0);
-		if ((val & I2C_PCF_PIN) == 0) {
+		val = wait_event_interruptible_timeout(bp->wq,
+			(((*status = readb(bp->i2c_control_regs + 0)) & I2C_PCF_PIN) == 0),
+			msecs_to_jiffies(250));
+		if ((val != -ERESTARTSYS) && (val > 0))  {
 			ret = 0;
 			break;
 		}
-		msleep_interruptible(250);
 	}
 	remove_wait_queue(&bp->wq, &wait);
 	bp->waiting = 0;
-	current->state = TASK_RUNNING;
 
 	return ret;
 }
@@ -340,7 +339,7 @@
 	 */
 	if (bp->waiting &&
 	    !(readb(bp->i2c_control_regs + 0x0) & I2C_PCF_PIN))
-		wake_up(&bp->wq);
+		wake_up_interruptible(&bp->wq);
 
 	return IRQ_HANDLED;
 }

--YiEDa0DAkWCtVeE4--

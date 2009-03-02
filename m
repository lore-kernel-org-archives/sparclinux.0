From: Roel Kluin <roel.kluin@gmail.com>
Date: Mon, 02 Mar 2009 15:23:39 +0000
Subject: [PATCH] sparc64: wait_event_interruptible_timeout may return -ERESTARTSYS
Message-Id: <49ABF9FB.2040502@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

wait_event_interruptible_timeout may return -ERESTARTSYS.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/drivers/sbus/char/bbc_i2c.c b/drivers/sbus/char/bbc_i2c.c
index f08e169..7e30e5f 100644
--- a/drivers/sbus/char/bbc_i2c.c
+++ b/drivers/sbus/char/bbc_i2c.c
@@ -129,7 +129,7 @@ static int wait_for_pin(struct bbc_i2c_bus *bp, u8 *status)
 	bp->waiting = 1;
 	add_wait_queue(&bp->wq, &wait);
 	while (limit-- > 0) {
-		unsigned long val;
+		long val;
 
 		val = wait_event_interruptible_timeout(
 				bp->wq,

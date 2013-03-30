From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 30 Mar 2013 21:44:24 +0000
Subject: [PATCH 3/5] bbc_i2c: fix section mismatch warning
Message-Id: <1364679866-29982-3-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix following warning:

WARNING: drivers/sbus/char/bbc.o(.text+0x674): Section mismatch in reference from the function bbc_i2c_probe() to the function .init.text:T.463()
The function bbc_i2c_probe() references the function __init T.463().
This is often because bbc_i2c_probe lacks a __init
annotation or the annotation of T.463 is wrong.

bbc_i2c_probe() referenced the inlined attach_one_i2c().
As probe may be called after init drop __init annotations
on all functions used by bbc_i2c_probe()

The warning was seen with a sparc64 defconfig build

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 drivers/sbus/char/bbc_i2c.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/sbus/char/bbc_i2c.c b/drivers/sbus/char/bbc_i2c.c
index 1a9d1e3..c1441ed 100644
--- a/drivers/sbus/char/bbc_i2c.c
+++ b/drivers/sbus/char/bbc_i2c.c
@@ -282,7 +282,7 @@ static irqreturn_t bbc_i2c_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static void __init reset_one_i2c(struct bbc_i2c_bus *bp)
+static void reset_one_i2c(struct bbc_i2c_bus *bp)
 {
 	writeb(I2C_PCF_PIN, bp->i2c_control_regs + 0x0);
 	writeb(bp->own, bp->i2c_control_regs + 0x1);
@@ -291,7 +291,7 @@ static void __init reset_one_i2c(struct bbc_i2c_bus *bp)
 	writeb(I2C_PCF_IDLE, bp->i2c_control_regs + 0x0);
 }
 
-static struct bbc_i2c_bus * __init attach_one_i2c(struct platform_device *op, int index)
+static struct bbc_i2c_bus * attach_one_i2c(struct platform_device *op, int index)
 {
 	struct bbc_i2c_bus *bp;
 	struct device_node *dp;
-- 
1.6.0.6


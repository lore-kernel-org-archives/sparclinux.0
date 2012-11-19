From: Bill Pemberton <wfp5p@virginia.edu>
Date: Mon, 19 Nov 2012 18:26:13 +0000
Subject: [PATCH 424/493] sbus: remove use of __devexit
Message-Id: <1353349642-3677-424-git-send-email-wfp5p@virginia.edu>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

CONFIG_HOTPLUG is going away as an option so __devexit is no
longer needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: "David S. Miller" <davem@davemloft.net> 
Cc: sparclinux@vger.kernel.org 
---
 drivers/sbus/char/bbc_i2c.c     | 2 +-
 drivers/sbus/char/display7seg.c | 2 +-
 drivers/sbus/char/envctrl.c     | 2 +-
 drivers/sbus/char/flash.c       | 2 +-
 drivers/sbus/char/uctrl.c       | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/sbus/char/bbc_i2c.c b/drivers/sbus/char/bbc_i2c.c
index 8ccaa79..1a9d1e3 100644
--- a/drivers/sbus/char/bbc_i2c.c
+++ b/drivers/sbus/char/bbc_i2c.c
@@ -379,7 +379,7 @@ static int bbc_i2c_probe(struct platform_device *op)
 	return err;
 }
 
-static int __devexit bbc_i2c_remove(struct platform_device *op)
+static int bbc_i2c_remove(struct platform_device *op)
 {
 	struct bbc_i2c_bus *bp = dev_get_drvdata(&op->dev);
 
diff --git a/drivers/sbus/char/display7seg.c b/drivers/sbus/char/display7seg.c
index 9f4c285..e85c803 100644
--- a/drivers/sbus/char/display7seg.c
+++ b/drivers/sbus/char/display7seg.c
@@ -236,7 +236,7 @@ out_free:
 	goto out;
 }
 
-static int __devexit d7s_remove(struct platform_device *op)
+static int d7s_remove(struct platform_device *op)
 {
 	struct d7s *p = dev_get_drvdata(&op->dev);
 	u8 regs = readb(p->regs);
diff --git a/drivers/sbus/char/envctrl.c b/drivers/sbus/char/envctrl.c
index e1cbbc2..ddbe5a9 100644
--- a/drivers/sbus/char/envctrl.c
+++ b/drivers/sbus/char/envctrl.c
@@ -1104,7 +1104,7 @@ out_iounmap:
 	return err;
 }
 
-static int __devexit envctrl_remove(struct platform_device *op)
+static int envctrl_remove(struct platform_device *op)
 {
 	int index;
 
diff --git a/drivers/sbus/char/flash.c b/drivers/sbus/char/flash.c
index 733f492..d9f268f 100644
--- a/drivers/sbus/char/flash.c
+++ b/drivers/sbus/char/flash.c
@@ -190,7 +190,7 @@ static int flash_probe(struct platform_device *op)
 	return misc_register(&flash_dev);
 }
 
-static int __devexit flash_remove(struct platform_device *op)
+static int flash_remove(struct platform_device *op)
 {
 	misc_deregister(&flash_dev);
 
diff --git a/drivers/sbus/char/uctrl.c b/drivers/sbus/char/uctrl.c
index 2484633..b0aae05 100644
--- a/drivers/sbus/char/uctrl.c
+++ b/drivers/sbus/char/uctrl.c
@@ -402,7 +402,7 @@ out_free:
 	goto out;
 }
 
-static int __devexit uctrl_remove(struct platform_device *op)
+static int uctrl_remove(struct platform_device *op)
 {
 	struct uctrl_driver *p = dev_get_drvdata(&op->dev);
 
-- 
1.8.0


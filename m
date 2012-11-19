From: Bill Pemberton <wfp5p@virginia.edu>
Date: Mon, 19 Nov 2012 18:23:15 +0000
Subject: [PATCH 246/493] sbus: remove use of __devinit
Message-Id: <1353349642-3677-246-git-send-email-wfp5p@virginia.edu>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

CONFIG_HOTPLUG is going away as an option so __devinit is no longer
needed.

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
index e844bb2..8ccaa79 100644
--- a/drivers/sbus/char/bbc_i2c.c
+++ b/drivers/sbus/char/bbc_i2c.c
@@ -355,7 +355,7 @@ fail:
 extern int bbc_envctrl_init(struct bbc_i2c_bus *bp);
 extern void bbc_envctrl_cleanup(struct bbc_i2c_bus *bp);
 
-static int __devinit bbc_i2c_probe(struct platform_device *op)
+static int bbc_i2c_probe(struct platform_device *op)
 {
 	struct bbc_i2c_bus *bp;
 	int err, index = 0;
diff --git a/drivers/sbus/char/display7seg.c b/drivers/sbus/char/display7seg.c
index 7694e5a..9f4c285 100644
--- a/drivers/sbus/char/display7seg.c
+++ b/drivers/sbus/char/display7seg.c
@@ -171,7 +171,7 @@ static struct miscdevice d7s_miscdev = {
 	.fops		= &d7s_fops
 };
 
-static int __devinit d7s_probe(struct platform_device *op)
+static int d7s_probe(struct platform_device *op)
 {
 	struct device_node *opts;
 	int err = -EINVAL;
diff --git a/drivers/sbus/char/envctrl.c b/drivers/sbus/char/envctrl.c
index 6f36638..e1cbbc2 100644
--- a/drivers/sbus/char/envctrl.c
+++ b/drivers/sbus/char/envctrl.c
@@ -1028,7 +1028,7 @@ static int kenvctrld(void *__unused)
 	return 0;
 }
 
-static int __devinit envctrl_probe(struct platform_device *op)
+static int envctrl_probe(struct platform_device *op)
 {
 	struct device_node *dp;
 	int index, err;
diff --git a/drivers/sbus/char/flash.c b/drivers/sbus/char/flash.c
index fa918c6..733f492 100644
--- a/drivers/sbus/char/flash.c
+++ b/drivers/sbus/char/flash.c
@@ -159,7 +159,7 @@ static const struct file_operations flash_fops = {
 
 static struct miscdevice flash_dev = { FLASH_MINOR, "flash", &flash_fops };
 
-static int __devinit flash_probe(struct platform_device *op)
+static int flash_probe(struct platform_device *op)
 {
 	struct device_node *dp = op->dev.of_node;
 	struct device_node *parent;
diff --git a/drivers/sbus/char/uctrl.c b/drivers/sbus/char/uctrl.c
index 7b8bd4e..2484633 100644
--- a/drivers/sbus/char/uctrl.c
+++ b/drivers/sbus/char/uctrl.c
@@ -347,7 +347,7 @@ static void uctrl_get_external_status(struct uctrl_driver *driver)
 	
 }
 
-static int __devinit uctrl_probe(struct platform_device *op)
+static int uctrl_probe(struct platform_device *op)
 {
 	struct uctrl_driver *p;
 	int err = -ENOMEM;
-- 
1.8.0


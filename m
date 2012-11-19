From: Bill Pemberton <wfp5p@virginia.edu>
Date: Mon, 19 Nov 2012 18:20:45 +0000
Subject: [PATCH 096/493] sbus: remove use of __devexit_p
Message-Id: <1353349642-3677-96-git-send-email-wfp5p@virginia.edu>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
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
index 5426682..e844bb2 100644
--- a/drivers/sbus/char/bbc_i2c.c
+++ b/drivers/sbus/char/bbc_i2c.c
@@ -413,7 +413,7 @@ static struct platform_driver bbc_i2c_driver = {
 		.of_match_table = bbc_i2c_match,
 	},
 	.probe		= bbc_i2c_probe,
-	.remove		= __devexit_p(bbc_i2c_remove),
+	.remove		= bbc_i2c_remove,
 };
 
 module_platform_driver(bbc_i2c_driver);
diff --git a/drivers/sbus/char/display7seg.c b/drivers/sbus/char/display7seg.c
index b160073..7694e5a 100644
--- a/drivers/sbus/char/display7seg.c
+++ b/drivers/sbus/char/display7seg.c
@@ -272,7 +272,7 @@ static struct platform_driver d7s_driver = {
 		.of_match_table = d7s_match,
 	},
 	.probe		= d7s_probe,
-	.remove		= __devexit_p(d7s_remove),
+	.remove		= d7s_remove,
 };
 
 module_platform_driver(d7s_driver);
diff --git a/drivers/sbus/char/envctrl.c b/drivers/sbus/char/envctrl.c
index 0bc1856..6f36638 100644
--- a/drivers/sbus/char/envctrl.c
+++ b/drivers/sbus/char/envctrl.c
@@ -1135,7 +1135,7 @@ static struct platform_driver envctrl_driver = {
 		.of_match_table = envctrl_match,
 	},
 	.probe		= envctrl_probe,
-	.remove		= __devexit_p(envctrl_remove),
+	.remove		= envctrl_remove,
 };
 
 module_platform_driver(envctrl_driver);
diff --git a/drivers/sbus/char/flash.c b/drivers/sbus/char/flash.c
index 327657e..fa918c6 100644
--- a/drivers/sbus/char/flash.c
+++ b/drivers/sbus/char/flash.c
@@ -212,7 +212,7 @@ static struct platform_driver flash_driver = {
 		.of_match_table = flash_match,
 	},
 	.probe		= flash_probe,
-	.remove		= __devexit_p(flash_remove),
+	.remove		= flash_remove,
 };
 
 module_platform_driver(flash_driver);
diff --git a/drivers/sbus/char/uctrl.c b/drivers/sbus/char/uctrl.c
index a9e468c..7b8bd4e 100644
--- a/drivers/sbus/char/uctrl.c
+++ b/drivers/sbus/char/uctrl.c
@@ -430,7 +430,7 @@ static struct platform_driver uctrl_driver = {
 		.of_match_table = uctrl_match,
 	},
 	.probe		= uctrl_probe,
-	.remove		= __devexit_p(uctrl_remove),
+	.remove		= uctrl_remove,
 };
 
 
-- 
1.8.0


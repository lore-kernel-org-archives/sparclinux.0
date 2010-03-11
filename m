From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 11 Mar 2010 18:23:22 +0000
Subject: [PATCH 17/27] drivers/sbus/of: don't use deprecated field in
Message-Id: <20100311182321.13103.29782.stgit@angua>
List-Id: <sparclinux.vger.kernel.org>
References: <20100311181604.13103.30088.stgit@angua>
In-Reply-To: <20100311181604.13103.30088.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: monstr@monstr.eu, gregkh@suse.de, benh@kernel.crashing.org, akpm@linux-foundation.org, davem@davemloft.net, sfr@canb.auug.org.au, jgarzik@pobox.com, ben-linux@fluff.org, dwmw2@infradead.org, jeremy.kerr@canonical.com, James.Bottomley@suse.de, broonie@opensource.wolfsonmicro.com, microblaze-uclinux@itee.uq.edu.au, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, sparclinux@vger.kernel.org, linux-ide@vger.kernel.org, netdev@vger.kernel.org, linux-i2c@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-scsi@vger.kernel.org, alsa-devel@alsa-project.org

.name, .match_table and .owner are duplicated in both of_platform_driver
and device_driver, so the of_platform_driver copies will be removed soon.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 drivers/sbus/char/bbc_i2c.c     |    7 +++++--
 drivers/sbus/char/display7seg.c |    7 +++++--
 drivers/sbus/char/envctrl.c     |    7 +++++--
 drivers/sbus/char/flash.c       |    7 +++++--
 drivers/sbus/char/uctrl.c       |    7 +++++--
 5 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/sbus/char/bbc_i2c.c b/drivers/sbus/char/bbc_i2c.c
index 1543ac3..8bfdd63 100644
--- a/drivers/sbus/char/bbc_i2c.c
+++ b/drivers/sbus/char/bbc_i2c.c
@@ -414,8 +414,11 @@ static const struct of_device_id bbc_i2c_match[] = {
 MODULE_DEVICE_TABLE(of, bbc_i2c_match);
 
 static struct of_platform_driver bbc_i2c_driver = {
-	.name		= "bbc_i2c",
-	.match_table	= bbc_i2c_match,
+	.driver = {
+		.name = "bbc_i2c",
+		.owner = THIS_MODULE,
+		.of_match_table = bbc_i2c_match,
+	},
 	.probe		= bbc_i2c_probe,
 	.remove		= __devexit_p(bbc_i2c_remove),
 };
diff --git a/drivers/sbus/char/display7seg.c b/drivers/sbus/char/display7seg.c
index d0a10f4..e1db005 100644
--- a/drivers/sbus/char/display7seg.c
+++ b/drivers/sbus/char/display7seg.c
@@ -265,8 +265,11 @@ static const struct of_device_id d7s_match[] = {
 MODULE_DEVICE_TABLE(of, d7s_match);
 
 static struct of_platform_driver d7s_driver = {
-	.name		= DRIVER_NAME,
-	.match_table	= d7s_match,
+	.driver = {
+		.name = DRIVER_NAME,
+		.owner = THIS_MODULE,
+		.of_match_table = d7s_match,
+	},
 	.probe		= d7s_probe,
 	.remove		= __devexit_p(d7s_remove),
 };
diff --git a/drivers/sbus/char/envctrl.c b/drivers/sbus/char/envctrl.c
index 84a4310..dc9e8ef 100644
--- a/drivers/sbus/char/envctrl.c
+++ b/drivers/sbus/char/envctrl.c
@@ -1130,8 +1130,11 @@ static const struct of_device_id envctrl_match[] = {
 MODULE_DEVICE_TABLE(of, envctrl_match);
 
 static struct of_platform_driver envctrl_driver = {
-	.name		= DRIVER_NAME,
-	.match_table	= envctrl_match,
+	.driver = {
+		.name = DRIVER_NAME,
+		.owner = THIS_MODULE,
+		.of_match_table = envctrl_match,
+	},
 	.probe		= envctrl_probe,
 	.remove		= __devexit_p(envctrl_remove),
 };
diff --git a/drivers/sbus/char/flash.c b/drivers/sbus/char/flash.c
index dc8f95d..0e8ae6b 100644
--- a/drivers/sbus/char/flash.c
+++ b/drivers/sbus/char/flash.c
@@ -208,8 +208,11 @@ static const struct of_device_id flash_match[] = {
 MODULE_DEVICE_TABLE(of, flash_match);
 
 static struct of_platform_driver flash_driver = {
-	.name		= "flash",
-	.match_table	= flash_match,
+	.driver = {
+		.name = "flash",
+		.owner = THIS_MODULE,
+		.of_match_table = flash_match,
+	},
 	.probe		= flash_probe,
 	.remove		= __devexit_p(flash_remove),
 };
diff --git a/drivers/sbus/char/uctrl.c b/drivers/sbus/char/uctrl.c
index acc6738..5f25366 100644
--- a/drivers/sbus/char/uctrl.c
+++ b/drivers/sbus/char/uctrl.c
@@ -425,8 +425,11 @@ static const struct of_device_id uctrl_match[] = {
 MODULE_DEVICE_TABLE(of, uctrl_match);
 
 static struct of_platform_driver uctrl_driver = {
-	.name		= "uctrl",
-	.match_table	= uctrl_match,
+	.driver = {
+		.name = "uctrl",
+		.owner = THIS_MODULE,
+		.of_match_table = uctrl_match,
+	},
 	.probe		= uctrl_probe,
 	.remove		= __devexit_p(uctrl_remove),
 };


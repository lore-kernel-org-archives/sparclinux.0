From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 11 Mar 2010 18:22:04 +0000
Subject: [PATCH 03/27] drivers/watchdog/of: don't use deprecated .name and
Message-Id: <20100311182204.13103.79395.stgit@angua>
List-Id: <sparclinux.vger.kernel.org>
References: <20100311181604.13103.30088.stgit@angua>
In-Reply-To: <20100311181604.13103.30088.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: monstr@monstr.eu, gregkh@suse.de, benh@kernel.crashing.org, akpm@linux-foundation.org, davem@davemloft.net, sfr@canb.auug.org.au, jgarzik@pobox.com, ben-linux@fluff.org, dwmw2@infrade

.name, .match_table and .owner are duplicated in both of_platform_driver
and device_driver, so the of_platform_driver copies will be removed soon.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 drivers/watchdog/cpwd.c        |    7 +++++--
 drivers/watchdog/gef_wdt.c     |    8 +++++---
 drivers/watchdog/mpc8xxx_wdt.c |    8 ++++----
 drivers/watchdog/riowd.c       |    7 +++++--
 4 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/watchdog/cpwd.c b/drivers/watchdog/cpwd.c
index 89da14f..4215b5d 100644
--- a/drivers/watchdog/cpwd.c
+++ b/drivers/watchdog/cpwd.c
@@ -676,8 +676,11 @@ static const struct of_device_id cpwd_match[] = {
 MODULE_DEVICE_TABLE(of, cpwd_match);
 
 static struct of_platform_driver cpwd_driver = {
-	.name		= DRIVER_NAME,
-	.match_table	= cpwd_match,
+	.driver = {
+		.name = DRIVER_NAME,
+		.owner = THIS_MODULE,
+		.of_match_table = cpwd_match,
+	},
 	.probe		= cpwd_probe,
 	.remove		= __devexit_p(cpwd_remove),
 };
diff --git a/drivers/watchdog/gef_wdt.c b/drivers/watchdog/gef_wdt.c
index abdbad0..ca0f4c6 100644
--- a/drivers/watchdog/gef_wdt.c
+++ b/drivers/watchdog/gef_wdt.c
@@ -303,9 +303,11 @@ static const struct of_device_id gef_wdt_ids[] = {
 };
 
 static struct of_platform_driver gef_wdt_driver = {
-	.owner		= THIS_MODULE,
-	.name		= "gef_wdt",
-	.match_table	= gef_wdt_ids,
+	.driver = {
+		.name = "gef_wdt",
+		.owner = THIS_MODULE,
+		.of_match_table = gef_wdt_ids,
+	},
 	.probe		= gef_wdt_probe,
 };
 
diff --git a/drivers/watchdog/mpc8xxx_wdt.c b/drivers/watchdog/mpc8xxx_wdt.c
index 4e3941c..7b55974 100644
--- a/drivers/watchdog/mpc8xxx_wdt.c
+++ b/drivers/watchdog/mpc8xxx_wdt.c
@@ -273,12 +273,12 @@ static const struct of_device_id mpc8xxx_wdt_match[] = {
 MODULE_DEVICE_TABLE(of, mpc8xxx_wdt_match);
 
 static struct of_platform_driver mpc8xxx_wdt_driver = {
-	.match_table	= mpc8xxx_wdt_match,
 	.probe		= mpc8xxx_wdt_probe,
 	.remove		= __devexit_p(mpc8xxx_wdt_remove),
-	.driver		= {
-		.name	= "mpc8xxx_wdt",
-		.owner	= THIS_MODULE,
+	.driver = {
+		.name = "mpc8xxx_wdt",
+		.owner = THIS_MODULE,
+		.of_match_table = mpc8xxx_wdt_match,
 	},
 };
 
diff --git a/drivers/watchdog/riowd.c b/drivers/watchdog/riowd.c
index ae57bf9..e7973bf 100644
--- a/drivers/watchdog/riowd.c
+++ b/drivers/watchdog/riowd.c
@@ -238,8 +238,11 @@ static const struct of_device_id riowd_match[] = {
 MODULE_DEVICE_TABLE(of, riowd_match);
 
 static struct of_platform_driver riowd_driver = {
-	.name		= DRIVER_NAME,
-	.match_table	= riowd_match,
+	.driver = {
+		.name = DRIVER_NAME,
+		.owner = THIS_MODULE,
+		.of_match_table = riowd_match,
+	},
 	.probe		= riowd_probe,
 	.remove		= __devexit_p(riowd_remove),
 };


From: David Miller <davem@davemloft.net>
Date: Fri, 29 Aug 2008 22:45:26 +0000
Subject: [PATCH 3/3]: riowd: Distinguish between driver name and OF device
Message-Id: <20080829.154526.19964567.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


riowd: Distinguish between driver name and OF device node name.

Driver messages should print the driver name, rather than the
OF device node name.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 drivers/watchdog/riowd.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/riowd.c b/drivers/watchdog/riowd.c
index 98bb60f..04fd1ba 100644
--- a/drivers/watchdog/riowd.c
+++ b/drivers/watchdog/riowd.c
@@ -48,8 +48,8 @@ MODULE_DESCRIPTION("Hardware watchdog driver for Sun RIO");
 MODULE_SUPPORTED_DEVICE("watchdog");
 MODULE_LICENSE("GPL");
 
-#define RIOWD_NAME	"pmc"
-#define PFX		RIOWD_NAME ": "
+#define DRIVER_NAME	"riowd"
+#define PFX		DRIVER_NAME ": "
 
 struct riowd {
 	void __iomem		*regs;
@@ -92,7 +92,7 @@ static int riowd_ioctl(struct inode *inode, struct file *filp,
 	static struct watchdog_info info = {
 		.options		= WDIOF_SETTIMEOUT,
 		.firmware_version	= 1,
-		.identity		= "riowd",
+		.identity		= DRIVER_NAME,
 	};
 	void __user *argp = (void __user *)arg;
 	struct riowd *p = riowd_device;
@@ -190,7 +190,7 @@ static int __devinit riowd_probe(struct of_device *op,
 
 	spin_lock_init(&p->lock);
 
-	p->regs = of_ioremap(&op->resource[0], 0, 2, "riowd");
+	p->regs = of_ioremap(&op->resource[0], 0, 2, DRIVER_NAME);
 	if (!p->regs) {
 		printk(KERN_ERR PFX "Cannot map registers.\n");
 		goto out_free;
@@ -239,7 +239,7 @@ static struct of_device_id riowd_match[] = {
 MODULE_DEVICE_TABLE(of, riowd_match);
 
 static struct of_platform_driver riowd_driver = {
-	.name		= "riowd",
+	.name		= DRIVER_NAME,
 	.match_table	= riowd_match,
 	.probe		= riowd_probe,
 	.remove		= __devexit_p(riowd_remove),
-- 
1.5.6.5.GIT


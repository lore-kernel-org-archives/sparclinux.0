From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Mon, 22 Feb 2016 03:13:11 +0000
Subject: [PATCH 2/3] drivers/video: make fbdev/sunxvr1000.c explicitly non-modular
Message-Id: <1456110792-21771-3-git-send-email-paul.gortmaker@windriver.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1456110792-21771-1-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1456110792-21771-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-fbdev@vger.kernel.org

The Kconfig currently controlling compilation of this code is:

config FB_XVR1000
        bool "Sun XVR-1000 support"

...meaning that it currently is not being built as a module by anyone.
Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

Since module_init translates to device_initcall in the non-modular
case, the init ordering remains unchanged with this commit.

We explicitly disallow a driver unbind, since that doesn't have a
sensible use case anyway, and it allows us to drop the ".remove"
code for non-modular drivers.

We don't replace module.h with init.h since the file already has that.
Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.

We also delete the MODULE_LICENSE tag etc. since all that information
was (or is now) contained at the top of the file in the comments.

Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/video/fbdev/sunxvr1000.c | 42 +++++++---------------------------------
 1 file changed, 7 insertions(+), 35 deletions(-)

diff --git a/drivers/video/fbdev/sunxvr1000.c b/drivers/video/fbdev/sunxvr1000.c
index 08879bdfad35..fb37f6e05391 100644
--- a/drivers/video/fbdev/sunxvr1000.c
+++ b/drivers/video/fbdev/sunxvr1000.c
@@ -1,9 +1,10 @@
-/* sunxvr1000.c: Sun XVR-1000 driver for sparc64 systems
+/* sunxvr1000.c: Sun XVR-1000 fb driver for sparc64 systems
+ *
+ * License: GPL
  *
  * Copyright (C) 2010 David S. Miller (davem@davemloft.net)
  */
 
-#include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/fb.h>
 #include <linux/init.h>
@@ -173,36 +174,19 @@ err_out:
 	return err;
 }
 
-static int gfb_remove(struct platform_device *op)
-{
-	struct fb_info *info = dev_get_drvdata(&op->dev);
-	struct gfb_info *gp = info->par;
-
-	unregister_framebuffer(info);
-
-	iounmap(gp->fb_base);
-
-	of_iounmap(&op->resource[6], gp->fb_base, gp->fb_size);
-
-        framebuffer_release(info);
-
-	return 0;
-}
-
 static const struct of_device_id gfb_match[] = {
 	{
 		.name = "SUNW,gfb",
 	},
 	{},
 };
-MODULE_DEVICE_TABLE(of, ffb_match);
 
 static struct platform_driver gfb_driver = {
 	.probe		= gfb_probe,
-	.remove		= gfb_remove,
 	.driver = {
-		.name		= "gfb",
-		.of_match_table	= gfb_match,
+		.name			= "gfb",
+		.of_match_table		= gfb_match,
+		.suppress_bind_attrs	= true,
 	},
 };
 
@@ -213,16 +197,4 @@ static int __init gfb_init(void)
 
 	return platform_driver_register(&gfb_driver);
 }
-
-static void __exit gfb_exit(void)
-{
-	platform_driver_unregister(&gfb_driver);
-}
-
-module_init(gfb_init);
-module_exit(gfb_exit);
-
-MODULE_DESCRIPTION("framebuffer driver for Sun XVR-1000 graphics");
-MODULE_AUTHOR("David S. Miller <davem@davemloft.net>");
-MODULE_VERSION("1.0");
-MODULE_LICENSE("GPL");
+device_initcall(gfb_init);
-- 
2.6.1


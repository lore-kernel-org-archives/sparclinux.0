From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Mon, 22 Feb 2016 03:13:10 +0000
Subject: [PATCH 1/3] drivers/video: make fbdev/sunxvr500.c explicitly non-modular
Message-Id: <1456110792-21771-2-git-send-email-paul.gortmaker@windriver.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1456110792-21771-1-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1456110792-21771-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-fbdev@vger.kernel.org

The Kconfig currently controlling compilation of this code is:

config FB_XVR500
        bool "Sun XVR-500 3DLABS Wildcat support"

...meaning that it currently is not being built as a module by anyone.
Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

We explicitly disallow a driver unbind, since that doesn't have a
sensible use case anyway, and it allows us to drop the ".remove"
code for non-modular drivers.

Since module_init translates to device_initcall in the non-modular
case, the init ordering remains unchanged with this commit.

We don't replace module.h with init.h since the file already has that.

We also delete the MODULE_LICENSE tag etc. since all that information
was (or is now) contained at the top of the file in the comments.

Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/video/fbdev/sunxvr500.c | 42 +++++++----------------------------------
 1 file changed, 7 insertions(+), 35 deletions(-)

diff --git a/drivers/video/fbdev/sunxvr500.c b/drivers/video/fbdev/sunxvr500.c
index 387350d004df..dc0d886e4e7e 100644
--- a/drivers/video/fbdev/sunxvr500.c
+++ b/drivers/video/fbdev/sunxvr500.c
@@ -1,9 +1,10 @@
-/* sunxvr500.c: Sun 3DLABS XVR-500 Expert3D driver for sparc64 systems
+/* sunxvr500.c: Sun 3DLABS XVR-500 Expert3D fb driver for sparc64 systems
+ *
+ * License: GPL
  *
  * Copyright (C) 2007 David S. Miller (davem@davemloft.net)
  */
 
-#include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/fb.h>
 #include <linux/pci.h>
@@ -392,25 +393,6 @@ err_out:
 	return err;
 }
 
-static void e3d_pci_unregister(struct pci_dev *pdev)
-{
-	struct fb_info *info = pci_get_drvdata(pdev);
-	struct e3d_info *ep = info->par;
-
-	unregister_framebuffer(info);
-
-	iounmap(ep->ramdac);
-	iounmap(ep->fb_base);
-
-	pci_release_region(pdev, 0);
-	pci_release_region(pdev, 1);
-
-	fb_dealloc_cmap(&info->cmap);
-        framebuffer_release(info);
-
-	pci_disable_device(pdev);
-}
-
 static struct pci_device_id e3d_pci_table[] = {
 	{	PCI_DEVICE(PCI_VENDOR_ID_3DLABS, 0x7a0),	},
 	{	PCI_DEVICE(0x1091, 0x7a0),			},
@@ -434,10 +416,12 @@ static struct pci_device_id e3d_pci_table[] = {
 };
 
 static struct pci_driver e3d_driver = {
+	.driver = {
+		.suppress_bind_attrs = true,
+	},
 	.name		= "e3d",
 	.id_table	= e3d_pci_table,
 	.probe		= e3d_pci_register,
-	.remove		= e3d_pci_unregister,
 };
 
 static int __init e3d_init(void)
@@ -447,16 +431,4 @@ static int __init e3d_init(void)
 
 	return pci_register_driver(&e3d_driver);
 }
-
-static void __exit e3d_exit(void)
-{
-	pci_unregister_driver(&e3d_driver);
-}
-
-module_init(e3d_init);
-module_exit(e3d_exit);
-
-MODULE_DESCRIPTION("framebuffer driver for Sun XVR-500 graphics");
-MODULE_AUTHOR("David S. Miller <davem@davemloft.net>");
-MODULE_VERSION("1.0");
-MODULE_LICENSE("GPL");
+device_initcall(e3d_init);
-- 
2.6.1


From: Christoph Hellwig <hch@lst.de>
Date: Tue, 09 Aug 2005 20:31:19 +0000
Subject: [PATCH] remove ifdef CONFIG_PCI from envctrl.c
Message-Id: <20050809203118.GA28805@lst.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The driver already depends on CONFIG_PCI in Kconfig.  What I don't quite
understand yet is why a PCI-only driver sits in drivers/sbus/ ..


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/drivers/sbus/char/envctrl.c
=================================--- linux-2.6.orig/drivers/sbus/char/envctrl.c	2005-08-09 20:16:59.000000000 +0200
+++ linux-2.6/drivers/sbus/char/envctrl.c	2005-08-09 22:29:45.000000000 +0200
@@ -1041,7 +1041,6 @@
 
 static int __init envctrl_init(void)
 {
-#ifdef CONFIG_PCI
 	struct linux_ebus *ebus = NULL;
 	struct linux_ebus_device *edev = NULL;
 	struct linux_ebus_child *edev_child = NULL;
@@ -1133,9 +1132,6 @@
 			kfree(i2c_childlist[i].tables);
 	}
 	return err;
-#else
-	return -ENODEV;
-#endif
 }
 
 static void __exit envctrl_cleanup(void)

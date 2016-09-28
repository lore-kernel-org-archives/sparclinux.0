From: chris hyser <chris.hyser@oracle.com>
Date: Wed, 28 Sep 2016 19:19:45 +0000
Subject: [PATCH v2 1/2] sparc64: Enable PCI IOMMU version 2 API
Message-Id: <201609281919.u8SJJk6x013125@userv0122.oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Enable Version 2 of the PCI IOMMU API needed for advanced features
such as PCI Relaxed Ordering and greater than 2 GB DMA address
space per root complex.

Signed-off-by: Chris Hyser <chris.hyser@oracle.com>

diff --git a/arch/sparc/kernel/pci_sun4v.c b/arch/sparc/kernel/pci_sun4v.c
index 61c6f93..c5c819d 100644
--- a/arch/sparc/kernel/pci_sun4v.c
+++ b/arch/sparc/kernel/pci_sun4v.c
@@ -30,8 +30,19 @@
 #define DRIVER_NAME	"pci_sun4v"
 #define PFX		DRIVER_NAME ": "
 
-static unsigned long vpci_major = 1;
-static unsigned long vpci_minor = 1;
+static unsigned long vpci_major;
+static unsigned long vpci_minor;
+
+struct vpci_version {
+	unsigned long major;
+	unsigned long minor;
+};
+
+/* Ordered from largest major to lowest */
+static struct vpci_version vpci_versions[] = {
+	{ .major = 2, .minor = 0 },
+	{ .major = 1, .minor = 1 },
+};
 
 #define PGLIST_NENTS	(PAGE_SIZE / sizeof(u64))
 
@@ -907,22 +918,27 @@ static int pci_sun4v_probe(struct platform_device *op)
 	struct device_node *dp;
 	struct iommu *iommu;
 	u32 devhandle;
-	int i, err;
+	int i, err = -ENODEV;
 
 	dp = op->dev.of_node;
 
 	if (!hvapi_negotiated++) {
-		err = sun4v_hvapi_register(HV_GRP_PCI,
-					   vpci_major,
-					   &vpci_minor);
+		for (i = 0; i < ARRAY_SIZE(vpci_versions); i++) {
+			vpci_major = vpci_versions[i].major;
+			vpci_minor = vpci_versions[i].minor;
+
+			err = sun4v_hvapi_register(HV_GRP_PCI, vpci_major,
+						   &vpci_minor);
+			if (!err)
+				break;
+		}
 
 		if (err) {
-			printk(KERN_ERR PFX "Could not register hvapi, "
-			       "err=%d\n", err);
+			pr_err(PFX "Could not register hvapi, err=%d\n", err);
 			return err;
 		}
-		printk(KERN_INFO PFX "Registered hvapi major[%lu] minor[%lu]\n",
-		       vpci_major, vpci_minor);
+		pr_info(PFX "Registered hvapi major[%lu] minor[%lu]\n",
+			vpci_major, vpci_minor);
 
 		dma_ops = &sun4v_dma_ops;
 	}

From: David Miller <davem@davemloft.net>
Date: Thu, 28 Aug 2008 04:23:30 +0000
Subject: [PATCH 5/49]: sparc: Propagate SBUS iommu archdata into real
Message-Id: <20080827.212330.121957399.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc: Propagate SBUS iommu archdata into real of_device objects.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 drivers/sbus/sbus.c |   24 ++++++++++++++++++++----
 1 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/sbus/sbus.c b/drivers/sbus/sbus.c
index 6949162..db0766e 100644
--- a/drivers/sbus/sbus.c
+++ b/drivers/sbus/sbus.c
@@ -30,6 +30,24 @@ static DEVICE_ATTR(obppath, S_IRUSR | S_IRGRP | S_IROTH, show_sbusobppath_attr,
 
 struct sbus_bus *sbus_root;
 
+static void __init fill_sbus_device_iommu(struct sbus_dev *sdev)
+{
+	struct of_device *op = of_find_device_by_node(sdev->ofdev.node);
+	struct dev_archdata *sd, *bus_sd;
+	struct sbus_bus *sbus;
+
+	sbus = sdev->bus;
+	bus_sd = &sbus->ofdev.dev.archdata;
+
+	sd = &sdev->ofdev.dev.archdata;
+	sd->iommu = bus_sd->iommu;
+	sd->stc = bus_sd->stc;
+
+	sd = &op->dev.archdata;
+	sd->iommu = bus_sd->iommu;
+	sd->stc = bus_sd->stc;
+}
+
 static void __init fill_sbus_device(struct device_node *dp, struct sbus_dev *sdev)
 {
 	struct dev_archdata *sd;
@@ -85,6 +103,8 @@ static void __init fill_sbus_device(struct device_node *dp, struct sbus_dev *sde
 
 	/* WE HAVE BEEN INVADED BY ALIENS! */
 	err = sysfs_create_file(&sdev->ofdev.dev.kobj, &dev_attr_obppath.attr);
+
+	fill_sbus_device_iommu(sdev);
 }
 
 static void __init sbus_bus_ranges_init(struct device_node *dp, struct sbus_bus *sbus)
@@ -209,10 +229,6 @@ static void __init walk_children(struct device_node *dp, struct sbus_dev *parent
 
 			sdev->bus = sbus;
 			sdev->parent = parent;
-			sdev->ofdev.dev.archdata.iommu -				sbus->ofdev.dev.archdata.iommu;
-			sdev->ofdev.dev.archdata.stc -				sbus->ofdev.dev.archdata.stc;
 
 			fill_sbus_device(dp, sdev);
 
-- 
1.5.6.5.GIT


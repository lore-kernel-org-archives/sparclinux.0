From: David Miller <davem@davemloft.net>
Date: Thu, 28 Aug 2008 04:24:50 +0000
Subject: [PATCH 36/49]: sparc: Remove dinky old-style SBUS probing
Message-Id: <20080827.212450.99576630.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc: Remove dinky old-style SBUS probing facilities.

No drivers or code uses this stuff any more, every driver has been
converted over to OF device probing.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/sbus_32.h    |   13 -------------
 arch/sparc/include/asm/sbus_64.h    |   13 -------------
 arch/sparc/kernel/sparc_ksyms.c     |    1 -
 arch/sparc64/kernel/sparc64_ksyms.c |    1 -
 drivers/sbus/sbus.c                 |   14 --------------
 5 files changed, 0 insertions(+), 42 deletions(-)

diff --git a/arch/sparc/include/asm/sbus_32.h b/arch/sparc/include/asm/sbus_32.h
index 8f5900b..9f35ae8 100644
--- a/arch/sparc/include/asm/sbus_32.h
+++ b/arch/sparc/include/asm/sbus_32.h
@@ -65,8 +65,6 @@ struct sbus_bus {
 };
 #define to_sbus(d) container_of(d, struct sbus_bus, ofdev.dev)
 
-extern struct sbus_bus *sbus_root;
-
 static inline int
 sbus_is_slave(struct sbus_dev *dev)
 {
@@ -74,17 +72,6 @@ sbus_is_slave(struct sbus_dev *dev)
 	return 0;
 }
 
-/* Device probing routines could find these handy */
-#define for_each_sbus(bus) \
-        for((bus) = sbus_root; (bus); (bus)=(bus)->next)
-
-#define for_each_sbusdev(device, bus) \
-        for((device) = (bus)->devices; (device); (device)=(device)->next)
-
-#define for_all_sbusdev(device, bus) \
-	for ((bus) = sbus_root; (bus); (bus) = (bus)->next) \
-		for ((device) = (bus)->devices; (device); (device) = (device)->next)
-
 /* These yield IOMMU mappings in consistent mode. */
 void prom_adjust_ranges(struct linux_prom_ranges *, int,
 			struct linux_prom_ranges *, int);
diff --git a/arch/sparc/include/asm/sbus_64.h b/arch/sparc/include/asm/sbus_64.h
index 75f95ff..ec3509a 100644
--- a/arch/sparc/include/asm/sbus_64.h
+++ b/arch/sparc/include/asm/sbus_64.h
@@ -66,19 +66,6 @@ struct sbus_bus {
 };
 #define to_sbus(d) container_of(d, struct sbus_bus, ofdev.dev)
 
-extern struct sbus_bus *sbus_root;
-
-/* Device probing routines could find these handy */
-#define for_each_sbus(bus) \
-        for((bus) = sbus_root; (bus); (bus)=(bus)->next)
-
-#define for_each_sbusdev(device, bus) \
-        for((device) = (bus)->devices; (device); (device)=(device)->next)
-
-#define for_all_sbusdev(device, bus) \
-	for ((bus) = sbus_root; (bus); (bus) = (bus)->next) \
-		for ((device) = (bus)->devices; (device); (device) = (device)->next)
-
 extern void sbus_setup_iommu(struct sbus_bus *, struct device_node *);
 extern int sbus_arch_preinit(void);
 extern void sbus_arch_postinit(void);
diff --git a/arch/sparc/kernel/sparc_ksyms.c b/arch/sparc/kernel/sparc_ksyms.c
index b1d2c97..84aaac4 100644
--- a/arch/sparc/kernel/sparc_ksyms.c
+++ b/arch/sparc/kernel/sparc_ksyms.c
@@ -153,7 +153,6 @@ EXPORT_SYMBOL(BTFIXUP_CALL(mmu_release_scsi_one));
 EXPORT_SYMBOL(BTFIXUP_CALL(pgprot_noncached));
 
 #ifdef CONFIG_SBUS
-EXPORT_SYMBOL(sbus_root);
 EXPORT_SYMBOL(sbus_set_sbus64);
 EXPORT_SYMBOL(sbus_iounmap);
 EXPORT_SYMBOL(sbus_ioremap);
diff --git a/arch/sparc64/kernel/sparc64_ksyms.c b/arch/sparc64/kernel/sparc64_ksyms.c
index 901c264..08c58a8 100644
--- a/arch/sparc64/kernel/sparc64_ksyms.c
+++ b/arch/sparc64/kernel/sparc64_ksyms.c
@@ -160,7 +160,6 @@ EXPORT_SYMBOL(auxio_set_led);
 EXPORT_SYMBOL(auxio_set_lte);
 #endif
 #ifdef CONFIG_SBUS
-EXPORT_SYMBOL(sbus_root);
 EXPORT_SYMBOL(sbus_set_sbus64);
 #endif
 EXPORT_SYMBOL(outsb);
diff --git a/drivers/sbus/sbus.c b/drivers/sbus/sbus.c
index 89eb922..3b30f99 100644
--- a/drivers/sbus/sbus.c
+++ b/drivers/sbus/sbus.c
@@ -28,8 +28,6 @@ show_sbusobppath_attr(struct device * dev, struct device_attribute * attr, char
 
 static DEVICE_ATTR(obppath, S_IRUSR | S_IRGRP | S_IROTH, show_sbusobppath_attr, NULL);
 
-struct sbus_bus *sbus_root;
-
 static void __init fill_sbus_device_iommu(struct sbus_dev *sdev)
 {
 	struct of_device *op = of_find_device_by_node(sdev->ofdev.node);
@@ -78,17 +76,6 @@ static void __init fill_sbus_device(struct device_node *dp, struct sbus_dev *sde
 	fill_sbus_device_iommu(sdev);
 }
 
-/* We preserve the "probe order" of these bus and device lists to give
- * the same ordering as the old code.
- */
-static void __init sbus_insert(struct sbus_bus *sbus, struct sbus_bus **root)
-{
-	while (*root)
-		root = &(*root)->next;
-	*root = sbus;
-	sbus->next = NULL;
-}
-
 static void __init sdev_insert(struct sbus_dev *sdev, struct sbus_dev **root)
 {
 	while (*root)
@@ -128,7 +115,6 @@ static void __init build_one_sbus(struct device_node *dp, int num_sbus)
 	if (!sbus)
 		return;
 
-	sbus_insert(sbus, &sbus_root);
 	sbus->prom_node = dp->node;
 
 	sbus_setup_iommu(sbus, dp);
-- 
1.5.6.5.GIT


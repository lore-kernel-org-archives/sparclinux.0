From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 04 Jun 2010 21:11:38 +0000
Subject: [PATCH 2/2] of: kill struct of_device
Message-Id: <20100604211138.2762.35074.stgit@angua>
List-Id: <sparclinux.vger.kernel.org>
References: <20100604205930.2762.17131.stgit@angua>
In-Reply-To: <20100604205930.2762.17131.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Michal Simek <monstr@monstr.eu>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, devicetree-discuss@lists.ozlabs.org, linuxppc-dev@ozlabs.org, microblaze-uclinux@itee.uq.edu.au, sparclinux@vger.kernel.org, "David S. Miller" <davem@davemloft.net>

Now that the device tree node pointer has been moved out of struct
of_device and into the common struct device, there isn't anything
unique about of_device anymore.  In fact, there isn't much need
for a separate of_bus when all busses have access to OF style
probing.

arch/powerpc and arch/microblaze are moving away from using the of_bus
and using the regular platform bus instead for mmio devices.  This
patch makes of_device the same as platform_device as a stepping stone
in migrating of_platform_drivers over to the platform bus.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
CC: Michal Simek <monstr@monstr.eu>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: "David S. Miller" <davem@davemloft.net>
CC: Stephen Rothwell <sfr@canb.auug.org.au>
CC: microblaze-uclinux@itee.uq.edu.au
CC: linuxppc-dev@ozlabs.org
CC: sparclinux@vger.kernel.org
CC: devicetree-discuss@lists.ozlabs.org
---
 arch/microblaze/include/asm/of_device.h |   10 ----------
 arch/powerpc/include/asm/of_device.h    |   11 -----------
 arch/powerpc/include/asm/smu.h          |    4 ++--
 arch/sparc/include/asm/device.h         |    4 ++--
 arch/sparc/include/asm/of_device.h      |   14 --------------
 drivers/net/niu.h                       |    4 ++--
 include/linux/of_device.h               |   17 +++++++++++++++++
 7 files changed, 23 insertions(+), 41 deletions(-)

diff --git a/arch/microblaze/include/asm/of_device.h b/arch/microblaze/include/asm/of_device.h
index 73cb980..0a5f3f9 100644
--- a/arch/microblaze/include/asm/of_device.h
+++ b/arch/microblaze/include/asm/of_device.h
@@ -15,16 +15,6 @@
 #include <linux/device.h>
 #include <linux/of.h>
 
-/*
- * The of_device is a kind of "base class" that is a superset of
- * struct device for use by devices attached to an OF node and
- * probed using OF properties.
- */
-struct of_device {
-	struct device		dev; /* Generic device interface */
-	struct pdev_archdata	archdata;
-};
-
 extern ssize_t of_device_get_modalias(struct of_device *ofdev,
 					char *str, ssize_t len);
 
diff --git a/arch/powerpc/include/asm/of_device.h b/arch/powerpc/include/asm/of_device.h
index 444e97e..cb36632 100644
--- a/arch/powerpc/include/asm/of_device.h
+++ b/arch/powerpc/include/asm/of_device.h
@@ -5,17 +5,6 @@
 #include <linux/device.h>
 #include <linux/of.h>
 
-/*
- * The of_device is a kind of "base class" that is a superset of
- * struct device for use by devices attached to an OF node and
- * probed using OF properties.
- */
-struct of_device
-{
-	struct device		dev;		/* Generic device interface */
-	struct pdev_archdata	archdata;
-};
-
 extern struct of_device *of_device_alloc(struct device_node *np,
 					 const char *bus_id,
 					 struct device *parent);
diff --git a/arch/powerpc/include/asm/smu.h b/arch/powerpc/include/asm/smu.h
index 7ae2753..e3bdada 100644
--- a/arch/powerpc/include/asm/smu.h
+++ b/arch/powerpc/include/asm/smu.h
@@ -457,8 +457,8 @@ extern void smu_poll(void);
  */
 extern int smu_init(void);
 extern int smu_present(void);
-struct of_device;
-extern struct of_device *smu_get_ofdev(void);
+struct platform_device;
+extern struct platform_device *smu_get_ofdev(void);
 
 
 /*
diff --git a/arch/sparc/include/asm/device.h b/arch/sparc/include/asm/device.h
index f9740d0..fb220e4 100644
--- a/arch/sparc/include/asm/device.h
+++ b/arch/sparc/include/asm/device.h
@@ -9,13 +9,13 @@
 #include <asm/openprom.h>
 
 struct device_node;
-struct of_device;
+struct platform_device;
 
 struct dev_archdata {
 	void			*iommu;
 	void			*stc;
 	void			*host_controller;
-	struct of_device	*op;
+	struct platform_device	*op;
 	int			numa_node;
 };
 
diff --git a/arch/sparc/include/asm/of_device.h b/arch/sparc/include/asm/of_device.h
index 6d1844a..22b9828 100644
--- a/arch/sparc/include/asm/of_device.h
+++ b/arch/sparc/include/asm/of_device.h
@@ -7,20 +7,6 @@
 #include <linux/mod_devicetable.h>
 #include <asm/openprom.h>
 
-/*
- * The of_device is a kind of "base class" that is a superset of
- * struct device for use by devices attached to an OF node and
- * probed using OF properties.
- */
-struct of_device
-{
-	struct device			dev;
-	u32				num_resources;
-	struct resource			*resource;
-
-	struct pdev_archdata		archdata;
-};
-
 extern void __iomem *of_ioremap(struct resource *res, unsigned long offset, unsigned long size, char *name);
 extern void of_iounmap(struct resource *res, void __iomem *base, unsigned long size);
 
diff --git a/drivers/net/niu.h b/drivers/net/niu.h
index d671546..a41fa8e 100644
--- a/drivers/net/niu.h
+++ b/drivers/net/niu.h
@@ -3236,7 +3236,7 @@ struct niu_phy_ops {
 	int (*link_status)(struct niu *np, int *);
 };
 
-struct of_device;
+struct platform_device;
 struct niu {
 	void __iomem			*regs;
 	struct net_device		*dev;
@@ -3297,7 +3297,7 @@ struct niu {
 	struct niu_vpd			vpd;
 	u32				eeprom_len;
 
-	struct of_device		*op;
+	struct platform_device		*op;
 	void __iomem			*vir_regs_1;
 	void __iomem			*vir_regs_2;
 };
diff --git a/include/linux/of_device.h b/include/linux/of_device.h
index 11651fa..a3ae590 100644
--- a/include/linux/of_device.h
+++ b/include/linux/of_device.h
@@ -3,9 +3,26 @@
 
 #ifdef CONFIG_OF_DEVICE
 #include <linux/device.h>
+#include <linux/platform_device.h>
 #include <linux/of.h>
 #include <linux/mod_devicetable.h>
 
+
+/*
+ * The of_device *was* a kind of "base class" that was a superset of
+ * struct device for use by devices attached to an OF node and probed
+ * using OF properties.  However, the important bit of OF-style
+ * probing, namely the device node pointer, has been moved into the
+ * common struct device when CONFIG_OF is set to make OF-style probing
+ * available to all bus types.  So now, just make of_device and
+ * platform_device equivalent so that current of_platform bus users
+ * can be transparently migrated over to using the platform bus.
+ *
+ * This line will go away once all references to of_device are removed
+ * from the kernel.
+ */
+#define of_device platform_device
+
 #include <asm/of_device.h>
 
 #define	to_of_device(d) container_of(d, struct of_device, dev)


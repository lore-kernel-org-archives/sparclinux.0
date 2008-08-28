From: David Miller <davem@davemloft.net>
Date: Thu, 28 Aug 2008 04:24:59 +0000
Subject: [PATCH 40/49]: sparc: Kill OBP property members of sbus_dev and
Message-Id: <20080827.212459.82996588.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc: Kill OBP property members of sbus_dev and sbus_bus

Unused.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/sbus_32.h |    6 ------
 arch/sparc/include/asm/sbus_64.h |    7 -------
 drivers/sbus/sbus.c              |   18 +-----------------
 3 files changed, 1 insertions(+), 30 deletions(-)

diff --git a/arch/sparc/include/asm/sbus_32.h b/arch/sparc/include/asm/sbus_32.h
index fdaf1a7..99f79e4 100644
--- a/arch/sparc/include/asm/sbus_32.h
+++ b/arch/sparc/include/asm/sbus_32.h
@@ -30,9 +30,6 @@ struct sbus_dev {
 	struct sbus_dev		*next;
 	struct sbus_dev		*child;
 	struct sbus_dev		*parent;
-	int prom_node;
-	char prom_name[64];
-	int slot;
 };
 #define to_sbus_device(d) container_of(d, struct sbus_dev, ofdev.dev)
 
@@ -41,9 +38,6 @@ struct sbus_bus {
 	struct of_device	ofdev;
 	struct sbus_dev		*devices;	/* Link to devices on this SBus */
 	struct sbus_bus		*next;		/* next SBus, if more than one SBus */
-	int			prom_node;	/* PROM device tree node for this SBus */
-	char			prom_name[64];  /* Usually "sbus" or "sbi" */
-	int			clock_freq;
 };
 #define to_sbus(d) container_of(d, struct sbus_bus, ofdev.dev)
 
diff --git a/arch/sparc/include/asm/sbus_64.h b/arch/sparc/include/asm/sbus_64.h
index 6b3b055..b7b7694 100644
--- a/arch/sparc/include/asm/sbus_64.h
+++ b/arch/sparc/include/asm/sbus_64.h
@@ -30,9 +30,6 @@ struct sbus_dev {
 	struct sbus_dev		*next;
 	struct sbus_dev		*child;
 	struct sbus_dev		*parent;
-	int prom_node;
-	char prom_name[64];
-	int slot;
 };
 #define to_sbus_device(d) container_of(d, struct sbus_dev, ofdev.dev)
 
@@ -41,10 +38,6 @@ struct sbus_bus {
 	struct of_device	ofdev;
 	struct sbus_dev		*devices;	/* Tree of SBUS devices	*/
 	struct sbus_bus		*next;		/* Next SBUS in system	*/
-	int			prom_node;      /* OBP node of SBUS	*/
-	char			prom_name[64];	/* Usually "sbus" or "sbi" */
-	int			clock_freq;
-	int portid;
 };
 #define to_sbus(d) container_of(d, struct sbus_bus, ofdev.dev)
 
diff --git a/drivers/sbus/sbus.c b/drivers/sbus/sbus.c
index 3b30f99..64c3e45 100644
--- a/drivers/sbus/sbus.c
+++ b/drivers/sbus/sbus.c
@@ -51,9 +51,6 @@ static void __init fill_sbus_device(struct device_node *dp, struct sbus_dev *sde
 	struct dev_archdata *sd;
 	int err;
 
-	sdev->prom_node = dp->node;
-	strcpy(sdev->prom_name, dp->name);
-
 	sd = &sdev->ofdev.dev.archdata;
 	sd->prom_node = dp;
 	sd->op = &sdev->ofdev;
@@ -107,30 +104,17 @@ static void __init walk_children(struct device_node *dp, struct sbus_dev *parent
 
 static void __init build_one_sbus(struct device_node *dp, int num_sbus)
 {
-	struct sbus_bus *sbus;
-	unsigned int sbus_clock;
 	struct device_node *dev_dp;
+	struct sbus_bus *sbus;
 
 	sbus = kzalloc(sizeof(struct sbus_bus), GFP_ATOMIC);
 	if (!sbus)
 		return;
 
-	sbus->prom_node = dp->node;
-
 	sbus_setup_iommu(sbus, dp);
 
 	printk("sbus%d: ", num_sbus);
 
-	sbus_clock = of_getintprop_default(dp, "clock-frequency",
-					   (25*1000*1000));
-	sbus->clock_freq = sbus_clock;
-
-	printk("Clock %d.%d MHz\n", (int) ((sbus_clock/1000)/1000),
-	       (int) (((sbus_clock/1000)%1000 != 0) ? 
-		      (((sbus_clock/1000)%1000) + 1000) : 0));
-
-	strcpy(sbus->prom_name, dp->name);
-
 	sbus->ofdev.node = dp;
 	sbus->ofdev.dev.parent = NULL;
 	sbus->ofdev.dev.bus = &sbus_bus_type;
-- 
1.5.6.5.GIT


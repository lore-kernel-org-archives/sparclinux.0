From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 01 Jan 2013 15:02:33 +0000
Subject: [PATCH] sparc: remove __devinit, __devexit annotations
Message-Id: <20130101150233.GA16318@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

__devinit, __devexit annotations are nops - so drop them.
Likewise for __devexit_p.

Adjusted alignment of arguments when needed.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
Build tested with sparc32 only!

	Sam

diff --git a/arch/sparc/include/asm/parport.h b/arch/sparc/include/asm/parport.h
index cb33608..c55291e 100644
--- a/arch/sparc/include/asm/parport.h
+++ b/arch/sparc/include/asm/parport.h
@@ -103,7 +103,7 @@ static inline unsigned int get_dma_residue(unsigned int dmanr)
 	return ebus_dma_residue(&sparc_ebus_dmas[dmanr].info);
 }
 
-static int __devinit ecpp_probe(struct platform_device *op)
+static int ecpp_probe(struct platform_device *op)
 {
 	unsigned long base = op->resource[0].start;
 	unsigned long config = op->resource[1].start;
@@ -192,7 +192,7 @@ out_err:
 	return err;
 }
 
-static int __devexit ecpp_remove(struct platform_device *op)
+static int ecpp_remove(struct platform_device *op)
 {
 	struct parport *p = dev_get_drvdata(&op->dev);
 	int slot = p->dma;
@@ -242,7 +242,7 @@ static struct platform_driver ecpp_driver = {
 		.of_match_table = ecpp_match,
 	},
 	.probe			= ecpp_probe,
-	.remove			= __devexit_p(ecpp_remove),
+	.remove			= ecpp_remove,
 };
 
 static int parport_pc_find_nonpci_ports(int autoirq, int autodma)
diff --git a/arch/sparc/include/asm/timer_64.h b/arch/sparc/include/asm/timer_64.h
index ef3c368..01197d8 100644
--- a/arch/sparc/include/asm/timer_64.h
+++ b/arch/sparc/include/asm/timer_64.h
@@ -24,7 +24,7 @@ struct sparc64_tick_ops {
 extern struct sparc64_tick_ops *tick_ops;
 
 extern unsigned long sparc64_get_clock_tick(unsigned int cpu);
-extern void __devinit setup_sparc64_timer(void);
+extern void setup_sparc64_timer(void);
 extern void __init time_init(void);
 
 #endif /* _SPARC64_TIMER_H */
diff --git a/arch/sparc/kernel/apc.c b/arch/sparc/kernel/apc.c
index 812e10b..348fa1a 100644
--- a/arch/sparc/kernel/apc.c
+++ b/arch/sparc/kernel/apc.c
@@ -31,7 +31,7 @@
 #define APC_DEVNAME "apc"
 
 static u8 __iomem *regs;
-static int apc_no_idle __devinitdata = 0;
+static int apc_no_idle = 0;
 
 #define apc_readb(offs)		(sbus_readb(regs+offs))
 #define apc_writeb(val, offs) 	(sbus_writeb(val, regs+offs))
@@ -138,7 +138,7 @@ static const struct file_operations apc_fops = {
 
 static struct miscdevice apc_miscdev = { APC_MINOR, APC_DEVNAME, &apc_fops };
 
-static int __devinit apc_probe(struct platform_device *op)
+static int apc_probe(struct platform_device *op)
 {
 	int err;
 
diff --git a/arch/sparc/kernel/auxio_64.c b/arch/sparc/kernel/auxio_64.c
index 773091a..86e5577 100644
--- a/arch/sparc/kernel/auxio_64.c
+++ b/arch/sparc/kernel/auxio_64.c
@@ -102,7 +102,7 @@ static const struct of_device_id auxio_match[] = {
 
 MODULE_DEVICE_TABLE(of, auxio_match);
 
-static int __devinit auxio_probe(struct platform_device *dev)
+static int auxio_probe(struct platform_device *dev)
 {
 	struct device_node *dp = dev->dev.of_node;
 	unsigned long size;
diff --git a/arch/sparc/kernel/central.c b/arch/sparc/kernel/central.c
index 9708851..052b5a4 100644
--- a/arch/sparc/kernel/central.c
+++ b/arch/sparc/kernel/central.c
@@ -33,7 +33,7 @@ struct fhc {
 	struct platform_device	leds_pdev;
 };
 
-static int __devinit clock_board_calc_nslots(struct clock_board *p)
+static int clock_board_calc_nslots(struct clock_board *p)
 {
 	u8 reg = upa_readb(p->clock_regs + CLOCK_STAT1) & 0xc0;
 
@@ -60,7 +60,7 @@ static int __devinit clock_board_calc_nslots(struct clock_board *p)
 	}
 }
 
-static int __devinit clock_board_probe(struct platform_device *op)
+static int clock_board_probe(struct platform_device *op)
 {
 	struct clock_board *p = kzalloc(sizeof(*p), GFP_KERNEL);
 	int err = -ENOMEM;
@@ -157,7 +157,7 @@ static struct platform_driver clock_board_driver = {
 	},
 };
 
-static int __devinit fhc_probe(struct platform_device *op)
+static int fhc_probe(struct platform_device *op)
 {
 	struct fhc *p = kzalloc(sizeof(*p), GFP_KERNEL);
 	int err = -ENOMEM;
diff --git a/arch/sparc/kernel/chmc.c b/arch/sparc/kernel/chmc.c
index 5f45026..dbb210d 100644
--- a/arch/sparc/kernel/chmc.c
+++ b/arch/sparc/kernel/chmc.c
@@ -336,9 +336,9 @@ static int jbusmc_print_dimm(int syndrome_code,
 	return 0;
 }
 
-static u64 __devinit jbusmc_dimm_group_size(u64 base,
-					    const struct linux_prom64_registers *mem_regs,
-					    int num_mem_regs)
+static u64 jbusmc_dimm_group_size(u64 base,
+				  const struct linux_prom64_registers *mem_regs,
+				  int num_mem_regs)
 {
 	u64 max = base + (8UL * 1024 * 1024 * 1024);
 	u64 max_seen = base;
@@ -363,10 +363,10 @@ static u64 __devinit jbusmc_dimm_group_size(u64 base,
 	return max_seen - base;
 }
 
-static void __devinit jbusmc_construct_one_dimm_group(struct jbusmc *p,
-						      unsigned long index,
-						      const struct linux_prom64_registers *mem_regs,
-						      int num_mem_regs)
+static void jbusmc_construct_one_dimm_group(struct jbusmc *p,
+					    unsigned long index,
+					    const struct linux_prom64_registers *mem_regs,
+					    int num_mem_regs)
 {
 	struct jbusmc_dimm_group *dp = &p->dimm_groups[index];
 
@@ -378,9 +378,9 @@ static void __devinit jbusmc_construct_one_dimm_group(struct jbusmc *p,
 	dp->size = jbusmc_dimm_group_size(dp->base_addr, mem_regs, num_mem_regs);
 }
 
-static void __devinit jbusmc_construct_dimm_groups(struct jbusmc *p,
-						   const struct linux_prom64_registers *mem_regs,
-						   int num_mem_regs)
+static void jbusmc_construct_dimm_groups(struct jbusmc *p,
+					 const struct linux_prom64_registers *mem_regs,
+					 int num_mem_regs)
 {
 	if (p->mc_reg_1 & JB_MC_REG1_DIMM1_BANK0) {
 		jbusmc_construct_one_dimm_group(p, 0, mem_regs, num_mem_regs);
@@ -392,7 +392,7 @@ static void __devinit jbusmc_construct_dimm_groups(struct jbusmc *p,
 	}
 }
 
-static int __devinit jbusmc_probe(struct platform_device *op)
+static int jbusmc_probe(struct platform_device *op)
 {
 	const struct linux_prom64_registers *mem_regs;
 	struct device_node *mem_node;
@@ -689,7 +689,7 @@ static void chmc_fetch_decode_regs(struct chmc *p)
 				      chmc_read_mcreg(p, CHMCTRL_DECODE4));
 }
 
-static int __devinit chmc_probe(struct platform_device *op)
+static int chmc_probe(struct platform_device *op)
 {
 	struct device_node *dp = op->dev.of_node;
 	unsigned long ver;
@@ -763,7 +763,7 @@ out_free:
 	goto out;
 }
 
-static int __devinit us3mc_probe(struct platform_device *op)
+static int us3mc_probe(struct platform_device *op)
 {
 	if (mc_type = MC_TYPE_SAFARI)
 		return chmc_probe(op);
@@ -772,21 +772,21 @@ static int __devinit us3mc_probe(struct platform_device *op)
 	return -ENODEV;
 }
 
-static void __devexit chmc_destroy(struct platform_device *op, struct chmc *p)
+static void chmc_destroy(struct platform_device *op, struct chmc *p)
 {
 	list_del(&p->list);
 	of_iounmap(&op->resource[0], p->regs, 0x48);
 	kfree(p);
 }
 
-static void __devexit jbusmc_destroy(struct platform_device *op, struct jbusmc *p)
+static void jbusmc_destroy(struct platform_device *op, struct jbusmc *p)
 {
 	mc_list_del(&p->list);
 	of_iounmap(&op->resource[0], p->regs, JBUSMC_REGS_SIZE);
 	kfree(p);
 }
 
-static int __devexit us3mc_remove(struct platform_device *op)
+static int us3mc_remove(struct platform_device *op)
 {
 	void *p = dev_get_drvdata(&op->dev);
 
@@ -814,7 +814,7 @@ static struct platform_driver us3mc_driver = {
 		.of_match_table = us3mc_match,
 	},
 	.probe		= us3mc_probe,
-	.remove		= __devexit_p(us3mc_remove),
+	.remove		= us3mc_remove,
 };
 
 static inline bool us3mc_platform(void)
diff --git a/arch/sparc/kernel/ds.c b/arch/sparc/kernel/ds.c
index f09257c..75bb608 100644
--- a/arch/sparc/kernel/ds.c
+++ b/arch/sparc/kernel/ds.c
@@ -29,7 +29,7 @@
 #define DRV_MODULE_VERSION	"1.0"
 #define DRV_MODULE_RELDATE	"Jul 11, 2007"
 
-static char version[] __devinitdata +static char version[]  	DRV_MODULE_NAME ".c:v" DRV_MODULE_VERSION " (" DRV_MODULE_RELDATE ")\n";
 MODULE_AUTHOR("David S. Miller (davem@davemloft.net)");
 MODULE_DESCRIPTION("Sun LDOM domain services driver");
@@ -1146,8 +1146,7 @@ static void ds_event(void *arg, int event)
 	spin_unlock_irqrestore(&ds_lock, flags);
 }
 
-static int __devinit ds_probe(struct vio_dev *vdev,
-			      const struct vio_device_id *id)
+static int ds_probe(struct vio_dev *vdev, const struct vio_device_id *id)
 {
 	static int ds_version_printed;
 	struct ldc_channel_config ds_cfg = {
diff --git a/arch/sparc/kernel/ldc.c b/arch/sparc/kernel/ldc.c
index 81d92fc..9fcc6b4 100644
--- a/arch/sparc/kernel/ldc.c
+++ b/arch/sparc/kernel/ldc.c
@@ -27,7 +27,7 @@
 #define DRV_MODULE_VERSION	"1.1"
 #define DRV_MODULE_RELDATE	"July 22, 2008"
 
-static char version[] __devinitdata +static char version[]  	DRV_MODULE_NAME ".c:v" DRV_MODULE_VERSION " (" DRV_MODULE_RELDATE ")\n";
 #define LDC_PACKET_SIZE		64
 
diff --git a/arch/sparc/kernel/leon_pci.c b/arch/sparc/kernel/leon_pci.c
index fc05211..852dc84 100644
--- a/arch/sparc/kernel/leon_pci.c
+++ b/arch/sparc/kernel/leon_pci.c
@@ -43,7 +43,7 @@ void leon_pci_init(struct platform_device *ofdev, struct leon_pci_info *info)
 	}
 }
 
-void __devinit pcibios_fixup_bus(struct pci_bus *pbus)
+void pcibios_fixup_bus(struct pci_bus *pbus)
 {
 	struct pci_dev *dev;
 	int i, has_io, has_mem;
diff --git a/arch/sparc/kernel/leon_pci_grpci2.c b/arch/sparc/kernel/leon_pci_grpci2.c
index b1bc388..fc43208 100644
--- a/arch/sparc/kernel/leon_pci_grpci2.c
+++ b/arch/sparc/kernel/leon_pci_grpci2.c
@@ -668,7 +668,7 @@ static irqreturn_t grpci2_err_interrupt(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
-static int __devinit grpci2_of_probe(struct platform_device *ofdev)
+static int grpci2_of_probe(struct platform_device *ofdev)
 {
 	struct grpci2_regs *regs;
 	struct grpci2_priv *priv;
diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index 75b31bc..baf4366 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -356,7 +356,7 @@ static struct pci_dev *of_create_pci_dev(struct pci_pbm_info *pbm,
 	return dev;
 }
 
-static void __devinit apb_calc_first_last(u8 map, u32 *first_p, u32 *last_p)
+static void apb_calc_first_last(u8 map, u32 *first_p, u32 *last_p)
 {
 	u32 idx, first, last;
 
@@ -378,9 +378,9 @@ static void __devinit apb_calc_first_last(u8 map, u32 *first_p, u32 *last_p)
 /* Cook up fake bus resources for SUNW,simba PCI bridges which lack
  * a proper 'ranges' property.
  */
-static void __devinit apb_fake_ranges(struct pci_dev *dev,
-				      struct pci_bus *bus,
-				      struct pci_pbm_info *pbm)
+static void apb_fake_ranges(struct pci_dev *dev,
+			    struct pci_bus *bus,
+			    struct pci_pbm_info *pbm)
 {
 	struct pci_bus_region region;
 	struct resource *res;
@@ -404,15 +404,15 @@ static void __devinit apb_fake_ranges(struct pci_dev *dev,
 	pcibios_bus_to_resource(dev, res, &region);
 }
 
-static void __devinit pci_of_scan_bus(struct pci_pbm_info *pbm,
-				      struct device_node *node,
-				      struct pci_bus *bus);
+static void pci_of_scan_bus(struct pci_pbm_info *pbm,
+			    struct device_node *node,
+			    struct pci_bus *bus);
 
 #define GET_64BIT(prop, i)	((((u64) (prop)[(i)]) << 32) | (prop)[(i)+1])
 
-static void __devinit of_scan_pci_bridge(struct pci_pbm_info *pbm,
-					 struct device_node *node,
-					 struct pci_dev *dev)
+static void of_scan_pci_bridge(struct pci_pbm_info *pbm,
+			       struct device_node *node,
+			       struct pci_dev *dev)
 {
 	struct pci_bus *bus;
 	const u32 *busrange, *ranges;
@@ -503,9 +503,9 @@ after_ranges:
 	pci_of_scan_bus(pbm, node, bus);
 }
 
-static void __devinit pci_of_scan_bus(struct pci_pbm_info *pbm,
-				      struct device_node *node,
-				      struct pci_bus *bus)
+static void pci_of_scan_bus(struct pci_pbm_info *pbm,
+			    struct device_node *node,
+			    struct pci_bus *bus)
 {
 	struct device_node *child;
 	const u32 *reg;
@@ -564,7 +564,7 @@ show_pciobppath_attr(struct device * dev, struct device_attribute * attr, char *
 
 static DEVICE_ATTR(obppath, S_IRUSR | S_IRGRP | S_IROTH, show_pciobppath_attr, NULL);
 
-static void __devinit pci_bus_register_of_sysfs(struct pci_bus *bus)
+static void pci_bus_register_of_sysfs(struct pci_bus *bus)
 {
 	struct pci_dev *dev;
 	struct pci_bus *child_bus;
@@ -585,8 +585,8 @@ static void __devinit pci_bus_register_of_sysfs(struct pci_bus *bus)
 		pci_bus_register_of_sysfs(child_bus);
 }
 
-struct pci_bus * __devinit pci_scan_one_pbm(struct pci_pbm_info *pbm,
-					    struct device *parent)
+struct pci_bus *pci_scan_one_pbm(struct pci_pbm_info *pbm,
+				 struct device *parent)
 {
 	LIST_HEAD(resources);
 	struct device_node *node = pbm->op->dev.of_node;
@@ -618,7 +618,7 @@ struct pci_bus * __devinit pci_scan_one_pbm(struct pci_pbm_info *pbm,
 	return bus;
 }
 
-void __devinit pcibios_fixup_bus(struct pci_bus *pbus)
+void pcibios_fixup_bus(struct pci_bus *pbus)
 {
 }
 
@@ -949,8 +949,7 @@ static int __init pcibios_init(void)
 subsys_initcall(pcibios_init);
 
 #ifdef CONFIG_SYSFS
-static void __devinit pci_bus_slot_names(struct device_node *node,
-					 struct pci_bus *bus)
+static void pci_bus_slot_names(struct device_node *node, struct pci_bus *bus)
 {
 	const struct pci_slot_names {
 		u32	slot_mask;
diff --git a/arch/sparc/kernel/pci_fire.c b/arch/sparc/kernel/pci_fire.c
index 188f935..e60fc6a 100644
--- a/arch/sparc/kernel/pci_fire.c
+++ b/arch/sparc/kernel/pci_fire.c
@@ -408,8 +408,8 @@ static void pci_fire_hw_init(struct pci_pbm_info *pbm)
 	upa_writeq(~(u64)0, pbm->pbm_regs + FIRE_PEC_IENAB);
 }
 
-static int __devinit pci_fire_pbm_init(struct pci_pbm_info *pbm,
-				       struct platform_device *op, u32 portid)
+static int pci_fire_pbm_init(struct pci_pbm_info *pbm,
+			     struct platform_device *op, u32 portid)
 {
 	const struct linux_prom64_registers *regs;
 	struct device_node *dp = op->dev.of_node;
@@ -454,7 +454,7 @@ static int __devinit pci_fire_pbm_init(struct pci_pbm_info *pbm,
 	return 0;
 }
 
-static int __devinit fire_probe(struct platform_device *op)
+static int fire_probe(struct platform_device *op)
 {
 	struct device_node *dp = op->dev.of_node;
 	struct pci_pbm_info *pbm;
diff --git a/arch/sparc/kernel/pci_psycho.c b/arch/sparc/kernel/pci_psycho.c
index f4d29e1..c647634 100644
--- a/arch/sparc/kernel/pci_psycho.c
+++ b/arch/sparc/kernel/pci_psycho.c
@@ -366,8 +366,8 @@ static void pbm_config_busmastering(struct pci_pbm_info *pbm)
 	pci_config_write8(addr, 64);
 }
 
-static void __devinit psycho_scan_bus(struct pci_pbm_info *pbm,
-				      struct device *parent)
+static void psycho_scan_bus(struct pci_pbm_info *pbm,
+			    struct device *parent)
 {
 	pbm_config_busmastering(pbm);
 	pbm->is_66mhz_capable = 0;
@@ -483,15 +483,15 @@ static void psycho_pbm_strbuf_init(struct pci_pbm_info *pbm,
 #define PSYCHO_MEMSPACE_B	0x180000000UL
 #define PSYCHO_MEMSPACE_SIZE	0x07fffffffUL
 
-static void __devinit psycho_pbm_init(struct pci_pbm_info *pbm,
-				      struct platform_device *op, int is_pbm_a)
+static void psycho_pbm_init(struct pci_pbm_info *pbm,
+			    struct platform_device *op, int is_pbm_a)
 {
 	psycho_pbm_init_common(pbm, op, "PSYCHO", PBM_CHIP_TYPE_PSYCHO);
 	psycho_pbm_strbuf_init(pbm, is_pbm_a);
 	psycho_scan_bus(pbm, &op->dev);
 }
 
-static struct pci_pbm_info * __devinit psycho_find_sibling(u32 upa_portid)
+static struct pci_pbm_info *psycho_find_sibling(u32 upa_portid)
 {
 	struct pci_pbm_info *pbm;
 
@@ -504,7 +504,7 @@ static struct pci_pbm_info * __devinit psycho_find_sibling(u32 upa_portid)
 
 #define PSYCHO_CONFIGSPACE	0x001000000UL
 
-static int __devinit psycho_probe(struct platform_device *op)
+static int psycho_probe(struct platform_device *op)
 {
 	const struct linux_prom64_registers *pr_regs;
 	struct device_node *dp = op->dev.of_node;
diff --git a/arch/sparc/kernel/pci_sabre.c b/arch/sparc/kernel/pci_sabre.c
index 3efaa46..6f00d27 100644
--- a/arch/sparc/kernel/pci_sabre.c
+++ b/arch/sparc/kernel/pci_sabre.c
@@ -403,8 +403,7 @@ static void apb_init(struct pci_bus *sabre_bus)
 	}
 }
 
-static void __devinit sabre_scan_bus(struct pci_pbm_info *pbm,
-				     struct device *parent)
+static void sabre_scan_bus(struct pci_pbm_info *pbm, struct device *parent)
 {
 	static int once;
 
@@ -443,8 +442,8 @@ static void __devinit sabre_scan_bus(struct pci_pbm_info *pbm,
 	sabre_register_error_handlers(pbm);
 }
 
-static void __devinit sabre_pbm_init(struct pci_pbm_info *pbm,
-				     struct platform_device *op)
+static void sabre_pbm_init(struct pci_pbm_info *pbm,
+			   struct platform_device *op)
 {
 	psycho_pbm_init_common(pbm, op, "SABRE", PBM_CHIP_TYPE_SABRE);
 	pbm->pci_afsr = pbm->controller_regs + SABRE_PIOAFSR;
@@ -454,7 +453,7 @@ static void __devinit sabre_pbm_init(struct pci_pbm_info *pbm,
 }
 
 static const struct of_device_id sabre_match[];
-static int __devinit sabre_probe(struct platform_device *op)
+static int sabre_probe(struct platform_device *op)
 {
 	const struct of_device_id *match;
 	const struct linux_prom64_registers *pr_regs;
diff --git a/arch/sparc/kernel/pci_schizo.c b/arch/sparc/kernel/pci_schizo.c
index 13d4aa2..8f76f23 100644
--- a/arch/sparc/kernel/pci_schizo.c
+++ b/arch/sparc/kernel/pci_schizo.c
@@ -1064,8 +1064,7 @@ static void pbm_config_busmastering(struct pci_pbm_info *pbm)
 	pci_config_write8(addr, 64);
 }
 
-static void __devinit schizo_scan_bus(struct pci_pbm_info *pbm,
-				      struct device *parent)
+static void schizo_scan_bus(struct pci_pbm_info *pbm, struct device *parent)
 {
 	pbm_config_busmastering(pbm);
 	pbm->is_66mhz_capable @@ -1307,9 +1306,9 @@ static void schizo_pbm_hw_init(struct pci_pbm_info *pbm)
 	}
 }
 
-static int __devinit schizo_pbm_init(struct pci_pbm_info *pbm,
-				     struct platform_device *op, u32 portid,
-				     int chip_type)
+static int schizo_pbm_init(struct pci_pbm_info *pbm,
+			   struct platform_device *op, u32 portid,
+			   int chip_type)
 {
 	const struct linux_prom64_registers *regs;
 	struct device_node *dp = op->dev.of_node;
@@ -1400,8 +1399,7 @@ static inline int portid_compare(u32 x, u32 y, int chip_type)
 	return (x = y);
 }
 
-static struct pci_pbm_info * __devinit schizo_find_sibling(u32 portid,
-							   int chip_type)
+static struct pci_pbm_info *schizo_find_sibling(u32 portid, int chip_type)
 {
 	struct pci_pbm_info *pbm;
 
@@ -1412,7 +1410,7 @@ static struct pci_pbm_info * __devinit schizo_find_sibling(u32 portid,
 	return NULL;
 }
 
-static int __devinit __schizo_init(struct platform_device *op, unsigned long chip_type)
+static int __schizo_init(struct platform_device *op, unsigned long chip_type)
 {
 	struct device_node *dp = op->dev.of_node;
 	struct pci_pbm_info *pbm;
@@ -1460,7 +1458,7 @@ out_err:
 }
 
 static const struct of_device_id schizo_match[];
-static int __devinit schizo_probe(struct platform_device *op)
+static int schizo_probe(struct platform_device *op)
 {
 	const struct of_device_id *match;
 
diff --git a/arch/sparc/kernel/pci_sun4v.c b/arch/sparc/kernel/pci_sun4v.c
index 051b69c..d07f6b2 100644
--- a/arch/sparc/kernel/pci_sun4v.c
+++ b/arch/sparc/kernel/pci_sun4v.c
@@ -536,8 +536,7 @@ static struct dma_map_ops sun4v_dma_ops = {
 	.unmap_sg			= dma_4v_unmap_sg,
 };
 
-static void __devinit pci_sun4v_scan_bus(struct pci_pbm_info *pbm,
-					 struct device *parent)
+static void pci_sun4v_scan_bus(struct pci_pbm_info *pbm, struct device *parent)
 {
 	struct property *prop;
 	struct device_node *dp;
@@ -550,8 +549,8 @@ static void __devinit pci_sun4v_scan_bus(struct pci_pbm_info *pbm,
 	/* XXX register error interrupt handlers XXX */
 }
 
-static unsigned long __devinit probe_existing_entries(struct pci_pbm_info *pbm,
-						      struct iommu *iommu)
+static unsigned long probe_existing_entries(struct pci_pbm_info *pbm,
+					    struct iommu *iommu)
 {
 	struct iommu_arena *arena = &iommu->arena;
 	unsigned long i, cnt = 0;
@@ -578,7 +577,7 @@ static unsigned long __devinit probe_existing_entries(struct pci_pbm_info *pbm,
 	return cnt;
 }
 
-static int __devinit pci_sun4v_iommu_init(struct pci_pbm_info *pbm)
+static int pci_sun4v_iommu_init(struct pci_pbm_info *pbm)
 {
 	static const u32 vdma_default[] = { 0x80000000, 0x80000000 };
 	struct iommu *iommu = pbm->iommu;
@@ -879,8 +878,8 @@ static void pci_sun4v_msi_init(struct pci_pbm_info *pbm)
 }
 #endif /* !(CONFIG_PCI_MSI) */
 
-static int __devinit pci_sun4v_pbm_init(struct pci_pbm_info *pbm,
-					struct platform_device *op, u32 devhandle)
+static int pci_sun4v_pbm_init(struct pci_pbm_info *pbm,
+			      struct platform_device *op, u32 devhandle)
 {
 	struct device_node *dp = op->dev.of_node;
 	int err;
@@ -919,7 +918,7 @@ static int __devinit pci_sun4v_pbm_init(struct pci_pbm_info *pbm,
 	return 0;
 }
 
-static int __devinit pci_sun4v_probe(struct platform_device *op)
+static int pci_sun4v_probe(struct platform_device *op)
 {
 	const struct linux_prom64_registers *regs;
 	static int hvapi_negotiated = 0;
diff --git a/arch/sparc/kernel/pcic.c b/arch/sparc/kernel/pcic.c
index 521fdf1..09f4fdd 100644
--- a/arch/sparc/kernel/pcic.c
+++ b/arch/sparc/kernel/pcic.c
@@ -439,8 +439,7 @@ int pcic_present(void)
 	return pcic0_up;
 }
 
-static int __devinit pdev_to_pnode(struct linux_pbm_info *pbm,
-				    struct pci_dev *pdev)
+static int pdev_to_pnode(struct linux_pbm_info *pbm, struct pci_dev *pdev)
 {
 	struct linux_prom_pci_registers regs[PROMREG_MAX];
 	int err;
@@ -595,7 +594,7 @@ pcic_fill_irq(struct linux_pcic *pcic, struct pci_dev *dev, int node)
 /*
  * Normally called from {do_}pci_scan_bus...
  */
-void __devinit pcibios_fixup_bus(struct pci_bus *bus)
+void pcibios_fixup_bus(struct pci_bus *bus)
 {
 	struct pci_dev *dev;
 	int i, has_io, has_mem;
diff --git a/arch/sparc/kernel/pmc.c b/arch/sparc/kernel/pmc.c
index 0e32022..dcbb62f 100644
--- a/arch/sparc/kernel/pmc.c
+++ b/arch/sparc/kernel/pmc.c
@@ -52,7 +52,7 @@ static void pmc_swift_idle(void)
 #endif
 }
 
-static int __devinit pmc_probe(struct platform_device *op)
+static int pmc_probe(struct platform_device *op)
 {
 	regs = of_ioremap(&op->resource[0], 0,
 			  resource_size(&op->resource[0]), PMC_OBPNAME);
diff --git a/arch/sparc/kernel/power.c b/arch/sparc/kernel/power.c
index 0d39075..4cb23c4 100644
--- a/arch/sparc/kernel/power.c
+++ b/arch/sparc/kernel/power.c
@@ -23,7 +23,7 @@ static irqreturn_t power_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int __devinit has_button_interrupt(unsigned int irq, struct device_node *dp)
+static int has_button_interrupt(unsigned int irq, struct device_node *dp)
 {
 	if (irq = 0xffffffff)
 		return 0;
@@ -33,7 +33,7 @@ static int __devinit has_button_interrupt(unsigned int irq, struct device_node *
 	return 1;
 }
 
-static int __devinit power_probe(struct platform_device *op)
+static int power_probe(struct platform_device *op)
 {
 	struct resource *res = &op->resource[0];
 	unsigned int irq = op->archdata.irqs[0];
diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index d94b878..537eb66 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -1180,7 +1180,7 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 {
 }
 
-void __devinit smp_prepare_boot_cpu(void)
+void smp_prepare_boot_cpu(void)
 {
 }
 
@@ -1194,7 +1194,7 @@ void __init smp_setup_processor_id(void)
 		xcall_deliver_impl = hypervisor_xcall_deliver;
 }
 
-void __devinit smp_fill_in_sib_core_maps(void)
+void smp_fill_in_sib_core_maps(void)
 {
 	unsigned int i;
 
diff --git a/arch/sparc/kernel/time_32.c b/arch/sparc/kernel/time_32.c
index 9536415..c4c27b0 100644
--- a/arch/sparc/kernel/time_32.c
+++ b/arch/sparc/kernel/time_32.c
@@ -278,7 +278,7 @@ static struct platform_device m48t59_rtc = {
 	},
 };
 
-static int __devinit clock_probe(struct platform_device *op)
+static int clock_probe(struct platform_device *op)
 {
 	struct device_node *dp = op->dev.of_node;
 	const char *model = of_get_property(dp, "model", NULL);
diff --git a/arch/sparc/kernel/time_64.c b/arch/sparc/kernel/time_64.c
index e861072..c3d82b5 100644
--- a/arch/sparc/kernel/time_64.c
+++ b/arch/sparc/kernel/time_64.c
@@ -419,7 +419,7 @@ static struct platform_device rtc_cmos_device = {
 	.num_resources	= 1,
 };
 
-static int __devinit rtc_probe(struct platform_device *op)
+static int rtc_probe(struct platform_device *op)
 {
 	struct resource *r;
 
@@ -477,7 +477,7 @@ static struct platform_device rtc_bq4802_device = {
 	.num_resources	= 1,
 };
 
-static int __devinit bq4802_probe(struct platform_device *op)
+static int bq4802_probe(struct platform_device *op)
 {
 
 	printk(KERN_INFO "%s: BQ4802 regs at 0x%llx\n",
@@ -534,7 +534,7 @@ static struct platform_device m48t59_rtc = {
 	},
 };
 
-static int __devinit mostek_probe(struct platform_device *op)
+static int mostek_probe(struct platform_device *op)
 {
 	struct device_node *dp = op->dev.of_node;
 
@@ -746,7 +746,7 @@ void __irq_entry timer_interrupt(int irq, struct pt_regs *regs)
 	set_irq_regs(old_regs);
 }
 
-void __devinit setup_sparc64_timer(void)
+void setup_sparc64_timer(void)
 {
 	struct clock_event_device *sevt;
 	unsigned long pstate;
@@ -844,7 +844,7 @@ unsigned long long sched_clock(void)
 		>> SPARC64_NSEC_PER_CYC_SHIFT;
 }
 
-int __devinit read_current_timer(unsigned long *timer_val)
+int read_current_timer(unsigned long *timer_val)
 {
 	*timer_val = tick_ops->get_tick();
 	return 0;
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 85be1ca..c3b7242 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -87,8 +87,8 @@ static unsigned long cpu_pgsz_mask;
 
 #define MAX_BANKS	32
 
-static struct linux_prom64_registers pavail[MAX_BANKS] __devinitdata;
-static int pavail_ents __devinitdata;
+static struct linux_prom64_registers pavail[MAX_BANKS];
+static int pavail_ents;
 
 static int cmp_p64(const void *a, const void *b)
 {
@@ -1931,7 +1931,7 @@ void __init paging_init(void)
 	printk("Booting Linux...\n");
 }
 
-int __devinit page_in_phys_avail(unsigned long paddr)
+int page_in_phys_avail(unsigned long paddr)
 {
 	int i;
 


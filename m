From: David Miller <davem@davemloft.net>
Date: Sat, 30 Aug 2008 07:58:39 +0000
Subject: [PATCH 5/6]: sparc: Kill EBUS driver layer.
Message-Id: <20080830.005839.189121417.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc: Kill EBUS driver layer.

All that remains is the EBUS DMA programming library for
sparc64.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/ebus.h       |    8 -
 arch/sparc/include/asm/ebus_32.h    |   99 ---------
 arch/sparc/include/asm/ebus_64.h    |   64 ------
 arch/sparc/kernel/Makefile          |    1 -
 arch/sparc/kernel/ebus.c            |  392 -----------------------------------
 arch/sparc/kernel/pcic.c            |    8 +-
 arch/sparc/kernel/sparc_ksyms.c     |    4 -
 arch/sparc64/kernel/Makefile        |    4 +-
 arch/sparc64/kernel/ebus.c          |  295 +--------------------------
 arch/sparc64/kernel/pci.c           |    4 +-
 arch/sparc64/kernel/sparc64_ksyms.c |    4 -
 11 files changed, 6 insertions(+), 877 deletions(-)
 delete mode 100644 arch/sparc/include/asm/ebus.h
 delete mode 100644 arch/sparc/include/asm/ebus_32.h
 delete mode 100644 arch/sparc/include/asm/ebus_64.h
 delete mode 100644 arch/sparc/kernel/ebus.c

diff --git a/arch/sparc/include/asm/ebus.h b/arch/sparc/include/asm/ebus.h
deleted file mode 100644
index 83a6d16..0000000
--- a/arch/sparc/include/asm/ebus.h
+++ /dev/null
@@ -1,8 +0,0 @@
-#ifndef ___ASM_SPARC_EBUS_H
-#define ___ASM_SPARC_EBUS_H
-#if defined(__sparc__) && defined(__arch64__)
-#include <asm/ebus_64.h>
-#else
-#include <asm/ebus_32.h>
-#endif
-#endif
diff --git a/arch/sparc/include/asm/ebus_32.h b/arch/sparc/include/asm/ebus_32.h
deleted file mode 100644
index f91f0b2..0000000
--- a/arch/sparc/include/asm/ebus_32.h
+++ /dev/null
@@ -1,99 +0,0 @@
-/*
- * ebus.h: PCI to Ebus pseudo driver software state.
- *
- * Copyright (C) 1997 Eddie C. Dost (ecd@skynet.be)
- *
- * Adopted for sparc by V. Roganov and G. Raiko.
- */
-
-#ifndef __SPARC_EBUS_H
-#define __SPARC_EBUS_H
-
-#ifndef _LINUX_IOPORT_H
-#include <linux/ioport.h>
-#endif
-#include <linux/of_device.h>
-#include <asm/oplib.h>
-#include <asm/prom.h>
-
-struct linux_ebus_child {
-	struct linux_ebus_child		*next;
-	struct linux_ebus_device	*parent;
-	struct linux_ebus		*bus;
-	struct device_node		*prom_node;
-	struct resource			 resource[PROMREG_MAX];
-	int				 num_addrs;
-	unsigned int			 irqs[PROMINTR_MAX];
-	int				 num_irqs;
-};
-
-struct linux_ebus_device {
-	struct of_device		ofdev;
-	struct linux_ebus_device	*next;
-	struct linux_ebus_child		*children;
-	struct linux_ebus		*bus;
-	struct device_node		*prom_node;
-	struct resource			 resource[PROMREG_MAX];
-	int				 num_addrs;
-	unsigned int			 irqs[PROMINTR_MAX];
-	int				 num_irqs;
-};
-#define to_ebus_device(d) container_of(d, struct linux_ebus_device, ofdev.dev)
-
-struct linux_ebus {
-	struct of_device		ofdev;
-	struct linux_ebus		*next;
-	struct linux_ebus_device	*devices;
-	struct linux_pbm_info		*parent;
-	struct pci_dev			*self;
-	struct device_node		*prom_node;
-};
-#define to_ebus(d) container_of(d, struct linux_ebus, ofdev.dev)
-
-struct linux_ebus_dma {
-	unsigned int dcsr;
-	unsigned int dacr;
-	unsigned int dbcr;
-};
-
-#define EBUS_DCSR_INT_PEND	0x00000001
-#define EBUS_DCSR_ERR_PEND	0x00000002
-#define EBUS_DCSR_DRAIN		0x00000004
-#define EBUS_DCSR_INT_EN	0x00000010
-#define EBUS_DCSR_RESET		0x00000080
-#define EBUS_DCSR_WRITE		0x00000100
-#define EBUS_DCSR_EN_DMA	0x00000200
-#define EBUS_DCSR_CYC_PEND	0x00000400
-#define EBUS_DCSR_DIAG_RD_DONE	0x00000800
-#define EBUS_DCSR_DIAG_WR_DONE	0x00001000
-#define EBUS_DCSR_EN_CNT	0x00002000
-#define EBUS_DCSR_TC		0x00004000
-#define EBUS_DCSR_DIS_CSR_DRN	0x00010000
-#define EBUS_DCSR_BURST_SZ_MASK	0x000c0000
-#define EBUS_DCSR_BURST_SZ_1	0x00080000
-#define EBUS_DCSR_BURST_SZ_4	0x00000000
-#define EBUS_DCSR_BURST_SZ_8	0x00040000
-#define EBUS_DCSR_BURST_SZ_16	0x000c0000
-#define EBUS_DCSR_DIAG_EN	0x00100000
-#define EBUS_DCSR_DIS_ERR_PEND	0x00400000
-#define EBUS_DCSR_TCI_DIS	0x00800000
-#define EBUS_DCSR_EN_NEXT	0x01000000
-#define EBUS_DCSR_DMA_ON	0x02000000
-#define EBUS_DCSR_A_LOADED	0x04000000
-#define EBUS_DCSR_NA_LOADED	0x08000000
-#define EBUS_DCSR_DEV_ID_MASK	0xf0000000
-
-extern struct linux_ebus		*ebus_chain;
-
-extern void ebus_init(void);
-
-#define for_each_ebus(bus)						\
-        for((bus) = ebus_chain; (bus); (bus) = (bus)->next)
-
-#define for_each_ebusdev(dev, bus)					\
-        for((dev) = (bus)->devices; (dev); (dev) = (dev)->next)
-
-#define for_each_edevchild(dev, child)					\
-        for((child) = (dev)->children; (child); (child) = (child)->next)
-
-#endif /* !(__SPARC_EBUS_H) */
diff --git a/arch/sparc/include/asm/ebus_64.h b/arch/sparc/include/asm/ebus_64.h
deleted file mode 100644
index cd102b8..0000000
--- a/arch/sparc/include/asm/ebus_64.h
+++ /dev/null
@@ -1,64 +0,0 @@
-/*
- * ebus.h: PCI to Ebus pseudo driver software state.
- *
- * Copyright (C) 1997 Eddie C. Dost (ecd@skynet.be)
- * Copyright (C) 1999 David S. Miller (davem@redhat.com)
- */
-
-#ifndef __SPARC64_EBUS_H
-#define __SPARC64_EBUS_H
-
-#include <linux/of_device.h>
-
-#include <asm/oplib.h>
-#include <asm/prom.h>
-
-struct linux_ebus_child {
-	struct linux_ebus_child		*next;
-	struct linux_ebus_device	*parent;
-	struct linux_ebus		*bus;
-	struct device_node		*prom_node;
-	struct resource			 resource[PROMREG_MAX];
-	int				 num_addrs;
-	unsigned int			 irqs[PROMINTR_MAX];
-	int				 num_irqs;
-};
-
-struct linux_ebus_device {
-	struct of_device		ofdev;
-	struct linux_ebus_device	*next;
-	struct linux_ebus_child		*children;
-	struct linux_ebus		*bus;
-	struct device_node		*prom_node;
-	struct resource			 resource[PROMREG_MAX];
-	int				 num_addrs;
-	unsigned int			 irqs[PROMINTR_MAX];
-	int				 num_irqs;
-};
-#define to_ebus_device(d) container_of(d, struct linux_ebus_device, ofdev.dev)
-
-struct linux_ebus {
-	struct of_device		ofdev;
-	struct linux_ebus		*next;
-	struct linux_ebus_device	*devices;
-	struct pci_dev			*self;
-	int				 index;
-	int				 is_rio;
-	struct device_node		*prom_node;
-};
-#define to_ebus(d) container_of(d, struct linux_ebus, ofdev.dev)
-
-extern struct linux_ebus		*ebus_chain;
-
-extern void ebus_init(void);
-
-#define for_each_ebus(bus)						\
-        for((bus) = ebus_chain; (bus); (bus) = (bus)->next)
-
-#define for_each_ebusdev(dev, bus)					\
-        for((dev) = (bus)->devices; (dev); (dev) = (dev)->next)
-
-#define for_each_edevchild(dev, child)					\
-        for((child) = (dev)->children; (child); (child) = (child)->next)
-
-#endif /* !(__SPARC64_EBUS_H) */
diff --git a/arch/sparc/kernel/Makefile b/arch/sparc/kernel/Makefile
index eaf7cf4..a430231 100644
--- a/arch/sparc/kernel/Makefile
+++ b/arch/sparc/kernel/Makefile
@@ -21,7 +21,6 @@ obj-$(CONFIG_PCI) += pcic.o
 obj-$(CONFIG_SUN4) += sun4setup.o
 obj-$(CONFIG_SMP) += trampoline.o smp.o sun4m_smp.o sun4d_smp.o
 obj-$(CONFIG_SUN_AUXIO) += auxio.o
-obj-$(CONFIG_PCI) += ebus.o
 obj-$(CONFIG_SUN_PM) += apc.o pmc.o
 obj-$(CONFIG_MODULES) += module.o sparc_ksyms.o
 obj-$(CONFIG_SPARC_LED) += led.o
diff --git a/arch/sparc/kernel/ebus.c b/arch/sparc/kernel/ebus.c
deleted file mode 100644
index 7e9397f..0000000
--- a/arch/sparc/kernel/ebus.c
+++ /dev/null
@@ -1,392 +0,0 @@
-/*
- * ebus.c: PCI to EBus bridge device.
- *
- * Copyright (C) 1997  Eddie C. Dost  (ecd@skynet.be)
- *
- * Adopted for sparc by V. Roganov and G. Raiko.
- * Fixes for different platforms by Pete Zaitcev.
- */
-
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/init.h>
-#include <linux/slab.h>
-#include <linux/string.h>
-
-#include <asm/system.h>
-#include <asm/page.h>
-#include <asm/pbm.h>
-#include <asm/ebus.h>
-#include <asm/io.h>
-#include <asm/oplib.h>
-#include <asm/prom.h>
-
-struct linux_ebus *ebus_chain = NULL;
-
-/* We are together with pcic.c under CONFIG_PCI. */
-extern unsigned int pcic_pin_to_irq(unsigned int, const char *name);
-
-/*
- * IRQ Blacklist
- * Here we list PROMs and systems that are known to supply crap as IRQ numbers.
- */
-struct ebus_device_irq {
-	char *name;
-	unsigned int pin;
-};
-
-struct ebus_system_entry {
-	char *esname;
-	struct ebus_device_irq *ipt;
-};
-
-static struct ebus_device_irq je1_1[] = {
-	{ "8042",		 3 },
-	{ "SUNW,CS4231",	 0 },
-	{ "parallel",		 0 },
-	{ "se",			 2 },
-	{ NULL, 0 }
-};
-
-/*
- * Gleb's JE1 supplied reasonable pin numbers, but mine did not (OBP 2.32).
- * Blacklist the sucker... Note that Gleb's system will work.
- */
-static struct ebus_system_entry ebus_blacklist[] = {
-	{ "SUNW,JavaEngine1", je1_1 },
-	{ NULL, NULL }
-};
-
-static struct ebus_device_irq *ebus_blackp = NULL;
-
-/*
- */
-static inline unsigned long ebus_alloc(size_t size)
-{
-	return (unsigned long)kmalloc(size, GFP_ATOMIC);
-}
-
-/*
- */
-static int __init ebus_blacklist_irq(const char *name)
-{
-	struct ebus_device_irq *dp;
-
-	if ((dp = ebus_blackp) != NULL) {
-		for (; dp->name != NULL; dp++) {
-			if (strcmp(name, dp->name) = 0) {
-				return pcic_pin_to_irq(dp->pin, name);
-			}
-		}
-	}
-	return 0;
-}
-
-static void __init fill_ebus_child(struct device_node *dp,
-				   struct linux_ebus_child *dev)
-{
-	const int *regs;
-	const int *irqs;
-	int i, len;
-
-	dev->prom_node = dp;
-	regs = of_get_property(dp, "reg", &len);
-	if (!regs)
-		len = 0;
-	dev->num_addrs = len / sizeof(regs[0]);
-
-	for (i = 0; i < dev->num_addrs; i++) {
-		if (regs[i] >= dev->parent->num_addrs) {
-			prom_printf("UGH: property for %s was %d, need < %d\n",
-				    dev->prom_node->name, len,
-				    dev->parent->num_addrs);
-			panic(__func__);
-		}
-
-		/* XXX resource */
-		dev->resource[i].start -			dev->parent->resource[regs[i]].start;
-	}
-
-	for (i = 0; i < PROMINTR_MAX; i++)
-		dev->irqs[i] = PCI_IRQ_NONE;
-
-	if ((dev->irqs[0] = ebus_blacklist_irq(dev->prom_node->name)) != 0) {
-		dev->num_irqs = 1;
-	} else {
-		irqs = of_get_property(dp, "interrupts", &len);
-		if (!irqs) {
-			dev->num_irqs = 0;
-			dev->irqs[0] = 0;
-			if (dev->parent->num_irqs != 0) {
-				dev->num_irqs = 1;
-				dev->irqs[0] = dev->parent->irqs[0];
-			}
-		} else {
-			dev->num_irqs = len / sizeof(irqs[0]);
-			if (irqs[0] = 0 || irqs[0] >= 8) {
-				/*
-				 * XXX Zero is a valid pin number...
-				 * This works as long as Ebus is not wired
-				 * to INTA#.
-				 */
-				printk("EBUS: %s got bad irq %d from PROM\n",
-				       dev->prom_node->name, irqs[0]);
-				dev->num_irqs = 0;
-				dev->irqs[0] = 0;
-			} else {
-				dev->irqs[0] -					pcic_pin_to_irq(irqs[0],
-							dev->prom_node->name);
-			}
-		}
-	}
-}
-
-static void __init fill_ebus_device(struct device_node *dp,
-				    struct linux_ebus_device *dev)
-{
-	const struct linux_prom_registers *regs;
-	struct linux_ebus_child *child;
-	struct dev_archdata *sd;
-	const int *irqs;
-	int i, n, len;
-	unsigned long baseaddr;
-
-	dev->prom_node = dp;
-
-	regs = of_get_property(dp, "reg", &len);
-	if (!regs)
-		len = 0;
-	if (len % sizeof(struct linux_prom_registers)) {
-		prom_printf("UGH: proplen for %s was %d, need multiple of %d\n",
-			    dev->prom_node->name, len,
-			    (int)sizeof(struct linux_prom_registers));
-		panic(__func__);
-	}
-	dev->num_addrs = len / sizeof(struct linux_prom_registers);
-
-	for (i = 0; i < dev->num_addrs; i++) {
-		/*
-		 * XXX Collect JE-1 PROM
-		 * 
-		 * Example - JS-E with 3.11:
-		 *  /ebus
-		 *      regs 
-		 *        0x00000000, 0x0, 0x00000000, 0x0, 0x00000000,
-		 *        0x82000010, 0x0, 0xf0000000, 0x0, 0x01000000,
-		 *        0x82000014, 0x0, 0x38800000, 0x0, 0x00800000,
-		 *      ranges
-		 *        0x00, 0x00000000, 0x02000010, 0x0, 0x0, 0x01000000,
-		 *        0x01, 0x01000000, 0x02000014, 0x0, 0x0, 0x00800000,
-		 *  /ebus/8042
-		 *      regs
-		 *        0x00000001, 0x00300060, 0x00000008,
-		 *        0x00000001, 0x00300060, 0x00000008,
-		 */
-		n = regs[i].which_io;
-		if (n >= 4) {
-			/* XXX This is copied from old JE-1 by Gleb. */
-			n = (regs[i].which_io - 0x10) >> 2;
-		} else {
-			;
-		}
-
-/*
- * XXX Now as we have regions, why don't we make an on-demand allocation...
- */
-		dev->resource[i].start = 0;
-		if ((baseaddr = dev->bus->self->resource[n].start +
-		    regs[i].phys_addr) != 0) {
-			/* dev->resource[i].name = dev->prom_name; */
-			if ((baseaddr = (unsigned long) ioremap(baseaddr,
-			    regs[i].reg_size)) = 0) {
-				panic("ebus: unable to remap dev %s",
-				      dev->prom_node->name);
-			}
-		}
-		dev->resource[i].start = baseaddr;	/* XXX Unaligned */
-	}
-
-	for (i = 0; i < PROMINTR_MAX; i++)
-		dev->irqs[i] = PCI_IRQ_NONE;
-
-	if ((dev->irqs[0] = ebus_blacklist_irq(dev->prom_node->name)) != 0) {
-		dev->num_irqs = 1;
-	} else {
-		irqs = of_get_property(dp, "interrupts", &len);
-		if (!irqs) {
-			dev->num_irqs = 0;
-			if ((dev->irqs[0] = dev->bus->self->irq) != 0) {
-				dev->num_irqs = 1;
-/* P3 */ /* printk("EBUS: child %s irq %d from parent\n", dev->prom_name, dev->irqs[0]); */
-			}
-		} else {
-			dev->num_irqs = 1;  /* dev->num_irqs = len / sizeof(irqs[0]); */
-			if (irqs[0] = 0 || irqs[0] >= 8) {
-				/* See above for the parent. XXX */
-				printk("EBUS: %s got bad irq %d from PROM\n",
-				       dev->prom_node->name, irqs[0]);
-				dev->num_irqs = 0;
-				dev->irqs[0] = 0;
-			} else {
-				dev->irqs[0] -					pcic_pin_to_irq(irqs[0],
-							dev->prom_node->name);
-			}
-		}
-	}
-
-	sd = &dev->ofdev.dev.archdata;
-	sd->prom_node = dp;
-	sd->op = &dev->ofdev;
-	sd->iommu = dev->bus->ofdev.dev.parent->archdata.iommu;
-
-	dev->ofdev.node = dp;
-	dev->ofdev.dev.parent = &dev->bus->ofdev.dev;
-	dev->ofdev.dev.bus = &ebus_bus_type;
-	sprintf(dev->ofdev.dev.bus_id, "ebus[%08x]", dp->node);
-
-	/* Register with core */
-	if (of_device_register(&dev->ofdev) != 0)
-		printk(KERN_DEBUG "ebus: device registration error for %s!\n",
-		       dp->path_component_name);
-
-	if ((dp = dp->child) != NULL) {
-		dev->children = (struct linux_ebus_child *)
-			ebus_alloc(sizeof(struct linux_ebus_child));
-
-		child = dev->children;
-		child->next = NULL;
-		child->parent = dev;
-		child->bus = dev->bus;
-		fill_ebus_child(dp, child);
-
-		while ((dp = dp->sibling) != NULL) {
-			child->next = (struct linux_ebus_child *)
-				ebus_alloc(sizeof(struct linux_ebus_child));
-
-			child = child->next;
-			child->next = NULL;
-			child->parent = dev;
-			child->bus = dev->bus;
-			fill_ebus_child(dp, child);
-		}
-	}
-}
-
-void __init ebus_init(void)
-{
-	const struct linux_prom_pci_registers *regs;
-	struct linux_pbm_info *pbm;
-	struct linux_ebus_device *dev;
-	struct linux_ebus *ebus;
-	struct ebus_system_entry *sp;
-	struct pci_dev *pdev;
-	struct pcidev_cookie *cookie;
-	struct device_node *dp;
-	struct resource *p;
-	unsigned short pci_command;
-	int len, reg, nreg;
-	int num_ebus = 0;
-
-	dp = of_find_node_by_path("/");
-	for (sp = ebus_blacklist; sp->esname != NULL; sp++) {
-		if (strcmp(dp->name, sp->esname) = 0) {
-			ebus_blackp = sp->ipt;
-			break;
-		}
-	}
-
-	pdev = pci_get_device(PCI_VENDOR_ID_SUN, PCI_DEVICE_ID_SUN_EBUS, NULL);
-	if (!pdev)
-		return;
-
-	cookie = pdev->sysdata;
-	dp = cookie->prom_node;
-
-	ebus_chain = ebus = (struct linux_ebus *)
-			ebus_alloc(sizeof(struct linux_ebus));
-	ebus->next = NULL;
-
-	while (dp) {
-		struct device_node *nd;
-
-		ebus->prom_node = dp;
-		ebus->self = pdev;
-		ebus->parent = pbm = cookie->pbm;
-
-		/* Enable BUS Master. */
-		pci_read_config_word(pdev, PCI_COMMAND, &pci_command);
-		pci_command |= PCI_COMMAND_MASTER;
-		pci_write_config_word(pdev, PCI_COMMAND, pci_command);
-
-		regs = of_get_property(dp, "reg", &len);
-		if (!regs) {
-			prom_printf("%s: can't find reg property\n",
-				    __func__);
-			prom_halt();
-		}
-		nreg = len / sizeof(struct linux_prom_pci_registers);
-
-		p = &ebus->self->resource[0];
-		for (reg = 0; reg < nreg; reg++) {
-			if (!(regs[reg].which_io & 0x03000000))
-				continue;
-
-			(p++)->start = regs[reg].phys_lo;
-		}
-
-		ebus->ofdev.node = dp;
-		ebus->ofdev.dev.parent = &pdev->dev;
-		ebus->ofdev.dev.bus = &ebus_bus_type;
-		sprintf(ebus->ofdev.dev.bus_id, "ebus%d", num_ebus);
-
-		/* Register with core */
-		if (of_device_register(&ebus->ofdev) != 0)
-			printk(KERN_DEBUG "ebus: device registration error for %s!\n",
-			       dp->path_component_name);
-
-
-		nd = dp->child;
-		if (!nd)
-			goto next_ebus;
-
-		ebus->devices = (struct linux_ebus_device *)
-				ebus_alloc(sizeof(struct linux_ebus_device));
-
-		dev = ebus->devices;
-		dev->next = NULL;
-		dev->children = NULL;
-		dev->bus = ebus;
-		fill_ebus_device(nd, dev);
-
-		while ((nd = nd->sibling) != NULL) {
-			dev->next = (struct linux_ebus_device *)
-				ebus_alloc(sizeof(struct linux_ebus_device));
-
-			dev = dev->next;
-			dev->next = NULL;
-			dev->children = NULL;
-			dev->bus = ebus;
-			fill_ebus_device(nd, dev);
-		}
-
-	next_ebus:
-		pdev = pci_get_device(PCI_VENDOR_ID_SUN,
-				       PCI_DEVICE_ID_SUN_EBUS, pdev);
-		if (!pdev)
-			break;
-
-		cookie = pdev->sysdata;
-		dp = cookie->prom_node;
-
-		ebus->next = (struct linux_ebus *)
-			ebus_alloc(sizeof(struct linux_ebus));
-		ebus = ebus->next;
-		ebus->next = NULL;
-		++num_ebus;
-	}
-	if (pdev)
-		pci_dev_put(pdev);
-}
diff --git a/arch/sparc/kernel/pcic.c b/arch/sparc/kernel/pcic.c
index 9a0aa4e..e5950b0 100644
--- a/arch/sparc/kernel/pcic.c
+++ b/arch/sparc/kernel/pcic.c
@@ -17,7 +17,6 @@
 #include <linux/slab.h>
 #include <linux/jiffies.h>
 
-#include <asm/ebus.h>
 #include <asm/swift.h> /* for cache flushing. */
 #include <asm/io.h>
 
@@ -429,7 +428,6 @@ static int __init pcic_init(void)
 
 	pcic_pbm_scan_bus(pcic);
 
-	ebus_init();
 	return 0;
 }
 
@@ -492,10 +490,6 @@ static void pcic_map_pci_device(struct linux_pcic *pcic,
 				 * do ioremap() before accessing PC-style I/O,
 				 * we supply virtual, ready to access address.
 				 *
-				 * Ebus devices do not come here even if
-				 * CheerIO makes a similar conversion.
-				 * See ebus.c for details.
-				 *
 				 * Note that request_region()
 				 * works for these devices.
 				 *
@@ -676,7 +670,7 @@ void __devinit pcibios_fixup_bus(struct pci_bus *bus)
 }
 
 /*
- * pcic_pin_to_irq() is exported to ebus.c.
+ * pcic_pin_to_irq() is exported to bus probing code
  */
 unsigned int
 pcic_pin_to_irq(unsigned int pin, const char *name)
diff --git a/arch/sparc/kernel/sparc_ksyms.c b/arch/sparc/kernel/sparc_ksyms.c
index 50ec48d..6007ac5 100644
--- a/arch/sparc/kernel/sparc_ksyms.c
+++ b/arch/sparc/kernel/sparc_ksyms.c
@@ -45,9 +45,6 @@
 #ifdef CONFIG_SBUS
 #include <asm/dma.h>
 #endif
-#ifdef CONFIG_PCI
-#include <asm/ebus.h>
-#endif
 #include <asm/io-unit.h>
 #include <asm/bug.h>
 
@@ -152,7 +149,6 @@ EXPORT_SYMBOL(BTFIXUP_CALL(pgprot_noncached));
 EXPORT_SYMBOL(sbus_set_sbus64);
 #endif
 #ifdef CONFIG_PCI
-EXPORT_SYMBOL(ebus_chain);
 EXPORT_SYMBOL(insb);
 EXPORT_SYMBOL(outsb);
 EXPORT_SYMBOL(insw);
diff --git a/arch/sparc64/kernel/Makefile b/arch/sparc64/kernel/Makefile
index 360a348..928aa7c 100644
--- a/arch/sparc64/kernel/Makefile
+++ b/arch/sparc64/kernel/Makefile
@@ -11,12 +11,12 @@ obj-y		:= process.o setup.o cpu.o idprom.o \
 		   traps.o auxio.o una_asm.o sysfs.o iommu.o \
 		   irq.o ptrace.o time.o sys_sparc.o signal.o \
 		   unaligned.o central.o starfire.o \
-		   power.o sbus.o sparc64_ksyms.o \
+		   power.o sbus.o sparc64_ksyms.o ebus.o \
 		   visemul.o prom.o of_device.o hvapi.o sstate.o mdesc.o
 
 obj-$(CONFIG_DYNAMIC_FTRACE) += ftrace.o
 obj-$(CONFIG_STACKTRACE) += stacktrace.o
-obj-$(CONFIG_PCI)	 += ebus.o pci.o pci_common.o \
+obj-$(CONFIG_PCI)	 += pci.o pci_common.o \
 			    pci_psycho.o pci_sabre.o pci_schizo.o \
 			    pci_sun4v.o pci_sun4v_asm.o pci_fire.o
 obj-$(CONFIG_PCI_MSI)	+= pci_msi.o
diff --git a/arch/sparc64/kernel/ebus.c b/arch/sparc64/kernel/ebus.c
index 8840874..77dbf6d 100644
--- a/arch/sparc64/kernel/ebus.c
+++ b/arch/sparc64/kernel/ebus.c
@@ -1,5 +1,4 @@
-/*
- * ebus.c: PCI to EBus bridge device.
+/* ebus.c: EBUS DMA library code.
  *
  * Copyright (C) 1997  Eddie C. Dost  (ecd@skynet.be)
  * Copyright (C) 1999  David S. Miller (davem@redhat.com)
@@ -9,24 +8,12 @@
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/init.h>
-#include <linux/slab.h>
-#include <linux/string.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
-#include <linux/pci.h>
-#include <linux/of_device.h>
 
-#include <asm/system.h>
-#include <asm/page.h>
-#include <asm/ebus.h>
 #include <asm/ebus_dma.h>
-#include <asm/oplib.h>
-#include <asm/prom.h>
-#include <asm/irq.h>
 #include <asm/io.h>
 
-/* EBUS dma library. */
-
 #define EBDMA_CSR	0x00UL	/* Control/Status */
 #define EBDMA_ADDR	0x04UL	/* DMA Address */
 #define EBDMA_COUNT	0x08UL	/* DMA Count */
@@ -268,283 +255,3 @@ void ebus_dma_enable(struct ebus_dma_info *p, int on)
 	spin_unlock_irqrestore(&p->lock, flags);
 }
 EXPORT_SYMBOL(ebus_dma_enable);
-
-struct linux_ebus *ebus_chain = NULL;
-
-static inline void *ebus_alloc(size_t size)
-{
-	void *mem;
-
-	mem = kzalloc(size, GFP_ATOMIC);
-	if (!mem)
-		panic("ebus_alloc: out of memory");
-	return mem;
-}
-
-static void __init fill_ebus_child(struct device_node *dp,
-				   struct linux_ebus_child *dev,
-				   int non_standard_regs)
-{
-	struct of_device *op;
-	const int *regs;
-	int i, len;
-
-	dev->prom_node = dp;
-	printk(" (%s)", dp->name);
-
-	regs = of_get_property(dp, "reg", &len);
-	if (!regs)
-		dev->num_addrs = 0;
-	else
-		dev->num_addrs = len / sizeof(regs[0]);
-
-	if (non_standard_regs) {
-		/* This is to handle reg properties which are not
-		 * in the parent relative format.  One example are
-		 * children of the i2c device on CompactPCI systems.
-		 *
-		 * So, for such devices we just record the property
-		 * raw in the child resources.
-		 */
-		for (i = 0; i < dev->num_addrs; i++)
-			dev->resource[i].start = regs[i];
-	} else {
-		for (i = 0; i < dev->num_addrs; i++) {
-			int rnum = regs[i];
-			if (rnum >= dev->parent->num_addrs) {
-				prom_printf("UGH: property for %s was %d, need < %d\n",
-					    dp->name, len, dev->parent->num_addrs);
-				prom_halt();
-			}
-			dev->resource[i].start = dev->parent->resource[i].start;
-			dev->resource[i].end = dev->parent->resource[i].end;
-			dev->resource[i].flags = IORESOURCE_MEM;
-			dev->resource[i].name = dp->name;
-		}
-	}
-
-	op = of_find_device_by_node(dp);
-	if (!op) {
-		dev->num_irqs = 0;
-	} else {
-		dev->num_irqs = op->num_irqs;
-		for (i = 0; i < dev->num_irqs; i++)
-			dev->irqs[i] = op->irqs[i];
-	}
-
-	if (!dev->num_irqs) {
-		/*
-		 * Oh, well, some PROMs don't export interrupts
-		 * property to children of EBus devices...
-		 *
-		 * Be smart about PS/2 keyboard and mouse.
-		 */
-		if (!strcmp(dev->parent->prom_node->name, "8042")) {
-			if (!strcmp(dev->prom_node->name, "kb_ps2")) {
-				dev->num_irqs = 1;
-				dev->irqs[0] = dev->parent->irqs[0];
-			} else {
-				dev->num_irqs = 1;
-				dev->irqs[0] = dev->parent->irqs[1];
-			}
-		}
-	}
-}
-
-static int __init child_regs_nonstandard(struct linux_ebus_device *dev)
-{
-	if (!strcmp(dev->prom_node->name, "i2c") ||
-	    !strcmp(dev->prom_node->name, "SUNW,lombus"))
-		return 1;
-	return 0;
-}
-
-static void __init fill_ebus_device(struct device_node *dp, struct linux_ebus_device *dev)
-{
-	struct linux_ebus_child *child;
-	struct dev_archdata *sd;
-	struct of_device *op;
-	int i, len;
-
-	dev->prom_node = dp;
-
-	printk(" [%s", dp->name);
-
-	op = of_find_device_by_node(dp);
-	if (!op) {
-		dev->num_addrs = 0;
-		dev->num_irqs = 0;
-	} else {
-		const int *regs = of_get_property(dp, "reg", &len);
-
-		if (!regs)
-			len = 0;
-		dev->num_addrs = len / sizeof(struct linux_prom_registers);
-
-		for (i = 0; i < dev->num_addrs; i++)
-			memcpy(&dev->resource[i],
-			       &op->resource[i],
-			       sizeof(struct resource));
-
-		dev->num_irqs = op->num_irqs;
-		for (i = 0; i < dev->num_irqs; i++)
-			dev->irqs[i] = op->irqs[i];
-	}
-
-	sd = &dev->ofdev.dev.archdata;
-	sd->prom_node = dp;
-	sd->op = &dev->ofdev;
-	sd->iommu = dev->bus->ofdev.dev.parent->archdata.iommu;
-	sd->stc = dev->bus->ofdev.dev.parent->archdata.stc;
-	sd->numa_node = dev->bus->ofdev.dev.parent->archdata.numa_node;
-
-	dev->ofdev.node = dp;
-	dev->ofdev.dev.parent = &dev->bus->ofdev.dev;
-	dev->ofdev.dev.bus = &ebus_bus_type;
-	dev_set_name(&dev->ofdev.dev, "ebus[%08x]", dp->node);
-
-	/* Register with core */
-	if (of_device_register(&dev->ofdev) != 0)
-		printk(KERN_DEBUG "ebus: device registration error for %s!\n",
-		       dp->path_component_name);
-
-	dp = dp->child;
-	if (dp) {
-		printk(" ->");
-		dev->children = ebus_alloc(sizeof(struct linux_ebus_child));
-
-		child = dev->children;
-		child->next = NULL;
-		child->parent = dev;
-		child->bus = dev->bus;
-		fill_ebus_child(dp, child,
-				child_regs_nonstandard(dev));
-
-		while ((dp = dp->sibling) != NULL) {
-			child->next = ebus_alloc(sizeof(struct linux_ebus_child));
-
-			child = child->next;
-			child->next = NULL;
-			child->parent = dev;
-			child->bus = dev->bus;
-			fill_ebus_child(dp, child,
-					child_regs_nonstandard(dev));
-		}
-	}
-	printk("]");
-}
-
-static struct pci_dev *find_next_ebus(struct pci_dev *start, int *is_rio_p)
-{
-	struct pci_dev *pdev = start;
-
-	while ((pdev = pci_get_device(PCI_VENDOR_ID_SUN, PCI_ANY_ID, pdev)))
-		if (pdev->device = PCI_DEVICE_ID_SUN_EBUS ||
-			pdev->device = PCI_DEVICE_ID_SUN_RIO_EBUS)
-			break;
-
-	*is_rio_p = !!(pdev && (pdev->device = PCI_DEVICE_ID_SUN_RIO_EBUS));
-
-	return pdev;
-}
-
-void __init ebus_init(void)
-{
-	struct linux_ebus_device *dev;
-	struct linux_ebus *ebus;
-	struct pci_dev *pdev;
-	struct device_node *dp;
-	int is_rio;
-	int num_ebus = 0;
-
-	pdev = find_next_ebus(NULL, &is_rio);
-	if (!pdev) {
-		printk("ebus: No EBus's found.\n");
-		return;
-	}
-
-	dp = pci_device_to_OF_node(pdev);
-
-	ebus_chain = ebus = ebus_alloc(sizeof(struct linux_ebus));
-	ebus->next = NULL;
-	ebus->is_rio = is_rio;
-
-	while (dp) {
-		struct device_node *child;
-
-		/* SUNW,pci-qfe uses four empty ebuses on it.
-		   I think we should not consider them here,
-		   as they have half of the properties this
-		   code expects and once we do PCI hot-plug,
-		   we'd have to tweak with the ebus_chain
-		   in the runtime after initialization. -jj */
-		if (!dp->child) {
-			pdev = find_next_ebus(pdev, &is_rio);
-			if (!pdev) {
-				if (ebus = ebus_chain) {
-					ebus_chain = NULL;
-					printk("ebus: No EBus's found.\n");
-					return;
-				}
-				break;
-			}
-			ebus->is_rio = is_rio;
-			dp = pci_device_to_OF_node(pdev);
-			continue;
-		}
-		printk("ebus%d:", num_ebus);
-
-		ebus->index = num_ebus;
-		ebus->prom_node = dp;
-		ebus->self = pdev;
-
-		ebus->ofdev.node = dp;
-		ebus->ofdev.dev.parent = &pdev->dev;
-		ebus->ofdev.dev.bus = &ebus_bus_type;
-		dev_set_name(&ebus->ofdev.dev, "ebus%d", num_ebus);
-
-		/* Register with core */
-		if (of_device_register(&ebus->ofdev) != 0)
-			printk(KERN_DEBUG "ebus: device registration error for %s!\n",
-			       dp->path_component_name);
-
-
-		child = dp->child;
-		if (!child)
-			goto next_ebus;
-
-		ebus->devices = ebus_alloc(sizeof(struct linux_ebus_device));
-
-		dev = ebus->devices;
-		dev->next = NULL;
-		dev->children = NULL;
-		dev->bus = ebus;
-		fill_ebus_device(child, dev);
-
-		while ((child = child->sibling) != NULL) {
-			dev->next = ebus_alloc(sizeof(struct linux_ebus_device));
-
-			dev = dev->next;
-			dev->next = NULL;
-			dev->children = NULL;
-			dev->bus = ebus;
-			fill_ebus_device(child, dev);
-		}
-
-	next_ebus:
-		printk("\n");
-
-		pdev = find_next_ebus(pdev, &is_rio);
-		if (!pdev)
-			break;
-
-		dp = pci_device_to_OF_node(pdev);
-
-		ebus->next = ebus_alloc(sizeof(struct linux_ebus));
-		ebus = ebus->next;
-		ebus->next = NULL;
-		ebus->is_rio = is_rio;
-		++num_ebus;
-	}
-	pci_dev_put(pdev); /* XXX for the case, when ebusnd is 0, is it OK? */
-}
diff --git a/arch/sparc64/kernel/pci.c b/arch/sparc64/kernel/pci.c
index 71d423a..2187786 100644
--- a/arch/sparc64/kernel/pci.c
+++ b/arch/sparc64/kernel/pci.c
@@ -18,11 +18,12 @@
 #include <linux/msi.h>
 #include <linux/irq.h>
 #include <linux/init.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 #include <asm/irq.h>
-#include <asm/ebus.h>
 #include <asm/prom.h>
 #include <asm/apb.h>
 
@@ -808,7 +809,6 @@ static int __init pcibios_init(void)
 
 	pci_scan_each_controller_bus();
 
-	ebus_init();
 	power_init();
 
 	return 0;
diff --git a/arch/sparc64/kernel/sparc64_ksyms.c b/arch/sparc64/kernel/sparc64_ksyms.c
index 4c3a6a8..30bba8b 100644
--- a/arch/sparc64/kernel/sparc64_ksyms.c
+++ b/arch/sparc64/kernel/sparc64_ksyms.c
@@ -45,9 +45,6 @@
 #ifdef CONFIG_SBUS
 #include <asm/dma.h>
 #endif
-#ifdef CONFIG_PCI
-#include <asm/ebus.h>
-#endif
 #include <asm/ns87303.h>
 #include <asm/timer.h>
 #include <asm/cpudata.h>
@@ -165,7 +162,6 @@ EXPORT_SYMBOL(insb);
 EXPORT_SYMBOL(insw);
 EXPORT_SYMBOL(insl);
 #ifdef CONFIG_PCI
-EXPORT_SYMBOL(ebus_chain);
 EXPORT_SYMBOL(pci_alloc_consistent);
 EXPORT_SYMBOL(pci_free_consistent);
 EXPORT_SYMBOL(pci_map_single);
-- 
1.5.6.5.GIT


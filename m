From: David Miller <davem@davemloft.net>
Date: Thu, 28 Aug 2008 04:24:21 +0000
Subject: [PATCH 24/49]: fore200e: Convert over to pure OF driver.
Message-Id: <20080827.212421.109450146.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


fore200e: Convert over to pure OF driver.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 drivers/atm/fore200e.c |  414 ++++++++++++++++++++++--------------------------
 drivers/atm/fore200e.h |    7 +-
 2 files changed, 189 insertions(+), 232 deletions(-)

diff --git a/drivers/atm/fore200e.c b/drivers/atm/fore200e.c
index 7213590..c2fa9fd 100644
--- a/drivers/atm/fore200e.c
+++ b/drivers/atm/fore200e.c
@@ -47,8 +47,9 @@
 #include <asm/atomic.h>
 
 #ifdef CONFIG_SBUS
+#include <linux/of.h>
+#include <linux/of_device.h>
 #include <asm/idprom.h>
-#include <asm/sbus.h>
 #include <asm/openprom.h>
 #include <asm/oplib.h>
 #include <asm/pgtable.h>
@@ -661,263 +662,189 @@ fore200e_pca_proc_read(struct fore200e* fore200e, char *page)
 
 #ifdef CONFIG_SBUS
 
-static u32
-fore200e_sba_read(volatile u32 __iomem *addr)
+static u32 fore200e_sba_read(volatile u32 __iomem *addr)
 {
     return sbus_readl(addr);
 }
 
-
-static void
-fore200e_sba_write(u32 val, volatile u32 __iomem *addr)
+static void fore200e_sba_write(u32 val, volatile u32 __iomem *addr)
 {
     sbus_writel(val, addr);
 }
 
-
-static u32
-fore200e_sba_dma_map(struct fore200e* fore200e, void* virt_addr, int size, int direction)
+static u32 fore200e_sba_dma_map(struct fore200e *fore200e, void* virt_addr, int size, int direction)
 {
-    struct sbus_dev *sdev = fore200e->bus_dev;
-    struct device *dev = &sdev->ofdev.dev;
-    u32 dma_addr = dma_map_single(dev, virt_addr, size, direction);
+	struct of_device *op = fore200e->bus_dev;
+	u32 dma_addr;
 
-    DPRINTK(3, "SBUS DVMA mapping: virt_addr = 0x%p, size = %d, direction = %d --> dma_addr = 0x%08x\n",
-	    virt_addr, size, direction, dma_addr);
+	dma_addr = dma_map_single(&op->dev, virt_addr, size, direction);
+
+	DPRINTK(3, "SBUS DVMA mapping: virt_addr = 0x%p, size = %d, direction = %d --> dma_addr = 0x%08x\n",
+		virt_addr, size, direction, dma_addr);
     
-    return dma_addr;
+	return dma_addr;
 }
 
-
-static void
-fore200e_sba_dma_unmap(struct fore200e* fore200e, u32 dma_addr, int size, int direction)
+static void fore200e_sba_dma_unmap(struct fore200e *fore200e, u32 dma_addr, int size, int direction)
 {
-    struct sbus_dev *sdev = fore200e->bus_dev;
-    struct device *dev = &sdev->ofdev.dev;
+	struct of_device *op = fore200e->bus_dev;
 
-    DPRINTK(3, "SBUS DVMA unmapping: dma_addr = 0x%08x, size = %d, direction = %d,\n",
-	    dma_addr, size, direction);
+	DPRINTK(3, "SBUS DVMA unmapping: dma_addr = 0x%08x, size = %d, direction = %d,\n",
+		dma_addr, size, direction);
 
-    dma_unmap_single(dev, dma_addr, size, direction);
+	dma_unmap_single(&op->dev, dma_addr, size, direction);
 }
 
-
-static void
-fore200e_sba_dma_sync_for_cpu(struct fore200e* fore200e, u32 dma_addr, int size, int direction)
+static void fore200e_sba_dma_sync_for_cpu(struct fore200e *fore200e, u32 dma_addr, int size, int direction)
 {
-    struct sbus_dev *sdev = fore200e->bus_dev;
-    struct device *dev = &sdev->ofdev.dev;
+	struct of_device *op = fore200e->bus_dev;
 
-    DPRINTK(3, "SBUS DVMA sync: dma_addr = 0x%08x, size = %d, direction = %d\n", dma_addr, size, direction);
+	DPRINTK(3, "SBUS DVMA sync: dma_addr = 0x%08x, size = %d, direction = %d\n", dma_addr, size, direction);
     
-    dma_sync_single_for_cpu(dev, dma_addr, size, direction);
+	dma_sync_single_for_cpu(&op->dev, dma_addr, size, direction);
 }
 
-static void
-fore200e_sba_dma_sync_for_device(struct fore200e* fore200e, u32 dma_addr, int size, int direction)
+static void fore200e_sba_dma_sync_for_device(struct fore200e *fore200e, u32 dma_addr, int size, int direction)
 {
-    struct sbus_dev *sdev = fore200e->bus_dev;
-    struct device *dev = &sdev->ofdev.dev;
+	struct of_device *op = fore200e->bus_dev;
 
-    DPRINTK(3, "SBUS DVMA sync: dma_addr = 0x%08x, size = %d, direction = %d\n", dma_addr, size, direction);
+	DPRINTK(3, "SBUS DVMA sync: dma_addr = 0x%08x, size = %d, direction = %d\n", dma_addr, size, direction);
 
-    dma_sync_single_for_device(dev, dma_addr, size, direction);
+	dma_sync_single_for_device(&op->dev, dma_addr, size, direction);
 }
 
-
-/* allocate a DVMA consistent chunk of memory intended to act as a communication mechanism
-   (to hold descriptors, status, queues, etc.) shared by the driver and the adapter */
-
-static int
-fore200e_sba_dma_chunk_alloc(struct fore200e* fore200e, struct chunk* chunk,
-			     int size, int nbr, int alignment)
+/* Allocate a DVMA consistent chunk of memory intended to act as a communication mechanism
+ * (to hold descriptors, status, queues, etc.) shared by the driver and the adapter.
+ */
+static int fore200e_sba_dma_chunk_alloc(struct fore200e *fore200e, struct chunk *chunk,
+					int size, int nbr, int alignment)
 {
-    struct sbus_dev *sdev = (struct sbus_dev *) fore200e->bus_dev;
-    struct device *dev = &sdev->ofdev.dev;
+	struct of_device *op = fore200e->bus_dev;
 
-    chunk->alloc_size = chunk->align_size = size * nbr;
+	chunk->alloc_size = chunk->align_size = size * nbr;
 
-    /* returned chunks are page-aligned */
-    chunk->alloc_addr = dma_alloc_coherent(dev, chunk->alloc_size,
-					   &chunk->dma_addr, GFP_ATOMIC);
+	/* returned chunks are page-aligned */
+	chunk->alloc_addr = dma_alloc_coherent(&op->dev, chunk->alloc_size,
+					       &chunk->dma_addr, GFP_ATOMIC);
 
-    if ((chunk->alloc_addr = NULL) || (chunk->dma_addr = 0))
-	return -ENOMEM;
+	if ((chunk->alloc_addr = NULL) || (chunk->dma_addr = 0))
+		return -ENOMEM;
 
-    chunk->align_addr = chunk->alloc_addr;
+	chunk->align_addr = chunk->alloc_addr;
     
-    return 0;
+	return 0;
 }
 
-
 /* free a DVMA consistent chunk of memory */
-
-static void
-fore200e_sba_dma_chunk_free(struct fore200e* fore200e, struct chunk* chunk)
+static void fore200e_sba_dma_chunk_free(struct fore200e *fore200e, struct chunk *chunk)
 {
-    struct sbus_dev *sdev = (struct sbus_dev *) fore200e->bus_dev;
-    struct device *dev = &sdev->ofdev.dev;
+	struct of_device *op = fore200e->bus_dev;
 
-    dma_free_coherent(dev, chunk->alloc_size,
-		      chunk->alloc_addr, chunk->dma_addr);
+	dma_free_coherent(&op->dev, chunk->alloc_size,
+			  chunk->alloc_addr, chunk->dma_addr);
 }
 
-
-static void
-fore200e_sba_irq_enable(struct fore200e* fore200e)
+static void fore200e_sba_irq_enable(struct fore200e *fore200e)
 {
-    u32 hcr = fore200e->bus->read(fore200e->regs.sba.hcr) & SBA200E_HCR_STICKY;
-    fore200e->bus->write(hcr | SBA200E_HCR_INTR_ENA, fore200e->regs.sba.hcr);
+	u32 hcr = fore200e->bus->read(fore200e->regs.sba.hcr) & SBA200E_HCR_STICKY;
+	fore200e->bus->write(hcr | SBA200E_HCR_INTR_ENA, fore200e->regs.sba.hcr);
 }
 
-
-static int
-fore200e_sba_irq_check(struct fore200e* fore200e)
+static int fore200e_sba_irq_check(struct fore200e *fore200e)
 {
-    return fore200e->bus->read(fore200e->regs.sba.hcr) & SBA200E_HCR_INTR_REQ;
+	return fore200e->bus->read(fore200e->regs.sba.hcr) & SBA200E_HCR_INTR_REQ;
 }
 
-
-static void
-fore200e_sba_irq_ack(struct fore200e* fore200e)
+static void fore200e_sba_irq_ack(struct fore200e *fore200e)
 {
-    u32 hcr = fore200e->bus->read(fore200e->regs.sba.hcr) & SBA200E_HCR_STICKY;
-    fore200e->bus->write(hcr | SBA200E_HCR_INTR_CLR, fore200e->regs.sba.hcr);
+	u32 hcr = fore200e->bus->read(fore200e->regs.sba.hcr) & SBA200E_HCR_STICKY;
+	fore200e->bus->write(hcr | SBA200E_HCR_INTR_CLR, fore200e->regs.sba.hcr);
 }
 
-
-static void
-fore200e_sba_reset(struct fore200e* fore200e)
+static void fore200e_sba_reset(struct fore200e *fore200e)
 {
-    fore200e->bus->write(SBA200E_HCR_RESET, fore200e->regs.sba.hcr);
-    fore200e_spin(10);
-    fore200e->bus->write(0, fore200e->regs.sba.hcr);
+	fore200e->bus->write(SBA200E_HCR_RESET, fore200e->regs.sba.hcr);
+	fore200e_spin(10);
+	fore200e->bus->write(0, fore200e->regs.sba.hcr);
 }
 
-
-static int __init
-fore200e_sba_map(struct fore200e* fore200e)
+static int __init fore200e_sba_map(struct fore200e *fore200e)
 {
-    struct sbus_dev* sbus_dev = (struct sbus_dev*)fore200e->bus_dev;
-    unsigned int bursts;
+	struct of_device *op = fore200e->bus_dev;
+	unsigned int bursts;
 
-    /* gain access to the SBA specific registers  */
-    fore200e->regs.sba.hcr = sbus_ioremap(&sbus_dev->resource[0], 0, SBA200E_HCR_LENGTH, "SBA HCR");
-    fore200e->regs.sba.bsr = sbus_ioremap(&sbus_dev->resource[1], 0, SBA200E_BSR_LENGTH, "SBA BSR");
-    fore200e->regs.sba.isr = sbus_ioremap(&sbus_dev->resource[2], 0, SBA200E_ISR_LENGTH, "SBA ISR");
-    fore200e->virt_base    = sbus_ioremap(&sbus_dev->resource[3], 0, SBA200E_RAM_LENGTH, "SBA RAM");
+	/* gain access to the SBA specific registers  */
+	fore200e->regs.sba.hcr = of_ioremap(&op->resource[0], 0, SBA200E_HCR_LENGTH, "SBA HCR");
+	fore200e->regs.sba.bsr = of_ioremap(&op->resource[1], 0, SBA200E_BSR_LENGTH, "SBA BSR");
+	fore200e->regs.sba.isr = of_ioremap(&op->resource[2], 0, SBA200E_ISR_LENGTH, "SBA ISR");
+	fore200e->virt_base    = of_ioremap(&op->resource[3], 0, SBA200E_RAM_LENGTH, "SBA RAM");
 
-    if (fore200e->virt_base = NULL) {
-	printk(FORE200E "unable to map RAM of device %s\n", fore200e->name);
-	return -EFAULT;
-    }
+	if (!fore200e->virt_base) {
+		printk(FORE200E "unable to map RAM of device %s\n", fore200e->name);
+		return -EFAULT;
+	}
 
-    DPRINTK(1, "device %s mapped to 0x%p\n", fore200e->name, fore200e->virt_base);
+	DPRINTK(1, "device %s mapped to 0x%p\n", fore200e->name, fore200e->virt_base);
     
-    fore200e->bus->write(0x02, fore200e->regs.sba.isr); /* XXX hardwired interrupt level */
+	fore200e->bus->write(0x02, fore200e->regs.sba.isr); /* XXX hardwired interrupt level */
 
-    /* get the supported DVMA burst sizes */
-    bursts = prom_getintdefault(sbus_dev->bus->prom_node, "burst-sizes", 0x00);
+	/* get the supported DVMA burst sizes */
+	bursts = of_getintprop_default(op->node->parent, "burst-sizes", 0x00);
 
-    if (sbus_can_dma_64bit())
-	sbus_set_sbus64(&sbus_dev->ofdev.dev, bursts);
+	if (sbus_can_dma_64bit())
+		sbus_set_sbus64(&op->dev, bursts);
 
-    fore200e->state = FORE200E_STATE_MAP;
-    return 0;
+	fore200e->state = FORE200E_STATE_MAP;
+	return 0;
 }
 
-
-static void
-fore200e_sba_unmap(struct fore200e* fore200e)
+static void fore200e_sba_unmap(struct fore200e *fore200e)
 {
-    sbus_iounmap(fore200e->regs.sba.hcr, SBA200E_HCR_LENGTH);
-    sbus_iounmap(fore200e->regs.sba.bsr, SBA200E_BSR_LENGTH);
-    sbus_iounmap(fore200e->regs.sba.isr, SBA200E_ISR_LENGTH);
-    sbus_iounmap(fore200e->virt_base,    SBA200E_RAM_LENGTH);
-}
+	struct of_device *op = fore200e->bus_dev;
 
+	of_iounmap(&op->resource[0], fore200e->regs.sba.hcr, SBA200E_HCR_LENGTH);
+	of_iounmap(&op->resource[1], fore200e->regs.sba.bsr, SBA200E_BSR_LENGTH);
+	of_iounmap(&op->resource[2], fore200e->regs.sba.isr, SBA200E_ISR_LENGTH);
+	of_iounmap(&op->resource[3], fore200e->virt_base,    SBA200E_RAM_LENGTH);
+}
 
-static int __init
-fore200e_sba_configure(struct fore200e* fore200e)
+static int __init fore200e_sba_configure(struct fore200e *fore200e)
 {
-    fore200e->state = FORE200E_STATE_CONFIGURE;
-    return 0;
+	fore200e->state = FORE200E_STATE_CONFIGURE;
+	return 0;
 }
 
-
-static struct fore200e* __init
-fore200e_sba_detect(const struct fore200e_bus* bus, int index)
+static int __init fore200e_sba_prom_read(struct fore200e *fore200e, struct prom_data *prom)
 {
-    struct fore200e*          fore200e;
-    struct sbus_bus* sbus_bus;
-    struct sbus_dev* sbus_dev = NULL;
-    
-    unsigned int     count = 0;
-    
-    for_each_sbus (sbus_bus) {
-	for_each_sbusdev (sbus_dev, sbus_bus) {
-	    if (strcmp(sbus_dev->prom_name, SBA200E_PROM_NAME) = 0) {
-		if (count >= index)
-		    goto found;
-		count++;
-	    }
-	}
-    }
-    return NULL;
-    
-  found:
-    if (sbus_dev->num_registers != 4) {
-	printk(FORE200E "this %s device has %d instead of 4 registers\n",
-	       bus->model_name, sbus_dev->num_registers);
-	return NULL;
-    }
-
-    fore200e = kzalloc(sizeof(struct fore200e), GFP_KERNEL);
-    if (fore200e = NULL)
-	return NULL;
+	struct of_device *op = fore200e->bus_dev;
+	const u8 *prop;
+	int len;
 
-    fore200e->bus     = bus;
-    fore200e->bus_dev = sbus_dev;
-    fore200e->irq     = sbus_dev->irqs[ 0 ];
+	prop = of_get_property(op->node, "madaddrlo2", &len);
+	if (!prop)
+		return -ENODEV;
+	memcpy(&prom->mac_addr[4], prop, 4);
 
-    fore200e->phys_base = (unsigned long)sbus_dev;
+	prop = of_get_property(op->node, "madaddrhi4", &len);
+	if (!prop)
+		return -ENODEV;
+	memcpy(&prom->mac_addr[2], prop, 4);
 
-    sprintf(fore200e->name, "%s-%d", bus->model_name, index - 1);
+	prom->serial_number = of_getintprop_default(op->node, "serialnumber", 0);
+	prom->hw_revision = of_getintprop_default(op->node, "promversion", 0);
     
-    return fore200e;
+	return 0;
 }
 
-
-static int __init
-fore200e_sba_prom_read(struct fore200e* fore200e, struct prom_data* prom)
+static int fore200e_sba_proc_read(struct fore200e *fore200e, char *page)
 {
-    struct sbus_dev* sbus_dev = (struct sbus_dev*) fore200e->bus_dev;
-    int                       len;
-
-    len = prom_getproperty(sbus_dev->prom_node, "macaddrlo2", &prom->mac_addr[ 4 ], 4);
-    if (len < 0)
-	return -EBUSY;
-
-    len = prom_getproperty(sbus_dev->prom_node, "macaddrhi4", &prom->mac_addr[ 2 ], 4);
-    if (len < 0)
-	return -EBUSY;
-    
-    prom_getproperty(sbus_dev->prom_node, "serialnumber",
-		     (char*)&prom->serial_number, sizeof(prom->serial_number));
-    
-    prom_getproperty(sbus_dev->prom_node, "promversion",
-		     (char*)&prom->hw_revision, sizeof(prom->hw_revision));
-    
-    return 0;
-}
+	struct of_device *op = fore200e->bus_dev;
+	const struct linux_prom_registers *regs;
 
+	regs = of_get_property(op->node, "reg", NULL);
 
-static int
-fore200e_sba_proc_read(struct fore200e* fore200e, char *page)
-{
-    struct sbus_dev* sbus_dev = (struct sbus_dev*)fore200e->bus_dev;
-
-    return sprintf(page, "   SBUS slot/device:\t\t%d/'%s'\n", sbus_dev->slot, sbus_dev->prom_name);
+	return sprintf(page, "   SBUS slot/device:\t\t%d/'%s'\n",
+		       (regs ? regs->which_io : 0), op->node->name);
 }
 #endif /* CONFIG_SBUS */
 
@@ -2586,7 +2513,7 @@ fore200e_load_and_start_fw(struct fore200e* fore200e)
 	device = &((struct pci_dev *) fore200e->bus_dev)->dev;
 #ifdef CONFIG_SBUS
     else if (strcmp(fore200e->bus->model_name, "SBA-200E") = 0)
-	device = &((struct sbus_dev *) fore200e->bus_dev)->ofdev.dev;
+	device = &((struct of_device *) fore200e->bus_dev)->dev;
 #endif
     else
 	return err;
@@ -2715,6 +2642,66 @@ fore200e_init(struct fore200e* fore200e)
     return 0;
 }
 
+#ifdef CONFIG_SBUS
+static int __devinit fore200e_sba_probe(struct of_device *op,
+					const struct of_device_id *match)
+{
+	const struct fore200e_bus *bus = match->data;
+	struct fore200e *fore200e;
+	static int index = 0;
+	int err;
+
+	fore200e = kzalloc(sizeof(struct fore200e), GFP_KERNEL);
+	if (!fore200e)
+		return -ENOMEM;
+
+	fore200e->bus = bus;
+	fore200e->bus_dev = op;
+	fore200e->irq = op->irqs[0];
+	fore200e->phys_base = op->resource[0].start;
+
+	sprintf(fore200e->name, "%s-%d", bus->model_name, index);
+
+	err = fore200e_init(fore200e);
+	if (err < 0) {
+		fore200e_shutdown(fore200e);
+		kfree(fore200e);
+		return err;
+	}
+
+	index++;
+	dev_set_drvdata(&op->dev, fore200e);
+
+	return 0;
+}
+
+static int __devexit fore200e_sba_remove(struct of_device *op)
+{
+	struct fore200e *fore200e = dev_get_drvdata(&op->dev);
+
+	fore200e_shutdown(fore200e);
+	kfree(fore200e);
+
+	return 0;
+}
+
+static struct of_device_id fore200e_sba_match[] = {
+	{
+		.name = SBA200E_PROM_NAME,
+		.data = (void *) &fore200e_bus[1],
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, fore200e_sba_match);
+
+static struct of_platform_driver fore200e_sba_driver = {
+	.name		= "fore_200e",
+	.match_table	= fore200e_sba_match,
+	.probe		= fore200e_sba_probe,
+	.remove		= __devexit_p(fore200e_sba_remove),
+};
+#endif
+
 #ifdef CONFIG_PCI
 static int __devinit
 fore200e_pca_detect(struct pci_dev *pci_dev, const struct pci_device_id *pci_ent)
@@ -2798,67 +2785,40 @@ static struct pci_driver fore200e_pca_driver = {
 };
 #endif
 
-
-static int __init
-fore200e_module_init(void)
+static int __init fore200e_module_init(void)
 {
-    const struct fore200e_bus* bus;
-    struct       fore200e*     fore200e;
-    int                        index;
+	int err;
 
-    printk(FORE200E "FORE Systems 200E-series ATM driver - version " FORE200E_VERSION "\n");
+	printk(FORE200E "FORE Systems 200E-series ATM driver - version " FORE200E_VERSION "\n");
 
-    /* for each configured bus interface */
-    for (bus = fore200e_bus; bus->model_name; bus++) {
-
-	/* detect all boards present on that bus */
-	for (index = 0; bus->detect && (fore200e = bus->detect(bus, index)); index++) {
-	    
-	    printk(FORE200E "device %s found at 0x%lx, IRQ %s\n",
-		   fore200e->bus->model_name, 
-		   fore200e->phys_base, fore200e_irq_itoa(fore200e->irq));
-
-	    sprintf(fore200e->name, "%s-%d", bus->model_name, index);
-
-	    if (fore200e_init(fore200e) < 0) {
-
-		fore200e_shutdown(fore200e);
-		break;
-	    }
-
-	    list_add(&fore200e->entry, &fore200e_boards);
-	}
-    }
+#ifdef CONFIG_SBUS
+	err = of_register_driver(&fore200e_sba_driver, &of_bus_type);
+	if (err)
+		return err;
+#endif
 
 #ifdef CONFIG_PCI
-    if (!pci_register_driver(&fore200e_pca_driver))
-	return 0;
+	err = pci_register_driver(&fore200e_pca_driver);
 #endif
 
-    if (!list_empty(&fore200e_boards))
-	return 0;
+#ifdef CONFIG_SBUS
+	if (err)
+		of_unregister_driver(&fore200e_sba_driver);
+#endif
 
-    return -ENODEV;
+	return err;
 }
 
-
-static void __exit
-fore200e_module_cleanup(void)
+static void __exit fore200e_module_cleanup(void)
 {
-    struct fore200e *fore200e, *next;
-
 #ifdef CONFIG_PCI
-    pci_unregister_driver(&fore200e_pca_driver);
+	pci_unregister_driver(&fore200e_pca_driver);
+#endif
+#ifdef CONFIG_SBUS
+	of_unregister_driver(&fore200e_sba_driver);
 #endif
-
-    list_for_each_entry_safe(fore200e, next, &fore200e_boards, entry) {
-	fore200e_shutdown(fore200e);
-	kfree(fore200e);
-    }
-    DPRINTK(1, "module being removed\n");
 }
 
-
 static int
 fore200e_proc_read(struct atm_dev *dev, loff_t* pos, char* page)
 {
@@ -3177,7 +3137,6 @@ static const struct fore200e_bus fore200e_bus[] = {
       fore200e_pca_dma_sync_for_device,
       fore200e_pca_dma_chunk_alloc,
       fore200e_pca_dma_chunk_free,
-      NULL,
       fore200e_pca_configure,
       fore200e_pca_map,
       fore200e_pca_reset,
@@ -3199,7 +3158,6 @@ static const struct fore200e_bus fore200e_bus[] = {
       fore200e_sba_dma_sync_for_device,
       fore200e_sba_dma_chunk_alloc,
       fore200e_sba_dma_chunk_free,
-      fore200e_sba_detect, 
       fore200e_sba_configure,
       fore200e_sba_map,
       fore200e_sba_reset,
diff --git a/drivers/atm/fore200e.h b/drivers/atm/fore200e.h
index 5c6e7ad..7f97c09 100644
--- a/drivers/atm/fore200e.h
+++ b/drivers/atm/fore200e.h
@@ -778,9 +778,9 @@ typedef struct fore200e_pca_regs {
 /* SBA-200E registers */
 
 typedef struct fore200e_sba_regs {
-    volatile u32 __iomem *hcr;    /* address of host control register              */
-    volatile u32 __iomem *bsr;    /* address of burst transfer size register       */
-    volatile u32 __iomem *isr;    /* address of interrupt level selection register */
+    u32 __iomem *hcr;    /* address of host control register              */
+    u32 __iomem *bsr;    /* address of burst transfer size register       */
+    u32 __iomem *isr;    /* address of interrupt level selection register */
 } fore200e_sba_regs_t;
 
 
@@ -810,7 +810,6 @@ typedef struct fore200e_bus {
     void                 (*dma_sync_for_device)(struct fore200e*, u32, int, int);
     int                  (*dma_chunk_alloc)(struct fore200e*, struct chunk*, int, int, int);
     void                 (*dma_chunk_free)(struct fore200e*, struct chunk*);
-    struct fore200e*     (*detect)(const struct fore200e_bus*, int);
     int                  (*configure)(struct fore200e*); 
     int                  (*map)(struct fore200e*); 
     void                 (*reset)(struct fore200e*);
-- 
1.5.6.5.GIT


From: Daniel Hellstrom <daniel@gaisler.com>
Date: Tue, 24 May 2011 07:04:47 +0000
Subject: [PATCH 2/3 v3] sparc32,leon: added LEON-common low-level PCI routines
Message-Id: <1306220688-8438-2-git-send-email-daniel@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The LEON architecture does not have a BIOS or bootloader that
initializes PCI for us, instead Linux generic PCI layer is used
to set up resources and IRQ.

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
---
 arch/sparc/Kconfig                |    5 +
 arch/sparc/include/asm/leon_pci.h |   21 +++
 arch/sparc/include/asm/pci_32.h   |   24 ++++
 arch/sparc/kernel/Makefile        |    1 +
 arch/sparc/kernel/leon_pci.c      |  253 +++++++++++++++++++++++++++++++++++++
 drivers/pci/Makefile              |    1 +
 6 files changed, 305 insertions(+), 0 deletions(-)
 create mode 100644 arch/sparc/include/asm/leon_pci.h
 create mode 100644 arch/sparc/kernel/leon_pci.c

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index c06bd34..c4bdd27 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -541,6 +541,11 @@ config PCIC_PCI
 	depends on PCI && !SPARC_LEON
 	default y
 
+config LEON_PCI
+	bool
+	depends on PCI && SPARC_LEON
+	default y
+
 source "drivers/pci/Kconfig"
 
 source "drivers/pcmcia/Kconfig"
diff --git a/arch/sparc/include/asm/leon_pci.h b/arch/sparc/include/asm/leon_pci.h
new file mode 100644
index 0000000..42b4b31
--- /dev/null
+++ b/arch/sparc/include/asm/leon_pci.h
@@ -0,0 +1,21 @@
+/*
+ * asm/leon_pci.h
+ *
+ * Copyright (C) 2011 Aeroflex Gaisler AB, Daniel Hellstrom
+ */
+
+#ifndef _ASM_LEON_PCI_H_
+#define _ASM_LEON_PCI_H_
+
+/* PCI related definitions */
+struct leon_pci_info {
+	struct pci_ops *ops;
+	struct resource	io_space;
+	struct resource	mem_space;
+	int (*map_irq)(struct pci_dev *dev, u8 slot, u8 pin);
+};
+
+extern void leon_pci_init(struct platform_device *ofdev,
+				struct leon_pci_info *info);
+
+#endif /* _ASM_LEON_PCI_H_ */
diff --git a/arch/sparc/include/asm/pci_32.h b/arch/sparc/include/asm/pci_32.h
index 332ac9a..862e3ce 100644
--- a/arch/sparc/include/asm/pci_32.h
+++ b/arch/sparc/include/asm/pci_32.h
@@ -47,7 +47,31 @@ extern struct device_node *pci_device_to_OF_node(struct pci_dev *pdev);
 
 #endif /* __KERNEL__ */
 
+#ifndef CONFIG_LEON_PCI
 /* generic pci stuff */
 #include <asm-generic/pci.h>
+#else
+/*
+ * On LEON PCI Memory space is mapped 1:1 with physical address space.
+ *
+ * I/O space is located at low 64Kbytes in PCI I/O space. The I/O addresses
+ * are converted into CPU addresses to virtual addresses that are mapped with
+ * MMU to the PCI Host PCI I/O space window which are translated to the low
+ * 64Kbytes by the Host controller.
+ */
+
+extern void
+pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
+			struct resource *res);
+
+extern void
+pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
+			struct pci_bus_region *region);
+
+static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
+{
+	return PCI_IRQ_NONE;
+}
+#endif
 
 #endif /* __SPARC_PCI_H */
diff --git a/arch/sparc/kernel/Makefile b/arch/sparc/kernel/Makefile
index 59a2256..b02d2e3 100644
--- a/arch/sparc/kernel/Makefile
+++ b/arch/sparc/kernel/Makefile
@@ -74,6 +74,7 @@ obj-$(CONFIG_SPARC64_SMP) += cpumap.o
 obj-y                     += dma.o
 
 obj-$(CONFIG_PCIC_PCI)    += pcic.o
+obj-$(CONFIG_LEON_PCI)    += leon_pci.o
 
 obj-$(CONFIG_SMP)         += trampoline_$(BITS).o smp_$(BITS).o
 obj-$(CONFIG_SPARC32_SMP) += sun4m_smp.o sun4d_smp.o leon_smp.o
diff --git a/arch/sparc/kernel/leon_pci.c b/arch/sparc/kernel/leon_pci.c
new file mode 100644
index 0000000..a8a9a27
--- /dev/null
+++ b/arch/sparc/kernel/leon_pci.c
@@ -0,0 +1,253 @@
+/*
+ * leon_pci.c: LEON Host PCI support
+ *
+ * Copyright (C) 2011 Aeroflex Gaisler AB, Daniel Hellstrom
+ *
+ * Code is partially derived from pcic.c
+ */
+
+#include <linux/of_device.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <asm/leon.h>
+#include <asm/leon_pci.h>
+
+/* The LEON architecture does not rely on a BIOS or bootloader to setup
+ * PCI for us. The Linux generic routines are used to setup resources,
+ * reset values of confuration-space registers settings ae preseved.
+ */
+void leon_pci_init(struct platform_device *ofdev, struct leon_pci_info *info)
+{
+	struct pci_bus *root_bus;
+
+	root_bus = pci_scan_bus_parented(&ofdev->dev, 0, info->ops, info);
+	if (root_bus) {
+		root_bus->resource[0] = &info->io_space;
+		root_bus->resource[1] = &info->mem_space;
+		root_bus->resource[2] = NULL;
+
+		/* Init all PCI devices into PCI tree */
+		pci_bus_add_devices(root_bus);
+
+		/* Setup IRQs of all devices using custom routines */
+		pci_fixup_irqs(pci_common_swizzle, info->map_irq);
+
+		/* Assign devices with resources */
+		pci_assign_unassigned_resources();
+	}
+}
+
+/* PCI Memory and Prefetchable Memory is direct-mapped. However I/O Space is
+ * accessed through a Window which is translated to low 64KB in PCI space, the
+ * first 4KB is not used so 60KB is available.
+ *
+ * This function is used by generic code to translate resource addresses into
+ * PCI addresses.
+ */
+void pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
+			     struct resource *res)
+{
+	struct leon_pci_info *info = dev->bus->sysdata;
+
+	region->start = res->start;
+	region->end = res->end;
+
+	if (res->flags & IORESOURCE_IO) {
+		region->start -= (info->io_space.start - 0x1000);
+		region->end -= (info->io_space.start - 0x1000);
+	}
+}
+EXPORT_SYMBOL(pcibios_resource_to_bus);
+
+/* see pcibios_resource_to_bus() comment */
+void pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
+			     struct pci_bus_region *region)
+{
+	struct leon_pci_info *info = dev->bus->sysdata;
+
+	res->start = region->start;
+	res->end = region->end;
+
+	if (res->flags & IORESOURCE_IO) {
+		res->start += (info->io_space.start - 0x1000);
+		res->end += (info->io_space.start - 0x1000);
+	}
+}
+EXPORT_SYMBOL(pcibios_bus_to_resource);
+
+void __devinit pcibios_fixup_bus(struct pci_bus *pbus)
+{
+	struct leon_pci_info *info = pbus->sysdata;
+	struct pci_dev *dev;
+	int i, has_io, has_mem;
+	u16 cmd;
+
+	/* Generic PCI bus probing sets these to point at
+	 * &io{port,mem}_resouce which is wrong for us.
+	 */
+	if (pbus->self = NULL) {
+		pbus->resource[0] = &info->io_space;
+		pbus->resource[1] = &info->mem_space;
+		pbus->resource[2] = NULL;
+	}
+
+	list_for_each_entry(dev, &pbus->devices, bus_list) {
+		/*
+		 * We can not rely on that the bootloader has enabled I/O
+		 * or memory access to PCI devices. Instead we enable it here
+		 * if the device has BARs of respective type.
+		 */
+		has_io = has_mem = 0;
+		for (i = 0; i < PCI_ROM_RESOURCE; i++) {
+			unsigned long f = dev->resource[i].flags;
+			if (f & IORESOURCE_IO)
+				has_io = 1;
+			else if (f & IORESOURCE_MEM)
+				has_mem = 1;
+		}
+		/* ROM BARs are mapped into 32-bit memory space */
+		if (dev->resource[PCI_ROM_RESOURCE].end != 0) {
+			dev->resource[PCI_ROM_RESOURCE].flags |+							IORESOURCE_ROM_ENABLE;
+			has_mem = 1;
+		}
+		pci_bus_read_config_word(pbus, dev->devfn, PCI_COMMAND, &cmd);
+		if (has_io && !(cmd & PCI_COMMAND_IO)) {
+#ifdef CONFIG_PCI_DEBUG
+			printk(KERN_INFO "LEONPCI: Enabling I/O for dev %s\n",
+					 pci_name(dev));
+#endif
+			cmd |= PCI_COMMAND_IO;
+			pci_bus_write_config_word(pbus, dev->devfn, PCI_COMMAND,
+									cmd);
+		}
+		if (has_mem && !(cmd & PCI_COMMAND_MEMORY)) {
+#ifdef CONFIG_PCI_DEBUG
+			printk(KERN_INFO "LEONPCI: Enabling MEMORY for dev"
+					 "%s\n", pci_name(dev));
+#endif
+			cmd |= PCI_COMMAND_MEMORY;
+			pci_bus_write_config_word(pbus, dev->devfn, PCI_COMMAND,
+									cmd);
+		}
+	}
+}
+
+/*
+ * Other archs parse arguments here.
+ */
+char * __devinit pcibios_setup(char *str)
+{
+	return str;
+}
+
+resource_size_t pcibios_align_resource(void *data, const struct resource *res,
+				resource_size_t size, resource_size_t align)
+{
+	return res->start;
+}
+
+int pcibios_enable_device(struct pci_dev *dev, int mask)
+{
+	return pci_enable_resources(dev, mask);
+}
+
+struct device_node *pci_device_to_OF_node(struct pci_dev *pdev)
+{
+	/*
+	 * Currently the OpenBoot nodes are not connected with the PCI device,
+	 * this is because the LEON PROM does not create PCI nodes. Eventually
+	 * this will change and the same approach as pcic.c can be used to
+	 * match PROM nodes with pci devices.
+	 */
+	return NULL;
+}
+EXPORT_SYMBOL(pci_device_to_OF_node);
+
+void __devinit pcibios_update_irq(struct pci_dev *dev, int irq)
+{
+#ifdef CONFIG_PCI_DEBUG
+	printk(KERN_DEBUG "LEONPCI: Assigning IRQ %02d to %s\n", irq,
+		pci_name(dev));
+#endif
+	pci_write_config_byte(dev, PCI_INTERRUPT_LINE, irq);
+}
+
+/* in/out routines taken from pcic.c
+ *
+ * This probably belongs here rather than ioport.c because
+ * we do not want this crud linked into SBus kernels.
+ * Also, think for a moment about likes of floppy.c that
+ * include architecture specific parts. They may want to redefine ins/outs.
+ *
+ * We do not use horrible macros here because we want to
+ * advance pointer by sizeof(size).
+ */
+void outsb(unsigned long addr, const void *src, unsigned long count)
+{
+	while (count) {
+		count -= 1;
+		outb(*(const char *)src, addr);
+		src += 1;
+		/* addr += 1; */
+	}
+}
+EXPORT_SYMBOL(outsb);
+
+void outsw(unsigned long addr, const void *src, unsigned long count)
+{
+	while (count) {
+		count -= 2;
+		outw(*(const short *)src, addr);
+		src += 2;
+		/* addr += 2; */
+	}
+}
+EXPORT_SYMBOL(outsw);
+
+void outsl(unsigned long addr, const void *src, unsigned long count)
+{
+	while (count) {
+		count -= 4;
+		outl(*(const long *)src, addr);
+		src += 4;
+		/* addr += 4; */
+	}
+}
+EXPORT_SYMBOL(outsl);
+
+void insb(unsigned long addr, void *dst, unsigned long count)
+{
+	while (count) {
+		count -= 1;
+		*(unsigned char *)dst = inb(addr);
+		dst += 1;
+		/* addr += 1; */
+	}
+}
+EXPORT_SYMBOL(insb);
+
+void insw(unsigned long addr, void *dst, unsigned long count)
+{
+	while (count) {
+		count -= 2;
+		*(unsigned short *)dst = inw(addr);
+		dst += 2;
+		/* addr += 2; */
+	}
+}
+EXPORT_SYMBOL(insw);
+
+void insl(unsigned long addr, void *dst, unsigned long count)
+{
+	while (count) {
+		count -= 4;
+		/*
+		 * XXX I am sure we are in for an unaligned trap here.
+		 */
+		*(unsigned long *)dst = inl(addr);
+		dst += 4;
+		/* addr += 4; */
+	}
+}
+EXPORT_SYMBOL(insl);
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index c85f744..094308e 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -51,6 +51,7 @@ obj-$(CONFIG_X86_VISWS) += setup-irq.o
 obj-$(CONFIG_MN10300) += setup-bus.o
 obj-$(CONFIG_MICROBLAZE) += setup-bus.o
 obj-$(CONFIG_TILE) += setup-bus.o setup-irq.o
+obj-$(CONFIG_SPARC_LEON) += setup-bus.o setup-irq.o
 
 #
 # ACPI Related PCI FW Functions
-- 
1.6.3.3


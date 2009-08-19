From: konrad@gaisler.com
Date: Wed, 19 Aug 2009 11:35:26 +0000
Subject: [PATCH 1/1] sparc,leon: Amba plug and play devices directory.
Message-Id: <1250681726-29459-1-git-send-email-konrad@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Konrad Eisele <konrad@gaisler.com>

Add Amba plug and play scanning for Aeroflex Gaisler's
GRLIB ips. All devices have a vendor and device id
similar to pci. The subfolders are named <vendor>/<device>.
First driver included is one for the APB uart: gaisler/apbuart.

Signed-off-by: Konrad Eisele <konrad@gaisler.com>
---
 drivers/Kconfig                          |    2 +
 drivers/Makefile                         |    1 +
 drivers/ambapp/Kconfig                   |    9 +
 drivers/ambapp/Makefile                  |    6 +
 drivers/ambapp/ambapp.c                  |  361 +++++++++++++
 drivers/ambapp/ambapp.h                  |  246 +++++++++
 drivers/ambapp/ambapp_driver.c           |  219 ++++++++
 drivers/ambapp/gaisler/Kconfig           |   20 +
 drivers/ambapp/gaisler/Makefile          |    3 +
 drivers/ambapp/gaisler/apbuart/Makefile  |    3 +
 drivers/ambapp/gaisler/apbuart/apbuart.c |  837 ++++++++++++++++++++++++++++++
 include/linux/serial_core.h              |    3 +
 12 files changed, 1710 insertions(+), 0 deletions(-)
 create mode 100644 drivers/ambapp/Kconfig
 create mode 100644 drivers/ambapp/Makefile
 create mode 100644 drivers/ambapp/ambapp.c
 create mode 100644 drivers/ambapp/ambapp.h
 create mode 100644 drivers/ambapp/ambapp_driver.c
 create mode 100644 drivers/ambapp/gaisler/Kconfig
 create mode 100644 drivers/ambapp/gaisler/Makefile
 create mode 100644 drivers/ambapp/gaisler/apbuart/Makefile
 create mode 100644 drivers/ambapp/gaisler/apbuart/apbuart.c

diff --git a/drivers/Kconfig b/drivers/Kconfig
index 48bbdbe..f2a19c5 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -113,4 +113,6 @@ source "drivers/xen/Kconfig"
 source "drivers/staging/Kconfig"
 
 source "drivers/platform/Kconfig"
+
+source "drivers/ambapp/Kconfig"
 endmenu
diff --git a/drivers/Makefile b/drivers/Makefile
index bc4205d..e2d0e96 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_ACPI)		+= acpi/
 # was used and do nothing if so
 obj-$(CONFIG_PNP)		+= pnp/
 obj-$(CONFIG_ARM_AMBA)		+= amba/
+obj-$(CONFIG_SPARC_LEON)	+= ambapp/
 
 obj-$(CONFIG_XEN)		+= xen/
 
diff --git a/drivers/ambapp/Kconfig b/drivers/ambapp/Kconfig
new file mode 100644
index 0000000..c7dc306
--- /dev/null
+++ b/drivers/ambapp/Kconfig
@@ -0,0 +1,9 @@
+#------------------------------------------------------------------------------
+# Ambapp device driver configuration
+#------------------------------------------------------------------------------
+
+menu "Grlib: Amba plug and play device driver configuration"
+
+source "drivers/ambapp/gaisler/Kconfig"
+
+endmenu
diff --git a/drivers/ambapp/Makefile b/drivers/ambapp/Makefile
new file mode 100644
index 0000000..92f3c0d
--- /dev/null
+++ b/drivers/ambapp/Makefile
@@ -0,0 +1,6 @@
+#
+# Makefile for the Plug & Play AMBA bus specific drivers.
+#
+
+obj-y		        += ambapp.o ambapp_driver.o
+obj-y                   += gaisler/
diff --git a/drivers/ambapp/ambapp.c b/drivers/ambapp/ambapp.c
new file mode 100644
index 0000000..0c06549
--- /dev/null
+++ b/drivers/ambapp/ambapp.c
@@ -0,0 +1,361 @@
+/*
+ *  Amba plug and play scanning
+ *
+ *  Copyright (C) 2008 Daniel Hellstrom <daniel@gaisler.com> Aeroflex Gaisler AB
+ *  Copyright (C) 2009 Konrad Eisele <konrad@gaisler.com> Aeroflex Gaisler AB
+ */
+
+#include <linux/ptrace.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/module.h>
+#include <linux/of.h>
+
+#include <asm/leon.h>
+#include <asm/prom.h>
+#include <asm/openprom.h>
+#include "ambapp.h"
+
+/*#define DEBUG_CONFIG */
+#ifdef DEBUG_CONFIG
+#define PRE b,
+#define DBGPRT(p) do {						\
+		char b[1024]; sprintf p; console_print_leon(b);	\
+	} while (0)
+#else
+#define PRE KERN_INFO
+#define DBGPRT(p) printk p
+#endif
+
+/* Structure containing address to devices found on the Amba Plug&Play bus */
+struct amba_confarea_type amba_conf[MAX_AMBA_BUS_CNT];
+EXPORT_SYMBOL(amba_conf);
+
+int amba_bus_cnt;
+int amba_is_init;
+
+void vendor_dev_string(unsigned long conf, char *vendorbuf, char *devbuf)
+{
+	int vendor = amba_vendor(conf);
+	int dev = amba_device(conf);
+	char *devstr;
+	char *vendorstr;
+	sprintf(vendorbuf, "Unknown vendor %2x", vendor);
+	sprintf(devbuf, "Unknown device %2x", dev);
+	vendorstr = vendor_id2str(vendor);
+	if (vendorstr)
+		sprintf(vendorbuf, "%s", vendorstr);
+	devstr = device_id2str(vendor, dev);
+	if (devstr)
+		sprintf(devbuf, "%s", devstr);
+}
+EXPORT_SYMBOL(vendor_dev_string);
+
+void amba_print_config(struct amba_confarea_type *a_conf)
+{
+	char devbuf[128];
+	char vendorbuf[128];
+	unsigned int conf;
+	int i = 0;
+	int j = 0;
+	unsigned int addr;
+	unsigned int m;
+	DBGPRT((PRE "               Vendor          Device\n"));
+	DBGPRT((PRE "AHB masters:\n"));
+	i = 0;
+	while (i < a_conf->ahbmst.devnr) {
+		conf = amba_get_confword(a_conf->ahbmst, i, 0);
+		vendor_dev_string(conf, vendorbuf, devbuf);
+		DBGPRT((PRE "%2i(%2x:%3x|%2i): %16s %16s \n", i,
+			amba_vendor(conf), amba_device(conf), amba_irq(conf),
+			vendorbuf, devbuf));
+		for (j = 0; j < 4; j++) {
+			m = amba_ahb_get_membar(a_conf->ahbmst, i, j);
+			if (m) {
+				addr = amba_membar_start(m);
+				DBGPRT((PRE " +%i: 0x%x \n", j, addr));
+			}
+		}
+		i++;
+	}
+	DBGPRT((PRE "AHB slaves:\n"));
+	i = 0;
+	while (i < a_conf->ahbslv.devnr) {
+		conf = amba_get_confword(a_conf->ahbslv, i, 0);
+		vendor_dev_string(conf, vendorbuf, devbuf);
+		DBGPRT((PRE "%2i(%2x:%3x|%2i): %16s %16s \n", i,
+			amba_vendor(conf), amba_device(conf), amba_irq(conf),
+			vendorbuf, devbuf));
+
+		for (j = 0; j < 4; j++) {
+			m = amba_ahb_get_membar(a_conf->ahbslv, i, j);
+			if (m) {
+				addr = amba_membar_start(m);
+				if (amba_membar_type(m) = AMBA_TYPE_AHBIO) {
+					addr = AMBA_TYPE_AHBIO_ADDR(addr);
+				} else if (amba_membar_type(m) =
+					   AMBA_TYPE_APBIO) {
+					DBGPRT((PRE "Warning: apbio membar\n"));
+				}
+				DBGPRT((PRE " +%i: 0x%x (raw:0x%x)\n", j, addr,
+					m));
+			}
+		}
+		i++;
+	}
+	DBGPRT((PRE "APB slaves:\n"));
+	i = 0;
+	while (i < a_conf->apbslv.devnr) {
+
+		conf = amba_get_confword(a_conf->apbslv, i, 0);
+		vendor_dev_string(conf, vendorbuf, devbuf);
+		DBGPRT((PRE "%2i(%2x:%3x|%2i): %16s %16s \n", i,
+			amba_vendor(conf), amba_device(conf), amba_irq(conf),
+			vendorbuf, devbuf));
+
+		m = amba_apb_get_membar(a_conf->apbslv, i);
+		addr = amba_iobar_start(a_conf->apbslv.apbmst[i], m);
+		DBGPRT((PRE " +%2i: 0x%x (raw:0x%x) \n", 0, addr, m));
+
+		i++;
+
+	}
+}
+
+void amba_print_all_config(void)
+{
+	int index = 0;
+	struct amba_confarea_type *area;
+
+	area = &amba_conf[0];
+
+	while (area != NULL) {
+		DBGPRT((PRE "--- AMBA bus %d ---\n", index));
+		amba_print_config(area);
+		area = area->next;
+		index++;
+	}
+	DBGPRT((PRE "--- End of AMBA PnP ---\n"));
+}
+
+static struct property *amba_property_create(char *n, int len, void *p)
+{
+
+	struct property *head;
+	head +	    (struct property *)prom_early_alloc(sizeof(struct property) + 32);
+	head->name = (char *)(head + 1);
+	strcpy(head->name, n);
+	head->length = len;
+	head->unique_id = prom_unique_id++;
+	head->value = prom_early_alloc(len + 1);
+	memcpy(head->value, p, len);
+	((unsigned char *)head->value)[head->length] = '\0';
+	head->next = (void *) 0;
+	return head;
+}
+
+/*
+ *  Used to scan system bus. Probes for AHB masters, AHB slaves and
+ *  APB slaves. Addresses to configuration areas of the AHB masters,
+ *  AHB slaves, APB slaves and APB master are stored in
+ *  amba_ahb_masters, amba_ahb_slaves and amba.
+ */
+
+static void amba_scan(struct device_node *dp, struct device_node ***nextp,
+	       struct amba_confarea_type *a_conf, unsigned int ioarea)
+{
+	unsigned int *cfg_area;	/* address to configuration area */
+	unsigned int mbar, conf, custom;
+	int i, j, idx = 0;
+	unsigned int apbmst;
+	static int allocate_child = 1;
+	struct device_node **next = &dp->child;
+
+	memset(a_conf, 0, sizeof(amba_conf));
+
+	cfg_area = (unsigned int *)(ioarea | LEON3_CONF_AREA);
+
+	for (i = 0; i < LEON3_AHB_MASTERS; i++) {
+		amba_insert_device(&a_conf->ahbmst, cfg_area);
+		cfg_area += LEON3_AHB_CONF_WORDS;
+	}
+
+	cfg_area +	    (unsigned int *)(ioarea | LEON3_CONF_AREA |
+			     LEON3_AHB_SLAVE_CONF_AREA);
+	for (i = 0; i < LEON3_AHB_SLAVES; i++) {
+		amba_insert_device(&a_conf->ahbslv, cfg_area);
+		cfg_area += LEON3_AHB_CONF_WORDS;
+	}
+
+	for (i = 0; i < a_conf->ahbslv.devnr; i++) {
+		conf = amba_get_confword(a_conf->ahbslv, i, 0);
+		mbar = amba_ahb_get_membar(a_conf->ahbslv, i, 0);
+		if ((amba_vendor(conf) = VENDOR_GAISLER) &&
+		    (amba_device(conf) = GAISLER_AHB2AHB)) {
+
+			struct device_node *bridge = dp;
+
+			/* Found AHB->AHB bus bridge custom config 1 contains ioarea. */
+			custom = amba_ahb_get_custom(a_conf->ahbslv, i, 1);
+
+			/*
+			 * We only create one 'child bus' to each bus. More
+			 * complex systems will need to adapt this code.
+			 */
+			if (allocate_child && amba_bus_cnt < MAX_AMBA_BUS_CNT) {
+				a_conf->next = &amba_conf[amba_bus_cnt++];
+				amba_scan(bridge, nextp, a_conf->next, custom);
+			}
+
+		} else if ((amba_vendor(conf) = VENDOR_GAISLER)
+			   && (amba_device(conf) = GAISLER_APBMST)) {
+
+			int k;
+			apbmst = amba_membar_start(mbar);
+			cfg_area = (unsigned int *)(apbmst | LEON3_CONF_AREA);
+
+			for (j = a_conf->apbslv.devnr, k = 0;
+			     j < AMBA_MAXAPB_DEVS
+			     && k < AMBA_MAXAPB_DEVS_PERBUS; j++, k++) {
+
+				unsigned int vendor, device;
+				unsigned int apb_conf +				    LEON3_BYPASS_LOAD_PA(cfg_area);
+				unsigned int iobar +				    LEON3_BYPASS_LOAD_PA(cfg_area + 1);
+				vendor = amba_vendor(apb_conf);
+				device = amba_device(apb_conf);
+
+				if (vendor && device) {
+
+					unsigned int intr;
+					struct amba_prom_registers regs;
+					struct device_node *node;
+					struct property *head;
+
+					node = prom_early_alloc(sizeof(*dp));
+					node->unique_id = prom_unique_id++;
+					node->parent = dp;
+					node->node = node->unique_id;
+					node->name +					    device_id2str(amba_vendor(apb_conf),
+							  amba_device
+							  (apb_conf));
+
+					intr = amba_irq(apb_conf);
+					regs.phys_addr +					    amba_iobar_start(apbmst, iobar);
+					regs.reg_size +					    ((((iobar) & 0xfff0) << 4) | 0xff) +
+					    1;
+
+					node->properties = head +					    amba_property_create("reg",
+								 sizeof(regs),
+								 &regs);
+					head = head->next +					    amba_property_create("interrupts",
+								 sizeof(intr),
+								 &intr);
+					head = head->next +					    amba_property_create("vendor",
+								 sizeof(int),
+								 &vendor);
+					head = head->next +					    amba_property_create("device",
+								 sizeof(int),
+								 &device);
+
+					*(*nextp) = node;
+					*nextp = &node->allnext;
+					*next = node;
+					next = &node->sibling;
+
+					node->path_component_name +					    build_path_component(node);
+					node->full_name = build_full_name(node);
+				}
+
+				amba_insert_apb_device(&a_conf->apbslv,
+						       cfg_area, apbmst, idx);
+				cfg_area += LEON3_APB_CONF_WORDS;
+			}
+			idx++;
+		}
+	}
+}
+
+/* Build PnP structure, find interrupt controller and timer */
+
+void _amba_init(struct device_node *dp, struct device_node ***nextp)
+{
+	int eirq;
+
+	if (amba_is_init)
+		return;
+
+	amba_is_init = 1;
+
+	DBGPRT((PRE "Reading AMBA Plug&Play configuration area\n"));
+
+	amba_bus_cnt = 1;
+
+	/* Probe for AHB masters, AHB slaves and APB slaves */
+	amba_scan(dp, nextp, &amba_conf[0], LEON3_IO_AREA);
+
+	/* Find LEON3 Interrupt controler */
+	leon3_irqctrl_regs = (struct leon3_irqctrl_regs_map *)
+		amba_find_apbslv_addr(VENDOR_GAISLER, GAISLER_IRQMP, (void *) 0);
+	leon3_gptimer_regs = (struct leon3_gptimer_regs_map *)
+	    amba_find_apbslv_addr(VENDOR_GAISLER, GAISLER_GPTIMER,
+				  &leon3_gptimer_irq);
+	if (leon3_irqctrl_regs) {
+		LEON3_BYPASS_STORE_PA(&(leon3_irqctrl_regs->mask[0]), 0);
+		eirq +		    (LEON3_BYPASS_LOAD_PA(&leon3_irqctrl_regs->mpstatus) >> 16)
+		    & 0xf;
+		if (eirq != 0) {
+			/* Extended IRQ controller available */
+			sparc_leon_eirq_register(eirq);
+		}
+	}
+
+#ifdef DEBUG_CONFIG
+	amba_print_all_config();
+#endif
+}
+
+void amba_init(void)
+{
+	_amba_init((struct device_node *) 0, (struct device_node ***) 0);
+}
+
+unsigned long amba_find_apbslv_addr(unsigned long vendor, unsigned long device,
+				    unsigned long *irq)
+{
+	unsigned int i, conf, iobar;
+	struct amba_confarea_type *a_conf = &amba_conf[0];
+
+	if (!amba_is_init)
+		return 0;
+
+	while (a_conf != NULL) {
+		for (i = 0; i < a_conf->apbslv.devnr; i++) {
+			conf = amba_get_confword(a_conf->apbslv, i, 0);
+			if ((amba_vendor(conf) = vendor)
+			    && (amba_device(conf) = device)) {
+				if (irq)
+					*irq = amba_irq(conf);
+				iobar = amba_apb_get_membar(a_conf->apbslv, i);
+				return amba_iobar_start(a_conf->apbslv.
+							apbmst[i], iobar);
+			}
+		}
+		a_conf = a_conf->next;
+	}
+	return 0;
+}
+
diff --git a/drivers/ambapp/ambapp.h b/drivers/ambapp/ambapp.h
new file mode 100644
index 0000000..a0f3103
--- /dev/null
+++ b/drivers/ambapp/ambapp.h
@@ -0,0 +1,246 @@
+/*
+ * Copyright (C) 2009 Daniel Hellstrom (daniel@gaisler.com), Konrad Eisele (konrad@gaisler.com) Aeroflex Gaisler AB
+ */
+
+#ifndef DRIVERS_AMBAPP_AMBA_H
+#define DRIVERS_AMBAPP_AMBA_H
+
+#include <asm/leon_amba.h>
+
+/* European Space Agency device id's */
+#define ESA_LEON2        0x2
+#define ESA_MCTRL        0xF
+#define ESA_PCIARB       0x10
+
+/* Opencores device id's */
+#define OPENCORES_PCIBR  0x4
+#define OPENCORES_ETHMAC 0x5
+
+/* maximum number of amba busses */
+#define MAX_AMBA_BUS_CNT 4
+
+#define AMBA_TYPE_APBIO 0x1
+#define AMBA_TYPE_MEM   0x2
+#define AMBA_TYPE_AHBIO 0x3
+
+#define AMBA_TYPE_AHBIO_ADDR(addr) (LEON3_IO_AREA | ((addr) >> 12))
+
+#ifndef __ASSEMBLY__
+
+extern struct amba_confarea_type amba_conf[MAX_AMBA_BUS_CNT];
+extern void console_print_leon(const char *p);
+extern unsigned int prom_unique_id;
+extern void *prom_early_alloc(unsigned long size);
+extern char *build_path_component(struct device_node *dp);
+extern char *build_full_name(struct device_node *dp);
+
+extern inline char *gaisler_device_str(int id)
+{
+	switch (id) {
+	case GAISLER_LEON3:
+		return "GAISLER_LEON3";
+	case GAISLER_LEON3DSU:
+		return "GAISLER_LEON3DSU";
+	case GAISLER_LEON4:
+		return "GAISLER_LEON4";
+	case GAISLER_LEON4DSU:
+		return "GAISLER_LEON4DSU";
+	case GAISLER_ETHAHB:
+		return "GAISLER_ETHAHB";
+	case GAISLER_ETHMAC:
+		return "GAISLER_ETHMAC";
+	case GAISLER_APBMST:
+		return "GAISLER_APBMST";
+	case GAISLER_AHBUART:
+		return "GAISLER_AHBUART";
+	case GAISLER_SRCTRL:
+		return "GAISLER_SRCTRL";
+	case GAISLER_SDCTRL:
+		return "GAISLER_SDCTRL";
+	case GAISLER_APBUART:
+		return "GAISLER_APBUART";
+	case GAISLER_IRQMP:
+		return "GAISLER_IRQMP";
+	case GAISLER_AHBRAM:
+		return "GAISLER_AHBRAM";
+	case GAISLER_GPTIMER:
+		return "GAISLER_GPTIMER";
+	case GAISLER_PCITRG:
+		return "GAISLER_PCITRG";
+	case GAISLER_PCISBRG:
+		return "GAISLER_PCISBRG";
+	case GAISLER_PCIFBRG:
+		return "GAISLER_PCIFBRG";
+	case GAISLER_PCITRACE:
+		return "GAISLER_PCITRACE";
+	case GAISLER_PCIDMA:
+		return "GAISLER_PCIDMA";
+	case GAISLER_AHBTRACE:
+		return "GAISLER_AHBTRACE";
+	case GAISLER_ETHDSU:
+		return "GAISLER_ETHDSU";
+	case GAISLER_PIOPORT:
+		return "GAISLER_PIOPORT";
+	case GAISLER_AHBJTAG:
+		return "GAISLER_AHBJTAG";
+	case GAISLER_USBDC:
+		return "GAISLER_USBDC";
+	case GAISLER_ATACTRL:
+		return "GAISLER_ATACTRL";
+	case GAISLER_DDRSPA:
+		return "GAISLER_DDRSPA";
+	case GAISLER_USBEHC:
+		return "GAISLER_USBEHC";
+	case GAISLER_USBUHC:
+		return "GAISLER_USBUHC";
+	case GAISLER_I2CMST:
+		return "GAISLER_I2CMST";
+	case GAISLER_SPICTRL:
+		return "GAISLER_SPICTRL";
+	case GAISLER_VGA:
+		return "GAISLER_VGA";
+	case GAISLER_SVGA:
+		return "GAISLER_SVGA";
+	case GAISLER_GRSYSMON:
+		return "GAISLER_GRSYSMON";
+	case GAISLER_GRACECTRL:
+		return "GAISLER_GRACECTRL";
+	case GAISLER_KBD:
+		return "GAISLER_KBD";
+	case GAISLER_DDR2SPA:
+		return "GAISLER_DDR2SPA";
+	case GAISLER_SPIMCTRL:
+		return "GAISLER_SPIMCTRL";
+	case GAISLER_AHBSTAT:
+		return "GAISLER_AHBSTAT";
+	case GAISLER_AHB2AHB:
+		return "GAISLER_AHB2AHB";
+
+	case GAISLER_L2TIME:
+		return "GAISLER_L2TIME";
+	case GAISLER_L2C:
+		return "GAISLER_L2C";
+	case GAISLER_PLUGPLAY:
+		return "GAISLER_PLUGPLAY";
+
+	default:
+		break;
+	}
+	return (char *) 0;
+}
+
+extern inline char *esa_device_str(int id)
+{
+	switch (id) {
+	case ESA_LEON2:
+		return "ESA_LEON2";
+	case ESA_MCTRL:
+		return "ESA_MCTRL";
+	case ESA_PCIARB:
+		return "ESA_PCIARB";
+	default:
+		break;
+	}
+	return (char *) 0;
+}
+
+extern inline char *opencores_device_str(int id)
+{
+	switch (id) {
+	case OPENCORES_PCIBR:
+		return "OPENCORES_PCIBR";
+	case OPENCORES_ETHMAC:
+		return "OPENCORES_ETHMAC";
+	default:
+		break;
+	}
+	return (char *) 0;
+}
+
+extern inline char *device_id2str(int vendor, int id)
+{
+	switch (vendor) {
+	case VENDOR_GAISLER:
+		return gaisler_device_str(id);
+	case VENDOR_ESA:
+		return esa_device_str(id);
+	case VENDOR_OPENCORES:
+		return opencores_device_str(id);
+	case VENDOR_PENDER:
+	default:
+		break;
+	}
+	return (char *) 0;
+}
+
+extern inline char *vendor_id2str(int vendor)
+{
+	switch (vendor) {
+	case VENDOR_GAISLER:
+		return "VENDOR_GAISLER";
+	case VENDOR_ESA:
+		return "VENDOR_ESA";
+	case VENDOR_OPENCORES:
+		return "VENDOR_OPENCORES";
+	case VENDOR_PENDER:
+		return "VENDOR_PENDER";
+	default:
+		break;
+	}
+	return (char *) 0;
+}
+
+#define amba_get_confword(tab, index, word) (LEON3_BYPASS_LOAD_PA((tab).addr[(index)] + (word)))
+#define amba_ahb_get_membar(tab, index, nr) (LEON3_BYPASS_LOAD_PA((tab).addr[(index)] + 4 + (nr)))
+#define amba_ahb_get_custom(tab, index, nr) (LEON3_BYPASS_LOAD_PA((tab).addr[(index)] + 1 + (nr)))
+#define amba_apb_get_membar(tab, index)     (LEON3_BYPASS_LOAD_PA((tab).addr[(index)] + 1))
+
+#define amba_membar_start(mbar)       (((mbar) & 0xfff00000) & (((mbar) & 0xfff0) << 16))
+#define amba_iobar_start(base, iobar) ((base) | ((((iobar) & 0xfff00000) >> 12) & (((iobar) & 0xfff0) << 4)))
+#define amba_vendor(x)                (((x) >> 24) & 0xff)
+#define amba_device(x)                (((x) >> 12) & 0xfff)
+#define amba_irq(conf)                ((conf) & 0x1f)
+#define amba_membar_type(mbar)        ((mbar) & 0xf)
+
+extern unsigned long amba_find_apbslv_addr(unsigned long vendor,
+					   unsigned long device,
+					   unsigned long *irq);
+extern int amba_get_free_apbslv_devices(int vendor, int device,
+					struct amba_apb_device *dev, int nr);
+
+extern int amba_is_init;
+extern int amba_bus_cnt;
+
+void vendor_dev_string(unsigned long conf, char *vendorbuf, char *devbuf);
+void amba_print_config(struct amba_confarea_type *a_conf);
+void amba_print_all_config(void);
+void amba_init(void);
+int amba_get_number_apbslv_devices(int vendor, int device);
+int amba_find_next_apbslv_devices(int vendor, int device, struct amba_apb_device *dev, int nr);
+void amba_free_apbslv_device(struct amba_apb_device *dev);
+int amba_get_number_ahbslv_devices(int vendor, int device);
+int amba_get_free_ahbslv_devices(int vendor, int device, struct amba_ahb_device *dev, int nr);
+void amba_free_ahbslv_device(struct amba_ahb_device *dev);
+
+#define amba_insert_device(tab, address)				\
+	do {								\
+		if (LEON3_BYPASS_LOAD_PA(address)) {			\
+				(tab)->addr[(tab)->devnr] = (address);	\
+				(tab)->devnr++;				\
+			}						\
+	} while (0)
+
+#define amba_insert_apb_device(tab, address, apbmst, idx)		\
+	do {								\
+		if (LEON3_BYPASS_LOAD_PA(address)) {			\
+				(tab)->addr[(tab)->devnr] = (address);	\
+				(tab)->apbmst[(tab)->devnr] = (apbmst);	\
+				(tab)->apbmstidx[(tab)->devnr] = (idx);	\
+				(tab)->devnr++;				\
+			}						\
+	} while (0)
+
+
+#endif /*!__ASSEMBLY__ */
+
+#endif
diff --git a/drivers/ambapp/ambapp_driver.c b/drivers/ambapp/ambapp_driver.c
new file mode 100644
index 0000000..e7ed398
--- /dev/null
+++ b/drivers/ambapp/ambapp_driver.c
@@ -0,0 +1,219 @@
+/*
+ *  Amba plug and play device lookup and allocation
+ *  Copyright (C) 2008 Daniel Hellstrom <daniel@gaisler.com> Aeroflex Gaisler AB
+ *  Copyright (C) 2009 Konrad Eisele <konrad@gaisler.com> Aeroflex Gaisler AB
+ */
+
+#include <linux/ptrace.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/module.h>
+
+#include <asm/leon.h>
+#include <asm/leon_amba.h>
+#include "ambapp.h"
+
+/*#define DEBUG_CONFIG*/
+#ifdef DEBUG_CONFIG
+#define DBGPRT(p) printk p
+#else
+#define DBGPRT(p)
+#endif
+
+/* get number of apb slaves */
+int amba_get_number_apbslv_devices(int vendor, int device)
+{
+	int i, j = 0, conf;
+	struct amba_confarea_type *a_conf = &amba_conf[0];
+
+	while (a_conf != NULL) {
+		for (i = 0; i < a_conf->apbslv.devnr; i++) {
+			conf = amba_get_confword(a_conf->apbslv, i, 0);
+			if ((amba_vendor(conf) = vendor)
+			    && (amba_device(conf) = device))
+				j++;
+		}
+		a_conf = a_conf->next;
+	}
+	return j;
+}
+EXPORT_SYMBOL(amba_get_number_apbslv_devices);
+
+/* collect next free apb slaves */
+int amba_find_next_apbslv_devices(int vendor, int device,
+				  struct amba_apb_device *dev, int nr)
+{
+	unsigned int i, conf, iobar, j = 0;
+	struct amba_confarea_type *a_conf = &amba_conf[0];
+
+	DBGPRT(("Apbslv: search for apdslv devices v:0x%x d:0x%x\n", vendor,
+		device));
+
+	while (a_conf != NULL) {
+		for (i = 0; i < a_conf->apbslv.devnr; i++) {
+			conf = amba_get_confword(a_conf->apbslv, i, 0);
+			DBGPRT(("Apbslv: check(%x:%x)=(%x:%x)\n", vendor,
+				device, amba_vendor(conf), amba_device(conf)));
+			if ((amba_vendor(conf) = vendor)
+			    && (amba_device(conf) = device)) {
+				if (j = nr) {
+					dev[0].irq = amba_irq(conf);
+					iobar +					    amba_apb_get_membar(a_conf->apbslv,
+								i);
+					DBGPRT(("Apbslv: found device idx %i cfgidx:%d(%x:%x) iobar 0x%08x at addr:0x%08x\n",
+						j, i, vendor, device, iobar, (a_conf->apbslv).addr[(i)] + 1));
+
+					dev[0].start +					    amba_iobar_start(a_conf->apbslv.
+							     apbmst[i], iobar);
+					DBGPRT((" +bar: 0x%x base:0x%x iobar:0x%x\n",
+						dev[0].start, a_conf->apbslv.apbmst[i],
+						((((iobar) & 0xfff00000) >> 12) & (((iobar) & 0xfff0) << 4))));
+					dev[0].bus = a_conf;
+
+					return 1;
+				}
+				j++;
+			}
+		}
+		a_conf = a_conf->next;
+	}
+	return 0;
+}
+
+/* collect apb slaves */
+int amba_get_free_apbslv_devices(int vendor, int device,
+				 struct amba_apb_device *dev, int nr)
+{
+	unsigned int i, conf, iobar, j = 0;
+	struct amba_confarea_type *a_conf = &amba_conf[0];
+
+	DBGPRT(("Apbslv: search for apbslv devices\n"));
+
+	while (a_conf != NULL) {
+		for (i = 0; i < a_conf->apbslv.devnr && j < nr; i++) {
+			conf = amba_get_confword(a_conf->apbslv, i, 0);
+			DBGPRT(("Apbslv: check(%x:%x)=(%x:%x)\n", vendor,
+				device, amba_vendor(conf), amba_device(conf)));
+			if ((amba_vendor(conf) = vendor)
+			    && (amba_device(conf) = device)) {
+				if (!
+				    (a_conf->apbslv.
+				     allocbits[i /
+					       32] & (1 << (i & (32 - 1))))) {
+					DBGPRT(("Apbslv: alloc device idx %i (%x:%x)\n", j, vendor, device));
+					a_conf->apbslv.allocbits[i / 32] |+					    (1 << (i & (32 - 1)));
+					dev[j].irq = amba_irq(conf);
+					iobar +					    amba_apb_get_membar(a_conf->apbslv,
+								i);
+					dev[j].start +					    amba_iobar_start(a_conf->apbslv.
+							     apbmst[i], iobar);
+					dev[j].bus_id = i;
+					DBGPRT((" +bar: 0x%x \n",
+						dev[j].start));
+					dev[j].bus = a_conf;
+
+					j++;
+				}
+			}
+		}
+		a_conf = a_conf->next;
+	}
+	return j;
+}
+EXPORT_SYMBOL(amba_get_free_apbslv_devices);
+
+void amba_free_apbslv_device(struct amba_apb_device *dev)
+{
+
+	dev->bus->apbslv.allocbits[dev->bus_id / 32] &+	    ~(1 << (dev->bus_id & (32 - 1)));
+}
+EXPORT_SYMBOL(amba_free_apbslv_device);
+
+/* get number of ahb slaves */
+int amba_get_number_ahbslv_devices(int vendor, int device)
+{
+
+	int i, j = 0, conf;
+	struct amba_confarea_type *a_conf = &amba_conf[0];
+
+	while (a_conf != NULL) {
+		for (i = 0; i < a_conf->ahbslv.devnr; i++) {
+			conf = amba_get_confword(a_conf->ahbslv, i, 0);
+			if ((amba_vendor(conf) = vendor)
+			    && (amba_device(conf) = device))
+				j++;
+		}
+		a_conf = a_conf->next;
+	}
+	return j;
+}
+EXPORT_SYMBOL(amba_get_number_ahbslv_devices);
+
+/* collect ahb slaves */
+int amba_get_free_ahbslv_devices(int vendor, int device,
+				 struct amba_ahb_device *dev, int nr)
+{
+	unsigned int addr, i, conf, iobar, j = 0, k;
+	struct amba_confarea_type *a_conf = &amba_conf[0];
+
+	DBGPRT(("Ahbslv: search for ahbslv devices\n"));
+
+	while (a_conf != NULL) {
+		for (i = 0; i < a_conf->ahbslv.devnr && j < nr; i++) {
+			conf = amba_get_confword(a_conf->ahbslv, i, 0);
+			DBGPRT(("Ahbslv: check(%x:%x)=(%x:%x)\n", vendor,
+				device, amba_vendor(conf), amba_device(conf)));
+			if ((amba_vendor(conf) = vendor)
+			    && (amba_device(conf) = device)) {
+				if (!
+				    (a_conf->ahbslv.
+				     allocbits[i /
+					       32] & (1 << (i & (32 - 1))))) {
+					DBGPRT(("Ahbslv: alloc device idx %i (%x:%x)\n", j, vendor, device));
+					a_conf->ahbslv.allocbits[i / 32] |+					    (1 << (i & (32 - 1)));
+					dev[j].irq = amba_irq(conf);
+					dev[j].bus_id = i;
+					dev[j].bus = a_conf;
+					for (k = 0; k < 4; k++) {
+						iobar +						    amba_ahb_get_membar(a_conf->
+									ahbslv,
+									i, k);
+						addr = amba_membar_start(iobar);
+						if (amba_membar_type(iobar) =
+						    AMBA_TYPE_AHBIO) {
+							addr +							    AMBA_TYPE_AHBIO_ADDR
+							    (addr);
+						}
+						dev[j].start[k] = addr;
+						DBGPRT((" +%i: 0x%x \n", k,
+							dev[j].start[k]));
+					}
+					j++;
+				}
+			}
+		}
+		a_conf = a_conf->next;
+	}
+	return j;
+}
+EXPORT_SYMBOL(amba_get_free_ahbslv_devices);
+
+void amba_free_ahbslv_device(struct amba_ahb_device *dev)
+{
+
+	dev->bus->ahbslv.allocbits[dev->bus_id / 32] &+	    ~(1 << (dev->bus_id & (32 - 1)));
+
+}
+EXPORT_SYMBOL(amba_free_ahbslv_device);
+
diff --git a/drivers/ambapp/gaisler/Kconfig b/drivers/ambapp/gaisler/Kconfig
new file mode 100644
index 0000000..d76f979
--- /dev/null
+++ b/drivers/ambapp/gaisler/Kconfig
@@ -0,0 +1,20 @@
+
+menu "Vendor Gaisler"
+
+config GRLIB_GAISLER_APBUART
+	bool "Grlib apbuart driver"
+	depends on SPARC_LEON
+	default y
+	---help---
+	  Add the driver for the grlib apbuart serial core.
+
+config GRLIB_GAISLER_APBUART_CONSOLE
+	bool "Grlib apbuart serial console"
+	default y
+	depends on GRLIB_GAISLER_APBUART
+	select SERIAL_CORE_CONSOLE
+	help
+	  Running a console on grlib uart
+
+endmenu
+
diff --git a/drivers/ambapp/gaisler/Makefile b/drivers/ambapp/gaisler/Makefile
new file mode 100644
index 0000000..12e06e2
--- /dev/null
+++ b/drivers/ambapp/gaisler/Makefile
@@ -0,0 +1,3 @@
+
+obj-$(CONFIG_GRLIB_GAISLER_APBUART)		+= apbuart/
+
diff --git a/drivers/ambapp/gaisler/apbuart/Makefile b/drivers/ambapp/gaisler/apbuart/Makefile
new file mode 100644
index 0000000..eb30a50
--- /dev/null
+++ b/drivers/ambapp/gaisler/apbuart/Makefile
@@ -0,0 +1,3 @@
+
+obj-y		+= apbuart.o
+
diff --git a/drivers/ambapp/gaisler/apbuart/apbuart.c b/drivers/ambapp/gaisler/apbuart/apbuart.c
new file mode 100644
index 0000000..13c9ab8
--- /dev/null
+++ b/drivers/ambapp/gaisler/apbuart/apbuart.c
@@ -0,0 +1,837 @@
+/*
+ *  Driver for Leon serial ports
+ *
+ *  Based on linux/drivers/serial/amba.c
+ *
+ *  Copyright (C) 2000 Deep Blue Solutions Ltd.
+ *  Copyright (C) 2003 Konrad Eisele <eiselekd@web.de>
+ *  Copyright (C) 2006 Daniel Hellstrom <daniel@gaisler.com> Aeroflex Gaisler AB
+ *  Copyright (C) 2008 Gilead Kutnick <kutnickg@zin-tech.com>
+ */
+
+#if defined(CONFIG_GRLIB_GAISLER_APBUART_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
+#define SUPPORT_SYSRQ
+#endif
+
+#include <linux/module.h>
+#include <linux/tty.h>
+#include <linux/ioport.h>
+#include <linux/init.h>
+#include <linux/serial.h>
+#include <linux/console.h>
+#include <linux/sysrq.h>
+#include <linux/kthread.h>
+#include <linux/device.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+
+#include <asm/irq.h>
+#include <asm/oplib.h>
+
+#include <linux/serial_core.h>
+#include <asm/leon.h>
+#include <asm/leon_amba.h>
+#include "../../ambapp.h"
+
+#define UART_NR		8
+static int leon_ports_nr;
+static int leon_line_nr;
+static int _apbuart_init_bases_done;
+
+#define SERIAL_LEON_MAJOR	TTY_MAJOR
+#define SERIAL_LEON_MINOR	64
+#define SERIAL_LEON_NR		UART_NR
+#define AMBA_ISR_PASS_LIMIT	256
+#define UART_DUMMY_RSR_RX	0x8000	/* for ignore all read */
+
+#define APBBASE(port)		((struct leon3_apbuart_regs_map *)((port)->membase))
+
+#define APBBASE_DATA_P(port)	(&(APBBASE(port)->data))
+#define APBBASE_STATUS_P(port)	(&(APBBASE(port)->status))
+#define APBBASE_CTRL_P(port)	(&(APBBASE(port)->ctrl))
+#define APBBASE_SCALAR_P(port)	(&(APBBASE(port)->scaler))
+
+#define UART_GET_CHAR(port)	(LEON_BYPASS_LOAD_PA(APBBASE_DATA_P(port)))
+#define UART_PUT_CHAR(port, v)	(LEON_BYPASS_STORE_PA(APBBASE_DATA_P(port), v))
+#define UART_GET_STATUS(port)	(LEON_BYPASS_LOAD_PA(APBBASE_STATUS_P(port)))
+#define UART_PUT_STATUS(port, v)(LEON_BYPASS_STORE_PA(APBBASE_STATUS_P(port), v))
+#define UART_GET_CTRL(port)	(LEON_BYPASS_LOAD_PA(APBBASE_CTRL_P(port)))
+#define UART_PUT_CTRL(port, v)	(LEON_BYPASS_STORE_PA(APBBASE_CTRL_P(port), v))
+#define UART_GET_SCAL(port)	(LEON_BYPASS_LOAD_PA(APBBASE_SCALAR_P(port)))
+#define UART_PUT_SCAL(port, v)	(LEON_BYPASS_STORE_PA(APBBASE_SCALAR_P(port), v))
+#define UART_RX_DATA(s)		(((s) & LEON_REG_UART_STATUS_DR) != 0)
+#define UART_TX_READY(s)	(((s) & LEON_REG_UART_STATUS_THE) != 0)
+
+static void leonuart_tx_chars(struct uart_port *port);
+
+/* We wrap our port structure around the generic uart_port */
+struct uart_leon_port {
+	struct uart_port port;
+	unsigned int old_status;
+};
+
+static void leonuart_stop_tx(struct uart_port *port)
+{
+	unsigned int cr;
+
+	cr = UART_GET_CTRL(port);
+	cr &= ~LEON_REG_UART_CTRL_TI;
+	UART_PUT_CTRL(port, cr);
+}
+
+static void leonuart_start_tx(struct uart_port *port)
+{
+	unsigned int cr;
+
+	cr = UART_GET_CTRL(port);
+	cr |= LEON_REG_UART_CTRL_TI;
+	UART_PUT_CTRL(port, cr);
+
+	if (UART_GET_STATUS(port) & LEON_REG_UART_STATUS_THE)
+		leonuart_tx_chars(port);
+}
+
+static void leonuart_stop_rx(struct uart_port *port)
+{
+	unsigned int cr;
+
+	cr = UART_GET_CTRL(port);
+	cr &= ~(LEON_REG_UART_CTRL_RI);
+	UART_PUT_CTRL(port, cr);
+}
+
+static void leonuart_enable_ms(struct uart_port *port)
+{
+	/* no modem status for leon */
+}
+
+static void leonuart_rx_chars(struct uart_port *port)
+{
+	struct tty_struct *tty = port->info->port.tty;
+	unsigned int status, ch, rsr, flag;
+	unsigned int max_chars = port->fifosize;
+
+	status = UART_GET_STATUS(port);
+
+	while (UART_RX_DATA(status) && (max_chars--)) {
+
+		ch = UART_GET_CHAR(port);
+		flag = TTY_NORMAL;
+
+		port->icount.rx++;
+
+		/*
+		 * Note that the error handling code is
+		 * out of the main execution path
+		 */
+		rsr = UART_GET_STATUS(port) | UART_DUMMY_RSR_RX;
+		UART_PUT_STATUS(port, 0);
+		if (rsr & LEON_REG_UART_STATUS_ERR) {
+
+			if (rsr & LEON_REG_UART_STATUS_BR) {
+				rsr &+				    ~(LEON_REG_UART_STATUS_FE |
+				      LEON_REG_UART_STATUS_PE);
+				port->icount.brk++;
+				if (uart_handle_break(port))
+					goto ignore_char;
+			} else if (rsr & LEON_REG_UART_STATUS_PE) {
+				port->icount.parity++;
+			} else if (rsr & LEON_REG_UART_STATUS_FE) {
+				port->icount.frame++;
+			}
+			if (rsr & LEON_REG_UART_STATUS_OE)
+				port->icount.overrun++;
+
+			rsr &= port->read_status_mask;
+
+			if (rsr & LEON_REG_UART_STATUS_PE)
+				flag = TTY_PARITY;
+			else if (rsr & LEON_REG_UART_STATUS_FE)
+				flag = TTY_FRAME;
+		}
+
+		if (uart_handle_sysrq_char(port, ch))
+			goto ignore_char;
+
+		if ((rsr & port->ignore_status_mask) = 0)
+			tty_insert_flip_char(tty, ch, flag);
+
+		if (rsr & LEON_REG_UART_STATUS_OE) {
+
+			/*
+			 * Overrun is special, since it's reported
+			 * immediately, and doesn't affect the current
+			 * character
+			 */
+			tty_insert_flip_char(tty, 0, TTY_OVERRUN);
+		}
+ignore_char:
+		status = UART_GET_STATUS(port);
+	}
+
+	tty_flip_buffer_push(tty);
+
+}
+
+static void leonuart_tx_chars(struct uart_port *port)
+{
+	struct circ_buf *xmit = &port->info->xmit;
+	int count;
+
+	if (port->x_char) {
+		UART_PUT_CHAR(port, port->x_char);
+		port->icount.tx++;
+		port->x_char = 0;
+		return;
+	}
+
+	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
+		leonuart_stop_tx(port);
+		return;
+	}
+
+	/* amba: fill FIFO */
+	count = port->fifosize >> 1;
+	do {
+		UART_PUT_CHAR(port, xmit->buf[xmit->tail]);
+		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
+		port->icount.tx++;
+		if (uart_circ_empty(xmit))
+			break;
+	} while (--count > 0);
+
+	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+		uart_write_wakeup(port);
+
+	if (uart_circ_empty(xmit))
+		leonuart_stop_tx(port);
+}
+
+static irqreturn_t leonuart_int(int irq, void *dev_id)
+{
+	struct uart_port *port = dev_id;
+	unsigned int status;
+
+	spin_lock(&port->lock);
+
+	status = UART_GET_STATUS(port);
+	if (status & LEON_REG_UART_STATUS_DR)
+		leonuart_rx_chars(port);
+	if (status & LEON_REG_UART_STATUS_THE)
+		leonuart_tx_chars(port);
+
+	spin_unlock(&port->lock);
+
+	return IRQ_HANDLED;
+}
+
+static unsigned int leonuart_tx_empty(struct uart_port *port)
+{
+	return UART_GET_STATUS(port) & LEON_REG_UART_STATUS_THE ? TIOCSER_TEMT :
+	    0;
+}
+
+static unsigned int leonuart_get_mctrl(struct uart_port *port)
+{
+	unsigned int result = 0;
+
+	/* no modem status for leon */
+
+	return result;
+}
+
+static void leonuart_set_mctrl(struct uart_port *port, unsigned int mctrl)
+{
+	/* no modem status for leon */
+}
+
+static void leonuart_break_ctl(struct uart_port *port, int break_state)
+{
+	/* no break for leon */
+}
+
+static int leonuart_startup(struct uart_port *port)
+{
+	struct uart_leon_port *uap = (struct uart_leon_port *)port;
+	int retval;
+	unsigned int cr;
+
+	/* Allocate the IRQ */
+	retval = request_irq(port->irq, leonuart_int, 0, "leon", port);
+	if (retval)
+		return retval;
+
+	/* initialise the old status of the modem signals */
+	uap->old_status = 0;
+
+	/* Finally, enable interrupts */
+	cr = UART_GET_CTRL(port);
+	UART_PUT_CTRL(port,
+		      cr | LEON_REG_UART_CTRL_RE | LEON_REG_UART_CTRL_TE |
+		      LEON_REG_UART_CTRL_RI | LEON_REG_UART_CTRL_TI);
+
+	return 0;
+}
+
+static void leonuart_shutdown(struct uart_port *port)
+{
+	unsigned int cr;
+
+	/* disable all interrupts, disable the port */
+	cr = UART_GET_CTRL(port);
+	UART_PUT_CTRL(port,
+		      cr & ~(LEON_REG_UART_CTRL_RE | LEON_REG_UART_CTRL_TE |
+			     LEON_REG_UART_CTRL_RI | LEON_REG_UART_CTRL_TI));
+
+	/* Free the interrupt */
+	free_irq(port->irq, port);
+}
+
+static void leonuart_set_termios(struct uart_port *port,
+				 struct ktermios *termios, struct ktermios *old)
+{
+	unsigned int cr;
+	unsigned long flags;
+	unsigned int baud, quot;
+
+	/* Ask the core to calculate the divisor for us. */
+	baud = uart_get_baud_rate(port, termios, old, 0, port->uartclk / 16);
+	if (baud = 0)
+		panic("invalid baudrate %i\n", port->uartclk / 16);
+
+	/*uart_get_divisor calc a *16 uart freq, leon is *8 */
+	quot = (uart_get_divisor(port, baud)) * 2;
+	cr = UART_GET_CTRL(port);
+	cr &= ~(LEON_REG_UART_CTRL_PE | LEON_REG_UART_CTRL_PS);
+
+	if (termios->c_cflag & PARENB) {
+		cr |= LEON_REG_UART_CTRL_PE;
+		if ((termios->c_cflag & PARODD))
+			cr |= LEON_REG_UART_CTRL_PS;
+	}
+
+	/* Enable flow control. */
+	if (termios->c_cflag & CRTSCTS)
+		cr |= LEON_REG_UART_CTRL_FL;
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	/* Update the per-port timeout. */
+	uart_update_timeout(port, termios->c_cflag, baud);
+
+	port->read_status_mask = LEON_REG_UART_STATUS_OE;
+	if (termios->c_iflag & INPCK)
+		port->read_status_mask |+		    LEON_REG_UART_STATUS_FE | LEON_REG_UART_STATUS_PE;
+
+	/* Characters to ignore */
+	port->ignore_status_mask = 0;
+	if (termios->c_iflag & IGNPAR)
+		port->ignore_status_mask |+		    LEON_REG_UART_STATUS_FE | LEON_REG_UART_STATUS_PE;
+
+	/* Ignore all characters if CREAD is not set. */
+	if ((termios->c_cflag & CREAD) = 0)
+		port->ignore_status_mask |= UART_DUMMY_RSR_RX;
+
+	/* Set baud rate */
+	quot -= 1;
+	UART_PUT_SCAL(port, quot);
+	UART_PUT_CTRL(port, cr);
+
+	spin_unlock_irqrestore(&port->lock, flags);
+}
+
+static const char *leonuart_type(struct uart_port *port)
+{
+	return port->type = PORT_LEON ? "Leon" : NULL;
+}
+
+static void leonuart_release_port(struct uart_port *port)
+{
+}
+
+static int leonuart_request_port(struct uart_port *port)
+{
+	return 0;
+}
+
+/* Configure/autoconfigure the port. */
+static void leonuart_config_port(struct uart_port *port, int flags)
+{
+	if (flags & UART_CONFIG_TYPE) {
+		port->type = PORT_LEON;
+		leonuart_request_port(port);
+	}
+}
+
+/* verify the new serial_struct (for TIOCSSERIAL). */
+static int leonuart_verify_port(struct uart_port *port,
+				struct serial_struct *ser)
+{
+	int ret = 0;
+	if (ser->type != PORT_UNKNOWN && ser->type != PORT_LEON)
+		ret = -EINVAL;
+	if (ser->irq < 0 || ser->irq >= NR_IRQS)
+		ret = -EINVAL;
+	if (ser->baud_base < 9600)
+		ret = -EINVAL;
+	return ret;
+}
+
+static struct uart_ops leon_pops = {
+	.tx_empty = leonuart_tx_empty,
+	.set_mctrl = leonuart_set_mctrl,
+	.get_mctrl = leonuart_get_mctrl,
+	.stop_tx = leonuart_stop_tx,
+	.start_tx = leonuart_start_tx,
+	.stop_rx = leonuart_stop_rx,
+	.enable_ms = leonuart_enable_ms,
+	.break_ctl = leonuart_break_ctl,
+	.startup = leonuart_startup,
+	.shutdown = leonuart_shutdown,
+	.set_termios = leonuart_set_termios,
+	.type = leonuart_type,
+	.release_port = leonuart_release_port,
+	.request_port = leonuart_request_port,
+	.config_port = leonuart_config_port,
+	.verify_port = leonuart_verify_port,
+};
+
+static struct uart_leon_port leon_ports[UART_NR];
+
+static int apbuart_scan_fifo_size(struct uart_port *port, int portnumber)
+{
+	int ctrl, loop = 0;
+	int status;
+	int fifosize;
+	unsigned long flags;
+
+	ctrl = UART_GET_CTRL(port);
+
+	printk(KERN_INFO "Testing fifo size for UART port %i: ", portnumber);
+
+	/*
+	 * Enable the transceiver and wait for it to be ready to send data.
+	 * Clear interrupts so that this process will not be externally
+	 * interrupted in the middle (which can cause the transceiver to
+	 * drain prematurely).
+	 */
+
+	local_irq_save(flags);
+
+	UART_PUT_CTRL(port, ctrl | LEON_REG_UART_CTRL_TE);
+
+	while (!UART_TX_READY(UART_GET_STATUS(port))) {
+		loop++;
+	};
+
+	/*
+	 * Disable the transceiver so data isn't actually sent during the
+	 * actual test.
+	 */
+
+	UART_PUT_CTRL(port, ctrl & ~(LEON_REG_UART_CTRL_TE));
+
+	fifosize = 1;
+	UART_PUT_CHAR(port, 0);
+
+	/*
+	 * So long as transmitting a character increments the tranceivier FIFO
+	 * length the FIFO must be at least that big. These bytes will automatically
+	 * drain off of the FIFO.
+	 */
+
+	status = UART_GET_STATUS(port);
+	while (((status >> 20) & 0x3F) = fifosize) {
+		fifosize++;
+		UART_PUT_CHAR(port, 0);
+		status = UART_GET_STATUS(port);
+	}
+
+	fifosize--;
+
+	UART_PUT_CTRL(port, ctrl);
+	local_irq_restore(flags);
+
+	printk("got %i bytes.\n", fifosize);
+
+	if (fifosize = 0)
+		fifosize = 1;
+
+	return fifosize;
+}
+
+static void apbuart_flush_fifo(struct uart_port *port)
+{
+	int i;
+
+	for (i = 0; i < port->fifosize; i++)
+		UART_GET_CHAR(port);
+}
+
+/* rs_init inits the driver */
+static void __init _apbuart_init_bases(void)
+{
+	int i;
+	struct amba_apb_device dev[8];
+	if (!_apbuart_init_bases_done) {
+		unsigned long clk +		    ((unsigned
+		      long)(((LEON3_BYPASS_LOAD_PA
+			      (&leon3_gptimer_regs->scalar_reload)) + 1)));
+		printk(KERN_INFO
+		       "Attaching grlib apbuart serial drivers (clk:%ihz):\n",
+		       (int)clk);
+		leon_ports_nr +		    amba_get_free_apbslv_devices(VENDOR_GAISLER,
+						 GAISLER_APBUART, dev, 8);
+
+		for (i = 0; i < leon_ports_nr; i++) {
+			leon_ports[i].port.membase = (void *)dev[i].start;
+			leon_ports[i].port.mapbase = dev[i].start;
+			leon_ports[i].port.irq = dev[i].irq;
+			leon_ports[i].port.iotype = SERIAL_IO_MEM;
+			leon_ports[i].port.uartclk = clk * 1000 * 1000;
+			leon_ports[i].port.fifosize = 1;
+			leon_ports[i].port.ops = &leon_pops;
+			leon_ports[i].port.flags = ASYNC_BOOT_AUTOCONF;
+			leon_ports[i].port.line = i;
+		}
+		_apbuart_init_bases_done = 1;
+	}
+}
+
+#ifdef CONFIG_GRLIB_GAISLER_APBUART_CONSOLE
+
+static void
+leonuart_console_write(struct console *co, const char *s, unsigned int count)
+{
+	struct uart_port *port = &leon_ports[co->index].port;
+	unsigned int status, old_cr;
+	int i;
+
+	/* First save the CR then disable the interrupts */
+	old_cr = UART_GET_CTRL(port);
+	UART_PUT_CTRL(port,
+		      (old_cr &
+		       ~(LEON_REG_UART_CTRL_RI | LEON_REG_UART_CTRL_TI)) |
+		      (LEON_REG_UART_CTRL_RE | LEON_REG_UART_CTRL_TE));
+
+	/*      Now, do each character */
+	for (i = 0; i < count; i++) {
+		do {
+			status = UART_GET_STATUS(port);
+		} while (!UART_TX_READY(status));
+		UART_PUT_CHAR(port, s[i]);
+		if (s[i] = '\n') {
+			do {
+				status = UART_GET_STATUS(port);
+			} while (!UART_TX_READY(status));
+			UART_PUT_CHAR(port, '\r');
+		}
+	}
+
+	/*
+	 *      Finally, wait for transmitter to become empty
+	 *      and restore the TCR
+	 */
+	do {
+		status = UART_GET_STATUS(port);
+	} while (!UART_TX_READY(status));
+	UART_PUT_CTRL(port, old_cr);
+}
+
+static void __init
+leonuart_console_get_options(struct uart_port *port, int *baud,
+			     int *parity, int *bits)
+{
+	if (UART_GET_CTRL(port) &
+	    (LEON_REG_UART_CTRL_RE | LEON_REG_UART_CTRL_TE)) {
+
+		unsigned int quot, status;
+		status = UART_GET_STATUS(port);
+
+		*parity = 'n';
+		if (status & LEON_REG_UART_CTRL_PE) {
+			if ((status & LEON_REG_UART_CTRL_PS) = 0)
+				*parity = 'e';
+			else
+				*parity = 'o';
+		}
+
+		*bits = 8;
+		quot = UART_GET_SCAL(port) / 8;
+		*baud = port->uartclk / (16 * (quot + 1));
+	}
+}
+
+static int __init leonuart_console_setup(struct console *co, char *options)
+{
+	struct uart_port *port;
+	int baud = 38400;
+	int bits = 8;
+	int parity = 'n';
+	int flow = 'n';
+
+	/*
+	 * Check whether an invalid uart number has been specified, and
+	 * if so, search for the first available port that does have
+	 * console support.
+	 */
+	if (co->index >= leon_ports_nr)
+		co->index = 0;
+	port = &leon_ports[co->index].port;
+
+	if (options)
+		uart_parse_options(options, &baud, &parity, &bits, &flow);
+	else
+		leonuart_console_get_options(port, &baud, &parity, &bits);
+
+	return uart_set_options(port, co, baud, parity, bits, flow);
+}
+
+static struct uart_driver leon_reg;
+static struct console leon_console = {
+	.name = "ttyS",
+	.write = leonuart_console_write,
+	.device = uart_console_device,
+	.setup = leonuart_console_setup,
+	.flags = CON_PRINTBUFFER,
+	.index = -1,
+	.data = &leon_reg,
+};
+
+static int __init leonuart_console_init(void)
+{
+	_apbuart_init_bases();
+	register_console(&leon_console);
+	return 0;
+}
+
+console_initcall(leonuart_console_init);
+
+#define LEON_CONSOLE	&leon_console
+#else
+#define LEON_CONSOLE	NULL
+#endif
+
+static struct uart_driver leon_reg = {
+	.owner = THIS_MODULE,
+	.driver_name = "serial",
+	.dev_name = "ttyS",
+	.major = SERIAL_LEON_MAJOR,
+	.minor = SERIAL_LEON_MINOR,
+	.nr = UART_NR,
+	.cons = LEON_CONSOLE,
+};
+
+/* ===== of driver ===== */
+
+static int __devinit apbuart_probe(struct of_device *op,
+				   const struct of_device_id *match)
+{
+	struct console co;
+	int node;
+	int freq_khz;
+	int baud_rates[UART_NR];
+	unsigned long clk;
+	int v = 0, d = 0;
+	unsigned int addr;
+	struct device_node *dp = op->node;
+	struct uart_leon_port *port;
+	struct amba_prom_registers *regs;
+	int irq, line;
+	int *vendor = (int *)of_get_property(dp, "vendor", NULL);
+	int *device = (int *)of_get_property(dp, "device", NULL);
+	int *irqs = (int *)of_get_property(dp, "interrupts", NULL);
+	regs = (struct amba_prom_registers *)of_get_property(dp, "reg", NULL);
+	if (vendor)
+		v = *vendor;
+	if (device)
+		d = *device;
+
+	if (leon3_gptimer_regs = 0 || irqs = 0 || regs = 0
+	    || !(v = VENDOR_GAISLER && d = GAISLER_APBUART)) {
+		return -ENODEV;
+	}
+	addr = regs->phys_addr;
+	irq = *irqs;
+
+	port = kzalloc(sizeof(struct uart_leon_port), GFP_KERNEL);
+	if (unlikely(!port))
+		return -ENOMEM;
+
+	node = prom_getchild(prom_root_node);
+	freq_khz = prom_getint(node, "clock-frequency");
+	clk +	    ((unsigned
+	      long)(((LEON3_BYPASS_LOAD_PA(&leon3_gptimer_regs->scalar_reload))
+		     + 1)));
+
+	port->port.membase = (void *)addr;
+	port->port.mapbase = addr;
+	port->port.irq = irq;
+	port->port.iotype = SERIAL_IO_MEM;
+	port->port.uartclk = clk * 1000 * 1000;
+	port->port.fifosize = 1;
+	port->port.ops = &leon_pops;
+	port->port.flags = (upf_t) ASYNC_BOOT_AUTOCONF;
+	port->port.line = line = leon_line_nr++;
+
+	port->port.uartclk = freq_khz * 1000;
+	uart_add_one_port(&leon_reg, (struct uart_port *)port);
+	uart_set_options((struct uart_port *)port, &co,
+			 line >= UART_NR ? 9600 : baud_rates[line], 'n', 8,
+			 'n');
+	port->port.fifosize +	    apbuart_scan_fifo_size((struct uart_port *)port, line);
+	apbuart_flush_fifo((struct uart_port *)port);
+
+	printk(KERN_INFO "of: Match %d: 0x%x@%d : %s\n", line, addr, irq,
+	       dp->path_component_name);
+	return 0;
+}
+
+static struct of_device_id __initdata apbuart_match[] = {
+	{
+	 .name = "GAISLER_APBUART",
+	 },
+	{},
+};
+
+static struct of_platform_driver apbuart_driver = {
+	.match_table = apbuart_match,
+	.probe = apbuart_probe,
+	.driver = {
+		   .name = "ambapp-apbuart",
+		   },
+};
+
+/* ===== of driver end ===== */
+
+static int __init gaisler_apbuart_init(void)
+{
+	int ret;
+	int i;
+	int node;
+	int freq_khz;
+	int baud_rates[UART_NR];
+
+	_apbuart_init_bases();
+	node = prom_getchild(prom_root_node);
+	freq_khz = prom_getint(node, "clock-frequency");
+
+	printk(KERN_INFO "grlib apbuart: %i serial driver(s) at [",
+	       leon_ports_nr);
+	for (i = 0; i < UART_NR; i++)
+		baud_rates[i] = 9600;
+
+	for (i = 0; i < leon_ports_nr; i++) {
+		baud_rates[i] = prom_getintdefault(node, "uart1_baud", 9600);
+		if (i != 0)
+			printk(",");
+		printk("0x%x", (unsigned int)leon_ports[i].port.mapbase);
+		printk("(irq %i)", leon_ports[i].port.irq);
+	}
+	printk("]\n");
+
+	baud_rates[0] = prom_getintdefault(node, "uart1_baud", 9600);
+	baud_rates[1] = prom_getintdefault(node, "uart2_baud", 9600);
+
+	printk(KERN_INFO
+	       "grlib apbuart: system frequency: %i khz, baud rates: %i %i\n",
+	       freq_khz, baud_rates[0], baud_rates[1]);
+
+	ret = uart_register_driver(&leon_reg);
+	leon_reg.tty_driver->init_termios.c_cflag +	    (leon_reg.tty_driver->init_termios.c_cflag & ~CBAUD) | B38400;
+
+	if (ret)
+		return ret;
+
+	/*
+	 * Set the FIFO size after the baud rates are set so it'll be done at an
+	 * appropriate rate. Also flush the FIFOs just in case they have lingering
+	 * data.
+	 */
+
+	of_register_driver(&apbuart_driver, &of_platform_bus_type);
+
+	return ret;
+}
+
+static void __exit gaisler_apbuart_exit(void)
+{
+	int i;
+
+	for (i = 0; i < leon_ports_nr; i++)
+		uart_remove_one_port(&leon_reg, &leon_ports[i].port);
+
+	uart_unregister_driver(&leon_reg);
+
+}
+
+static void leon3_rs_put_char_base(struct leon3_apbuart_regs_map *uart_regs, char ch)
+{
+	unsigned long flags;
+	int loops;
+
+	local_irq_save(flags);
+	loops = 0;
+	while (!(LEON3_BYPASS_LOAD_PA(&(uart_regs->status)) &
+		 LEON_REG_UART_STATUS_THE) && (loops < 100000))
+		loops++;
+
+	LEON3_BYPASS_STORE_PA(&(uart_regs->data), ch);
+
+	loops = 0;
+	while (!(LEON3_BYPASS_LOAD_PA(&(uart_regs->status)) &
+		 LEON_REG_UART_STATUS_TSE) && (loops < 100000))
+		loops++;
+	local_irq_restore(flags);
+}
+
+void leon3_rs_put_char(char ch)
+{
+	struct leon3_apbuart_regs_map *b = (struct leon3_apbuart_regs_map *)
+	    amba_find_apbslv_addr(VENDOR_GAISLER,
+				  GAISLER_APBUART,
+				  (void *) 0);
+	if (b)
+		leon3_rs_put_char_base(b, ch);
+}
+
+void console_print_leon(const char *p)
+{
+	char c;
+	struct leon3_apbuart_regs_map *b;
+
+	if (!amba_is_init)
+		return;
+	b = (struct leon3_apbuart_regs_map *)
+	    amba_find_apbslv_addr(VENDOR_GAISLER, GAISLER_APBUART, 0);
+	if (b) {
+		while ((c = *(p++)) != 0) {
+			if (c = '\n')
+				leon3_rs_put_char_base(b, '\r');
+			leon3_rs_put_char_base(b, c);
+		}
+	}
+
+	/* Comment this if you want to have a strict interrupt-driven output */
+	/* rs_fair_output(); */
+
+	return;
+}
+
+module_init(gaisler_apbuart_init);
+module_exit(gaisler_apbuart_exit);
+
+MODULE_AUTHOR("Konrad Eisele<eiselekd@web.de>, based on AMBA serial");
+MODULE_DESCRIPTION("grlib apbuart serial driver");
+MODULE_VERSION("2.0");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 23d2fb0..62d4ca0 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -174,6 +174,9 @@
 /* Qualcomm MSM SoCs */
 #define PORT_MSM	88
 
+/* SPARC leon */
+#define PORT_LEON	89
+
 #ifdef __KERNEL__
 
 #include <linux/compiler.h>
-- 
1.6.3.2


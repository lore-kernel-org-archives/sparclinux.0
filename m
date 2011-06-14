From: "corentin.labbe" <corentin.labbe@geomatys.fr>
Date: Tue, 14 Jun 2011 12:59:41 +0000
Subject: [PATCH][RFC] add SPARC support to i2c-ali1535
Message-Id: <4DF75B3D.9090206@geomatys.fr>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------080106040708030103070506"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------080106040708030103070506
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello

This patch enable i2c-ali1535 to works under SPARC architecture.

I wait for your comments/approval before sending it to the lm_sensors mailing lists.

Thanks in advance
Bests regards,

LABBE Corentin

--------------080106040708030103070506
Content-Type: text/x-patch;
 name="i2c-ali1535-sparc_support.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="i2c-ali1535-sparc_support.patch"

--- /root/linux-2.6.38/drivers/i2c/busses/i2c-ali1535.c	2011-03-15 02:20:32.000000000 +0100
+++ drivers/i2c/busses/i2c-ali1535.c	2011-06-10 15:08:49.000000000 +0200
@@ -132,7 +132,60 @@
 #define	ALI1535_SMBIO_EN	0x04	/* SMB I/O Space enable		*/
 
 static struct pci_driver ali1535_driver;
+#ifdef CONFIG_SPARC
+static unsigned long ali1535_smba;
+#else
 static unsigned short ali1535_smba;
+#endif
+
+#ifdef CONFIG_SPARC
+static unsigned long ali1535_get_ioport_base_addr(struct pci_dev *dev)
+{
+	struct device_node *of_node, *of_parent_node;
+	const struct linux_prom_pci_ranges *pbm_ranges;
+	int i, type;
+	u32 parent_phys_hi, parent_phys_lo;
+	unsigned long a = 0;
+	const struct linux_prom_pci_ranges *pr;
+	int num_pbm_ranges;
+
+	/* I do the same thing that pci_determine_mem_io_space()
+	 * in arch/sparc/kernel/pci_common.c
+	 * I get the parent pci bus as an of_node and get ioport base address*/
+	of_node = pci_device_to_OF_node(dev);
+	if (of_node == NULL) {
+		dev_err(&dev->dev, "ALI1535_smb cant get OF_node from pci_device\n");
+		return 0;
+	}
+	of_parent_node = of_get_parent(of_node);
+	if (of_parent_node == NULL) {
+		dev_err(&dev->dev, "ALI1535_smb cant get parent pcibus from OF\n");
+		return 0;
+	}
+	pbm_ranges = of_get_property(of_parent_node, "ranges", &i);
+	if (!pbm_ranges) {
+		dev_err(&dev->dev, "ALI1535_smb cant get ranges from OF\n");
+		return 0;
+	}
+	num_pbm_ranges = i / sizeof(*pbm_ranges);
+	for (i = 0; i < num_pbm_ranges; i++) {
+		pr = &pbm_ranges[i];
+		type = (pr->child_phys_hi >> 24) & 0x3;
+		if (type == 1) {
+			parent_phys_hi = pr->parent_phys_hi;
+			parent_phys_lo = pr->parent_phys_lo;
+			if (tlb_type == hypervisor)
+				parent_phys_hi &= 0x0fffffff;
+			a = (((unsigned long)parent_phys_hi << 32UL) |
+				((unsigned long)parent_phys_lo << 0UL));
+			dev_info(&dev->dev, "ALI1535_smb found IOstart at 0x%lx\n", a);
+		}
+	}
+	if (a == 0)
+		dev_err(&dev->dev, "ALI1535_smb error iobase is 0\n");
+	return a;
+}
+#endif
 
 /* Detect whether a ALI1535 can be found, and initialize it, where necessary.
    Note the differences between kernels with the old PCI BIOS interface and
@@ -142,6 +195,7 @@
 {
 	int retval = -ENODEV;
 	unsigned char temp;
+	unsigned short offset;
 
 	/* Check the following things:
 		- SMB I/O address is initialized
@@ -150,13 +204,21 @@
 	*/
 
 	/* Determine the address of the SMBus area */
-	pci_read_config_word(dev, SMBBA, &ali1535_smba);
-	ali1535_smba &= (0xffff & ~(ALI1535_SMB_IOSIZE - 1));
-	if (ali1535_smba == 0) {
+	pci_read_config_word(dev, SMBBA, &offset);
+	dev_info(&dev->dev, "ALI1535_smb is at offset 0x%04x", offset);
+	offset &= (0xffff & ~(ALI1535_SMB_IOSIZE - 1));
+	if (offset == 0) {
 		dev_warn(&dev->dev,
 			"ALI1535_smb region uninitialized - upgrade BIOS?\n");
 		goto exit;
 	}
+	ali1535_smba = 0;
+#ifdef CONFIG_SPARC
+	ali1535_smba = ali1535_get_ioport_base_addr(dev);
+	if (ali1535_smba == 0)
+		return -ENODEV;
+#endif
+	ali1535_smba += offset;
 
 	retval = acpi_check_region(ali1535_smba, ALI1535_SMB_IOSIZE,
 				   ali1535_driver.name);
@@ -165,8 +227,13 @@
 
 	if (!request_region(ali1535_smba, ALI1535_SMB_IOSIZE,
 			    ali1535_driver.name)) {
+#ifdef CONFIG_SPARC
+		dev_err(&dev->dev, "ALI1535_smb region 0x%lx already in use!\n",
+			ali1535_smba);
+#else
 		dev_err(&dev->dev, "ALI1535_smb region 0x%x already in use!\n",
 			ali1535_smba);
+#endif
 		goto exit;
 	}
 
@@ -196,7 +263,6 @@
 	*/
 	pci_read_config_byte(dev, SMBREV, &temp);
 	dev_dbg(&dev->dev, "SMBREV = 0x%X\n", temp);
-	dev_dbg(&dev->dev, "ALI1535_smba = 0x%X\n", ali1535_smba);
 
 	retval = 0;
 exit:
@@ -498,8 +564,13 @@
 	/* set up the sysfs linkage to our parent device */
 	ali1535_adapter.dev.parent = &dev->dev;
 
+#ifdef CONFIG_SPARC
+	snprintf(ali1535_adapter.name, sizeof(ali1535_adapter.name),
+		"SMBus ALI1535 adapter at %lx", ali1535_smba);
+#else
 	snprintf(ali1535_adapter.name, sizeof(ali1535_adapter.name),
 		"SMBus ALI1535 adapter at %04x", ali1535_smba);
+#endif
 	return i2c_add_adapter(&ali1535_adapter);
 }
 

--------------080106040708030103070506--

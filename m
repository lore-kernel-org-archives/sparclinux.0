From: "corentin.labbe" <corentin.labbe@geomatys.fr>
Date: Wed, 15 Jun 2011 16:13:15 +0000
Subject: [PATCH v2][RFC] i2c-ali1535: enable SPARC support
Message-Id: <4DF8DA1B.3020509@geomatys.fr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello

I have discovered pci_resource_start that largely simplify my patch.
And I am very sorry for the non-respect of Documentation/SubmittingPatches for my precedent mails.

Thanks in advance
Bests regards,

Signed-off-by: LABBE Corentin <corentin.labbe@geomatys.fr>
---
--- linux/drivers/i2c/busses/i2c-ali1535.c.orig	2011-06-15 18:02:56.000000000 +0200
+++ linux/drivers/i2c/busses/i2c-ali1535.c	2011-06-15 18:05:26.000000000 +0200
@@ -132,7 +132,7 @@
 #define	ALI1535_SMBIO_EN	0x04	/* SMB I/O Space enable		*/

 static struct pci_driver ali1535_driver;
-static unsigned short ali1535_smba;
+static unsigned long ali1535_smba;

 /* Detect whether a ALI1535 can be found, and initialize it, where necessary.
    Note the differences between kernels with the old PCI BIOS interface and
@@ -142,6 +142,7 @@ static int __devinit ali1535_setup(struc
 {
 	int retval = -ENODEV;
 	unsigned char temp;
+	unsigned short offset;

 	/* Check the following things:
 		- SMB I/O address is initialized
@@ -149,15 +150,27 @@ static int __devinit ali1535_setup(struc
 		- We can use the addresses
 	*/

+	if (pci_enable_device(dev)) {
+		dev_err(&dev->dev, "ALI1535_smb cant enable device");
+		goto exit;
+	}
+
 	/* Determine the address of the SMBus area */
-	pci_read_config_word(dev, SMBBA, &ali1535_smba);
-	ali1535_smba &= (0xffff & ~(ALI1535_SMB_IOSIZE - 1));
-	if (ali1535_smba = 0) {
+	pci_read_config_word(dev, SMBBA, &offset);
+	dev_dbg(&dev->dev, "ALI1535_smb is at offset 0x%04x", offset);
+	offset &= (0xffff & ~(ALI1535_SMB_IOSIZE - 1));
+	if (offset = 0) {
 		dev_warn(&dev->dev,
 			"ALI1535_smb region uninitialized - upgrade BIOS?\n");
 		goto exit;
 	}

+	ali1535_smba = pci_resource_start(dev, 0) + offset;
+	if ((pci_resource_flags(dev, 0) & IORESOURCE_IO) = 0) {
+		dev_err(&dev->dev, "ALI1535_smb bar 0 is not IORESOURCE_IO");
+		goto exit;
+	}
+
 	retval = acpi_check_region(ali1535_smba, ALI1535_SMB_IOSIZE,
 				   ali1535_driver.name);
 	if (retval)
@@ -165,7 +178,7 @@ static int __devinit ali1535_setup(struc

 	if (!request_region(ali1535_smba, ALI1535_SMB_IOSIZE,
 			    ali1535_driver.name)) {
-		dev_err(&dev->dev, "ALI1535_smb region 0x%x already in use!\n",
+		dev_err(&dev->dev, "ALI1535_smb region 0x%lx already in use!\n",
 			ali1535_smba);
 		goto exit;
 	}
@@ -196,7 +209,7 @@ static int __devinit ali1535_setup(struc
 	*/
 	pci_read_config_byte(dev, SMBREV, &temp);
 	dev_dbg(&dev->dev, "SMBREV = 0x%X\n", temp);
-	dev_dbg(&dev->dev, "ALI1535_smba = 0x%X\n", ali1535_smba);
+	dev_dbg(&dev->dev, "ALI1535_smba = 0x%0lx\n", ali1535_smba);

 	retval = 0;
 exit:
@@ -499,7 +512,7 @@ static int __devinit ali1535_probe(struc
 	ali1535_adapter.dev.parent = &dev->dev;

 	snprintf(ali1535_adapter.name, sizeof(ali1535_adapter.name),
-		"SMBus ALI1535 adapter at %04x", ali1535_smba);
+		"SMBus ALI1535 adapter at %0lx", ali1535_smba);
 	return i2c_add_adapter(&ali1535_adapter);
 }


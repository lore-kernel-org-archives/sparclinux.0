From: "corentin.labbe" <corentin.labbe@geomatys.fr>
Date: Mon, 06 Jun 2011 08:01:31 +0000
Subject: patch for i2c_ali1535 working on SPARC
Message-Id: <4DEC895B.30101@geomatys.fr>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------000600040902040708020600"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------000600040902040708020600
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello

I have a sun blade 100 and I want to get the sensors working with
lm_sensors, but in current state, it doesn't work.

After some research, i have found that all smbus driver and the i2c_ali1535 particularly cant work.
It assumes that ioport address are 16bits wide (address stored with an unsigned short).
But on SPARC arch, ioports are mapped in memory and so are stored with an unsigned long.

So I write a patch for i2c_ali1535 for supporting SPARC architecture.
With this patch, the driver i2c_ali1535 loads and works successfully.
# sensors
adm1023-i2c-0-18
Adapter: SMBus ALI1535 adapter at 0x1fe02000620
temp1:       +31.0 C  (low  = -55.0 C, high = +127.0 C)
temp2:       +61.6 C  (low  = -55.0 C, high = +127.0 C)

But this patch is bad because the base address for ioport is hard-coded (0x1fe02000000).
I have tried to understand how works all SPARC drivers but I cant find how to get that.

Perhaps i can get some usefull infos with all of_* functions but i dont know what exaclty means infos printed by prtconf (assigned-addresses and reg specifically).
        Node 0xf0083f44
            .node:  f0083f44
            assigned-addresses:  81001810.00000000.00000000.00000000.00000010
            name: 'pmu'
            ranges:  00000000.00000000.00001800.00000000.00000000.00000100.00000001.00000000.81001810.00000000.00000600.00000100.00000002.00000000.81001814.00000000.00000000.00000100
            reg:  00001800.00000000.00000000.00000000.00000000.81001810.00000000.00000600.00000000.00000010
            compatible:  70636931.3062392c.37313031.2e300070.63693130.62392c37.31303100.70636963.6c617373.2c303030.30303000.70636963.6c617373.2c303030.3000
            #address-cells:  00000002
            #size-cells:  00000001
            devsel-speed:  00000001
            class-code:  00000000
            latency-timer:  00000000
            cache-line-size:  00000000
            max-latency:  00000000
            min-grant:  00000000
            revision-id:  00000000
            device-id:  00007101
            vendor-id:  000010b9

            Node 0xf00849c4
                .node:  f00849c4
                reg:  00000000.00000000.00000100.00000001.00000000.00000100
                #address-cells:  00000002
                #size-cells:  00000000
                interrupts:  00000001
                compatible: 'i2c-smbus'
                name: 'i2c'

                Node 0xf008505c
                    .node:  f008505c
                    compatible: 'i2c-max1617'
                    name: 'temperature'
                    reg:  00000000.00000030


Best regards

--------------000600040902040708020600
Content-Type: text/x-patch;
 name="i2c-ali1535-sparc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="i2c-ali1535-sparc.patch"

--- drivers/i2c/busses/i2c-ali1535.c.old	2011-03-15 02:20:32.000000000 +0100
+++ drivers/i2c/busses/i2c-ali1535.c	2011-06-06 09:49:29.000000000 +0200
@@ -132,7 +132,11 @@
 #define	ALI1535_SMBIO_EN	0x04	/* SMB I/O Space enable		*/
 
 static struct pci_driver ali1535_driver;
+#ifdef CONFIG_SPARC
+static unsigned long ali1535_smba;
+#else
 static unsigned short ali1535_smba;
+#endif
 
 /* Detect whether a ALI1535 can be found, and initialize it, where necessary.
    Note the differences between kernels with the old PCI BIOS interface and
@@ -142,6 +146,7 @@
 {
 	int retval = -ENODEV;
 	unsigned char temp;
+	unsigned short offset;
 
 	/* Check the following things:
 		- SMB I/O address is initialized
@@ -150,13 +155,19 @@
 	*/
 
 	/* Determine the address of the SMBus area */
-	pci_read_config_word(dev, SMBBA, &ali1535_smba);
-	ali1535_smba &= (0xffff & ~(ALI1535_SMB_IOSIZE - 1));
-	if (ali1535_smba == 0) {
+	pci_read_config_word(dev, SMBBA, &offset);
+	dev_info(&dev->dev, "ALI1535_smb is at offset %04x", offset);
+	offset &= (0xffff & ~(ALI1535_SMB_IOSIZE - 1));
+	if (offset == 0) {
 		dev_warn(&dev->dev,
 			"ALI1535_smb region uninitialized - upgrade BIOS?\n");
 		goto exit;
 	}
+	#ifdef CONFIG_SPARC
+	ali1535_smba = 0x1fe02000000 + offset;
+	#else
+	ali1535_smba = offset;
+	#endif
 
 	retval = acpi_check_region(ali1535_smba, ALI1535_SMB_IOSIZE,
 				   ali1535_driver.name);
@@ -165,8 +176,8 @@
 
 	if (!request_region(ali1535_smba, ALI1535_SMB_IOSIZE,
 			    ali1535_driver.name)) {
-		dev_err(&dev->dev, "ALI1535_smb region 0x%x already in use!\n",
-			ali1535_smba);
+		dev_err(&dev->dev, "ALI1535_smb region 0x%04x already in use!\n",
+			offset);
 		goto exit;
 	}
 
@@ -196,7 +207,7 @@
 	*/
 	pci_read_config_byte(dev, SMBREV, &temp);
 	dev_dbg(&dev->dev, "SMBREV = 0x%X\n", temp);
-	dev_dbg(&dev->dev, "ALI1535_smba = 0x%X\n", ali1535_smba);
+	dev_dbg(&dev->dev, "ALI1535_smba = 0x%04x\n", offset);
 
 	retval = 0;
 exit:
@@ -498,8 +509,13 @@
 	/* set up the sysfs linkage to our parent device */
 	ali1535_adapter.dev.parent = &dev->dev;
 
+	#ifdef CONFIG_SPARC
 	snprintf(ali1535_adapter.name, sizeof(ali1535_adapter.name),
-		"SMBus ALI1535 adapter at %04x", ali1535_smba);
+		"SMBus ALI1535 adapter at 0x%0lx", ali1535_smba);
+	#else
+	snprintf(ali1535_adapter.name, sizeof(ali1535_adapter.name),
+		"SMBus ALI1535 adapter at 0x%04x", ali1535_smba);
+	#endif
 	return i2c_add_adapter(&ali1535_adapter);
 }
 


--------------000600040902040708020600--

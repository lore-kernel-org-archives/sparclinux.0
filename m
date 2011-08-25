From: "corentin.labbe" <corentin.labbe@geomatys.fr>
Date: Thu, 25 Aug 2011 09:32:55 +0000
Subject: Re: [PATCH][RFC] add SPARC support to i2c-ali1535
Message-Id: <4E5616C7.1080708@geomatys.fr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Le 06/07/2011 17:04, David Miller a =E9crit :
> From: "corentin.labbe" <corentin.labbe@geomatys.fr>
> Date: Tue, 14 Jun 2011 14:59:41 +0200
>=20
>> This patch enable i2c-ali1535 to works under SPARC architecture.
>>
>> I wait for your comments/approval before sending it to the lm_sensors ma=
iling lists.
>=20
> Implementing this as a PCI driver doesn't make any sense.
>=20
> It's be better to probe and fetch the register information
> by using the openfirmware tree driver interfaces,
> a table of "struct of_device_id", a "platform_driver" that
> points to that of_device_id table, and a call to
> platform_device_register() to register that platform_driver.
>=20
> Also, even if you attach the I2C controller, you won't be
> able to enumerate the underlying I2C devices properly.
> The openfirmware device tree will need to be used in order
> to do that as well.

Hello

It seems that you respond to my first patch and I have sent a second
patch (much simpler and I resend it with this mail for simplicity).

I agree that this driver could be ported to a platform driver but for
the moment my simple goal is to make it work under SPARC.
In a second time, it could be transformed to a platform driver.

Sorry for this very late responce.

Best regards

Signed-off-by: LABBE Corentin <corentin.labbe@geomatys.fr>
---
--- linux/drivers/i2c/busses/i2c-ali1535.c.orig	2011-06-15
18:02:56.000000000 +0200
+++ linux/drivers/i2c/busses/i2c-ali1535.c	2011-06-15 18:05:26.000000000
+0200
@@ -132,7 +132,7 @@
 #define	ALI1535_SMBIO_EN	0x04	/* SMB I/O Space enable		*/

 static struct pci_driver ali1535_driver;
-static unsigned short ali1535_smba;
+static unsigned long ali1535_smba;

 /* Detect whether a ALI1535 can be found, and initialize it, where
necessary.
    Note the differences between kernels with the old PCI BIOS interface and
@@ -142,6 +142,7 @@ static int __devinit ali1535_setup(struc
 {
 	int retval =3D -ENODEV;
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
-	ali1535_smba &=3D (0xffff & ~(ALI1535_SMB_IOSIZE - 1));
-	if (ali1535_smba =3D 0) {
+	pci_read_config_word(dev, SMBBA, &offset);
+	dev_dbg(&dev->dev, "ALI1535_smb is at offset 0x%04x", offset);
+	offset &=3D (0xffff & ~(ALI1535_SMB_IOSIZE - 1));
+	if (offset =3D 0) {
 		dev_warn(&dev->dev,
 			"ALI1535_smb region uninitialized - upgrade BIOS?\n");
 		goto exit;
 	}

+	ali1535_smba =3D pci_resource_start(dev, 0) + offset;
+	if ((pci_resource_flags(dev, 0) & IORESOURCE_IO) =3D 0) {
+		dev_err(&dev->dev, "ALI1535_smb bar 0 is not IORESOURCE_IO");
+		goto exit;
+	}
+
 	retval =3D acpi_check_region(ali1535_smba, ALI1535_SMB_IOSIZE,
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
 	dev_dbg(&dev->dev, "SMBREV =3D 0x%X\n", temp);
-	dev_dbg(&dev->dev, "ALI1535_smba =3D 0x%X\n", ali1535_smba);
+	dev_dbg(&dev->dev, "ALI1535_smba =3D 0x%0lx\n", ali1535_smba);

 	retval =3D 0;
 exit:
@@ -499,7 +512,7 @@ static int __devinit ali1535_probe(struc
 	ali1535_adapter.dev.parent =3D &dev->dev;

 	snprintf(ali1535_adapter.name, sizeof(ali1535_adapter.name),
-		"SMBus ALI1535 adapter at %04x", ali1535_smba);
+		"SMBus ALI1535 adapter at %0lx", ali1535_smba);
 	return i2c_add_adapter(&ali1535_adapter);
 }



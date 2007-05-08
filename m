From: David Miller <davem@davemloft.net>
Date: Tue, 08 May 2007 09:04:04 +0000
Subject: Re: XVR-500 support in XVR-2500 driver?
Message-Id: <20070508.020404.41635366.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0705072317540.4832@math>
In-Reply-To: <Pine.SOC.4.64.0705072317540.4832@math>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Date: Tue, 8 May 2007 10:50:56 +0200 (MEST)

> 
> On May 7 2007 14:03, David Miller wrote:
> >
> >diff --git a/drivers/video/sunxvr2500.c b/drivers/video/sunxvr2500.c
> >index 4010492..4316c7f 100644
> >--- a/drivers/video/sunxvr2500.c
> >+++ b/drivers/video/sunxvr2500.c
> >@@ -237,14 +237,14 @@ static void __devexit s3d_pci_unregister(struct pci_dev *pdev)
> > }
> > 
> > static struct pci_device_id s3d_pci_table[] = {
> >-	{	/* XVR-2500 */
> >-		PCI_DEVICE(PCI_VENDOR_ID_3DLABS, 0x0032),
> >-		.driver_data = 1,
> >-	},
> >-	{	/* XVR-500 */
> >-		PCI_DEVICE(PCI_VENDOR_ID_3DLABS, 0x07a2),
> >-		.driver_data = 0,
> >-	},
> >+	{	PCI_DEVICE(PCI_VENDOR_ID_3DLABS, 0x002c),	},
> >+	{	PCI_DEVICE(PCI_VENDOR_ID_3DLABS, 0x002d),	},
> >+	{	PCI_DEVICE(PCI_VENDOR_ID_3DLABS, 0x002e),	},
> >+	{	PCI_DEVICE(PCI_VENDOR_ID_3DLABS, 0x002f),	},
> >+	{	PCI_DEVICE(PCI_VENDOR_ID_3DLABS, 0x0030),	},
> >+	{	PCI_DEVICE(PCI_VENDOR_ID_3DLABS, 0x0031),	},
> >+	{	PCI_DEVICE(PCI_VENDOR_ID_3DLABS, 0x0032),	},
> >+	{	PCI_DEVICE(PCI_VENDOR_ID_3DLABS, 0x0033),	},
> 
> The extra comma inside the { } is not needed, is it?

No, but if later I want to fill in more fields per entry I will indeed
need that comma there.

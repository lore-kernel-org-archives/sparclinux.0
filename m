From: David Miller <davem@davemloft.net>
Date: Mon, 07 May 2007 21:03:27 +0000
Subject: Re: XVR-500 support in XVR-2500 driver?
Message-Id: <20070507.140327.35467006.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0705072317540.4832@math>
In-Reply-To: <Pine.SOC.4.64.0705072317540.4832@math>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Mon, 07 May 2007 13:54:51 -0700 (PDT)

> From: Meelis Roos <mroos@linux.ee>
> Date: Mon, 7 May 2007 23:21:44 +0300 (EEST)
> 
> > The newly merged XVR-500 and XVR-2500 drivers both seem to have
> > PCI_DEVICE(PCI_VENDOR_ID_3DLABS, 0x7a2) (XVR-500) support in pci device 
> > table. Is this correct?
> > 
> > Just curiously reading new drivers,
> 
> Thanks for catching this.
> 
> Originally I handled both chips in one driver, then I split
> them up, that's why it was there.  I'll fix that up :)

Here is that fix I will push to Linus, thanks again.

commit de9f0cf93fcbccc2de4e6bcb5ef90f997616be3b
Author: David S. Miller <davem@sunset.davemloft.net>
Date:   Mon May 7 14:02:51 2007 -0700

    [VIDEO] sunxvr2500: Fix PCI device ID table.
    
    Noticed by Meelis Roos.
    
    Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/drivers/video/sunxvr2500.c b/drivers/video/sunxvr2500.c
index 4010492..4316c7f 100644
--- a/drivers/video/sunxvr2500.c
+++ b/drivers/video/sunxvr2500.c
@@ -237,14 +237,14 @@ static void __devexit s3d_pci_unregister(struct pci_dev *pdev)
 }
 
 static struct pci_device_id s3d_pci_table[] = {
-	{	/* XVR-2500 */
-		PCI_DEVICE(PCI_VENDOR_ID_3DLABS, 0x0032),
-		.driver_data = 1,
-	},
-	{	/* XVR-500 */
-		PCI_DEVICE(PCI_VENDOR_ID_3DLABS, 0x07a2),
-		.driver_data = 0,
-	},
+	{	PCI_DEVICE(PCI_VENDOR_ID_3DLABS, 0x002c),	},
+	{	PCI_DEVICE(PCI_VENDOR_ID_3DLABS, 0x002d),	},
+	{	PCI_DEVICE(PCI_VENDOR_ID_3DLABS, 0x002e),	},
+	{	PCI_DEVICE(PCI_VENDOR_ID_3DLABS, 0x002f),	},
+	{	PCI_DEVICE(PCI_VENDOR_ID_3DLABS, 0x0030),	},
+	{	PCI_DEVICE(PCI_VENDOR_ID_3DLABS, 0x0031),	},
+	{	PCI_DEVICE(PCI_VENDOR_ID_3DLABS, 0x0032),	},
+	{	PCI_DEVICE(PCI_VENDOR_ID_3DLABS, 0x0033),	},
 	{ 0, }
 };
 

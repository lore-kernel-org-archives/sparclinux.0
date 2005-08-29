From: Jiri Slaby <jirislaby@gmail.com>
Date: Mon, 29 Aug 2005 22:27:42 +0000
Subject: [PATCH 7/7] arch: pci_find_device remove (sparc64/kernel/ebus.c)
Message-Id: <200508292227.j7TMRgNY020033@wscnet.wsc.cz>
List-Id: <sparclinux.vger.kernel.org>
In-Reply-To: <200508292220.j7TMKbNC019793@wscnet.wsc.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <gregkh@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pci@atrey.karlin.mff.cuni.cz, davem@davemloft.net, ecd@brainaid.de, jj@sunsite.ms.mff.cuni.cz, anton@samba.org, sparclinux@vger.kernel.org, ultralinux@vger.kernel.org

Generated in 2.6.13-rc6-mm2 kernel version.

Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>

 ebus.c |   17 ++++++-----------
 1 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/arch/sparc64/kernel/ebus.c b/arch/sparc64/kernel/ebus.c
--- a/arch/sparc64/kernel/ebus.c
+++ b/arch/sparc64/kernel/ebus.c
@@ -527,19 +527,13 @@ static struct pci_dev *find_next_ebus(st
 {
 	struct pci_dev *pdev = start;
 
-	do {
-		pdev = pci_find_device(PCI_VENDOR_ID_SUN, PCI_ANY_ID, pdev);
-		if (pdev &&
-		    (pdev->device = PCI_DEVICE_ID_SUN_EBUS ||
-		     pdev->device = PCI_DEVICE_ID_SUN_RIO_EBUS))
+	while (pdev = pci_get_device(PCI_VENDOR_ID_SUN, PCI_ANY_ID, pdev))
+		if (pdev->device = PCI_DEVICE_ID_SUN_EBUS ||
+			pdev->device = PCI_DEVICE_ID_SUN_RIO_EBUS)
 			break;
-	} while (pdev != NULL);
-
-	if (pdev && (pdev->device = PCI_DEVICE_ID_SUN_RIO_EBUS))
-		*is_rio_p = 1;
-	else
-		*is_rio_p = 0;
 
+	*is_rio_p = !!(pdev && (pdev->device = PCI_DEVICE_ID_SUN_RIO_EBUS));
+	
 	return pdev;
 }
 
@@ -637,6 +631,7 @@ void __init ebus_init(void)
 		ebus->is_rio = is_rio;
 		++num_ebus;
 	}
+	pci_dev_put(pdev); /* XXX for the case, when ebusnd is 0, is it OK? */
 
 #ifdef CONFIG_SUN_AUXIO
 	auxio_probe();

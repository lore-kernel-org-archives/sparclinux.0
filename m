From: Amit Gud <gud@eth.net>
Date: Tue, 29 Mar 2005 12:39:47 +0000
Subject: [PATCH 5/91] get rid of pci_find_{device,subsys} arch/sparc64
Message-Id: <ITPXCHFE1gwJHpeVvVN0000206b@itpxchfe1.enterprise.veritas.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Replace pci_find_{device,subsys} with pci_get_{device,subsys}.



Signed-off-by: Amit Gud <gud@eth.net>

---
diff -upr orig-2.6.12-rc1/arch/sparc64/kernel/ebus.c work-2.6.12-rc1/arch/sparc64/kernel/ebus.c
--- orig-2.6.12-rc1/arch/sparc64/kernel/ebus.c	2005-03-15 21:00:22.000000000 +0530
+++ work-2.6.12-rc1/arch/sparc64/kernel/ebus.c	2005-03-29 17:55:40.281121064 +0530
@@ -528,11 +528,12 @@ static struct pci_dev *find_next_ebus(st
 	struct pci_dev *pdev = start;
 
 	do {
-		pdev = pci_find_device(PCI_VENDOR_ID_SUN, PCI_ANY_ID, pdev);
+		pdev = pci_get_device(PCI_VENDOR_ID_SUN, PCI_ANY_ID, pdev);
 		if (pdev &&
 		    (pdev->device = PCI_DEVICE_ID_SUN_EBUS ||
 		     pdev->device = PCI_DEVICE_ID_SUN_RIO_EBUS))
 			break;
+		pci_dev_put(pdev);
 	} while (pdev != NULL);
 
 	if (pdev && (pdev->device = PCI_DEVICE_ID_SUN_RIO_EBUS))
@@ -540,6 +541,7 @@ static struct pci_dev *find_next_ebus(st
 	else
 		*is_rio_p = 0;
 
+	pci_dev_put(pdev);
 	return pdev;
 }
 

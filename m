From: domen@coderock.org
Date: Mon, 10 Jan 2005 17:48:51 +0000
Subject: [patch 1/2] ebus.c replace pci_find_device with pci_get_device
Message-Id: <20050110174852.931F21F1ED@trashy.coderock.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org




As pci_find_device is going away I've replaced it with pci_get_device.
If someone with a Sparc64 system could test it I would appreciate it.
Thanks.

Hanna Linder
IBM Linux Technology Center

Signed-off-by: Hanna Linder <hannal@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
---
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/arch/sparc64/kernel/ebus.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/sparc64/kernel/ebus.c~remove-pci-find-device-arch_sparc64_kernel_ebus arch/sparc64/kernel/ebus.c
--- kj/arch/sparc64/kernel/ebus.c~remove-pci-find-device-arch_sparc64_kernel_ebus	2005-01-10 18:00:16.000000000 +0100
+++ kj-domen/arch/sparc64/kernel/ebus.c	2005-01-10 18:00:16.000000000 +0100
@@ -528,7 +528,7 @@ static struct pci_dev *find_next_ebus(st
 	struct pci_dev *pdev = start;
 
 	do {
-		pdev = pci_find_device(PCI_VENDOR_ID_SUN, PCI_ANY_ID, pdev);
+		pdev = pci_get_device(PCI_VENDOR_ID_SUN, PCI_ANY_ID, pdev);
 		if (pdev &&
 		    (pdev->device = PCI_DEVICE_ID_SUN_EBUS ||
 		     pdev->device = PCI_DEVICE_ID_SUN_RIO_EBUS))
_

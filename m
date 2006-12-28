From: Jan Andersson <jan.andersson@ieee.org>
Date: Thu, 28 Dec 2006 17:44:59 +0000
Subject: [PATCH] sparc32: add offset in pci_map_sg()
Message-Id: <20061228184459.1c51a33b@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: wli@holomorphy.com
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Jan Andersson jan.andersson@ieee.org

Add sg->offset to sg->dvma_address in pci_map_sg() on sparc32. Without
the offset, transfers to buffers that do not begin on a page boundary 
will not work as expected. 

Signed-off-by: Jan Andersson <jan.andersson@ieee.org>
---

diff -uprN a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
--- a/arch/sparc/kernel/ioport.c        2006-12-28 15:00:46.000000000 +0100
+++ b/arch/sparc/kernel/ioport.c        2006-12-28 16:22:40.000000000 +0100
@@ -728,7 +728,8 @@ int pci_map_sg(struct pci_dev *hwdev, st
        /* IIep is write-through, not flushing. */
        for (n = 0; n < nents; n++) {
                BUG_ON(page_address(sg->page) = NULL);
-               sg->dvma_address = virt_to_phys(page_address(sg->page));
+               sg->dvma_address = 
+                       virt_to_phys(page_address(sg->page)) + sg->offset;
                sg->dvma_length = sg->length;
                sg++;
        }

From: "Art Haas" <ahaas@airmail.net>
Date: Wed, 28 Jul 2004 15:09:08 +0000
Subject: [PATCH] Remove duplicated pci_dma_mapping_error function
Message-Id: <20040728150908.GW3996@artsapartment.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Here's a patch to remove the older version of the function. The patch is
untested as yet, as the kernel build with this patch is just beginning.
The patch is against the current BK.

Art Haas

=== include/asm-sparc/pci.h 1.16 vs edited ==--- 1.16/include/asm-sparc/pci.h	2004-07-21 15:44:22 -05:00
+++ edited/include/asm-sparc/pci.h	2004-07-28 10:05:02 -05:00
@@ -87,12 +87,6 @@
 extern void pci_unmap_page(struct pci_dev *hwdev,
 			dma_addr_t dma_address, size_t size, int direction);
 
-/* map_page and map_single cannot fail */
-static inline int pci_dma_mapping_error(dma_addr_t dma_addr)
-{
-	return 0;
-}
-
 /* Map a set of buffers described by scatterlist in streaming
  * mode for DMA.  This is the scather-gather version of the
  * above pci_map_single interface.  Here the scatter gather list
-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822

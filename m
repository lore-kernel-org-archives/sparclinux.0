From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Mon, 12 Jul 2004 22:30:39 +0000
Subject: [PATCH 2.6] define pci_dma_mapping_error for sparc
Message-Id: <1089671439.20813.31.camel@localhost.localdomain>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-eUA8gMdw1QUenENwE0Z9"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--=-eUA8gMdw1QUenENwE0Z9
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Sparc32 is missing the pci_dma_mapping_error function in pci.h, this
patch adds it.

~spot
---
Tom "spot" Callaway <tcallawa(a)redhat*com> LCA, RHCE 
Red Hat Sales Engineer || Aurora Linux Project Leader

"If you are going through hell, keep going."
- Sir Winston Churchill

--=-eUA8gMdw1QUenENwE0Z9
Content-Disposition: attachment; filename=linux-2.6.6-sparc-define_pci_dma_mapping_error.patch
Content-Type: text/x-patch; name=linux-2.6.6-sparc-define_pci_dma_mapping_error.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.6/include/asm-sparc/pci.h.BAD	2004-05-19 21:38:11.502123000 -0400
+++ linux-2.6.6/include/asm-sparc/pci.h	2004-05-19 21:40:13.872123000 -0400
@@ -148,6 +148,13 @@
 {
 }
 
+#define PCI_DMA_ERROR_CODE      (~(dma_addr_t)0x0)
+                                                                                
+static inline int pci_dma_mapping_error(dma_addr_t dma_addr)
+{
+        return (dma_addr == PCI_DMA_ERROR_CODE);
+}
+
 #endif /* __KERNEL__ */
 
 /* generic pci stuff */

--=-eUA8gMdw1QUenENwE0Z9--


From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Mon, 12 Jul 2004 22:33:23 +0000
Subject: Re: [PATCH 2.6] define pci_dma_mapping_error for sparc
Message-Id: <1089671603.20813.33.camel@localhost.localdomain>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-Vh6kjhHYGd67J9ZiPAJ/"
List-Id: <sparclinux.vger.kernel.org>
References: <1089671439.20813.31.camel@localhost.localdomain>
In-Reply-To: <1089671439.20813.31.camel@localhost.localdomain>
To: sparclinux@vger.kernel.org


--=-Vh6kjhHYGd67J9ZiPAJ/
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2004-07-12 at 17:30 -0500, Tom 'spot' Callaway wrote:
> Sparc32 is missing the pci_dma_mapping_error function in pci.h, this
> patch adds it.

Ugh. Use this revision instead, sorry for the nasty whitespace.

~spot
---
Tom "spot" Callaway <tcallawa(a)redhat*com> LCA, RHCE 
Red Hat Sales Engineer || Aurora Linux Project Leader

"If you are going through hell, keep going."
- Sir Winston Churchill

--=-Vh6kjhHYGd67J9ZiPAJ/
Content-Disposition: attachment; filename=linux-2.6.6-sparc-define_pci_dma_mapping_error-good.patch
Content-Type: text/x-patch; name=linux-2.6.6-sparc-define_pci_dma_mapping_error-good.patch; charset=utf-8
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

--=-Vh6kjhHYGd67J9ZiPAJ/--


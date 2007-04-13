From: "Tom \"spot\" Callaway" <tcallawa@redhat.com>
Date: Fri, 13 Apr 2007 17:10:32 +0000
Subject: [PATCH] minor inline fix for sparc64
Message-Id: <1176484232.3970.198.camel@localhost.localdomain>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-aLt80i/vTDKzyQGrE2Im"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--=-aLt80i/vTDKzyQGrE2Im
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

While building a test kernel for the new esp driver (against
git-current), I hit this bug. Trivial fix, put the inline declaration
in the right place. :)

Signed-off-by: Tom "spot" Callaway <tcallawa@redhat.com>



--=-aLt80i/vTDKzyQGrE2Im
Content-Disposition: attachment; filename=linux-2.6.20-sparc64-inlinefix.patch
Content-Type: text/x-patch; name=linux-2.6.20-sparc64-inlinefix.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.20.sparc64/arch/sparc64/kernel/pci_iommu.c.BAD	2007-04-13 12:35:59.000000000 -0400
+++ linux-2.6.20.sparc64/arch/sparc64/kernel/pci_iommu.c	2007-04-13 12:36:11.000000000 -0400
@@ -64,7 +64,7 @@
 #define IOPTE_IS_DUMMY(iommu, iopte)	\
 	((iopte_val(*iopte) & IOPTE_PAGE) == (iommu)->dummy_page_pa)
 
-static void inline iopte_make_dummy(struct pci_iommu *iommu, iopte_t *iopte)
+static inline void iopte_make_dummy(struct pci_iommu *iommu, iopte_t *iopte)
 {
 	unsigned long val = iopte_val(*iopte);
 

--=-aLt80i/vTDKzyQGrE2Im--


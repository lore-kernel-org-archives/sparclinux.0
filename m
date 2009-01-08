From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 08 Jan 2009 19:27:23 +0000
Subject: [PATCH] fix warnings in psycho_common after ull conversion
Message-Id: <20090108192723.GA27674@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

After conversion to use unsigned long long for u64
I saw following warnings:

  CC      arch/sparc/kernel/psycho_common.o
arch/sparc/kernel/psycho_common.c: In function `psycho_check_stc_error':
arch/sparc/kernel/psycho_common.c:104: warning: long long unsigned int format, long unsigned int arg (arg 4)
arch/sparc/kernel/psycho_common.c:104: warning: long long unsigned int format, long unsigned int arg (arg 5)
arch/sparc/kernel/psycho_common.c:114: warning: long long unsigned int format, long unsigned int arg (arg 4)
arch/sparc/kernel/psycho_common.c:114: warning: long long unsigned int format, long unsigned int arg (arg 5)
arch/sparc/kernel/psycho_common.c:114: warning: long long unsigned int format, long unsigned int arg (arg 6)
arch/sparc/kernel/psycho_common.c:114: warning: long long unsigned int format, long unsigned int arg (arg 7)
arch/sparc/kernel/psycho_common.c: In function `psycho_dump_iommu_tags_and_data':
arch/sparc/kernel/psycho_common.c:187: warning: long long unsigned int format, long unsigned int arg (arg 8)
arch/sparc/kernel/psycho_common.c:193: warning: long long unsigned int format, long unsigned int arg (arg 6)
arch/sparc/kernel/psycho_common.c: In function `psycho_pcierr_intr':
arch/sparc/kernel/psycho_common.c:333: warning: long long unsigned int format, long unsigned int arg (arg 3)
arch/sparc/kernel/psycho_common.c:333: warning: long long unsigned int format, long unsigned int arg (arg 4)

This is due to different integer promotion in my 32 bit hosted gcc.
The fix is to force a few constants to ULL.

The following stands out from the rest:
+#define  PSYCHO_IOMMU_TAG_VPAGE         0x7ffffULL
+#define  PSYCHO_IOMMU_DATA_PPAGE 0xfffffffULL

They were needed otherwise the expression:

    (data_val & PSYCHO_IOMMU_DATA_PPAGE) << IOMMU_PAGE_SHIFT)

were promoted to a unsigned long and not a unsigned long long as expected.

I tried the alternative solution and made IOMMU_PAGE_SHIFT an ULL but that did not help.
The only way gcc would make this expression an unsigned long long was to
define PSYCHO_IOMMU_DATA_PPAGE as ULL. The alternative to add a cast was
not considered a valid solution.

We had this issue in two places and this were the only places the above
two constants are used.

A small coding style diff sneaked in too. 

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---

I have so far not seen any other fallout due to this.
If I see more I will submit patches.

	Sam

diff --git a/arch/sparc/kernel/psycho_common.c b/arch/sparc/kernel/psycho_common.c
index 40689ae..8f14784 100644
--- a/arch/sparc/kernel/psycho_common.c
+++ b/arch/sparc/kernel/psycho_common.c
@@ -11,19 +11,19 @@
 #include "iommu_common.h"
 #include "psycho_common.h"
 
-#define  PSYCHO_STRBUF_CTRL_DENAB	0x0000000000000002UL
-#define  PSYCHO_STCERR_WRITE		0x0000000000000002UL
-#define  PSYCHO_STCERR_READ		0x0000000000000001UL
-#define  PSYCHO_STCTAG_PPN		0x0fffffff00000000UL
-#define  PSYCHO_STCTAG_VPN		0x00000000ffffe000UL
-#define  PSYCHO_STCTAG_VALID		0x0000000000000002UL
-#define  PSYCHO_STCTAG_WRITE		0x0000000000000001UL
-#define  PSYCHO_STCLINE_LINDX		0x0000000001e00000UL
-#define  PSYCHO_STCLINE_SPTR		0x00000000001f8000UL
-#define  PSYCHO_STCLINE_LADDR		0x0000000000007f00UL
-#define  PSYCHO_STCLINE_EPTR		0x00000000000000fcUL
-#define  PSYCHO_STCLINE_VALID		0x0000000000000002UL
-#define  PSYCHO_STCLINE_FOFN		0x0000000000000001UL
+#define  PSYCHO_STRBUF_CTRL_DENAB	0x0000000000000002ULL
+#define  PSYCHO_STCERR_WRITE		0x0000000000000002ULL
+#define  PSYCHO_STCERR_READ		0x0000000000000001ULL
+#define  PSYCHO_STCTAG_PPN		0x0fffffff00000000ULL
+#define  PSYCHO_STCTAG_VPN		0x00000000ffffe000ULL
+#define  PSYCHO_STCTAG_VALID		0x0000000000000002ULL
+#define  PSYCHO_STCTAG_WRITE		0x0000000000000001ULL
+#define  PSYCHO_STCLINE_LINDX		0x0000000001e00000ULL
+#define  PSYCHO_STCLINE_SPTR		0x00000000001f8000ULL
+#define  PSYCHO_STCLINE_LADDR		0x0000000000007f00ULL
+#define  PSYCHO_STCLINE_EPTR		0x00000000000000fcULL
+#define  PSYCHO_STCLINE_VALID		0x0000000000000002ULL
+#define  PSYCHO_STCLINE_FOFN		0x0000000000000001ULL
 
 static DEFINE_SPINLOCK(stc_buf_lock);
 static unsigned long stc_error_buf[128];
@@ -144,10 +144,10 @@ static void psycho_record_iommu_tags_and_data(struct pci_pbm_info *pbm,
 #define  PSYCHO_IOMMU_TAG_WRITE	 (0x1UL << 21UL)
 #define  PSYCHO_IOMMU_TAG_STREAM (0x1UL << 20UL)
 #define  PSYCHO_IOMMU_TAG_SIZE	 (0x1UL << 19UL)
-#define  PSYCHO_IOMMU_TAG_VPAGE	 0x7ffffUL
+#define  PSYCHO_IOMMU_TAG_VPAGE	 0x7ffffULL
 #define  PSYCHO_IOMMU_DATA_VALID (1UL << 30UL)
 #define  PSYCHO_IOMMU_DATA_CACHE (1UL << 28UL)
-#define  PSYCHO_IOMMU_DATA_PPAGE 0xfffffffUL
+#define  PSYCHO_IOMMU_DATA_PPAGE 0xfffffffULL
 
 static void psycho_dump_iommu_tags_and_data(struct pci_pbm_info *pbm,
 					    u64 *tag, u64 *data)
@@ -190,7 +190,7 @@ static void psycho_dump_iommu_tags_and_data(struct pci_pbm_info *pbm,
 		       pbm->name, i,
 		       ((data_val & PSYCHO_IOMMU_DATA_VALID) ? 1 : 0),
 		       ((data_val & PSYCHO_IOMMU_DATA_CACHE) ? 1 : 0),
-		       (data_val & PSYCHO_IOMMU_DATA_PPAGE)<<IOMMU_PAGE_SHIFT);
+		       (data_val & PSYCHO_IOMMU_DATA_PPAGE) << IOMMU_PAGE_SHIFT);
 	}
 }
 
@@ -285,20 +285,20 @@ static irqreturn_t psycho_pcierr_intr_other(struct pci_pbm_info *pbm)
 	return ret;
 }
 
-#define  PSYCHO_PCIAFSR_PMA	0x8000000000000000UL
-#define  PSYCHO_PCIAFSR_PTA	0x4000000000000000UL
-#define  PSYCHO_PCIAFSR_PRTRY	0x2000000000000000UL
-#define  PSYCHO_PCIAFSR_PPERR	0x1000000000000000UL
-#define  PSYCHO_PCIAFSR_SMA	0x0800000000000000UL
-#define  PSYCHO_PCIAFSR_STA	0x0400000000000000UL
-#define  PSYCHO_PCIAFSR_SRTRY	0x0200000000000000UL
-#define  PSYCHO_PCIAFSR_SPERR	0x0100000000000000UL
-#define  PSYCHO_PCIAFSR_RESV1	0x00ff000000000000UL
-#define  PSYCHO_PCIAFSR_BMSK	0x0000ffff00000000UL
-#define  PSYCHO_PCIAFSR_BLK	0x0000000080000000UL
-#define  PSYCHO_PCIAFSR_RESV2	0x0000000040000000UL
-#define  PSYCHO_PCIAFSR_MID	0x000000003e000000UL
-#define  PSYCHO_PCIAFSR_RESV3	0x0000000001ffffffUL
+#define  PSYCHO_PCIAFSR_PMA	0x8000000000000000ULL
+#define  PSYCHO_PCIAFSR_PTA	0x4000000000000000ULL
+#define  PSYCHO_PCIAFSR_PRTRY	0x2000000000000000ULL
+#define  PSYCHO_PCIAFSR_PPERR	0x1000000000000000ULL
+#define  PSYCHO_PCIAFSR_SMA	0x0800000000000000ULL
+#define  PSYCHO_PCIAFSR_STA	0x0400000000000000ULL
+#define  PSYCHO_PCIAFSR_SRTRY	0x0200000000000000ULL
+#define  PSYCHO_PCIAFSR_SPERR	0x0100000000000000ULL
+#define  PSYCHO_PCIAFSR_RESV1	0x00ff000000000000ULL
+#define  PSYCHO_PCIAFSR_BMSK	0x0000ffff00000000ULL
+#define  PSYCHO_PCIAFSR_BLK	0x0000000080000000ULL
+#define  PSYCHO_PCIAFSR_RESV2	0x0000000040000000ULL
+#define  PSYCHO_PCIAFSR_MID	0x000000003e000000ULL
+#define  PSYCHO_PCIAFSR_RESV3	0x0000000001ffffffULL
 
 irqreturn_t psycho_pcierr_intr(int irq, void *dev_id)
 {

From: Nitin Gupta <nitin.m.gupta@oracle.com>
Date: Thu, 09 Mar 2017 22:22:23 +0000
Subject: [PATCH] sparc64: Add support for 2G hugepages
Message-Id: <1489098164-220948-1-git-send-email-nitin.m.gupta@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: Nitin Gupta <nitin.m.gupta@oracle.com>, Mike Kravetz <mike.kravetz@oracle.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Ingo Molnar <mingo@kernel.org>, Babu Moger <babu.moger@oracle.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Bob Picco <bob.picco@oracle.com>, Thomas Tai <thomas.tai@oracle.com>, Pavel Tatashin <pasha.tatashin@oracle.com>, Atish Patra <atish.patra@oracle.com>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

Signed-off-by: Nitin Gupta <nitin.m.gupta@oracle.com>
---
 arch/sparc/include/asm/page_64.h | 3 ++-
 arch/sparc/mm/hugetlbpage.c      | 7 +++++++
 arch/sparc/mm/init_64.c          | 4 ++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/include/asm/page_64.h b/arch/sparc/include/asm/page_64.h
index f294dd4..5961b2d 100644
--- a/arch/sparc/include/asm/page_64.h
+++ b/arch/sparc/include/asm/page_64.h
@@ -17,6 +17,7 @@
 
 #define HPAGE_SHIFT		23
 #define REAL_HPAGE_SHIFT	22
+#define HPAGE_2GB_SHIFT		31
 #define HPAGE_256MB_SHIFT	28
 #define HPAGE_64K_SHIFT		16
 #define REAL_HPAGE_SIZE		(_AC(1,UL) << REAL_HPAGE_SHIFT)
@@ -27,7 +28,7 @@
 #define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT - PAGE_SHIFT)
 #define HAVE_ARCH_HUGETLB_UNMAPPED_AREA
 #define REAL_HPAGE_PER_HPAGE	(_AC(1,UL) << (HPAGE_SHIFT - REAL_HPAGE_SHIFT))
-#define HUGE_MAX_HSTATE		3
+#define HUGE_MAX_HSTATE		4
 #endif
 
 #ifndef __ASSEMBLY__
diff --git a/arch/sparc/mm/hugetlbpage.c b/arch/sparc/mm/hugetlbpage.c
index 3016850..ee5273a 100644
--- a/arch/sparc/mm/hugetlbpage.c
+++ b/arch/sparc/mm/hugetlbpage.c
@@ -143,6 +143,10 @@ static pte_t sun4v_hugepage_shift_to_tte(pte_t entry, unsigned int shift)
 	pte_val(entry) = pte_val(entry) & ~_PAGE_SZALL_4V;
 
 	switch (shift) {
+	case HPAGE_2GB_SHIFT:
+		hugepage_size = _PAGE_SZ2GB_4V;
+		pte_val(entry) |= _PAGE_PMD_HUGE;
+		break;
 	case HPAGE_256MB_SHIFT:
 		hugepage_size = _PAGE_SZ256MB_4V;
 		pte_val(entry) |= _PAGE_PMD_HUGE;
@@ -183,6 +187,9 @@ static unsigned int sun4v_huge_tte_to_shift(pte_t entry)
 	unsigned int shift;
 
 	switch (tte_szbits) {
+	case _PAGE_SZ2GB_4V:
+		shift = HPAGE_2GB_SHIFT;
+		break;
 	case _PAGE_SZ256MB_4V:
 		shift = HPAGE_256MB_SHIFT;
 		break;
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index ccd4553..3328043 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -337,6 +337,10 @@ static int __init setup_hugepagesz(char *string)
 	hugepage_shift = ilog2(hugepage_size);
 
 	switch (hugepage_shift) {
+	case HPAGE_2GB_SHIFT:
+		hv_pgsz_mask = HV_PGSZ_MASK_2GB;
+		hv_pgsz_idx = HV_PGSZ_IDX_2GB;
+		break;
 	case HPAGE_256MB_SHIFT:
 		hv_pgsz_mask = HV_PGSZ_MASK_256MB;
 		hv_pgsz_idx = HV_PGSZ_IDX_256MB;
-- 
2.9.2


From: David Miller <davem@davemloft.net>
Date: Mon, 30 Sep 2013 16:31:52 +0000
Subject: [PATCH 4/9] sparc64: Document the shift counts used to validate linear kernel addresses.
Message-Id: <20130930.123152.61930388532110733.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


This way we can see exactly what they are derived from, and in particular
how they would change if we were to use a different PAGE_OFFSET value.

Signed-off-by: David S. Miller <davem@davemloft.net>
Acked-by: Bob Picco <bob.picco@oracle.com>
---
 arch/sparc/include/asm/page_64.h | 16 ++++++++++++++++
 arch/sparc/kernel/ktlb.S         | 10 +++++-----
 arch/sparc/mm/init_64.h          |  4 +++-
 3 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/arch/sparc/include/asm/page_64.h b/arch/sparc/include/asm/page_64.h
index 9dd0f73..978ea6d 100644
--- a/arch/sparc/include/asm/page_64.h
+++ b/arch/sparc/include/asm/page_64.h
@@ -121,6 +121,22 @@ typedef pte_t *pgtable_t;
 #define PAGE_OFFSET_BY_BITS(X)	(-(_AC(1,UL) << (X)))
 #define PAGE_OFFSET		PAGE_OFFSET_BY_BITS(MAX_SUPPORTED_PA_BITS)
 
+/* The "virtual" portion of PAGE_OFFSET, used to clip off the non-physical
+ * bits of a linear kernel address.
+ */
+#define PAGE_OFFSET_VA_BITS	(64 - MAX_SUPPORTED_PA_BITS)
+
+/* The actual number of physical memory address bits we support, this is
+ * used to size various tables used to manage kernel TLB misses.
+ */
+#define MAX_PHYS_ADDRESS_BITS	41
+
+/* These two shift counts are used when indexing sparc64_valid_addr_bitmap
+ * and kpte_linear_bitmap.
+ */
+#define ILOG2_4MB		22
+#define ILOG2_256MB		28
+
 #ifndef __ASSEMBLY__
 
 #define __pa(x)			((unsigned long)(x) - PAGE_OFFSET)
diff --git a/arch/sparc/kernel/ktlb.S b/arch/sparc/kernel/ktlb.S
index fde5a41..7ad46bc 100644
--- a/arch/sparc/kernel/ktlb.S
+++ b/arch/sparc/kernel/ktlb.S
@@ -153,12 +153,12 @@ kvmap_dtlb_tsb4m_miss:
 	/* Clear the PAGE_OFFSET top virtual bits, shift
 	 * down to get PFN, and make sure PFN is in range.
 	 */
-	sllx		%g4, 21, %g5
+	sllx		%g4, PAGE_OFFSET_VA_BITS, %g5
 
 	/* Check to see if we know about valid memory at the 4MB
 	 * chunk this physical address will reside within.
 	 */
-	srlx		%g5, 21 + 41, %g2
+	srlx		%g5, PAGE_OFFSET_VA_BITS + MAX_PHYS_ADDRESS_BITS, %g2
 	brnz,pn		%g2, kvmap_dtlb_longpath
 	 nop
 
@@ -176,7 +176,7 @@ valid_addr_bitmap_patch:
 	or		%g7, %lo(sparc64_valid_addr_bitmap), %g7
 	.previous
 
-	srlx		%g5, 21 + 22, %g2
+	srlx		%g5, PAGE_OFFSET_VA_BITS + ILOG2_4MB, %g2
 	srlx		%g2, 6, %g5
 	and		%g2, 63, %g2
 	sllx		%g5, 3, %g5
@@ -189,9 +189,9 @@ valid_addr_bitmap_patch:
 2:	 sethi		%hi(kpte_linear_bitmap), %g2
 
 	/* Get the 256MB physical address index. */
-	sllx		%g4, 21, %g5
+	sllx		%g4, PAGE_OFFSET_VA_BITS, %g5
 	or		%g2, %lo(kpte_linear_bitmap), %g2
-	srlx		%g5, 21 + 28, %g5
+	srlx		%g5, PAGE_OFFSET_VA_BITS + ILOG2_256MB, %g5
 	and		%g5, (32 - 1), %g7
 
 	/* Divide by 32 to get the offset into the bitmask.  */
diff --git a/arch/sparc/mm/init_64.h b/arch/sparc/mm/init_64.h
index 0661aa6..5d3782de 100644
--- a/arch/sparc/mm/init_64.h
+++ b/arch/sparc/mm/init_64.h
@@ -1,11 +1,13 @@
 #ifndef _SPARC64_MM_INIT_H
 #define _SPARC64_MM_INIT_H
 
+#include <asm/page.h>
+
 /* Most of the symbols in this file are defined in init.c and
  * marked non-static so that assembler code can get at them.
  */
 
-#define MAX_PHYS_ADDRESS	(1UL << 41UL)
+#define MAX_PHYS_ADDRESS	(1UL << MAX_PHYS_ADDRESS_BITS)
 #define KPTE_BITMAP_CHUNK_SZ		(256UL * 1024UL * 1024UL)
 #define KPTE_BITMAP_BYTES	\
 	((MAX_PHYS_ADDRESS / KPTE_BITMAP_CHUNK_SZ) / 4)
-- 
1.8.1.2


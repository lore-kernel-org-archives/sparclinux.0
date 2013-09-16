From: Bob Picco <bpicco@meloft.net>
Date: Mon, 16 Sep 2013 13:46:36 +0000
Subject: [PATCH 1/4] sparc64 expand linear mapping region
Message-Id: <1379339199-9388-2-git-send-email-bpicco@meloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: bob picco <bpicco@meloft.net>

This prepares for four level page table support in sparc64. It expands
the identity mapped region to 47 bits. It also identifies pieces of
code which are impacted by the changes.

This patch introduces a new config option which isn't available until later
in the patch series.

Signed-off-by: Bob Picco <bob.picco@oracle.com>
---
 arch/sparc/include/asm/page_64.h   |   10 +++++++++-
 arch/sparc/include/asm/sparsemem.h |    5 +++++
 arch/sparc/kernel/ktlb.S           |   12 +++++++-----
 arch/sparc/mm/init_64.c            |   11 +++++------
 arch/sparc/mm/init_64.h            |    4 ++++
 5 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/arch/sparc/include/asm/page_64.h b/arch/sparc/include/asm/page_64.h
index e155388..f4e7adf 100644
--- a/arch/sparc/include/asm/page_64.h
+++ b/arch/sparc/include/asm/page_64.h
@@ -104,7 +104,15 @@ typedef pte_t *pgtable_t;
 /* We used to stick this into a hard-coded global register (%g4)
  * but that does not make sense anymore.
  */
-#define PAGE_OFFSET		_AC(0xFFFFF80000000000,UL)
+#ifdef CONFIG_SPARC_PGTABLE_LEVEL4
+#define	PO_LOWBITS		_AC(47,UL)
+#define	PO_DELTA		_AC(0, UL)
+#else
+#define	PO_LOWBITS		_AC(43,UL)
+#define	PO_DELTA		_AC(2, UL)
+#endif
+#define	PO_HIBITS		(BITS_PER_LONG - PO_LOWBITS)
+#define	PAGE_OFFSET		(-(_AC(1,UL) << PO_LOWBITS))
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/sparc/include/asm/sparsemem.h b/arch/sparc/include/asm/sparsemem.h
index b99d4e4..e147bb1 100644
--- a/arch/sparc/include/asm/sparsemem.h
+++ b/arch/sparc/include/asm/sparsemem.h
@@ -4,8 +4,13 @@
 #ifdef __KERNEL__
 
 #define SECTION_SIZE_BITS       30
+#ifdef CONFIG_SPARC_PGTABLE_LEVEL4
+#define MAX_PHYSADDR_BITS       47
+#define MAX_PHYSMEM_BITS        47
+#else
 #define MAX_PHYSADDR_BITS       42
 #define MAX_PHYSMEM_BITS        42
+#endif
 
 #endif /* !(__KERNEL__) */
 
diff --git a/arch/sparc/kernel/ktlb.S b/arch/sparc/kernel/ktlb.S
index fde5a41..ddb77b6 100644
--- a/arch/sparc/kernel/ktlb.S
+++ b/arch/sparc/kernel/ktlb.S
@@ -153,14 +153,16 @@
 	/* Clear the PAGE_OFFSET top virtual bits, shift
 	 * down to get PFN, and make sure PFN is in range.
 	 */
-	sllx		%g4, 21, %g5
+	sllx		%g4, PO_HIBITS, %g5
 
+#ifndef CONFIG_SPARC_PGTABLE_LEVEL4
 	/* Check to see if we know about valid memory at the 4MB
 	 * chunk this physical address will reside within.
 	 */
-	srlx		%g5, 21 + 41, %g2
+	srlx		%g5, PO_HIBITS + PO_LOWBITS - PO_DELTA, %g2
 	brnz,pn		%g2, kvmap_dtlb_longpath
 	 nop
+#endif
 
 	/* This unconditional branch and delay-slot nop gets patched
 	 * by the sethi sequence once the bitmap is properly setup.
@@ -176,7 +178,7 @@
 	or		%g7, %lo(sparc64_valid_addr_bitmap), %g7
 	.previous
 
-	srlx		%g5, 21 + 22, %g2
+	srlx		%g5, PO_HIBITS + 22, %g2
 	srlx		%g2, 6, %g5
 	and		%g2, 63, %g2
 	sllx		%g5, 3, %g5
@@ -189,9 +191,9 @@
 2:	 sethi		%hi(kpte_linear_bitmap), %g2
 
 	/* Get the 256MB physical address index. */
-	sllx		%g4, 21, %g5
+	sllx            %g4, PO_HIBITS, %g5
 	or		%g2, %lo(kpte_linear_bitmap), %g2
-	srlx		%g5, 21 + 28, %g5
+	srlx            %g5, PO_HIBITS + 28, %g5
 	and		%g5, (32 - 1), %g7
 
 	/* Divide by 32 to get the offset into the bitmask.  */
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index ed82eda..3aebec9 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -1722,7 +1722,7 @@ static void __init sun4v_linear_pte_xor_finalize(void)
 #ifndef CONFIG_DEBUG_PAGEALLOC
 	if (cpu_pgsz_mask & HV_PGSZ_MASK_256MB) {
 		kern_linear_pte_xor[1] = (_PAGE_VALID | _PAGE_SZ256MB_4V) ^
-			0xfffff80000000000UL;
+			PAGE_OFFSET;
 		kern_linear_pte_xor[1] |= (_PAGE_CP_4V | _PAGE_CV_4V |
 					   _PAGE_P_4V | _PAGE_W_4V);
 	} else {
@@ -1731,7 +1731,7 @@ static void __init sun4v_linear_pte_xor_finalize(void)
 
 	if (cpu_pgsz_mask & HV_PGSZ_MASK_2GB) {
 		kern_linear_pte_xor[2] = (_PAGE_VALID | _PAGE_SZ2GB_4V) ^
-			0xfffff80000000000UL;
+			PAGE_OFFSET;
 		kern_linear_pte_xor[2] |= (_PAGE_CP_4V | _PAGE_CV_4V |
 					   _PAGE_P_4V | _PAGE_W_4V);
 	} else {
@@ -1740,7 +1740,7 @@ static void __init sun4v_linear_pte_xor_finalize(void)
 
 	if (cpu_pgsz_mask & HV_PGSZ_MASK_16GB) {
 		kern_linear_pte_xor[3] = (_PAGE_VALID | _PAGE_SZ16GB_4V) ^
-			0xfffff80000000000UL;
+			PAGE_OFFSET;
 		kern_linear_pte_xor[3] |= (_PAGE_CP_4V | _PAGE_CV_4V |
 					   _PAGE_P_4V | _PAGE_W_4V);
 	} else {
@@ -2308,10 +2308,9 @@ static void __init sun4v_pgprot_init(void)
 	_PAGE_CACHE = _PAGE_CACHE_4V;
 
 #ifdef CONFIG_DEBUG_PAGEALLOC
-	kern_linear_pte_xor[0] = _PAGE_VALID ^ 0xfffff80000000000UL;
+	kern_linear_pte_xor[0] = _PAGE_VALID ^ PAGE_OFFSET;
 #else
-	kern_linear_pte_xor[0] = (_PAGE_VALID | _PAGE_SZ4MB_4V) ^
-		0xfffff80000000000UL;
+	kern_linear_pte_xor[0] = (_PAGE_VALID | _PAGE_SZ4MB_4V) ^ PAGE_OFFSET;
 #endif
 	kern_linear_pte_xor[0] |= (_PAGE_CP_4V | _PAGE_CV_4V |
 				   _PAGE_P_4V | _PAGE_W_4V);
diff --git a/arch/sparc/mm/init_64.h b/arch/sparc/mm/init_64.h
index 0661aa6..0753ac6 100644
--- a/arch/sparc/mm/init_64.h
+++ b/arch/sparc/mm/init_64.h
@@ -5,7 +5,11 @@
  * marked non-static so that assembler code can get at them.
  */
 
+#ifdef CONFIG_SPARC_PGTABLE_LEVEL4
+#define MAX_PHYS_ADDRESS	(1UL << 47UL)
+#else
 #define MAX_PHYS_ADDRESS	(1UL << 41UL)
+#endif
 #define KPTE_BITMAP_CHUNK_SZ		(256UL * 1024UL * 1024UL)
 #define KPTE_BITMAP_BYTES	\
 	((MAX_PHYS_ADDRESS / KPTE_BITMAP_CHUNK_SZ) / 4)
-- 
1.7.10.4


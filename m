From: Bob Picco <bob.picco@oracle.com>
Date: Wed, 01 Feb 2017 12:38:21 +0000
Subject: [PATCH 1/3] sparc64: make tsb pointer computation symbolic
Message-Id: <20170201123823.6273-2-bob.picco@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: bob picco <bob.picco@oracle.com>

Define some symbolic names for tsb/tlb miss trap tsb pointer computation.

Signed-off-by: Bob Picco <bob.picco@oracle.com>
---
 arch/sparc/include/asm/spitfire.h  |  5 +++++
 arch/sparc/kernel/sun4v_tlb_miss.S | 24 ++++++++++++------------
 2 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/arch/sparc/include/asm/spitfire.h b/arch/sparc/include/asm/spitfire.h
index 1d8321c827a8..1852a8618001 100644
--- a/arch/sparc/include/asm/spitfire.h
+++ b/arch/sparc/include/asm/spitfire.h
@@ -37,6 +37,11 @@
 #define SPITFIRE_HIGHEST_LOCKED_TLBENT	(64 - 1)
 #define CHEETAH_HIGHEST_LOCKED_TLBENT	(16 - 1)
 
+#define HV_TSB_SIZE_BASE	0x200	/* 512 TTE-s minimum.		*/
+#define	HV_TSB_SIZE_BASE_SHIFT	0x09	/* Shift of minimum tsb size.	*/
+#define	HV_TSB_SIZE_MASK	0x07	/* Size encoding of tsb.	*/
+#define	HV_TSB_TTE_SIZE_SHIFT	0x04	/* Sixteen byte tte size.	*/
+
 #define L1DCACHE_SIZE		0x4000
 
 #define SUN4V_CHIP_INVALID	0x00
diff --git a/arch/sparc/kernel/sun4v_tlb_miss.S b/arch/sparc/kernel/sun4v_tlb_miss.S
index 6179e19bc9b9..8206f5853866 100644
--- a/arch/sparc/kernel/sun4v_tlb_miss.S
+++ b/arch/sparc/kernel/sun4v_tlb_miss.S
@@ -27,20 +27,20 @@
 
 	/* Create TSB pointer.  This is something like:
 	 *
-	 * index_mask = (512 << (tsb_reg & 0x7UL)) - 1UL;
-	 * tsb_base = tsb_reg & ~0x7UL;
+	 * tsb_mask = (HV_TSB_SIZE_BASE << (tsb_reg & HV_TSB_SIZE_MASK)) - 1UL;
+	 * tsb_base = tsb_reg & ~HV_TSB_SIZE_MASK;
 	 * tsb_index = ((vaddr >> HASH_SHIFT) & tsb_mask);
-	 * tsb_ptr = tsb_base + (tsb_index * 16);
+	 * tsb_ptr = tsb_base + (tsb_index * (1UL << HV_TSB_TTE_SIZE_SHIFT));
 	 */
-#define COMPUTE_TSB_PTR(TSB_PTR, VADDR, HASH_SHIFT, TMP1, TMP2) \
-	and	TSB_PTR, 0x7, TMP1;			\
-	mov	512, TMP2;				\
-	andn	TSB_PTR, 0x7, TSB_PTR;			\
-	sllx	TMP2, TMP1, TMP2;			\
-	srlx	VADDR, HASH_SHIFT, TMP1;		\
-	sub	TMP2, 1, TMP2;				\
-	and	TMP1, TMP2, TMP1;			\
-	sllx	TMP1, 4, TMP1;				\
+#define COMPUTE_TSB_PTR(TSB_PTR, VADDR, HASH_SHIFT, TMP1, TMP2)		\
+	and	TSB_PTR, HV_TSB_SIZE_MASK, TMP1;			\
+	mov	HV_TSB_SIZE_BASE, TMP2;					\
+	andn	TSB_PTR, HV_TSB_SIZE_MASK, TSB_PTR;			\
+	sllx	TMP2, TMP1, TMP2;					\
+	srlx	VADDR, HASH_SHIFT, TMP1;				\
+	sub	TMP2, 1, TMP2;						\
+	and	TMP1, TMP2, TMP1;					\
+	sllx	TMP1, HV_TSB_TTE_SIZE_SHIFT, TMP1;			\
 	add	TSB_PTR, TMP1, TSB_PTR;
 
 sun4v_itlb_miss:
-- 
2.11.0


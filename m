From: Kirill Tkhai <tkhai@yandex.ru>
Date: Fri, 02 Aug 2013 15:24:40 +0000
Subject: [PATCH 2/2]sparc64: Unify kvmap_itlb for generic v9 and sun_4v
Message-Id: <1446411375457080@web28g.yandex.ru>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Compute virtual address before kvmap_itlb call and unify
kvmap_itlb and kvmap_itlb_4v.

In itlb_miss.S we use the fact that context is 0. So %g6
is already equal to TAG and we are ready for the call.

Signed-off-by: Kirill Tkhai <tkhai@yandex.ru>
CC: David Miller <davem@davemloft.net>
---
 arch/sparc/kernel/itlb_miss.S      |    4 ++--
 arch/sparc/kernel/ktlb.S           |   11 +++--------
 arch/sparc/kernel/sun4v_tlb_miss.S |    4 ++--
 3 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/arch/sparc/kernel/itlb_miss.S b/arch/sparc/kernel/itlb_miss.S
index 5a8377b..b8afcb9 100644
--- a/arch/sparc/kernel/itlb_miss.S
+++ b/arch/sparc/kernel/itlb_miss.S
@@ -2,9 +2,9 @@
 	ldxa	[%g0] ASI_IMMU_TSB_8KB_PTR, %g1	! Get TSB 8K pointer
 	ldxa	[%g0] ASI_IMMU, %g6		! Get TAG TARGET
 	srlx	%g6, 48, %g5			! Get context
-	sllx	%g6, 22, %g6			! Zero out context
 	brz,pn	%g5, kvmap_itlb			! Context 0 processing
-	 srlx	%g6, 22, %g6			! Delay slot
+	 sllx	%g6, 22, %g4			! Zero out context
+	srlx	%g4, 22, %g6			! Get TAG
 	TSB_LOAD_QUAD(%g1, %g4)			! Load TSB entry
 	cmp	%g4, %g6			! Compare TAG
 
diff --git a/arch/sparc/kernel/ktlb.S b/arch/sparc/kernel/ktlb.S
index fde5a41..2126015 100644
--- a/arch/sparc/kernel/ktlb.S
+++ b/arch/sparc/kernel/ktlb.S
@@ -15,16 +15,11 @@
 	.text
 	.align		32
 
-kvmap_itlb:
-	/* g6: TAG TARGET */
-	mov		TLB_TAG_ACCESS, %g4
-	ldxa		[%g4] ASI_IMMU, %g4
-
-	/* sun4v_itlb_miss branches here with the missing virtual
-	 * address already loaded into %g4
+	/* kernel branches here with the missing virtual address
+	 * loaded into %g4 and the tag loaded into %g6
 	 */
-kvmap_itlb_4v:
 
+kvmap_itlb:
 	/* Catch kernel NULL pointer calls.  */
 	sethi		%hi(PAGE_SIZE), %g5
 	cmp		%g4, %g5
diff --git a/arch/sparc/kernel/sun4v_tlb_miss.S b/arch/sparc/kernel/sun4v_tlb_miss.S
index bde867f..390cd9b 100644
--- a/arch/sparc/kernel/sun4v_tlb_miss.S
+++ b/arch/sparc/kernel/sun4v_tlb_miss.S
@@ -52,7 +52,7 @@ sun4v_itlb_miss:
 	ldxa	[%g1] ASI_SCRATCHPAD, %g1
 
 	LOAD_ITLB_INFO(%g2, %g4, %g5)
-	COMPUTE_TAG_TARGET(%g6, %g4, %g5, kvmap_itlb_4v)
+	COMPUTE_TAG_TARGET(%g6, %g4, %g5, kvmap_itlb)
 	COMPUTE_TSB_PTR(%g1, %g4, PAGE_SHIFT, %g3, %g7)
 
 	/* Load TSB tag/pte into %g2/%g3 and compare the tag.  */
@@ -154,7 +154,7 @@ sun4v_dtlb_prot:
 sun4v_itsb_miss:
 	mov	SCRATCHPAD_UTSBREG1, %g1
 	ldxa	[%g1] ASI_SCRATCHPAD, %g1
-	brz,pn	%g5, kvmap_itlb_4v
+	brz,pn	%g5, kvmap_itlb
 	 mov	FAULT_CODE_ITLB, %g3
 	ba,a,pt	%xcc, sun4v_tsb_miss_common
 


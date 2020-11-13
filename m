From: Peter Zijlstra <peterz@infradead.org>
Date: Fri, 13 Nov 2020 11:19:02 +0000
Subject: [PATCH 1/5] mm/gup: Provide gup_get_pte() more generic
Message-Id: <20201113113426.404673264@infradead.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20201113111901.743573013@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kan.liang@linux.intel.com, mingo@kernel.org, acme@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@redhat.com, eranian@google.com
Cc: christophe.leroy@csgroup.eu, npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, will@kernel.org, willy@infradead.org, aneesh.kumar@linux.ibm.com, sparclinux@vger.kernel.org, davem@davemloft.net, catalin.marinas@arm.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, ak@linux.intel.com, dave.hansen@intel.com, kirill.shutemov@linux.intel.com, peterz@infradead.org

In order to write another lockless page-table walker, we need
gup_get_pte() exposed. While doing that, rename it to
ptep_get_lockless() to match the existing ptep_get() naming.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/pgtable.h |   55 +++++++++++++++++++++++++++++++++++++++++++++
 mm/gup.c                |   58 ------------------------------------------------
 2 files changed, 56 insertions(+), 57 deletions(-)

--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -258,6 +258,61 @@ static inline pte_t ptep_get(pte_t *ptep
 }
 #endif
 
+#ifdef CONFIG_GUP_GET_PTE_LOW_HIGH
+/*
+ * WARNING: only to be used in the get_user_pages_fast() implementation.
+ *
+ * With get_user_pages_fast(), we walk down the pagetables without taking any
+ * locks.  For this we would like to load the pointers atomically, but sometimes
+ * that is not possible (e.g. without expensive cmpxchg8b on x86_32 PAE).  What
+ * we do have is the guarantee that a PTE will only either go from not present
+ * to present, or present to not present or both -- it will not switch to a
+ * completely different present page without a TLB flush in between; something
+ * that we are blocking by holding interrupts off.
+ *
+ * Setting ptes from not present to present goes:
+ *
+ *   ptep->pte_high = h;
+ *   smp_wmb();
+ *   ptep->pte_low = l;
+ *
+ * And present to not present goes:
+ *
+ *   ptep->pte_low = 0;
+ *   smp_wmb();
+ *   ptep->pte_high = 0;
+ *
+ * We must ensure here that the load of pte_low sees 'l' IFF pte_high sees 'h'.
+ * We load pte_high *after* loading pte_low, which ensures we don't see an older
+ * value of pte_high.  *Then* we recheck pte_low, which ensures that we haven't
+ * picked up a changed pte high. We might have gotten rubbish values from
+ * pte_low and pte_high, but we are guaranteed that pte_low will not have the
+ * present bit set *unless* it is 'l'. Because get_user_pages_fast() only
+ * operates on present ptes we're safe.
+ */
+static inline pte_t ptep_get_lockless(pte_t *ptep)
+{
+	pte_t pte;
+
+	do {
+		pte.pte_low = ptep->pte_low;
+		smp_rmb();
+		pte.pte_high = ptep->pte_high;
+		smp_rmb();
+	} while (unlikely(pte.pte_low != ptep->pte_low));
+
+	return pte;
+}
+#else /* CONFIG_GUP_GET_PTE_LOW_HIGH */
+/*
+ * We require that the PTE can be read atomically.
+ */
+static inline pte_t ptep_get_lockless(pte_t *ptep)
+{
+	return ptep_get(ptep);
+}
+#endif /* CONFIG_GUP_GET_PTE_LOW_HIGH */
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 #ifndef __HAVE_ARCH_PMDP_HUGE_GET_AND_CLEAR
 static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2079,62 +2079,6 @@ static void put_compound_head(struct pag
 	put_page(page);
 }
 
-#ifdef CONFIG_GUP_GET_PTE_LOW_HIGH
-
-/*
- * WARNING: only to be used in the get_user_pages_fast() implementation.
- *
- * With get_user_pages_fast(), we walk down the pagetables without taking any
- * locks.  For this we would like to load the pointers atomically, but sometimes
- * that is not possible (e.g. without expensive cmpxchg8b on x86_32 PAE).  What
- * we do have is the guarantee that a PTE will only either go from not present
- * to present, or present to not present or both -- it will not switch to a
- * completely different present page without a TLB flush in between; something
- * that we are blocking by holding interrupts off.
- *
- * Setting ptes from not present to present goes:
- *
- *   ptep->pte_high = h;
- *   smp_wmb();
- *   ptep->pte_low = l;
- *
- * And present to not present goes:
- *
- *   ptep->pte_low = 0;
- *   smp_wmb();
- *   ptep->pte_high = 0;
- *
- * We must ensure here that the load of pte_low sees 'l' IFF pte_high sees 'h'.
- * We load pte_high *after* loading pte_low, which ensures we don't see an older
- * value of pte_high.  *Then* we recheck pte_low, which ensures that we haven't
- * picked up a changed pte high. We might have gotten rubbish values from
- * pte_low and pte_high, but we are guaranteed that pte_low will not have the
- * present bit set *unless* it is 'l'. Because get_user_pages_fast() only
- * operates on present ptes we're safe.
- */
-static inline pte_t gup_get_pte(pte_t *ptep)
-{
-	pte_t pte;
-
-	do {
-		pte.pte_low = ptep->pte_low;
-		smp_rmb();
-		pte.pte_high = ptep->pte_high;
-		smp_rmb();
-	} while (unlikely(pte.pte_low != ptep->pte_low));
-
-	return pte;
-}
-#else /* CONFIG_GUP_GET_PTE_LOW_HIGH */
-/*
- * We require that the PTE can be read atomically.
- */
-static inline pte_t gup_get_pte(pte_t *ptep)
-{
-	return ptep_get(ptep);
-}
-#endif /* CONFIG_GUP_GET_PTE_LOW_HIGH */
-
 static void __maybe_unused undo_dev_pagemap(int *nr, int nr_start,
 					    unsigned int flags,
 					    struct page **pages)
@@ -2160,7 +2104,7 @@ static int gup_pte_range(pmd_t pmd, unsi
 
 	ptem = ptep = pte_offset_map(&pmd, addr);
 	do {
-		pte_t pte = gup_get_pte(ptep);
+		pte_t pte = ptep_get_lockless(ptep);
 		struct page *head, *page;
 
 		/*

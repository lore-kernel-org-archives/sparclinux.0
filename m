From: Prasad Joshi <prasadjoshi124@gmail.com>
Date: Mon, 14 Mar 2011 18:01:03 +0000
Subject: [RFC][PATCH v2 17/23] (sparc) __vmalloc: add gfp flags variant of pte
Message-Id: <AANLkTin1RfkdzK+oXG1mHR_KBAHyQfeOa_WrDEnLiFFW@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Prasad Joshi <prasadjoshi124@gmail.com>, Anand Mitra <mitra@kqinfotech.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

__vmalloc: propagating GFP allocation flag.

- adds functions to allow caller to pass the GFP flag for memory allocation
- helps in fixing the Bug 30702 (__vmalloc(GFP_NOFS) can callback
		  file system evict_inode).

Signed-off-by: Anand Mitra <mitra@kqinfotech.com>
Signed-off-by: Prasad Joshi <prasadjoshi124@gmail.com>
---
Chnagelog:
arch/sparc/include/asm/pgalloc_32.h |    5 +++++
arch/sparc/include/asm/pgalloc_64.h |   17 +++++++++++++++--
2 files changed, 20 insertions(+), 2 deletions(-)
---
diff --git a/arch/sparc/include/asm/pgalloc_32.h
b/arch/sparc/include/asm/pgalloc_32.h
index ca2b344..ad68597 100644
--- a/arch/sparc/include/asm/pgalloc_32.h
+++ b/arch/sparc/include/asm/pgalloc_32.h
@@ -41,6 +41,9 @@ BTFIXUPDEF_CALL(void, pgd_set, pgd_t *, pmd_t *)
 BTFIXUPDEF_CALL(pmd_t *, pmd_alloc_one, struct mm_struct *, unsigned long)
 #define pmd_alloc_one(mm, address)	BTFIXUP_CALL(pmd_alloc_one)(mm, address)

+BTFIXUPDEF_CALL(pmd_t *, __pmd_alloc_one, struct mm_struct *,
unsigned long, gfp_t)
+#define __pmd_alloc_one(mm, address,
gfp_mask)	BTFIXUP_CALL(pmd_alloc_one)(mm, address)
+
 BTFIXUPDEF_CALL(void, free_pmd_fast, pmd_t *)
 #define free_pmd_fast(pmd)	BTFIXUP_CALL(free_pmd_fast)(pmd)

@@ -57,6 +60,8 @@ BTFIXUPDEF_CALL(pgtable_t , pte_alloc_one, struct
mm_struct *, unsigned long)
 #define pte_alloc_one(mm, address)	BTFIXUP_CALL(pte_alloc_one)(mm, address)
 BTFIXUPDEF_CALL(pte_t *, pte_alloc_one_kernel, struct mm_struct *,
unsigned long)
 #define pte_alloc_one_kernel(mm,
addr)	BTFIXUP_CALL(pte_alloc_one_kernel)(mm, addr)
+BTFIXUPDEF_CALL(pte_t *, __pte_alloc_one_kernel, struct mm_struct *,
unsigned long, gfp_t)
+#define __pte_alloc_one_kernel(mm, addr,
gfp_mask)	BTFIXUP_CALL(pte_alloc_one_kernel)(mm, addr)

 BTFIXUPDEF_CALL(void, free_pte_fast, pte_t *)
 #define pte_free_kernel(mm, pte)	BTFIXUP_CALL(free_pte_fast)(pte)
diff --git a/arch/sparc/include/asm/pgalloc_64.h
b/arch/sparc/include/asm/pgalloc_64.h
index 5bdfa2c..a7952a5 100644
--- a/arch/sparc/include/asm/pgalloc_64.h
+++ b/arch/sparc/include/asm/pgalloc_64.h
@@ -26,9 +26,15 @@ static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)

 #define pud_populate(MM, PUD, PMD)	pud_set(PUD, PMD)

+static inline pmd_t *
+__pmd_alloc_one(struct mm_struct *mm, unsigned long addr, gfp_t gfp_mask)
+{
+	return quicklist_alloc(0, gfp_mask, NULL);
+}
+
 static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
-	return quicklist_alloc(0, GFP_KERNEL, NULL);
+	return __pmd_alloc_one(mm, addr, GFP_KERNEL);
 }

 static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
@@ -36,10 +42,17 @@ static inline void pmd_free(struct mm_struct *mm,
pmd_t *pmd)
 	quicklist_free(0, NULL, pmd);
 }

+static inline pte_t *
+__pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address,
+		gfp_t gfp_mask)
+{
+	return quicklist_alloc(0, gfp_mask, NULL);
+}
+
 static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
 					  unsigned long address)
 {
-	return quicklist_alloc(0, GFP_KERNEL, NULL);
+	return __pte_alloc_one_kernel(mm, address, GFP_KERNEL);
 }

 static inline pgtable_t pte_alloc_one(struct mm_struct *mm,

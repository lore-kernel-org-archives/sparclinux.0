From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 20 Jul 2012 07:55:42 +0000
Subject: [PATCH 7/9] sparc32: drop unused kmap_atomic_to_page
Message-Id: <1342770944-17476-7-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

No users left of this function - drop it.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/highmem.h |    1 -
 arch/sparc/mm/highmem.c          |   18 ------------------
 2 files changed, 0 insertions(+), 19 deletions(-)

diff --git a/arch/sparc/include/asm/highmem.h b/arch/sparc/include/asm/highmem.h
index 3b6e00d..a31b2a1 100644
--- a/arch/sparc/include/asm/highmem.h
+++ b/arch/sparc/include/asm/highmem.h
@@ -72,7 +72,6 @@ static inline void kunmap(struct page *page)
 
 extern void *kmap_atomic(struct page *page);
 extern void __kunmap_atomic(void *kvaddr);
-extern struct page *kmap_atomic_to_page(void *vaddr);
 
 #define flush_cache_kmaps()	flush_cache_all()
 
diff --git a/arch/sparc/mm/highmem.c b/arch/sparc/mm/highmem.c
index 055c66c..856432a 100644
--- a/arch/sparc/mm/highmem.c
+++ b/arch/sparc/mm/highmem.c
@@ -110,21 +110,3 @@ void __kunmap_atomic(void *kvaddr)
 	pagefault_enable();
 }
 EXPORT_SYMBOL(__kunmap_atomic);
-
-/* We may be fed a pagetable here by ptep_to_xxx and others. */
-struct page *kmap_atomic_to_page(void *ptr)
-{
-	unsigned long idx, vaddr = (unsigned long)ptr;
-	pte_t *pte;
-
-	if (vaddr < SRMMU_NOCACHE_VADDR)
-		return virt_to_page(ptr);
-	if (vaddr < PKMAP_BASE)
-		return pfn_to_page(__nocache_pa(vaddr) >> PAGE_SHIFT);
-	BUG_ON(vaddr < FIXADDR_START);
-	BUG_ON(vaddr > FIXADDR_TOP);
-
-	idx = virt_to_fix(vaddr);
-	pte = kmap_pte - (idx - FIX_KMAP_BEGIN);
-	return pte_page(*pte);
-}
-- 
1.6.0.6


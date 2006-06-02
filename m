From: David Miller <davem@davemloft.net>
Date: Fri, 02 Jun 2006 00:52:58 +0000
Subject: [PATCH]: Fix D-cache corruption in mremap() (was Re:
Message-Id: <20060601.175258.41634623.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Thanks to some excellent corrupted status and available files
Daniel sent to me, I was able to track down the bug.  This
bug has been around basically forever, just minor data layout
changes due to arbitrary unrelated kernel and userland library
modifications make the bug go away for some time and then
reappear.  It was always there.

Anyways, give this patch below a test, it should fix things.
It is against the current 2.6.17 tree.

I'll also post a little reproducer program that can be used to
accurately see if the patch really fixes the problem on your
machine or not, which should help with the variability of the
dpkg corruption case.

Please test this, I need to know if this works for everyone
or not.

Thanks.

diff-tree 0b0968a3e691771bf87e1ce747b2c7d23b5526c8 (from 951bc82c53f30ec6b4c2d04a051e74ea9a89b669)
Author: David S. Miller <davem@sunset.sfo1.dsl.speakeasy.net>
Date:   Thu Jun 1 17:47:25 2006 -0700

    [SPARC64]: Fix D-cache corruption in mremap
    
    If we move a mapping from one virtual address to another,
    and this changes the virtual color of the mapping to those
    pages, we can see corrupt data due to D-cache aliasing.
    
    Check for and deal with this by overriding the move_pte()
    macro.  Set things up so that other platforms can cleanly
    override the move_pte() macro too.
    
    Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index 358e4d3..c2059a3 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -159,17 +159,8 @@ static inline void ptep_set_wrprotect(st
 #define lazy_mmu_prot_update(pte)	do { } while (0)
 #endif
 
-#ifndef __HAVE_ARCH_MULTIPLE_ZERO_PAGE
+#ifndef __HAVE_ARCH_MOVE_PTE
 #define move_pte(pte, prot, old_addr, new_addr)	(pte)
-#else
-#define move_pte(pte, prot, old_addr, new_addr)				\
-({									\
- 	pte_t newpte = (pte);						\
-	if (pte_present(pte) && pfn_valid(pte_pfn(pte)) &&		\
-			pte_page(pte) = ZERO_PAGE(old_addr))		\
-		newpte = mk_pte(ZERO_PAGE(new_addr), (prot));		\
-	newpte;								\
-})
 #endif
 
 /*
diff --git a/include/asm-mips/pgtable.h b/include/asm-mips/pgtable.h
index 702a28f..69cebbd 100644
--- a/include/asm-mips/pgtable.h
+++ b/include/asm-mips/pgtable.h
@@ -70,7 +70,15 @@ extern unsigned long zero_page_mask;
 #define ZERO_PAGE(vaddr) \
 	(virt_to_page(empty_zero_page + (((unsigned long)(vaddr)) & zero_page_mask)))
 
-#define __HAVE_ARCH_MULTIPLE_ZERO_PAGE
+#define __HAVE_ARCH_MOVE_PTE
+#define move_pte(pte, prot, old_addr, new_addr)				\
+({									\
+ 	pte_t newpte = (pte);						\
+	if (pte_present(pte) && pfn_valid(pte_pfn(pte)) &&		\
+			pte_page(pte) = ZERO_PAGE(old_addr))		\
+		newpte = mk_pte(ZERO_PAGE(new_addr), (prot));		\
+	newpte;								\
+})
 
 extern void paging_init(void);
 
diff --git a/include/asm-sparc64/pgtable.h b/include/asm-sparc64/pgtable.h
index c44e746..cd464f4 100644
--- a/include/asm-sparc64/pgtable.h
+++ b/include/asm-sparc64/pgtable.h
@@ -689,6 +689,23 @@ static inline void set_pte_at(struct mm_
 #define pte_clear(mm,addr,ptep)		\
 	set_pte_at((mm), (addr), (ptep), __pte(0UL))
 
+#ifdef DCACHE_ALIASING_POSSIBLE
+#define __HAVE_ARCH_MOVE_PTE
+#define move_pte(pte, prot, old_addr, new_addr)				\
+({									\
+ 	pte_t newpte = (pte);						\
+	if (tlb_type != hypervisor && pte_present(pte)) {		\
+		unsigned long this_pfn = pte_pfn(pte);			\
+									\
+		if (pfn_valid(this_pfn) &&				\
+		    (((old_addr) ^ (new_addr)) & (1 << 13)))		\
+			flush_dcache_page_all(current->mm,		\
+					      pfn_to_page(this_pfn));	\
+	}								\
+	newpte;								\
+})
+#endif
+
 extern pgd_t swapper_pg_dir[2048];
 extern pmd_t swapper_low_pmd_dir[2048];
 

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date: Fri, 09 Dec 2016 11:24:00 +0000
Subject: [PATCH] sparc64: fix typo in pgd_clear()
Message-Id: <20161209112400.72500-1-kirill.shutemov@linux.intel.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

It really has to be pgdp, not pgd.

It just happend to work since all callers have 'pgd' as an argument.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/sparc/include/asm/pgtable_64.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index 1fb317fbc0b3..314b66851348 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -826,7 +826,7 @@ static inline unsigned long __pmd_page(pmd_t pmd)
 #define pgd_page_vaddr(pgd)		\
 	((unsigned long) __va(pgd_val(pgd)))
 #define pgd_present(pgd)		(pgd_val(pgd) != 0U)
-#define pgd_clear(pgdp)			(pgd_val(*(pgd)) = 0UL)
+#define pgd_clear(pgdp)			(pgd_val(*(pgdp)) = 0UL)
 
 static inline unsigned long pud_large(pud_t pud)
 {
-- 
2.10.2


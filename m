From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 26 Jul 2012 21:02:25 +0000
Subject: [PATCH 15/18] sparc32: drop unused BAD_PAGE stuff
Message-Id: <1343336548-3879-15-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/pgtable_32.h |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
index 97a4880..6fc1348 100644
--- a/arch/sparc/include/asm/pgtable_32.h
+++ b/arch/sparc/include/asm/pgtable_32.h
@@ -87,18 +87,11 @@ extern unsigned long phys_base;
 extern unsigned long pfn_base;
 
 /*
- * BAD_PAGETABLE is used when we need a bogus page-table, while
- * BAD_PAGE is used for a bogus page.
- *
  * ZERO_PAGE is a global shared page that is always zero: used
  * for zero-mapped memory areas etc..
  */
-extern pte_t * __bad_pagetable(void);
-extern pte_t __bad_page(void);
 extern unsigned long empty_zero_page;
 
-#define BAD_PAGETABLE __bad_pagetable()
-#define BAD_PAGE __bad_page()
 #define ZERO_PAGE(vaddr) (virt_to_page(&empty_zero_page))
 
 /*
-- 
1.6.0.6


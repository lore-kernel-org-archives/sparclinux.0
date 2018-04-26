From: Zi Yan <zi.yan@sent.com>
Date: Thu, 26 Apr 2018 14:28:03 +0000
Subject: [RFC PATCH 8/9] sparc: mm: migrate: add pmd swap entry to support thp migration.
Message-Id: <20180426142804.180152-9-zi.yan@sent.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20180426142804.180152-1-zi.yan@sent.com>
In-Reply-To: <20180426142804.180152-1-zi.yan@sent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Zi Yan <zi.yan@cs.rutgers.edu>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

From: Zi Yan <zi.yan@cs.rutgers.edu>

Signed-off-by: Zi Yan <zi.yan@cs.rutgers.edu>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Cc: linux-mm@kvack.org
---
 arch/sparc/include/asm/pgtable_32.h | 2 ++
 arch/sparc/include/asm/pgtable_64.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
index 4eebed6c6781..293bf9f8f949 100644
--- a/arch/sparc/include/asm/pgtable_32.h
+++ b/arch/sparc/include/asm/pgtable_32.h
@@ -367,7 +367,9 @@ static inline swp_entry_t __swp_entry(unsigned long type, unsigned long offset)
 }
 
 #define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val(pte) })
+#define __pmd_to_swp_entry(pmd)		((swp_entry_t) { pmd_val(pmd) })
 #define __swp_entry_to_pte(x)		((pte_t) { (x).val })
+#define __swp_entry_to_pmd(x)		((pmd_t) { (x).val })
 
 static inline unsigned long
 __get_phys (unsigned long addr)
diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index 339920fdf9ed..2811aef4a636 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -1031,7 +1031,9 @@ pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp);
                  ((long)(offset) << (PAGE_SHIFT + 8UL))) \
 	  } )
 #define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val(pte) })
+#define __pmd_to_swp_entry(pmd)		((swp_entry_t) { pmd_val(pmd) })
 #define __swp_entry_to_pte(x)		((pte_t) { (x).val })
+#define __swp_entry_to_pmd(x)		((pmd_t) { (x).val })
 
 int page_in_phys_avail(unsigned long paddr);
 
-- 
2.17.0


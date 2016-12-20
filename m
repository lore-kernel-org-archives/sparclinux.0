From: Mike Kravetz <mike.kravetz@oracle.com>
Date: Tue, 20 Dec 2016 03:17:08 +0000
Subject: [PATCH] sparc: use symbolic names for tsb indexing
Message-Id: <1482203828-22017-1-git-send-email-mike.kravetz@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>, Sam Ravnborg <sam@ravnborg.org>, Mike Kravetz <mike.kravetz@oracle.com>

Use symbolic names MM_TSB_BASE and MM_TSB_HUGE instead of numeric values
0 and 1 in __tsb_context_switch.  Code cleanup only, no functional change.

Suggested-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 arch/sparc/include/asm/mmu_context_64.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/include/asm/mmu_context_64.h b/arch/sparc/include/asm/mmu_context_64.h
index b84be67..d031799 100644
--- a/arch/sparc/include/asm/mmu_context_64.h
+++ b/arch/sparc/include/asm/mmu_context_64.h
@@ -35,15 +35,15 @@ void __tsb_context_switch(unsigned long pgd_pa,
 static inline void tsb_context_switch(struct mm_struct *mm)
 {
 	__tsb_context_switch(__pa(mm->pgd),
-			     &mm->context.tsb_block[0],
+			     &mm->context.tsb_block[MM_TSB_BASE],
 #if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)
-			     (mm->context.tsb_block[1].tsb ?
-			      &mm->context.tsb_block[1] :
+			     (mm->context.tsb_block[MM_TSB_HUGE].tsb ?
+			      &mm->context.tsb_block[MM_TSB_HUGE] :
 			      NULL)
 #else
 			     NULL
 #endif
-			     , __pa(&mm->context.tsb_descr[0]));
+			     , __pa(&mm->context.tsb_descr[MM_TSB_BASE]));
 }
 
 void tsb_grow(struct mm_struct *mm,
-- 
2.7.4


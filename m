From: Herton Ronaldo Krzesinski <herton.krzesinski@canonical.com>
Date: Wed, 16 Jan 2013 15:56:21 +0000
Subject: [PATCH 181/222] sparc: huge_ptep_set_* functions need to call set_huge_pte_at()
Message-Id: <1358351822-7675-182-git-send-email-herton.krzesinski@canonical.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1358351822-7675-1-git-send-email-herton.krzesinski@canonical.com>
In-Reply-To: <1358351822-7675-1-git-send-email-herton.krzesinski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org, kernel-team@lists.ubuntu.com
Cc: Dave Kleikamp <dave.kleikamp@oracle.com>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Herton Ronaldo Krzesinski <herton.krzesinski@canonical.com>

3.5.7.3 -stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Kleikamp <dave.kleikamp@oracle.com>

commit 6cb9c3697585c47977c42c5cc1b9fc49247ac530 upstream.

Modifying the huge pte's requires that all the underlying pte's be
modified.

Version 2: added missing flush_tlb_page()

Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Herton Ronaldo Krzesinski <herton.krzesinski@canonical.com>
---
 arch/sparc/include/asm/hugetlb.h |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/include/asm/hugetlb.h b/arch/sparc/include/asm/hugetlb.h
index 1770610..f368cef 100644
--- a/arch/sparc/include/asm/hugetlb.h
+++ b/arch/sparc/include/asm/hugetlb.h
@@ -58,14 +58,20 @@ static inline pte_t huge_pte_wrprotect(pte_t pte)
 static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
 					   unsigned long addr, pte_t *ptep)
 {
-	ptep_set_wrprotect(mm, addr, ptep);
+	pte_t old_pte = *ptep;
+	set_huge_pte_at(mm, addr, ptep, pte_wrprotect(old_pte));
 }
 
 static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 					     unsigned long addr, pte_t *ptep,
 					     pte_t pte, int dirty)
 {
-	return ptep_set_access_flags(vma, addr, ptep, pte, dirty);
+	int changed = !pte_same(*ptep, pte);
+	if (changed) {
+		set_huge_pte_at(vma->vm_mm, addr, ptep, pte);
+		flush_tlb_page(vma, addr);
+	}
+	return changed;
 }
 
 static inline pte_t huge_ptep_get(pte_t *ptep)
-- 
1.7.9.5


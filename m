From: Dave Kleikamp <dave.kleikamp@oracle.com>
Date: Mon, 17 Dec 2012 17:52:47 +0000
Subject: [PATCH v2] sparc: huge_ptep_set_* functions need to call set_huge_pte_at()
Message-Id: <50CF5BEF.9080009@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 12/16/2012 10:52 AM, David Miller wrote:
> From: Dave Kleikamp <dave.kleikamp@oracle.com>
> Date: Fri, 14 Dec 2012 15:02:00 -0600
> 
>>  static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
>>  					     unsigned long addr, pte_t *ptep,
>>  					     pte_t pte, int dirty)
>>  {
>> -	return ptep_set_access_flags(vma, addr, ptep, pte, dirty);
>> +	int changed = !pte_same(*ptep, pte);
>> +	if (changed)
>> +		set_huge_pte_at(vma->vm_mm, addr, ptep, pte);
>> +	return changed;
>>  }
>>  
>>  static inline pte_t huge_ptep_get(pte_t *ptep)
> 
> This lacks the TLB flush after setting the pte, which is really
> needed.

Modifying the huge pte's requires that all the underlying pte's be
modified.

Version 2: added missing flush_tlb_page()

Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
---
 arch/sparc/include/asm/hugetlb.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/include/asm/hugetlb.h b/arch/sparc/include/asm/hugetlb.h
index 8c5eed6..9661e9b 100644
--- a/arch/sparc/include/asm/hugetlb.h
+++ b/arch/sparc/include/asm/hugetlb.h
@@ -61,14 +61,20 @@ static inline pte_t huge_pte_wrprotect(pte_t pte)
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
1.8.0.1


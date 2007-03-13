From: David Miller <davem@davemloft.net>
Date: Tue, 13 Mar 2007 05:58:04 +0000
Subject: Re: libhugetlbfs and sparc64 support
Message-Id: <20070312.225804.74747670.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070312183920.GD29949@us.ibm.com>
In-Reply-To: <20070312183920.GD29949@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Nishanth Aravamudan <nacc@us.ibm.com>
Date: Mon, 12 Mar 2007 14:12:40 -0700

> On 12.03.2007 [13:40:28 -0700], David Miller wrote:
> > I'll try to take a look at this, thanks.
> 
> Really appreciated.

This patch below seems to improve the situation for me
on my SunBlade1500, let me know if you can get farther
on your Ultra60.

This points out a big pet-peeve I have with all of
these hugetlb page table interfaces, every single
platform has the HPAGE_MASK the address parameter,
and missing that is how I keep getting burnt with
hugetlb bugs on sparc64.

I really think the callers should be doing this.

commit bb8236f2b978e8ed84e8b664882905fb5a7dd6c8
Author: David S. Miller <davem@sunset.davemloft.net>
Date:   Mon Mar 12 22:55:39 2007 -0700

    [SPARC64]: Add missing HPAGE_MASK masks on address parameters.
    
    These pte loops all assume the passed in address is HPAGE
    aligned, make sure that is actually true.
    
    Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/arch/sparc64/mm/hugetlbpage.c b/arch/sparc64/mm/hugetlbpage.c
index 33fd0b2..00677b5 100644
--- a/arch/sparc64/mm/hugetlbpage.c
+++ b/arch/sparc64/mm/hugetlbpage.c
@@ -248,6 +248,7 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 	if (!pte_present(*ptep) && pte_present(entry))
 		mm->context.huge_pte_count++;
 
+	addr &= HPAGE_MASK;
 	for (i = 0; i < (1 << HUGETLB_PAGE_ORDER); i++) {
 		set_pte_at(mm, addr, ptep, entry);
 		ptep++;
@@ -266,6 +267,8 @@ pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
 	if (pte_present(entry))
 		mm->context.huge_pte_count--;
 
+	addr &= HPAGE_MASK;
+
 	for (i = 0; i < (1 << HUGETLB_PAGE_ORDER); i++) {
 		pte_clear(mm, addr, ptep);
 		addr += PAGE_SIZE;

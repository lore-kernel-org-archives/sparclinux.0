From: David Miller <davem@davemloft.net>
Date: Mon, 17 Dec 2012 19:17:14 +0000
Subject: Re: [PATCH v2] sparc: huge_ptep_set_* functions need to call set_huge_pte_at()
Message-Id: <20121217.111714.1506610775700563421.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <50CF5BEF.9080009@oracle.com>
In-Reply-To: <50CF5BEF.9080009@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Dave Kleikamp <dave.kleikamp@oracle.com>
Date: Mon, 17 Dec 2012 11:52:47 -0600

> On 12/16/2012 10:52 AM, David Miller wrote:
>> From: Dave Kleikamp <dave.kleikamp@oracle.com>
>> Date: Fri, 14 Dec 2012 15:02:00 -0600
>> 
>>>  static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
>>>  					     unsigned long addr, pte_t *ptep,
>>>  					     pte_t pte, int dirty)
>>>  {
>>> -	return ptep_set_access_flags(vma, addr, ptep, pte, dirty);
>>> +	int changed = !pte_same(*ptep, pte);
>>> +	if (changed)
>>> +		set_huge_pte_at(vma->vm_mm, addr, ptep, pte);
>>> +	return changed;
>>>  }
>>>  
>>>  static inline pte_t huge_ptep_get(pte_t *ptep)
>> 
>> This lacks the TLB flush after setting the pte, which is really
>> needed.
> 
> Modifying the huge pte's requires that all the underlying pte's be
> modified.
> 
> Version 2: added missing flush_tlb_page()
> 
> Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>

Please don't submit new versions of patches as a reply like this.

Always submit new patches as fresh list postings, that way the
maintainer doesn't have to edit out all of the unnecessary
reply verbiage from the resulting commit message during checkin.

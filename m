From: Dave Kleikamp <dave.kleikamp@oracle.com>
Date: Mon, 17 Dec 2012 18:44:23 +0000
Subject: Re: [PATCH v2] sparc: huge_ptep_set_* functions need to call set_huge_pte_at()
Message-Id: <50CF6807.2060200@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <50CF5BEF.9080009@oracle.com>
In-Reply-To: <50CF5BEF.9080009@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 12/17/2012 12:24 PM, Josip Rodin wrote:
> On Mon, Dec 17, 2012 at 11:52:47AM -0600, Dave Kleikamp wrote:
>>  static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
>>  					     unsigned long addr, pte_t *ptep,
>>  					     pte_t pte, int dirty)
>>  {
>> -	return ptep_set_access_flags(vma, addr, ptep, pte, dirty);
>> +	int changed = !pte_same(*ptep, pte);
>> +	if (changed) {
>> +		set_huge_pte_at(vma->vm_mm, addr, ptep, pte);
>> +		flush_tlb_page(vma, addr);
>> +	}
>> +	return changed;
>>  }
> 
> I've no idea what this really does, but I noticed that you are ignoring the
> 'dirty' parameter in the new version. If it's irrelevant, maybe make a note
> of it to avoid the impression it got lost?

It seems x86 is the only architecture that pays any attention to this
flag. ptep_set_access_flags() ignores it as well.

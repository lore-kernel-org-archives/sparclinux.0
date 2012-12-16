From: David Miller <davem@davemloft.net>
Date: Sun, 16 Dec 2012 16:52:09 +0000
Subject: Re: [PATCH] sparc: huge_ptep_set_* functions need to call set_huge_pte_at()
Message-Id: <20121216.085209.1144113123941715592.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <50CB93C8.8010802@oracle.com>
In-Reply-To: <50CB93C8.8010802@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Dave Kleikamp <dave.kleikamp@oracle.com>
Date: Fri, 14 Dec 2012 15:02:00 -0600

>  static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
>  					     unsigned long addr, pte_t *ptep,
>  					     pte_t pte, int dirty)
>  {
> -	return ptep_set_access_flags(vma, addr, ptep, pte, dirty);
> +	int changed = !pte_same(*ptep, pte);
> +	if (changed)
> +		set_huge_pte_at(vma->vm_mm, addr, ptep, pte);
> +	return changed;
>  }
>  
>  static inline pte_t huge_ptep_get(pte_t *ptep)

This lacks the TLB flush after setting the pte, which is really
needed.


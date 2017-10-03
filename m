From: Michal Hocko <mhocko@kernel.org>
Date: Tue, 03 Oct 2017 12:59:40 +0000
Subject: Re: [PATCH v9 04/12] sparc64: simplify vmemmap_populate
Message-Id: <20171003125940.6d5fyhwx2lkzxn67@dhcp22.suse.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <20170920201714.19817-1-pasha.tatashin@oracle.com>
 <20170920201714.19817-5-pasha.tatashin@oracle.com>
In-Reply-To: <20170920201714.19817-5-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed 20-09-17 16:17:06, Pavel Tatashin wrote:
> Remove duplicating code by using common functions
> vmemmap_pud_populate and vmemmap_pgd_populate.
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> Reviewed-by: Steven Sistare <steven.sistare@oracle.com>
> Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
> Reviewed-by: Bob Picco <bob.picco@oracle.com>
> Acked-by: David S. Miller <davem@davemloft.net>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  arch/sparc/mm/init_64.c | 23 ++++++-----------------
>  1 file changed, 6 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
> index 310c6754bcaa..99aea4d15a5f 100644
> --- a/arch/sparc/mm/init_64.c
> +++ b/arch/sparc/mm/init_64.c
> @@ -2651,30 +2651,19 @@ int __meminit vmemmap_populate(unsigned long vstart, unsigned long vend,
>  	vstart = vstart & PMD_MASK;
>  	vend = ALIGN(vend, PMD_SIZE);
>  	for (; vstart < vend; vstart += PMD_SIZE) {
> -		pgd_t *pgd = pgd_offset_k(vstart);
> +		pgd_t *pgd = vmemmap_pgd_populate(vstart, node);
>  		unsigned long pte;
>  		pud_t *pud;
>  		pmd_t *pmd;
>  
> -		if (pgd_none(*pgd)) {
> -			pud_t *new = vmemmap_alloc_block(PAGE_SIZE, node);
> +		if (!pgd)
> +			return -ENOMEM;
>  
> -			if (!new)
> -				return -ENOMEM;
> -			pgd_populate(&init_mm, pgd, new);
> -		}
> -
> -		pud = pud_offset(pgd, vstart);
> -		if (pud_none(*pud)) {
> -			pmd_t *new = vmemmap_alloc_block(PAGE_SIZE, node);
> -
> -			if (!new)
> -				return -ENOMEM;
> -			pud_populate(&init_mm, pud, new);
> -		}
> +		pud = vmemmap_pud_populate(pgd, vstart, node);
> +		if (!pud)
> +			return -ENOMEM;
>  
>  		pmd = pmd_offset(pud, vstart);
> -
>  		pte = pmd_val(*pmd);
>  		if (!(pte & _PAGE_VALID)) {
>  			void *block = vmemmap_alloc_block(PMD_SIZE, node);
> -- 
> 2.14.1

-- 
Michal Hocko
SUSE Labs

From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 20 Dec 2012 06:34:44 +0000
Subject: Re: [PATCH] sparc64: Define pte_accessible()
Message-Id: <20121220063444.GA21241@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20121219.154334.335294150358192263.davem@davemloft.net>
In-Reply-To: <20121219.154334.335294150358192263.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Dec 19, 2012 at 03:43:34PM -0800, David Miller wrote:
> 
> We can elide flush_tlb_*() calls when _PAGE_VALID is clear
> as that is the test used to determine whether or not to
> queue up a TLB flush in set_pte_at().

I was a bit puzzeled about this change until I noticed this is an override.
And we use pte_accessible in generic code.

> 
> Signed-off-by: David S. Miller <davem@davemloft.net>
> ---
>  arch/sparc/include/asm/pgtable_64.h | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
> index 95515f1..7870be0 100644
> --- a/arch/sparc/include/asm/pgtable_64.h
> +++ b/arch/sparc/include/asm/pgtable_64.h
> @@ -617,6 +617,12 @@ static inline unsigned long pte_present(pte_t pte)
>  	return val;
>  }
>  
> +#define pte_accessible pte_accessible
> +static inline unsigned long pte_accessible(pte_t a)
> +{
> +	return pte_val(a) & _PAGE_VALID;
> +}
> +
>  static inline unsigned long pte_special(pte_t pte)
>  {
>  	return pte_val(pte) & _PAGE_SPECIAL;
> @@ -802,7 +808,7 @@ static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
>  	 * SUN4V NOTE: _PAGE_VALID is the same value in both the SUN4U
>  	 *             and SUN4V pte layout, so this inline test is fine.
>  	 */
The comment above belongs to the pte_accessible function now.

> -	if (likely(mm != &init_mm) && (pte_val(orig) & _PAGE_VALID))
> +	if (likely(mm != &init_mm) && pte_accessible(orig))
>  		tlb_batch_add(mm, addr, ptep, orig, fullmm);
>  }

	Sam

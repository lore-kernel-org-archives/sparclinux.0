From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 14 May 2014 19:55:55 +0000
Subject: Re: [PATCH 23/27] sparc: Use common bits from generic tlb.h
Message-Id: <20140514195555.GA2801@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1400093999-18703-1-git-send-email-richard@nod.at>
 <1400093999-18703-24-git-send-email-richard@nod.at>
In-Reply-To: <1400093999-18703-24-git-send-email-richard@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Weinberger <richard@nod.at>
Cc: linux-arch@vger.kernel.org, arnd@arndb.de, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

On Wed, May 14, 2014 at 08:59:55PM +0200, Richard Weinberger wrote:
> It is no longer needed to define them on our own.
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: sparclinux@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  arch/sparc/include/asm/tlb_32.h | 8 --------
>  arch/sparc/include/asm/tlb_64.h | 3 ---
>  2 files changed, 11 deletions(-)
> 
> diff --git a/arch/sparc/include/asm/tlb_32.h b/arch/sparc/include/asm/tlb_32.h
> index 6d02d1c..60641a1 100644
> --- a/arch/sparc/include/asm/tlb_32.h
> +++ b/arch/sparc/include/asm/tlb_32.h
> @@ -11,14 +11,6 @@ do {								\
>  	flush_tlb_range(vma, vma->vm_start, vma->vm_end);	\
>  } while (0)
>  
> -#define __tlb_remove_tlb_entry(tlb, pte, address) \
> -	do { } while (0)
> -
> -#define tlb_flush(tlb) \
> -do {								\
> -	flush_tlb_mm((tlb)->mm);				\
> -} while (0)
> -
>  #include <asm-generic/tlb.h>
>  
>  #endif /* _SPARC_TLB_H */

This part looks OK.

> diff --git a/arch/sparc/include/asm/tlb_64.h b/arch/sparc/include/asm/tlb_64.h
> index 190e189..36fdcec 100644
> --- a/arch/sparc/include/asm/tlb_64.h
> +++ b/arch/sparc/include/asm/tlb_64.h
> @@ -22,9 +22,6 @@ extern void smp_flush_tlb_mm(struct mm_struct *mm);
>  extern void __flush_tlb_pending(unsigned long, unsigned long, unsigned long *);
>  extern void flush_tlb_pending(void);
>  
> -#define tlb_start_vma(tlb, vma) do { } while (0)
> -#define tlb_end_vma(tlb, vma)	do { } while (0)
> -#define __tlb_remove_tlb_entry(tlb, ptep, address) do { } while (0)
>  #define tlb_flush(tlb)	flush_tlb_pending()
>  
>  #include <asm-generic/tlb.h>

This does not fly for sparc64.
__pte_free_tlb is a static inline in pgalloc_64.h so no
define exist to teach tlb.h that an arch override exist.

Likewise for __pmd_free_tlb

	Sam

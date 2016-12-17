From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 17 Dec 2016 07:38:13 +0000
Subject: Re: [RFC PATCH 02/14] sparc64: add new fields to mmu context for shared context support
Message-Id: <20161217073813.GB23567@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1481913337-9331-1-git-send-email-mike.kravetz@oracle.com>
 <1481913337-9331-3-git-send-email-mike.kravetz@oracle.com>
In-Reply-To: <1481913337-9331-3-git-send-email-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Kravetz <mike.kravetz@oracle.com>
Cc: sparclinux@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Bob Picco <bob.picco@oracle.com>, Nitin Gupta <nitin.m.gupta@oracle.com>, Vijay Kumar <vijay.ac.kumar@oracle.com>, Julian Calaby <julian.calaby@gmail.com>, Adam Buchbinder <adam.buchbinder@gmail.com>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>

Hi Mike

> diff --git a/arch/sparc/include/asm/mmu_context_64.h b/arch/sparc/include/asm/mmu_context_64.h
> index b84be67..d031799 100644
> --- a/arch/sparc/include/asm/mmu_context_64.h
> +++ b/arch/sparc/include/asm/mmu_context_64.h
> @@ -35,15 +35,15 @@ void __tsb_context_switch(unsigned long pgd_pa,
>  static inline void tsb_context_switch(struct mm_struct *mm)
>  {
>  	__tsb_context_switch(__pa(mm->pgd),
> -			     &mm->context.tsb_block[0],
> +			     &mm->context.tsb_block[MM_TSB_BASE],
>  #if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)
> -			     (mm->context.tsb_block[1].tsb ?
> -			      &mm->context.tsb_block[1] :
> +			     (mm->context.tsb_block[MM_TSB_HUGE].tsb ?
> +			      &mm->context.tsb_block[MM_TSB_HUGE] :
>  			      NULL)
>  #else
>  			     NULL
>  #endif
> -			     , __pa(&mm->context.tsb_descr[0]));
> +			     , __pa(&mm->context.tsb_descr[MM_TSB_BASE]));
>  }
>  
This is a nice cleanup that has nothing to do with your series.
Could you submit this as a separate patch so we can get it applied.

This is the only place left where the array index for tsb_block
and tsb_descr uses hardcoded values. And it would be good to get
rid of these.

	Sam

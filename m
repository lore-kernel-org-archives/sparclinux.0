From: Pete Zaitcev <zaitcev@redhat.com>
Date: Tue, 06 Jan 2004 04:55:44 +0000
Subject: Re: [SPARC32] Fix BUG-on-swapout
Message-Id: <20040106045544.GA26852@devserv.devel.redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040106040805.GA13026@foobazco.org>
In-Reply-To: <20040106040805.GA13026@foobazco.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Jan 05, 2004 at 08:08:05PM -0800, Keith M Wesolowski wrote:
> 
> This fixes BUG-on-swapout for srmmu-based systems.  The problem is
> caused by kmap_atomic_to_page being fed an aliased (pagetable) address
> and returning bogons.  This also adjusts the pkmap and fixmap base
> addresses so they cannot overlap.

Go, Keith!

> --- 2.5-sparc/arch/sparc/mm/fault.c	Sat Jan  3 02:08:08 2004
> +++ 2.5-sparc-smp/arch/sparc/mm/fault.c	Sat Jan  3 02:11:02 2004
> @@ -36,7 +36,7 @@
>  
>  #define ELEMENTS(arr) (sizeof (arr)/sizeof (arr[0]))
>  
> -extern struct sparc_phys_banks sp_banks[SPARC_PHYS_BANKS];
> +extern struct sparc_phys_banks sp_banks[SPARC_PHYS_BANKS+1];
>  extern int prom_node_root;
>  
>  /* At boot time we determine these two values necessary for setting

> --- 2.5-sparc/include/asm-sparc/page.h	Sat Jan  3 02:08:30 2004
> +++ 2.5-sparc-smp/include/asm-sparc/page.h	Sat Jan  3 02:11:28 2004
> @@ -54,7 +54,7 @@
>  
>  #define SPARC_PHYS_BANKS 32
>  
> -extern struct sparc_phys_banks sp_banks[SPARC_PHYS_BANKS];
> +extern struct sparc_phys_banks sp_banks[SPARC_PHYS_BANKS+1];
>  
>  /* Cache alias structure.  Entry is valid if context != -1. */
>  struct cache_palias {

Seems that the first one can be just removed altogether,
since you're on it.

> --- 2.5-sparc/include/asm-sparc/kmap_types.h	Sat Jan  3 02:08:30 2004
> +++ 2.5-sparc-smp/include/asm-sparc/kmap_types.h	Sat Jan  3 02:11:28 2004
> @@ -11,6 +11,7 @@
>  	KM_BIO_DST_IRQ,
>  	KM_PTE0,
>  	KM_PTE1,
> +	KM_PTE2,
>  	KM_IRQ0,
>  	KM_IRQ1,
>  	KM_SOFTIRQ0,

Is this needed for anything?

-- Pete

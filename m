From: Christoph Hellwig <hch@infradead.org>
Date: Sun, 26 Apr 2020 07:26:42 +0000
Subject: Re: [PATCH 4/5] arch/kmap_atomic: Consolidate duplicate code
Message-Id: <20200426072642.GB22024@infradead.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20200426055406.134198-1-ira.weiny@intel.com>
 <20200426055406.134198-5-ira.weiny@intel.com>
In-Reply-To: <20200426055406.134198-5-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ira.weiny@intel.com
Cc: Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Dave Hansen <dave.hansen@linux.intel.com>, linux-mips@vger.kernel.org, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Helge Deller <deller@gmx.de>, x86@kernel.org, linux-csky@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Chris Zankel <chris@zankel.net>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>

> diff --git a/arch/arc/mm/highmem.c b/arch/arc/mm/highmem.c
> index 4db13a6b9f3b..1cae4b911a33 100644
> --- a/arch/arc/mm/highmem.c
> +++ b/arch/arc/mm/highmem.c
> @@ -53,11 +53,10 @@ void *kmap_atomic(struct page *page)
>  {
>  	int idx, cpu_idx;
>  	unsigned long vaddr;
> +	void *addr = kmap_atomic_fast(page);
>  
> -	preempt_disable();
> -	pagefault_disable();
> -	if (!PageHighMem(page))
> -		return page_address(page);
> +	if (addr)
> +		return addr;

Wouldn't it make sense to just move kmap_atomic itelf to common code,
and call out to a kmap_atomic_high for the highmem case, following the
scheme in kmap?  Same for the unmap side.  That might require to support
kmap_atomic_prot everywhere first, which sounds like a really good
idea anyway, and would avoid the need for strange workaround in drm.

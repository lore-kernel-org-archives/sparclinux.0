From: Baoquan He <bhe@redhat.com>
Date: Thu, 30 Jul 2020 01:52:21 +0000
Subject: Re: [PATCH 09/15] memblock: make for_each_memblock_type() iterator private
Message-Id: <20200730015221.GI14854@MiWiFi-R3L-srv>
List-Id: <sparclinux.vger.kernel.org>
References: <20200728051153.1590-1-rppt@kernel.org>
 <20200728051153.1590-10-rppt@kernel.org>
In-Reply-To: <20200728051153.1590-10-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Dave Hansen <dave.hansen@linux.intel.com>, linux-mips@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, Will Deacon <will@kernel.org>, Stafford Horne <shorne@gmail.com>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, Mike Rapoport <rppt@linux.ibm.com>, clang-built-linux@googlegroups.com, Ingo Molnar <mingo@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, uclinux-h8-devel@lists.sourceforge.jp, linux-xtensa@linux-xtensa.org, openrisc@lists.librecores.org, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Michal Simek <monstr@monstr.eu>, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Palmer Dabbelt <palmer@dabbelt.com>, Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>

On 07/28/20 at 08:11am, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> for_each_memblock_type() is not used outside mm/memblock.c, move it there
> from include/linux/memblock.h
> 
> ---
>  include/linux/memblock.h | 5 -----
>  mm/memblock.c            | 5 +++++
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index 017fae833d4a..220b5f0dad42 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -532,11 +532,6 @@ static inline unsigned long memblock_region_reserved_end_pfn(const struct memblo
>  	     region < (memblock.memblock_type.regions + memblock.memblock_type.cnt);	\
>  	     region++)
>  
> -#define for_each_memblock_type(i, memblock_type, rgn)			\
> -	for (i = 0, rgn = &memblock_type->regions[0];			\
> -	     i < memblock_type->cnt;					\
> -	     i++, rgn = &memblock_type->regions[i])
> -
>  extern void *alloc_large_system_hash(const char *tablename,
>  				     unsigned long bucketsize,
>  				     unsigned long numentries,
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 39aceafc57f6..a5b9b3df81fc 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -129,6 +129,11 @@ struct memblock memblock __initdata_memblock = {
>  	.current_limit		= MEMBLOCK_ALLOC_ANYWHERE,
>  };
>  
> +#define for_each_memblock_type(i, memblock_type, rgn)			\
> +	for (i = 0, rgn = &memblock_type->regions[0];			\
> +	     i < memblock_type->cnt;					\
> +	     i++, rgn = &memblock_type->regions[i])
> +

Reviewed-by: Baoquan He <bhe@redhat.com>

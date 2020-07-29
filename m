From: Stafford Horne <shorne@gmail.com>
Date: Wed, 29 Jul 2020 11:41:57 +0000
Subject: Re: [PATCH 05/15] h8300, nds32, openrisc: simplify detection of memory extents
Message-Id: <20200729114157.GF80756@lianli.shorne-pla.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20200728051153.1590-1-rppt@kernel.org>
 <20200728051153.1590-6-rppt@kernel.org>
In-Reply-To: <20200728051153.1590-6-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Dave Hansen <dave.hansen@linux.intel.com>, linux-mips@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, Mike Rapoport <rppt@linux.ibm.com>, clang-built-linux@googlegroups.com, Ingo Molnar <mingo@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, uclinux-h8-devel@lists.sourceforge.jp, linux-xtensa@linux-xtensa.org, openrisc@lists.librecores.org, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Michal Simek <monstr@monstr.eu>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Palmer Dabbelt <palmer@dabbelt.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org

On Tue, Jul 28, 2020 at 08:11:43AM +0300, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Instead of traversing memblock.memory regions to find memory_start and
> memory_end, simply query memblock_{start,end}_of_DRAM().
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/h8300/kernel/setup.c    | 8 +++-----
>  arch/nds32/kernel/setup.c    | 8 ++------
>  arch/openrisc/kernel/setup.c | 9 ++-------
>  3 files changed, 7 insertions(+), 18 deletions(-)

Hi Mike,

For the openrisc part:

Acked-by: Stafford Horne <shorne@gmail.com>

> --- a/arch/openrisc/kernel/setup.c
> +++ b/arch/openrisc/kernel/setup.c
> @@ -48,17 +48,12 @@ static void __init setup_memory(void)
>  	unsigned long ram_start_pfn;
>  	unsigned long ram_end_pfn;
>  	phys_addr_t memory_start, memory_end;
> -	struct memblock_region *region;
>  
>  	memory_end = memory_start = 0;
>  
>  	/* Find main memory where is the kernel, we assume its the only one */
> -	for_each_memblock(memory, region) {
> -		memory_start = region->base;
> -		memory_end = region->base + region->size;
> -		printk(KERN_INFO "%s: Memory: 0x%x-0x%x\n", __func__,
> -		       memory_start, memory_end);
> -	}
> +	memory_start = memblock_start_of_DRAM();
> +	memory_end = memblock_end_of_DRAM();
>  
>  	if (!memory_end) {
>  		panic("No memory!");
> -- 
> 2.26.2
> 

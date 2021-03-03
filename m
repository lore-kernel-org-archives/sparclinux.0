From: Andreas Larsson <andreas@gaisler.com>
Date: Wed, 03 Mar 2021 08:19:38 +0000
Subject: Re: [PATCH AUTOSEL 4.14 06/13] sparc32: Limit memblock allocation to low memory
Message-Id: <ad613de2-6fd4-f7a3-25b1-61f3a093c811@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20210302115903.63458-1-sashal@kernel.org>
 <20210302115903.63458-6-sashal@kernel.org>
In-Reply-To: <20210302115903.63458-6-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Mike Rapoport <rppt@linux.ibm.com>, "David S . Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

On 2021-03-02 12:58, Sasha Levin wrote:
> From: Andreas Larsson <andreas@gaisler.com>
> 
> [ Upstream commit bda166930c37604ffa93f2425426af6921ec575a ]
> 
> Commit cca079ef8ac29a7c02192d2bad2ffe4c0c5ffdd0 changed sparc32 to use
> memblocks instead of bootmem, but also made high memory available via
> memblock allocation which does not work together with e.g. phys_to_virt
> and can lead to kernel panic.
> 
> This changes back to only low memory being allocatable in the early
> stages, now using memblock allocation.
> 
> Signed-off-by: Andreas Larsson <andreas@gaisler.com>
> Acked-by: Mike Rapoport <rppt@linux.ibm.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   arch/sparc/mm/init_32.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
> index 95fe4f081ba3..372a4f08ddf8 100644
> --- a/arch/sparc/mm/init_32.c
> +++ b/arch/sparc/mm/init_32.c
> @@ -230,6 +230,9 @@ unsigned long __init bootmem_init(unsigned long *pages_avail)
>   	reserve_bootmem((bootmap_pfn << PAGE_SHIFT), size, BOOTMEM_DEFAULT);
>   	*pages_avail -= PAGE_ALIGN(size) >> PAGE_SHIFT;
>   
> +	/* Only allow low memory to be allocated via memblock allocation */
> +	memblock_set_current_limit(max_low_pfn << PAGE_SHIFT);
> +
>   	return max_pfn;
>   }
>   
> 

This is not needed for 4.14, and will not compile, as the problem it
fixes was introduced in 4.19.

-- 
Andreas Larsson

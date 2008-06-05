From: David Miller <davem@davemloft.net>
Date: Thu, 05 Jun 2008 18:42:00 +0000
Subject: Re: [RFC: 2.6 patch] sparc/mm/: possible cleanups
Message-Id: <20080605.114200.264713107.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080605182625.GH1469@cs181133002.pp.htv.fi>
In-Reply-To: <20080605182625.GH1469@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Adrian Bunk <bunk@kernel.org>
Date: Thu, 5 Jun 2008 21:26:27 +0300

> This patch contains the following possible cleanups:
> - make the following needlessly global code static:
>   - fault.c: force_user_fault()
>   - init.c: calc_max_low_pfn()
>   - init.c: pgt_cache_water[]
>   - init.c: map_high_region()
>   - srmmu.c: hwbug_bitmask
>   - srmmu.c: srmmu_swapper_pg_dir
>   - srmmu.c: srmmu_context_table
>   - srmmu.c: is_hypersparc
>   - srmmu.c: srmmu_cache_pagetables
>   - srmmu.c: srmmu_nocache_size
>   - srmmu.c: srmmu_nocache_end
>   - srmmu.c: srmmu_get_nocache()
>   - srmmu.c: srmmu_free_nocache()
>   - srmmu.c: srmmu_early_allocate_ptable_skeleton()
>   - srmmu.c: srmmu_nocache_calcsize()
>   - srmmu.c: srmmu_nocache_init()
>   - srmmu.c: srmmu_alloc_thread_info()
>   - srmmu.c: early_pgtable_allocfail()
>   - srmmu.c: srmmu_early_allocate_ptable_skeleton()
>   - srmmu.c: srmmu_allocate_ptable_skeleton()
>   - srmmu.c: srmmu_inherit_prom_mappings()
>   - sunami.S: tsunami_copy_1page
> - remove the following unused code:
>   - init.c: struct sparc_aliases
> 
> Signed-off-by: Adrian Bunk <bunk@kernel.org>

Applied.

Received: from mailrelay-egress4.pub.mailoutpod2-cph3.one.com (mailrelay-egress4.pub.mailoutpod2-cph3.one.com [46.30.211.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA09237C908
	for <sparclinux@vger.kernel.org>; Sat, 29 Aug 2026 06:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787984794; cv=none; b=Ek8qCvJy1sqk/6w90DK/FZyVZmq+oDSEQ9ADA9OG8e9bkfhHauAuzMCIxT25+phZo+6wyTnDc2B6kBeQnYtVnym7Ducwzatm8i086N4OVBpuyIS7FgVYr8BWHTIOQS6BS0fyh2q+uyPprbH2+nusqjMwdYLSIhcdx06oqIFQUlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787984794; c=relaxed/simple;
	bh=q4GpF3OqPegTQd9cJ2QYPPj8QntQDa9G0gz+GvAYEU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C/+exvdsrhgndrDm49eo4sWFIdZjGaY3wU3/OmpvzAxjd1wkeyIPWD1uFgdCbyHGIsivvWP8myaA5Sxnz8rCfiYD85Verq+vmF2o8fup/yAhqf6yCN4f8/EIrJxeG/UttmAIfphpLSEag0VoOYzonVM3z0Ep9HNOOGHxCfnZAnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org; spf=none smtp.mailfrom=ravnborg.org; dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=jsjnLpbC; dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=1OzQnMOD; arc=none smtp.client-ip=46.30.211.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="jsjnLpbC";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="1OzQnMOD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1787984785; x=1788589585;
	d=ravnborg.org; s=rsa1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=ofQlwmnGw3PEeR1WpbWm08yN0hlGqwWSnQ6hhvtMn/M=;
	b=jsjnLpbCw9b+YQRpL7k6AorxLExmdr9Hdy7BBBWIsVeGi7qdAwWvz6rFdXNeHlxHhC40gG24OHa8X
	 q4r+GkFBRwkrZe0VNBMBbI5mYXxy/pxFqz6JPChy0XAvqKrWi2hyW89ILRx6XuYocEaivpgAOFL6do
	 /lVwtCZR8IAsxj/OE7QI5ySSim1LeeHOrblwMDr1b9q3DqdhUIwYpUa39jwQLgqnRbJwORvmp3P421
	 ZtC8ETNXaT2wCMvoBbMLFzQsUbzq+I5/xFEmMx9mih9j1HBrC3WgrF1vAtm/AgD+eABpsLwtSql/vN
	 me9A3YbDbKJpHHXNbrft+bJd3Ih6uMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1787984785; x=1788589585;
	d=ravnborg.org; s=ed1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=ofQlwmnGw3PEeR1WpbWm08yN0hlGqwWSnQ6hhvtMn/M=;
	b=1OzQnMODt3kbVZEmX8qEQpXYBpqpasB80hJcyWyj/sUMqurgo1QetqjwxfcKoGOv4V6KKcG6R9PUA
	 XVuXBLeBw==
X-HalOne-ID: 8d795de2-a372-11f1-a4cc-579199b74f77
Received: from ravnborg.org (unknown [2a00:fd01:81e9:6100:cd23:4a74:8afa:914b])
	by mailrelay5.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
	id 8d795de2-a372-11f1-a4cc-579199b74f77;
	Sat, 29 Aug 2026 06:26:24 +0000 (UTC)
Date: Sat, 29 Aug 2026 08:26:23 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Magnus Lindholm <linmag7@gmail.com>
Cc: sparclinux@vger.kernel.org, davem@davemloft.net, andreas@gaisler.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] sparc32: move early memory setup to setup_arch
Message-ID: <20260829062623.GA44338@ravnborg.org>
References: <20260827182757.6856-1-linmag7@gmail.com>
 <20260827182757.6856-5-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827182757.6856-5-linmag7@gmail.com>

Hi Magnus

On Thu, Aug 27, 2026 at 08:24:16PM +0200, Magnus Lindholm wrote:
> Move the early memory configuration out of SRMMU paging setup and next to
> the rest of setup_arch(). Derive the PFN limits from memblock, reserve the
> kernel and initrd there, and retain mem= support with
> memblock_enforce_memory_limit().
> 
> When PAGE_OFFSET maps a relocated kernel, remove memory below phys_base
> from memblock because it cannot be reached through the linear map. This
> replaces the equivalent trimming of sp_banks.
> 
Rebasing the relocate kernel patch on top of this would prevent the same
code to be patched twice. But the end result would ofc be the same.

A few comments in the following.

	Sam

> Suggested-by: Sam Ravnborg <sam@ravnborg.org>
> Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
> ---
>  arch/sparc/include/asm/pgtable_32.h |   3 +-
>  arch/sparc/kernel/setup_32.c        | 118 +++++++++++++----------
>  arch/sparc/mm/init_32.c             | 140 +---------------------------
>  arch/sparc/mm/srmmu.c               |   4 -
>  4 files changed, 73 insertions(+), 192 deletions(-)
> 
> diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
> index f89b1250661d..91a6032cf6a2 100644
> --- a/arch/sparc/include/asm/pgtable_32.h
> +++ b/arch/sparc/include/asm/pgtable_32.h
> @@ -37,8 +37,7 @@ struct vm_area_struct;
>  struct page;
>  
>  void load_mmu(void);
> -unsigned long calc_highpages(void);
> -unsigned long __init bootmem_init(unsigned long *pages_avail);
> +void __init find_ramdisk(unsigned long end_of_phys_memory);
>  
>  #define pte_ERROR(e)   __builtin_trap()
>  #define pmd_ERROR(e)   __builtin_trap()
> diff --git a/arch/sparc/kernel/setup_32.c b/arch/sparc/kernel/setup_32.c
> index 795714959da6..e5f1c3ee36df 100644
> --- a/arch/sparc/kernel/setup_32.c
> +++ b/arch/sparc/kernel/setup_32.c
> @@ -23,6 +23,7 @@
>  #include <linux/syscalls.h>
>  #include <linux/kdev_t.h>
>  #include <linux/major.h>
> +#include <linux/memblock.h>
>  #include <linux/string.h>
>  #include <linux/init.h>
>  #include <linux/interrupt.h>
> @@ -254,28 +255,77 @@ static __init void leon_patch(void)
>  
>  struct tt_entry *sparc_ttable;
>  
> -/* Drop RAM below the kernel; the linear map runs upward from phys_base
> - * and cannot reach it.
> - */
> -static void __init trim_sp_banks_below(unsigned long base)
> +unsigned long phys_base;
> +EXPORT_SYMBOL(phys_base);
> +
> +unsigned long pfn_base;
> +EXPORT_SYMBOL(pfn_base);
> +
> +unsigned long highend_pfn;
> +
> +static unsigned long __init calc_max_low_pfn(void)
>  {
> -	int i, j = 0;
> +	unsigned long limit = pfn_base + (SRMMU_MAXMEM >> PAGE_SHIFT);
> +	unsigned long last_pfn = 0;
> +	phys_addr_t start, end;
> +	u64 i;
>  
> -	for (i = 0; sp_banks[i].num_bytes != 0; i++) {
> -		unsigned long start = sp_banks[i].base_addr;
> -		unsigned long end = start + sp_banks[i].num_bytes;
> +	for_each_mem_range(i, &start, &end) {
> +		unsigned long start_pfn = PFN_DOWN(start);
Here for_each_mem_pfn_range() could be used.

>  
> -		if (end <= base)
> -			continue;		/* wholly below - drop it */
> -		if (start < base)
> -			start = base;		/* straddles - trim the front */
> +		if (start_pfn >= limit) {
> +			if (last_pfn < limit)
> +				limit = last_pfn;
> +			break;
> +		}
>  
> -		sp_banks[j].base_addr = start;
> -		sp_banks[j].num_bytes = end - start;
> -		j++;
> +		last_pfn = PFN_DOWN(end);
>  	}
> -	sp_banks[j].base_addr = 0;
> -	sp_banks[j].num_bytes = 0;
> +
> +	return limit;
> +}
> +
> +static void __init setup_memory(void)
> +{
> +	unsigned long ram_base = memblock_start_of_DRAM();
> +	unsigned long real_base = __get_phys(PAGE_OFFSET);
> +	unsigned long size;
> +
> +	memblock_set_bottom_up(true);
> +	memblock_allow_resize();
> +
> +	phys_base = ram_base;
> +	if (real_base && real_base != phys_base) {
> +		prom_printf("phys_base: RAM starts 0x%x but kernel is at 0x%x\n",
> +			    (unsigned int)phys_base, (unsigned int)real_base);
> +		phys_base = real_base;
> +		memblock_remove(0, phys_base);
> +		prom_printf("phys_base: adopted 0x%x, RAM below it dropped\n",
> +			    (unsigned int)phys_base);
> +	}
> +
> +	if (cmdline_memory_size)
> +		memblock_enforce_memory_limit(cmdline_memory_size);
> +
> +	min_low_pfn = PFN_DOWN(memblock_start_of_DRAM());
> +	pfn_base = phys_base >> PAGE_SHIFT;
> +	max_pfn = PFN_DOWN(memblock_end_of_DRAM());
> +	last_valid_pfn = max_pfn;
last_valid_pfn can be replaced with max_low_pfn in all places.
> +	max_low_pfn = max_pfn;
Likewise, replace all uses of max_pfn with max_low_pfn.

Code becomes easier to understand when the memblock defined variables
are used.

> +	highend_pfn = max_pfn;
> +
> +	if (max_low_pfn > pfn_base + (SRMMU_MAXMEM >> PAGE_SHIFT))
> +		max_low_pfn = calc_max_low_pfn();
> +
> +	find_ramdisk(memblock_end_of_DRAM());
> +
> +	/* Reserve the kernel text/data/bss. */
> +	size = __pa(PAGE_ALIGN((unsigned long)&_end)) - phys_base;
> +	memblock_reserve(phys_base, size);
> +	memblock_add(phys_base, size);
> +
> +	/* Only allow low memory to be allocated by memblock. */
> +	memblock_set_current_limit(PFN_PHYS(max_low_pfn));
>  }
>  
>  /* Called from head_32.S - before we have setup anything
> @@ -306,9 +356,6 @@ void __init sparc32_start_kernel(struct linux_romvec *rp)
>  
>  void __init setup_arch(char **cmdline_p)
>  {
> -	int i;
> -	unsigned long highest_paddr;
> -
>  	sparc_ttable = &trapbase[0];
>  
>  	/* Initialize PROM console and command line. */
> @@ -343,36 +390,7 @@ void __init setup_arch(char **cmdline_p)
>  
>  	idprom_init();
>  	load_mmu();
> -
> -	phys_base = 0xffffffffUL;
> -	highest_paddr = 0UL;
> -	for (i = 0; sp_banks[i].num_bytes != 0; i++) {
> -		unsigned long top;
> -
> -		if (sp_banks[i].base_addr < phys_base)
> -			phys_base = sp_banks[i].base_addr;
> -		top = sp_banks[i].base_addr +
> -			sp_banks[i].num_bytes;
> -		if (highest_paddr < top)
> -			highest_paddr = top;
> -	}
> -
> -	/* phys_base must describe what PAGE_OFFSET maps to, not where RAM starts. */
> -	{
> -		unsigned long real_base = __get_phys(PAGE_OFFSET);
> -
> -		if (real_base && real_base != phys_base) {
> -			prom_printf("phys_base: RAM starts 0x%x but kernel is at 0x%x\n",
> -				    (unsigned int)phys_base,
> -				    (unsigned int)real_base);
> -			phys_base = real_base;
> -			trim_sp_banks_below(phys_base);
> -			prom_printf("phys_base: adopted 0x%x, RAM below it dropped\n",
> -				    (unsigned int)phys_base);
> -		}
> -	}
> -
> -	pfn_base = phys_base >> PAGE_SHIFT;
> +	setup_memory();
>  
>  	if (!root_flags)
>  		root_mountflags &= ~MS_RDONLY;
> diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
> index 75050dfbc2ea..62c41d896421 100644
> --- a/arch/sparc/mm/init_32.c
> +++ b/arch/sparc/mm/init_32.c
> @@ -39,66 +39,15 @@
>  
>  static unsigned long *sparc_valid_addr_bitmap;
>  
> -unsigned long phys_base;
> -EXPORT_SYMBOL(phys_base);
> -
> -unsigned long pfn_base;
> -EXPORT_SYMBOL(pfn_base);
> -
>  struct sparc_phys_banks sp_banks[SPARC_PHYS_BANKS+1];
>  
>  /* Initial ramdisk setup */
>  extern unsigned int sparc_ramdisk_image;
>  extern unsigned int sparc_ramdisk_size;
>  
> -unsigned long highstart_pfn, highend_pfn;
> -
>  unsigned long last_valid_pfn;
>  
> -unsigned long calc_highpages(void)
> -{
> -	int i;
> -	int nr = 0;
> -
> -	for (i = 0; sp_banks[i].num_bytes != 0; i++) {
> -		unsigned long start_pfn = sp_banks[i].base_addr >> PAGE_SHIFT;
> -		unsigned long end_pfn = (sp_banks[i].base_addr + sp_banks[i].num_bytes) >> PAGE_SHIFT;
> -
> -		if (end_pfn <= max_low_pfn)
> -			continue;
> -
> -		if (start_pfn < max_low_pfn)
> -			start_pfn = max_low_pfn;
> -
> -		nr += end_pfn - start_pfn;
> -	}
> -
> -	return nr;
> -}
> -
> -static unsigned long calc_max_low_pfn(void)
> -{
> -	int i;
> -	unsigned long tmp = pfn_base + (SRMMU_MAXMEM >> PAGE_SHIFT);
> -	unsigned long curr_pfn, last_pfn;
> -
> -	last_pfn = (sp_banks[0].base_addr + sp_banks[0].num_bytes) >> PAGE_SHIFT;
> -	for (i = 1; sp_banks[i].num_bytes != 0; i++) {
> -		curr_pfn = sp_banks[i].base_addr >> PAGE_SHIFT;
> -
> -		if (curr_pfn >= tmp) {
> -			if (last_pfn < tmp)
> -				tmp = last_pfn;
> -			break;
> -		}
> -
> -		last_pfn = (sp_banks[i].base_addr + sp_banks[i].num_bytes) >> PAGE_SHIFT;
> -	}
> -
> -	return tmp;
> -}
> -
> -static void __init find_ramdisk(unsigned long end_of_phys_memory)
> +void __init find_ramdisk(unsigned long end_of_phys_memory)
>  {
>  #ifdef CONFIG_BLK_DEV_INITRD
>  	unsigned long size;
> @@ -128,83 +77,6 @@ static void __init find_ramdisk(unsigned long end_of_phys_memory)
>  #endif
>  }
>  
> -unsigned long __init bootmem_init(unsigned long *pages_avail)
> -{
> -	unsigned long start_pfn, bytes_avail, size;
> -	unsigned long end_of_phys_memory = 0;
> -	unsigned long high_pages = 0;
> -	int i;
> -
> -	memblock_set_bottom_up(true);
> -	memblock_allow_resize();
> -
> -	bytes_avail = 0UL;
> -	for (i = 0; sp_banks[i].num_bytes != 0; i++) {
> -		end_of_phys_memory = sp_banks[i].base_addr +
> -			sp_banks[i].num_bytes;
> -		bytes_avail += sp_banks[i].num_bytes;
> -		if (cmdline_memory_size) {
> -			if (bytes_avail > cmdline_memory_size) {
> -				unsigned long slack = bytes_avail - cmdline_memory_size;
> -
> -				bytes_avail -= slack;
> -				end_of_phys_memory -= slack;
> -
> -				sp_banks[i].num_bytes -= slack;
> -				if (sp_banks[i].num_bytes == 0) {
> -					sp_banks[i].base_addr = 0xdeadbeef;
> -				} else {
> -					memblock_add(sp_banks[i].base_addr,
> -						     sp_banks[i].num_bytes);
> -					sp_banks[i+1].num_bytes = 0;
> -					sp_banks[i+1].base_addr = 0xdeadbeef;
> -				}
> -				break;
> -			}
> -		}
> -		memblock_add(sp_banks[i].base_addr, sp_banks[i].num_bytes);
> -	}
> -
> -	if (cmdline_memory_size)
> -		memblock_enforce_memory_limit(cmdline_memory_size);
> -
> -	/* Start with page aligned address of last symbol in kernel
> -	 * image.
> -	 */
> -	start_pfn  = (unsigned long)__pa(PAGE_ALIGN((unsigned long) &_end));
> -
> -	/* Now shift down to get the real physical page frame number. */
> -	start_pfn >>= PAGE_SHIFT;
> -
> -	max_pfn = end_of_phys_memory >> PAGE_SHIFT;
> -
> -	max_low_pfn = max_pfn;
> -	highstart_pfn = highend_pfn = max_pfn;
> -
> -	if (max_low_pfn > pfn_base + (SRMMU_MAXMEM >> PAGE_SHIFT)) {
> -		highstart_pfn = pfn_base + (SRMMU_MAXMEM >> PAGE_SHIFT);
> -		max_low_pfn = calc_max_low_pfn();
> -		high_pages = calc_highpages();
> -		printk(KERN_NOTICE "%ldMB HIGHMEM available.\n",
> -		    high_pages >> (20 - PAGE_SHIFT));
> -	}
> -
> -	find_ramdisk(end_of_phys_memory);
> -
> -	/* Reserve the kernel text/data/bss. */
> -	size = (start_pfn << PAGE_SHIFT) - phys_base;
> -	memblock_reserve(phys_base, size);
> -	memblock_add(phys_base, size);
> -
> -	size = memblock_phys_mem_size() - memblock_reserved_size();
> -	*pages_avail = (size >> PAGE_SHIFT) - high_pages;
> -
> -	/* Only allow low memory to be allocated via memblock allocation */
> -	memblock_set_current_limit(max_low_pfn << PAGE_SHIFT);
> -
> -	return max_pfn;
> -}
> -
>  /*
>   * paging_init() sets up the page tables: We call the MMU specific
>   * init routine based upon the Sun model type on the Sparc.
> @@ -220,14 +92,10 @@ void __init paging_init(void)
>  
>  static void __init taint_real_pages(void)
>  {
> -	int i;
> -
> -	for (i = 0; sp_banks[i].num_bytes; i++) {
> -		unsigned long start, end;
> -
> -		start = sp_banks[i].base_addr;
> -		end = start + sp_banks[i].num_bytes;
> +	phys_addr_t start, end;
> +	u64 i;
>  
> +	for_each_mem_range(i, &start, &end) {
>  		while (start < end) {
>  			set_bit(start >> 20, sparc_valid_addr_bitmap);
>  			start += PAGE_SIZE;
There are no users of sparc_valid_addr_bitmap, it would be better
to drop the whole function in a preparation patch.

> diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
> index 3029527a5a9f..272e430f8bd8 100644
> --- a/arch/sparc/mm/srmmu.c
> +++ b/arch/sparc/mm/srmmu.c
> @@ -884,7 +884,6 @@ void __init srmmu_paging_init(void)
>  	pud_t *pud;
>  	pmd_t *pmd;
>  	pte_t *pte;
> -	unsigned long pages_avail;
>  
>  	init_mm.context = (unsigned long) NO_CONTEXT;
>  	sparc_iomap.start = SUN4M_IOBASE_VADDR;	/* 16MB of IOSPACE on all sun4m's. */
> @@ -910,9 +909,6 @@ void __init srmmu_paging_init(void)
>  		prom_halt();
>  	}
>  
> -	pages_avail = 0;
> -	last_valid_pfn = bootmem_init(&pages_avail);
> -
>  	srmmu_nocache_calcsize();
>  	srmmu_nocache_init();
>  	srmmu_inherit_prom_mappings(0xfe400000, (LINUX_OPPROM_ENDVM - PAGE_SIZE));
> -- 
> 2.43.0

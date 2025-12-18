Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BFC2D6E4B;
	Thu, 18 Dec 2025 08:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766047458; cv=none; b=cpWJNkuATTAG3D1hgbhHFHFFYyFy8RJ7knsqnORdrZUGKgJ/zDdKINwvg3I26T1XGaXz6PUvtQn17tFVZJmMo19huySnWOzF/yOPPf6eC4CWIXq5NnZ/7DcXTlYvme4B2OT1WXCY7U6mz6kUJsViBvt7Lks/7r+6fEfyUE2YEAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766047458; c=relaxed/simple;
	bh=bALsCqvSTHwwYz8QmGh55URvGVsNoAOBLrpOS8lJtd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SDJ/QU5+GnNzuB/qCZ5hpnMdiYFi+8Sj4uF4rW/ZS7JGFMHvlHT7vIUrYZbuCBdg3LQNUCBgevBaGNrwHh6yGVSziYU5QN13jJkXGE4ryM6ngZs+6h/Fex+pbm15Vvw2zQEej+N8+91UF/NFWJ/mTpDEC2VzJLwR9HUewpZ4zOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ukyez4lu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ukyez4lu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F222C4CEFB;
	Thu, 18 Dec 2025 08:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766047457;
	bh=bALsCqvSTHwwYz8QmGh55URvGVsNoAOBLrpOS8lJtd4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ukyez4lu8CFjM7JHpAeVJUdVpCmSNa2wj7Xmg4xLozKRmW+/KY0M+f0iioxKKlRTL
	 MOUts3mwjSzKX67ovaxIYmBNpvgrrAzZ9u6ATvCzXCBkLXJbIsMCNErjsHjF8TxrXa
	 wKWVwOruiNMyYjvM1EA+WfC7ufzB4g/NF7tjwsmrZnbvvJVNIkamoprSGdtnrT0cdu
	 A29w2x9UtFTaS+jALpDaZr/zllPmWQHu6NgzdCLlKIQhzuw7A5NZovaTCoCqUtTg1d
	 XERd6gK0dUi9ML0LgD4E+lq+5eyToLHmBKOEgsF3eKAVuabLCKU8mXzruRiNi6sZiS
	 yEX5hzI3wzYwg==
Message-ID: <d373f7b0-f822-4c31-990c-41a6cdc76db3@kernel.org>
Date: Thu, 18 Dec 2025 09:44:11 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sparc: Use vmemmap_populate_hugepages for
 vmemmap_populate
To: chengkaitao <pilgrimtao@gmail.com>, davem@davemloft.net,
 andreas@gaisler.com, akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com
Cc: kevin.brodsky@arm.com, dave.hansen@linux.intel.com, ziy@nvidia.com,
 chengkaitao@kylinos.cn, willy@infradead.org, zhengqi.arch@bytedance.com,
 sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20251217120858.18713-1-pilgrimtao@gmail.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251217120858.18713-1-pilgrimtao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/17/25 13:08, chengkaitao wrote:
> From: Chengkaitao <chengkaitao@kylinos.cn>
> 
> 1. Added the vmemmap_false_pmd function to accommodate architectures
> that do not support basepages.
> 2. In the SPARC architecture, reimplemented vmemmap_populate using
> vmemmap_populate_hugepages.
> 
> Signed-off-by: Chengkaitao <chengkaitao@kylinos.cn>
> ---
>   arch/sparc/mm/init_64.c | 56 ++++++++++++++++-------------------------
>   include/linux/mm.h      |  1 +
>   mm/sparse-vmemmap.c     |  7 +++++-
>   3 files changed, 28 insertions(+), 36 deletions(-)
> 
> diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
> index df9f7c444c39..a80cdfa6ba98 100644
> --- a/arch/sparc/mm/init_64.c
> +++ b/arch/sparc/mm/init_64.c
> @@ -5,7 +5,7 @@
>    *  Copyright (C) 1996-1999 David S. Miller (davem@caip.rutgers.edu)
>    *  Copyright (C) 1997-1999 Jakub Jelinek (jj@sunsite.mff.cuni.cz)
>    */
> -
> +
>   #include <linux/extable.h>
>   #include <linux/kernel.h>
>   #include <linux/sched.h>
> @@ -2397,11 +2397,11 @@ void __init paging_init(void)
>   	 * work.
>   	 */
>   	init_mm.pgd += ((shift) / (sizeof(pgd_t)));
> -	
> +
>   	memset(swapper_pg_dir, 0, sizeof(swapper_pg_dir));
>   
>   	inherit_prom_mappings();
> -	
> +
>   	/* Ok, we can use our TLB miss and window trap handlers safely.  */
>   	setup_tba();
>   

Bunch of unrelated changes that should not go in here.

> @@ -2581,8 +2581,8 @@ unsigned long _PAGE_CACHE __read_mostly;
>   EXPORT_SYMBOL(_PAGE_CACHE);
>   
>   #ifdef CONFIG_SPARSEMEM_VMEMMAP
> -int __meminit vmemmap_populate(unsigned long vstart, unsigned long vend,
> -			       int node, struct vmem_altmap *altmap)
> +void __meminit vmemmap_set_pmd(pmd_t *pmd, void *p, int node,
> +			       unsigned long addr, unsigned long next)
>   {
>   	unsigned long pte_base;
>   
> @@ -2595,39 +2595,25 @@ int __meminit vmemmap_populate(unsigned long vstart, unsigned long vend,
>   
>   	pte_base |= _PAGE_PMD_HUGE;
>   
> -	vstart = vstart & PMD_MASK;
> -	vend = ALIGN(vend, PMD_SIZE);
> -	for (; vstart < vend; vstart += PMD_SIZE) {
> -		pgd_t *pgd = vmemmap_pgd_populate(vstart, node);
> -		unsigned long pte;
> -		p4d_t *p4d;
> -		pud_t *pud;
> -		pmd_t *pmd;
> -
> -		if (!pgd)
> -			return -ENOMEM;
> -
> -		p4d = vmemmap_p4d_populate(pgd, vstart, node);
> -		if (!p4d)
> -			return -ENOMEM;
> -
> -		pud = vmemmap_pud_populate(p4d, vstart, node);
> -		if (!pud)
> -			return -ENOMEM;
> -
> -		pmd = pmd_offset(pud, vstart);
> -		pte = pmd_val(*pmd);
> -		if (!(pte & _PAGE_VALID)) {
> -			void *block = vmemmap_alloc_block(PMD_SIZE, node);
> +	pmd_val(*pmd) = pte_base | __pa(p);
> +}
>   
> -			if (!block)
> -				return -ENOMEM;
> +bool __meminit vmemmap_false_pmd(pmd_t *pmd, int node)
> +{
> +	return true;
> +}
>   
> -			pmd_val(*pmd) = pte_base | __pa(block);
> -		}
> -	}
> +int __meminit vmemmap_check_pmd(pmd_t *pmdp, int node,
> +				unsigned long addr, unsigned long next)
> +{
> +	vmemmap_verify((pte_t *)pmdp, node, addr, next);
> +	return 1;
> +}
>   
> -	return 0;
> +int __meminit vmemmap_populate(unsigned long vstart, unsigned long vend,
> +			       int node, struct vmem_altmap *altmap)
> +{
> +	return vmemmap_populate_hugepages(vstart, vend, node, altmap);
>   }
>   #endif /* CONFIG_SPARSEMEM_VMEMMAP */
>   
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 15076261d0c2..5e005b0f947d 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4248,6 +4248,7 @@ void *vmemmap_alloc_block_buf(unsigned long size, int node,
>   void vmemmap_verify(pte_t *, int, unsigned long, unsigned long);
>   void vmemmap_set_pmd(pmd_t *pmd, void *p, int node,
>   		     unsigned long addr, unsigned long next);
> +bool vmemmap_false_pmd(pmd_t *pmd, int node);
>   int vmemmap_check_pmd(pmd_t *pmd, int node,
>   		      unsigned long addr, unsigned long next);
>   int vmemmap_populate_basepages(unsigned long start, unsigned long end,
> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> index 37522d6cb398..bd54b8c6f56e 100644
> --- a/mm/sparse-vmemmap.c
> +++ b/mm/sparse-vmemmap.c
> @@ -407,6 +407,11 @@ void __weak __meminit vmemmap_set_pmd(pmd_t *pmd, void *p, int node,
>   {
>   }
>   
> +bool __weak __meminit vmemmap_false_pmd(pmd_t *pmd, int node)
> +{
> +	return 0;
> +}
> +

Reading that function I have absolutely no clue what this is supposed to 
do. :)

Also, why are you passing pmd+node when sparc ignores them completely 
and statically returns "true" ?

If you can tell me what the semantics of that function should be, maybe 
we can come up with a more descriptive name.

-- 
Cheers

David

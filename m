Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E55F33066B;
	Mon, 26 Jan 2026 14:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769439047; cv=none; b=RKRS7k2N1N12zeQ5DMKO5kDX1qQObdOWEp0ra65eTJ/FRVXO214qJjpqynce1RDuzOOQ6d2z5fjpktt9MGejQrNVIfa8VzDAr75X2/PFT1vVfu0sxFKhcImVDx5ZHTbz8bdfmyemwaB8OigXctCxtgdBq+wlJbqfEm1dmnoem14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769439047; c=relaxed/simple;
	bh=HnGqafQ0+df/3DEFU6leLP3NzQ+ys68JEG986c5pxSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VEpQ5HxheMdLDTJQuFGaPXA13RzNtuL02JtOdk3mc8sFBtbliYaLhmRhphvx3vvmm5COnBBwP/P1/XSSTpYyNfAuXz9Ha361JhpUj5kkeZqa+ebk9NApGKALl/OaGPaErJdDNwpbMB9+t07686c84w4bWhuf2E6eIeS6veTo4ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=D8+GIGWK reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="D8+GIGWK"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4f0BKl5YR7z1DPk2;
	Mon, 26 Jan 2026 15:50:35 +0100 (CET)
Received: from [10.10.15.30] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4f0BKk6h2Fz1DDV2;
	Mon, 26 Jan 2026 15:50:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1769439035;
	bh=ARP0Pw/Fo5FtnRzlhI9dsRF360HgZtwUjmen8yDukTk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=D8+GIGWKbpOYGKqPOqVI+1SKk+U1HacWqBBdSlIWTlvf+ZpgAe7caqNNkYbV4pLHJ
	 NbbLeq7u3X2qDdnwgtask4C9cOxmPGV3oH3cnb/NXmRfPDug4rzXS+ur1sgJyYHG+H
	 XQgiYcE9WXsaObs2wL9UsNFqibjRxQ0UnoJKA0RDyJyEvLb3ytcizSFESPplkfE7rn
	 WnXbg0p3S8ll1Chxrf2fxvqshC/osR2PIfU5BpkILcSyxSxJdF6+FzMnzMBe0Vhuoy
	 NSshafDDO9d77JX7vQNDZnGcSc9uEj5JF9pl7g0VPKBxlDhj/mp1rC5pqn76Sf8EQj
	 NFsrz6sR+mRsw==
Message-ID: <aaf30e1e-be55-4212-b096-69f71bafd406@gaisler.com>
Date: Mon, 26 Jan 2026 15:50:34 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] sparc: Use vmemmap_populate_hugepages for
 vmemmap_populate
To: chengkaitao <pilgrimtao@gmail.com>, davem@davemloft.net,
 akpm@linux-foundation.org, david@kernel.org, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com
Cc: kevin.brodsky@arm.com, dave.hansen@linux.intel.com, ziy@nvidia.com,
 chengkaitao@kylinos.cn, willy@infradead.org, zhengqi.arch@bytedance.com,
 sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20260111074453.66728-1-pilgrimtao@gmail.com>
 <20260111074453.66728-2-pilgrimtao@gmail.com>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20260111074453.66728-2-pilgrimtao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026-01-11 08:44, chengkaitao wrote:
> From: Chengkaitao <chengkaitao@kylinos.cn>
> 
> 1. In the SPARC architecture, reimplemented vmemmap_populate using
> vmemmap_populate_hugepages.
> 2. Allow the SPARC arch to fallback to vmemmap_populate_basepages(),
> when vmemmap_alloc_block returns NULL.

This patch seems to potentially make more functional changes than what
the descriptions gives impression of.

Given the amount of changes this seems to introduce, more on that below,
I'd like to see more description on the changes and why they can be done
than this.

Nit: use active language, "reimplement", not "reimplemented".


> Signed-off-by: Chengkaitao <chengkaitao@kylinos.cn>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  arch/sparc/mm/init_64.c | 47 ++++++++++++++---------------------------
>  1 file changed, 16 insertions(+), 31 deletions(-)
> 
> diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
> index df9f7c444c39..858eaa6615ea 100644
> --- a/arch/sparc/mm/init_64.c
> +++ b/arch/sparc/mm/init_64.c
> @@ -2581,8 +2581,8 @@ unsigned long _PAGE_CACHE __read_mostly;
>  EXPORT_SYMBOL(_PAGE_CACHE);
>  
>  #ifdef CONFIG_SPARSEMEM_VMEMMAP
> -int __meminit vmemmap_populate(unsigned long vstart, unsigned long vend,
> -			       int node, struct vmem_altmap *altmap)
> +void __meminit vmemmap_set_pmd(pmd_t *pmd, void *p, int node,
> +			       unsigned long addr, unsigned long next)
>  {
>  	unsigned long pte_base;
>  
> @@ -2595,39 +2595,24 @@ int __meminit vmemmap_populate(unsigned long vstart, unsigned long vend,
>  
>  	pte_base |= _PAGE_PMD_HUGE;
>  
> -	vstart = vstart & PMD_MASK;
> -	vend = ALIGN(vend, PMD_SIZE);

It seems that this patch removes alignment of both start and end. Is
this a functional change in practice or are these always aligned for
some other reason?


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
> +	pmd_val(*pmd) = pte_base | __pa(p);
> +}
>  
> -		pmd = pmd_offset(pud, vstart);
> -		pte = pmd_val(*pmd);
> -		if (!(pte & _PAGE_VALID)) {

It is not the same thing, but is this equivalent to if
(pmd_none(pmdp_get(pmd))) at this point?


> -			void *block = vmemmap_alloc_block(PMD_SIZE, node);
> +int __meminit vmemmap_check_pmd(pmd_t *pmdp, int node,
> +				unsigned long addr, unsigned long next)
> +{
> +	int large = pmd_leaf(*pmdp);
>  
> -			if (!block)
> -				return -ENOMEM;
> +	if (large)
> +		vmemmap_verify((pte_t *)pmdp, node, addr, next);
>  
> -			pmd_val(*pmd) = pte_base | __pa(block);
> -		}
> -	}
> +	return large;
> +}
>  
> -	return 0;
> +int __meminit vmemmap_populate(unsigned long vstart, unsigned long vend,
> +			       int node, struct vmem_altmap *altmap)
> +{
> +	return vmemmap_populate_hugepages(vstart, vend, node, altmap);
>  }
>  #endif /* CONFIG_SPARSEMEM_VMEMMAP */
>  


This change introduces using vmemmap_alloc_block_buf() instead of
vmemmap_alloc_block() seems to introduce two new behaviours that was not
in use for sparc64 before:

1) Using altmap_alloc_block_buf() for a non-null altmap, that was not
   used before. Also the fallback to vmemmap_populate_basepages() passes
   on altmap.

2) Trying sparse_buffer_alloc() before vmemmap_alloc_block(), which was
   not done before.

Neither the commit message nor the cover letter touches upon this. Could
you elaborate here?


Given all the (at least seeming) functional changes could you share how
you tested this change?

Cheers,
Andreas


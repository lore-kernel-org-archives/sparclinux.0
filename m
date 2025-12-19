Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9992BE03B;
	Fri, 19 Dec 2025 09:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766136861; cv=none; b=d2q689qPwCax/zOcgfATSsvpNl7z7FjAYfS479cuAIuipu76/bI2vUKCdLMKuNH6XYg3timVDnRb7IQRWMcUoqW+dQCLKsW7HHasqShCoVI7c15Bhtbs7T+Em/FL7iahzhh1TbPfsPBwjQzOuV/qEBH0de1kCKGaoHo6hrLK+lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766136861; c=relaxed/simple;
	bh=MHgQTaG61qGMuxEXN5cJbS8M2YCe8RD+w/6EJgGwGbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DjHE+ZoAj2LL2eW6T6nXUmSwNqCZgesC7Q6FKytlX4/vhAzWH7NxWo0NaeoM7FqeMNBhTb+bXoyRsBAgmtOl4ADdJyblUAZRP2+xHlhCLxq+62semR7ezZzNAlvwN6S1BbI/+ZOjs8M9I4HNDfjRBlFzOcLCnJKQh1pAupILono=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N5KOwCn2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5KOwCn2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54DF7C116D0;
	Fri, 19 Dec 2025 09:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766136861;
	bh=MHgQTaG61qGMuxEXN5cJbS8M2YCe8RD+w/6EJgGwGbo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N5KOwCn2sZfy3p8ScNckzmQBAclcYoqauxSc2WaSf2YFdtM52i2C/pLr+yEycW8N2
	 l81ncubQWmQdQ1Lw0ElF9sFvwXHsQl+A0G/sXlckaAtYApqB6sKQhOx/JUf05x9uPx
	 o5ukTiv/1QzEPsAPdaA1mLmlZ5pl8s4/+Ua8I1hUZFDzQaFYei9FaS0esHDdE0/Nnr
	 uE2KxFSnzs1oRXaBl+RLO92fOMjkp8VXonqriNbEBJs6F5ux+UxRLGjqWGFRdXNspo
	 X+e+b+rmaT7tF5liS1RNgvsxqnHrRAjcf+fewNxVZgVMLWOgb0PIlIOnnhUIgvCFn/
	 xFIJ0SwyJnCbw==
Date: Fri, 19 Dec 2025 11:34:11 +0200
From: Mike Rapoport <rppt@kernel.org>
To: chengkaitao <pilgrimtao@gmail.com>
Cc: davem@davemloft.net, andreas@gaisler.com, akpm@linux-foundation.org,
	david@kernel.org, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, surenb@google.com,
	mhocko@suse.com, kevin.brodsky@arm.com, dave.hansen@linux.intel.com,
	ziy@nvidia.com, chengkaitao@kylinos.cn, willy@infradead.org,
	zhengqi.arch@bytedance.com, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 2/3] mm: Convert vmemmap_p?d_populate() to static
 functions
Message-ID: <aUUcE8esEjyKingC@kernel.org>
References: <20251218174749.45965-1-pilgrimtao@gmail.com>
 <20251218174749.45965-3-pilgrimtao@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218174749.45965-3-pilgrimtao@gmail.com>

On Fri, Dec 19, 2025 at 01:47:48AM +0800, chengkaitao wrote:
> From: Chengkaitao <chengkaitao@kylinos.cn>
> 
> Eliminate the external declarations of vmemmap_p?d_populate functions
> and convert them to static functions.

Please also mention that they are unused outside mm.
With that 

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> Signed-off-by: Chengkaitao <chengkaitao@kylinos.cn>
> ---
>  include/linux/mm.h  |  7 -------
>  mm/sparse-vmemmap.c | 10 +++++-----
>  2 files changed, 5 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 15076261d0c2..d98a38a6ac0e 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4234,13 +4234,6 @@ unsigned long section_map_size(void);
>  struct page * __populate_section_memmap(unsigned long pfn,
>  		unsigned long nr_pages, int nid, struct vmem_altmap *altmap,
>  		struct dev_pagemap *pgmap);
> -pgd_t *vmemmap_pgd_populate(unsigned long addr, int node);
> -p4d_t *vmemmap_p4d_populate(pgd_t *pgd, unsigned long addr, int node);
> -pud_t *vmemmap_pud_populate(p4d_t *p4d, unsigned long addr, int node);
> -pmd_t *vmemmap_pmd_populate(pud_t *pud, unsigned long addr, int node);
> -pte_t *vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, int node,
> -			    struct vmem_altmap *altmap, unsigned long ptpfn,
> -			    unsigned long flags);
>  void *vmemmap_alloc_block(unsigned long size, int node);
>  struct vmem_altmap;
>  void *vmemmap_alloc_block_buf(unsigned long size, int node,
> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> index 37522d6cb398..67f9a08c2376 100644
> --- a/mm/sparse-vmemmap.c
> +++ b/mm/sparse-vmemmap.c
> @@ -151,7 +151,7 @@ void __meminit vmemmap_verify(pte_t *pte, int node,
>  			start, end - 1);
>  }
>  
> -pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, int node,
> +static pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, int node,
>  				       struct vmem_altmap *altmap,
>  				       unsigned long ptpfn, unsigned long flags)
>  {
> @@ -195,7 +195,7 @@ static void * __meminit vmemmap_alloc_block_zero(unsigned long size, int node)
>  	return p;
>  }
>  
> -pmd_t * __meminit vmemmap_pmd_populate(pud_t *pud, unsigned long addr, int node)
> +static pmd_t * __meminit vmemmap_pmd_populate(pud_t *pud, unsigned long addr, int node)
>  {
>  	pmd_t *pmd = pmd_offset(pud, addr);
>  	if (pmd_none(*pmd)) {
> @@ -208,7 +208,7 @@ pmd_t * __meminit vmemmap_pmd_populate(pud_t *pud, unsigned long addr, int node)
>  	return pmd;
>  }
>  
> -pud_t * __meminit vmemmap_pud_populate(p4d_t *p4d, unsigned long addr, int node)
> +static pud_t * __meminit vmemmap_pud_populate(p4d_t *p4d, unsigned long addr, int node)
>  {
>  	pud_t *pud = pud_offset(p4d, addr);
>  	if (pud_none(*pud)) {
> @@ -221,7 +221,7 @@ pud_t * __meminit vmemmap_pud_populate(p4d_t *p4d, unsigned long addr, int node)
>  	return pud;
>  }
>  
> -p4d_t * __meminit vmemmap_p4d_populate(pgd_t *pgd, unsigned long addr, int node)
> +static p4d_t * __meminit vmemmap_p4d_populate(pgd_t *pgd, unsigned long addr, int node)
>  {
>  	p4d_t *p4d = p4d_offset(pgd, addr);
>  	if (p4d_none(*p4d)) {
> @@ -234,7 +234,7 @@ p4d_t * __meminit vmemmap_p4d_populate(pgd_t *pgd, unsigned long addr, int node)
>  	return p4d;
>  }
>  
> -pgd_t * __meminit vmemmap_pgd_populate(unsigned long addr, int node)
> +static pgd_t * __meminit vmemmap_pgd_populate(unsigned long addr, int node)
>  {
>  	pgd_t *pgd = pgd_offset_k(addr);
>  	if (pgd_none(*pgd)) {
> -- 
> 2.50.1 (Apple Git-155)
> 

-- 
Sincerely yours,
Mike.

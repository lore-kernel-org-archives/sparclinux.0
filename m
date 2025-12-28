Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0991FB1;
	Sun, 28 Dec 2025 21:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766955647; cv=none; b=QMu/aun7xabNcUWOodIIjz7GzIyJlmJqBNHc6aBOeQFx17jCMyfF1bOEBKLEyhPNgjE7FZ+8GnTnXxryvCiGF1rEVmYqqTVqzQfvy7oEJvtAN3tTeyUqEFPCDcTIahFGbaM9nWfBGsPK1YVv1xQ0oph/8wUWGH27qACgfHaeT7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766955647; c=relaxed/simple;
	bh=D9/7cYqcpU72WPvnsrQXQKGY0dbbqapVo4LdFuNSb08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TwBFaQ/RSuIXus3awbd2PP8RFIwl7NtYHPK2Km7eqfKTcc2NxemTSxlsKWR9fl0SIvDy8uEd6ADQgJmQL+7LsGzBz4D+JaCWJReJu4qwTpwO301Mg7IeFj1iqyQsYQ+vhWcXs2fXtokiPS5cA0hybN2niNCIMesPvn/zlu0vtxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pz/cWfeG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pz/cWfeG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DC60C4CEFB;
	Sun, 28 Dec 2025 21:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766955646;
	bh=D9/7cYqcpU72WPvnsrQXQKGY0dbbqapVo4LdFuNSb08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pz/cWfeGaOlqPEHlhhXG6Lhj7deT0Ud3PVeSR++oVG9RaxfSe/r9CBg21L+ZJX9fV
	 XD/HLmJ1qAMgMZZTYDr7uAq0zlTAViAAOki//bTr89HHkLv7xq3gHkIgnYIzcXpA9h
	 Rh89PbVbTYFRainlKrNqWQmW5eWLqzSPH58V+EQEeILIaDf+h6mvlnVUnMn/X/fGs7
	 DXfUZNpk8756GqH+F9viNvqnMyWCLIJTML+MJv+/8jnNTUq/bdLQa77F+ZUI4L5Ixf
	 RHzeGLjDaIVdoGo2bNcsobT/N9AjN3ELRmMstIE/hZAxSGtvfmFKnwdhfF1D9lZOlV
	 Ng5tRyZKD/uaA==
Date: Sun, 28 Dec 2025 23:00:36 +0200
From: Mike Rapoport <rppt@kernel.org>
To: chengkaitao <pilgrimtao@gmail.com>
Cc: davem@davemloft.net, andreas@gaisler.com, akpm@linux-foundation.org,
	david@kernel.org, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, surenb@google.com,
	mhocko@suse.com, kevin.brodsky@arm.com, dave.hansen@linux.intel.com,
	ziy@nvidia.com, chengkaitao@kylinos.cn, willy@infradead.org,
	zhengqi.arch@bytedance.com, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 2/3] mm: Convert vmemmap_p?d_populate() to static
 functions
Message-ID: <aVGadJAlS0Z6LLEl@kernel.org>
References: <20251219115812.65855-1-pilgrimtao@gmail.com>
 <20251219115812.65855-3-pilgrimtao@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251219115812.65855-3-pilgrimtao@gmail.com>

On Fri, Dec 19, 2025 at 07:58:11PM +0800, chengkaitao wrote:
> From: Chengkaitao <chengkaitao@kylinos.cn>
> 
> Since the vmemmap_p?d_populate functions are unused outside the mm
> subsystem, we can remove their external declarations and convert
> them to static functions.
> 
> Signed-off-by: Chengkaitao <chengkaitao@kylinos.cn>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

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

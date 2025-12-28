Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4391FB1;
	Sun, 28 Dec 2025 21:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766955694; cv=none; b=LadPM6g4VwojDxPtH/FYlWQDFFibyW9lgFv/F6X65Jw9oUHjMISVNNACVyrBNOanEH+th5+jjaPqtX+2ah4Ska0XSr8jk2U/tNX0iVglbUBWLS4ccXcCKrc4EByhqAsokTwlLf5ptJaxopAFWF0N3W0EXI6LLEs8vvAGk1foYDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766955694; c=relaxed/simple;
	bh=E40TfozfMTRWLVhTkV2adBCHelIThaQvQ1777er0xX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GOhRp3FZWwb7zlD52OrKMhIC2ftFhiyytpZQGgWSqCZkPsb7zXolJPIRZysgGYD/ae669MhL0Puzg+8MYYoTNJUaeKUW9GZdavIAotmvEulEyA/uFYI0F/ymbHq5XTyZVOltE2Rfo5/96IQjZnjKi9hQVDbzajb2KQhcChD+ylo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bFWZMLhh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bFWZMLhh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9092CC4CEFB;
	Sun, 28 Dec 2025 21:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766955693;
	bh=E40TfozfMTRWLVhTkV2adBCHelIThaQvQ1777er0xX4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bFWZMLhhI3RJJiSLADl8BpMm0BnLpwhbEOOJBd3TJEaErP26PcymDPdJB8E0wNQGX
	 LQri8Y9MhXUjljPf8CBpX8MYh0c305UBBWQaKV/8DNAk0siTJYEH5X5l/qa4PuAB4J
	 g3Ywaj8l911WWFB9uSVchXMVdsIOLCgQUjy4vv8kN/EOHlg1NGKb3AQUcim4Kq54s8
	 hBRaWcdK0VCiBVDWTtafozyrIn+fbNeuJxqZDC8kjakUY2n9h4AqMwjg42eOCxiRdZ
	 zQSGSrm9UG+tKzprdCJgRPZbV2//qkUbJ4jtY/WivRUzbqP4nQlVvubZ//5oP32m1I
	 xgF1E7r3+kc7Q==
Date: Sun, 28 Dec 2025 23:01:23 +0200
From: Mike Rapoport <rppt@kernel.org>
To: chengkaitao <pilgrimtao@gmail.com>
Cc: davem@davemloft.net, andreas@gaisler.com, akpm@linux-foundation.org,
	david@kernel.org, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, surenb@google.com,
	mhocko@suse.com, kevin.brodsky@arm.com, dave.hansen@linux.intel.com,
	ziy@nvidia.com, chengkaitao@kylinos.cn, willy@infradead.org,
	zhengqi.arch@bytedance.com, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 1/3] sparc: Use vmemmap_populate_hugepages for
 vmemmap_populate
Message-ID: <aVGao3KAyKxXrIo6@kernel.org>
References: <20251219115812.65855-1-pilgrimtao@gmail.com>
 <20251219115812.65855-2-pilgrimtao@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251219115812.65855-2-pilgrimtao@gmail.com>

On Fri, Dec 19, 2025 at 07:58:10PM +0800, chengkaitao wrote:
> From: Chengkaitao <chengkaitao@kylinos.cn>
> 
> 1. In the SPARC architecture, reimplemented vmemmap_populate using
> vmemmap_populate_hugepages.
> 2. Allow the SPARC arch to fallback to vmemmap_populate_basepages(),
> when vmemmap_alloc_block returns NULL.
> 
> Signed-off-by: Chengkaitao <chengkaitao@kylinos.cn>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

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
> -- 
> 2.50.1 (Apple Git-155)
> 

-- 
Sincerely yours,
Mike.

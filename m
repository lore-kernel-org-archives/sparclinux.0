Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EE734677F;
	Wed,  7 Jan 2026 14:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767797192; cv=none; b=UlAxJocCBj3z0cdTs15VE9W6fE4Xp1eZBSEe7tmnOB2Eh3sa7Y8nV4GXzIruRsSWpsSKBc/d8H/nzDlaXo+BiCtm7t95mCtdFjnP8XV1YZisflwgk0YP0VsLz6oEk9TUTG4pWivTKPZYvW3AkyuXywA/Zw1lqEjayCN0lYFsR08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767797192; c=relaxed/simple;
	bh=OxJj8KI5G/sUmYU76oeSPedaPXLG5QDxif5HI9j8m2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IBU20myQNU1rcPrAXfTRP1hiLDDq6ZlTQ/6tu9SoR8FBvgbqg9uL0XpXO6nFwPEd+aedYakE95i+aH192685eMUlzt/VEpsxyXmG7bIbEZ2q6eue1S48DKKubSjQUNqU+Rg6BkI8lFsy8sDRVJTPW0dUJboRmVR9UIh/5DbjMww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ih3GVWJK; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ih3GVWJK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dxaxnPOyyyziTdlSFXv64BSJwk5O+5EVvmxBfNV3l3c=; b=Ih3GVWJK21BuTLzXwoK135eKk5
	tx4y/kwLL6RBybL4mqJd8NyEWzgSmSCgcQfydjqdnEuLLZZcUfRLfcwjvdD+760CsNJaA5gjUpVb9
	eVfucnZ/I8PhFJ0ztQZWXnlq8JeoC58oPm9b3ZuPldV5/61411WHfDWn4xqxTBFgoAyaNuIe8+NaU
	awhZTqaLjKU1PJzsf7y6IOz0z+1hAAPrpKhMtCnFcuL1Mj0WzEmqaeHTwOfm/bQzxyMVqQgV4Z5p0
	STSfeRhqxV4stUbK1/FNeDYG5WJH3HWnOxPOABIx3Nxy2UfXrNEeFw/dzKkGajgam5pIb8ECcXz+3
	4t8pZJVQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdUnn-0000000DVUx-2Arw;
	Wed, 07 Jan 2026 14:46:23 +0000
Date: Wed, 7 Jan 2026 14:46:23 +0000
From: Matthew Wilcox <willy@infradead.org>
To: alexs@kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	"open list:SPARC + UltraSPARC (sparc/sparc64)" <sparclinux@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	kernel test robot <lkp@intel.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, Zi Yan <ziy@nvidia.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] arch/sparc: fix unused variable warning
Message-ID: <aV5xv0PfUvdc5QFE@casper.infradead.org>
References: <20260107104145.51416-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107104145.51416-1-alexs@kernel.org>

On Wed, Jan 07, 2026 at 06:41:44PM +0800, alexs@kernel.org wrote:
> From: Alex Shi <alexs@kernel.org>
> 
>    arch/sparc/mm/init_64.c: In function 'arch_hugetlb_valid_size':
>    arch/sparc/mm/init_64.c:361:24: warning: variable 'hv_pgsz_idx' set but not used [-Wunused-but-set-variable]
>      361 |         unsigned short hv_pgsz_idx;
>          |                        ^~~~~~~~~~~

Looks like it's been unused since introduction in c7d9f77d33a7 ?

As such, why cc all these people who have absolutely nothing to do with
it?  Use your brain, not a stupid script.

> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Alex Shi <alexs@kernel.org>
> Cc: sparclinux@vger.kernel.org
> Cc: Matthew Wilcox  <willy@infradead.org>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Qi Zheng <zhengqi.arch@bytedance.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Kevin Brodsky <kevin.brodsky@arm.com>
> Cc: Mike Rapoport  <rppt@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Andreas Larsson <andreas@gaisler.com>
> Cc: David S. Miller <davem@davemloft.net>
> ---
>  arch/sparc/mm/init_64.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
> index df9f7c444c39..ba19d23d4040 100644
> --- a/arch/sparc/mm/init_64.c
> +++ b/arch/sparc/mm/init_64.c
> @@ -358,30 +358,24 @@ static void __init pud_huge_patch(void)
>  bool __init arch_hugetlb_valid_size(unsigned long size)
>  {
>  	unsigned int hugepage_shift = ilog2(size);
> -	unsigned short hv_pgsz_idx;
>  	unsigned int hv_pgsz_mask;
>  
>  	switch (hugepage_shift) {
>  	case HPAGE_16GB_SHIFT:
>  		hv_pgsz_mask = HV_PGSZ_MASK_16GB;
> -		hv_pgsz_idx = HV_PGSZ_IDX_16GB;
>  		pud_huge_patch();
>  		break;
>  	case HPAGE_2GB_SHIFT:
>  		hv_pgsz_mask = HV_PGSZ_MASK_2GB;
> -		hv_pgsz_idx = HV_PGSZ_IDX_2GB;
>  		break;
>  	case HPAGE_256MB_SHIFT:
>  		hv_pgsz_mask = HV_PGSZ_MASK_256MB;
> -		hv_pgsz_idx = HV_PGSZ_IDX_256MB;
>  		break;
>  	case HPAGE_SHIFT:
>  		hv_pgsz_mask = HV_PGSZ_MASK_4MB;
> -		hv_pgsz_idx = HV_PGSZ_IDX_4MB;
>  		break;
>  	case HPAGE_64K_SHIFT:
>  		hv_pgsz_mask = HV_PGSZ_MASK_64K;
> -		hv_pgsz_idx = HV_PGSZ_IDX_64K;
>  		break;
>  	default:
>  		hv_pgsz_mask = 0;
> -- 
> 2.43.0
> 

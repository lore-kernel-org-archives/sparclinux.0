Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA8A230270;
	Fri, 19 Dec 2025 09:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766136597; cv=none; b=MZCiFY0M0RCjTCu7AS0V5bfADX1sdGJPmr7KppxJzVSxX2lMsg3WL9iqmUEZu3Qsbu+/ihMtP+X/bEX2M9YqDVSVjrzH3WW5deTLOnxfBW4dXP3dkjF5hTiZU3EqWlJJyBich3jrsQLlwtslb4lLg6VBCeKo3fVIjW5vSfg897k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766136597; c=relaxed/simple;
	bh=V/6lQG6kh+DJ+F+maEx/cpf9+v1suaX8xw+gTbpt5Cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lrbLdrRb0zj12QFI3Hq2HqPiBJN1ZKmK7pEx90OPrHSHG3YdcgYbQYCq5d9LcZfb31lUNyhSIKJZz3tn97BZI6dtWLju4nLKU+J6HC+gtb0Wh80SMp842lO3IAOmcHhGIAvRHRswWOmNlHVjdoNwiGemkNDiM3Lzgvwaxcs5vTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWBUCWFN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWBUCWFN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41525C116D0;
	Fri, 19 Dec 2025 09:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766136597;
	bh=V/6lQG6kh+DJ+F+maEx/cpf9+v1suaX8xw+gTbpt5Cs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bWBUCWFNVeHiQZOp92aMo6bJbzBD3M61Yti8z0C2cvo71wg0c7Gm/GjgYbma3XIKE
	 N1UEqpp2lVbUeK1kfjsENB3Aowo0dor0psKQ0UCYvTu+r/KZJkEcrl6S3yM25gTFXK
	 SeUhIB4V40M5wckR4NtXg8/X4Sz5OAvyf06uzMdy27IdKtG9snvKJd1Mdn3Gp4G6kY
	 uGTKpP2e0pzCzYAu7Irg6lhs6HBjpVLoekXOcawnSk3VkrWe6csdbLEAcDYQYyxqVJ
	 HCviAwXQYxoQSZiIYwQVv20tigNKIG2g1h7aywqG4UHItiVTtXIDTUpoN9E3gGxH5Z
	 g9MraE2fxb15A==
Date: Fri, 19 Dec 2025 11:29:47 +0200
From: Mike Rapoport <rppt@kernel.org>
To: chengkaitao <pilgrimtao@gmail.com>
Cc: davem@davemloft.net, andreas@gaisler.com, akpm@linux-foundation.org,
	david@kernel.org, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, surenb@google.com,
	mhocko@suse.com, kevin.brodsky@arm.com, dave.hansen@linux.intel.com,
	ziy@nvidia.com, chengkaitao@kylinos.cn, willy@infradead.org,
	zhengqi.arch@bytedance.com, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 0/3] Generalize vmemmap_populate_hugepages to sparc
Message-ID: <aUUbC4QWMZn_BO8L@kernel.org>
References: <20251218174749.45965-1-pilgrimtao@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218174749.45965-1-pilgrimtao@gmail.com>

On Fri, Dec 19, 2025 at 01:47:46AM +0800, chengkaitao wrote:
> Sparc implement vmemmap_populate using vmemmap_populate_hugepages
> to streamline the code. Another benefit is that it allows us to

If this is merged via mm tree, the cover letter would be a part of git
history so I'd suggest slightly rephrasing the first sentence:

Change sparc's implementation of vmemmap_populate() using
vmemmap_populate_hugepages() to streamline the code.

> eliminate the external declarations of vmemmap_p?d_populate
> functions and convert them to static functions.
> 
> Since vmemmap_populate_hugepages may fallback to vmemmap_populate-
> _basepages, which differs from sparc's original implementation.
> During the v1 discussion with Mike Rapoport, sparc uses base pages
> in the kernel page tables, so it should be able to use them in
> vmemmap as well. Consequently, no additional special handling is
> required.
> 
> Remove unnecessary whitespace from sparc.
> 
> Changes in v3:
> - Allow sparc to fallback to vmemmap_populate_basepages
> - Convert vmemmap_p?d_populate() to static functions
> - Split the v1 patch
> 
> Changes in v2:
> - Revert the whitespace deletions
> - Change vmemmap_false_pmd to vmemmap_pte_fallback_allowed
> 
> Link to V1:
> https://lore.kernel.org/all/20251217120858.18713-1-pilgrimtao@gmail.com/
> 
> Chengkaitao (3):
>   sparc: Use vmemmap_populate_hugepages for vmemmap_populate
>   mm: Convert vmemmap_p?d_populate() to static functions
>   sparc: Remove unnecessary whitespace
> 
>  arch/sparc/mm/fault_64.c   |  4 +--
>  arch/sparc/mm/hypersparc.S |  4 +--
>  arch/sparc/mm/init_64.c    | 53 ++++++++++++--------------------------
>  arch/sparc/mm/io-unit.c    | 12 ++++-----
>  arch/sparc/mm/iommu.c      |  2 +-
>  arch/sparc/mm/swift.S      |  2 +-
>  arch/sparc/mm/ultra.S      |  4 +--
>  include/linux/mm.h         |  7 -----
>  mm/sparse-vmemmap.c        | 10 +++----
>  9 files changed, 36 insertions(+), 62 deletions(-)
> 
> -- 
> 2.50.1 (Apple Git-155)
> 

-- 
Sincerely yours,
Mike.

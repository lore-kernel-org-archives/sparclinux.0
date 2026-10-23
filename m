Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792788797;
	b=X3oHeGbsl1+i7TBGAtTsbC8N7QJhwbPxLkCu77+rJZFLot066KkEH9lSs6d0Iw7P8xiZ
	 QP/UV93fYLH0SjEJPiCI0le8HYbqId/9r7zS+5Taax0tJcubnNEcK5Neq2muS5PlylrT9
	 3o+smE4GUBjPeHsUR07VKzVV6TkcyqcEvJNuRF303H+LW/QzDCDURyqOCJ0Hik5Cykj6d
	 OPsTTD7itV1RkL9+7JVf4RlzS3SSPznBT4O6aZ+ab7TJA4BM7H9K2TYdkw9zrBr7JxAds
	 qp+G8jPPzg3GU1D3pJYmP9rkWJ7zhR+wBX1+JTxgeW1ddL8H2WnK80HU89litk4Bqtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792788797;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=0buMQQINV0ZMT10UHG2uFH0Ptzl8aD3BfO7547k5kqY=;
	b=zX6NFEhmTWvGJcCoSs16DzEtq9uqntiEOfnWgRDLMvIYunnFi4edSdtuDs4cBQPWW+9l
	 34VALkM+Mz2jCGcPwEIJv1rk+gJBJEJWPiyGds0zP1UElNrk4gXG+zjP/FZ9OJB7zcfk7
	 5VhS62eJeorCvnLOhH1NlEZUn598DeCZPbNpMo8J+CYKh4jzdP2A0ngeK6+ZygcJsEN/I
	 WpXQzUY/rPEpUc188406TqHCWNeanoDx1FXqfAlIC2VDUqHFdcjz48bggTJSci00KUTye
	 d6QZsPcNNnj0HeZ83AOLts7/wRDE/IiPxSFR5wDBPCICohypqgxDNRrXhwnpzf4hivg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DUU81bAs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886C7606A31B;
	Fri, 23 Oct 2026 20:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DUU81bAs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15DEB1F01825;
	Fri, 23 Oct 2026 20:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792788797;
	bh=0buMQQINV0ZMT10UHG2uFH0Ptzl8aD3BfO7547k5kqY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=DUU81bAsRlByMerKC6j8ENrXC1/LZaH6l/iyH813lPlUNnkhTUzRJZ7FS62aiyRtg
	 nk18HnfoiLhgD/7nubtqFeBFg8UJPicbpbNVP1OiMueX/sFnkIptckyLCdt3yShdok
	 fOmBsw0eNvATOPhavkFKgnshJ/cF4t2QGt4/goRkbHFXKSC+j6Sz1i4YTDQJs9StRI
	 1k3eNBpmp7vjOP9O8hXMfiWhngOVx6UgHOW2RsbPmrG4kzH/Q6tDPkOrw8CuZMcYSY
	 99iKODVHyysJalk31n5BoLCcDBQ+AfAMuQGn2jzvcF1E+IB7wVuvrRF9fA4u8i4QYX
	 WRBqUM0rLtOlw==
Message-ID: <409079fe-ab52-4389-9fe0-d7246eb27bad@kernel.org>
Date: Fri, 23 Oct 2026 22:53:09 +0200
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] mm: pass the number of PTEs to move_pte()
To: Imre Kaloz <kaloz@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 "Mike Rapoport (IBM)" <rppt@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <cover.1792609488.git.kaloz@kernel.org>
 <2bc50d2a6829b49ee909e5bb943244859661a40b.1792609488.git.kaloz@kernel.org>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <2bc50d2a6829b49ee909e5bb943244859661a40b.1792609488.git.kaloz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/22/26 01:33, Imre Kaloz wrote:
> Since commit f822a9a81a31 ("mm: optimize mremap() by PTE batching"),
> move_ptes() moves a batch of PTEs mapping consecutive pages of a folio
> at a time, but calls move_pte() once per batch with the first PTE
> only. sparc64, the only architecture that overrides move_pte(), flushes
> from the D-cache the page that PTE maps when the move changes its
> colour, so the other pages of a batch would keep lines of the old
> colour. This cannot happen today only because sparc64 has no
> pte_batch_hint(), and mremap_folio_pte_batch() then never batches.
> 
> Pass nr_ptes to move_pte(), as get_and_clear_ptes() takes it. The
> generic version ignores it, and sparc64 flushes every page of the
> batch.
> 
> Signed-off-by: Imre Kaloz <kaloz@kernel.org>
> ---
>  arch/sparc/include/asm/pgtable_64.h | 16 +++++++++-------
>  include/linux/pgtable.h             |  2 +-
>  mm/mremap.c                         |  2 +-
>  3 files changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
> index 1430489b9ac5..9ca787b3cbfe 100644
> --- a/arch/sparc/include/asm/pgtable_64.h
> +++ b/arch/sparc/include/asm/pgtable_64.h
> @@ -946,21 +946,23 @@ static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
>  	set_pte_at((mm), (addr), (ptep), __pte(0UL))
>  
>  #ifdef DCACHE_ALIASING_POSSIBLE
> -/* This flushes only the page the PTE maps, so it relies on move_ptes()
> - * calling it for one PTE at a time, which the default pte_batch_hint()
> - * guarantees.
> +/* The nr PTEs map consecutive pages of one folio and all move by the
> + * same offset, so either every page of the batch aliases or none does.
>   */
>  #define __HAVE_ARCH_MOVE_PTE
> -#define move_pte(pte, old_addr, new_addr)				\
> +#define move_pte(pte, old_addr, new_addr, nr)				\
>  ({									\
>  	pte_t newpte = (pte);						\
>  	if (tlb_type != hypervisor && pte_present(pte)) {		\
>  		unsigned long this_pfn = pte_pfn(pte);			\
> +		unsigned int i;						\
>  									\
>  		if (pfn_valid(this_pfn) &&				\
> -		    (((old_addr) ^ (new_addr)) & (1 << 13)))		\
> -			flush_dcache_page_all(current->mm,		\
> -					      pfn_to_page(this_pfn));	\
> +		    (((old_addr) ^ (new_addr)) & (1 << 13))) {		\
> +			for (i = 0; i < (nr); i++)			\
> +				flush_dcache_page_all(current->mm,	\
> +					pfn_to_page(this_pfn + i));	\
> +		}							\
>  	}								\
>  	newpte;								\
>  })
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 8c093c119e5a..b58c0e98994e 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -1471,7 +1471,7 @@ static inline void arch_swap_restore(swp_entry_t entry, struct folio *folio)
>  #endif
>  
>  #ifndef __HAVE_ARCH_MOVE_PTE
> -#define move_pte(pte, old_addr, new_addr)	(pte)
> +#define move_pte(pte, old_addr, new_addr, nr)	(pte)
>  #endif
>  
>  #ifndef pte_accessible
> diff --git a/mm/mremap.c b/mm/mremap.c
> index e8df5cdb0ac9..7fcae7f0082d 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -289,7 +289,7 @@ static int move_ptes(struct pagetable_move_control *pmc,
>  			force_flush = true;
>  		}
>  		pte = get_and_clear_ptes(mm, old_addr, old_ptep, nr_ptes);
> -		pte = move_pte(pte, old_addr, new_addr);
> +		pte = move_pte(pte, old_addr, new_addr, nr_ptes);
>  		pte = move_soft_dirty_pte(pte);
>  
>  		if (need_clear_uffd_wp && pte_is_uffd_wp_marker(pte))


I hate move_pte() so much. And I hate sparc64 for requiring it. ;)

Is there some way we can avoid this
helper-that-shouldn't-exist-but-someone-hacked-it-in entirely?

If it makes sparc64 slightly slower #dontcare.

-- 
Cheers,

David

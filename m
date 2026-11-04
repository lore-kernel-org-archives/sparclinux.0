Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793800074;
	b=f88Qgy9niLjgJpKt1G+HbTQw4X5YDwolpAAOOYimsCdBJMUjDAmJmYaFQ375owuO3XFZ
	 moeMCfO/qcgN3IYnhYt60IjOgEdKHDwhJhi2+l7ehbI3UrSV1AwFZ+geP1MBq65BCkcmF
	 AD6TTjF/5SujiNPdsfdNQyN9b1GPgFXkupb73xjs1ytXXK42JOeiXD7ZdPVKOzW7TXnkK
	 kRXQPgSgt0RlUJwLyyrSqynsnX730ftI5zBPab9bNFgWco2lMEe8P1wWFXjcfK8AfU/wJ
	 XomKxTDqGfhVxG46+B3NEGkh+dRfq+t/0Mr7hBlbnay8VKhF2lUvLGjuWDTa60fyfoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793800074;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=fTVNdWh8B46/PatSuHx4QbO9mWYJLcSt+owknOqg8D0=;
	b=k+EJi8XJcrnTWkiDq4RrbL6UcIM6YfgVzr0MFHYARQVwfOlNMlQFe74WCjFD64cpCcfe
	 dp+MRie1k13gw+tKTUcnNIxgj/4e9447qTXe1uachdigHtaCggyd9KVxeSWat5yl2Q6O8
	 dct4gl4OekMRxTLdQXjh0ahLfYrxxiH6WmprTbtqEgxI8w1Rr/rNdXOjs4hKKx6H+N9GH
	 XdewrGNXiP8Vgs9Vop4wf0hgd0EFTx1ty2gqfHzhdccn8IuM2Eh6wxOTp1vdTasMdUFeH
	 sikusyh9lSciPYNs1Owhv5QyCpyXqOip8ei5B/G7npxCqUka8vTP+ykxXIwlijaf3nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OEOPfR8c;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EA6606A31B;
	Wed,  4 Nov 2026 13:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OEOPfR8c
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31AB01F000C1;
	Wed,  4 Nov 2026 13:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793800074;
	bh=fTVNdWh8B46/PatSuHx4QbO9mWYJLcSt+owknOqg8D0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OEOPfR8cPw7G74kt65uMFjL6tNhebIPjtChoImRgJ+W0MEr7uoduMrU+eTgQKvm50
	 sZD+lg9/90SEW6KMj/m24Inj+j3r7wAA0CxTbDDQITamh6oYP1qEWKKO6SPGfbl2/C
	 sUoEaiWsieZSFfxQp2z9mocrqbmiVEbG+KJ7RNxNOVb9PCZLcC2LP11zs61pIFjjkB
	 CQlZFdZc3vlLr84dUYfAnB37FN4TeJcZ43ldsrJX7qRj0RCtzdSlhrx23AK+IqAfIU
	 R7RVrZ/3s9++HyPr547nfY/4aKdSLJjsDjlR18pThjADN5b+zKFoTwNptFGT1p3JKd
	 QTdCyMOf9iZJg==
Date: Wed, 4 Nov 2026 15:47:46 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Imre Kaloz <kaloz@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] sparc64: replace move_pte() with a D-cache flush in
 flush_cache_range()
Message-ID: <aus3giOxv0WWeysK@kernel.org>
References: <20261104105300.16260-1-kaloz@kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104105300.16260-1-kaloz@kernel.org>

On Wed, Nov 04, 2026 at 11:52:58AM +0100, Imre Kaloz wrote:
> mremap() can move a page to an address of the other D-cache color,
> leaving lines of the old color in the virtually indexed D-cache of
> Spitfire and Cheetah CPUs.  move_pte() flushed the page for each PTE
> moved, which is only correct while move_ptes() handles one PTE at a
> time.
> 
> Drop move_pte(), which no other architecture defines, and flush the
> whole D-cache in flush_cache_range(), which mremap() calls on the old
> range before moving the PTEs.  This keeps the fix in sparc64 without
> a page table walk.
> 
> Suggested-by: David Hildenbrand (Arm) <david@kernel.org>
> Link: https://lore.kernel.org/all/409079fe-ab52-4389-9fe0-d7246eb27bad@kernel.org/
> Signed-off-by: Imre Kaloz <kaloz@kernel.org>
> ---
> Andreas asked for this as a separate patch once the merge window was
> over [1]. It applies on top of sparc for-next.
> 
> [1] https://lore.kernel.org/all/4fba060e-c4f4-4d73-8efe-dbed0b5a7bc3@gaisler.com/
> 
>  arch/sparc/include/asm/cacheflush_64.h |  4 ++--
>  arch/sparc/include/asm/pgtable_64.h    | 21 ---------------------
>  arch/sparc/mm/init_64.c                | 18 ++++++++++++++++++
>  include/linux/pgtable.h                |  4 ----
>  mm/mremap.c                            |  1 -
>  5 files changed, 20 insertions(+), 28 deletions(-)

Lovely indeed :)

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

-- 
Sincerely yours,
Mike.

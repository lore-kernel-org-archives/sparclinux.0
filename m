Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794756208;
	b=sjjg1MvTOq3E7OuLqg8GKB+dGrSmq+S/DgNezrYF8WOMTO8NL1TzeaWATmSpNwRGe7j9
	 4kVkndQwkP1nrN2WrUavg1Hn+UBp56mGPbzbyC62i4dfCjp5PhZLgSkC/grHK+aDbbSyQ
	 WDblmFSkx6DadC9x+7w8HLvqOG6yuIcF1ItIoFEKjchmnL6TO21s7aw7vSjRDlZpFimo0
	 cJHUgni4HxJCVWD3ZWxldU+frwK/ui9/tII8cew8vqMoyVtcgRHcbfwLf7/A+Pfck54B5
	 MPkyhNE/xYNzbC3GD83Eouxg982ydtOciojSWM3oSVRnfbj2kF80lDYgXKJjEocSWTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794756208;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=v8TIMiq73Mw5ReQUdV1tXDz4+sKry0oZWtUShE+0QUw=;
	b=iywjn/le9vMlBfzstBM6x+bET6VqmZ6cAjBbuf9Nc5qPiI/JOOoRGooYUZsULDACbZLs
	 Vy/oEuS3kWb96EOlrK5/zTtTl1TTMdAMqI93/+Q5Nq8zZk0oWKulqvN4BKN7BCI+xX1Cd
	 0FWheN28bBfNn9sV71i/iYhImZlX8RtQGidVWr7xTSxuy6hw9OrzizADAiU3hVjtaHsN8
	 bBVq5jk/IkUBO9O4t7D9XguFs0cfpvpnk9SFcxBDHY+EA1vrkMlLpOaVY/+bzOveI0eB1
	 IJ+hyOwxkZLrl1xZUboUMKoFFzRiWiehdXpAKl/nXIHe2S8pyWBQACPoAo9Yu6wcsUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fAQB6H3O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23C0606A31A
	for <sparclinux@vger.kernel.org>; Sun, 15 Nov 2026 15:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fAQB6H3O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2AEA1F000C4;
	Sun, 15 Nov 2026 15:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794756208;
	bh=v8TIMiq73Mw5ReQUdV1tXDz4+sKry0oZWtUShE+0QUw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fAQB6H3OHz6MhUX4o14L06zIdHxek5EYYUSe8L67TknIoIgOFFrvSKoXE8PkUoHAG
	 SNzqFF/b+7omJmf9eZNnEkrun6GzBdMgPXVdD+3YqUcPbwET/vKWMev2PSKPQa/iZK
	 EM5DW0eWMo+59T/M0uhbOGP/S8glmJyWXzOc0w9salYEV4jkvtPOdRdkjeVoNo9pBT
	 Q1ssqgET+egcv4GrSvaPrYDchm6tVUGoBvkFvBjjQn6ieMhns/YaKmy9akI8TvV7yZ
	 sDGRmuGwPVOkuh39SzzWXz+LqrU26yAHUX3d0Ka+7CC2AHNLBjX7VX5DFCF5fUAzOo
	 /y0qLa0tKDaCQ==
Message-ID: <sashiko-outbox-215629@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 9/9] mm, sparc: batch arch_unmap_one()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dev Jain" <dev.jain@arm.com>, david@kernel.org, ljs@kernel.org, akpm@linux-foundation.org, hughd@google.com, chrisl@kernel.org, kasong@tencent.com, davem@davemloft.net, andreas@gaisler.com
Cc: riel@surriel.com, liam@infradead.org, vbabka@kernel.org, harry@kernel.org, jannh@google.com, lance.yang@linux.dev, baolin.wang@linux.alibaba.com, shikemeng@huaweicloud.com, nphamcs@gmail.com, baoquan.he@linux.dev, baohua@kernel.org, youngjun.park@lge.com, linux-mm@kvack.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com, pfalcato@suse.de, anshuman.khandual@arm.com, geert@linux-m68k.org, sparclinux@vger.kernel.org, ryan.roberts@arm.com
In-Reply-To: <20261115143905.3045084-10-dev.jain@arm.com>
References: <20261115143905.3045084-1-dev.jain@arm.com>
 <20261115143905.3045084-10-dev.jain@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 15:23:26 +0000
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] sparc: leak of ADI tag_users and tag storage in
  adi_save_tags_range()
--

commit ccbef0704b88d6e8aff2c2f0c82f32d9131dcc3f
Author: Dev Jain <dev.jain@arm.com>

mm, sparc: batch arch_unmap_one()

This commit extends arch_unmap_one() to accept a page count so SPARC can
save ADI tags across a PTE batch during anonymous large-folio unmapping.

> diff --git a/arch/sparc/kernel/adi_64.c b/arch/sparc/kernel/adi_64.c
> index 18036a43cf568..ffa378accefe3 100644
> --- a/arch/sparc/kernel/adi_64.c
> +++ b/arch/sparc/kernel/adi_64.c
[ ... ]
> @@ -394,3 +395,23 @@ int adi_save_tags(struct mm_struct *mm, struct vm_ar=
ea_struct *vma,
> =20
>  	return 0;
>  }
> +
> +int adi_save_tags_range(struct mm_struct *mm, struct vm_area_struct *vma,
> +			unsigned long addr, pte_t oldpte, unsigned long nr)
> +{
> +	unsigned long i;
> +
> +	for (i =3D 0; i < nr; i++, addr +=3D PAGE_SIZE,
> +	     oldpte =3D pte_next_pfn(oldpte)) {
> +		int ret;
> +
> +		if (!(pte_val(oldpte) & _PAGE_MCD_4V))
> +			continue;
> +
> +		ret =3D adi_save_tags(mm, vma, addr, oldpte);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}

[Severity: Medium]
Does this leak tag_desc->tag_users references and tag storage when
adi_save_tags() fails partway through a batch?

Each successful adi_save_tags() call invokes alloc_tag_store(), which
allocates a tag_storage_desc_t slot (and its tag_desc->tags buffer) or
increments tag_desc->tag_users on an existing descriptor:

arch/sparc/kernel/adi_64.c:alloc_tag_store() {
    ...
				if ((addr >=3D tag_desc->start) &&
				    (tag_desc->end >=3D (addr + PAGE_SIZE - 1))) {
					tag_desc->tag_users++;
					goto out;
				}
    ...
}

If a batch crosses tag_desc->end at page i > 0 and alloc_tag_store() fails
its GFP_NOWAIT allocation for the new range, adi_save_tags_range() returns
an error without unwinding the first i pages.  In mm/rmap.c,
__ttu_anon_swapbacked_folio() then fails and ttu_anon_swapbacked_folio()
restores the present PTEs for the entire sub-batch via set_ptes().  Because
those first i pages are not swapped out, adi_restore_tags() ->
del_tag_store() never runs for them, leaking their tag_users references and
preventing del_tag_store() from freeing tag_desc->tags or releasing the
descriptor slot until process exit.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115143905.3045=
084-1-dev.jain@arm.com?part=3D9

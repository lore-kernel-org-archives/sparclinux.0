Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794178956;
	b=NNH/yAWK0JCo3NvRkr40VZcegn6tVGR5zyjwJ99yEHr9ZzJe4qlUZ038NafqLQaeDSPr
	 Ltb9/AYm7cMQe8rfSlPB2Vy1Gjq/mqDs9h1WV53qU2MvxP/XyFcMOaweSaG58sv3l3vXl
	 hvF/SmUP0zxBDtmQu+hPYruc7x9uK4J0ZI5Ip+5omA17xsg/Abmg6k1ZjlbHSABSpvx/k
	 YNzcsNpLslMuJADcMLWPZ/lHZ2Non7pGR++Fm+7XpifQawrQew8B5AOPPecmww5MPf3zj
	 N5HYyPIe9rNIPHu6kohAuSWU4r6lMlQ5A4zD10kuQn4q5IgKM9FoVZ/SwriYYXRh4LA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794178956;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BYUt4K307cYJk6Pgxa8mDT9ifQB4BhDShyvajW1zKH0=;
	b=g+OIFGc6eIP7KBI1X3Qyc0iMYRd4BXFwElNHd5IndrqYIudxTjK8h8akdc7nFK+c64k7
	 /q3pqwdKeOdA6t3ndRdh8jRUAoftSlXUmooUrlqIeT92bMSCF9gpSEfjWSygGD8443h8o
	 7P3jbq8nPXowDa/FMsLTA3v2AMWenu1Owm/UpHdYg4hbBsBjmhTIgAx3lYGwIZuLLxcep
	 ciOpuTZY0o2cRsVYgel7KoCR77JNdpzJ3s65KGaDlgPoElRgeYLG/syerBW9SZK0vXAwI
	 2WqGWiEY1yjB9vG9nJxi80GPIF7n0kjXs4bUs5c9aH/cd6gkMSX6nKEXbdhWBitLUVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JT5vlhMY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3D7606A321
	for <sparclinux@vger.kernel.org>; Sun,  8 Nov 2026 23:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JT5vlhMY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E3D1F0089F;
	Sun,  8 Nov 2026 23:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794178955;
	bh=BYUt4K307cYJk6Pgxa8mDT9ifQB4BhDShyvajW1zKH0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JT5vlhMYe7HOQ2FHYA4E5gtSKo0Ul/3uC+E7E/326h3j+rCVmiJulyu38pcU2LfoF
	 aGo4SuPnfQVJMyJ/UHBlxh+ZYq4Z2+5YB+OqU+9ftuDKFmwkj++KuCr8kJRi0ZCp17
	 uLU382Zur/NflNVAQa9BdydfwSUa+Zutn5sX197DUB7098CR1HGKyrBBBLeTyKm2KG
	 BOq8m9pfnILlz/DAlmUbA6JSy7CfusTmVEi58YF+1bF0EbmVvz87xUHBADVbDXPFNW
	 Pdg1WPh/+8BT4EDcP99Pv/3Qqi4hvOWrS+ErZnlTwYUlyTYcsYO97cxzQadS5Q9TM/
	 G+kAj1jr/iDfQ==
Message-ID: <sashiko-outbox-204147@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/9] sparc32: flush the source user alias in
 copy_user_highpage()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Magnus Lindholm" <linmag7@gmail.com>
Cc: sparclinux@vger.kernel.org
In-Reply-To: <20261108223516.1125534-3-linmag7@gmail.com>
References: <20261108223516.1125534-1-linmag7@gmail.com>
 <20261108223516.1125534-3-linmag7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 23:02:34 +0000
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
- [Medium] sparc32: stale kernel cache alias at vfrom in
  copy_user_highpage()
--

commit 698c37936dc073ff888986a9b12b4e12b07451f0
Author: Magnus Lindholm <linmag7@gmail.com>

sparc32: flush the source user alias in copy_user_highpage()

This commit implements copy_user_highpage() on sparc32 to flush the source
page's user cache alias before copying and flush the destination page via
its mapped kmap_local address.

> diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
> index 2f693b70dbd80..7b53ee9f061f3 100644
> --- a/arch/sparc/mm/init_32.c
> +++ b/arch/sparc/mm/init_32.c
> @@ -103,6 +103,29 @@ void sparc_flush_page_to_ram(struct page *page)
>  }
>  EXPORT_SYMBOL(sparc_flush_page_to_ram);
> =20
> +/*
> + * The kernel reads the source page through a kmap alias, which on a
> + * virtually indexed cache lands in a different set than the user mapping
> + * userspace has been dirtying.  Flush that alias first, and flush the
> + * destination through the address actually written rather than
> + * page_address(), which is NULL for a highmem page.
> + */
> +void copy_user_highpage(struct page *to, struct page *from,
> +			unsigned long vaddr, struct vm_area_struct *vma)
> +{
> +	char *vfrom, *vto;
> +
> +	if (vma)
> +		flush_cache_page(vma, vaddr, page_to_pfn(from));
> +
> +	vfrom =3D kmap_local_page(from);
> +	vto =3D kmap_local_page(to);
> +	copy_page(vto, vfrom);
> +	__flush_page_to_ram((unsigned long)vto);
> +	kunmap_local(vto);
> +	kunmap_local(vfrom);
> +}

[Severity: Medium]
Can copy_page(vto, vfrom) leave or hit stale supervisor cache lines at
vfrom when from is a lowmem page on HyperSPARC?

For a lowmem page, kmap_local_page(from) returns page_address(from) and
kunmap_local(vfrom) returns early without flushing because vfrom is
outside the fixmap kmap range.  Reading vfrom in copy_page() populates
clean supervisor-tagged cache lines at page_address(from).

If the remaining process later reuses from via wp_page_reuse(), writes to
vaddr at a different cache colour, and forks again, neither
hypersparc_flush_cache_mm() (which uses ASI_M_FLUSH_USER) nor
hypersparc_flush_cache_page(vma, vaddr, ...) (which flushes only the user
virtual address vaddr) invalidates the supervisor lines at vfrom.  The
second copy_page(vto, vfrom) will then read stale cached data from vfrom
instead of the updated lines written back from vaddr to RAM.

Flushing vfrom with __flush_page_to_ram((unsigned long)vfrom) as well
would evict the kernel alias.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108223516.1125=
534-1-linmag7@gmail.com?part=3D2

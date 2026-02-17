Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766D136E47F;
	Tue, 17 Feb 2026 16:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771346320; cv=none; b=OAHC7UXljltugMl63E+Kf+fiWFT719NEjBxlQqFCAUTUkQ1yu38KuOZ88u7GRq+sZ7j53JCzN5pCs+daoiqz248ZsYQxhq6snlY+sIsn99z8sWQYcIsn/4zuPEqUdDXiPUtqzM6nYGu+OFQ5TBS8wLAD7YFrynDcgvtuDYQS4mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771346320; c=relaxed/simple;
	bh=mldD4VhmefGCaLyPUMg5t3n5dfvwR1j0C007CHIPr/k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oe+zx5VC4gsFBaV4vJJv4/fh6kuaS2tSki2Zw3FOZNnwU37YJ+ao63Nz7i7DDS0l+jq/OIKlSjDR/jwK3DXRYvB3ral6LMg3idJzSxp1sIcEoBT/vlC3DVycCS3OVRqH0HiLnBJwO3/3Moq4BFOy1xlIc79WIwoXpZ1Qnoc9Zmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=Qp4Y4484; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="Qp4Y4484"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=M1WGiGUaeKMBCIgOq1tn2Z50nnWEF9jmSQdBVLl8i5A=; t=1771346318;
	x=1771951118; b=Qp4Y4484sGvNSTKXOEkjwX489iDG0FDqnHIAAQkIKCU/ellh5V8E8RpeP1WfR
	k4Jq2iV6XYSEQWUa67XrsxsVQAjJxIXaGtykjO2N4rLAEejiaJWO8dfiYzZwdoZKGPxiz1g1A+adc
	MCy5OOLqXWfQ5b/0p9RTvnWjeQRSc97moNqOwUcJPKKOA6XiorMiYbRjbLoiqVEJEkl6bx7Z4vhlD
	XZjr5yrLrFRaeG/dZF8xIo6rZQ31jZVTQl9Tp9mHUsDehBcKdUfF7NzpLDygFd/FYikE3o3iuc25M
	bsUMYrLnhQiujG4Vyq2PcvzB0B2jKDdfcf/ovSVMo08clZbwuA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1vsO5q-00000001EgW-0400; Tue, 17 Feb 2026 17:38:34 +0100
Received: from p5dc55f29.dip0.t-ipconnect.de ([93.197.95.41] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1vsO5p-00000000RcV-3K0i; Tue, 17 Feb 2026 17:38:33 +0100
Message-ID: <60c8265afe8be501a9eb5c811c5b564b0842b156.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sparc: iommu/pci_sun4v: fix page alignment in dma
 mapping
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: stian@itx.no
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, "David S. Miller"	
 <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, Leon
 Romanovsky	 <leon@kernel.org>, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 17 Feb 2026 17:38:33 +0100
In-Reply-To: <20260217162141.4669-2-stian@itx.no>
References: <20260217162141.4669-2-stian@itx.no>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Stian,

please rephrase the subject to:

	sparc: Fix page alignment in dma mapping

Your patch is not specific to sun4v but also fixes generic sparc code,
so you should remove the part "iommu/pci_sun4v:" from the subject.

On Tue, 2026-02-17 at 17:21 +0100, stian@itx.no wrote:
> From: Stian Halseth <stian@itx.no>
>=20
> 'phys' may include an offset within the page, while 'base_paddr' is alrea=
dy page-aligned.
>=20
> This caused incorrect DMA mapping in dma_4u_map_phys and dma_4v_map_phys.
>=20
> Fix both functions by masking phys with IO_PAGE_MASK or subtracting the p=
age offset.

Please remove the newlines between your sentences, they're not necessary
and also trim the lines at 80 columns.

> Fixes: 38c0d0ebf520 ("sparc: Use physical address DMA mapping")
>=20
> Reported-by: Stian Halseth <stian@itx.no>
> Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Stian Halseth <stian@itx.no>
> ---
>  arch/sparc/kernel/iommu.c     | 2 ++
>  arch/sparc/kernel/pci_sun4v.c | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/sparc/kernel/iommu.c b/arch/sparc/kernel/iommu.c
> index 46ef88bc9c26..f3755a388ac7 100644
> --- a/arch/sparc/kernel/iommu.c
> +++ b/arch/sparc/kernel/iommu.c
> @@ -312,6 +312,8 @@ static dma_addr_t dma_4u_map_phys(struct device *dev,=
 phys_addr_t phys,
>  	if (direction !=3D DMA_TO_DEVICE)
>  		iopte_protection |=3D IOPTE_WRITE;
> =20
> +	phys -=3D offset_in_page(phys);
> +
>  	for (i =3D 0; i < npages; i++, base++, phys +=3D IO_PAGE_SIZE)
>  		iopte_val(*base) =3D iopte_protection | phys;
> =20
> diff --git a/arch/sparc/kernel/pci_sun4v.c b/arch/sparc/kernel/pci_sun4v.=
c
> index 791f0a76665f..2f30eeac4861 100644
> --- a/arch/sparc/kernel/pci_sun4v.c
> +++ b/arch/sparc/kernel/pci_sun4v.c
> @@ -411,7 +411,7 @@ static dma_addr_t dma_4v_map_phys(struct device *dev,=
 phys_addr_t phys,
>  	iommu_batch_start(dev, prot, entry);
> =20
>  	for (i =3D 0; i < npages; i++, phys +=3D IO_PAGE_SIZE) {
> -		long err =3D iommu_batch_add(phys, mask);
> +		long err =3D iommu_batch_add(phys & IO_PAGE_MASK, mask);
>  		if (unlikely(err < 0L))
>  			goto iommu_map_fail;
>  	}

Looks good to me otherwise.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

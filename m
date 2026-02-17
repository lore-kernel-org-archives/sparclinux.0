Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694FC36B045;
	Tue, 17 Feb 2026 15:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771342969; cv=none; b=TJWr2+tfX8OzJPe0/rl8drQcKty/sXM4MffkkfpfUsZBuZYlj1zZ/DQ7iL8yxNNXeDf6eI4TI7FICOcVpaiyhgblxWi3UKXvR38OxB3SA0Bwyu5XwtxXTTlOX+RpAtNO6WYBbUM2d3pVeQQuxyGOYkSotw5OXQuhDY/q+FVCSXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771342969; c=relaxed/simple;
	bh=5yG4RFnL8ypGaxpgb/sTM70ZS+1LWPCNdOMscqAM8ks=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EooS64kevgL7FlxlJs9ww6vbAvJqrdBR7EdOs7fhNjWisyRitOBmMW+0zdab3ZYKARFm9JGr0DDtpCZ+DiKbzqR3T3RDOroZ7+B5fnRKBhmaEXpRBGDh1qkUdGfy8DqMM76EmF4qzLU/Y9vUIA8rBpSjT1XEQsutWc0B2IuLUuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=FhUK8wYf; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="FhUK8wYf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=dmEX3MWkxO0ObLmOc9neHhaS1cE4qbZswVWT7AYW6kI=; t=1771342966;
	x=1771947766; b=FhUK8wYfHxisFAc7OgpBVhT4oDAI4K/IAIzP+h+XL/TGKXCCOfc2kUYBI9x/6
	mOeQhswQYa2tMMqpbX0cbJTXxySHPvDSgmYxxYps3HjSbz7YWImiB4BvtFNICm6Rp9DPt34xgXoHb
	u48TAG6B/+MeBqBOxzPC5APW6Uip6F9t0QZdw0VvBupSLOsSS423AtMWn0FhOm4ZTE9Yo4ZnxQegU
	eobB6fR7G6XF+HPINrdO56uynQ60nRyP9MrBIqwrbjnEe00J+3r92jJIhGE4vENC+qTOTeIrQRpxm
	nvAldBgyo21uXGG/SVsXV6M1qemo/tlvw8lPgUzxWZPHYaWonA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1vsNDn-00000000k1h-3IPa; Tue, 17 Feb 2026 16:42:43 +0100
Received: from p5dc55f29.dip0.t-ipconnect.de ([93.197.95.41] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1vsNDn-00000003pGQ-2L9f; Tue, 17 Feb 2026 16:42:43 +0100
Message-ID: <e6cc15f12e3798a540ca9e38df9e320e7c38b8c9.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sparc: iommu/pci_sun4v: fix page alignment in dma
 mapping
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: stian@itx.no, sparclinux@vger.kernel.org
Cc: iommu@lists.linux.dev, m.szyprowski@samsung.com
Date: Tue, 17 Feb 2026 16:42:43 +0100
In-Reply-To: <20260217150350.3541-2-stian@itx.no>
References: <7131d609-b083-4264-818a-21de38c1c3ed@samsung.com>
	 <20260217150350.3541-2-stian@itx.no>
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

On Tue, 2026-02-17 at 16:03 +0100, stian@itx.no wrote:
> From: Stian Halseth <stian@itx.no>
>=20
> 'phys' may include an offset within the page, while 'base_paddr' is alrea=
dy page-aligned.
> This caused incorrect DMA mapping in dma_4u_map_phys and dma_4v_map_phys.
>=20
> Fix both functions by masking phys with IO_PAGE_MASK or subtracting the p=
age offset.
>=20
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

Thanks a lot for your patch! Please follow this guide [1] to send your patc=
h in
a new thread and also making sure you are sending it to the right recipient=
s.

Adrian

> [1] https://nickdesaulniers.github.io/blog/2017/05/16/submitting-your-fir=
st-patch-to-the-linux-kernel-and-responding-to-feedback/

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

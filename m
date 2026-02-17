Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D1021D5B0;
	Tue, 17 Feb 2026 16:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771346893; cv=none; b=AZ1b0skBMaqvwNpbIGeBxxAKeb66BwZQA383q8mIvtop2tntv48Jt7fJbuucBqKaw5oy7MWnpGc8DQOJkAshzYzmKpDmJlHEiDSIQyAvD6kkHx/sOYQnOzm3zMSfcFOjttYZY7axLxBRtpgLB5tlt8CbJBPDv0q6nslc/xUgzgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771346893; c=relaxed/simple;
	bh=SYcgvsCNCDg0+6/cNO8oaP0FjiphVbkBocfNWbIeINM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ke93sb+sn1R+eZBBSE2SckxBu1/rRY8etQKi/xCLYKFIKYxqamm1wRa38Y3LCK0JVRNXjO4UbQqLy+u09kFlkrm8UbS64qfXyKmhX9z3UOVt8CbytazwM4jUEqWqQ7Xi/CKR/4uOUmXrEYpt4HOnIGHGCMSVj/Bt2ByFlj7g1TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=dcr5dcvd; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="dcr5dcvd"
Message-ID: <3a12bf53d43c608968a97350a6b6a7db9df612dd.camel@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1771346889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SYcgvsCNCDg0+6/cNO8oaP0FjiphVbkBocfNWbIeINM=;
	b=dcr5dcvdiYmFw+VoUFg+9QsjCs7jLAvRn0JME/rYjq/WIJeqq6pYBocmvGWfAHv+bbmDWT
	eyNh2JRhXNCN7Hm3vZddlYX2gjSFIaTcRKQDScxcvi22HLPZ48m7Von3FCD3Pwitog8zj6
	uzTYLerpZlx81INmtVJnSLebbYrqmCI=
Subject: Re: [PATCH] sparc: iommu/pci_sun4v: fix page alignment in dma
 mapping
From: Stian Halseth <stian@itx.no>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, "David S. Miller"
 <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, Leon
 Romanovsky <leon@kernel.org>, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 17 Feb 2026 17:48:08 +0100
In-Reply-To: <60c8265afe8be501a9eb5c811c5b564b0842b156.camel@physik.fu-berlin.de>
References: <20260217162141.4669-2-stian@itx.no>
	 <60c8265afe8be501a9eb5c811c5b564b0842b156.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Adrian,

Thanks for the review and suggestions.

On Tue, 2026-02-17 at 17:38 +0100, John Paul Adrian Glaubitz wrote:
> Hi Stian,
>=20
> please rephrase the subject to:
>=20
> =C2=A0sparc: Fix page alignment in dma mapping
>=20
> Your patch is not specific to sun4v but also fixes generic sparc
> code,
> so you should remove the part "iommu/pci_sun4v:" from the subject.
>=20
Understood =E2=80=94 I will update the patch subject as suggested.
> On Tue, 2026-02-17 at 17:21 +0100, stian@itx.no=C2=A0wrote:
> > From: Stian Halseth <stian@itx.no>
> >=20
> > 'phys' may include an offset within the page, while 'base_paddr' is
> > already page-aligned.
> >=20
> > This caused incorrect DMA mapping in dma_4u_map_phys and
> > dma_4v_map_phys.
> >=20
> > Fix both functions by masking phys with IO_PAGE_MASK or subtracting
> > the page offset.
>=20
> Please remove the newlines between your sentences, they're not
> necessary
> and also trim the lines at 80 columns.

Will do =E2=80=94 I=E2=80=99ll reformat the commit message to 80-column lin=
es
and remove extra newlines.

> > Fixes: 38c0d0ebf520 ("sparc: Use physical address DMA mapping")
> >=20
> > Reported-by: Stian Halseth <stian@itx.no>
> > Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Signed-off-by: Stian Halseth <stian@itx.no>
> > ---
> > =C2=A0arch/sparc/kernel/iommu.c=C2=A0=C2=A0=C2=A0=C2=A0 | 2 ++
> > =C2=A0arch/sparc/kernel/pci_sun4v.c | 2 +-
> > =C2=A02 files changed, 3 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/arch/sparc/kernel/iommu.c b/arch/sparc/kernel/iommu.c
> > index 46ef88bc9c26..f3755a388ac7 100644
> > --- a/arch/sparc/kernel/iommu.c
> > +++ b/arch/sparc/kernel/iommu.c
> > @@ -312,6 +312,8 @@ static dma_addr_t dma_4u_map_phys(struct device
> > *dev, phys_addr_t phys,
> > =C2=A0 if (direction !=3D DMA_TO_DEVICE)
> > =C2=A0 iopte_protection |=3D IOPTE_WRITE;
> > =C2=A0
> > + phys -=3D offset_in_page(phys);
> > +
> > =C2=A0 for (i =3D 0; i < npages; i++, base++, phys +=3D IO_PAGE_SIZE)
> > =C2=A0 iopte_val(*base) =3D iopte_protection | phys;
> > =C2=A0
> > diff --git a/arch/sparc/kernel/pci_sun4v.c
> > b/arch/sparc/kernel/pci_sun4v.c
> > index 791f0a76665f..2f30eeac4861 100644
> > --- a/arch/sparc/kernel/pci_sun4v.c
> > +++ b/arch/sparc/kernel/pci_sun4v.c
> > @@ -411,7 +411,7 @@ static dma_addr_t dma_4v_map_phys(struct device
> > *dev, phys_addr_t phys,
> > =C2=A0 iommu_batch_start(dev, prot, entry);
> > =C2=A0
> > =C2=A0 for (i =3D 0; i < npages; i++, phys +=3D IO_PAGE_SIZE) {
> > - long err =3D iommu_batch_add(phys, mask);
> > + long err =3D iommu_batch_add(phys & IO_PAGE_MASK, mask);
> > =C2=A0 if (unlikely(err < 0L))
> > =C2=A0 goto iommu_map_fail;
> > =C2=A0 }
>=20
> Looks good to me otherwise.
>=20
> Adrian
>=20

I=E2=80=99ll send an updated patch (v2) shortly with these changes applied.

Thanks again for reviewing.

--=20
Med vennlig hilsen
Stian Halseth=E2=80=8B=E2=80=8B

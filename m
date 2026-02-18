Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85763043DC;
	Wed, 18 Feb 2026 11:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771412950; cv=none; b=g93Qw52fB5xixhoRlPRZXQfbjLFMD/UUIuvl2EEIafM7DvwaxJg48/36uG7hKqYSuXfRWQ/u4El2dXXLRd0zJrTJFmzueooKdkSnymvB32Q41vL8ONdAF5Sc6oxl+nq5KUzPugZQ8LKn+RiHksGyWs3Jss78ZkDn6XeiV+sgqKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771412950; c=relaxed/simple;
	bh=UpZ9+jhihaQp668wPNY1OVNfjF9iMax/aJfUeZgjOUg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NuBrTrG/Gp6SuXeIIUSjucJ3XZZTPlXtTnastD1/OHsvs8jh+7pKzQr8plt6Bq4MCK1wXt7Woush8qt+FgnoO/Mo0BTPuSFaKcus+HsdJpzD5nY4nG+yTXCcj3lBVojUJKAr7tqTERxWVFaXFQ3L26OnYV6aASPwS+0S/YJwWXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=d4P55+dk; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="d4P55+dk"
Message-ID: <37bd2be353f839c1cb13b0d18bc9e8903b31f9c0.camel@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1771412946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UKDN/8jCQ/f/4GdhcHRKTYtx0IplQ3Rvt9P88Sm0m+k=;
	b=d4P55+dkAZcaZsMZANI+IqX4gmfQVbDa1PzszINq/V5yUstJPHI5K9UdGo39Ohs4Zq29ut
	s1MSdhwOsEPT5eJOZQ12e16vHZig3JNq+T8tntsX/Ar3X4yrXV1I3Zdnp4eaEsz67r5mC7
	iS3FYK+q0COjfWegsXHIQOJkQ9FiN4c=
Subject: Re: [PATCH v2] sparc: Fix page alignment in dma mapping
From: Stian Halseth <stian@itx.no>
To: Marek Szyprowski <m.szyprowski@samsung.com>, John Paul Adrian Glaubitz
	 <glaubitz@physik.fu-berlin.de>
Cc: "David S. Miller" <davem@davemloft.net>, Andreas Larsson
	 <andreas@gaisler.com>, Leon Romanovsky <leon@kernel.org>, 
	sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 18 Feb 2026 12:09:06 +0100
In-Reply-To: <0bdd9ad5-e1b4-4dea-b936-e078b19d2996@samsung.com>
References: 
	<60c8265afe8be501a9eb5c811c5b564b0842b156.camel@physik.fu-berlin.de>
	 <CGME20260217171231eucas1p1f915cdb1081b194466431155fd8ec136@eucas1p1.samsung.com>
	 <20260217171104.5643-3-stian@itx.no>
	 <0bdd9ad5-e1b4-4dea-b936-e078b19d2996@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-02-18 at 11:28 +0100, Marek Szyprowski wrote:
> On 17.02.2026 18:10, stian@itx.no=C2=A0wrote:
> > From: Stian Halseth <stian@itx.no>
> >=20
> > 'phys' may include an offset within the page, while 'base_paddr' is
> > already
> > page-aligned. This caused incorrect DMA mapping in dma_4u_map_phys
> > and
> > dma_4v_map_phys.
> >=20
> > Fix both functions by masking phys with IO_PAGE_MASK or subtracting
> > the
> > page offset, covering both generic SPARC code and sun4v.
> >=20
> > Fixes: 38c0d0ebf520 ("sparc: Use physical address DMA mapping")
> > Reported-by: Stian Halseth <stian@itx.no>
> > Closes: https://protect2.fireeye.com/v1/url?k=3D4d8fbc00-1214850c-
> > 4d8e374f-000babff3563-ee1be24be576e072&q=3D1&e=3D0f8967ce-f558-4339-
> > bddb-
> > f324ec46c035&u=3Dhttps%3A%2F%2Fgithub.com%2Fsparclinux%2Fissues%2Fiss
> > ues%2F75
> > Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Signed-off-by: Stian Halseth <stian@itx.no>
> > ---
> > =C2=A0 arch/sparc/kernel/iommu.c=C2=A0=C2=A0=C2=A0=C2=A0 | 2 ++
> > =C2=A0 arch/sparc/kernel/pci_sun4v.c | 2 +-
> > =C2=A0 2 files changed, 3 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/arch/sparc/kernel/iommu.c b/arch/sparc/kernel/iommu.c
> > index 46ef88bc9c26..f3755a388ac7 100644
> > --- a/arch/sparc/kernel/iommu.c
> > +++ b/arch/sparc/kernel/iommu.c
> > @@ -312,6 +312,8 @@ static dma_addr_t dma_4u_map_phys(struct device
> > *dev, phys_addr_t phys,
> > =C2=A0=C2=A0 if (direction !=3D DMA_TO_DEVICE)
> > =C2=A0=C2=A0 iopte_protection |=3D IOPTE_WRITE;
> > =C2=A0=20
> > + phys -=3D offset_in_page(phys);
> > +
>=20
> I've just noticed that IO_PAGE_SIZE might not equal to PAGE_SIZE (not
> sure if this is=C2=A0true in case of SPARCs), so it would be better to
> rely=20
> on IO_PAGE_MASK or IO_PAGE_SIZE only. Just unify the fix for the both
> affected functions either by masking phys with IO_PAGE_SIZE where it
> is=20
> used or by subtracting (phys & ~IO_PAGE_MASK) from it.
>=20

Good point, and thanks for the review.

I failed to consider that the offset_in_page is based on PAGE_SIZE, not
IO_PAGE_SIZE.

Suggestion, subtract IO_PAGE_MASK in both functions.

arch/sparc/kernel/iommu.c:
 -phys -=3D offset_in_page(phys)
 +phys &=3D IO_PAGE_MASK;


arch/sparc/kernel/pci_sun4v.c (better to subtract before loop?):
 +phys &=3D IO_PAGE_MASK;

 for (i =3D 0; i < npages; i++, phys +=3D IO_PAGE_SIZE) {
         -long err =3D iommu_batch_add(phys & IO_PAGE_MASK, mask);
         +long err =3D iommu_batch_add(phys, mask);
         if (unlikely(err < 0L))
                 goto iommu_map_fail;
 }

Is this acceptable, and in line with kernel coding style?

If yes, I can submit patch v3 with this proposed change.

And Patch v3, should be sent using the message ID of this review
response, right? Still learning :)



> > =C2=A0=C2=A0 for (i =3D 0; i < npages; i++, base++, phys +=3D IO_PAGE_S=
IZE)
> > =C2=A0=C2=A0 iopte_val(*base) =3D iopte_protection | phys;
> > =C2=A0=20
> > diff --git a/arch/sparc/kernel/pci_sun4v.c
> > b/arch/sparc/kernel/pci_sun4v.c
> > index 791f0a76665f..2f30eeac4861 100644
> > --- a/arch/sparc/kernel/pci_sun4v.c
> > +++ b/arch/sparc/kernel/pci_sun4v.c
> > @@ -411,7 +411,7 @@ static dma_addr_t dma_4v_map_phys(struct device
> > *dev, phys_addr_t phys,
> > =C2=A0=C2=A0 iommu_batch_start(dev, prot, entry);
> > =C2=A0=20
> > =C2=A0=C2=A0 for (i =3D 0; i < npages; i++, phys +=3D IO_PAGE_SIZE) {
> > - long err =3D iommu_batch_add(phys, mask);
> > + long err =3D iommu_batch_add(phys & IO_PAGE_MASK, mask);
> > =C2=A0=C2=A0 if (unlikely(err < 0L))
> > =C2=A0=C2=A0 goto iommu_map_fail;
> > =C2=A0=C2=A0 }
>=20
> Best regards

--=20
Med vennlig hilsen
Stian Halseth
Mobile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0+47 406 77 777
Office(dir)=C2=A0+47 236 80 400 (402)
E-mail=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0stian@itx=
.no
=E2=80=8B=E2=80=8B

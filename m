Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C3F36E480;
	Tue, 17 Feb 2026 17:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771349585; cv=none; b=swy4vFWjydihKrew7B0QWYrrahLY3azvtQECw4WFzAHFe/v9vdQqpGvyxSzpnN1fuziAVYenXAyuMkuq0ez5bx+SwQhIw5IQiEsuoisycj4Uk8mggc8PQ2ecnZ1iHoifrMrXN0aZ47mYmRw1RHNI6sWOvtxK7sA+tnXTnilhQjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771349585; c=relaxed/simple;
	bh=KvN5MEWSVPEhtzyoHHu1wdDZ3JbLZw9/yyCCauX75gA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gx6xf7B9ZGHdOZhX+PFdqfmMbq9Gl1crJ0NBoyKXahvn6PyWymUT0IjsxJaxwC2gpptf603bY2uG2Adbfxwkq/FZQ0zCdgG7+hkGX1rmNZxS8lGb2FdLBXq84H9lhdAn0NpzvQK4GAEZMoZ8VL5VSS3aX4Zd2NJ8dn0fk3ORm8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=TdiIrSt6; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="TdiIrSt6"
Message-ID: <4d219c0521dc14e51ffffc954d283dfd05fdce38.camel@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1771349581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KvN5MEWSVPEhtzyoHHu1wdDZ3JbLZw9/yyCCauX75gA=;
	b=TdiIrSt6D8CahuVrBXn8N2ybMCME5DIm1n41nXrFmHOEcU/DNcdx10lHKJ6uc9tth7sKoN
	Ya3n9M3LT6ht8u21f6C+GcnjlEj06ClJhvCB81UI/fmqfo9yqUnsDNT6gLYELU7zo/0xv3
	C2UQotDwTecjGStpWURIy+XemUVBFEE=
Subject: Re: [PATCH] sparc: iommu/pci_sun4v: fix page alignment in dma
 mapping
From: Stian Halseth <stian@itx.no>
To: Leon Romanovsky <leon@kernel.org>, John Paul Adrian Glaubitz
	 <glaubitz@physik.fu-berlin.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, David Miller
	 <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 17 Feb 2026 18:33:01 +0100
In-Reply-To: <b3da4bf0-d66a-404c-8d29-cfd58f89e84e@app.fastmail.com>
References: <20260217162141.4669-2-stian@itx.no>
	 <60c8265afe8be501a9eb5c811c5b564b0842b156.camel@physik.fu-berlin.de>
	 <3a12bf53d43c608968a97350a6b6a7db9df612dd.camel@itx.no>
	 <2124864d0640cd5d8f0697b1d01061ccf3e4243c.camel@physik.fu-berlin.de>
	 <b3da4bf0-d66a-404c-8d29-cfd58f89e84e@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Leon,


On Tue, 2026-02-17 at 19:25 +0200, Leon Romanovsky wrote:
>=20
>=20
> On Tue, Feb 17, 2026, at 19:16, John Paul Adrian Glaubitz wrote:
> > Hi Stian,
> >=20
> > On Tue, 2026-02-17 at 17:48 +0100, Stian Halseth wrote:
> > > Thanks for the review and suggestions.
> > >=20
> > > On Tue, 2026-02-17 at 17:38 +0100, John Paul Adrian Glaubitz
> > > wrote:
> > > > Hi Stian,
> > > >=20
> > > > please rephrase the subject to:
> > > >=20
> > > > =C2=A0sparc: Fix page alignment in dma mapping
> > > >=20
> > > > Your patch is not specific to sun4v but also fixes generic
> > > > sparc
> > > > code,
> > > > so you should remove the part "iommu/pci_sun4v:" from the
> > > > subject.
> > > >=20
> > > Understood =E2=80=94 I will update the patch subject as suggested.
> > > > On Tue, 2026-02-17 at 17:21 +0100, stian@itx.no=C2=A0wrote:
> > > > > From: Stian Halseth <stian@itx.no>
> > > > >=20
> > > > > 'phys' may include an offset within the page, while
> > > > > 'base_paddr' is
> > > > > already page-aligned.
> > > > >=20
> > > > > This caused incorrect DMA mapping in dma_4u_map_phys and
> > > > > dma_4v_map_phys.
> > > > >=20
> > > > > Fix both functions by masking phys with IO_PAGE_MASK or
> > > > > subtracting
> > > > > the page offset.
> > > >=20
> > > > Please remove the newlines between your sentences, they're not
> > > > necessary
> > > > and also trim the lines at 80 columns.
> > >=20
> > > Will do =E2=80=94 I=E2=80=99ll reformat the commit message to 80-colu=
mn lines
> > > and remove extra newlines.
> >=20
> > Perfect! I have nothing to add. Let's have Andreas review your
> > patch ;-).
>=20
> Please add Fixes line, so the patch will be taken to stable@ in
> automatic way.
I currently have:
Fixes: 38c0d0ebf520 ("sparc: Use physical address DMA mapping")

Is this sufficient, or do I need to add something else?
>=20
> Thanks=20
>=20
> >=20
> > Adrian
> >=20
> > --=20
> > =C2=A0.''`.=C2=A0 John Paul Adrian Glaubitz
> > : :' :=C2=A0 Debian Developer
> > `. `'=C2=A0=C2=A0 Physicist
> > =C2=A0 `-=C2=A0=C2=A0=C2=A0 GPG: 62FF 8A75 84E0 2956 9546=C2=A0 0006 74=
26 3B37 F5B5 F913

--=20
Best regards
Stian Halseth
=E2=80=8B

Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963932DB7A1;
	Tue, 17 Feb 2026 17:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771348600; cv=none; b=f1WmN9N0mCAQvLCyi8mG2O6LCnGzCjOzx9xMqAG1hpTjQTt0ZtJ70gdDasuLAEqdmS0p74D2rDj2bk/d+/PWFQJoqTXgrwLq5oVXOActmmgpHFgMHOHK+XeALnfe1zSSt3PTFWtxce/c1u/H/jZRSOddG6DRIOrrx1btYJaMnYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771348600; c=relaxed/simple;
	bh=wKSqlUYb52EWWcT5qie+A27tFSS4bF6tMtFGPKf2nIo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dMmOZtnvdEi0RCHirhNTsP5KIfrbH+aQ6pwohj3atkIiY3SoPFjMLgbS3HcziSjOpUEVUKP1mfWyTToc0vwUloWyK1pF6/nZrzJedHuoGF//9BYKzUmbelWvJ/WrYO2TlFrdTpyXIEt073c1ug1+ZtyInEqA8DyQqphC7YbGGoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=AND2eojg; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="AND2eojg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=6+wNL2bLdnEX8GzBE6A/Gil1zT4vc0gX6oVpX3SUp7o=; t=1771348598;
	x=1771953398; b=AND2eojgqv8Um6E86/EMZUHWnNlqLO7dbbrtAkmQl8xLWtlDpTUrfmyQEiGzE
	E5q0J8R7qgsBGKuqBhpGldshHViPBSwZ9RgN+S5/nP/0UHuMkMVYNC4Uz1SpU9cbuw9aZPMm4ym/Z
	Sc5saGhApAtMsiRylI0XGDOaXe3zhAPP/I+DLR/1a4YuUuwmEGtEVNMhU8I+yfN/7KicZf6GQ7zrV
	NohoxsTyaPvdH5Ops7+G6eZWtMDGz2axzpsHd6mQn5ebHnsvxORIGwWSoElZbtTTcuGWyBPtyVtuS
	VT2jLmgdPYWSTMZvlxMZSjyX+VsZYdMox+OAWn6e6fr4yHG7KQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1vsOgc-00000001PGO-0SEl; Tue, 17 Feb 2026 18:16:34 +0100
Received: from p5dc55f29.dip0.t-ipconnect.de ([93.197.95.41] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1vsOgb-00000001175-3h0N; Tue, 17 Feb 2026 18:16:34 +0100
Message-ID: <2124864d0640cd5d8f0697b1d01061ccf3e4243c.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sparc: iommu/pci_sun4v: fix page alignment in dma
 mapping
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Stian Halseth <stian@itx.no>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, "David S. Miller"	
 <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, Leon
 Romanovsky	 <leon@kernel.org>, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 17 Feb 2026 18:16:33 +0100
In-Reply-To: <3a12bf53d43c608968a97350a6b6a7db9df612dd.camel@itx.no>
References: <20260217162141.4669-2-stian@itx.no>
		 <60c8265afe8be501a9eb5c811c5b564b0842b156.camel@physik.fu-berlin.de>
	 <3a12bf53d43c608968a97350a6b6a7db9df612dd.camel@itx.no>
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

On Tue, 2026-02-17 at 17:48 +0100, Stian Halseth wrote:
> Thanks for the review and suggestions.
>=20
> On Tue, 2026-02-17 at 17:38 +0100, John Paul Adrian Glaubitz wrote:
> > Hi Stian,
> >=20
> > please rephrase the subject to:
> >=20
> > =C2=A0sparc: Fix page alignment in dma mapping
> >=20
> > Your patch is not specific to sun4v but also fixes generic sparc
> > code,
> > so you should remove the part "iommu/pci_sun4v:" from the subject.
> >=20
> Understood =E2=80=94 I will update the patch subject as suggested.
> > On Tue, 2026-02-17 at 17:21 +0100, stian@itx.no=C2=A0wrote:
> > > From: Stian Halseth <stian@itx.no>
> > >=20
> > > 'phys' may include an offset within the page, while 'base_paddr' is
> > > already page-aligned.
> > >=20
> > > This caused incorrect DMA mapping in dma_4u_map_phys and
> > > dma_4v_map_phys.
> > >=20
> > > Fix both functions by masking phys with IO_PAGE_MASK or subtracting
> > > the page offset.
> >=20
> > Please remove the newlines between your sentences, they're not
> > necessary
> > and also trim the lines at 80 columns.
>=20
> Will do =E2=80=94 I=E2=80=99ll reformat the commit message to 80-column l=
ines
> and remove extra newlines.

Perfect! I have nothing to add. Let's have Andreas review your patch ;-).

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

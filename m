Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F405136E46B;
	Tue, 17 Feb 2026 17:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771350749; cv=none; b=IwfhZn1xZa+mLxyyNeEGKP7pfANm/XtgK2mXRm6rd1rdROvkSyJJgIFUx0udqqjT7WqF4+4clWcz/p20xjWHyFUlVRE2Nz0Tegu3CtrQpD8ZhQb5pNhKseOsRJ/JNR6+P8shkWA+s7xmV+s8FQCaZ1RvTNiR4QOjsDl7Hn55umM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771350749; c=relaxed/simple;
	bh=q2iLJvfshxTcU0LU2HsxT7XUUqRumdt2K35bQZYaQkA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=N9iQb19gzGNfDENxVGABgY2qzMdNo/PQx9XVQpJHiUiuDvp0Br7BJfX4LeZqtg7qKCqZk6WwYFLUjRceriUrVh7ZRjlFZC78Kbymg2bVy7RNidFAMpIXsGDPCVbB809QEUPvSF7q426gwnpUUNeI8zoJc+qZTaLBiGCQEOgMkAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJZF36EI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJZF36EI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6565CC4CEF7;
	Tue, 17 Feb 2026 17:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771350748;
	bh=q2iLJvfshxTcU0LU2HsxT7XUUqRumdt2K35bQZYaQkA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=jJZF36EIYp9BTjaggVZzkaxRla8uTcWbGSwnSVkzoYXzLsJ1YQkNRhumrwK0L+tty
	 p1fg+GsSxOjXVn7x5zrmp0NcX7CBQeWvI4iVW0/vYNb0DqVw3mwXkbHsfW8hfiDFiC
	 GvpRm6xaRRqnFA3eh4rzh53DK8YF/3IEUNhAKiK4vylzqXWkbGThyvv69oylCF6RBb
	 ZNiBHYMrAuxwgIqaDzOH4j1w/sc/3KOsnlpFwbVBGtEyl/CXRC3KmtVOpdFosxotM+
	 62KefcQgy7HB7FX4S29pwdGwu0hBV6zONHx0BYAYy73mXaVzoklHvZP56AB2wd1GEO
	 vgf5g+DMpSjlw==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 70F91F4006A;
	Tue, 17 Feb 2026 12:52:27 -0500 (EST)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-04.internal (MEProxy); Tue, 17 Feb 2026 12:52:27 -0500
X-ME-Sender: <xms:26qUafP3cylGO6m2SgtIf7PA3agPWKJjQEWgd9qSczK1v6IYYPAoew>
    <xme:26qUaUy4twCPj03Dh2Y4hiNuYjmOb_iYzn-aFXDuBQ0vk4Q9p53x-yGTvAorUrPz2
    aIKy3T_FdVO1pZBtItC8oombeN1hatoxjO55aH6iCw_SFmt6n4JLqWx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvddtgeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfnfgvohhn
    ucftohhmrghnohhvshhkhidfuceolhgvohhnsehkvghrnhgvlhdrohhrgheqnecuggftrf
    grthhtvghrnhepteegudfgueelueefgfffvefgleetteekgeehtdelgfffieevgfeuteej
    hfetheegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eplhgvohhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduvdeftdehfeel
    keegqddvjeejleejjedvkedqlhgvohhnpeepkhgvrhhnvghlrdhorhhgsehlvghonhdrnh
    hupdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegu
    rghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvggrshesgh
    grihhslhgvrhdrtghomhdprhgtphhtthhopehsthhirghnsehithigrdhnohdprhgtphht
    thhopehglhgruhgsihhtiiesphhhhihsihhkrdhfuhdqsggvrhhlihhnrdguvgdprhgtph
    htthhopehmrdhsiiihphhrohifshhkihesshgrmhhsuhhnghdrtghomhdprhgtphhtthho
    pehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehsphgrrhgtlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:26qUaQy4llKh7BvVchEBImPuJ9EZO_ancf-XS5PK18-1wMnDt-C0Sg>
    <xmx:26qUaTUgADUGYH3BqLcAu0af5LrEyx8vFop2ZBbmE-MacJvvw3I-vA>
    <xmx:26qUaYgSZuiI5z9syuOnFWv36GTl5BeVw28WVxmS14mmaEQcMz4Pmw>
    <xmx:26qUabAxZSK5GVMiVskgJ9nbFTQBw0uQE2Cn-uHyXSr_xfyWMZhu4Q>
    <xmx:26qUaWvWOCYsgZ9d-PU-HBsjBOwQQzbjLD2ZhtQS6QUJryzU2Uf-IYEQ>
Feedback-ID: i927946fb:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 50E792CE0072; Tue, 17 Feb 2026 12:52:27 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Aqza6KJWDazJ
Date: Tue, 17 Feb 2026 19:52:07 +0200
From: "Leon Romanovsky" <leon@kernel.org>
To: "Stian Halseth" <stian@itx.no>,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>
Cc: "Marek Szyprowski" <m.szyprowski@samsung.com>,
 "David Miller" <davem@davemloft.net>,
 "Andreas Larsson" <andreas@gaisler.com>, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <359aa017-ca72-460d-96dc-c3b46edb186c@app.fastmail.com>
In-Reply-To: <4d219c0521dc14e51ffffc954d283dfd05fdce38.camel@itx.no>
References: <20260217162141.4669-2-stian@itx.no>
 <60c8265afe8be501a9eb5c811c5b564b0842b156.camel@physik.fu-berlin.de>
 <3a12bf53d43c608968a97350a6b6a7db9df612dd.camel@itx.no>
 <2124864d0640cd5d8f0697b1d01061ccf3e4243c.camel@physik.fu-berlin.de>
 <b3da4bf0-d66a-404c-8d29-cfd58f89e84e@app.fastmail.com>
 <4d219c0521dc14e51ffffc954d283dfd05fdce38.camel@itx.no>
Subject: Re: [PATCH] sparc: iommu/pci_sun4v: fix page alignment in dma mapping
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Tue, Feb 17, 2026, at 19:33, Stian Halseth wrote:
> Hi Leon,
>
>
> On Tue, 2026-02-17 at 19:25 +0200, Leon Romanovsky wrote:
>>=20
>>=20
>> On Tue, Feb 17, 2026, at 19:16, John Paul Adrian Glaubitz wrote:
>> > Hi Stian,
>> >=20
>> > On Tue, 2026-02-17 at 17:48 +0100, Stian Halseth wrote:
>> > > Thanks for the review and suggestions.
>> > >=20
>> > > On Tue, 2026-02-17 at 17:38 +0100, John Paul Adrian Glaubitz
>> > > wrote:
>> > > > Hi Stian,
>> > > >=20
>> > > > please rephrase the subject to:
>> > > >=20
>> > > > =C2=A0sparc: Fix page alignment in dma mapping
>> > > >=20
>> > > > Your patch is not specific to sun4v but also fixes generic
>> > > > sparc
>> > > > code,
>> > > > so you should remove the part "iommu/pci_sun4v:" from the
>> > > > subject.
>> > > >=20
>> > > Understood =E2=80=94 I will update the patch subject as suggested.
>> > > > On Tue, 2026-02-17 at 17:21 +0100, stian@itx.no=C2=A0wrote:
>> > > > > From: Stian Halseth <stian@itx.no>
>> > > > >=20
>> > > > > 'phys' may include an offset within the page, while
>> > > > > 'base_paddr' is
>> > > > > already page-aligned.
>> > > > >=20
>> > > > > This caused incorrect DMA mapping in dma_4u_map_phys and
>> > > > > dma_4v_map_phys.
>> > > > >=20
>> > > > > Fix both functions by masking phys with IO_PAGE_MASK or
>> > > > > subtracting
>> > > > > the page offset.
>> > > >=20
>> > > > Please remove the newlines between your sentences, they're not
>> > > > necessary
>> > > > and also trim the lines at 80 columns.
>> > >=20
>> > > Will do =E2=80=94 I=E2=80=99ll reformat the commit message to 80-=
column lines
>> > > and remove extra newlines.
>> >=20
>> > Perfect! I have nothing to add. Let's have Andreas review your
>> > patch ;-).
>>=20
>> Please add Fixes line, so the patch will be taken to stable@ in
>> automatic way.
> I currently have:
> Fixes: 38c0d0ebf520 ("sparc: Use physical address DMA mapping")
>
> Is this sufficient, or do I need to add something else?

Ohh, you added extra line between signed-of-by and fixes line.

Just remove that extra blank line.

Thanks=20

>>=20
>> Thanks=20
>>=20
>> >=20
>> > Adrian
>> >=20
>> > --=20
>> > =C2=A0.''`.=C2=A0 John Paul Adrian Glaubitz
>> > : :' :=C2=A0 Debian Developer
>> > `. `'=C2=A0=C2=A0 Physicist
>> > =C2=A0 `-=C2=A0=C2=A0=C2=A0 GPG: 62FF 8A75 84E0 2956 9546=C2=A0 000=
6 7426 3B37 F5B5 F913
>
> --=20
> Best regards
> Stian Halseth
> =E2=80=8B

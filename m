Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A79136BCF4
	for <sparclinux@vger.kernel.org>; Tue, 17 Feb 2026 17:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771349172; cv=none; b=JvqFZAFhfT8SsiUyiEQQ2GEQGsdFqK0slXusifd0nDNgQAaT54Nb+JPLriVuGvubCha4WZdxr9RzTMstodtMWfrja4FbA3tT7QUe7W+zRIKGAbKyBeoWMsB5wW4Qps7rvl4fcHtEbU//sOqvgNdMx0kVAdP7NQcfcwVkq7LwwQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771349172; c=relaxed/simple;
	bh=iGftuOpiNzkTR1+5e+SEGO/jCKYRnoh0oQc6uddfaCQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=DwDCfuVaK6adrk37UMw0n6usZUc0h5U0HWk5K0Dw7HfaRf+8L/Dx/W2VJjVo6CBOJDLPl+aRF95qxucWfsh0j55N/xRI9Y5x90ZeQrgOKf4DvDvPrVG7Oad2bIC6jvpckk/HNjQ1GI1P/o316aToDLP1jkjQcd304U6BLCpWhFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hTeZn4EQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hTeZn4EQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D3E0C19421;
	Tue, 17 Feb 2026 17:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771349172;
	bh=iGftuOpiNzkTR1+5e+SEGO/jCKYRnoh0oQc6uddfaCQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=hTeZn4EQRHSHBNsdFlaEHzpetYOyYGz/HY2o9OEQBZ2xNlD6RGiBfrEj4da1yG5gd
	 41TSCfsQlJftChgRTbJZdbU8Sjn2Cfgm9HgHBZbD5VSjmD2tMyhnjBTIha8hqBuDVe
	 NK8G5z18B2TPSxgDuA0EHCEyGk7n3Dm2wjTZGP+62mMRUAfv/NAByw/26wu3YfuVee
	 z7nRCitHSW5hsye7sXJnOkg0l8hBxIG/XsrRowXfXx8CwiG/P9fCE9+goGlmX6/iDd
	 xqy3tc9lHu+6O9gfp1jlLPNMfmfMzv7LrdEWhT6hfTQ1lsyTO44Wux62gzASyHQU/v
	 ic4ArPh5F6qaQ==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id DB522F4006A;
	Tue, 17 Feb 2026 12:26:10 -0500 (EST)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-04.internal (MEProxy); Tue, 17 Feb 2026 12:26:10 -0500
X-ME-Sender: <xms:sqSUaXWehFyG-oO22nUpdvLlX_sQfqUdTTQkv7gU3j68bbNFlxt_zA>
    <xme:sqSUaaZpP_A_T9eEXx5kVPVQRIPrMZn5VpKyhA7kyP9eSoCGbOxDYfc6PHXjN9mxr
    rI2Bs_-XO9Ue3sqajPOHUNfBYEwGYBe-3JhDaj-pcuDiPVK4SpUKrQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvddtfeeiucetufdoteggodetrf
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
X-ME-Proxy: <xmx:sqSUad7gHF3v8hi7IHgKWJHw2DswRXBXWGI0DofjL2nfMYAB6vqy3A>
    <xmx:sqSUaZ8tZPbD9hCPgPxDzV6yRFtJ-APlPHeWw3WtA4OEGxqA6VEk2Q>
    <xmx:sqSUaaoExW1yBqxKV0UW30OFowidAUlNxTNvHtmeUe2AL6746KHy2w>
    <xmx:sqSUaSrWtOyeivIP5Fv_I3UB-Wt63beyvVePj3daNIYGs86GL-eC0Q>
    <xmx:sqSUaV16X0TKsjUaCen1hWDOiVzs7VdQQc5Gc0jJws338Vi8gnsFxDrj>
Feedback-ID: i927946fb:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 039542CE0072; Tue, 17 Feb 2026 12:26:10 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Aqza6KJWDazJ
Date: Tue, 17 Feb 2026 19:25:35 +0200
From: "Leon Romanovsky" <leon@kernel.org>
To: "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 "Stian Halseth" <stian@itx.no>
Cc: "Marek Szyprowski" <m.szyprowski@samsung.com>,
 "David Miller" <davem@davemloft.net>,
 "Andreas Larsson" <andreas@gaisler.com>, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <b3da4bf0-d66a-404c-8d29-cfd58f89e84e@app.fastmail.com>
In-Reply-To: 
 <2124864d0640cd5d8f0697b1d01061ccf3e4243c.camel@physik.fu-berlin.de>
References: <20260217162141.4669-2-stian@itx.no>
 <60c8265afe8be501a9eb5c811c5b564b0842b156.camel@physik.fu-berlin.de>
 <3a12bf53d43c608968a97350a6b6a7db9df612dd.camel@itx.no>
 <2124864d0640cd5d8f0697b1d01061ccf3e4243c.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sparc: iommu/pci_sun4v: fix page alignment in dma mapping
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Tue, Feb 17, 2026, at 19:16, John Paul Adrian Glaubitz wrote:
> Hi Stian,
>
> On Tue, 2026-02-17 at 17:48 +0100, Stian Halseth wrote:
>> Thanks for the review and suggestions.
>>=20
>> On Tue, 2026-02-17 at 17:38 +0100, John Paul Adrian Glaubitz wrote:
>> > Hi Stian,
>> >=20
>> > please rephrase the subject to:
>> >=20
>> > =C2=A0sparc: Fix page alignment in dma mapping
>> >=20
>> > Your patch is not specific to sun4v but also fixes generic sparc
>> > code,
>> > so you should remove the part "iommu/pci_sun4v:" from the subject.
>> >=20
>> Understood =E2=80=94 I will update the patch subject as suggested.
>> > On Tue, 2026-02-17 at 17:21 +0100, stian@itx.no=C2=A0wrote:
>> > > From: Stian Halseth <stian@itx.no>
>> > >=20
>> > > 'phys' may include an offset within the page, while 'base_paddr' =
is
>> > > already page-aligned.
>> > >=20
>> > > This caused incorrect DMA mapping in dma_4u_map_phys and
>> > > dma_4v_map_phys.
>> > >=20
>> > > Fix both functions by masking phys with IO_PAGE_MASK or subtracti=
ng
>> > > the page offset.
>> >=20
>> > Please remove the newlines between your sentences, they're not
>> > necessary
>> > and also trim the lines at 80 columns.
>>=20
>> Will do =E2=80=94 I=E2=80=99ll reformat the commit message to 80-colu=
mn lines
>> and remove extra newlines.
>
> Perfect! I have nothing to add. Let's have Andreas review your patch ;=
-).

Please add Fixes line, so the patch will be taken to stable@ in automati=
c way.

Thanks=20

>
> Adrian
>
> --=20
>  .''`.  John Paul Adrian Glaubitz
> : :' :  Debian Developer
> `. `'   Physicist
>   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

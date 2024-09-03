Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542791C768A
	for <sparclinux@vger.kernel.org>; Tue,  3 Sep 2024 09:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725355351; cv=none; b=pADhZaR949N1JZWJC63PXAwdE+lf/6bc1GZeuayCxhUAvwy9xhQBr4xbEYXU+OBznJmOA3upomK5XsK/knyY96hhAIpTh2TKnja2KD4lrBxlIQ00rUhHTXQIQztwsntO14HsbW3EHH/vuODw/4Krfx0gRbAA9Mr0VUS3P9z9nFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725355351; c=relaxed/simple;
	bh=DMF1dizToCJNRnn473u3BRPHzZIv9q/N1A0cNuiDumM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H3K2wMaeMD5/sOCq2GKVksL8NybWPYN/QzI7yrHjS8VuVlqug5STQAGQ1k0pvYFzvTKtoFNuDncHsKQX/bGy8IH1KVlT4Ch5eE4TgtHziwwyFQNv8Sh4HeCnpjGkxCtLv4nsTvpU2enwljh3ldlpzk7B0bjzG/BfUxPxa/0FCyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=JX3NdfP8; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="JX3NdfP8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qnM2gK5NdGjBLF/5F/M4KRNE4zeSeN6pM63qk6yVXLs=; t=1725355347; x=1725960147; 
	b=JX3NdfP8xWWxRqTMDEbA944qkXf/CZYB7A0v8mxFv82S7wVR4d2uxdxYvMMfMykooEnA1YVtwiV
	636N48fDgE1FlEi/LH/dHzdZvXNneajmOe3kTeQm/yo74KoIj4waH1U0QIX5Uo9PNubaipgakbFbp
	m2KsTNm8qTRmyqOZkNFXUdaogjHimfiHv0HVpbyOjFKzmDO/R70MW0uGPvYpesXn0yO/w6AQrBlcn
	rvCkFgM1883A+ijZes8a82Me6f4wpT8bmaMOXBhX/MtRLBeRMX4per65xfIq4YtBnWNKBO1oDKWVJ
	PTyrZGvcCcZ51WPIT0JICZ5JLGOmnx/shKjw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1slPk1-000000011u6-1Nyk; Tue, 03 Sep 2024 11:22:25 +0200
Received: from p5b13a591.dip0.t-ipconnect.de ([91.19.165.145] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1slPk1-00000003WdM-0WZ6; Tue, 03 Sep 2024 11:22:25 +0200
Message-ID: <cdcc68cc5967f13b4755b9e18ef54ab4b8a560cd.camel@physik.fu-berlin.de>
Subject: Re: Linux kernel  stability fixes for older SPARCs
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: =?ISO-8859-1?Q?Ren=E9?= Rebe <rene@exactcode.com>
Cc: Ignacio Soriano Hernandez <bond6872@googlemail.com>, sparclinux
	 <sparclinux@vger.kernel.org>, "<debian-sparc@lists.debian.org>"
	 <debian-sparc@lists.debian.org>
Date: Tue, 03 Sep 2024 11:22:24 +0200
In-Reply-To: <E03776ED-377E-4FE5-86B9-A07306E4B4D4@exactcode.com>
References: 
	<caf9102c649a8c76e7eb444ab8c702e3a8da8a52.camel@physik.fu-berlin.de>
	 <E03776ED-377E-4FE5-86B9-A07306E4B4D4@exactcode.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hello Rene,

On Tue, 2024-09-03 at 11:09 +0200, Ren=C3=A9 Rebe wrote:
> > according to these posts [1][2] by Iggi, you figured out the stability =
problem
>=20
> No, we are just sometimes lucky it run that long stable. I was only made =
aware
> recently that sun4u was not 100% and my fasted UltraSPARC until some year=
 ago
> was only a 360MHz Ultra5 until I was donated a Sun Blade 1000 recently. I=
 see
> some MM corruption that I wanted to hunt next.

Hmm, ok. I was under the impression that you made some changes that made th=
e kernel
on Iggi's machine stable. Currently, the kernel crashes randomly on older S=
PARCs
such as reported by Iggi:

> https://x.com/Iggi76123640/status/1827658841581896152

> > with newer kernels on older SPARC machines. There has been a regression=
 on older
> > SPARCs since around kernel 4.19.x which I haven't gotten around to bise=
cting yet.
>=20
> Happy to bi-sect. I guess you mean random memory corruption I see or anyt=
hing
> else?

Not sure what the underlying issue is, but the kernel just crashes complete=
ly.

> If you have issues to bi-sect just let us know for any arch. Given T2=E2=
=80=99s cross-compile
> support and I have most hardware in my museum now, I can usually bisect i=
ssues
> within a day or two.

I don't have issues with bisecting, I'm just rather time-constrained at the=
 moment, so
I'm always happy when someone else can step in and help. Would be great to =
get this issue
fixed upstream.

> > If you've found and fixed the bug in question, it would be great if you=
 could share
> > your fix with the community and maybe whip up a kernel patch to fix the=
 bug upstream.
>=20
>=20
> Of course - all patches are always nicely sorted in our public and nicely=
 readable
> SVN tree in any case.
>=20
> 	https://t2linux.com

Is there a web view available? I'm not really a big fan of SVN, to be hones=
t.

> > Newer SPARCs are not affected by this bug, although there are other iss=
ues.
>=20
> You mean sun4v? I found a cheap T4-1 some month ago, and T2/Linux appears
> to run stable on that. Any list of issues w/ sun4v I should be aware of?

Linux runs mostly stable on sun4v, but there are filesystem corruption issu=
es when you
run Linux inside an LDOM on Solaris 11.3 and 11.4 even with the latest SRU =
of Solaris.

These happen rarely, but they do occur and they are quite annoying as they =
mandate rebooting
the LDOM as the root filesystem is mounted read-only and the filesystems as=
 errors afterwards.

It seems to be a bug in the LDOM vdisk driver (drivers/block/sunvdc.c).

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

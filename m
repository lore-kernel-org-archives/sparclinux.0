Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.189.121.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793055477;
	b=T1CtWlHUZghNkstraYZMBOGGdQmE5nNy21NXrEWaveGYBQRFP1VgjsHdRmf1xFcYUpPx
	 Kwi1l2Rg9Xv5ifVUj3X//4oziZ0sqO8vPFwtIyLMC9iLa03u1x6682vnIUjPhUIpIAaGn
	 2xRsLB5Bb+8vzyYZqzbAbMJOL7rXyEQGZWQi+D1P1bpoR4ugFEOseCf4oqu9wruRYn5Q1
	 lL0bUkMrrW7yaXh96NMAmD7jU5R2PNTwxKR11MOeE+ytXiDRdFTrhUiHC4UJPuRiQo2S3
	 Gzi03x8pgBSSRzUy1QQC2IVNLYKZJsVyKW/LBjjL6W00ZvCRpqQSOgcAjqIBWXoGlpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793055477;
	h=DMARC-Filter:Message-ID:DKIM-Signature:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Content-Type:MIME-Version;
	bh=S8/llgcaB/mpDHfwRwYWWVTl9b+7/f/8AxF57QOJwNg=;
	b=HoRBy7Kt52pc7vt+C4oxN9QcpaBJsSfEKidiUPHfWVAy9cEO5se3YfVHXtfnpREMP8tp
	 da2/tXxhHUubmty3Hc+pgMx/ccPB9OxLjBPVCRDqkGbFwDqB5BEbD1SmDQVcTRYIYFpYr
	 NWnyvsYLMRsDj2yvCiLk+jggixJIlXgncRQBSZ04SWMLSKLG1jgrn8HPGSMEVuWcIlE76
	 mgXxVgq8G/uuhLQcI+ahiib8AM9MEvGYvYCXZsejJO1stZFAA+CsI2HbZGQdawa1soJS8
	 eCc+s4yw48qnbvFbqBaSf5aKJIbL9n2czooZESsm5E5QoAvF9eXKCWr9ru/WSriS+vQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=itx.no;
	spf=pass smtp.mailfrom=itx.no;
	dkim=pass header.d=itx.no header.i=@itx.no header.a=rsa-sha256 header.s=mx.itx.no header.b=MRYSb8OE;
	arc=none smtp.remote-ip=91.189.121.228
Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BFC606A322
	for <sparclinux@vger.kernel.org>; Mon, 26 Oct 2026 22:57:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4BFC606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=itx.no header.i=@itx.no header.a=rsa-sha256 header.s=mx.itx.no header.b=MRYSb8OE
Message-ID: <45d2a73a509ce040fefd667879cd77d7e618da72.camel@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1793055474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S8/llgcaB/mpDHfwRwYWWVTl9b+7/f/8AxF57QOJwNg=;
	b=MRYSb8OEJtiBC/LWeRlWxeS4KPVQNm9X4fZENyOiEfrddFKOWLhyEd8uYiFf+IaykBCiR8
	KjddO4/YAQZfPfoDtA99elR4cqk1pb1QC6sZp/QP6cwI2N2LyAi/p5bWhUN+EJsl4G4EQ5
	7IL3/YD4KbJnEBG8QKOaw/B7rbS3d5Q=
Subject: Re: [PATCH] sparc: populate sysfs cache topology information on
 sun4v
From: Stian Halseth <stian@itx.no>
To: Jan Engelhardt <ej@inai.de>
Cc: sparclinux@vger.kernel.org
Date: Mon, 26 Oct 2026 23:57:53 +0100
In-Reply-To: <90rrs2po-oq65-pqp4-s7q3-90r5ns5qqn60@vanv.qr>
References: <20261026193421.20404-1-jengelh@inai.de>
	 <3c24c1f0a16ed4b2f58c3288ae100b48be005c75.camel@itx.no>
	 <90rrs2po-oq65-pqp4-s7q3-90r5ns5qqn60@vanv.qr>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-PKDY7/nqFSbwifhTAkJL"
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0


--=-PKDY7/nqFSbwifhTAkJL
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Jan,

On Mon, 2026-10-26 at 22:27 +0100, Jan Engelhardt wrote:

> Which two? I have 16 of them.

Two per cpu node. On my T4-1 and T7-1 every cpu node has three
exec-unit children:

  ifetch                                               -> L1i
  integer,integer-load,integer-store,fp-load,fp-store  -> L1d
  fp,integer,vis,crypto                                -> no cache

Both of the last two match "integer", and mdesc_find_subobject()
returns the first one, which is the one with the L1d on both boxes. I
don't know if any firmware actually orders them differently, so it
might not be worth worrying too much about.=20


> (If you want, you can send me a directed mail with the contents from
> /dev/mdesc and maybe it will enlighten me.)

Let me know if you still need it, or if you have all you need in the
table above.

>=20
> "int" was there in the old code (since commit
> f78eae2e6f5d1eb05f76a45486286445b916bd92), I just took it.
>=20
>=20
> > - mdesc_find_subobject() passes NULL and an uninitialized len on if
> > =A0there is no "type" property.
>=20
> This too was rooted in old code which assumed that "type" always
> exists.
>=20

Ok, those are probably fine then.

/Stian


--=-PKDY7/nqFSbwifhTAkJL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTK1ph9OaYoND1R57zoeAEuJe36VgUCat/a8QAKCRDoeAEuJe36
ViS1AQCYp2SdzSvKcJmwbOO+/OnMgUltX7W1X0Bbv7Jy/ZXFtQD+OI8TgxiIawDR
T1/gD8EtKxMOYTPWQSxGnD0E1v4rMAI=
=OdiE
-----END PGP SIGNATURE-----

--=-PKDY7/nqFSbwifhTAkJL--

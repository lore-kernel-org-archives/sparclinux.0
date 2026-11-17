Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.189.121.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794919459;
	b=bthx8kJBXTbWWKLU9AQRhxbKPa1ut1+SNuqzDl0u3zOJQEOnPsrPvrDrQMfiktJrKBph
	 8uZfAXatPMEJaAtCD02SY7FsYHMCWsYsd0LBbhUPLKb3GZqC4A9y8ikV7fwvEgT80+EZr
	 ocGIIT4JUHiJtwXOgVYoZ52PLL5fLr92CAysadDyg4CyUxeJNPhkCVfJIuuWLI6D+lHYd
	 QeJN93QAIo/HDQG3U+b3uXbdkRRNJD3Y/iTZJXsxSW8w5BxspdS3kxuSFAIeVye9nSo4l
	 DdU93Gj/dIkgttaA35wttZnR22prHSO/No04EqbJR5V9n0FGAXYTv9FeX2N5Ny9M48w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794919459;
	h=DMARC-Filter:Message-ID:DKIM-Signature:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Content-Type:MIME-Version;
	bh=0oMpxMqAh1huD7QvmrRmZJkCRKZ5apl5xyHDTsm2JJw=;
	b=Zofny9z6IlJP85EGS/a5HHIxERHcHjemRYdBeLxUFr/4VN6vF9IDdPkEhGWLkXPRVRJq
	 DngKXfASDxu5hdlJ0vVDPia6xehd2FeVPVXTluApO+SWDyTpJ4Zhqt9DPEQuiRJBjddBO
	 SIBXkhoiFRwi5Kijn0G7Lc3E0FBuvIRV9gpxX13Bd2C9BzoYN8OjkPrCNsqwRYhD+zvt5
	 G8JCGlsrCskOvQOfd7l3a4fgUZtRvGNh4dFpwpOe5QUgeTc0ci//b0HbW1U2KcROSj74S
	 OVCO0N+UEIeo9nuJYfgDDNj4eI8c+PojJeii4kYBgmjvUx+mIJuNplTkaQMMVy2J4BQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=itx.no;
	spf=pass smtp.mailfrom=itx.no;
	dkim=pass header.d=itx.no header.i=@itx.no header.a=rsa-sha256 header.s=mx.itx.no header.b=Vfyqj0f7;
	arc=none smtp.remote-ip=91.189.121.228
Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E2C606A323;
	Tue, 17 Nov 2026 12:44:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5E2C606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=itx.no header.i=@itx.no header.a=rsa-sha256 header.s=mx.itx.no header.b=Vfyqj0f7
Message-ID: <8c0c3734b9ad1ba0072ce1fbcf895b544563798f.camel@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1794919456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0oMpxMqAh1huD7QvmrRmZJkCRKZ5apl5xyHDTsm2JJw=;
	b=Vfyqj0f72ALQ/u7eN/0j8cbqTU95GvMzRaoRfB+Krw2PHCHJjECcgJkPZ7dfedjVob+JaI
	NsQIetAtcU+qFsai8utJWoCEL1XQFYr1L+mOcg/Kal0AiuKcxySHKYVceq4SIzVd6DOQW5
	G07VxzqaJAgnmnWjEOS9F2XwIRrBHNA=
Subject: Re: [PATCH] sparc64: Read qemu,hwcap-list from the OF cpu node on
 sun4u
From: Stian Halseth <stian@itx.no>
To: sashiko-reviews@lists.linux.dev, sparclinux@vger.kernel.org
Cc: Andreas Larsson <andreas@gaisler.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Biggers <ebiggers@kernel.org>, Mark Cave-Ayland
 <mark.cave-ayland@ilande.co.uk>, linux-kernel@vger.kernel.org
Date: Tue, 17 Nov 2026 13:44:14 +0100
In-Reply-To: <sashiko-outbox-218725@kernel.org>
References: <20261117112914.2300417-1-stian@itx.no>
	 <sashiko-outbox-218725@kernel.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-OgfmDeW2u+LdEbYAhuII"
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0


--=-OgfmDeW2u+LdEbYAhuII
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 2026-11-17 at 11:46 +0000, sashiko-bot@kernel.org wrote:
>=20
> [Severity: High]
> This problem wasn't introduced by this patch, but can hwcap_list_caps()
> read out of bounds and loop forever [1] if the property buffer is not
> null-terminated?

Yes,=A0and we can fix that in v2. As it stands the parser trusts the list
to end with a NUL, which is not guaranteed if a QEMU user supplies a
fw_cfg file directly.

>=20
> [Severity: High]
> Does setting HWCAP_SPARC_CRYPTO in sparc64_elf_hwcap on sun4u cause a
> regression where the sparc64 skcipher drivers corrupt FPU state and round
> keys across skcipher_walk_done()?
>=20

This might be a bit worse than I first thought. I was aware of the
self-test failures, as noted in my patch notes, but it looks like this
could also cause some data corruption. Only QEMU can hit it, since no
real sun4u CPU has the crypto opcodes.

I have not reproduced it myself, and before spending time on that,
I would like to get Eric's take on removing the glue code altogether.
If not, we could fix the glue itself, for example by dropping the FP
state before skcipher_walk_done(). IMO that would be maintaining code
that probably should be removed. Not my call, though.

Andreas, please don't apply this patch as-is for now. I will wait for
Eric's reply before proceeding.


/Stian


--=-OgfmDeW2u+LdEbYAhuII
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTK1ph9OaYoND1R57zoeAEuJe36VgUCavxMHgAKCRDoeAEuJe36
VtAtAP40VSMQ5ymr7U87qFc4sjU2DlNO1iIUxQ6PAl/9qkXMbwEAhFXM6W5sZ2WK
P3euzWF5g10P7eRmzRwhw/vt0WCezAU=
=TGk3
-----END PGP SIGNATURE-----

--=-OgfmDeW2u+LdEbYAhuII--

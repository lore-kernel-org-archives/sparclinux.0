Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BCA30DD22
	for <sparclinux@vger.kernel.org>; Sat, 10 Oct 2026 19:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791659176; cv=none; b=g8OtOzOrl+C3FDw1WxBrwtNqM8bGPXRkXcLsOwhrE3ipQKU7Mdqtg3wtiyFjBIp0kYheLtyJgvxeGOdSKg0W/XrQTWKFWhandkrzoWon5tuWATuGTD84+NHtk11RQxvKhOcwJXelLZWe9M/SK+94FhV4IWL7VoFtdtPMKsGxcbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791659176; c=relaxed/simple;
	bh=XJ+26hL9VosPH6X2Xue7xpWMyk9QFX+jQOfvJpE7OtE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZS4N26cpXj2e2en+HIISyWfQkDg8tWyOfZi+D13+vZBdwddN7tzIkhU1u9gCeAsrkAgCOhUj8i2tdgr0fWHI2be9+Xo2YoxCteMjWos2w7V9P25AFDyLdE9ruKCWQyTRICMqxwJQ04BLeroRv6cAeRJKebLxNaNkot3YqGX+VMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=mHmKO1QB; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="mHmKO1QB"
Message-ID: <b85e047233f5b38cdbfbd7af852ce30055680b47.camel@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1791659172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XJ+26hL9VosPH6X2Xue7xpWMyk9QFX+jQOfvJpE7OtE=;
	b=mHmKO1QBJw+EQ7+yAkIpo5qxD56dZUPfh7ACcR5Oq2h1KUSKkZVdsz+nekUzd+NaSSYyll
	mBhMl6YTmr7Smk0aGcHBKW1wFqYu6d1h5hHDTh1dpcMnUL620+j1IcAFvGhwiRctpSgF5E
	4ihpQv+aBUZaL0GESDfFgdfbIoWagqk=
Subject: Re: Mount crashes with SIGILL on v240 on for-next
From: Stian Halseth <stian@itx.no>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, sparclinux
	 <sparclinux@vger.kernel.org>
Cc: Imre Kaloz <kaloz@kernel.org>, Andreas Larsson <andreas@gaisler.com>, 
 Magnus Lindholm <linmag7@gmail.com>
Date: Sat, 10 Oct 2026 21:06:09 +0200
In-Reply-To: <ed3c37da1320ac19bd45dbfaa89957d9a8c05e0f.camel@physik.fu-berlin.de>
References: 
	<b74cffe77f82562fae8cf611349e765f1f38af2c.camel@physik.fu-berlin.de>
	 <14ae2aabb9e681a69818d3e02da8273cd12261b8.camel@itx.no>
	 <69c1798a6409879a70474c10e3d653fdb37c7246.camel@physik.fu-berlin.de>
	 <ef8e85c1fc00c999e74b2d43048bfa67997c13a2.camel@itx.no>
	 <01bd740a7b5f2c5cd12b4ba025fb9a53573188bf.camel@itx.no>
	 <ed3c37da1320ac19bd45dbfaa89957d9a8c05e0f.camel@physik.fu-berlin.de>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-BTiexlPvUf4Gqbo2/M/P"
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-BTiexlPvUf4Gqbo2/M/P
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On Sat, 2026-10-10 at 20:56 +0200, John Paul Adrian Glaubitz wrote:
>=20
> Odd that you can't reproduce it.

I have a dual CPU V240, but compiling uniprocessor kernel wasn't
enough, apparently.
>=20
> > CONFIG_SMP unset, is that intended, do you have a single CPU V240?
>=20
> Yes, that machine has only one CPU.

Ok, makes sense.

>=20
> > If this isn't a regression in the for-next branch, I would try to
> > apply
> > Kaloz v2 patch from sparclinux #29. I cannot reproduce / test, but
> > since you have the issue, I would be very interested to know if it
> > makes a difference:
> > https://lore.kernel.org/all/20260928132102.1707-1-kaloz@kernel.org/
>=20
> Applied both patches, system boots without issues now. Will continue
> testing and see if it's stable.
>=20
Looks like you hit this, where I didn't. Glad it worked. Should
probably look at bringing that patch in as well. I've tested it with no
regression on my dual CPU V240.=20

--=-BTiexlPvUf4Gqbo2/M/P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTK1ph9OaYoND1R57zoeAEuJe36VgUCasqMogAKCRDoeAEuJe36
VmivAP48WvOmZpQF7PVL38NtxsxroJ+EVkudU42Wt1TeoHhZIQEAr65GsnpCseg2
0Xy4i5zGXE9VUVQbloGymg4E76WEewM=
=Mgfq
-----END PGP SIGNATURE-----

--=-BTiexlPvUf4Gqbo2/M/P--

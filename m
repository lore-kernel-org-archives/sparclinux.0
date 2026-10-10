Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF696136672
	for <sparclinux@vger.kernel.org>; Sat, 10 Oct 2026 18:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791657097; cv=none; b=nwI3s5jEeztTEBja+9Cy/vruN8EaF4sQ4mwmSDR0KLZJb7ptXUsi9ZLHVytE98zzu+IoqVyB9XoRZ4NKX89L0JQ9BXjQyIAr8OAyGib4lU5hidFXzO33lZbhNjqIPJRzHd3BLqWWdjvO96RQMmGzT2TpMK+hN7KGO1swz/50vSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791657097; c=relaxed/simple;
	bh=F5QuV40irg6TrqjyAFRcwmYa7bM+G3NAvYEnNG0KBZI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Oi28X4YKJSv8IuIPEDuIuBBnpe3TW61g7jQhNHxPNeSi5H7kyxezYCGBYU/bqR90YayqYHRJeKbwWko7SZM9i9HuZLHbGDvB/0JDRflkz0Lj3aGgrjo+6Q3f/x8RAd8R5hOT8TWwPVecKygLMWefkz1Q+vHTICvO7UEYTvKpbPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=W52tqG6K; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="W52tqG6K"
Message-ID: <01bd740a7b5f2c5cd12b4ba025fb9a53573188bf.camel@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1791657086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F5QuV40irg6TrqjyAFRcwmYa7bM+G3NAvYEnNG0KBZI=;
	b=W52tqG6KF93fNkHGhAMi8GibAgwp8pgfKrBVqXi4BJNStYll6LdJFHTT5IMk2AerIS9d6x
	LQe1kRIixc2Oqt5W+wUg/hYt37eCfrgS/iny3yOSe0+hkqEczvIyR9hkPlhpngic2thc7N
	rR2JG/tZRuLNq2OvEV/hzZzqX8SxIEU=
Subject: Re: Mount crashes with SIGILL on v240 on for-next
From: Stian Halseth <stian@itx.no>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, sparclinux
	 <sparclinux@vger.kernel.org>
Cc: Imre Kaloz <kaloz@kernel.org>, Andreas Larsson <andreas@gaisler.com>, 
 Magnus Lindholm <linmag7@gmail.com>
Date: Sat, 10 Oct 2026 20:31:25 +0200
In-Reply-To: <ef8e85c1fc00c999e74b2d43048bfa67997c13a2.camel@itx.no>
References: 
	<b74cffe77f82562fae8cf611349e765f1f38af2c.camel@physik.fu-berlin.de>
	 <14ae2aabb9e681a69818d3e02da8273cd12261b8.camel@itx.no>
	 <69c1798a6409879a70474c10e3d653fdb37c7246.camel@physik.fu-berlin.de>
	 <ef8e85c1fc00c999e74b2d43048bfa67997c13a2.camel@itx.no>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-Rznbiat18GxF2U02ynr3"
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-Rznbiat18GxF2U02ynr3
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On Sat, 2026-10-10 at 19:03 +0200, Stian Halseth wrote:
> Hi,
>=20
> On Sat, 2026-10-10 at 18:44 +0200, John Paul Adrian Glaubitz wrote:
> > >=20
> > > Will report back if I reproduce and find something more concrete.
> >=20
> > Apologies, I forgot to provide my kernel config. See attached.
> >=20
> >=20
> Ah, uniprocessor, no SMP. That changes quite a few things, D-
> cache/TLB
> flush paths...
>=20
> Will test the same here.=20
>=20

Tested with the same config, even built it with the same crosstool gcc
15.2.0 / binutils 2.45 on Andreas' for-next. My V240 boots and loads
ext4 from the initramfs every time.

CONFIG_SMP unset, is that intended, do you have a single CPU V240?

Does this exact setup (UP kernel, ftrace, xz-compressed modules
decompressed by the kernel) ever work with an earlier kernel? If so,
which version was the last good one?=A0

If this isn't a regression in the for-next branch, I would try to apply
Kaloz v2 patch from sparclinux #29. I cannot reproduce / test, but
since you have the issue, I would be very interested to know if it
makes a difference:
https://lore.kernel.org/all/20260928132102.1707-1-kaloz@kernel.org/


/Stian

--=-Rznbiat18GxF2U02ynr3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTK1ph9OaYoND1R57zoeAEuJe36VgUCasqEfQAKCRDoeAEuJe36
VjWpAP9eaiYL7+W7HWpMor9cAmGsAB3Q/+YwBmaCuh8bp4Xh1gEAweEayEmE2PIN
EUwS2z2FvdcotjroXwb2//alyd7dhAA=
=uTur
-----END PGP SIGNATURE-----

--=-Rznbiat18GxF2U02ynr3--

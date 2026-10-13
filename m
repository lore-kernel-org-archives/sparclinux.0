Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6607516175
	for <sparclinux@vger.kernel.org>; Tue, 13 Oct 2026 13:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791898253; cv=none; b=TtEr3l71YmX4YO/QcyadAzhA3n7sh5eMNY1jHMv/btLmPLtod4JBLRh61tHFEAgW+BDNPVKRyB6K/gFadc8QkvufpIrrWzXYqx7opiCHodocEc5CJOMxRXThID8h81JY+HNwUkVIjhnpT/FngvUNMubl/hyXg/wg6IA3PsU80WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791898253; c=relaxed/simple;
	bh=obl5D/IeSxj0CsVUTmfiZOwDOHTvnEdD3Sh3wh+r3uQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fqy1KVX2kMb6DZnI8ETwgWxVZ088M5X3YwTndlFOJvMps0p3QCAJoGM1O/IAIZHwzhwW2GX4NC6EF53XYOrMYksAQrzYbf8AOSGrM+pVk4QhoIqPvjk2NrYuDke4EtWVwjH01jTXVsUWFMQaX9SBmH6PzJFfv5x+0j2GXE/9HYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=cD00ECrx; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="cD00ECrx"
Message-ID: <6dfc6782b6b1d194a2c454dab7c9505eb0dc9a1c.camel@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1791898249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=obl5D/IeSxj0CsVUTmfiZOwDOHTvnEdD3Sh3wh+r3uQ=;
	b=cD00ECrxZCrATOs1WBTIQJRA2qmNo/ujSl0h46mkzPMiYygxAwxFNRyyT4PT9NZyi5Lqya
	UPYlVNczzswETgCoyXgNIqdsMcFjHSavijSSugGrRwmehDX+mioKR/dHyb2+ajWLdVBBYB
	g9wbWmtINOYTfHp8Gqlnbl6w4XyNy6g=
Subject: Re: SPARC Meetup at FOSDEM
From: Stian Halseth <stian@itx.no>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Magnus
 Lindholm <linmag7@gmail.com>, Andreas Larsson <andreas@gaisler.com>, Imre
 Kaloz <kaloz@kernel.org>, Sam James <sam@gentoo.org>
Cc: sparclinux <sparclinux@vger.kernel.org>, 
 "<debian-sparc@lists.debian.org>" <debian-sparc@lists.debian.org>,
 gentoo-sparc <gentoo-sparc@lists.gentoo.org>
Date: Tue, 13 Oct 2026 15:30:48 +0200
In-Reply-To: <690d59600b7a2562d62440ead25b94505739e3bf.camel@itx.no>
References: 
	<8d81032ee582ede5ad2df981bb1646d096c9abe2.camel@physik.fu-berlin.de>
	 <690d59600b7a2562d62440ead25b94505739e3bf.camel@itx.no>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-HQvkTrAfyycWHoA9DKWB"
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-HQvkTrAfyycWHoA9DKWB
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

And _no_ offence intended to the ladies out there.

_My_ wife doesn't quite share my fascination with SPARC (or retro
computing for that matter), but that does of course not apply to
everyone.

In any case, I would be down for a meetup, and there could also
possibly be a group for any less technically interested better half's.

/Stian

On Tue, 2026-10-13 at 15:24 +0200, Stian Halseth wrote:
> Hi Adrian,
>=20
> Thank you for the initiative.
>=20
> I've actually never attended FOSDEM before, but sounds interesting,
> and
> I will absolutely consider it.
>=20
> Perhaps I will place my wife in a hotel somewhere in Brussels.=A0
>=20
> We could possibly make a wife camp, if this is common issue.=A0
> Could create an issue at sparclinux for wife tracking, if necessary.
>=20
> Let's see how the response is.
>=20
> /Stian
>=20
>=20
> On Tue, 2026-10-13 at 14:59 +0200, John Paul Adrian Glaubitz wrote:
> > Hi,
> >=20
> > I was wondering whether people would be interested in a SPARC
> > meetup
> > at FOSDEM?
> >=20
> > I will be around as usual and maybe we could arrange a meeting with
> > some hacking
> > and beer.
> >=20
> > Adria=20
> >=20

--=-HQvkTrAfyycWHoA9DKWB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTK1ph9OaYoND1R57zoeAEuJe36VgUCas4yiAAKCRDoeAEuJe36
VgnYAQCgqHCoTgVUxQpoH7yHsvG1MiFsTCbYIxiD97C3mgMcxgEAz9VQjW7jDbMx
y3fDMK+OgBrbp68Qm21Jh1Z/ebMh5As=
=AIGf
-----END PGP SIGNATURE-----

--=-HQvkTrAfyycWHoA9DKWB--

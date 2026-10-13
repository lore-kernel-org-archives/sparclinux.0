Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638554F393E
	for <sparclinux@vger.kernel.org>; Tue, 13 Oct 2026 13:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791897858; cv=none; b=bgqDfu/ve+GTG5HwvLuQX7eZSmvwyDmxGdGssbzDF0DgEpPMEgqWRjv7P9pw7rmq3TiFM3v1RGT2KoOJIAi7+mJSO1BkWCVC44ukdYVwphYJtoJx2qYmZTuXrGvopgtw/ogq7Gg8G2bEnq7o+59ZDTPDNuQTSS9QmTJgZ6YYtqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791897858; c=relaxed/simple;
	bh=a6b4g9guFfRvxt6QPIHfXrpz+CbnBq2Uwe0kCtbPyVw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O5D7CXVCDrlyHk553WS21m1PW+wqSBfH9xSrdnO6vV6bGOqSXq5BdiLsZzdGEKneFrvzcstfl791B7VvxfLZjkiO0J4UUCNilOSlk+dxFLM5U3cjr0x/d43S6JLK2lCqVDpq7AJbZJcmgtDQcsauHCdmQh6xobZmRljwagsPxLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=IGJ9pQaA; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="IGJ9pQaA"
Message-ID: <690d59600b7a2562d62440ead25b94505739e3bf.camel@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1791897847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a6b4g9guFfRvxt6QPIHfXrpz+CbnBq2Uwe0kCtbPyVw=;
	b=IGJ9pQaALcMjIe4aI1d3Gp1E77kdE9cyzfTQsglGNQP3yWZKTqvVVaz21QV6HE9lIuGvz0
	Ohg9L7anZq2PFe84ArPXGgwoqm8L6f9xV3Vv2UoOgR7x/kxxyDigLjPgAtMFY8Et1T7eJB
	Jhs35iBEqVmh7slvgnR4GE6A7QDrlXM=
Subject: Re: SPARC Meetup at FOSDEM
From: Stian Halseth <stian@itx.no>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Magnus
 Lindholm <linmag7@gmail.com>, Andreas Larsson <andreas@gaisler.com>, Imre
 Kaloz <kaloz@kernel.org>, Sam James <sam@gentoo.org>
Cc: sparclinux <sparclinux@vger.kernel.org>, 
 "<debian-sparc@lists.debian.org>" <debian-sparc@lists.debian.org>,
 gentoo-sparc <gentoo-sparc@lists.gentoo.org>
Date: Tue, 13 Oct 2026 15:24:07 +0200
In-Reply-To: <8d81032ee582ede5ad2df981bb1646d096c9abe2.camel@physik.fu-berlin.de>
References: 
	<8d81032ee582ede5ad2df981bb1646d096c9abe2.camel@physik.fu-berlin.de>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-EhhtoJWz1V4X2pIAdUKc"
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-EhhtoJWz1V4X2pIAdUKc
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Adrian,

Thank you for the initiative.

I've actually never attended FOSDEM before, but sounds interesting, and
I will absolutely consider it.

Perhaps I will place my wife in a hotel somewhere in Brussels.=A0

We could possibly make a wife camp, if this is common issue.=A0
Could create an issue at sparclinux for wife tracking, if necessary.

Let's see how the response is.

/Stian


On Tue, 2026-10-13 at 14:59 +0200, John Paul Adrian Glaubitz wrote:
> Hi,
>=20
> I was wondering whether people would be interested in a SPARC meetup
> at FOSDEM?
>=20
> I will be around as usual and maybe we could arrange a meeting with
> some hacking
> and beer.
>=20
> Adria=20
>=20

--=-EhhtoJWz1V4X2pIAdUKc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTK1ph9OaYoND1R57zoeAEuJe36VgUCas4w9wAKCRDoeAEuJe36
VmoUAP97fTZJQTdmp9LaSo8mBBvVGY1rg6ZzE0x2Ti5q7uo/gAEA/aQbl4E51syr
aynbf38nqyteSBsCaFqHwOEgybbZqQM=
=5iTL
-----END PGP SIGNATURE-----

--=-EhhtoJWz1V4X2pIAdUKc--

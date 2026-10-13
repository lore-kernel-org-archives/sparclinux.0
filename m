Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD4B35203C
	for <sparclinux@vger.kernel.org>; Tue, 13 Oct 2026 14:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791900967; cv=none; b=sW5rgSIJCfHgvJvqbSiBGFDcDo8OTdHN+A/r5n+MSYsaWhPws9bn/X5Oxs6vv6oEFOe9pN6J2prh11OAFo2IJO79JWhK7lmCutrhOJqXWAzAEHUWyomIvTz01azZ+1m+ZUevN11AbfO6pTgPbHjsIO26WhITO5JQazzqyIJom1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791900967; c=relaxed/simple;
	bh=LIz7qv5hdQDkh5kC+YE2bfL0hdqdfvEBNVUNLoaY+8o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b0pbt4G3+jCApCDPKLTjsXzODr+yskP67r54atVgpbzcuy45Pq1nTL7cTACkBZAI0b8YGCaOitB+t9/+EwMVr4eY6/G54PWiT5iSgwZBd/K815ASfghwQTfqBs/mcBgeI/XADSU7S9yVyb7rL3HHIh04NT2rOOFhmkOmU5PNEis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=GQDC2fLz; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="GQDC2fLz"
Message-ID: <30f944bb25cff2c8e478f78c9c7d05315ca245ec.camel@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1791900964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LIz7qv5hdQDkh5kC+YE2bfL0hdqdfvEBNVUNLoaY+8o=;
	b=GQDC2fLzo1OzU5yOxkFxO/xlxWbCRBFs9ZQ3eS/I/z5mM365w9/livydQ8Mkw8kGo8Klhy
	cIh1DdyljvSI1vpGFySembOusHaYQ8gEUbvjqziag5qeSmMrnyROmZ/fdbJU/GQ9cZlFvA
	Zx9kuuhNZFdceqblWKLLh0xpi1qVYX8=
Subject: Re: SPARC Meetup at FOSDEM
From: Stian Halseth <stian@itx.no>
To: Magnus Lindholm <linmag7@gmail.com>, John Paul Adrian Glaubitz
	 <glaubitz@physik.fu-berlin.de>
Cc: Andreas Larsson <andreas@gaisler.com>, Imre Kaloz <kaloz@kernel.org>, 
 Sam James <sam@gentoo.org>, sparclinux <sparclinux@vger.kernel.org>, 
 "<debian-sparc@lists.debian.org>" <debian-sparc@lists.debian.org>,
 gentoo-sparc <gentoo-sparc@lists.gentoo.org>
Date: Tue, 13 Oct 2026 16:16:03 +0200
In-Reply-To: <CA+=Fv5SuE2bgKyQCp-w+0GT=dduk3_yOSbTOzVJybC2pjLaPJw@mail.gmail.com>
References: 
	<8d81032ee582ede5ad2df981bb1646d096c9abe2.camel@physik.fu-berlin.de>
	 <CA+=Fv5SuE2bgKyQCp-w+0GT=dduk3_yOSbTOzVJybC2pjLaPJw@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-ZAMwVXU2Mzk+vxNBiCsd"
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-ZAMwVXU2Mzk+vxNBiCsd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 2026-10-13 at 16:10 +0200, Magnus Lindholm wrote:
> Hi everyone,
>=20
>=20
> Great initiative!
>=20
> On Tue, Oct 13, 2026 at 2:59=E2=80=AFPM John Paul Adrian Glaubitz
> <glaubitz@physik.fu-berlin.de> wrote:
> >=20
> > Hi,
> >=20
> > I was wondering whether people would be interested in a SPARC
> > meetup at FOSDEM?
> >=20
>=20
> This sounds very nice, I've never attended FOSDEM so maybe its about
> time

Same here, sounds great! I'm looking forward to see how you're going to
bring the Alpha with you to the event ;-)


--=-ZAMwVXU2Mzk+vxNBiCsd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTK1ph9OaYoND1R57zoeAEuJe36VgUCas49IwAKCRDoeAEuJe36
Vm5yAP9QqgpYtxgom9hVob6s5pIFZOolggJ3DD4+vnNkc52WQQD/QH1M76RBaGvY
M/SOPi7w1iNE89ntUOixa6UcOqy23gA=
=nlS4
-----END PGP SIGNATURE-----

--=-ZAMwVXU2Mzk+vxNBiCsd--

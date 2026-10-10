Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C1613B58C
	for <sparclinux@vger.kernel.org>; Sat, 10 Oct 2026 17:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791651843; cv=none; b=FeZjksnFEJAPz1+graz+hXs3r08h+CAiXXvwXRbKgrRXiQuba2aqcJbRvGZ13ipfMyVBdX4JB2qjqf/Nb8C4pYiM5d9yrguBZFBlq7Etjq8rTNqhmI9QlE72iej0CbvRUEawK+uNDULY8+8kI+Q3c3HHX4KcoIFCyZB//6E86gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791651843; c=relaxed/simple;
	bh=0E98i8zUkoaVZuAg3W8iOqw3EH9oH81BFU+rEfAKHsI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V0cs20dqFR03ZVFNkxxZem/96Qnwh2RWh1jAYNHEcEQsf2XlwG4ZGPbbR9/P/QSWz0Xl+DWQApVKqPBsZq9djJ/KL218UFo4/BV7UgVsw/5bnrxw1gCKeK5jtfe7NYpYwRFcl4HTtlJrkNPsQ7zVfRy9BwSjDS5+cdK93kATpsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=iU3fL2wQ; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="iU3fL2wQ"
Message-ID: <ef8e85c1fc00c999e74b2d43048bfa67997c13a2.camel@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1791651839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0E98i8zUkoaVZuAg3W8iOqw3EH9oH81BFU+rEfAKHsI=;
	b=iU3fL2wQa6WCQle8FdXMgjrJ9pAJcaEDFDCtrHl0jc6S/V/2L3/S7JVqG5W2UgPuZ7E334
	CKLs4y8AHLmx0GipmDJCzyRxJaN1RbUzk4bhX1rMx8iQvFZYdov5ipYCoNr9guFF3+ho3P
	GW3XaZ97wa299+vtEG9zeWzRyuv9zds=
Subject: Re: Mount crashes with SIGILL on v240 on for-next
From: Stian Halseth <stian@itx.no>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, sparclinux
	 <sparclinux@vger.kernel.org>
Cc: Imre Kaloz <kaloz@kernel.org>, Andreas Larsson <andreas@gaisler.com>, 
 Magnus Lindholm <linmag7@gmail.com>
Date: Sat, 10 Oct 2026 19:03:58 +0200
In-Reply-To: <69c1798a6409879a70474c10e3d653fdb37c7246.camel@physik.fu-berlin.de>
References: 
	<b74cffe77f82562fae8cf611349e765f1f38af2c.camel@physik.fu-berlin.de>
	 <14ae2aabb9e681a69818d3e02da8273cd12261b8.camel@itx.no>
	 <69c1798a6409879a70474c10e3d653fdb37c7246.camel@physik.fu-berlin.de>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-CIq3bSF1OXnD67ichC3B"
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-CIq3bSF1OXnD67ichC3B
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, 2026-10-10 at 18:44 +0200, John Paul Adrian Glaubitz wrote:
> >=20
> > Will report back if I reproduce and find something more concrete.
>=20
> Apologies, I forgot to provide my kernel config. See attached.
>=20
>=20
Ah, uniprocessor, no SMP. That changes quite a few things, D-cache/TLB
flush paths...

Will test the same here.=20

/Stian

--=-CIq3bSF1OXnD67ichC3B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTK1ph9OaYoND1R57zoeAEuJe36VgUCaspv/gAKCRDoeAEuJe36
VknQAQCtVOg8n2qU7woGyofIjxFCxanrXZ1tHOb/Q0l8e/owxwEAx/ZKmPDmx9Ih
X0MPGvwP/HvOo0cRZyDYxqsCb1urygo=
=GygZ
-----END PGP SIGNATURE-----

--=-CIq3bSF1OXnD67ichC3B--

Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1732395240;
	Sun, 18 Oct 2026 21:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792357720; cv=none; b=icLheyLt9G4jIAGjS3Pmv71MkhsI5rOniTLBGC5Ycq/Jj29AFnbndrYsCXuPUNUIl4ssJIkP0iCohcupmRqX+9g9LezqEHnmWv69Hctp8MlBvO8nJmjo/6gBnld/C6AsOMebkSZmMbVPxhGEzuDupsX0DIx5tKTem9C+D6YTTUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792357720; c=relaxed/simple;
	bh=N3tcKlU8SvkUmQmBZi0BzH/KKWW601974k6exc9vqrU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SNXOx1U45CpM/BbwecLxQFa5NmFg8LCfG2nVv0l8KY3qJK+QhIer3GGN0GBVr7gcfF5gKookF3gJ9bztQI2/0SR8Vkun3f85tuhk/4Y/PDyEufHvwJNuufjbfzLk9zPwL6rbqi2PYsT24YCEn6UehieJ4ZTf0S66Sk+ypaXXcp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=mLhkdJ18; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="mLhkdJ18"
Message-ID: <d233287d5dcb6726403703a7b923b05a8134cb1a.camel@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1792357716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N3tcKlU8SvkUmQmBZi0BzH/KKWW601974k6exc9vqrU=;
	b=mLhkdJ18WOX6JryQihTQGivO3zZpHqWO6fGMCj7cwaQpQzAr+GF+1NsuvEZZa5UztXzhj5
	x9nn7vGymEvD5XHin3fHlD2GDeqtw1eCnChcc+BoyjhfCrxx0oaYGE1uJ8b7C4UXlHi6gU
	EoHI39cbsaWcoTrhndVeYlhbpQrVPYE=
Subject: Re: [PATCH v2 0/3] sparc64: Randomize mmap base and PIE executables
From: Stian Halseth <stian@itx.no>
To: Magnus Lindholm <linmag7@gmail.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Andreas
 Larsson <andreas@gaisler.com>, "David S . Miller" <davem@davemloft.net>,
 Kees Cook <kees@kernel.org>, Michel Lespinasse <michel@lespinasse.org>, Jan
 Engelhardt <jengelh@inai.de>, sparclinux@vger.kernel.org,
 linux-mm@kvack.org,  linux-kernel@vger.kernel.org
Date: Sun, 18 Oct 2026 23:08:33 +0200
In-Reply-To: <CA+=Fv5R31wpXsm-7_H7ZR_U4ASubis+_zWKotpj2iNeWW_MTUg@mail.gmail.com>
References: <20261018122734.2594904-1-stian@itx.no>
	 <e3068b5c97884032e7cbd12c78f6b5534d75e30c.camel@physik.fu-berlin.de>
	 <6e2d2b2b7aa4029c261831016d8b6c40bc335341.camel@itx.no>
	 <4f7dacd9b4cf0a43209be84f2408e6f7e033fd3d.camel@itx.no>
	 <CA+=Fv5R31wpXsm-7_H7ZR_U4ASubis+_zWKotpj2iNeWW_MTUg@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-BufmEGetig0tO3gMlS8x"
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-BufmEGetig0tO3gMlS8x
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Magnus,

On Sun, 2026-10-18 at 22:37 +0200, Magnus Lindholm wrote:
> >=20
> > Additionally, outside of qemu testing, I'm a bit worried about
> > sparc32
> > machines with virtually indexed caches. I've heard those can be
> > fun,
> > and I wouldn't feel confident about implementing it without testing
> > on
> > the "real thing".
> >=20
>=20
> Stian, following your exchange with Adrian, would you be willing to
> put
> together a native sparc32 version? I can test it=A0 on my Hypersparc
> SS-20.
>=20
Sure, I could do that.=A0

Ideally, I would like to get this sparc64 series through review before
I add anything else. Could be a follow up series based on this one.

/Stian


--=-BufmEGetig0tO3gMlS8x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTK1ph9OaYoND1R57zoeAEuJe36VgUCatU1UgAKCRDoeAEuJe36
VuVKAP0cSMBZ6SDTS0DWLSLchPoPvpTgLEqfXS7kPSPasheALAEAoQhUpdtgBPTz
CjTIY7tHgOlE9Q3FhIYspzMtpED0dwM=
=BgY2
-----END PGP SIGNATURE-----

--=-BufmEGetig0tO3gMlS8x--

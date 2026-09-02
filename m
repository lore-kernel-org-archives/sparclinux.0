Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA2C1DED42;
	Wed,  2 Sep 2026 07:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788333669; cv=none; b=sjOqkxFF8BDsjE8+1ZNsJsF22gR5n1EnR7+qdce7Tm1OkCKTjk+9eKqfjJkLsACc6baJjXT1B7bFiKLVQ06A+5ULvqoSlTiejIsMsiVyK8t8wE7MhMzlZmvI1pifQdYrR7+dEuRqbDQODNbmHmxyVZscnFg7mppQLM97hP4XM5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788333669; c=relaxed/simple;
	bh=/95Et0FTC0jnTxhXK66zcbKlfSDhLQq4+FOgpFgPSVw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XfhdRe1pNGP1zNV1tZILyutkQm1nsoAG9nWPOCnVwCEOa4TAw+iwtyMTkuptRyXZ/v6NCTsoocCWq8T5HWFfLlMbLGqFGLWZI8qZZZQNg16uP51Gk7gYiJnZq+zH3ozDHxbc1SAjSLQl/Vo1qVJxAn1K/9aqeZPlK7RDvRwofwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=dbmrjr9F; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="dbmrjr9F"
Message-ID: <91ee5ca0ace64f0d990a4efb6ae72aa3e0966450.camel@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1788333665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/95Et0FTC0jnTxhXK66zcbKlfSDhLQq4+FOgpFgPSVw=;
	b=dbmrjr9Fu98fTnJE4K+sMU2zyY/zHVbG2vDMmTtDJCmOCr9eBHvhaHjZLBNTw9Yogm82L9
	xJhn7PscA/faydoZlk4GdIsVf04UPgb/SNlJbv8TI8HxS+KMd1O2Dt9el5gpFv9VmEsio1
	rZljspdWTQ6jj8yAwie09Vvqd3GhzgQ=
Subject: Re: [PATCH 2/2] selftests/seccomp: add sparc64 support
From: Stian Halseth <stian@itx.no>
To: Kees Cook <kees@kernel.org>
Cc: Andreas Larsson <andreas@gaisler.com>, "David S . Miller"
	 <davem@davemloft.net>, sparclinux@vger.kernel.org, Andy Lutomirski
	 <luto@amacapital.net>, Will Drewry <wad@chromium.org>, Oleg Nesterov
	 <oleg@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, John Paul
 Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Wed, 02 Sep 2026 09:21:04 +0200
In-Reply-To: <d4d5d20bd3fd8bab30c1a28fd1eda374e62d9038.camel@itx.no>
References: <20260901220811.3369666-1-stian@itx.no>
	 <20260901220811.3369666-3-stian@itx.no> <202609011700.E21C37761@keescook>
	 <d4d5d20bd3fd8bab30c1a28fd1eda374e62d9038.camel@itx.no>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-EO16OVG6qLdVgK9Abkps"
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-EO16OVG6qLdVgK9Abkps
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable


On Wed, 2026-09-02 at 09:15 +0200, Stian Halseth wrote:
> On Tue, 2026-09-01 at 17:02 -0700, Kees Cook wrote:
>=20
> > Thanks for getting the working on sparc! :)
> >=20
> Thank you for the quick and friendly review! This is my first feature
> submission to the kernel. I've only sent some bug fixes earlier, so
> that's much appreciated.=20
>=20
>=20
"feature" was perhaps a bit of an overstatement. First kernel
submission that _adds functionality_ rather than fixes a bug, perhaps.

Note to self: Contain excitement ;)

--=-EO16OVG6qLdVgK9Abkps
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTK1ph9OaYoND1R57zoeAEuJe36VgUCapfOYAAKCRDoeAEuJe36
VthiAP46dSc58UP9r46LqEUX/pib9JgSnv3g+aa2hDm3bz+svAEA3PLssdHy561k
2XlfWWjEYui+GSU5N27D8fE8N7mXKQc=
=Bsj4
-----END PGP SIGNATURE-----

--=-EO16OVG6qLdVgK9Abkps--

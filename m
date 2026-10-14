Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E45D387346;
	Wed, 14 Oct 2026 09:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791970159; cv=none; b=uolQINh4YWQoDZjB3RMAyKBVCEBINnZ+ndTCJCOoYq4iYk0MrAroHNM4E34OK2PCN3H4B7puqymwBAA8VQK78sZDnOSuxd2nKyqxvV7RTs0PMsT+lP9tvtMxHJLofKk5gVg5uey6YX8GJZ8NeIiQHu65DL+702YOOtHPm0q6+dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791970159; c=relaxed/simple;
	bh=bZcSaZIvM0ndoFJovUr9jXf0bk/P9K1VBlEWPXY85BQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bBld1DOR4omgh/lI0vslKaR26ImI9OydCNpZinY5im7SAujYasqn7SWcF9bEJqY5oHaPcbjO8TuBHbYF6KBJI09wvIXyq+LV023n1Ien5Yppp+o8HDR3tkzOLSeDtJb+Xgcm3jJL6U3sWam8+NU4brY0SkLxE3PhnfuvcCYJ31g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=VS/5e8kh; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="VS/5e8kh"
Message-ID: <49e370ceff863dad24a58070e987ebd36440cbf1.camel@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1791970154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bZcSaZIvM0ndoFJovUr9jXf0bk/P9K1VBlEWPXY85BQ=;
	b=VS/5e8khANuO7HXcL7V38XITDuKBn0chUQXZSao+2yliGmnFv3axYWFLCDdTCVepYkqie4
	ugHu7m6aAAHldAmMNVzdAOvMO6xhnduFKWj9bOq95TZBXKomt59vLJQO6Aualw4M/kk4QU
	/5NJRxaLQSxoS/iGdp8wrFRNHcvqKK0=
Subject: Re: [PATCH 3/3] selftests/seccomp: add sparc32 support
From: Stian Halseth <stian@itx.no>
To: Ludwig Rydberg <ludwig.rydberg@gaisler.com>, Andreas Larsson
	 <andreas@gaisler.com>, "David S. Miller" <davem@davemloft.net>, Kees Cook
	 <kees@kernel.org>, sparclinux@vger.kernel.org
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
 Oleg Nesterov <oleg@redhat.com>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org,  linux-kernel@vger.kernel.org, John Paul
 Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Wed, 14 Oct 2026 11:29:13 +0200
In-Reply-To: <20261014080730.8817-4-ludwig.rydberg@gaisler.com>
References: <20261014080730.8817-1-ludwig.rydberg@gaisler.com>
	 <20261014080730.8817-4-ludwig.rydberg@gaisler.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-Bw0MB6kSdidACYAXBKdy"
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-Bw0MB6kSdidACYAXBKdy
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-10-14 at 10:07 +0200, Ludwig Rydberg wrote:
> Add SPARC32 definitions to seccomp_bpf selftest.
>=20
> Reuse the sparc64 register handling on sparc32 but adapt the carry
> bit handling to use %tstate on sparc64 and %psr on sparc32.
>=20
>=20

Tested on a SPARC T7-1 (M7), 7.3-rc5 with the sparc64 series. The
64-bit seccomp_bpf gives the same result with this patch as without
it, pass:95 fail:0 skip:16. Built as a 32-bit binary against a sparc
Gentoo stage3, it gets the same result on the 64-bit kernel through
the compat path.

Tested-by: Stian Halseth <stian@itx.no> # sparc64, native and compat


--=-Bw0MB6kSdidACYAXBKdy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTK1ph9OaYoND1R57zoeAEuJe36VgUCas9LaQAKCRDoeAEuJe36
Vl7xAP4/fZi5foZm2kkVsdUAYC36tmBFv6bTnswy7KsNamlRGAEArNghgjdeevWS
4BUgT6nqVttl7g8mubMyxAG0mTmNQQ4=
=EVH7
-----END PGP SIGNATURE-----

--=-Bw0MB6kSdidACYAXBKdy--

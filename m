Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6817D3AC0C8;
	Wed, 23 Sep 2026 20:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790197024; cv=none; b=J34sTVYbxHj60q2GIZESCfYfLEWw/7eqt/dfNaLwRbSEkONUa1u3fyFvOjTjdNmAh/+a+K7KEoCFEGtDDdmTKmSb+GGegO6FNW4zMMwP5UNtnL2Uzv2V6AeHIAUQSCymDTh/npYZAMs3yXFNkshPpw62RnTs0c6LBbc7ltzibjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790197024; c=relaxed/simple;
	bh=Zgd9EYXjfCotOgPT2J1zHMkAfVG8iyoh91G3Xdd+CWE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KXyNrcNUva1yl9Tee/4WlFO9nxNaaAzaoCxKmdXFPVULHqfW4TNrpqR9mw0lyhOWiFkjyQej9AAtIgeAbnr8yVEYf+0v10m5kST/owgjRIV06V8wUycKxmFc5mPF8JaoAZLXtqvLxxMHW6XvbW0U4e4sw+c3+QPvXLgEFJB9aI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=iBejrJgo; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="iBejrJgo"
Message-ID: <4927bb40f34ec6d3d5591dabba755452bd6b4a39.camel@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1790197019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zgd9EYXjfCotOgPT2J1zHMkAfVG8iyoh91G3Xdd+CWE=;
	b=iBejrJgoPxKBztcQcgVdxSdRTWcAkVfO0RZrDb7hu4dUdY3/qrD7kZ9pkRPv+y4zbP41q6
	P9DeYAc8PezeZwWXd00TRyAd3bVvNELgzsjNQ2VL5+TZ4h2mbNT8AsJGMpoUg08L0azFU0
	PMJL57KcDToZBaX06WXoqRHFzMDmMWU=
Subject: Re: [RFC PATCH v3 0/3] perf: sparc64 user regs and stack dump, with
 arch hooks
From: Stian Halseth <stian@itx.no>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Andreas Larsson <andreas@gaisler.com>, "David S. Miller"
 <davem@davemloft.net>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung
 Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>,  Jiri Olsa
 <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Magnus
 Lindholm <linmag7@gmail.com>, linux-perf-users@vger.kernel.org,
 sparclinux@vger.kernel.org,  linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 23 Sep 2026 22:56:57 +0200
In-Reply-To: <CAP-5=fW4bzmy5_6a-8YucOy7JGKg+izRbq+7TaOGKV5aG0oYcw@mail.gmail.com>
References: <20260923090429.2026529-1-stian@itx.no>
	 <CAP-5=fW4bzmy5_6a-8YucOy7JGKg+izRbq+7TaOGKV5aG0oYcw@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-F+1UqHVTzc7TRQwvfyjr"
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-F+1UqHVTzc7TRQwvfyjr
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Ian,

On Wed, 2026-09-23 at 13:38 -0700, Ian Rogers wrote:
>=20
>=20
> For the series:
>=20
> Reviewed-by: Ian Rogers <irogers@google.com>
>=20

Since this series is still marked RFC,=A0should I resend it as a regular
PATCH v4 with your Reviewed-by, or wait for additional maintainer
feedback?

And thank you so much for the reviews!

Stian

--=-F+1UqHVTzc7TRQwvfyjr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTK1ph9OaYoND1R57zoeAEuJe36VgUCarQ9GQAKCRDoeAEuJe36
Vl4eAQD+uEQ1n9fexqsHAW+RClIdJRwVU+vkiz1xd2YN7/TRBAEAt1mGBqpE68ca
BxWIdAv2OtDaW1ZRb5GRmiUmT5dxlgg=
=tWXr
-----END PGP SIGNATURE-----

--=-F+1UqHVTzc7TRQwvfyjr--

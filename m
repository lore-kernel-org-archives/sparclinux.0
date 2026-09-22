Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A4D4399F2;
	Tue, 22 Sep 2026 21:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790111407; cv=none; b=fjqtmsPI3EJf1xp0gooB2IzwgTQ+ah6Z9FZv6hfXS1N/BZZWNHBPaNoxc6NI3zGeKJCWuzm74Je2VpbLltUH8OUG+Tv1QfP2xcxdxnRGURr2T6nTicgLcvQcUveDyiuOCZATtVXBQvHJaE89YezAFnOGNOBIEu7VYslYDEx5Qh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790111407; c=relaxed/simple;
	bh=5NNMt3/DILXM0pS+sZEqPErVAEkz8VaV2WS/9ygGJk8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M2ZQimH3abeyotdxb80tR9hKQaYn98sT2438TdluTo/DSgz36gfFRwsKx7YrW4F9AJHP+DNckD0gRuirhtM6Dmtvi25f/6gnJkiArR7OrqGMpvDKg31IyZFulzZtHusVLCv4BOVAzsgVR2fhqyeu+GAQB+uRX/5rd7iFSWhu/hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=SOcHJH9O; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="SOcHJH9O"
Message-ID: <3d76ccdcb6b9cf73d0ea494b55ddaed775d9d4a5.camel@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1790111396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5NNMt3/DILXM0pS+sZEqPErVAEkz8VaV2WS/9ygGJk8=;
	b=SOcHJH9O9mHaAMrdg8i5/XoQitw6yHJiptjP1THfXbfXG82Hk0dxoLyxBJLeuAiMrqtICb
	fnGusUyUWgmR/18dcaW/3/ACIavfiH2g1x1SoRKBpvxg8V3Ibl0jgkVr2/iShjBXhfL0l9
	JW4ESvq5Y4vbxXB3NW89w38PbJQwZGY=
Subject: Re: [RFC PATCH v2 3/3] perf tools: Support sparc user register
 samples and dwarf unwinding
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
Date: Tue, 22 Sep 2026 23:09:54 +0200
In-Reply-To: <CAP-5=fWNhJGHnRoz7FrwZO2mOZa4NCi5C3ZsFGrirAE0prj69w@mail.gmail.com>
References: <20260922201507.1719668-1-stian@itx.no>
	 <20260922201507.1719668-4-stian@itx.no>
	 <CAP-5=fWNhJGHnRoz7FrwZO2mOZa4NCi5C3ZsFGrirAE0prj69w@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-atYsV/48A5yRhAuCPJUd"
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-atYsV/48A5yRhAuCPJUd
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Ian,

On Tue, 2026-09-22 at 13:31 -0700, Ian Rogers wrote:
> > @@ -295,6 +330,8 @@ static bool
> > libdw_set_initial_registers(Dwfl_Thread *thread, void *arg)
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 max_dwarf_reg =3D dwarf_reg;
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> > =A0=A0=A0=A0=A0=A0=A0 }
> > +=A0=A0=A0=A0=A0=A0 if (is_sparc && max_dwarf_reg < 31)
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 max_dwarf_reg =3D 31;
>=20
> Thanks! I think these are great patches! At this point in the code
> are
> you setting max_dwarf_reg so that there's space for the window
> registers? I think adding a comment here for clarity would be
> worthwhile as it matches up with libdw_set_sparc_window_registers.
>=20
I'm glad to hear that!

Yes. On sparc the sampled registers map only to DWARF 0-15, so without
this the array would be too short for the %l/%i values that
libdw_set_sparc_window_registers() writes to 16-31. I'll add a comment
there in the next version.

Thanks for the review!

--=20
Best regards
Stian Halseth


--=-atYsV/48A5yRhAuCPJUd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTK1ph9OaYoND1R57zoeAEuJe36VgUCarLuogAKCRDoeAEuJe36
Vs7jAP9t5oDz0cPy1zmNX45JqqO+EQY6e0qKIov1G/ibW8fYMgEAiJD4wKnHkulx
z2/i1CXfhY+YL1KedAgm4M1a953Uuw4=
=20nH
-----END PGP SIGNATURE-----

--=-atYsV/48A5yRhAuCPJUd--

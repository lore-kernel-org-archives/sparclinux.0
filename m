Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E365360EED;
	Thu, 24 Sep 2026 08:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790238020; cv=none; b=i+lxYOAyI9d7hfBwrPW+6GJO0WcxLMwhyIeK4crnY93u2wG5GjsrhnmRYHw8b31DRkFwvvsQWZYwTfgKkR3s+szjU1w4OOV2bKRY//YCy7hM7SvOcQ59gLUA9Au4mw+H5bz3yMdfV5u4KcdPfk165XQ5Mp8otFOxZyYmCTTrrQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790238020; c=relaxed/simple;
	bh=iC/jecRdvD447Nwl9WQbrjGoa6foMelrHFINX/aafbM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o4l9AMUMRJ6WgzlwLCwV2vB+sDl9xbuMdzqJi7VZluY+Lco5Fw+GtoqddKFGkszUIdJxbQ/hNeMDqsfhccWvcFVG1bNBTje+4/aq0Ii1B7rjkq4g/M6m03DsOAKQdRbMrNYCElIS1FJuuHFGyR0cuPgiGOJ7ovZg/0BonlTVFwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=VivYFouR; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="VivYFouR"
Message-ID: <31e9c297ca688ecd627ac06c96d9531cd1ce1d77.camel@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1790238016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iC/jecRdvD447Nwl9WQbrjGoa6foMelrHFINX/aafbM=;
	b=VivYFouRalwLxn7d+A4KzAYOHrrSVO736JIM40z4F1lCOlKrztXNH8LStIXj9sJbdm2vIw
	sPDBSkDZvxMRq5j7wIj2XVa2uJUuAac97i7p3jmwf4BTUwxkP+dNrF7OZ9W1C6bKJbSsJV
	CJiZW8FQukykpHLx+0qgaJnpG9SeYXA=
Subject: Re: [RFC PATCH v3 0/3] perf: sparc64 user regs and stack dump, with
 arch hooks
From: Stian Halseth <stian@itx.no>
To: Magnus Lindholm <linmag7@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Andreas Larsson <andreas@gaisler.com>, "David S. Miller"
 <davem@davemloft.net>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung
 Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>,  Jiri Olsa
 <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
 <adrian.hunter@intel.com>,  James Clark <james.clark@linaro.org>, Jonathan
 Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Randy
 Dunlap <rdunlap@infradead.org>,  linux-perf-users@vger.kernel.org,
 sparclinux@vger.kernel.org,  linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Thu, 24 Sep 2026 10:20:15 +0200
In-Reply-To: <CA+=Fv5QKMaMGaLO3gKymSv7FVhHMMYxM8ux0S5dTKB26nQeAQw@mail.gmail.com>
References: <20260923090429.2026529-1-stian@itx.no>
	 <CA+=Fv5QKMaMGaLO3gKymSv7FVhHMMYxM8ux0S5dTKB26nQeAQw@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-ogy8Ow1tmSismGZ49il+"
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-ogy8Ow1tmSismGZ49il+
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Magnus,

On Thu, 2026-09-24 at 01:10 +0200, Magnus Lindholm wrote:
>=20
> Hi Stian,
>=20
> I tested v3 on real hardware. I haven't noticed any regressions.
> I built tools/perf from this series and tested the new functionality
> with software cpu-clock events.
>=20
> Basic perf stat/record and the existing frame-pointer callchain mode
> worked normally.
>=20
> PERF_SAMPLE_REGS_USER also worked, with perf successfully recording
> and decoding the SPARC register set.
>=20
> I then tested:
>=20
> =A0 perf record -e '1:0:u' -F 99 --call-graph dwarf,8192 ...
>=20
> This recorded 443 samples with PERF_SAMPLE_REGS_USER and
> PERF_SAMPLE_STACK_USER, using the full 0x7ffff register mask and an
> 8192-byte stack dump. perf script and perf report were both able to
> unwind the resulting callchains, and no samples were reported lost.
>=20
> I haven't tested 32-bit compat tasks or hardware-cycle sampling.
>=20
> Tested-by: Magnus Lindholm <linmag7@gmail.com>
>=20
> Thanks,
> Magnus

Thanks for testing,
Stian

--=-ogy8Ow1tmSismGZ49il+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTK1ph9OaYoND1R57zoeAEuJe36VgUCarTdPwAKCRDoeAEuJe36
VtPOAQDqDF2a8Ap8gUmVTOF1WfKaKCGHpr2yV5fGyEyTYEytgwEAjNiEz1muyI1Y
7YFW9Y4IdFkOCYiTRmVMH4ZJPM+4Sws=
=nHEa
-----END PGP SIGNATURE-----

--=-ogy8Ow1tmSismGZ49il+--

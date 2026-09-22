Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F574AC176;
	Tue, 22 Sep 2026 20:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790107364; cv=none; b=tlWQ0FUb7WaFzaPE4YmhDgyIN52U6t/Dswerr4V5zde4HAlCM+t3OMRNridapQTRQkwsRMXgxblirB8gNvcOzKH2hfvGZBl+l6ybB4YrF083gH0FHDuNhDMsH6xAX5DGLLVZ9r8/6kxe1q1tuO0fjVPJoovQQX5chRBQbnw0Sl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790107364; c=relaxed/simple;
	bh=kZzIuUZdeJtjUZxs3xOer06DEMom4RwITwG3trbOWvM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L8ST9QDr5HI6VXebWUYUGaZ0CJ2vmO8r9uPwbK7w/iIMXpqo1HZY5Qe8SgUeuI4bW5qAh8s4T/ombM2h5prt+mvgXncX9lv1q4Tv0NbR6ecFM7iT4tmCC2b9USs8H612C+iv4FO4VYOs3Ebe+MoxD+j+oBgiXoTEwKGpDH4MJmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=O0enwL+c; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="O0enwL+c"
Message-ID: <a0bee581f87dba8e40ea0055ef8c6a5cfed72ec5.camel@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1790107347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kZzIuUZdeJtjUZxs3xOer06DEMom4RwITwG3trbOWvM=;
	b=O0enwL+c0Vv/+BdkiN0wZ4PjNopcuZb142YrD1j+YDvic7cn+iGmeALgGInw+8GntH8Vz4
	ntSBA11l0KIGldaIGabCSdJjoiCsJH7vbnn1Gt3HG0aESkedPsQLX+DjQnne/bzTl/tZLe
	sm2M6022473gsE8sQFZZwaJDZ2X1KQs=
Subject: Re: [RFC PATCH 0/2] perf: user stack dump on sparc64 needs an arch
 hook
From: Stian Halseth <stian@itx.no>
To: Magnus Lindholm <linmag7@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Andreas Larsson <andreas@gaisler.com>, "David S. Miller"
 <davem@davemloft.net>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung
 Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>,  Jiri Olsa
 <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
 <adrian.hunter@intel.com>,  James Clark <james.clark@linaro.org>,
 linux-perf-users@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Date: Tue, 22 Sep 2026 22:02:26 +0200
In-Reply-To: <CA+=Fv5RnsBXnxb2JHfZ2kXkYB7fz3KLS3+oHtx==z9W93WRANA@mail.gmail.com>
References: <20260922135653.1622301-1-stian@itx.no>
	 <CA+=Fv5RnsBXnxb2JHfZ2kXkYB7fz3KLS3+oHtx==z9W93WRANA@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-ce6TdhinF5bXGGN2lfMu"
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-ce6TdhinF5bXGGN2lfMu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Magnus, thanks for the testing and feedback.

Almost done with a v2.

It has some minor changes based on the AI bot feedback, and my comments
to you below.


On Tue, 2026-09-22 at 19:04 +0200, Magnus Lindholm wrote:
>=20
> Very nice series, thanks for working on this!
>=20
> I built and booted the series on a sparc64 box and haven't
> noticed any regressions so far.
>=20
> I also smoke-tested the new interfaces from 64-bit userspace with a
> small standalone C program using perf_event_open() and software
> cpu-clock events. The register-only, stack-only, and combined
> register/stack tests all passed. The test does not use tools/perf or
> request PERF_SAMPLE_CALLCHAIN. I haven't tested end-to-end DWARF
> unwinding yet.
>=20
> I see that you plan to post the userspace changes once the hook is
> settled. Could you include the tools/perf support in the next
> revision,
> or post it as a follow-up or linked companion series? Having that
> available, along with a link to the matching elfutils changes, would
> make testing easier and let us exercise the intended DWARF unwinding
> use case directly.
Yes, I originally planned to post tools/perf after I got some feedback
on the first patches.=C2=A0Especially since it touches some generic code
that I'm not too familiar with, and I half expect that I have to
rewrite some of it based on maintainer feedback :-)

But since its "just" a RFC patch at this point, I guess I can post the
full series to allow end-to-end testing.=C2=A0

I have mainly focused on the first patches, and the rest was done a bit
faster as a means to validate the "core" changes. It works (TM). I'm
looking through it now, but I probably make a second thorough review of
the entire final series, once the I know what changes I need to make.

I will publish and link to the elfutils changes as well.
>=20
> Also, could you update the sparc entries from TODO to ok in:
>=20
> =C2=A0 Documentation/features/perf/perf-regs/arch-support.txt
> =C2=A0 Documentation/features/perf/perf-stackdump/arch-support.txt
>=20
> Those updates would fit naturally in patch 2 alongside the
> HAVE_PERF_REGS and HAVE_PERF_USER_STACK_DUMP selections.
Yes, agree.



--=20
Best regards
Stian Halseth
=E2=80=8B

--=-ce6TdhinF5bXGGN2lfMu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTK1ph9OaYoND1R57zoeAEuJe36VgUCarLe0gAKCRDoeAEuJe36
VrF2AP9wAbZZ670xm9KEuNDWUdcFAEZen5+BsV7bqBE6LmuepAD/djcN0afRxg98
8YMFwB67dCMOAsM9yvxZCdUyP207Qwc=
=pRuN
-----END PGP SIGNATURE-----

--=-ce6TdhinF5bXGGN2lfMu--

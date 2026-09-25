Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92A63F076F;
	Fri, 25 Sep 2026 07:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790321629; cv=none; b=eRUBH6Pib4zMQmPWdmixUf3QN6uE28sjz+PcPCwFVMAMGF8L1f6RAPM2F48QE3zZhkMc8OAHTlEjEtWetgh06+f7EJBS+bjUvwu9y68Gr34at6sD5adlPyiLT+xjmuLkuFz8L2Tq0XJmkSBiNMYn5DVr+xbT34Ulp2clTX+4EGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790321629; c=relaxed/simple;
	bh=XIqE6ZDqaLT098t+TN7Zt/OlxixF7z7UHm4+trqYkpE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MnT6vtkbPUuG3BxxoMm9b5T3iWY2aG/3ZZKjaPlV3uoabl2ncjatr3IU03xrhJDqpTc26d5xvzGnuUqf06IbcZGfODRb8qN2lC68ZIoYGB7aYlkhGre3MzAzpJjJuxWbfO3zRsCzDIbc59XUOAz6SKgEPVILTw3piZF6niX0lSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=WR8s/2Pf; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="WR8s/2Pf"
Message-ID: <41a208e59a2c3dfc824bd93366034f89ea8b8ed3.camel@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1790321615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XIqE6ZDqaLT098t+TN7Zt/OlxixF7z7UHm4+trqYkpE=;
	b=WR8s/2PfsQrPVkawk6mzyvWpF+AEt9aODFULMdK9Ao5E6LL5QQM6K9lw9I1Edwm36Uss95
	D1UgpSNX2Bbvo6PIhFyLr9EQRjSDNlA0o9eTSRcpW0tQdYH2LK0X86IMMTRwsd1Or2txss
	74fLjXZ4j8pNMMWIh6h1D9RjtOolNR4=
Subject: Re: [RFC PATCH v3 0/3] perf: sparc64 user regs and stack dump, with
 arch hooks
From: Stian Halseth <stian@itx.no>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers
 <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Namhyung Kim <namhyung@kernel.org>, Andreas Larsson <andreas@gaisler.com>,
 "David S. Miller" <davem@davemloft.net>, Mark Rutland
 <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>,  Adrian Hunter
 <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, Jonathan
 Corbet <corbet@lwn.net>,  Shuah Khan <skhan@linuxfoundation.org>, Randy
 Dunlap <rdunlap@infradead.org>, Magnus Lindholm <linmag7@gmail.com>,
 linux-perf-users@vger.kernel.org,  sparclinux@vger.kernel.org,
 linux-doc@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Fri, 25 Sep 2026 09:33:33 +0200
In-Reply-To: <arVZtcrJRRxI6jYd@x2>
References: <20260923090429.2026529-1-stian@itx.no>
	 <CAP-5=fW4bzmy5_6a-8YucOy7JGKg+izRbq+7TaOGKV5aG0oYcw@mail.gmail.com>
	 <4927bb40f34ec6d3d5591dabba755452bd6b4a39.camel@itx.no>
	 <CAP-5=fWhk8Z22+PhFKbatO6fYgiNBgLGwVgg_NxS8fg=uEdDUw@mail.gmail.com>
	 <arVZZCidUqSnIg7u@x2> <arVZtcrJRRxI6jYd@x2>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-Oz1hUSas1fZ459BAxScs"
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-Oz1hUSas1fZ459BAxScs
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arnaldo,

On Thu, 2026-09-24 at 19:11 +0200, Arnaldo Carvalho de Melo wrote:
> On Thu, Sep 24, 2026 at 07:09:58PM +0200, Arnaldo Carvalho de Melo
> wrote:
> > On Wed, Sep 23, 2026 at 02:16:49PM -0700, Ian Rogers wrote:
> > > On Wed, Sep 23, 2026 at 1:57=E2=80=AFPM Stian Halseth <stian@itx.no>
> > > wrote:
> > > I think we have everything we need but the kernel changes are
> > > really
> > > up to Peter and Ingo, and the tool changes are up to Arnaldo and
> > > Namhyung.
> =C2=A0
> > Exactly, as soon as the kernel changes land in a path to upstream,
> > I can
> > do the same for the tooling bits.
>=20
> Once that happens, please resubmit just the tools patches without an
> RFC
> in the subject line.

Will do, thanks!

--=-Oz1hUSas1fZ459BAxScs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTK1ph9OaYoND1R57zoeAEuJe36VgUCarYjzQAKCRDoeAEuJe36
Vta7AP4lWN3nptkMdkcDcSiOSG690zpD3TPdnYRu0Jrrjo2QigD8C+7co0ri+6m6
eXoyuQdskh9e1F2RCjdM46/rmdSLKgk=
=95O6
-----END PGP SIGNATURE-----

--=-Oz1hUSas1fZ459BAxScs--

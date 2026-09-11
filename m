Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86DB44CF52;
	Fri, 11 Sep 2026 07:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789111352; cv=none; b=H3cA+nBAavoa87FaG62JOVv0bMZQaPOqBHOmMF01/aLfOqCd1YFBmEa3IX28Y5K73W4rgQCt039LIeExaMDk4ZQUQ3jp5A7CltZIadqcI/QKAQbRbL6/R6aqHgyuCx0wojQV1PCIFO0zlFrG5koSmEGCrQwBvmuHZL8Ai+brhPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789111352; c=relaxed/simple;
	bh=naeKzsscMTXktcnb/Nhh/RH39fMrfG4aZLk4y4ZkGdU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NfyGQO+qXdtXWzhrLhXGqTl3DxO+fFkFuVGJj4yboz7yTRi23KdERqYsfNgh9shbGbNif3AC8GURZ1p6viTjrWk9OxKTqwFImfJ5F6qhwGi5CfAVEklVcBs41/KPL9ubfB4cmr2g7so5f7rPGkpcN7WykeJrQpQCVZS+Sc8lQf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=HEXn3FxT; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="HEXn3FxT"
Message-ID: <ffbfc17df4f57b8d2de2ed17beb6db6cf573f2fd.camel@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1789110805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=naeKzsscMTXktcnb/Nhh/RH39fMrfG4aZLk4y4ZkGdU=;
	b=HEXn3FxT0174foL/H943lrhNeg9YZ2AFPuO4HIOTmqh8TGUAKzyOi2EhRhUyeIylmxCSX4
	ukNcFqq4L/WdXfv9u60LL3Rn4lsKWtei4yZeqbtpHri0qpil/wnlDNtJ+K+Y3C2oFclBGS
	pVOBJ1C+YWU9e2otaBT6fX7PBucktEs=
Subject: Re: [PATCH v2] sparc64: increase kernel thread stack size to 32K
From: Stian Halseth <stian@itx.no>
To: Tony Rodriguez <unixpro1970@gmail.com>, andreas@gaisler.com, 
	davem@davemloft.net, sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, david.laight.linux@gmail.com, 
 glaubitz@physik.fu-berlin.de, thuth@redhat.com,
 regressions@lists.linux.dev,  nroach44@nroach44.id.au
Date: Fri, 11 Sep 2026 09:13:24 +0200
In-Reply-To: <5b920b1d-a32b-494e-b97c-8672a8371dd3@gmail.com>
References: <20260519075809.8993-1-unixpro1970@gmail.com>
	 <20260831172928.3082853-1-stian@itx.no>
	 <afaa8ced-0717-4d62-8ea6-4ecdbf489694@gmail.com>
	 <680606d594645568c21afcc552558882c4f59a96.camel@itx.no>
	 <b46209d5-e518-4289-9b3a-5854a2512278@gmail.com>
	 <18d7ea80efbb5dd3d81acbae926da4e027ebfed9.camel@itx.no>
	 <5b920b1d-a32b-494e-b97c-8672a8371dd3@gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-Hwe0JHIAiyYeYqy9/5+u"
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-Hwe0JHIAiyYeYqy9/5+u
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tony,

This email got lost on me, so a bit late reply.

Thanks for testing and validating 32K.

As far as I'm concerned no need to retest. Your results=C2=A0from the 32K
stack test answers the question. I've been testing on 7.2.

Timer patch is just changelog and description changes.

Best regards
Stian
=20

On Tue, 2026-09-01 at 20:30 -0700, Tony Rodriguez wrote:
> Thanks again for the details, but I already had those CONFIG and=20
> stacktrace options defined based on previous debugging sessions.
>=20
> 32K should be fine based on the output (see the link below), and I
> have=20
> not noticed any crashes with a 32K stack).=C2=A0 These results are agains=
t
> kernel v7.1.0-rc3 using my original patches on the S7-2.
>=20
> https://github.com/unixpro1970/Sparc64-Kernel-Debugging-
> Dumps/blob/main/kernel-v7.1.0-rc3-depth-stack-trace-sparc64-s7-2.txt
>=20
>=20
> Should I try your revised 32k stack and timer patches on the S7-2 and
> T7-1?=C2=A0 If so, which kernel version did you validate against 7.2 or
> 7.3?
>=20
>=20
> Regards,
>=20
> Tony
>=20
> On 8/31/26 2:05 PM, Stian Halseth wrote:
> > Hi Tony,
> >=20
> > On Mon, 2026-08-31 at 13:18 -0700, Tony Rodriguez wrote:
> > > Hi Stian,
> > >=20
> > > Just please continue to give me a
> > > mention in any patches related to this work, since I spent a
> > > considerable amount of time debugging, researching, and
> > > validating
> > > the fixes.
> > Sure. For now, no real changes have been made to your patches, so
> > as
> > far as I'm concerned, this is entirely your work.
> > Will try help with the last mile, alongside some other patches I've
> > submitted.
> > And yes, the debugging, researching and validation is the hard
> > part.
> > Writing a fix is often _relatively_ easy, when you have all the
> > facts.
> > > When I last tested on 7.0 and 7.1, both of my patches worked:
> > >=20
> > > A)=C2=A0 =C2=A0 sparc64: increase kernel thread stack size to 32K
> > >=20
> > > B)=C2=A0 =C2=A0 sparc64: Fix comparator problem with timer interrupts
> > >=20
> > > I was able to debug and validate these issues on S7=E2=80=912 and T7=
=E2=80=911
> > > hardware.
> > Yes, and that's a very important data point. My analyzis is based
> > on
> > the change itself, _and_ your validation/testing.
> > > I=E2=80=99m not sure if others have reported similar problems on T4 o=
r T5
> > > systems.
> > Not that I'm aware of, and I haven't seen it on my T4-1.
> > > If you have a quicker or better methodology for reviewing stack
> > > usage=E2=80=94or
> > > any general suggestions=E2=80=94I=E2=80=99m definitely open to seeing=
 them, along
> > > with
> > > your config and exact procedure. And if you need help validating
> > > against
> > > S7=E2=80=912 and T7=E2=80=911 hardware, I can try to allocate some ti=
me to
> > > assist.
> > I think that would be very helpful. Let's try to settle the 32K-vs-
> > 64K
> > question with more data.
> >=20
> > The kernel has stack measurement built in.
> >=20
> > The in-kernel method:
> > =C2=A0=C2=A0 CONFIG_STACK_TRACER=3Dy
> > =C2=A0=C2=A0 CONFIG_DEBUG_STACK_USAGE=3Dy
> > =C2=A0=C2=A0 CONFIG_SCHED_STACK_END_CHECK=3Dy
> >=20
> > Boot with "stacktrace" on the kernel command line (arms the tracer
> > before built-in drivers probe). Then:
> >=20
> > =C2=A0=C2=A0 cat /sys/kernel/tracing/stack_max_size=C2=A0=C2=A0 # worst=
 case seen,
> > bytes
> > =C2=A0=C2=A0 cat /sys/kernel/tracing/stack_trace=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 # that path, frame by
> > frame
> >=20
> > Reset with "echo 0 > stack_max_size" before a workload to isolate
> > it.
> >=20
> > For the 32K-vs-64K question, the most valuable data you could
> > gather
> > is a stack_trace snapshot on the S7-2/T7-1 under your real workload
> > with mlx5 active, on a 32K kernel.
> >=20
> > On our T4-1 the worst case is 12616 bytes, but doesn't have
> > mlx5.=C2=A0If
> > your machines stay well under 32K, we have comfortable margin. But
> > if
> > something approaches the limit, the trace will name the exact
> > frames,
> > and we can judge whether the right answer is 64K or a targeted fix
> > in
> > that driver.
> > Thanks!
> >=20

--=-Hwe0JHIAiyYeYqy9/5+u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTK1ph9OaYoND1R57zoeAEuJe36VgUCaqOqFAAKCRDoeAEuJe36
Vjk7AP9ohX1Yt0xlUXhufw72uHIv4j32gtVpRhZxWn43gAiw+gD/SrXkQxT34SS2
uS9+qBb+zeVlmnygH3J7XDSmYWmszQY=
=emyu
-----END PGP SIGNATURE-----

--=-Hwe0JHIAiyYeYqy9/5+u--

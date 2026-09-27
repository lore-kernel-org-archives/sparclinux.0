Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952BF3C0A1E;
	Sun, 27 Sep 2026 21:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790544617; cv=none; b=RhlSjqfgKd90UnphvQj5wPLeSN/sqjcfgVf8JkC+lWBL183cUXAv0W0NRc6D44QOKqajTS6RhsxBth3pJmgO/h1ho+Sw9NAtgy6HX/D3srbECrnXk/efOadL3gO6vsQnRPKgW/n3lqkYt1Ke0WyJPPgCzIGzBTigrTBT7sqxRH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790544617; c=relaxed/simple;
	bh=5E+12Be7OEjou2LCPKAP/4vXzFvj7dPan4fmMbDq538=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hdMsLPh+0Hl8XgxgfLybdfxNsoCp/9A10e43lPB3Ow89QmUmtngFHh/ye0XIV+1/o2LB0wJNx2sEryb1HfL1osT2EWKdd+kMl/ZHe4AcmHra1a5x6WvknMsO/6Fj6vSmrA/qC6uc0Gc3T8t/zMKcP9aiR88Sjs2N6hO4dMmmW9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=a0dMnNNP; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="a0dMnNNP"
Message-ID: <33811471d0a5c2a48b74132544761bfaa593bb63.camel@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1790544612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CUDG9GC9eRqW+mvK68VrsUJWYeyozDIV4IPnZX7k+1Y=;
	b=a0dMnNNPo+2z4DPljLy0f3/6hGzZ9K2i7j/oTSm8YXSrD6I+H2RwsxUlGtNkMzW4pYLCR/
	Y04IbIsNRc8mZe+A39uSz/0rG0bQdVZ0/mb+moYi3+YdS5PLuUPq6UE/7Z/4zeLrKKOUZV
	nqMHviMFeH3fuBaxb2Jvbd99LMWkzh0=
Subject: Re: [PATCH v2] sparc64: increase kernel thread stack size to 32K
From: Stian Halseth <stian@itx.no>
To: Imre Kaloz <kaloz@kernel.org>
Cc: Andreas Larsson <andreas@gaisler.com>, davem@davemloft.net, 
 sparclinux@vger.kernel.org, Tony Rodriguez <unixpro1970@gmail.com>, 
 linux-kernel@vger.kernel.org, david.laight.linux@gmail.com, 
 glaubitz@physik.fu-berlin.de, thuth@redhat.com,
 regressions@lists.linux.dev,  nroach44@nroach44.id.au
Date: Sun, 27 Sep 2026 23:30:11 +0200
In-Reply-To: <20260927204912.3667-1-kaloz@kernel.org>
References: <20260519075809.8993-1-unixpro1970@gmail.com>
	 <20260831172928.3082853-1-stian@itx.no>
	 <20260927204912.3667-1-kaloz@kernel.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-BJgZ19SNOurW6N2jL4c+"
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-BJgZ19SNOurW6N2jL4c+
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Imre,

Sending V3 with two separate patches now.

Thank for the feedback and testing!

Stian

On Sun, 2026-09-27 at 22:49 +0200, Imre Kaloz wrote:
> Hi Stian,
>=20
> I ran this on a Sun Ultra 45 (UltraSPARC IIIi, SMP). The unpatched
> kernel hits "corrupted stack end detected inside scheduler" in
> hub_power_on() on 10 out of 10 boots with USB devices attached. With
> the 32K stack it boots clean every time: 6 boots with the v1 diff,
> 10 more with the minimal diff below. A forced hub/device rebind with
> the stack tracer armed peaked at 15832 of 32768 bytes, so 32K looks
> like plenty here.
>=20
> On v1, Andreas agreed with 32K but asked for the dead else branches
> to be pulled into their own patch with a fixup tag for 15b9350a177b,
> since that commit should have removed them already. v2 folds the
> removal into the same patch, so I'd split it back out for v3: the
> fix as the minimal diff below, the else-branch removal as its own
> patch on top. Nice work!
>=20
> The minimal diff is below the scissors, feel free to fold it in.
>=20
> Tested-by: Imre Kaloz <kaloz@kernel.org> # Sun Ultra 45
>=20
>=20
> Best,
> Imre
>=20
> -- >8 --
> Signed-off-by: Imre Kaloz <kaloz@kernel.org>
> ---
> diff --git a/arch/sparc/include/asm/thread_info_64.h
> b/arch/sparc/include/asm/thread_info_64.h
> index c8a73dff27f8..ec552513d63c 100644
> --- a/arch/sparc/include/asm/thread_info_64.h
> +++ b/arch/sparc/include/asm/thread_info_64.h
> @@ -100,8 +100,8 @@ struct thread_info {
> =A0#define	FAULT_CODE_BAD_RA	0x20	/* Bad RA for
> sun4v		=A0=A0 */
> =A0
> =A0#if PAGE_SHIFT =3D=3D 13
> -#define THREAD_SIZE (2*PAGE_SIZE)
> -#define THREAD_SHIFT (PAGE_SHIFT + 1)
> +#define THREAD_SIZE (4*PAGE_SIZE)
> +#define THREAD_SHIFT (PAGE_SHIFT + 2)
> =A0#else /* PAGE_SHIFT =3D=3D 13 */
> =A0#define THREAD_SIZE PAGE_SIZE
> =A0#define THREAD_SHIFT PAGE_SHIFT
> @@ -129,7 +129,7 @@ extern struct thread_info
> *current_thread_info(void);
> =A0
> =A0/* thread information allocation */
> =A0#if PAGE_SHIFT =3D=3D 13
> -#define THREAD_SIZE_ORDER	1
> +#define THREAD_SIZE_ORDER	2
> =A0#else /* PAGE_SHIFT =3D=3D 13 */
> =A0#define THREAD_SIZE_ORDER	0
> =A0#endif /* PAGE_SHIFT =3D=3D 13 */

--=-BJgZ19SNOurW6N2jL4c+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTK1ph9OaYoND1R57zoeAEuJe36VgUCarmK4wAKCRDoeAEuJe36
VogkAP9R7tEqlrVRNhzy1/oMtAPyOM6pCa5aqPcJIqcKctwXrAD/RfqGNQxiB1yp
hcrSouDqwd06nNX/xu7EAmo1qUIq3Qs=
=1H8C
-----END PGP SIGNATURE-----

--=-BJgZ19SNOurW6N2jL4c+--

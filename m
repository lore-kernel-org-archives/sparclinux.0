Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6502F4B8276;
	Mon, 19 Oct 2026 09:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792403397; cv=none; b=h/11z8Pm6CAuy/G6tDLmtFE+gBhg4rqj9ND3p0DxMfHyAzRv42HM2mN/g+2gZoeQAJhu1+dvylZmn8/pnaQlfRGjNMLZ0BYILxNjbOmBq41OhnxlOzkZEGT2oKItBy0+XLzMX5jH0Hzs0e+WNV8Kk5H4arIHFcyU13rSH4AT5FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792403397; c=relaxed/simple;
	bh=tNwh0NgMwC2NxmyZzoBmi8wtLFpnWDZrPMg2XzlB5WI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kUyJJ7QO0Ct/rPFVcagfMYCDwp6hhCJuDvLTQS8RJL9/jLzvqnL6nJ29pMyGMSbYuSiwUr/nAyRmRMGvB5Osvfy4Tasn8Um7HY5FHePMK+EuBdvEdo7FcOmuUkGDT7qPl1AcG66MVZ4Yj1jvFDlI+Imnaa4HL0aVN2C85G3+kNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=FmiHeiqw; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="FmiHeiqw"
Message-ID: <156ed58445e869ffb783bfee0c07bc784f6178ad.camel@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1792403390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bn4aGHXHs3sa40Ens1ww3bFvwndhquiAPhSKtFdOVUw=;
	b=FmiHeiqwpE9q8wlbdZYTJ2H6clE3pAQHuI/kAbL7irNE581hmsL20y2aaEAqDKahaFt27N
	nqURCj7esDaGWoCwW4cs5WngqyLh/R9D/gIZVl3GtUA8/AQPI7l0nsNWKHuQmxZ9fovFxS
	zbwcS7tgF+Oh20fAz91Zvm9pkh4fCtE=
Subject: Re: [PATCH] sparc: populate sysfs cache topology information on
 sun4v
From: Stian Halseth <stian@itx.no>
To: Jan Engelhardt <jengelh@inai.de>, davem@davemloft.net
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, John Paul
 Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Mon, 19 Oct 2026 11:49:49 +0200
In-Reply-To: <20261018222723.43442-1-jengelh@inai.de>
References: <20261018222723.43442-1-jengelh@inai.de>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-MkgeK9/okFuKXT4SCUx/"
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-MkgeK9/okFuKXT4SCUx/
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Jan, thanks for looking into this!

On Mon, 2026-10-19 at 00:27 +0200, Jan Engelhardt wrote:
> +int init_cache_level(unsigned int cpu)
> +{
> +	struct cpu_cacheinfo *i =3D get_cpu_cacheinfo(cpu);
> +	i->num_levels =3D 2;
> +	i->num_leaves =3D 3;

Using the MD node as the cache id with CACHE_ID set looks to me like
the right way to do it. I tried it on my T4-1 and V240 and have a few
comments.

mdesc.c is also built for sun4u and there the new *_id fields are never
filled in and stay 0, so both CPUs end up sharing every cache. On my
V240 lscpu goes from 128K L1d in 2 instances to 64K in 1, and the same
for L1i and L2. A tlb_type =3D=3D hypervisor check here, like the one in
setup_per_cpu_areas(), and -ENOENT otherwise puts it back to how it is
today. I tested that too.

The fixed 2 levels / 3 leaves also only fits T1-T3. On the T4-1 L1 and
L2 come out right now (16K and 128K per core, 8 instances), but the
4M L3 shared by all strands is missing. I dumped the cache nodes from
/dev/mdesc on my T4-1 and T7-1:

  T4:  L1i/L1d per core, L2 128K per core, L3 4M shared by all
  M7:  L1i/L1d per core, L2 data per 2 cores + L2 instn per 4 cores
       (both level 2), L3 8M per 4 cores

On M7 the L2 you get is whichever level 2 node fill_in_one_cache()
hits last (data here), labelled Unified. That's what Tony saw on his
S7 too. The missing L3 isn't just cosmetic either. The scheduler,
sched_ext and the page allocator use the last leaf as the LLC, so the
T4 would end up with a per-core 128K L2 as its LLC.

Maybe it's simpler to just walk the MD directly in init_cache_level()
and populate_cache_leaves(), following the same arcs as
fill_in_one_cpu(), and add one leaf per cache node? Then you get the
split L2 and the L3 for free, and cpuinfo_sparc doesn't have to grow.

Tony, about your first list: CACHE_ID is right, it's the flag that
tells the generic code leaf->id is valid. I built the T4 kernel without
it as well, and then nothing shows up at all, cacheinfo just says
"Failed to find cpu0 device node" and gives up. The functions override
the __weak ones in drivers/base/cacheinfo.c, so they have to stay
non-static. The L2 split and the L3 you found on the S7 are real
though.

/Stian



--=-MkgeK9/okFuKXT4SCUx/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTK1ph9OaYoND1R57zoeAEuJe36VgUCatXnvQAKCRDoeAEuJe36
VhcHAQD8KumrLMH1zPG9vdglrfCbvFsITFLJDqpPhVwdaunJRgEA3RJ5VWUjeMIc
x47qVdMf0mzY37f0nHfOEpQvt3GXcgQ=
=O+JQ
-----END PGP SIGNATURE-----

--=-MkgeK9/okFuKXT4SCUx/--

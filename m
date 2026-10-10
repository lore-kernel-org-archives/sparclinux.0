Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01F7314D05
	for <sparclinux@vger.kernel.org>; Sat, 10 Oct 2026 18:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791658619; cv=none; b=qFTforLe6ZPEpalxiXZeNDWfezx6K+cbOCxYSbCVi1GwzkQVsKu8eAq/ahF4lzSflNcm34WCoSsdCGoAQtLbih9bQGVVrJGjYaJLwmPIzeo9YS4aC9FTvBx3JiYElZrVR4YT9Go2Sywpn4C1/z5TblxIO7Fwl2qVshp0ORYa+UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791658619; c=relaxed/simple;
	bh=x4Dj3D+mx36RZj1aU0C6LDiGFIbZso7ouKNWtakOBy4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bpysfQ75PlM9IElIKL3UVzyr729v1iWwKNUKdi2dgZKGkyQngQivSNO8Xy1BSmBuTV9vE2fjXVAmS7BHg4pkQdGQNxwgsz5Be/UQWlgOcuz+l9R8gThW0F6QboS7aRQOYBspviY1nPHBRIMfwHNov8MFwjqkg/4xS9MFeAULqVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=OiarkgLs; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="OiarkgLs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=y+Q4Lygc0F6ENBeMk3Qo0mz/OrsZBy6ElZMaI5uZR9c=; t=1791658616;
	x=1792263416; b=OiarkgLsKSlwjMUuZ5CVFHflCy83lTEfMpcrlTs6+YOXiEbN/+MkPx8SpyafV
	yBomrQjMZPMTT5qV45q87PmgzBPcVas1Vo/7gLb9BGv04lFyy2lD1x15Edxoj9GRPUMMWyxyInhC9
	kN1KZbLDr+QU8Njxtby6n0ZJo747ZaJ2edYLolhSj1RlTsGy2509rGm2Ljzztmm+wPKL+HHQpYEZ9
	ZnuQiyUwgqMlMCFR29BPFxu7CFJmT/znNGVWzl1gTVoxQoW68bTsHTI+c56XYb4NDZCRTKjPNHRsP
	3Gff4am1m7kw6iCpTeEcjthwrTlOwA/D0qA+QqxMf0HOlS+ncw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xFcFa-00000000zf3-1y2V; Sat, 10 Oct 2026 20:56:54 +0200
Received: from dynamic-077-183-246-238.77.183.pool.telefonica.de ([77.183.246.238] helo=[192.168.178.50])
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xFcFa-000000048OT-14sx; Sat, 10 Oct 2026 20:56:54 +0200
Message-ID: <ed3c37da1320ac19bd45dbfaa89957d9a8c05e0f.camel@physik.fu-berlin.de>
Subject: Re: Mount crashes with SIGILL on v240 on for-next
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Stian Halseth <stian@itx.no>, sparclinux <sparclinux@vger.kernel.org>
Cc: Imre Kaloz <kaloz@kernel.org>, Andreas Larsson <andreas@gaisler.com>, 
 Magnus Lindholm <linmag7@gmail.com>
Date: Sat, 10 Oct 2026 20:56:53 +0200
In-Reply-To: <01bd740a7b5f2c5cd12b4ba025fb9a53573188bf.camel@itx.no>
References: 
	<b74cffe77f82562fae8cf611349e765f1f38af2c.camel@physik.fu-berlin.de>
		 <14ae2aabb9e681a69818d3e02da8273cd12261b8.camel@itx.no>
		 <69c1798a6409879a70474c10e3d653fdb37c7246.camel@physik.fu-berlin.de>
		 <ef8e85c1fc00c999e74b2d43048bfa67997c13a2.camel@itx.no>
	 <01bd740a7b5f2c5cd12b4ba025fb9a53573188bf.camel@itx.no>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Stian,

On Sat, 2026-10-10 at 20:31 +0200, Stian Halseth wrote:
> Tested with the same config, even built it with the same crosstool gcc
> 15.2.0 / binutils 2.45 on Andreas' for-next. My V240 boots and loads
> ext4 from the initramfs every time.

Odd that you can't reproduce it.

> CONFIG_SMP unset, is that intended, do you have a single CPU V240?

Yes, that machine has only one CPU.

> Does this exact setup (UP kernel, ftrace, xz-compressed modules
> decompressed by the kernel) ever work with an earlier kernel? If so,
> which version was the last good one?=C2=A0

Yes, it worked fine with earlier kernels besides the stack-size issue.

> If this isn't a regression in the for-next branch, I would try to apply
> Kaloz v2 patch from sparclinux #29. I cannot reproduce / test, but
> since you have the issue, I would be very interested to know if it
> makes a difference:
> https://lore.kernel.org/all/20260928132102.1707-1-kaloz@kernel.org/

Applied both patches, system boots without issues now. Will continue
testing and see if it's stable.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963242EB5A6
	for <sparclinux@vger.kernel.org>; Sat, 10 Oct 2026 20:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791663511; cv=none; b=kjRmJ+WiScJ4JORHi5VbOsCGNw0z2N9k0oaCtTdGFAMBLIwbAnFmsLVeeUBUC9XC+m05H6qIqsovV0upUIpOTrApPy+u68M0Qo7B4z5E9eLhagXibxYPW8D3yed+Tn3RunAtlfEGBuOwL1FzNVEm5suppRMVY1Nqb8+ODbiRxpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791663511; c=relaxed/simple;
	bh=mISr/VxeNHvjOoBS3Lt5viiVF6MRqNw0mlnBBxrbm7U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qfuLItNbN0CD7IIy9+xfgwtc+51dusYLpZ5iNB4n6n9zbBgPuDX1M42/QwuWSlCtvLaBd0Tfr1557M5mqfyhebNgw/GomuqBkadsjtqm85MXZ9dS+4LwHEY+kDh9/wfKE8rRpo/nzH7ceFeDK5rZ2HxlE6o2B/n1wuvYttTJ7+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=fQfkF+TJ; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="fQfkF+TJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=wBGVAeNTfg5CpZ5yhCo+w8E7r5vnrxgWA1rdC3M8vYE=; t=1791663508;
	x=1792268308; b=fQfkF+TJ22YAKv+XwoxCVkhMsrnOvweFEVgmtAfofOuIhquy+cVrwyAIjD1Ya
	k6ydTJuNAaB64VRrhZVfdWoRlt3WNu0sb4sOLzy46iCEEGRfYw4yKIcIJeszJHRux7KvTF+jNHyyj
	PVoc8DEOQWMZMiBDMlB5AJy6X0lYwVr97Ht46q3vwPicZQ2mF03GtWmRop1s0SK5FPyD65vD2gGsr
	8RtaznV6i/cOAY2Ho0bkaX7D/nowLwfEpYwp+5D2TpoPRsGS4exh4Q5io0HcIzbxpY3UQ80Z9OYBo
	OgrQHKuE2/GHB44jyE+o57QGgkXOTucc4g/jg1piev5xEUPjlw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xFdWU-00000001BOx-0lOS; Sat, 10 Oct 2026 22:18:26 +0200
Received: from dynamic-077-183-246-238.77.183.pool.telefonica.de ([77.183.246.238] helo=[192.168.178.50])
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xFdWT-000000006m3-45kX; Sat, 10 Oct 2026 22:18:26 +0200
Message-ID: <c4fd9e838043b2b552ea9c33dfaf716a5e9d5b6a.camel@physik.fu-berlin.de>
Subject: Re: Mount crashes with SIGILL on v240 on for-next
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Stian Halseth <stian@itx.no>, sparclinux <sparclinux@vger.kernel.org>
Cc: Imre Kaloz <kaloz@kernel.org>, Andreas Larsson <andreas@gaisler.com>, 
 Magnus Lindholm <linmag7@gmail.com>
Date: Sat, 10 Oct 2026 22:18:24 +0200
In-Reply-To: <b85e047233f5b38cdbfbd7af852ce30055680b47.camel@itx.no>
References: 
	<b74cffe77f82562fae8cf611349e765f1f38af2c.camel@physik.fu-berlin.de>
		 <14ae2aabb9e681a69818d3e02da8273cd12261b8.camel@itx.no>
		 <69c1798a6409879a70474c10e3d653fdb37c7246.camel@physik.fu-berlin.de>
		 <ef8e85c1fc00c999e74b2d43048bfa67997c13a2.camel@itx.no>
		 <01bd740a7b5f2c5cd12b4ba025fb9a53573188bf.camel@itx.no>
		 <ed3c37da1320ac19bd45dbfaa89957d9a8c05e0f.camel@physik.fu-berlin.de>
	 <b85e047233f5b38cdbfbd7af852ce30055680b47.camel@itx.no>
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

On Sat, 2026-10-10 at 21:06 +0200, Stian Halseth wrote:
> > > If this isn't a regression in the for-next branch, I would try to
> > > apply
> > > Kaloz v2 patch from sparclinux #29. I cannot reproduce / test, but
> > > since you have the issue, I would be very interested to know if it
> > > makes a difference:
> > > https://lore.kernel.org/all/20260928132102.1707-1-kaloz@kernel.org/
> >=20
> > Applied both patches, system boots without issues now. Will continue
> > testing and see if it's stable.
> >=20
> Looks like you hit this, where I didn't. Glad it worked. Should
> probably look at bringing that patch in as well. I've tested it with no
> regression on my dual CPU V240.=20

Did your kernel ever crash with CONFIG_CGROUP_BPF enabled? That was my
original reproducer.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

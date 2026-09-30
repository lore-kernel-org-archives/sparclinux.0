Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9934A46F494
	for <sparclinux@vger.kernel.org>; Wed, 30 Sep 2026 20:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790799800; cv=none; b=gQc8SGRYPG+KvTj97/TKCQTPpM7udqe3Df33N5e5HDBX0dGjkVNQeZQ9vU2m9VUqAEu4aAv+RojR5ft0IUTZ6eyr6iMk5B84k8juHEHPMTI/MaeYer6WPfh0+9yaV4FwCTXOLPT5EtxL7clGGS4fPVy6JtGcHqVHUrhwMDvIu/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790799800; c=relaxed/simple;
	bh=XvDY3QH8cZCf+9SUv2McOikXBHE/rMi1UiU/rKU0XU4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zs8y+0UBC052VcfgG7Gu6eCTkOQ7zCv0yLAUoT+YKy2i8Ty0oij4zTGHqg3IXG+HBsgbUFPJtZLzvkk06NCAu3lPBYqCQ5ZGUncyakfKG5ksspVOqc99oTfkGwne3R0p7LicS1oVqRhTvmsW33r/J2gYLtWTlLiKkZ7jH8NSeD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=Oyf6A4Se; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="Oyf6A4Se"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=KO/NHWDxxhfW0snG8mozl2NuFX1Ss+LjUMBixelfidc=; t=1790799797;
	x=1791404597; b=Oyf6A4SeykFR5hNA+lYPvgXUU9wZ3wsISHLyYdCK5pCMusb7ZvI3RLBsd2nuB
	UV8MJhGFI7c7tDYXM9WcSnqaleNGMOvVbvYYZFJtNDgQ+TUo6Lp1xOagrwHyMTDsIP3zYDANZzqdq
	HJ9bOgaB34linBP5ZloqhpiNhxfSTBHLAgT104SSDKeSMFLOd7wGt0s+gKiKrqVEQWtbZZdyo8otT
	gtwT/nVlQ1aQCOwrBQIBVaRqAe0QH3pUHa3r0+RcLEwVNscrU3G9IRBs53FNLUw/7W7UR8boUFUuk
	QVTQP9JC2NOfSkdDYkAgGxh5lK792NhiDNWHTV5+w8v7q896yw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xC0pf-00000001vxp-1S1Z; Wed, 30 Sep 2026 22:23:15 +0200
Received: from p5dc55206.dip0.t-ipconnect.de ([93.197.82.6] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xC0pf-00000001EhL-0X1u; Wed, 30 Sep 2026 22:23:15 +0200
Message-ID: <071a1ebbd8dc9d99bfe9b4c98285f435bdb3a39f.camel@physik.fu-berlin.de>
Subject: Linux on Fujitsu M3000 - was: Re: [PATCH v3] crypto: aes - Fix
 undesired override of some optimized AES modes
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Magnus Lindholm <linmag7@gmail.com>, Stian Halseth <stian@itx.no>, 
 Dennis Clarke <dclarke@blastwave.org>
Cc: sparclinux@vger.kernel.org, "<debian-sparc@lists.debian.org>"
	 <debian-sparc@lists.debian.org>
Date: Wed, 30 Sep 2026 22:23:14 +0200
In-Reply-To: <CA+=Fv5R0F5YNgORUx1c8YWzyFcS6wqVtmzQUXaS3vuLHYwBndw@mail.gmail.com>
References: <20260929222752.36427-1-ebiggers@kernel.org>
	 <322e5255353e3a5f9e3840a496018edd980fb016.camel@itx.no>
	 <1f85bdb9614365fedda81fb649147da48bf7be13.camel@physik.fu-berlin.de>
	 <25c7a7c7bbe3c7f70fca559867e0883b9e4dc48d.camel@itx.no>
	 <3ea57d640ac7409fa37b15ec9e3f49126347e432.camel@physik.fu-berlin.de>
	 <8d3d3142d1ac323695a3ea2d5b3e2a10d2a129d6.camel@itx.no>
	 <CA+=Fv5R0F5YNgORUx1c8YWzyFcS6wqVtmzQUXaS3vuLHYwBndw@mail.gmail.com>
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

On Wed, 2026-09-30 at 18:03 +0200, Magnus Lindholm wrote:
> Hi,
>=20
> On Wed, Sep 30, 2026 at 4:52=E2=80=AFPM Stian Halseth <stian@itx.no> wrot=
e:
> >=20
> > Hi Adrian,
> >=20
> > On Wed, 2026-09-30 at 11:27 +0200, John Paul Adrian Glaubitz wrote:
> > >=20
> > >=20
> > > > The T2 and T3 has a separate crypto unit, but not supported here.
> > > > Support was removed from the kernel in 6.14. Haven't tested it, as
> > > > I
> > > > don't have the hardware.
> > >=20
> > > Why was it removed? I'm not happy about such removals as long as the
> > > hardware is supported.
> >=20
> > Looks like there were issues that prompted the removal:
> > https://github.com/torvalds/linux/commit/9cda46babdfe
> >=20
> >=20
> > >=20
> > > > Also worth noting, it's only used when the firmware lists the
> > > > machine
> > > > description's hwcap-list and the CFR has its bit set.
> > >=20
> > > Is that not the case by default?
> > Yes, on real hardware. Just mentioned to clarify that it doesn't cause
> > problems on hardware that doesn't support it.
> >=20
> > > > I have no idea about Fujitsu's SPARC64 X family.
> > >=20
> > > -relocatable-kernelI think SPARC64 X is not supported by the Linux ke=
rnel at all, is it?
> > >=20
> > There some chip detection for it, but I've never tested, or heard about
> > anyone actually using it.
> >=20
> > sparc64: correctly recognize SPARC64-X chips
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D76950e6e54ccfc98a25b501dbb1bc879cce1aa29
> >=20
> > cpu hw caps support for sparc64x:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D4e96377983d2e060dd89703f1846ad920af9e17f
> >=20
>=20
> I while back I got a hold of a Sun/Orcle M3000 box, there wasn't that muc=
h
> missing in the linux kernel, and some hardware manuals available online
> gave me the missing pieces. I have an experimental kernel running now
> with gentoo user-land installed. The box has been running stable for a wh=
ile
> now during normal load (building stuff with emerge). I'm doing some final
> cleanup work with the patches now before I send them out.
>=20
> Some details below:
>=20
> m3000 ~ # cat /proc/cpuinfo
> cpu : Fujitsu SPARC64 VII / VII+
> fpu : Fujitsu SPARC64 VII integrated FPU
> pmu : (null)
> prom : OBP 4.33.5.d 2012/07/18 06:55
> type : sun4u
> ncpus probed : 8
> ncpus active : 8
> D$ parity tl1 : 0
> I$ parity tl1 : 0
> cpucaps : flush,stbar,swap,muldiv,v9,mul32,div32,v8plus
> Cpu0ClkTck : 0000000000000000
> Cpu1ClkTck : 0000000000000000
> Cpu2ClkTck : 0000000000000000
> Cpu3ClkTck : 0000000000000000
> Cpu4ClkTck : 0000000000000000
> Cpu5ClkTck : 0000000000000000
> Cpu6ClkTck : 0000000000000000
> Cpu7ClkTck : 0000000000000000
> MMU Type : Fujitsu SPARC64 VII (experimental)
> MMU PGSZs : 8K,64K,512K,4MB
> State:
> CPU0: online
> CPU1: online
> CPU2: online
> CPU3: online
> CPU4: online
> CPU5: online
> CPU6: online
> CPU7: online
> m3000 ~ # uname -a
> Linux m3000 7.3.0-rc1-m3000-rfc5 #2 SMP Sun Sep 20 18:04:02 CEST 2026
> sparc64 sun4u Fujitsu SPARC64 VII / VII+ GNU/Linux
> m3000 ~ # cat /proc/meminfo
> MemTotal:       16595712 kB
> MemFree:        16337304 kB
> MemAvailable:   16440248 kB

Dennis Clarke (CC'ed) might be very interested to hear about this. He
wanted to install Debian on his M3000 back in 2022 [1]. Maybe Dennis
can help testing patches.

Adrian

> [1] https://lists.debian.org/debian-sparc/2022/05/msg00003.html

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

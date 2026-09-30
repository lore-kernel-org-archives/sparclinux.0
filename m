Received: from mail-ed2-f35.google.com (mail-ed2-f35.google.com [74.125.228.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114F451C060
	for <sparclinux@vger.kernel.org>; Wed, 30 Sep 2026 21:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790804534; cv=pass; b=mO3gv+j1hRbauh+72XBcnBIoy8f7d+mIWgHkoY7jdmx7eJYfknqUNdmTXSYPElXc7TzQu0kifGQWJmEXVfVJsQU4mWWcSymPdfKUwQBGhtoI2AXHe6854pW5RJJl21nXYXWFpegUXSTp3R6HZror8aRESPdJCP04keyPsGa4v0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790804534; c=relaxed/simple;
	bh=Qkob6+20CZ/NienufMASrUQ4i7XmI4YmUUFYyYDa3AU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hXr8VmEmGHWZESpRYdclDoXolSypLZlTt7wyH+z4DxAbXI65oP08nZ0iObLod3zIbSOHbcAlp5wCDEmJh/HubuGkdC5ZCmvaowRxjXVdyGky6jf4qBzwVJFGhKuliNOmTyYIAOjRQqiaxQYOVheH7vyD/YOtwW1S9728kYviuJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XbmmLk5y; arc=pass smtp.client-ip=74.125.228.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbmmLk5y"
Received: by mail-ed2-f35.google.com with SMTP id 4fb4d7f45d1cf-6a8038a9f10so8103755a12.1
        for <sparclinux@vger.kernel.org>; Wed, 30 Sep 2026 14:42:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790804531; cv=none;
        d=google.com; s=arc-20260327;
        b=ndqRm6hPN66D0MECA0YY5jKooItumKNdsfUUQH7Qxp5hnhprzY4Wc4+a2hJ5yhtQNh
         T7m+TP3EUuGLddQYJGQ57KV3r/fAAgQgHPLIWsHqvOtXRGTg+NdmGlq7hWEglxcCLg41
         9eI0teCAWjH6eC+ZQQD9XbxEFzfbzG0PZg1NclTl+ZReVFMag6CHPKUXx7gj2YDdJNcR
         A6Xdij9qd6wiPS5qrY9KRn2eY1RB4hdXmDwsVHik3etHmb9pJMbq3pvOiJul3v7tQnA8
         YbHt0XQeqQVOpoLuytc3U8CdXLVT441uw8mMyZHlRU/UChRJeHKSOUfgSwelaIH4rcQ1
         D9LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n6tsmkU5pFQ2CiqKaTV6giJdkZYkN+Kd6I5hL35gisQ=;
        fh=pPhkZmGt+ZO1NAC3zJ0MrcVJtjsT8gTfHHEHYxy1RaM=;
        b=YYVTNkoze1OpusKW+iL9JBBEVe3k+bYgXTsKvZ1gQKz89K/HCS4NDcG4ujrzoMv7Sj
         KlgESE3wOqy2mGfKxu7aY9lnwPKM1G8QJ2dsKlezeYeBliKgF3ZFTJ+eG3IG9uyQKnEL
         PRm4R8c896oS3ra3+HAAsCWJfaEToZnZ/kU6mFT9BrX8RmyKFZh4OQvHZuaxWnlYNFdq
         AmsdWqZGap/ExvFbZeACz/wUrKmcf5AtkxnGSFD1sa8RqyDNi++gFR30gXk2YAastLvf
         NaRIHN1v/63XaUC7NfvJXTaERIZ7ITsTr/3CXzB7l+Rf8E9hWJlGfrM0T27lhMnCrNQI
         aywg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790804531; x=1791409331; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=n6tsmkU5pFQ2CiqKaTV6giJdkZYkN+Kd6I5hL35gisQ=;
        b=XbmmLk5yPAz5Yw6oCerA+8IcgxGP9A0UVy+8x6lwIkzijZ5B9RCqtgfujVapBQp8tL
         wwZ6sRJ3IabJu4S2Cqqa6DSxe3S6YQlFBSpVg5K2sc3g0MNBzMJ6gIX6ENs97pHTJzsR
         2W5QjQ095hSwjOMq2g/Krdw+/5ePbP4e9rh2y5CMSQpuaWWvOzjWOHOEIfyeze8YLAUa
         XyUOPkuNsrO3hNEiAeXmxQD/uoNOpPtL6GZvJ/mMvu3TamoZ6qJwCXKYsCG1C0eLNNmP
         tp8II6FslyY3xXZYk4lt5G58aoFe5xOndEOpcBeihHRq+uJuU3hXHVI0udVwv1kbB0/S
         lOtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790804531; x=1791409331;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n6tsmkU5pFQ2CiqKaTV6giJdkZYkN+Kd6I5hL35gisQ=;
        b=PdForhl/ofWkMg506PAAW5AexrkUcmJvRLnd41xI8r1jrsYfnpWne+/641tJuM7cbM
         3jksOkKyTpqKQ2rg2F9gDSBvHqbMPKXHDE/KJgD5qnHDSs5kTByQTspRFFYBy/dg8Rgu
         KFRuZP5c4zQ5+zijGmExarXm4PZjH7/ydwQHTManPX3mcob9k44fT3g0R1U9SkDZaagS
         Hly0NOwAp5iIC7iLBx+W9Ras/xgTRO9IDr1TmA/ldZUSRwLC1kIVT1dCfnPpfUcbFpF2
         DafW0bg56pVaTO7XZRmV6XvM5BmKBX4phOx50VeWkkcc4El0TfbgUqCieSBZ2svj3nXZ
         F5Xw==
X-Forwarded-Encrypted: i=1; AKwUvBwo695PoXvPsaEiQDo2UNmz1kMKNEUF6uhr0jCmo5HzlRA1SyiyqzsD/SzGaabGrKRlFwXjnl9LnsUy@vger.kernel.org
X-Gm-Message-State: AFq9FYIIEA0uPXzup0Fkh3SrdK8bP9+oQR7jyvL+qh21G8fsqaej8juZ
	vSVbqqK7S0eYS5XVkBv6luEEr7baZEN7nJ4pHFuK6a9mhMxviRXu6u/UV5xo2c0ewqCzuzJBV6K
	p8QPFktV+Dk8mmil7HTLm+GJkRPyfWIY=
X-Gm-Gg: AYBFou0VnBShZldX7nUrfzokRiGISt1MPviU+Mq9ItbjLrl2kDWGYRW33dVwYwVZTxC
	Ohd0UKwgpo0q0CKjDV6nfy+AS7RsFNFhisanyQQnXb1cnpBz2Hue/yQV48AF5B1fY/sWuhpdExp
	ThxIEJf4F3IAP7cmC1nep6+SOvV7nuL8qcQUwnoMx8CMYmjuhJwZ1Nq+zzG9JEyEyQnkDjSgN1v
	zP2X3ZcoDPSTIa3qKdEbST4YFwyAueATcq2Hz3kwRvm6qJ0s4OcRxuUGi4wn9T06sUQdrpyb4fH
	Znagdt0f+o9x/7sGENo9jFQqierkbPPUYupIbZvROD9gpvbhZPDaCuL+eaCGmFWuC7c2+zqdjrc
	NpJwUR3JyezqG/Dxi1bQJj2tAWBCS2DCNhx91NmnGZg==
X-Received: by 2002:a05:6402:a0d7:b0:6ac:765e:def6 with SMTP id
 4fb4d7f45d1cf-6ae1985dfdcmr1766304a12.2.1790804531001; Wed, 30 Sep 2026
 14:42:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929222752.36427-1-ebiggers@kernel.org> <322e5255353e3a5f9e3840a496018edd980fb016.camel@itx.no>
 <1f85bdb9614365fedda81fb649147da48bf7be13.camel@physik.fu-berlin.de>
 <25c7a7c7bbe3c7f70fca559867e0883b9e4dc48d.camel@itx.no> <3ea57d640ac7409fa37b15ec9e3f49126347e432.camel@physik.fu-berlin.de>
 <8d3d3142d1ac323695a3ea2d5b3e2a10d2a129d6.camel@itx.no> <CA+=Fv5R0F5YNgORUx1c8YWzyFcS6wqVtmzQUXaS3vuLHYwBndw@mail.gmail.com>
 <071a1ebbd8dc9d99bfe9b4c98285f435bdb3a39f.camel@physik.fu-berlin.de>
In-Reply-To: <071a1ebbd8dc9d99bfe9b4c98285f435bdb3a39f.camel@physik.fu-berlin.de>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Wed, 30 Sep 2026 23:41:57 +0200
X-Gm-Features: AclHuK9PFRzPTN3pe9R5Vo1hkAsWLDrZKDt8xqTRQ_ocPCcvAWqgdmyzJKvdXkw
Message-ID: <CA+=Fv5SgDoLxN5-un=Q2=Q-SYCyZwHMNLEeBkjSqrc5KSS0=ww@mail.gmail.com>
Subject: Re: Linux on Fujitsu M3000 - was: Re: [PATCH v3] crypto: aes - Fix
 undesired override of some optimized AES modes
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Stian Halseth <stian@itx.no>, Dennis Clarke <dclarke@blastwave.org>, sparclinux@vger.kernel.org, 
	"<debian-sparc@lists.debian.org>" <debian-sparc@lists.debian.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Adrian,

On Wed, Sep 30, 2026 at 10:23=E2=80=AFPM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
>
> On Wed, 2026-09-30 at 18:03 +0200, Magnus Lindholm wrote:
> > Hi,
> >
> > On Wed, Sep 30, 2026 at 4:52=E2=80=AFPM Stian Halseth <stian@itx.no> wr=
ote:
> > >
> > > Hi Adrian,
> > >
> > > On Wed, 2026-09-30 at 11:27 +0200, John Paul Adrian Glaubitz wrote:
> > > >
> > > >
> > > > > The T2 and T3 has a separate crypto unit, but not supported here.
> > > > > Support was removed from the kernel in 6.14. Haven't tested it, a=
s
> > > > > I
> > > > > don't have the hardware.
> > > >
> > > > Why was it removed? I'm not happy about such removals as long as th=
e
> > > > hardware is supported.
> > >
> > > Looks like there were issues that prompted the removal:
> > > https://github.com/torvalds/linux/commit/9cda46babdfe
> > >
> > >
> > > >
> > > > > Also worth noting, it's only used when the firmware lists the
> > > > > machine
> > > > > description's hwcap-list and the CFR has its bit set.
> > > >
> > > > Is that not the case by default?
> > > Yes, on real hardware. Just mentioned to clarify that it doesn't caus=
e
> > > problems on hardware that doesn't support it.
> > >
> > > > > I have no idea about Fujitsu's SPARC64 X family.
> > > >
> > > > -relocatable-kernelI think SPARC64 X is not supported by the Linux =
kernel at all, is it?
> > > >
> > > There some chip detection for it, but I've never tested, or heard abo=
ut
> > > anyone actually using it.
> > >
> > > sparc64: correctly recognize SPARC64-X chips
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3D76950e6e54ccfc98a25b501dbb1bc879cce1aa29
> > >
> > > cpu hw caps support for sparc64x:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3D4e96377983d2e060dd89703f1846ad920af9e17f
> > >
> >
> > I while back I got a hold of a Sun/Orcle M3000 box, there wasn't that m=
uch
> > missing in the linux kernel, and some hardware manuals available online
> > gave me the missing pieces. I have an experimental kernel running now
> > with gentoo user-land installed. The box has been running stable for a =
while
> > now during normal load (building stuff with emerge). I'm doing some fin=
al
> > cleanup work with the patches now before I send them out.
> >
> > Some details below:
> >
> > m3000 ~ # cat /proc/cpuinfo
> > cpu : Fujitsu SPARC64 VII / VII+
> > fpu : Fujitsu SPARC64 VII integrated FPU
> > pmu : (null)
> > prom : OBP 4.33.5.d 2012/07/18 06:55
> > type : sun4u
> > ncpus probed : 8
> > ncpus active : 8
> > D$ parity tl1 : 0
> > I$ parity tl1 : 0
> > cpucaps : flush,stbar,swap,muldiv,v9,mul32,div32,v8plus
> > Cpu0ClkTck : 0000000000000000
> > Cpu1ClkTck : 0000000000000000
> > Cpu2ClkTck : 0000000000000000
> > Cpu3ClkTck : 0000000000000000
> > Cpu4ClkTck : 0000000000000000
> > Cpu5ClkTck : 0000000000000000
> > Cpu6ClkTck : 0000000000000000
> > Cpu7ClkTck : 0000000000000000
> > MMU Type : Fujitsu SPARC64 VII (experimental)
> > MMU PGSZs : 8K,64K,512K,4MB
> > State:
> > CPU0: online
> > CPU1: online
> > CPU2: online
> > CPU3: online
> > CPU4: online
> > CPU5: online
> > CPU6: online
> > CPU7: online
> > m3000 ~ # uname -a
> > Linux m3000 7.3.0-rc1-m3000-rfc5 #2 SMP Sun Sep 20 18:04:02 CEST 2026
> > sparc64 sun4u Fujitsu SPARC64 VII / VII+ GNU/Linux
> > m3000 ~ # cat /proc/meminfo
> > MemTotal:       16595712 kB
> > MemFree:        16337304 kB
> > MemAvailable:   16440248 kB
>
> Dennis Clarke (CC'ed) might be very interested to hear about this. He
> wanted to install Debian on his M3000 back in 2022 [1]. Maybe Dennis
> can help testing patches.
>
> Adrian
>
> > [1] https://lists.debian.org/debian-sparc/2022/05/msg00003.html
>

Thanks for picking this up, I would very much appreciate some help with tes=
ting.
Getting in touch with people who have access to M3000 hardware
and are willing to help out in testing would be great.

I'm gonna go over the patches and do some cleaning up, I hope I'll
have something
to send out by the weekend.

Magnus

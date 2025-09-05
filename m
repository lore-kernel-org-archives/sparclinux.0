Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCF0143756
	for <sparclinux@vger.kernel.org>; Fri,  5 Sep 2025 03:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757043432; cv=none; b=PJdCrRcsnX4Vm/Efmocyffef4WNbfpJAzYxRDHvcn7C9z4fboQHlIHuzOP+zSH4psrlTHe2UK+ebBATcLDqQy+s1KSS/VW9TplgkHL5T7Ub4ijoVZPIDDquYgwz1pH+XaPlA1r4PAJokx7v2qCEMZvZak3f6NPbgp+5XphjuZpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757043432; c=relaxed/simple;
	bh=UJp9ip8wauQcu1GpQXETqeTXkUsYi+rSsoZ/qkCWWWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bVUdt6f9UHW+WW/BiVaSbueIbue9zFoZ00UCjKHV9gb40/2lH4qYekZNGUtG1k2lRARE1sRuBTWQ0X+AQz0kjeWkS4ugNKjwJ2w11YGGSXgR3F6QBkBfxxCXhQaXZoS2LaMeBUqe+5gCrcV4/Bkc+2skInexy+X0mtCIzqZ/giw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=numberzero.org; spf=none smtp.mailfrom=numberzero.org; dkim=pass (2048-bit key) header.d=numberzero-org.20230601.gappssmtp.com header.i=@numberzero-org.20230601.gappssmtp.com header.b=CrzCvdGC; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=numberzero.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=numberzero.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=numberzero-org.20230601.gappssmtp.com header.i=@numberzero-org.20230601.gappssmtp.com header.b="CrzCvdGC"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e98a18faa35so1969498276.0
        for <sparclinux@vger.kernel.org>; Thu, 04 Sep 2025 20:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=numberzero-org.20230601.gappssmtp.com; s=20230601; t=1757043429; x=1757648229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QdUNIXCv9XvocNp6sZjSj50dinQK1dKBVeQLLo7vHE8=;
        b=CrzCvdGCfYbKbjFhlw3slEu4ald0USYHJ4YMKLLeNl4esluXd0l1XOfkfuEyt2fBg5
         8hlXlFz6gE/vlaxqLc0Gx2SOu0F2wiH9hVHI/HEHepffeWqlD8UZFy9J7zYwQpOVfdDO
         zOnCMTAFsxOEQKpkjEQiK9lIa5Sjgu7dwQp+6hQJTITizPNEVTqRSFAbumrk2n1es2Hm
         CYyP9sgm/zdnjStAKEinSV6pjKBe+Fi5D5pDrvumB/oKgsUF/vUuoUkud+Kb2gSp+0J7
         JnZj0wXM9mqhEhbTMCocc3gn54kGy7/Ks/mnRrQ4soI2xZWM7P+HWhrfCW12Ou/IbJJd
         kFSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757043429; x=1757648229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QdUNIXCv9XvocNp6sZjSj50dinQK1dKBVeQLLo7vHE8=;
        b=c1TsvKHJ+EQdCjVG+k5rLxOFMp4Z6u2ZwVhrDTMDydquYzKcRnokdw5DoRCkkdnxRD
         uMuyZBejcVZab5mU2kHjBVszXtYdO+sj081dvH00hWhRDmP29KSXse3jeyXKM24OSCJV
         doNnn04HB+lGS2+qTMiQ0E5ltfDEiYxCPpNMJ2DN/KmAWMx10/IQfhGsJJEMp2+aGzc5
         Zfq3BM9O+6mzNJpMtDpBnOsXo8aL6MpQvXKMgf+2cToBsFUV245Bwgr4HgwosWs2fe5P
         hkc5qc9fgLPnZFDWRxpdJuvyrrHke120Z4RjQ5WN5csoMlX28uiPCOvncp6pXX8VpSjE
         ThkA==
X-Forwarded-Encrypted: i=1; AJvYcCW0r9jPSkyD/HmeAeNGa1B1Tnbh8kJoUroU9ID+S5TA1McRh/AlorwPehpHLqY5khOV+naj66aFyMB3@vger.kernel.org
X-Gm-Message-State: AOJu0YwytHskkW7gWgA04qW+1MZ7czZpxSSchYq8rFUwxNbLrWp4cay2
	87qbhBqGoMWsKbn2CdgNxVR926WIGNFsPiei+CPtqmByy4jQSHeFTYVqE3082YvqV3Gv+bF/jNM
	Gn1RoeWgu3ty5uDmnnuVo2IhKc/xxS5bQeovQ7FdY3A==
X-Gm-Gg: ASbGncseMZaDEi6MeIk5cYDGm0mctICvBjQ4ZkYmefmfO+u41UpiNKiQGrgnn52L38u
	2zJWFY5kaFMAt8J0Y/GeAfcKr/icgXAdnXKTDYG0lmFtPeb+9mRgzlgJ25Ko12Rdxszql5Ju76x
	TwztB9ju8QY4nLnLRSDCMR14S6onoj5mxEsyr05OMAyi1TfsFgUfBq4ixIeqRt7y5iTV1+KF81M
	ilRTDzLddvO6QVEh8M=
X-Google-Smtp-Source: AGHT+IEfQ6DFfq/h4QdvTcXpuLFzvzUFO/OjoGKLieH2aukMeCl4YwyCsxRlXQgtO74o/vpnDSGBcWI1cl11YxP5vJ0=
X-Received: by 2002:a05:6902:2490:b0:e96:efc6:8392 with SMTP id
 3f1490d57ef6-e98a5851c2amr22539626276.43.1757043429439; Thu, 04 Sep 2025
 20:37:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826160312.2070-1-kernel@mkarcher.dialup.fu-berlin.de>
 <20250826160312.2070-4-kernel@mkarcher.dialup.fu-berlin.de> <CA+=Fv5To0A3N0fajWVhP1SfjD4uv1oaPNOpi9dnFVt9yHfaPQw@mail.gmail.com>
In-Reply-To: <CA+=Fv5To0A3N0fajWVhP1SfjD4uv1oaPNOpi9dnFVt9yHfaPQw@mail.gmail.com>
From: Ken Link <iissmart@numberzero.org>
Date: Thu, 4 Sep 2025 22:36:33 -0500
X-Gm-Features: Ac12FXx3P-MtuWX8UMh3cwtZpj2JgMH-3Ra2IT9zPld8mLmWGLobRAKv4x0nHuI
Message-ID: <CAPZdOsYr5HuLuvTBeY85h0vr=VWMXQhoNaq6jr5PVFt7LGx5ig@mail.gmail.com>
Subject: Re: [PATCH 3/4] sparc: fix accurate exception reporting in
 copy_{from_to}_user for Niagara
To: Magnus Lindholm <linmag7@gmail.com>
Cc: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>, linux-kernel@vger.kernel.org, 
	sparclinux@vger.kernel.org, Andreas Larsson <andreas@gaisler.com>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Anthony Yznaga <anthony.yznaga@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I can provide additional test coverage on a T1000, using Adrian's
patched kernel package from:
https://people.debian.org/~glaubitz/sparc64/linux-image-6.12.3-sparc64-smp_=
6.12.3-1+sparc64_sparc64.deb

$ uname -a
Linux t1000a 6.12.3-sparc64-smp #1 SMP Debian 6.12.3-1+sparc64
(2025-08-28) sparc64 GNU/Linux
$ lsb_release -a

No LSB modules are available.
Distributor ID: Debian
Description:    Debian GNU/Linux bookworm/sid
Release:        unstable
Codename:       sid
$ sudo dmesg | grep T1000
[    0.979644] PLATFORM: banner-name [Sun Fire(TM) T1000]
[    0.980069] PLATFORM: name [SUNW,Sun-Fire-T1000]
$ lscpu
Architecture:          sparc64
  CPU op-mode(s):      32-bit, 64-bit
  Byte Order:          Big Endian
CPU(s):                24
  On-line CPU(s) list: 0-23
Model name:            UltraSparc T1 (Niagara)
  Thread(s) per core:  4
  Core(s) per socket:  6
  Socket(s):           1
  Flags:               sun4v
Caches (sum of all):
  L1d:                 192 KiB (24 instances)
  L1i:                 384 KiB (24 instances)
  L2:                  72 MiB (24 instances)

Tested-by: Ken Link <iissmart@numberzero.org>

On Thu, Sep 4, 2025 at 1:37=E2=80=AFPM Magnus Lindholm <linmag7@gmail.com> =
wrote:
>
> I've tested this patch from on my T2000, I've booted up the ISO
>
> https://dl.t2sde.org/binary/2025/incoming/t2-25.9-sparc64-base-wayland-gl=
ibc-gcc-ultrasparc3.iso
>
> And have been running some "regular stuff" like unpacking files and
> building some packages
> with gcc. It seems to work fine. The system has been running stable
> with load for some hours now
> install:/etc# uname -a
> Linux t2 6.16.4-t2 #1 SMP Tue Sep  2 23:17:46 CEST 2025 sparc64 GNU/Linux
> install:/etc# cat /proc/cpuinfo
> cpu : UltraSparc T1 (Niagara)
> fpu : UltraSparc T1 integrated FPU
> pmu : niagara
> prom : OBP 4.30.4.d 2011/07/06 14:29
> type : sun4v
> ncpus probed : 8
> ncpus active : 8
> D$ parity tl1 : 0
> I$ parity tl1 : 0
> cpucaps : flush,stbar,swap,muldiv,v9,blkinit,mul32,div32,v8plus,ASIBlkIni=
t
> Cpu0ClkTck : 000000003b9aca00
> Cpu1ClkTck : 000000003b9aca00
> Cpu2ClkTck : 000000003b9aca00
> Cpu3ClkTck : 000000003b9aca00
> Cpu4ClkTck : 000000003b9aca00
> Cpu5ClkTck : 000000003b9aca00
> Cpu6ClkTck : 000000003b9aca00
> Cpu7ClkTck : 000000003b9aca00
> MMU Type : Hypervisor (sun4v)
> MMU PGSZs : 8K,64K,4MB,256MB
> State:
> CPU0: online
> CPU1: online
> CPU2: online
> CPU3: online
> CPU4: online
> CPU5: online
> CPU6: online
> CPU7: online
>
>
> tested-by: Magnus Lindholm <linmag7@gmail.com>
>
>
> On Tue, Aug 26, 2025 at 6:05=E2=80=AFPM Michael Karcher
> <kernel@mkarcher.dialup.fu-berlin.de> wrote:
> >
> > Fixes: 7ae3aaf53f16 ("sparc64: Convert NGcopy_{from,to}_user to accurat=
e exception reporting.")
> > Signed-off-by: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
> > ---
> >  arch/sparc/lib/NGmemcpy.S | 29 ++++++++++++++++++-----------
> >  1 file changed, 18 insertions(+), 11 deletions(-)
> >
> > diff --git a/arch/sparc/lib/NGmemcpy.S b/arch/sparc/lib/NGmemcpy.S
> > index ee51c1230689..bbd3ea0a6482 100644
> > --- a/arch/sparc/lib/NGmemcpy.S
> > +++ b/arch/sparc/lib/NGmemcpy.S
> > @@ -79,8 +79,8 @@
> >  #ifndef EX_RETVAL
> >  #define EX_RETVAL(x)   x
> >  __restore_asi:
> > -       ret
> >         wr      %g0, ASI_AIUS, %asi
> > +       ret
> >          restore
> >  ENTRY(NG_ret_i2_plus_i4_plus_1)
> >         ba,pt   %xcc, __restore_asi
> > @@ -125,15 +125,16 @@ ENTRY(NG_ret_i2_plus_g1_minus_56)
> >         ba,pt   %xcc, __restore_asi
> >          add    %i2, %g1, %i0
> >  ENDPROC(NG_ret_i2_plus_g1_minus_56)
> > -ENTRY(NG_ret_i2_plus_i4)
> > +ENTRY(NG_ret_i2_plus_i4_plus_16)
> > +        add     %i4, 16, %i4
> >         ba,pt   %xcc, __restore_asi
> >          add    %i2, %i4, %i0
> > -ENDPROC(NG_ret_i2_plus_i4)
> > -ENTRY(NG_ret_i2_plus_i4_minus_8)
> > -       sub     %i4, 8, %i4
> > +ENDPROC(NG_ret_i2_plus_i4_plus_16)
> > +ENTRY(NG_ret_i2_plus_i4_plus_8)
> > +       add     %i4, 8, %i4
> >         ba,pt   %xcc, __restore_asi
> >          add    %i2, %i4, %i0
> > -ENDPROC(NG_ret_i2_plus_i4_minus_8)
> > +ENDPROC(NG_ret_i2_plus_i4_plus_8)
> >  ENTRY(NG_ret_i2_plus_8)
> >         ba,pt   %xcc, __restore_asi
> >          add    %i2, 8, %i0
> > @@ -160,6 +161,12 @@ ENTRY(NG_ret_i2_and_7_plus_i4)
> >         ba,pt   %xcc, __restore_asi
> >          add    %i2, %i4, %i0
> >  ENDPROC(NG_ret_i2_and_7_plus_i4)
> > +ENTRY(NG_ret_i2_and_7_plus_i4_plus_8)
> > +       and     %i2, 7, %i2
> > +       add     %i4, 8, %i4
> > +       ba,pt   %xcc, __restore_asi
> > +        add    %i2, %i4, %i0
> > +ENDPROC(NG_ret_i2_and_7_plus_i4)
> >  #endif
> >
> >         .align          64
> > @@ -405,13 +412,13 @@ FUNC_NAME:        /* %i0=3Ddst, %i1=3Dsrc, %i2=3D=
len */
> >         andn            %i2, 0xf, %i4
> >         and             %i2, 0xf, %i2
> >  1:     subcc           %i4, 0x10, %i4
> > -       EX_LD(LOAD(ldx, %i1, %o4), NG_ret_i2_plus_i4)
> > +       EX_LD(LOAD(ldx, %i1, %o4), NG_ret_i2_plus_i4_plus_16)
> >         add             %i1, 0x08, %i1
> > -       EX_LD(LOAD(ldx, %i1, %g1), NG_ret_i2_plus_i4)
> > +       EX_LD(LOAD(ldx, %i1, %g1), NG_ret_i2_plus_i4_plus_16)
> >         sub             %i1, 0x08, %i1
> > -       EX_ST(STORE(stx, %o4, %i1 + %i3), NG_ret_i2_plus_i4)
> > +       EX_ST(STORE(stx, %o4, %i1 + %i3), NG_ret_i2_plus_i4_plus_16)
> >         add             %i1, 0x8, %i1
> > -       EX_ST(STORE(stx, %g1, %i1 + %i3), NG_ret_i2_plus_i4_minus_8)
> > +       EX_ST(STORE(stx, %g1, %i1 + %i3), NG_ret_i2_plus_i4_plus_8)
> >         bgu,pt          %XCC, 1b
> >          add            %i1, 0x8, %i1
> >  73:    andcc           %i2, 0x8, %g0
> > @@ -468,7 +475,7 @@ FUNC_NAME:  /* %i0=3Ddst, %i1=3Dsrc, %i2=3Dlen */
> >         subcc           %i4, 0x8, %i4
> >         srlx            %g3, %i3, %i5
> >         or              %i5, %g2, %i5
> > -       EX_ST(STORE(stx, %i5, %o0), NG_ret_i2_and_7_plus_i4)
> > +       EX_ST(STORE(stx, %i5, %o0), NG_ret_i2_and_7_plus_i4_plus_8)
> >         add             %o0, 0x8, %o0
> >         bgu,pt          %icc, 1b
> >          sllx           %g3, %g1, %g2
> > --
> > 2.50.1
> >
> >
>

Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AC8136988;
	Thu,  4 Sep 2025 18:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757011021; cv=none; b=CVBYLU8jzIf2XEk2c3FaUY9FjOlp3Va7sWXDBTuWPnxbFNE1TCB+iMe9kWxx8MGb3joHAY+wGsLy2k5j4bw5IncuajjIr7sgOwwysp1pWlLpiDdKJll+7O+gHDIhx/+pUBZmqEcS8v15oECb4lRXZMFzpU3pU3xu2/doNM3ijQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757011021; c=relaxed/simple;
	bh=d1UahPRC2zdA6qWCRwFyoRacivOyJYDFTBdfaBdN5vE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OMoyq162dsO+nY4QoFXE2y3BM9hPdaMn6gQ5FjOWKNYzuspEuJ9iY8+pobMUN/Qb4DKvgRAtk8V6lZxMdpIvShUfMHxlVlFR/865nVrSWBBibUc99nqpokV/jGsB9Ge8Ui6U3eYiwrPr+q9T19W9bceWYLJyk4H0tp//B0JDzf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WBCeyQqa; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBCeyQqa"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b0454d63802so234550566b.2;
        Thu, 04 Sep 2025 11:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757011018; x=1757615818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S2SpnafG503SII4O9TKIfd/M/Bk/AVmQp3CshlY74iQ=;
        b=WBCeyQqaKjJpkhHVT3wI8YGr7NsK/mbJ44ezFuZR7e5afUcZXDPIxLbjxCna48Tlp0
         MdOaD79nLiEPU5A9gdCGnOt0LjMAY7eezVF2hx0AOZr3bjqGd/B1XqxLHvWwoV6SRk7z
         QBRloVWT/azJvzCHmqrkerX4kVv8tgwKDpTrP+bqWOHOR3ZJ1I23xw7T/vDGrvPZz1kd
         VEYBCHOGfuhj/LF5jlXhxzpJVvFgwmLbt1NU9Z1E6Sr45O/v3TyMgKJ/jpKa3OL3d/3O
         o7H4ZFXNpv8LNrJumllZv5995Y0CMZuAZMsNzAhYhjvqk/LIzPUlRvRnIsAl/FY5kKEw
         j3Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757011018; x=1757615818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S2SpnafG503SII4O9TKIfd/M/Bk/AVmQp3CshlY74iQ=;
        b=DVue7X6NCYgzmXYfEVx5Ho9uPpkRP39fi6JLkPaphE8Y+MYgqwdtkzoyVPSl1bSmgP
         xOx8GRr6T3jrv8iNjHL6mUNoBA61V5ISM8IlTldyLTQSYBGLkJV166LgB5ETpUIczQyj
         ObobxXHKW3a4n4k2EJmzcyLMEmoDXMT9agt9Xlw9gKu6hqwOAapBBvGG77KMG72XpLzz
         KOogVTpW/Mvw67TMOBdOUISGFAo5vVNNcuZ08U5QD7ONknqlWPOKUlPnJSqbrwUhag1F
         ueMDLSEAwYV6GDiEINWpMD/sQYoZCE89lKHRwSJTDcE+UMZuJyb7bnqdGuXRZKnm2C6r
         BCYQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5NnGlrplu91Gv6bLdsuM1VQHyTJqNzEBzTM19FQsplC7IDBuOEyWuZMUtj1XA9gStO4CGlRnYHLGJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7NkrVwMMCsQZskU9LWqxe/MQKdVmxuOAvcQb+c17VIJTjD1KF
	bGPxYaXn871BKmMceCQo7+2HTPsr808F8zrCnYIVrDd7kWosD//dVj+RJxdLCnBWStMjBAWUdbV
	TKmGFlz4jCV9aF40p74/P6DyDjDerIcc=
X-Gm-Gg: ASbGncuxlJj+oo14N0eKXLd3zm2W66IX0JA58DFj+tORdpyLqERO4UwNCIL4dUPuh57
	V5wkMfu4SVKbW2O1ZZueryrCujyCV9XoLkjyg127eaWrA9liYPJMoc6Pv6B8QE4YIIViW8xLKDW
	iX44kh9zLRTuVmPKBCpDHwPBfT7VfCEVtp1GJxVbfWDh0BZGy8avssbzrEnz6xfL8wwwvQulw9q
	qUrcctp4lHs/9Il8JY=
X-Google-Smtp-Source: AGHT+IFTY3JdN9BCMxnS1V4bqAYZ2k/1Xi0GPBhL+bvAQ4Qha8iczhfd/0NAJkyYcnvZU0Grdn3/+kiQnFVu2vxPR1U=
X-Received: by 2002:a17:907:7202:b0:b04:4625:2372 with SMTP id
 a640c23a62f3a-b0446252767mr1215877766b.15.1757011017535; Thu, 04 Sep 2025
 11:36:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826160312.2070-1-kernel@mkarcher.dialup.fu-berlin.de> <20250826160312.2070-4-kernel@mkarcher.dialup.fu-berlin.de>
In-Reply-To: <20250826160312.2070-4-kernel@mkarcher.dialup.fu-berlin.de>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Thu, 4 Sep 2025 20:36:46 +0200
X-Gm-Features: Ac12FXzDtfbl__3iQeAtex62Ju8AvB5m1NJ8r6OE2x8NOp9QAmpqN2PTq5haGRs
Message-ID: <CA+=Fv5To0A3N0fajWVhP1SfjD4uv1oaPNOpi9dnFVt9yHfaPQw@mail.gmail.com>
Subject: Re: [PATCH 3/4] sparc: fix accurate exception reporting in
 copy_{from_to}_user for Niagara
To: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, 
	Andreas Larsson <andreas@gaisler.com>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Anthony Yznaga <anthony.yznaga@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I've tested this patch from on my T2000, I've booted up the ISO

https://dl.t2sde.org/binary/2025/incoming/t2-25.9-sparc64-base-wayland-glib=
c-gcc-ultrasparc3.iso

And have been running some "regular stuff" like unpacking files and
building some packages
with gcc. It seems to work fine. The system has been running stable
with load for some hours now
install:/etc# uname -a
Linux t2 6.16.4-t2 #1 SMP Tue Sep  2 23:17:46 CEST 2025 sparc64 GNU/Linux
install:/etc# cat /proc/cpuinfo
cpu : UltraSparc T1 (Niagara)
fpu : UltraSparc T1 integrated FPU
pmu : niagara
prom : OBP 4.30.4.d 2011/07/06 14:29
type : sun4v
ncpus probed : 8
ncpus active : 8
D$ parity tl1 : 0
I$ parity tl1 : 0
cpucaps : flush,stbar,swap,muldiv,v9,blkinit,mul32,div32,v8plus,ASIBlkInit
Cpu0ClkTck : 000000003b9aca00
Cpu1ClkTck : 000000003b9aca00
Cpu2ClkTck : 000000003b9aca00
Cpu3ClkTck : 000000003b9aca00
Cpu4ClkTck : 000000003b9aca00
Cpu5ClkTck : 000000003b9aca00
Cpu6ClkTck : 000000003b9aca00
Cpu7ClkTck : 000000003b9aca00
MMU Type : Hypervisor (sun4v)
MMU PGSZs : 8K,64K,4MB,256MB
State:
CPU0: online
CPU1: online
CPU2: online
CPU3: online
CPU4: online
CPU5: online
CPU6: online
CPU7: online


tested-by: Magnus Lindholm <linmag7@gmail.com>


On Tue, Aug 26, 2025 at 6:05=E2=80=AFPM Michael Karcher
<kernel@mkarcher.dialup.fu-berlin.de> wrote:
>
> Fixes: 7ae3aaf53f16 ("sparc64: Convert NGcopy_{from,to}_user to accurate =
exception reporting.")
> Signed-off-by: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
> ---
>  arch/sparc/lib/NGmemcpy.S | 29 ++++++++++++++++++-----------
>  1 file changed, 18 insertions(+), 11 deletions(-)
>
> diff --git a/arch/sparc/lib/NGmemcpy.S b/arch/sparc/lib/NGmemcpy.S
> index ee51c1230689..bbd3ea0a6482 100644
> --- a/arch/sparc/lib/NGmemcpy.S
> +++ b/arch/sparc/lib/NGmemcpy.S
> @@ -79,8 +79,8 @@
>  #ifndef EX_RETVAL
>  #define EX_RETVAL(x)   x
>  __restore_asi:
> -       ret
>         wr      %g0, ASI_AIUS, %asi
> +       ret
>          restore
>  ENTRY(NG_ret_i2_plus_i4_plus_1)
>         ba,pt   %xcc, __restore_asi
> @@ -125,15 +125,16 @@ ENTRY(NG_ret_i2_plus_g1_minus_56)
>         ba,pt   %xcc, __restore_asi
>          add    %i2, %g1, %i0
>  ENDPROC(NG_ret_i2_plus_g1_minus_56)
> -ENTRY(NG_ret_i2_plus_i4)
> +ENTRY(NG_ret_i2_plus_i4_plus_16)
> +        add     %i4, 16, %i4
>         ba,pt   %xcc, __restore_asi
>          add    %i2, %i4, %i0
> -ENDPROC(NG_ret_i2_plus_i4)
> -ENTRY(NG_ret_i2_plus_i4_minus_8)
> -       sub     %i4, 8, %i4
> +ENDPROC(NG_ret_i2_plus_i4_plus_16)
> +ENTRY(NG_ret_i2_plus_i4_plus_8)
> +       add     %i4, 8, %i4
>         ba,pt   %xcc, __restore_asi
>          add    %i2, %i4, %i0
> -ENDPROC(NG_ret_i2_plus_i4_minus_8)
> +ENDPROC(NG_ret_i2_plus_i4_plus_8)
>  ENTRY(NG_ret_i2_plus_8)
>         ba,pt   %xcc, __restore_asi
>          add    %i2, 8, %i0
> @@ -160,6 +161,12 @@ ENTRY(NG_ret_i2_and_7_plus_i4)
>         ba,pt   %xcc, __restore_asi
>          add    %i2, %i4, %i0
>  ENDPROC(NG_ret_i2_and_7_plus_i4)
> +ENTRY(NG_ret_i2_and_7_plus_i4_plus_8)
> +       and     %i2, 7, %i2
> +       add     %i4, 8, %i4
> +       ba,pt   %xcc, __restore_asi
> +        add    %i2, %i4, %i0
> +ENDPROC(NG_ret_i2_and_7_plus_i4)
>  #endif
>
>         .align          64
> @@ -405,13 +412,13 @@ FUNC_NAME:        /* %i0=3Ddst, %i1=3Dsrc, %i2=3Dle=
n */
>         andn            %i2, 0xf, %i4
>         and             %i2, 0xf, %i2
>  1:     subcc           %i4, 0x10, %i4
> -       EX_LD(LOAD(ldx, %i1, %o4), NG_ret_i2_plus_i4)
> +       EX_LD(LOAD(ldx, %i1, %o4), NG_ret_i2_plus_i4_plus_16)
>         add             %i1, 0x08, %i1
> -       EX_LD(LOAD(ldx, %i1, %g1), NG_ret_i2_plus_i4)
> +       EX_LD(LOAD(ldx, %i1, %g1), NG_ret_i2_plus_i4_plus_16)
>         sub             %i1, 0x08, %i1
> -       EX_ST(STORE(stx, %o4, %i1 + %i3), NG_ret_i2_plus_i4)
> +       EX_ST(STORE(stx, %o4, %i1 + %i3), NG_ret_i2_plus_i4_plus_16)
>         add             %i1, 0x8, %i1
> -       EX_ST(STORE(stx, %g1, %i1 + %i3), NG_ret_i2_plus_i4_minus_8)
> +       EX_ST(STORE(stx, %g1, %i1 + %i3), NG_ret_i2_plus_i4_plus_8)
>         bgu,pt          %XCC, 1b
>          add            %i1, 0x8, %i1
>  73:    andcc           %i2, 0x8, %g0
> @@ -468,7 +475,7 @@ FUNC_NAME:  /* %i0=3Ddst, %i1=3Dsrc, %i2=3Dlen */
>         subcc           %i4, 0x8, %i4
>         srlx            %g3, %i3, %i5
>         or              %i5, %g2, %i5
> -       EX_ST(STORE(stx, %i5, %o0), NG_ret_i2_and_7_plus_i4)
> +       EX_ST(STORE(stx, %i5, %o0), NG_ret_i2_and_7_plus_i4_plus_8)
>         add             %o0, 0x8, %o0
>         bgu,pt          %icc, 1b
>          sllx           %g3, %g1, %g2
> --
> 2.50.1
>
>

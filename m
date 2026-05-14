Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D7823D28C
	for <sparclinux@vger.kernel.org>; Thu, 14 May 2026 05:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778736899; cv=pass; b=INzreAgdGykw0mGN9eVA9HMKOX1JkUmEsbsAdXKNlGpcMGNvHMABlEkA8VNRlA2GxgiUSIi1FSL7Il7hF+l1c2vLCf9nva+I9se/iAYMbAVwOjqPnJix+jLofnSZm1fMexw6hL9ZWg1SLHt1olNnQrLG12cmz4ftYtGxK6wBWWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778736899; c=relaxed/simple;
	bh=LI2uQiX1c/C+6kF1oi0rst1iJDuzd442XbGt5etALnU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N22YJ7R+AcxWpEqG62UpDHU6t6Vjk6yOeVaT50bfFmny/R63ND499abwoDYC4Vw/w/j9maMmnTtN97RRA6nCQPf0ftSGHWZeSVtiSwyvx8e9/Er/iqDD8PUO1IGvevTb6zQZ75L/mBdiJAouXYbqAXVc88zpW1yt8N1S8dfrWG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XaJ05QPG; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XaJ05QPG"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-67c4aaf76ecso1293260a12.3
        for <sparclinux@vger.kernel.org>; Wed, 13 May 2026 22:34:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778736896; cv=none;
        d=google.com; s=arc-20240605;
        b=Dqe/q+aGoqPLiKN7dY4d3Q6LwaPI3G1Lxejt7CknK7J7tvPIIC/3xnLCftR4zgLPEc
         f2bSMa72ki5Aj0XNfeQjOm1m1Jur61GHwf5wGqYKkc09+/vrK8ZlAPYGOyqr+JXFePxF
         mA2kiLGCEuMd+tROzIfOfGTQ7vHvGQUQuHiCwhMsWoJ63rLsUyTleeY0qySjL3AGoHSb
         WovNoDPZadlfm2rkBtoi4X9Qi7bydwIdHIOFx7OWhlu4Sq7AOq+gGv4cNj2ZxEX6f2W8
         We8I+aQeQvyxItMWOyYrb0c7E/UDAYICH8b/WD5qmG6paGorjTdgViFj2xpR0IKFBULS
         Jb1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xtenubrnHd/7okEMU9AwV4hJhC5AhgRcEvRa83caoZo=;
        fh=5X2ZAkmyw9UFoQASaVYMJLAC09NZO/t/FX4fs+JC9IU=;
        b=aSK4m+wTIp52OoEhqjKijbtviijBt1GmgnBW4kS4bW90fXgI8vYntkxXDBuKDwWhTm
         K6IQt3tbZlW+toC1x3jmnmPfm3qFljfQQDs8IjsB6wYFKA82U7C5HvJQJrKOpfwl2sCh
         aMC7qMzJ/I2KJGYSw4jOO4uzNX86xm0wQARKducy13wctS618M89lsSip9uSoRBdB7/0
         KUHvwSdjWCdgh4O+0bsFm6I+zAKT73Kdqr6adZfeNtZSuoK7DBghYqEqPFbvC9407fyj
         wXwwbdLHZN+3GZELgjs2d4bLNClkWJHEpxVgYn2ZNtnQ3TY4JLz8i73IzZ45znpk1v/g
         b7uA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778736896; x=1779341696; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xtenubrnHd/7okEMU9AwV4hJhC5AhgRcEvRa83caoZo=;
        b=XaJ05QPG9s1UeZmGaUX8B02xTXkKYscN3yKaXqjuX3w/1GI/un7uC9BIVGBSJ0LKXh
         R+ZnIa7QwMXwmEQzlSx2EKjhNvQ7LQ8GF8E0JH1wra7IBsu3bHLyWahdjJmjqDgWaANk
         xMYHycWJ3IvdB4FOO4rmaBHa20qCUXrmtSqbTaAeltExhO/4vrf+ci5R8sMRBvLCLv7u
         L4pYMj5GP/7XBTPScAJ8LkIc4PyubnePggjOGjAMQ5FVdI6/gxvSaR7MKTGHrgVvlpRv
         rLZgDoWq4U3UwgWb4Vz2+Du+ebATmyzilwR6HbYjApeG8NWh6LdgaJINkzKg6tBtlr2W
         wJBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778736896; x=1779341696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xtenubrnHd/7okEMU9AwV4hJhC5AhgRcEvRa83caoZo=;
        b=sLtO/9FLaxosiqB0pzR2X6q2agdj/Kmpp8BZPV6WCt2d41fzec85hkgrz/yKa5RieC
         Fwhr0a2B2ds9IZsjhzB5JuhJWDozwS+opM6HPFWen3CV1ERjfHvvjqz98HH9lmooQT4o
         Nn/lGmpWtmbIzrm0qsA6c4UR8PwbG5HRfHeCnrV8CMp/xA6dpsuadzsA7M1JIlWa4MRi
         GJDip+IHS6OMpVDeco1qlxbrdQO1os+ds5fJgLyJH/326ZvWgwO1Tr96iP/nv3LDIdJw
         OBP1VbDGlGTpFX8b+bAjLaLqx+M7uTZR5Lfp7aQhXQQfRt00fpqD4PB4/OoXtxKZgZd5
         2W0g==
X-Gm-Message-State: AOJu0Yzk47eOJzJGhdB2s30tFnUc4z8ErdvFvf2+V5+z8IgfWE01ddFp
	AE3eH7gigkGF8z93Od2FQR2EHZzG+iDPyzgAMrhwbc2TscuoUZRhnSdkVnpkSlklszUuJuTZJsT
	4AJh62DeEqKVWJQbFmyGwlRoExiR1nNjJFg==
X-Gm-Gg: Acq92OHWNBY3HMz0nToQYJhh9zzBQdGAvSVognmMnUmV7Oo7CnVAY4hq/xzk4kOidy1
	msXSalsdBzc1Mdc9AagW8gwZJ6NhrbgxVHOUd285SIjJsZR46qUp4M0AKQ5pC4j3fdds8MD+1fI
	k0EVk+cFm5oC26sDY9OaGV6g6wCmXGNV8gE4IU3cmDo9Tgcfoa//z6iNJIlZtpi1P2qvz1IeAiC
	LVidROMb1IwcsJjCsWUPr7qzOxcsAdCLk7PMQ3qIhc7oEJcLjhOfF6Mxpln1tTvCP3SxvM7HZhG
	qK95ZGcB0NuW1HQeLdew0L6k+V2yzqHIZwzMYs4c9SfWuog7Kq9IZ1n+06M5UlAV9iQpnZwPPGR
	8uH2zb+BlSk2fmCT3d0W5myZNVtswWzcN+MuMcql1FEVmIUHLv3E6DmeXHw==
X-Received: by 2002:a05:6402:3251:b0:670:8d21:dab with SMTP id
 4fb4d7f45d1cf-682a780a6eemr2482315a12.24.1778736895824; Wed, 13 May 2026
 22:34:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514041908.874355-1-rosenp@gmail.com> <f8a58a8d567149f514f2f5f47af25905f254f72f.camel@physik.fu-berlin.de>
In-Reply-To: <f8a58a8d567149f514f2f5f47af25905f254f72f.camel@physik.fu-berlin.de>
From: Rosen Penev <rosenp@gmail.com>
Date: Wed, 13 May 2026 22:34:44 -0700
X-Gm-Features: AVHnY4JKGFtMc7HLQqgstk12QDdcDoNuca3jknYjanpMtySQzdVFdmm86cn8OXc
Message-ID: <CAKxU2N_p7unDCif826jpTUtzs8=-ZoKw4u-Eg1UEM+4o+5Fbzg@mail.gmail.com>
Subject: Re: [PATCH] sparc: Avoid unsupported LLD branch relocations
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: sparclinux@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Christian Brauner <brauner@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:CLANG/LLVM BUILD SUPPORT:Keyword:\\b(?i:clang|llvm)\\b" <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 10:03=E2=80=AFPM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
>
> Hi Rosen,
>
> On Wed, 2026-05-13 at 21:19 -0700, Rosen Penev wrote:
> > LLD does not support several SPARC branch relocation types, including
> > R_SPARC_WDISP16, R_SPARC_WDISP19, and R_SPARC_WDISP22. A sparc64
> > allmodconfig LLVM build can therefore fail when trap table code and
> > low-level assembly leave branches to global symbols for the linker.
> >
> > Use local labels for branches that stay within the same assembled
> > object so the assembler can resolve them directly. Convert the
> > remaining cross-object branches and tail calls to absolute set/jmpl
> > sequences, which LLD handles through the usual HI22/LO10 relocations.
> >
> > Disable the unused sparc32 syscall trace entry points when compat
> > support is not built, and request sys_llseek for the native syscall
> > table so the LLD allmodconfig build remains self-contained.
>
> I would rather fix LLD than making such intrusive changes to the SPARC
> code in the kernel. In particular, since this touches the CPU-optimized
> memory routines which had been haunted by subtle bugs for years and were
> only fixed recently.
>
> Is improving LLD in this case not possible?
Above my paygrade. I use this so that allmodconfig succeeds.
>
> Adrian
>
> --
>  .''`.  John Paul Adrian Glaubitz
> : :' :  Debian Developer
> `. `'   Physicist
>   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7B52EDD41
	for <sparclinux@vger.kernel.org>; Mon, 19 Jan 2026 17:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768844856; cv=none; b=G6Iad9StG9F2E6cIUHDXMhuA9FGZca5KcgVHZE+agMSOjP2fj+vAe/DDw0tbzEZNfPeG/aAA9eQizA9vPiOVKqv+jP0fn02td8GhxznNVqzf6tLLDxEf5M0wbsO0M/ryx95Cma7/Wg8xsPSdgq6uVtYjttO0BKEovb8kAs3myIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768844856; c=relaxed/simple;
	bh=uFWIzT/NGXdCZyvcgR0/FUoFNBord156hv8OfVms58Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QPDdLTBYRhe290wV18gtT1NJ0wQubIgrNlErkFXTR6cuXmGOqZGkxSF+8i/YnZBzD8ld3nhC4DeNJFQQCz3Dn8Uan/2aJ7ZGEEqvy0i/MAFmtbcNpOhM8OivAcG1063PU/DwFh8PVFloW4BmVElEPkB7oed2eB5N5nLbIMWRHfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GMtYY/zm; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMtYY/zm"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-432d2c7a8b9so3975927f8f.2
        for <sparclinux@vger.kernel.org>; Mon, 19 Jan 2026 09:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768844853; x=1769449653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l2ACadv0hgsZtux+LBE5pG2d7aO4i+uY5axwwBu8vVQ=;
        b=GMtYY/zmJhPX5Xs7FJm3rgdUKdWIuhIklepJ1p4sddiSk/m48GgcuCFWYojivUWl0S
         ItcXWhV3LEwOv4TzwJv2L8CLKQ44AK3D7QBES/aeXyukZebzf2e+NZ46lwP+vS2RJDr5
         Fas+NRvNzp81+95dkDBYnUxXK/nnySKrAwae2kWZV4CNSP878KpANRKljUJLJ2uB15oC
         sAxiISTwz31imERKHeIZ9AEFL9R6RLEjaJRY0JjT2sDdN+s30Rb5I1AXTdLHzspGThuB
         tiCttjFFxbiQp8IPlnnIJDSDi/RKZC4j2b5/myFO+GiYQyFzJrxUbAtTdQo9bs/p5O/b
         sM7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768844853; x=1769449653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l2ACadv0hgsZtux+LBE5pG2d7aO4i+uY5axwwBu8vVQ=;
        b=oL5s+S7OtHq1mgwH0QCduLytV5+/zUxB+8EqulQpylnL6lk90RSz/5Ab88TLiYIf+z
         VQwrgEd6TrvRdR/l56d4C+8DAq66iMJCuUEhQ/arm+WQJJP1IFBlo4JZ9xDXC7cWyKwe
         mx7mzfqvmB8a/KoxAO5geokIZfQ8Anxn2wh2J/v5I+GT0Jsl2Fc7mXcj1I059kWnFiqz
         4Sj6YaWLDcZGBfekshxrWeJ6pTPf/5lYYyqexZIax18g8xr9AvK2C2BXcn0+eFO62KvL
         jI2zhcGtSLtXJPexbI1GdCNA1eTiR3cpnXjjWr+MxJ8lq9jOkrx0hQEOsClyK7dIQQrk
         +CeA==
X-Forwarded-Encrypted: i=1; AJvYcCVeGcldemvxiO/OdmXGdbC5L2sJAjwhbcy6yVzL9dfz/gF3M2V+gu/M70UZoltlFI8j/lEfF7+e7npW@vger.kernel.org
X-Gm-Message-State: AOJu0YzY+pelR1tEEtv9GOZFbnppyZ6PgxtFQ+fDFF1c1aAK9kRlRMwf
	OL7pi+Fp7usJ0V/78MtsuydW2AFX8z+S9KdJN+1U8G2rLoc7VQLPo8ry
X-Gm-Gg: AZuq6aInHgHfbUDpQO5bqcpn0gtX7a1kEGRGOlV+vtYHS843rhZSZQ6cl8SRd7tFFWm
	4PpQDgAYFIHCrvpHO4u+X1b87PMQkhApJM04c0r4OS5svxAIZkUXgxL6lpg73GgQuy/nO95Kgwq
	tqpNOkHZEKwKg17zbVfcrA9yqWI1/7of4fKP5r8Eupn7n4CHDfyfOVJBlmfgxBc6fZ9rGV4RriP
	joxnbKS8HValgBN7MZ4sbp2LgTqdMynQkLzMX8XASSq5SgSoWtuMNGpkcsXrQyVOJ7HJfwcLnQm
	oWO8Irk3b2RHbfGMM8KYhNfYs4J6XzNvOsGgCoy87LkPY5LiW1glsJ/94l4peZQtE5KADV+sZne
	VTez2qQnmgucpaFN/tUn7ZMFvxAvV59uvozTRfUVheTS51e6yTNywiq0oYiNo0gsr6g1tVP0zyx
	H8r0PEe8MQWRDGtew1Arb5VnjwwUbYeUzKC8jpc7J8ID3DPGALkSjI
X-Received: by 2002:a5d:588e:0:b0:431:9b2:61b0 with SMTP id ffacd0b85a97d-4356a03dd73mr15899699f8f.25.1768844852626;
        Mon, 19 Jan 2026 09:47:32 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43569921dedsm24242699f8f.9.2026.01.19.09.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 09:47:32 -0800 (PST)
Date: Mon, 19 Jan 2026 17:47:30 +0000
From: David Laight <david.laight.linux@gmail.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?= <thomas.weissschuh@linutronix.de>,
 "David S . Miller" <davem@davemloft.net>, "Andreas Larsson"
 <andreas@gaisler.com>, "Andy Lutomirski" <luto@kernel.org>, "Thomas
 Gleixner" <tglx@kernel.org>, "Ingo Molnar" <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, "Dave Hansen" <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, "Heiko Carstens"
 <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger"
 <borntraeger@linux.ibm.com>, "Sven Schnelle" <svens@linux.ibm.com>,
 sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, Linux-Arch
 <linux-arch@vger.kernel.org>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 4/4] asm-generic/bitsperlong.h: Add sanity checks for
 __BITS_PER_LONG
Message-ID: <20260119174730.5a20169d@pumpkin>
In-Reply-To: <4e4b1b5b-5f7d-4604-b5ef-0d0726263843@app.fastmail.com>
References: <20260116-vdso-compat-checkflags-v1-0-4a83b4fbb0d3@linutronix.de>
	<20260116-vdso-compat-checkflags-v1-4-4a83b4fbb0d3@linutronix.de>
	<20260119100619.479bcff3@pumpkin>
	<20260119111037-4decf57f-2094-4fac-bcf4-03506791b197@linutronix.de>
	<20260119103758.3afb5927@pumpkin>
	<20260119114526-a15e7172-fc4c-40d0-a651-7c4a21acb1c8@linutronix.de>
	<72a2744a-debc-4d8f-b418-5d6a595c2578@app.fastmail.com>
	<20260119143735-ca5b7901-b501-4cb8-8e5d-10f4e2f8b650@linutronix.de>
	<4e4b1b5b-5f7d-4604-b5ef-0d0726263843@app.fastmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 19 Jan 2026 15:57:49 +0100
"Arnd Bergmann" <arnd@arndb.de> wrote:

> On Mon, Jan 19, 2026, at 14:41, Thomas Wei=C3=9Fschuh wrote:
> > On Mon, Jan 19, 2026 at 01:45:04PM +0100, Arnd Bergmann wrote: =20
> >> On Mon, Jan 19, 2026, at 11:56, Thomas Wei=C3=9Fschuh wrote: =20
> >> > On Mon, Jan 19, 2026 at 10:37:58AM +0000, David Laight wrote: =20
> >> >>=20
> >> >> Don't you need a check that it isn't wrong on a user system?
> >> >> Which is what I thought it was doing. =20
> >> >
> >> > Not really. The overrides defined by arch/*/include/uapi/asm/bitsper=
long.h are
> >> > being tested here. If they work in the kernel build I assume they al=
so work
> >> > in userspace. =20
> >>=20
> >> I think You could just move check into include/asm-generic/bitsperlong=
.h
> >> to make this more obvious with the #ifdef __KERNEL__, and remove the
> >> disabled check from my original version there. =20
> >
> > Ok. I'd like to keep your existing test though, as it tests something d=
ifferent
> > and it would be nice to have that too at some point. =20
>=20
> Sure, that works too. I wonder if one of the recent vdso cleanups
> also happened to address the problem with the incorrect BITS_PER_LONG
> being visible in the vdso code. Maybe we can already turn that on again.

There is vdso/bits.h, but everything actually includes linux/bits.h first.

I was wondering what happens if you are actually using the 'uapi' headers
to build programs (may nolibc ones).
On x86-64, 'gcc foo.c' might work, but 'gcc -m32 foo.c' will find exactly
the same headers and go badly wrong unless everything is based on
compiler defines.

An assert (of some kind) that checks the pre-processor BITS_PER_LONG
constant actually matches sizof (long) seems reasonable for all build.
The alternative is to (somehow) manage to avoid needing a pre-processor
constant at all, moving everything to 'integer constant expressions'
instead (good luck with that...).

I'm most of the way through a 'de-bloat' patchset for bits.h.
I'm sure there is a good reason why GENMASK(hi, lo) isn't defined
as '((type)2 << hi) - ((type)1 << lo)'.
Since that definition doesn't need the bit-width in any form.
(Just beat up any static checker that objects to '2 << hi' being zero.)
I've only made that change for ASM files - IIRC the assembler only
supports one size of signed integer.

	David


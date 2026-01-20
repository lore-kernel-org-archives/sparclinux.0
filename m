Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9966421A15
	for <sparclinux@vger.kernel.org>; Tue, 20 Jan 2026 11:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768908825; cv=none; b=U8te4/2titZUhLEBVUQntnXfink/jHtgfw8sqoOGD7JQKBx4hIXxK4krKv7ZxhqeuEejUQ5F6WJN2Sxv4ZwdFT1CXWXK0T8PaRgJmqqj+LxTjo6N9DyrJrA2j9PdNSTqEKOP6YiEWrLDH3FQ0IrHmyDRSkP54ZtDINe9mtWJjPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768908825; c=relaxed/simple;
	bh=rOd9yTpdEpOmqr8gV3Zvtz93VcNjmSVSiEIE/dTz7Yg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AVqWbsVWw0BSuthvm4CCGt6wpXWBo9W41Z+oQOewV7MoTh/F1PPN/C3Wsq2+v+kiYLZuK3heVzrCGznuqDq+sqhtLuat+iam6BfytlVR0tKMVD3o+Lcm/kbtYDmvD2k3J1OpwsnR1Ijc6gIu7c7Bn6VnW+eZQsFYFGNLPf8se94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S4ikCjUf; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4ikCjUf"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b871cfb49e6so841088566b.1
        for <sparclinux@vger.kernel.org>; Tue, 20 Jan 2026 03:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768908822; x=1769513622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pGTA45Ofysyie+s0KKre7pJ1MVbPnUxT25h6KktO9Bs=;
        b=S4ikCjUfHXmAShi89svU3ooLSsryCjMiaXWmt44IovpJl7bN1cLMm/I1HVwDsqsyOK
         3AG3ugff9N5FHtT97gxVEBMoYQhpwiZ2w8CMVAZT1l6M8waM+GSx6aoEz/lWMvheKjKZ
         pdmlEoC5+mZnBJ93lYlNCmXcqsBHzWK/ozg7wHcCh1nRUnMUhkS8eg53PKqrSdWNr2iH
         KfXhy83ZbpXPYUOwiN8luu04efuHdBs/nERtiHg0McVC+fiPv2T6cUFkki51LYsCjRDV
         Gt6I+kVOlWTgI8rPJ1XUPRlqqlE2klzOW9v1T6FLB+JMCQNPNPHA8cAVDcaNA3xwiW/p
         tD7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768908822; x=1769513622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pGTA45Ofysyie+s0KKre7pJ1MVbPnUxT25h6KktO9Bs=;
        b=dATrl9Z1dqfL90XsKHmNvXwlUgmyfNKQy5EQSO0qAmSBYZHI3ndKJAzxO9EuogADt0
         5mSUlPbWB+TVfRoAmKWTD4YBkX3vN93UbjmisVpw8cS5j32dwuQWpLuwvAixXtoIs9j+
         KK8lW5a3DcD6+yz/Ut0YNffua3depM6x2Rgb3t1YAiR+yzuNvwTAv2Jxn2JMov42Q47D
         pPZOvlzG8WnCe2nFxO5dZxptSr286ECVa5QLk5yNqBqFoRqIF4aaKMqVzwhpcVTDJFYG
         cHfrTAV/dY+9z4THYIGYo8wgKqPhFO5Qipw2JvT1Iy/Wngwcn5tEoBUIMvZE4WDJPT8y
         0cQA==
X-Forwarded-Encrypted: i=1; AJvYcCVFAjTkkbv1C2wokEo06iDKM80Ys21SqCtXMegdjnRKHAUU+h+hezoNVVwJLpWlyfib88z/Vk+a6RK0@vger.kernel.org
X-Gm-Message-State: AOJu0YwaNpp60jkeS9mGEi9lO7N49WwD+rrBp8UYPXanHmzpTvr06ggO
	cFm5l31HEXiAvWfJL2jF1tHG3kaRe7YIpe4V9kufMBuFCsh90l/sBV9C0wpNAQ==
X-Gm-Gg: AY/fxX45U7u6TF82Vk8EIMuKF2gkFeCiinUPE4iyMShlnbNtm9M4tzQ9SzWD+pva5hg
	iavd593inUSzD/5yjn2w0y0d8kullm4VKQaCjve7NNNzePb0Q25HvFH/4mSRI3qFG24olzCclqf
	Q3zz6UNcy/FHWy00jnAyAWHi/FX78+xIiQ80iN+OHrPvgeC+yCziQwq5nCXVXMT2NngadmAN4Nx
	XPn+QHEUyiRm9OY6xdZVHHKfL2NA4sfHknoT9IWxB3P7VQC7PgDwO6X/4cCT19iguhdMf1EArEd
	Dbids46CIOlkYZE2hAs3bdmscKL3p+CvWlszcE5UgHlUb/6NzaB79Yz+c/SBYThTP8AcpP3U44u
	rsDvjmKXm2GJqDOA+YL4e2WP3vWuYY3CLQzS1utQ1rbuiZzr96lkqqoE59CkGzJYO+caNC4SFmr
	65xZwwdNtPUpdUh7yKCRhXEu9opVx7LJiLjc7ZCyxvBaLtSHdw3nSW
X-Received: by 2002:a05:6000:4202:b0:432:a9fb:68f8 with SMTP id ffacd0b85a97d-4356a02643dmr16216419f8f.1.1768903412929;
        Tue, 20 Jan 2026 02:03:32 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43569997f41sm27420500f8f.38.2026.01.20.02.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 02:03:32 -0800 (PST)
Date: Tue, 20 Jan 2026 10:03:31 +0000
From: David Laight <david.laight.linux@gmail.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?=
 <thomas.weissschuh@linutronix.de>, "David S . Miller"
 <davem@davemloft.net>, "Andreas Larsson" <andreas@gaisler.com>, "Andy
 Lutomirski" <luto@kernel.org>, "Thomas Gleixner" <tglx@kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>, "Dave Hansen"
 <dave.hansen@linux.intel.com>, x86@kernel.org, "Heiko Carstens"
 <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger"
 <borntraeger@linux.ibm.com>, "Sven Schnelle" <svens@linux.ibm.com>,
 sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, Linux-Arch
 <linux-arch@vger.kernel.org>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 4/4] asm-generic/bitsperlong.h: Add sanity checks for
 __BITS_PER_LONG
Message-ID: <20260120100331.1f57aa99@pumpkin>
In-Reply-To: <7b10344c-bb71-44fb-a391-32f7784db0e6@app.fastmail.com>
References: <20260116-vdso-compat-checkflags-v1-0-4a83b4fbb0d3@linutronix.de>
	<20260116-vdso-compat-checkflags-v1-4-4a83b4fbb0d3@linutronix.de>
	<1a77fda4-3cf6-4c19-aa36-b5f0e305b313@zytor.com>
	<20260119163559-b20b14d7-56ca-4f17-8800-83f618d778b8@linutronix.de>
	<f3bd8bfd-d66c-45fe-a634-9ac418806f40@zytor.com>
	<7b10344c-bb71-44fb-a391-32f7784db0e6@app.fastmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 19 Jan 2026 22:39:53 +0100
"Arnd Bergmann" <arnd@arndb.de> wrote:

> On Mon, Jan 19, 2026, at 22:12, H. Peter Anvin wrote:
> > On 2026-01-19 07:39, Thomas Wei=C3=9Fschuh wrote: =20
> >>>
> >>> Do we actually support any compilers which *don't* define __SIZEOF_LO=
NG__? =20
> >>=20
> >> When building the kernel not. I used this pattern because it is used
> >> further up in the file. There it makes sense as it is actually a users=
pace
> >> header which needs to support all kinds of compilers.
> >> But this new check is gated behind __KERNEL__ anyways...
> >> For the next revision I will move it into the regular kernel-internal
> >> bitsperlong.h. That will be less confusing and still handle the vDSO b=
uild,
> >> due to the way our header hierarchy works.
> >>  =20
> >
> > The point is that we can simply do:
> >
> > #define __BITS_PER_LONG (__SIZEOF_LONG__ << 3)
> >
> > ... and it will always be consistent. =20
>=20
> We have discussed this before, but decided it was too early to
> assume that userspace compilers are recent enough for that.
> According to godbolt.org, gcc-4.1 lacks __SIZEOF_LONG__ while
> gcc-4.4 has it, as do all versions of clang. Not sure what other
> compilers one may encounter using Linux kernel headers.

For instance MSVC doesn't define __SIZEOF_LONG__ or __x86_64__.
Unlikely to be used, but...

So you can use __SIZEOF_LONG__ if it is defined, if not hunt for
something else (possible just fixed in the installed headers).
But in the latter case (at least) a compile-time check that the
value is correct makes sense.
And that can be done portably - probable with a negative array size.

	David

>=20
>      Arnd
>=20


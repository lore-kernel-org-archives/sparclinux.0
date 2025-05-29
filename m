Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58C5292915
	for <sparclinux@vger.kernel.org>; Thu, 29 May 2025 20:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748549696; cv=none; b=Qao6bW7Iu2YWTZ0mQRzagpHULujq0CKYxk98CMqoQRe7kJ8baxs+TehOePcJu0k0zfG3pmq4fiP1vy3u0Bqyo3pNT/oraT7WJmRjf2pbyH030bM9LkUJsd4Y3oOt6kFWd2hXHmz/tvOsW9r+i8Go09C108Xb0BFLd824tJOXAHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748549696; c=relaxed/simple;
	bh=pEGh+FyMPK3zT/zV3uCRaiREChKfcHdnfIXKiv+KGVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UHs+cA3OkarERiiaXSMXN8pYrLhAE38lMO6/d9yrAmr3gxtXTgZNnCoLeLBxOqQCDtDdKqOkgicwKNn4cY1jWKAoOmMXe4Sta9qEmYhdiv+rOk5KTdE4BvmY0seoX2I6WeG46g/GkWIIP+yH7VXptIBeRfL4OlysxA2670bvsDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BdPbfjkL; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BdPbfjkL"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ad5566ac13cso198575666b.1
        for <sparclinux@vger.kernel.org>; Thu, 29 May 2025 13:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1748549690; x=1749154490; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HVSRhT5MS1pvdu2dqLDEs9T4cWr5CB+FRQ66tAe+RVE=;
        b=BdPbfjkLjjkO1/oLlwT3lAWZPfHD13gdaYU3q6sVGjzcvPH9gqr0k0ksLcw60W53rM
         60gGnVpZc7PYhL41D23BcS+a/08BEXMYeDijNeXA1CiEBXc7RLACJZq0LyrXhNWMR3Yx
         WAlfO0WlPnwPxO+XWdYb7sperMTrYrkefisfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748549690; x=1749154490;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HVSRhT5MS1pvdu2dqLDEs9T4cWr5CB+FRQ66tAe+RVE=;
        b=U9wIxmNPZX+k2ix616amuwWmKQFj+gzLOsLIdWdn+zUiGU4zWM+zaihu4hCKQRFJ6K
         O5ouVs7KeNO2RKi9gcKpYxGrTOH7za54eZefMs42ejLk+ypMp+pWtt2EcLsDNM/e8efC
         oFgv8moZ3uVxObeiLfnIdH+kWhFnnCVcwetqovfWzn9TFmWmYgZtTssmKtsqzR3c6YiG
         LstSmzjtUvPFzIUpUGVPKxvn0qz24U0LlVWGkyVO3NnJvlLUDvPg7WxWHD3tw64459VW
         S5GP6v3dE56QwV8kdxv81WxqJG8QqdD7pChW5leZxqGXkFI/gGSVj6cuvznReqxfDYuF
         2CEw==
X-Forwarded-Encrypted: i=1; AJvYcCWgkrl8/QMwXfphUFh0OCNGud5F/pmt+PbfQVXC5sWhcqCiuXGeIdFOE2PVv5qiOxJvRKJfEX7zHWWW@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2KOB9YZ4ezFuj3tGnye/wZ4v7Sd62Im/ceIlGJSDpfG5ILuJU
	Hv+qjInEDseR0l3KiQP/zkPEpBNkRvXooGqLqmuU40LWmM/rE7PN21uY+2HW9/e3bdlVLPL9YxW
	uAiuWObA=
X-Gm-Gg: ASbGnctRYcmgbuHhvs+Pfi9oQa9AndRI5wBOiwhEtp8SG7p6k0CUcDM20K8yrCstHPm
	azLWj5B/OdhDaPgjln/JwdtJEzblnbe+PewFx9d2e/n6KyHFxhfKRfbfiP11irRe8+rMEmP5fIM
	jMxNhpDNyYNTvb1bq1qg1EccbkXwusYF7pBHa95LIPEIIlgrpT3FcQn4xz09k0CH1FiJAXaYo4D
	F47vbkZViqdDWvWowkL4TGygFEwLvHgjxLGOajdhsJ8y+9L15qhD1GGrag+jMMZYvwkRXfLdhoX
	ItlhRlMGAKnb//Dj0o6SBoiGGzjUqCyVcGmGh16hvGmmqRWzM0T602WMLMdln6ykhIUdBTzMx5E
	JRJ/EUdQ+MZZ+FBuXAWySnCoxEw==
X-Google-Smtp-Source: AGHT+IGeSKMz08nMFMxRf2J/DlBknw2QCbJmJRIp2fZ6pOctYaUqUPDhW/Yhcb4AjYRut+Drby4EzA==
X-Received: by 2002:a17:907:3d16:b0:ad8:9ff4:c047 with SMTP id a640c23a62f3a-adb3225d2f1mr72769066b.35.1748549689902;
        Thu, 29 May 2025 13:14:49 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada6ad6ac52sm198233166b.170.2025.05.29.13.14.48
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 May 2025 13:14:48 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-604bf67b515so2389641a12.0
        for <sparclinux@vger.kernel.org>; Thu, 29 May 2025 13:14:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVssQN4GbJ1V9nHzwwQ59CjFBrCCKFZ6SqTObmL/xMBxGoKpaZRZz75lQVkPGszIxCv7zcWeVw6ngMK@vger.kernel.org
X-Received: by 2002:a05:6402:2346:b0:602:1d01:2883 with SMTP id
 4fb4d7f45d1cf-6056db10b4emr581444a12.1.1748549687775; Thu, 29 May 2025
 13:14:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428170040.423825-1-ebiggers@kernel.org> <20250428170040.423825-9-ebiggers@kernel.org>
 <20250529110526.6d2959a9.alex.williamson@redhat.com> <20250529173702.GA3840196@google.com>
In-Reply-To: <20250529173702.GA3840196@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 29 May 2025 13:14:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=whCp-nMWyLxAot4e6yVMCGANTUCWErGfvmwqNkEfTQ=Sw@mail.gmail.com>
X-Gm-Features: AX0GCFuiJcryO_X7sE1ePk8yCEY5HNa9j_jPT14Gm93VGY22kOHLk2kIn44ZkWY
Message-ID: <CAHk-=whCp-nMWyLxAot4e6yVMCGANTUCWErGfvmwqNkEfTQ=Sw@mail.gmail.com>
Subject: Re: [PATCH v4 08/13] crypto: s390/sha256 - implement library instead
 of shash
To: Eric Biggers <ebiggers@kernel.org>
Cc: Alex Williamson <alex.williamson@redhat.com>, linux-crypto@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	sparclinux@vger.kernel.org, linux-s390@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 29 May 2025 at 10:37, Eric Biggers <ebiggers@kernel.org> wrote:
>
> Long-term, I'd like to find a clean way to consolidate the library code for each
> algorithm into a single module.

No, while I think the current situation isn't great, I think the "make
it one single module" is even worse.

For most architectures - including s390 - you end up being in the
situation that these kinds of hw accelerated crypto things depend on
some CPU capability, and aren't necessarily statically always
available.

So these things end up having stupid extra overhead due to having some
conditional.

That extra overhead is then in turn minimized with tricks like static
branches, but that's all just just piling more ugly hacks on top
because it picked a bad choice to begin with.

So what's the *right* thing to do?

The right thing to do is to just link the right routine in the first
place, and *not* have static branch hackery at all. Because you didn't
need it.

And we already do runtime linking at module loading time. So if it's a
module, if the hardware acceleration doesn't exist, the module load
should just fail, and the loader should go on to load the next option.

Not any silly "one module to rule them all" hackery that only results
in worse code. Just a simple "if this module loads successfully,
you'll link the optimal hw acceleration".

Now, the problem with this all is the *non*modular case.

For modules, we already have the optimal solution in the form of
init-module error handling and runtime linking.

So I think the module case is "solved" (except the solution is not
what we actually do).

For the non-module case, the problem is that "I linked this
unconditionally, and now it turns out I run on hardware that doesn't
have the capability to run this".

And that's when you need to do things like static_call_update() to
basically do runtime re-linking of a static decision.

And currently we very much do this wrong. See how s390 and x86-64 (and
presumably others) basically have the *exact* same problems, but they
then mix static branches and static calls (in the case of x86-64) and
just have non-optimal code in general.

What I think the generic code should do (for the built-in case) is just have

        DEFINE_STATIC_CALL(sha256_blocks_fn, sha256_blocks_generic);

and do

        static_call(sha256_blocks_fn)(args..);

and then architecture code can do the static_call_update() to set
their optimal version.

And yeah, we'd presumably need multiple versions, since there's the
whole "is simd usable" thing. Although maybe that's going away?

                   Linus

Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C1B230BFF
	for <sparclinux@vger.kernel.org>; Thu, 29 May 2025 23:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748562897; cv=none; b=DQhzPltxZVWklVjCaVHO29h5qmIQe26iYCN6D/tKa2XWMnRQZuppPSgjPGIM/6kVOV1JHgqAFy4jIsVePdYbr4DDgTBJz/CgRooexlXrv6XoaLEidDc+NVjHdKPvhe2YaHzUXhqB3cSuupjIxdAMtFNwT8H3J/W9llVyS28nM9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748562897; c=relaxed/simple;
	bh=mQ2X3C83MrQ+ifFd0cXmKRdvIysb8KwRrZHJnS3dFHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=klOxVdle7GIRLGXn24G2QWTtfB5YRKU88st5ErBhMeLYwlZq9pUOv6LQNDukT2yIlBhe8ZnP5LKFBbUmgy2xl0Oa1UrtD41mklwgnDEJg3kOdKWylndv0rHXrUVgK6D1Oee7UxyeYbIhVkElEh3FEhEM7Xei6BtU5yNoa5osORk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=F6I+Plfv; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="F6I+Plfv"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ad8a8da2376so245849666b.3
        for <sparclinux@vger.kernel.org>; Thu, 29 May 2025 16:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1748562894; x=1749167694; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VCpgeKXbWpRtz3XeS2MBk7nO0oA3f7brSdzLdQTvzhc=;
        b=F6I+Plfvh1QbPuCTmn+Q/sPKw6zn0Ihak9o4GfylVNU9GwSJSbZsXBMOgrnWimPR/u
         oNEv9lH1uAn0McKTBYelp/UFFf1FQX9Mpr8h47/FIAk/eiqIlJbAYPlW4/zY4lZT1JvC
         ni8yMu0AB2cmpsDDu+PsSVJ8MXWSgIjl9fP6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748562894; x=1749167694;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VCpgeKXbWpRtz3XeS2MBk7nO0oA3f7brSdzLdQTvzhc=;
        b=PueRl9qYldVgXCwjMHTmvTEGdRkXW3CEzeFOaFwzb9v+FcKJ7uuyXrWZdl0ZAxyKLg
         0FNCZnE8AEcdGPMZLp8HmTBIzJEdCu0vL7ilQOc3Y74QF9pk+5nIxqpYp6hApJCrw9MB
         Y15UtVuevZFjjTEqWzGHV2zmGR6wi8O2B9jx5G48Ghn4JA7gtKPPsH9PVpaWs629obyu
         6T+ix5N0A0BydWNvOk2eoVC9E97ujJZNE7/TsUXpzuHnqqW8N6BweocbRW1OBYvSKxTI
         CiA947NJl6ic/rJkTJ2MrNChtZ1zsoiwWPq8ZTQqsZqgS3PdfQWUp3qT5gC1V+hVHwR8
         Q+3w==
X-Forwarded-Encrypted: i=1; AJvYcCW18Fyw8xyY6TPIaawlWqewCB25Xr1Bz6V46XCLgHXvs6/BIzBK/Tt+KVZIsY3Zl/SfCoOAbCb3xYTy@vger.kernel.org
X-Gm-Message-State: AOJu0YyElI1pvcfrCGYgmYQDBXX87XE2xv9iPh8r4k2aoSEU0suUd4Z7
	PUCJQfUL9uwkHHypcpcS3Sn+5LRfyta6PZKE0VaIg68mHfrdaZKF2gsYpLftbOziXd3Qc0UvyJq
	QTNs3HjE=
X-Gm-Gg: ASbGncv/JyC01IsZ8986YC6XUbx/4aLTKE2ScpPaSUkQuGEav43Gd0GhT6hCllC39FX
	+hfGodh6iq3YLR5Jp3rECtvy7MtsjYUJMlCrAbrO4D1wtd2Nw01U15QeCn56GdKJ4WdlKjUwdIb
	iWRW/4RAWMbFxW+sURF9T3eb3BjuMqKKKco67Xiu0wuiaT+H9bzBJiiLpVDNc1IC8LjLc1p9PEA
	rcQiAx+YFFYf4WIVs/qiFAi5TqDe/hJgvMGfFrcZQWnWr1PGoL1QTzmRbxua8+Z7aHv6orh0UNK
	0s19qRRkFk4SBDbEufbwetk3CxU4pQpl1qIBTX0FZp/fyQQ8/pVzBuTbYpo5nQhGbZ2EP9tvW9E
	JUOzMzyPcTD21eqyjIP5pnJVWZQ==
X-Google-Smtp-Source: AGHT+IHKAupyQvkjzmF1x39AdXYADxqu8uecTeRV1d2peiGs6xIwxyfOt8hN4iuIyhz4ZuU7Y76lAQ==
X-Received: by 2002:a17:907:9282:b0:ad8:959c:c55d with SMTP id a640c23a62f3a-adb322457f2mr112344866b.2.1748562893806;
        Thu, 29 May 2025 16:54:53 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5e878178sm225753466b.91.2025.05.29.16.54.51
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 May 2025 16:54:51 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6020ff8d54bso2443877a12.2
        for <sparclinux@vger.kernel.org>; Thu, 29 May 2025 16:54:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVP1frsELmb+TPtqA1BzUMYYKDVZisz88jRbbKy6ghRA1MPSwDVlBSwos/O71GkdviFtyUHsHIBPCGJ@vger.kernel.org
X-Received: by 2002:a05:6402:35c6:b0:5f8:357e:bb1 with SMTP id
 4fb4d7f45d1cf-6056e1597eamr926476a12.22.1748562890813; Thu, 29 May 2025
 16:54:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428170040.423825-1-ebiggers@kernel.org> <20250428170040.423825-9-ebiggers@kernel.org>
 <20250529110526.6d2959a9.alex.williamson@redhat.com> <20250529173702.GA3840196@google.com>
 <CAHk-=whCp-nMWyLxAot4e6yVMCGANTUCWErGfvmwqNkEfTQ=Sw@mail.gmail.com> <20250529211639.GD23614@sol>
In-Reply-To: <20250529211639.GD23614@sol>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 29 May 2025 16:54:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh+H-9649NHK5cayNKn0pmReH41rvG6hWee+oposb3EUg@mail.gmail.com>
X-Gm-Features: AX0GCFuuQZJkBnHy-mtAufGSUKbxBrKrMtOhVAT8ZxGCHwWeq3lbFPW0g13cPtE
Message-ID: <CAHk-=wh+H-9649NHK5cayNKn0pmReH41rvG6hWee+oposb3EUg@mail.gmail.com>
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

On Thu, 29 May 2025 at 14:16, Eric Biggers <ebiggers@kernel.org> wrote:
>
> So using crc32c() + ext4 + x86 as an example (but SHA-256 would be very
> similar), the current behavior is that ext4.ko depends on the crc32c_arch()
> symbol.

Yes, I think that's a good example.

I think it's an example of something that "works", but it certainly is
a bit hacky.

Wouldn't it be nicer if just plain "crc32c()" did the right thing,
instead of users having to do strange hacks just to get the optimized
version that they are looking for?

> Does any of the infrastructure to handle "this symbol is in multiple modules and
> they must be loaded in this particular order" actually exist, though?

Hmm. I was sure we already did that for other things, but looking
around, I'm not finding any cases.

Or rather, I _am_ finding cases where we export the same symbol from
different code, but all the ones I found were being careful to not be
active at the same time.

I really thought we had cases where depending on which module you
loaded you got different implementations, but it looks like it either
was some historical thing that no longer exists - or that I need to go
take my meds.

> IMO this sounds questionable compared to just using static keys and/or branches,
> which we'd need anyway to support the non-modular case.

I really wish the non-modular case used static calls, not static keys
like it does now.

In fact, that should work even for modular users.

Of course, not all architectures actually do the optimized thing, and
the generic fallback uses indirect calls through a function pointer,
but hey, if an architecture didn't bother with the rewriting code that
is fixable - if the architecture maintainer cares.

(On some architectures, indirect calls are not noticeably slower than
direct calls - because you have to load the address from some global
pointer area anyway - so not having the rewriting can be a "we don't
need it" thing)

               Linus

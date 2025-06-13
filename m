Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BEA2E11B5
	for <sparclinux@vger.kernel.org>; Fri, 13 Jun 2025 16:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749832581; cv=none; b=qsrTyvyJmjphe2aXrM53Y9taRCSXeqWogb6nGDHZ0mhbGe5iQCXL7B4C+InBuqpjNIuScDXHd/rCGML2xKQr8kA6WyBtEUmn91p6l2tqOQbtHHDgaA0LjduvLsnWEqYLHiVKHgTh0XmyB326lyLL3Resb7giA/0jr0vtmn5wq3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749832581; c=relaxed/simple;
	bh=6IDK3mFK3aUcD6DqmEoL/rBAW6jbXc5FxEXCTke0bD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sQIT1qw5lV6viHxNFEWChMvpskA3pZZJc2mjZwkj10AR3uvyBaK0MUSwAv7lF7nqq5cq2Uagw+mFzzln799YXVGfQ+E8hrtZsQuq+ckaY12LT52EKdE0Vc2xq+A9ljzyNIEn5X416jTAO9MJRs3sx1Yr65B29Qa38GAQ4e6ROWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PI5Rveho; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PI5Rveho"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-adf3b33f968so88231066b.0
        for <sparclinux@vger.kernel.org>; Fri, 13 Jun 2025 09:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1749832578; x=1750437378; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=76g08zX1QgiOXgDWQ+4Q63FmolLqjqLzmJdnqen2jZI=;
        b=PI5RvehogUMvTtnZ9NT+nSQkeUjvDQn3WINLD3naZhlnHdHoiwzfw4PB8oyeNV7oDE
         VrHfQJGMeqLG/pNd3WOoWMrlR6AladBALeW/89jAhhvNPpu5dfKbt2xlyQEemCm0h6s4
         FDkroMjWJCWEClLaDHi+R/BMqAC4Nlc/tEs3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749832578; x=1750437378;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=76g08zX1QgiOXgDWQ+4Q63FmolLqjqLzmJdnqen2jZI=;
        b=MPXD4hI/4pi8PXk1YmxJ1c1yPp4BxhsjGcSBf/oy7LG+oIyUYpkezZYuqFr41PXjvB
         nME8AdR79jZuIV3iqTarcM3Dtx9oY3nh3OWLDynDRmmuS/U/7ECJJr5E8SSuH1ZrfTsm
         FhwbERP7vYkDLBrJlLSDXplycO+zyM9a1PKFpB9zLTg/4FjECQX9vnWLQTIhRS0zYvQH
         aKxT9bCHMAOoswCqTlyr8tMyIBn21NWTPBDEkdrLYZLmm7aS40aaWkQh06fVqLWcGurT
         fPx3kYYdFrHzq4R21Wpt78/Bidzf5IhgGSGzdILM4FCMe+QdhOE6XVwukLgfHn5L21u2
         cbrg==
X-Forwarded-Encrypted: i=1; AJvYcCWG602FIRUt2gwdK31+eode5V3icbDSyAPs4vGHJfFIQ0VsemkQHX6TD5vKUTMVW036PrRsZ10mnza4@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy8xbIhL1QDjD0mwf0qLdUzAAua1HZmIBxe0KVkIkIU7KW4qT3
	Cn5HHX8GowyB81cM14ZgRvxYtWhROIm/QJXx4W0ZN84s3mDvTRav9+YqierFAPofFlhRqX0kjwd
	tq5Ba+ZQy7g==
X-Gm-Gg: ASbGncu7VQ8M9QgrrW1sveKjoOiuLQaBZNeTnsflyx/Swso+C36tBVVNcYbAE+RS6AQ
	gGEiO/VKDAMTRI9pn89cHGFcg7XchfK3vZtFOQBJdBo7eUm/0XuTrct0m6Hxfi/MIcKTtxlmyUd
	ufb7ithmlzPhohkSAYSqk6D+yThy8BMifV3ElBrF3v66Vpk12v05hSmsy8MwSyuezRSNZUtBU2U
	AvOJm7cqOstryEHCp8YrOHGlQw0IWJVgMLL5rXJb+3O08NKnSMn6O26tGDryGKDbD3LRj9RnUQ2
	7YX47jbzCfHC2I2P4Fq2T237w1Ocno3tl0HSj+0ART6qWcXoWJXyHvR1ko8NmhaM5Th8aD91hi0
	ifec6aKoMCrZZ75zTvg0Ijk35Nort18Da7K/w
X-Google-Smtp-Source: AGHT+IFpuA1AI7ktTukizO20HEtWJ+uFeCnPSRode1IKyyKobuelytXLxkYHo7JllC9YR1EwryUwqw==
X-Received: by 2002:a17:907:d8e:b0:ad8:9394:272a with SMTP id a640c23a62f3a-adf4c82c7e6mr167509066b.12.1749832577784;
        Fri, 13 Jun 2025 09:36:17 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec8156ed7sm153650666b.37.2025.06.13.09.36.16
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jun 2025 09:36:16 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-60780d74bbaso3986529a12.0
        for <sparclinux@vger.kernel.org>; Fri, 13 Jun 2025 09:36:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWZ5NTVkP59b7DjeoRxgD2Ju72Lf5oks2b3afl0HwSDi773MQobXpiN4UsriBjBFPo/p6z+g3QSQcfA@vger.kernel.org
X-Received: by 2002:a05:6402:35cd:b0:602:427c:452b with SMTP id
 4fb4d7f45d1cf-608ce49d897mr365341a12.3.1749832576184; Fri, 13 Jun 2025
 09:36:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611020923.1482701-8-ebiggers@kernel.org> <aEjo6YZn59m5FnZ_@gondor.apana.org.au>
 <20250611033957.GA1484147@sol> <aEj8J3ZIYEFp_XT4@gondor.apana.org.au>
 <20250611035842.GB1484147@sol> <20250613053624.GA163131@sol>
 <aEu5cyDOMcKteW_b@gondor.apana.org.au> <20250613055439.GB163131@sol>
 <CAMj1kXEDCRfCgvtuhRc+a=m1kVt-zkcCqi_=_WOFTmt4Hz2gGg@mail.gmail.com> <aEvjrhkLnB_GEKnV@gondor.apana.org.au>
In-Reply-To: <aEvjrhkLnB_GEKnV@gondor.apana.org.au>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 13 Jun 2025 09:35:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiewoOfhK=NVQT2uf+29Kngv9F9J6ObJRFUKi6n-=B06g@mail.gmail.com>
X-Gm-Features: AX0GCFu7lGsyyFJqLRh6z7a562txhJJOyTpVqIIzlie72BRGPF0wH2A3ccvLGV0
Message-ID: <CAHk-=wiewoOfhK=NVQT2uf+29Kngv9F9J6ObJRFUKi6n-=B06g@mail.gmail.com>
Subject: Re: [PATCH 07/16] crypto: sha512 - replace sha512_generic with
 wrapper around SHA-512 library
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Ard Biesheuvel <ardb@kernel.org>, Eric Biggers <ebiggers@kernel.org>, linux-crypto@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org, 
	Jason@zx2c4.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Jun 2025 at 01:39, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> First of all the export format is being made consistent so that
> any hardware hash can switch over to a software fallback after
> it has started, e.g., in the event of a memory allocation failure.

Can we please instead aim to *simplify* the crypto thing?

Just say that hw accelerators that have this kind of issue shouldn't
be used. At all. And certainly not be catered to by generic code.

The whole hw acceleration is very dubious to begin with unless it's
directly tied to the source (or destination) of the data in the first
place, so that there isn't extra data movement.

And if there are any software fallbacks, that "dubious to begin with"
pretty much becomes "entirely pointless".

If the point is that there are existing stupid hw drivers that already
do that fallback internally, then please just *keep* that kind of
idiocy and workarounds in the drivers.

It's actually *better* to have a broken garbage hardware driver - that
you can easily just disable on its own - than having a broken garbage
generic crypto layer that people just don't want to use at all because
it's such a ess.

This whole "make the mess that is the crypto layer EVEN MORE OF A
MESS" model of development is completely broken in my opinion.

There's a reason people prefer to have just the sw library without any
of the indirection or complexity of the crypto layer.

           Linus

Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219D137C915
	for <sparclinux@vger.kernel.org>; Sun, 12 Apr 2026 13:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776000187; cv=pass; b=peDzCv91KPImT/Ib4gsbXoR3/M7bk7SkSmzsaXbbiFbyW/vBu4DLEjbvT34HwN6TVlLHizVR7gBv66JppOoD2nKamyk7zpndfOysU6Qk/r42ZvdoBzLtl7qoLZhXMaGN+4bbFsowqYm5FasKriZxOOO0uc88PaDNjLzs73csGSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776000187; c=relaxed/simple;
	bh=1p6x7PvyQL+5PGqdAnx23TY8v0cVXdqCOnUZdmPD2Po=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ng4tRDlopiGY1SIQhRNq8Jkv6BFMVVBNBzASKGygQFn8R8CGigqwaJ6q8OV/scKIoOReyrPtejx1XzeJ2cCw2cwpm5Xdzpm8ZodtxA6j97SpvxKAExfdXJ0vLx4yE8oE21TItu+yVX7+bOUjrjU6xVLwxRkY4XZjvswAkJNwfCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dccArJm9; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dccArJm9"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b9c3e2cf3c0so546931766b.1
        for <sparclinux@vger.kernel.org>; Sun, 12 Apr 2026 06:23:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776000183; cv=none;
        d=google.com; s=arc-20240605;
        b=BvLnInWFLvWXSJOrncTiMK5Pnvd5jfFqEltbFVRenqOEb7fZRefwEZoSra64MPWYqj
         7qIAOOPooVtBpJKj/sF0DJOHuKZeUtvVIYEuw+p0oxa3JRpkuA/Aj6NIDn2j/PuFP2VE
         7r9sV6kSDkoya0+L8UQn4nr/fuRMUIYw3KZB36fTmF2/XflSHIDkvq4utep8AxAtp//S
         8ukqd0IL8w0sgRVfuydLpYvxFwn0KAGO/q1g66j8tYj3YhdvH7EHyykwUwHilyP9Uxd2
         j48J4t7LrCLA0sCux78egB8ZSpXBYTcp8R1QwBrhRc3Liut5Jn4jiLq9tZFJtccx5PXc
         Hh6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gDdA9vu4Fz00bgurrj0mXlyC2hJ8rRfiuCUxuR8xwe8=;
        fh=30SjVQYjCKBO/8bRjkzNH1wKyoT3dGERRKNKqdPFy8M=;
        b=fwYJeM9CwZZA6P6DLnYWqZ5xfmnGxaX36KmoI56ViS9mALSDBW69LnNS6BkTt4PuyW
         qD3wfnHUO6KSqnHikBJB4SfOkLTo55M2YzlaNLydrjtA28TeHuZpxNhJ5M0RDaDTMH40
         egiF2Ce5/Cxb2YmHbZylFMHy6vhtB++ZVbUrJAluXOqdHcxVkRa1ZRBzE+5zn+9r5Yor
         1a3R6NnpwqnuQ8avUj4FA3Wi/xoqWzI7T3d3GLGY3kuzNvHF3rOfMXj8GgqKlEXvKkH4
         mZSD4IYwv0E2PyoZXIsk8457s1rrnec+PoDNK3+a3kOFwFVC7R8HjygIN/1wHiMWxzyw
         eWFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776000183; x=1776604983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gDdA9vu4Fz00bgurrj0mXlyC2hJ8rRfiuCUxuR8xwe8=;
        b=dccArJm9v6h9Fdk8lDGNWZnQG14AQ9ZokHDnv7DAL1GW0R6BDoMR0waR0wHnO++sNY
         YJPJSDf/Eo4Jqw4GQ8Gz/T/rsLkNap5uTZ+EpwANfeQ1dFGXyG88+fN/49+h4JvC9C7c
         2+asFn0yzVsL4n2hJqrH+GINWtCINsNrMCDz6yHqeLWKks0EsNy7ssNes4vhdFLCd+tg
         k2Ys2/EuxonOOeyCkSNs/L20e6zSdmHhXIY25hzHxXat+VjZowRiCo0VNk9bdjlPvxYt
         DV9owUMCQ8VWv/4Ldm8HtUCj9QQlhYJyZr8JnJBv87EbzYIfO7KpnQu2sRPezsHrfV9J
         1U2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776000183; x=1776604983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gDdA9vu4Fz00bgurrj0mXlyC2hJ8rRfiuCUxuR8xwe8=;
        b=S4/P9jLbfopMa9gyYXdGvwJnH/Ol6/Iob/OcoZx5yAdra7jOz6Ea3BX8Sj1avYwV4m
         mGgC6xEut/Y7ZVEG5MnvGj3zZ8acBhmLMhTZQgaU3Zc9mSoItcq6aWFaVh3v7yM44O81
         R4ZLc1Br4/dAO/uuCn7XxHdE4XIUMVMzepp7r7ABUDdlYTknARa+8SEcO7e41RkfsUgo
         D1NGdvtCpZfQCR/T1MDzYES81EWCDCiScsfgWpwsRqLWWdzglAnN/tkSTnV6CvQEMylj
         UmGj1mleFL5Ydntz6Clkb3ASLcSxaFyqONehfGuSnw8fSgQu9KgCfEp/bKkuil+BlMZi
         v3JA==
X-Forwarded-Encrypted: i=1; AJvYcCVSlk1lKDoY6T1iG7C7KCvvQxK++yoVIaikz49zhhyrJwpTxDZQd7uzwEDQ+HSDdW+BVcCgTYP0vtXA@vger.kernel.org
X-Gm-Message-State: AOJu0YzdHWbA+DqeYP9HWc0TmuHBiQ1uku1PQZi27qP9M2wyNIOsR1us
	78Ok8crhDs2MERxSqsRJyqphU1lNe0y3wpxNG7W0pNWkFd9W01LxvgDkzkRDyJumzm/USc3I9B0
	xH3ByJXdiKLRrvYVFPCowAu6SHi+8mPk=
X-Gm-Gg: AeBDieuV+tveCWckf18LyYDmSjE3Ttndl47OlX2Xzyg2353NYfOM+YCYPY+4liogI/o
	FynueaN8Jd6HXMBd254woI2bBZz389H16TndykVCmiNq/QyvCEp9zn/ONDNMJnjlk1Qk8xXS9/r
	EYOOfeya69ZHGgc96BzHz3umEn2jkyk/ZATADWC7aeFzlgg/grYuCUeniA2vHL+2TGgNagyktQ/
	4OY78VkcgXA/MKdTqXTv2jCkeryJz/1OIZCHbWsft/uo3mxQ30UWjZBeOQGPXZ+q2D81vptUbSS
	/uhljz17WnJV6Aui/iGkx10PUJBRZMuBBNGVeIGS
X-Received: by 2002:a17:907:e113:b0:b9c:6ef1:ed18 with SMTP id
 a640c23a62f3a-b9d727aa4fdmr352963766b.25.1776000183133; Sun, 12 Apr 2026
 06:23:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410120044.031381086@kernel.org> <20260410120319.131582521@kernel.org>
In-Reply-To: <20260410120319.131582521@kernel.org>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sun, 12 Apr 2026 15:22:51 +0200
X-Gm-Features: AQROBzAeMsaeSVePCJ__tEd4f2rWAY6MixXzp_fii2b8vyUpLt4xjSbtYzENFaw
Message-ID: <CA+=Fv5S68wZQapeaYTspOfsuGk=nBj60sx-ojHBSqrxV59Q+ZA@mail.gmail.com>
Subject: Re: [patch 23/38] alpha: Select ARCH_HAS_RANDOM_ENTROPY
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Richard Henderson <richard.henderson@linaro.org>, linux-alpha@vger.kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, Lu Baolu <baolu.lu@linux.intel.com>, 
	iommu@lists.linux.dev, Michael Grzeschik <m.grzeschik@pengutronix.de>, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	linux-crypto@vger.kernel.org, Vlastimil Babka <vbabka@kernel.org>, linux-mm@kvack.org, 
	David Woodhouse <dwmw2@infradead.org>, Bernie Thompson <bernie@plugable.com>, linux-fbdev@vger.kernel.org, 
	Theodore Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Thomas Sailer <t.sailer@alumni.ethz.ch>, 
	linux-hams@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Huacai Chen <chenhuacai@kernel.org>, 
	loongarch@lists.linux.dev, Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-m68k@lists.linux-m68k.org, Dinh Nguyen <dinguyen@kernel.org>, 
	Jonas Bonn <jonas@southpole.se>, linux-openrisc@vger.kernel.org, 
	Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, 
	Paul Walmsley <pjw@kernel.org>, linux-riscv@lists.infradead.org, 
	Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2026 at 2:36=E2=80=AFPM Thomas Gleixner <tglx@kernel.org> w=
rote:
>
> The only remaining usage of get_cycles() is to provide
> random_get_entropy().
>
> Switch alpha over to the new scheme of selecting ARCH_HAS_RANDOM_ENTROPY
> and providing random_get_entropy() in asm/random.h.
>
> Remove asm/timex.h as it has no functionality anymore.
>
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: linux-alpha@vger.kernel.org
> ---
>  arch/alpha/Kconfig              |    1 +
>  arch/alpha/include/asm/random.h |   14 ++++++++++++++
>  arch/alpha/include/asm/timex.h  |   26 --------------------------
>  3 files changed, 15 insertions(+), 26 deletions(-)

Hi,

The Alpha side looks fine to me.

I've applied this patch on top of v7.0-rc7, built a kernel successfully,
boot-tested it on an Alpha UP2000+ (SMP) without issues.

Acked-by: Magnus Lindholm <linmag7@gmail.com>
Tested-by: Magnus Lindholm <linmag7@gmail.com>

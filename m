Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B29219D080
	for <sparclinux@vger.kernel.org>; Thu, 31 Oct 2024 12:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730378551; cv=none; b=DWauEfVV+xm/klyKZSIIrLezYdjOPH2Mj1XJDhO5OQXFhbh66+ziHLjJ0uKHOfl5/oFORVpV2vYE3Qn4yHgjQiGN23e1K4h2gd7iKIxUlA5xS0Iz0vC5HlRfb2/D43XWlbftxHmh1/lPDkrKnFkL73OuFIw7Nz83tbUwjYe7WI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730378551; c=relaxed/simple;
	bh=d3l+JXTXn/d0gN9635I2vxj7QUG3pzswYvim2u3FDG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fJZDBMpolmmE31WAZXBslqPR4fztcSwlHNvthKyNtxj1W2BCxOaY5j/lS62yhVcoFU/21BUUTYQfiOR+NVfjrjDyb1d3xQJGE0aP9tydB7dN1zNlGu7ssx301V94bMR/RcGS9j40n2CLDY5R1sWH5Nfcdl9Mzf/LtIaHM1rJeWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=LVV8lWY9; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="LVV8lWY9"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539f72c8fc1so1445184e87.1
        for <sparclinux@vger.kernel.org>; Thu, 31 Oct 2024 05:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1730378546; x=1730983346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lTC2PsMAJfMn76auApCUvfCYGG80eZPc8JkIbfU4S3I=;
        b=LVV8lWY9SlAR+ykeyWB69P/yLuGwNOxOFqodsWki28Z6pRwlLRDBRw1MLL3GAJ/bsa
         uleh0teLLhX9O20TH71NPQLTv/xw8YxeVprGgVH7Rs6B1/z+wmUyJlKOyrNqBJteWExj
         TBpZw1oqWKwEGHpwT1KwtxD2RgPeZyWSo10kg9VHzTa7kNiEFua46vMGKAIF3nUYPJ+K
         dSDdBt1x5FO6/SMU5BN+5iL+4UBU9gk4ZPS6xVWSHyWdpWy4G8utqWKnnx46JRI3eghl
         +dMtyAsoGY+SO2X5aIidFhEeas8hTiGQTdRg1EfqoUQtPEJh6I95U1+aXUSRw3c9BeCm
         6Miw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730378546; x=1730983346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lTC2PsMAJfMn76auApCUvfCYGG80eZPc8JkIbfU4S3I=;
        b=J3AWIwNbWN7mSD8KTkKLaWAqCxbZUovDhxAR+G4XspJVZZBaT2tqwq7bv88IubLpjj
         NY5+S3Ji5d8HMWZCtBpcWAiFnDhqSJL2DAi4PoGMH0b85lV1ivuPuEWFOOEfqBuGs8e9
         LaCz4xqpXZeT5Fw3xQbWQHFbN2739tX8LGJN5oe0j6mAuxUhwZm6h9DeHPOFbj7BUyYn
         zRio/ii05qYTOjjb7MgGaEmH/aGeysyvC9TMsruDI0c/XR3tHCAV210btUU1nqFrILoB
         gLbeJhw3Tm+E9YQ9v6qLN0++0BNHgsFNQiiQorhOhfJDSn3gIduWKjPgGcx5jkg+9A3m
         Ya+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUKpv+R4iQlo02hSczDQO7mVcMBJh7tUCnlN8fNkkOtmIUJjd1uoEl9rpfxL4L8CPTIyMMrRleJpFfE@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+cfkxs55pBpF5tnZ5X88gOA6PaOjnLbpyRUl6S59sJfXDcBQV
	4U+LxQwIJQ4ELULx9yyqO2Imnh4dvwpF6lnonUWe173aba8BKGNmyeAzZkZIFoKQRBqtyUY3l81
	ukhtUKeNfSX7wKaIYnKquNVDxEhfQ3JZmuFUFlw==
X-Google-Smtp-Source: AGHT+IENgdCym3aCfQQffIdnAcnQ7jVQiujpNsdy/1kYvXN1HMbcw+ZNCVnTHviivQmDH59BdbpwnL5ScACnRVI2Res=
X-Received: by 2002:a05:6512:3b95:b0:539:f7de:df6a with SMTP id
 2adb3069b0e04-53b86b029efmr4048108e87.52.1730378546384; Thu, 31 Oct 2024
 05:42:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <140b0f7522ff2f86a7fad0be88c19111fa6cb5b1.1730282507.git.geert+renesas@glider.be>
 <04040095-27c2-49a1-b956-ac7bbd5f919a@gaisler.com> <CAMRc=MdAq3t7P_+SSCcZC3J02B5RuDQvUZjFXQbi4KViiK=-Pg@mail.gmail.com>
 <CAMuHMdX_OzLc5YzqxObHQrAdZAYrCa8E5Qz4zHR_cqX370KSAw@mail.gmail.com>
In-Reply-To: <CAMuHMdX_OzLc5YzqxObHQrAdZAYrCa8E5Qz4zHR_cqX370KSAw@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 31 Oct 2024 13:42:15 +0100
Message-ID: <CAMRc=MeZ8Anyiid-drOm2B373mh1yfwNzx_6ot-tHr=zHqoMWg@mail.gmail.com>
Subject: Re: [PATCH] gpio: GPIO_GRGPIO should depend on OF_GPIO
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andreas Larsson <andreas@gaisler.com>, Linus Walleij <linus.walleij@linaro.org>, 
	linux-gpio@vger.kernel.org, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 10:07=E2=80=AFAM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Bartosz,
>
> On Wed, Oct 30, 2024 at 5:44=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.p=
l> wrote:
> > On Wed, Oct 30, 2024 at 4:45=E2=80=AFPM Andreas Larsson <andreas@gaisle=
r.com> wrote:
> > > On 2024-10-30 11:03, Geert Uytterhoeven wrote:
> > > > While the Aeroflex Gaisler GRGPIO driver has no build-time dependen=
cy on
> > > > gpiolib-of, it supports only DT-based configuration, and is used on=
ly on
> > > > DT systems.  Hence re-add the dependency on OF_GPIO, to prevent ask=
ing
> > > > the user about this driver when configuring a kernel without DT sup=
port.
> > > >
> > > > Fixes: bc40668def384256 ("gpio: grgpio: drop Kconfig dependency on =
OF_GPIO")
> > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> > > > --- a/drivers/gpio/Kconfig
> > > > +++ b/drivers/gpio/Kconfig
> > > > @@ -341,6 +341,7 @@ config GPIO_GRANITERAPIDS
> > > >
> > > >  config GPIO_GRGPIO
> > > >       tristate "Aeroflex Gaisler GRGPIO support"
> > > > +     depends on OF_GPIO || COMPILE_TEST
> > > >       select GPIO_GENERIC
> > > >       select IRQ_DOMAIN
> > > >       help
> > >
> > > Or alternatively:
> > >
> > >         depends on OF || COMPILE_TEST
> > >
> > > Reviewed-by: Andreas Larsson <andreas@gaisler.com>
>
> > Yes, if anything it should depend on CONFIG_OF but is this really an
> > issue if this shows up as an option in Kconfig? It's not a hard no
> > from my side and I have heard a similar comment from Torvalds already
> > but I really don't get it: do people go through all the make config
> > prompts on a daily basis instead of using some base config and doing
> > make olddefconfig or menuconfig at worst?
>
> I never use "make olddefconfig" or "make menuconfig".
> I always use "make oldconfig".  How else do you find out about new
> driver support for the hardware you are interested in?
> I also compare the resulting config to what I had before, to catch new
> dependencies that suddenly make an option unavailable.
>
> The kernel has 20K Kconfig options. It's nearly impossible to configure
> a kernel from scratch. Being able to filter out the thousands of
> questions that cannot possibly apply to the hardware you are configuring
> your kernel for is a big win. Times the number of people doing this...
>
> Thanks for applying ;-)
>

Well I didn't. Not yet anyway. Please make it depend on CONFIG_OF if
you really want it.

Bartosz

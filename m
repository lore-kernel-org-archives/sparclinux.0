Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612482144DB
	for <sparclinux@vger.kernel.org>; Wed, 30 Oct 2024 16:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730306651; cv=none; b=lwkEhC9byiQnOIUwwMj3ZGoshrDJZafjWp8YZQz4+jSgXbVOSjorgYi11+ozJ4XaR9ZYS0oOc8gMruWBv6ZtpH/ss8nsjI0BnmXihenHL2B0Nv+FtIh2qH5e/rIPIDDBFHF3fSo9f2Jlyy3Iwkdn2WQq967mdv/ralTA2554/tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730306651; c=relaxed/simple;
	bh=WwWqx4o7XjhXX9R23m9CDYEIFUF9Qm6fI0Ek6MiyNm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kAg2KCRBKWxZJWELxFPNSABS7W6QhzdL8y3LF7neSnBxKwpkTdq/HRh3zZemPuUfiYran0JZgv8kNua0nniwsgsEZfawmktxn/1XQCllWcy7gscJ+RnO2f/3YQCCMlghPlSVF1wGDUQ9IVf2QaWkIaJTZnSbQAEhUtWImUV+5T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=RzoXNKTI; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="RzoXNKTI"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539f4d8ef84so63361e87.0
        for <sparclinux@vger.kernel.org>; Wed, 30 Oct 2024 09:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1730306647; x=1730911447; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xCtjX+ozVgiRdnmSFGTHSFQPiMY5pSNkOvyIgXNK6I0=;
        b=RzoXNKTI3JxKCPa27muOeU0iaLYAXCeevty8m8fSHWXIpYUPfLZyHIzu9szZzu1Q/w
         iHPkYnSJR/QkHwA1qBOEuYNh9pRTZmoXE0kR2Fku1EYI0S8Hvnax03XXVc2YAIxINaMK
         KsCo/srlAFD0UXdO+cKJmInld8oxUVroNw/ioepaxDXwZ9bK2KJLb7sWMCCHUFUuEATj
         UxIJdKX1dJI+YWSlPBI9EnXk22HWTtyoow8Y/e+RsFYhfuGI4HjZaEdr9X7j+W+P1UZe
         oGjZ/UqCqmcEOePVA+JDBjXpPulCc910XTOU9ByMtMGUnDzaSJorrB0Hs0lxI8qYiWyy
         dVWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730306647; x=1730911447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xCtjX+ozVgiRdnmSFGTHSFQPiMY5pSNkOvyIgXNK6I0=;
        b=sUIPwFiih66Q/yY8o0vKNIp2cUjOMQaMrfslZc7I/5SkrQZJICVNRqCR1rFUq8qjN1
         NYVkyRCCaoFdGcM/rFrbpyf3cNr9Qoauw4du6IBuCc7xWT+5B5INQtiA11qFVJrxIlt9
         r8/yz+cxODXkZEaa0JE/7TOVZQYn2K3LQW2dN8ZpVfXRy3cTqI0zZAYMVzlvzcTAqJD7
         YRBci2jdWYGad5P/8RMW/oDmrIQFUpFlxJJBtjG6WKfnRW2C5blMbuqREMHjqvBhvL+D
         ojGoWipEnhu7bgy17EZ0LQEi964o2f+F/vUOnHYpVMTYDOPctYO88p8lCQEJ/rXRHTLT
         BxEA==
X-Forwarded-Encrypted: i=1; AJvYcCWIbNYxH+Pq5vUZ/nqx01cDkrX3S0iJ47U1grBuf8XL6BFNUhj3ET4WrC3TzyFVkLzgwO7lFOqM+jd3@vger.kernel.org
X-Gm-Message-State: AOJu0YzNiRJ5T1R3cUIuv2C9y8uIHysjX7dJjkZLkwvsmlIUKtlqO43S
	/kO96pfyBUGCa6ctzn89YGQDa0N290/Ei6ekwhU7DizUdulE3W+CIoyQ209KJapuD/63skLWdb/
	3gIEY3GwphR1T1MO+dPTKGuieU2ULkOiXWlEzag==
X-Google-Smtp-Source: AGHT+IGo/ITkgJuG0uQfDtW5DgfpPBqnrV/BCb4sQ+oxUtEnQlE46DtCRhJKXJ2LG1BryoTFClZcZeVoViked7jsBEI=
X-Received: by 2002:a05:6512:2216:b0:539:f7c1:5feb with SMTP id
 2adb3069b0e04-53c79e8f0a1mr81987e87.39.1730306647227; Wed, 30 Oct 2024
 09:44:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <140b0f7522ff2f86a7fad0be88c19111fa6cb5b1.1730282507.git.geert+renesas@glider.be>
 <04040095-27c2-49a1-b956-ac7bbd5f919a@gaisler.com>
In-Reply-To: <04040095-27c2-49a1-b956-ac7bbd5f919a@gaisler.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 30 Oct 2024 17:43:55 +0100
Message-ID: <CAMRc=MdAq3t7P_+SSCcZC3J02B5RuDQvUZjFXQbi4KViiK=-Pg@mail.gmail.com>
Subject: Re: [PATCH] gpio: GPIO_GRGPIO should depend on OF_GPIO
To: Andreas Larsson <andreas@gaisler.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Linus Walleij <linus.walleij@linaro.org>, 
	linux-gpio@vger.kernel.org, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 4:45=E2=80=AFPM Andreas Larsson <andreas@gaisler.co=
m> wrote:
>
> On 2024-10-30 11:03, Geert Uytterhoeven wrote:
> > While the Aeroflex Gaisler GRGPIO driver has no build-time dependency o=
n
> > gpiolib-of, it supports only DT-based configuration, and is used only o=
n
> > DT systems.  Hence re-add the dependency on OF_GPIO, to prevent asking
> > the user about this driver when configuring a kernel without DT support=
.
> >
> > Fixes: bc40668def384256 ("gpio: grgpio: drop Kconfig dependency on OF_G=
PIO")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> >  drivers/gpio/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> > index 158ec0d7e52e2e51..a7b27a8541f572d5 100644
> > --- a/drivers/gpio/Kconfig
> > +++ b/drivers/gpio/Kconfig
> > @@ -341,6 +341,7 @@ config GPIO_GRANITERAPIDS
> >
> >  config GPIO_GRGPIO
> >       tristate "Aeroflex Gaisler GRGPIO support"
> > +     depends on OF_GPIO || COMPILE_TEST
> >       select GPIO_GENERIC
> >       select IRQ_DOMAIN
> >       help
>
> Or alternatively:
>
>         depends on OF || COMPILE_TEST
>
> Reviewed-by: Andreas Larsson <andreas@gaisler.com>
>
> Thanks,
> Andreas
>

Yes, if anything it should depend on CONFIG_OF but is this really an
issue if this shows up as an option in Kconfig? It's not a hard no
from my side and I have heard a similar comment from Torvalds already
but I really don't get it: do people go through all the make config
prompts on a daily basis instead of using some base config and doing
make olddefconfig or menuconfig at worst?

Bartosz

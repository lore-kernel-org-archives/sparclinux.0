Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60335C77B73
	for <sparclinux@archiver.kernel.org>; Fri,  5 May 2023 02:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjEECxU (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Thu, 4 May 2023 22:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjEECxQ (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Thu, 4 May 2023 22:53:16 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC9B2D53;
        Thu,  4 May 2023 19:53:15 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1ab1ce53ca6so9031065ad.0;
        Thu, 04 May 2023 19:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683255195; x=1685847195;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TvuQIwE86qT9nMkGXeQaDip5ug2GQu1BAKE7bYWgdwk=;
        b=jxvLXO0ysCTk5XQj17Rp4MPTljRhsg/NAlWqiFmGR2fpw55Cfg5sVLQNF9ke8zqu/N
         HHnWR+znibrRLrH9vcnvMDlm348iuI+SsyPL+KjDHd8kJ+kLygMtANYkoqlJA6z6lSGj
         QZNZWJy5SjgWh7ZGzeckqYUPsJuTsWIU94R5NJGqG7ornKXAjfQhUxU9ZW6eHYyHSwC8
         XuNhhR9rjzN6nhEHsIDIEBvw8EKr9RR4JqVK8n0VmA4Fy2LIawRCSoZ2wFbIEnMX0Hu7
         jCpsjNuzdvbOAUR1puJswLMYD3EbpysfH1e5Yu7q8B6TUU8LxJDGkmTXqTGuht3T2lUp
         xFiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683255195; x=1685847195;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TvuQIwE86qT9nMkGXeQaDip5ug2GQu1BAKE7bYWgdwk=;
        b=PqDThDNkaN3j47pETaV8NVP7xh7UVdKs/7F/M3n0i3leM7jrWJPBORrWC1G5Hd0n5M
         myO3x9McEzAmQcqNVHJAPGAqhDHofCA8UbZFE6TV46kF6K0rOOjetTGJI+8qEsV7w2Ym
         +k35YNRMooPOugxhLl8PBJYQuDMjIYtX9d8Aqy8/JhR3zlDe0yGuLeTjGQ/+YhxxbqHL
         1Fe6j0eXTF23dB5nx2cWGQPvlaqe7TjPLg5pNzGPb1/Af50VichO+ll0XCaw3Q0TKK+V
         UJgLAPr+EIBAXCUUBNxGJyERdreGt7o50F30Ctcr+r73BSvHy0qXVGfFhyP4y/XefvRt
         vmCA==
X-Gm-Message-State: AC+VfDxHsFobOfsuzACz3v+Du0xLUnPQiO5XUhTCAryprwVlgJjZJ/M8
        ENmIo7nSBf60R8ed7oyrG/8=
X-Google-Smtp-Source: ACHHUZ5a9oH4I1uJO71H1fLGgVbhwllNxoxjP5ILVe8scfc+huKbvNVr33otWqWTE3YRZg/we43I2g==
X-Received: by 2002:a17:903:2285:b0:1aa:f536:b1e2 with SMTP id b5-20020a170903228500b001aaf536b1e2mr6428524plh.62.1683255194928;
        Thu, 04 May 2023 19:53:14 -0700 (PDT)
Received: from localhost ([203.59.190.92])
        by smtp.gmail.com with ESMTPSA id a13-20020a170902eccd00b00186a2274382sm356805plh.76.2023.05.04.19.53.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 19:53:14 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 05 May 2023 12:53:01 +1000
Message-Id: <CSE05UZ1HC0R.2L6QW2OI7GIMA@wheely>
Cc:     "Sumit Garg" <sumit.garg@linaro.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Matthias Kaehlcke" <mka@chromium.org>,
        "Stephane Eranian" <eranian@google.com>,
        "Stephen Boyd" <swboyd@chromium.org>, <ricardo.neri@intel.com>,
        "Tzung-Bi Shih" <tzungbi@chromium.org>,
        "Lecopzer Chen" <lecopzer.chen@mediatek.com>,
        <kgdb-bugreport@lists.sourceforge.net>,
        "Masayoshi Mizuma" <msys.mizuma@gmail.com>,
        "Guenter Roeck" <groeck@chromium.org>,
        "Pingfan Liu" <kernelfans@gmail.com>,
        "Andi Kleen" <ak@linux.intel.com>,
        "Ian Rogers" <irogers@google.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>, <ito-yuichi@fujitsu.com>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Chen-Yu Tsai" <wens@csie.org>, <christophe.leroy@csgroup.eu>,
        <davem@davemloft.net>, <sparclinux@vger.kernel.org>,
        <mpe@ellerman.id.au>, "Will Deacon" <will@kernel.org>,
        <ravi.v.shankar@intel.com>, <linuxppc-dev@lists.ozlabs.org>,
        "Marc Zyngier" <maz@kernel.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Daniel Thompson" <daniel.thompson@linaro.org>
Subject: Re: [PATCH v4 06/17] watchdog/perf: Rename watchdog_hld.c to
 watchdog_perf.c
From:   "Nicholas Piggin" <npiggin@gmail.com>
To:     "Douglas Anderson" <dianders@chromium.org>,
        "Petr Mladek" <pmladek@suse.com>,
        "Andrew Morton" <akpm@linux-foundation.org>
X-Mailer: aerc 0.14.0
References: <20230504221349.1535669-1-dianders@chromium.org>
 <20230504151100.v4.6.Ice803cb078d0e15fb2cbf49132f096ee2bd4199d@changeid>
In-Reply-To: <20230504151100.v4.6.Ice803cb078d0e15fb2cbf49132f096ee2bd4199d@changeid>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Fri May 5, 2023 at 8:13 AM AEST, Douglas Anderson wrote:
> The code currently in "watchdog_hld.c" is for detecting hardlockups
> using perf, as evidenced by the line in the Makefile that only
> compiles this file if CONFIG_HARDLOCKUP_DETECTOR_PERF is
> defined. Rename the file to prepare for the buddy hardlockup detector,
> which doesn't use perf.
>
> It could be argued that the new name makes it less obvious that this
> is a hardlockup detector. While true, it's not hard to remember that
> the "perf" detector is always a hardlockup detector and it's nice not
> to have names that are too convoluted.

Better than the confusion that the perf version is *the* hardlockup
detector IMO.

Acked-by: Nicholas Piggin <npiggin@gmail.com>

>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
> Changes in v4:
> - ("Rename watchdog_hld.c to watchdog_perf.c") new for v4.
>
>  kernel/Makefile                            | 2 +-
>  kernel/{watchdog_hld.c =3D> watchdog_perf.c} | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>  rename kernel/{watchdog_hld.c =3D> watchdog_perf.c} (99%)
>
> diff --git a/kernel/Makefile b/kernel/Makefile
> index 10ef068f598d..406ccccc4dd3 100644
> --- a/kernel/Makefile
> +++ b/kernel/Makefile
> @@ -91,7 +91,7 @@ obj-$(CONFIG_FAIL_FUNCTION) +=3D fail_function.o
>  obj-$(CONFIG_KGDB) +=3D debug/
>  obj-$(CONFIG_DETECT_HUNG_TASK) +=3D hung_task.o
>  obj-$(CONFIG_LOCKUP_DETECTOR) +=3D watchdog.o
> -obj-$(CONFIG_HARDLOCKUP_DETECTOR_PERF) +=3D watchdog_hld.o
> +obj-$(CONFIG_HARDLOCKUP_DETECTOR_PERF) +=3D watchdog_perf.o
>  obj-$(CONFIG_SECCOMP) +=3D seccomp.o
>  obj-$(CONFIG_RELAY) +=3D relay.o
>  obj-$(CONFIG_SYSCTL) +=3D utsname_sysctl.o
> diff --git a/kernel/watchdog_hld.c b/kernel/watchdog_perf.c
> similarity index 99%
> rename from kernel/watchdog_hld.c
> rename to kernel/watchdog_perf.c
> index 96b717205952..c3d8ceb149da 100644
> --- a/kernel/watchdog_hld.c
> +++ b/kernel/watchdog_perf.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * Detect hard lockups on a system
> + * Detect hard lockups on a system using perf
>   *
>   * started by Don Zickus, Copyright (C) 2010 Red Hat, Inc.
>   *
> --=20
> 2.40.1.521.gf1e218fcd8-goog


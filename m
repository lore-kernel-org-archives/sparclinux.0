Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 945FFEB64DC
	for <sparclinux@archiver.kernel.org>; Sat,  1 Jul 2023 16:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjGAQJF (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Sat, 1 Jul 2023 12:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjGAQJE (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Sat, 1 Jul 2023 12:09:04 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B90D270E
        for <sparclinux@vger.kernel.org>; Sat,  1 Jul 2023 09:09:02 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fa16c6a85cso4719201e87.3
        for <sparclinux@vger.kernel.org>; Sat, 01 Jul 2023 09:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688227740; x=1690819740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ng1EwQD5y0cvCYQ4WXImHX40YGNrjiR/qucwDkIAqw0=;
        b=UZYCFRSzR+fLKW3hjwx6MJoSjyPdFqdjl04g2hUifIPlH3Pci7Lps7Lmay/4wTw/q8
         4fOftK0DL494NLdIQAc2qDSGJmWAwHoSYmGWoH1bv5bQIg02N1NCkR2scq9hIgqm+bGL
         6eoLgF0hMWHXmvbfMg1LbdiOfkdEzJmnkDH/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688227740; x=1690819740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ng1EwQD5y0cvCYQ4WXImHX40YGNrjiR/qucwDkIAqw0=;
        b=MoWfWsSdP8tO2fT2yuzCC9gjrynB6EqixDsOws+GewFUBvNrAc6CpQvzfN58AQ0l+a
         4aouoNLYL9P3eeLprXqq3GTATT0SncPOY8DwMFvffA/HRwYubVGNAedC1BsJnQZtz6Hq
         CiBs6XL+xgmm6bWGAktreyrZdY5Vt39l7/R+NRHbMGaSFi/JOKJQamdVfK6lbaERmz/V
         DwRc3SeL269Rms4OsgnBemz5zktvsixXaXiG/YvD4vZZC4oNIWFn6S7uvVK3c3hYfpHA
         Mp6MtkMcjw+s7g8w8vhtGMkRjriDQ47S5wQKaQlKqi+NlJoz1t+RtsTSX8J5o1ysfG+2
         Rpbg==
X-Gm-Message-State: ABy/qLYg4NVyhTEy9YRVzUmHW3zxUyLf9YzHZtAE22jFVKXBnmrEbYQl
        1wMfZNPAOaPn9fCiSblm3QnGOH9LzZd09zyEux63wNHj
X-Google-Smtp-Source: APBJJlFeiEjR8/p6wo36IdYNJqTa7sfmQTHeruTbR92y29rsUGYb2Z9lr0V9JdCkcP7FlIy6dGeeZQ==
X-Received: by 2002:a05:6512:70c:b0:4fb:7b4c:d38c with SMTP id b12-20020a056512070c00b004fb7b4cd38cmr4106818lfs.60.1688227740293;
        Sat, 01 Jul 2023 09:09:00 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id x2-20020ac24882000000b004fb99da37e3sm1423613lfc.220.2023.07.01.09.08.56
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Jul 2023 09:08:58 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-4fb0336ed4fso1423e87.1
        for <sparclinux@vger.kernel.org>; Sat, 01 Jul 2023 09:08:56 -0700 (PDT)
X-Received: by 2002:a19:ee17:0:b0:4f2:7840:e534 with SMTP id
 g23-20020a19ee17000000b004f27840e534mr36733lfb.0.1688227736365; Sat, 01 Jul
 2023 09:08:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230616150618.6073-1-pmladek@suse.com> <20230616150618.6073-7-pmladek@suse.com>
 <7cfc15f1-d8d0-4418-b7a1-5aa9e90e3fb3@roeck-us.net>
In-Reply-To: <7cfc15f1-d8d0-4418-b7a1-5aa9e90e3fb3@roeck-us.net>
From:   Doug Anderson <dianders@chromium.org>
Date:   Sat, 1 Jul 2023 09:08:43 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UsgweS0pTpr=6xE-+Dx0fqXgjN=3Gf-4MQcNAzjL+64w@mail.gmail.com>
Message-ID: <CAD=FV=UsgweS0pTpr=6xE-+Dx0fqXgjN=3Gf-4MQcNAzjL+64w@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] watchdog/hardlockup: Define HARDLOCKUP_DETECTOR_ARCH
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>,
        sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        "David S . Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Hi,

On Sat, Jul 1, 2023 at 7:40=E2=80=AFAM Guenter Roeck <linux@roeck-us.net> w=
rote:
>
> On Fri, Jun 16, 2023 at 05:06:18PM +0200, Petr Mladek wrote:
> > The HAVE_ prefix means that the code could be enabled. Add another
> > variable for HAVE_HARDLOCKUP_DETECTOR_ARCH without this prefix.
> > It will be set when it should be built. It will make it compatible
> > with the other hardlockup detectors.
> >
> > The change allows to clean up dependencies of PPC_WATCHDOG
> > and HAVE_HARDLOCKUP_DETECTOR_PERF definitions for powerpc.
> >
> > As a result HAVE_HARDLOCKUP_DETECTOR_PERF has the same dependencies
> > on arm, x86, powerpc architectures.
> >
> > Signed-off-by: Petr Mladek <pmladek@suse.com>
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > ---
> ...
> > --- a/include/linux/nmi.h
> > +++ b/include/linux/nmi.h
> > @@ -9,7 +9,7 @@
> >  #include <asm/irq.h>
> >
> >  /* Arch specific watchdogs might need to share extra watchdog-related =
APIs. */
> > -#if defined(CONFIG_HAVE_HARDLOCKUP_DETECTOR_ARCH) || defined(CONFIG_HA=
RDLOCKUP_DETECTOR_SPARC64)
> > +#if defined(CONFIG_HARDLOCKUP_DETECTOR_ARCH) || defined(CONFIG_HARDLOC=
KUP_DETECTOR_SPARC64)
>
> This results in:
>
> arch/powerpc/platforms/pseries/mobility.c: In function 'pseries_migrate_p=
artition':
> arch/powerpc/platforms/pseries/mobility.c:753:17: error: implicit declara=
tion of function 'watchdog_hardlockup_set_timeout_pct'; did you mean 'watch=
dog_hardlockup_stop'? [-Werror=3Dimplicit-function-declaration]
>   753 |                 watchdog_hardlockup_set_timeout_pct(factor);
>
> with ppc64_defconfig -CONFIG_HARDLOCKUP_DETECTOR, because the dummy
> for watchdog_hardlockup_set_timeout_pct() is still defined in
> arch/powerpc/include/asm/nmi.h which is no longer included.

Can you test with:

https://lore.kernel.org/r/20230629124500.1.I55e2f4e7903d686c4484cb23c033c6a=
9e1a9d4c4@changeid

Thanks!

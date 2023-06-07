Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34CFC7EE25
	for <sparclinux@archiver.kernel.org>; Wed,  7 Jun 2023 23:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbjFGXf1 (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 7 Jun 2023 19:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233340AbjFGXf1 (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 7 Jun 2023 19:35:27 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED142697
        for <sparclinux@vger.kernel.org>; Wed,  7 Jun 2023 16:35:25 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-33b22221da6so8924005ab.1
        for <sparclinux@vger.kernel.org>; Wed, 07 Jun 2023 16:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686180923; x=1688772923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=biTF71f0vAcJJkYigTXNuEEy/3xCIdh35a2WB5hJK3w=;
        b=cDd+huO6yiwjdUNKLZXT1W+AqRcPQSvEqge36+d9FgGW3jIk7SHGJctxAb9YVM1Ir+
         FkTiBJw1Sij/UzxFy9XlYMPCkAu/Qq5AH8vuftnbuox0hONovc6Zvxwsh/nkCQmgUjrI
         Rej4cdv23ACAsd3VSLMLwZ68en6at1YE+ugOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686180923; x=1688772923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=biTF71f0vAcJJkYigTXNuEEy/3xCIdh35a2WB5hJK3w=;
        b=jY780EgPi0SsAz5wwjAIdkNIXK/pJ/IhsRwGI2DHGa5KHo1mkqN/uW0KlHZK0IRdgz
         urJ8dW9XUCzUslDPQYnCaUnKDxlly+8mhU7L3c33aTsP7eIYHmzqzhAHSIQNHsnN9Qf6
         44tXzUgoAjUTckx8Eg0+F2aYBumv6wBgbTcjMd/PyqAde6FrivkMmbv14kqa7JP9FuxG
         BGIzHiagF1eTx+FSgUwLVOVlW7K5E0PnQ8dJ2E35BUSKJeI97nLgOjrmQhBSLNOfmro7
         r+/xuRwpChPC+BMEsJF8rq1ZtgkHAEn1Kie/uVZwo7nC+8XMLm15lUmYGuE/wVs0YmSj
         PnMA==
X-Gm-Message-State: AC+VfDyYbz7ixBbkTdfRY/gSn/3boO27om5vraxQgMx135o1G8iFN8N6
        H+8qs2REUKSkQRZ+PxO7tap+K1oJEKkgVq1Ogkc=
X-Google-Smtp-Source: ACHHUZ4SUWPEwhL3Y8tScWgdfocP80Uv5Cy0TfkAxyN84wlIjCFlEwgT7yXh71nvrgG3asomvooR7w==
X-Received: by 2002:a92:da83:0:b0:331:96e5:678b with SMTP id u3-20020a92da83000000b0033196e5678bmr8114824iln.23.1686180923160;
        Wed, 07 Jun 2023 16:35:23 -0700 (PDT)
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com. [209.85.166.173])
        by smtp.gmail.com with ESMTPSA id o25-20020a02cc39000000b004163438fd4esm921818jap.92.2023.06.07.16.35.21
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 16:35:22 -0700 (PDT)
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-33bf12b5fb5so26075ab.1
        for <sparclinux@vger.kernel.org>; Wed, 07 Jun 2023 16:35:21 -0700 (PDT)
X-Received: by 2002:a05:6e02:170e:b0:33d:5640:f315 with SMTP id
 u14-20020a056e02170e00b0033d5640f315mr16394ill.25.1686180921009; Wed, 07 Jun
 2023 16:35:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230607152432.5435-1-pmladek@suse.com> <20230607152432.5435-3-pmladek@suse.com>
In-Reply-To: <20230607152432.5435-3-pmladek@suse.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 7 Jun 2023 16:35:09 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WRzaLbLQ65usGeFq3ya=DV8cYyHQina_721EFoSTdBGA@mail.gmail.com>
Message-ID: <CAD=FV=WRzaLbLQ65usGeFq3ya=DV8cYyHQina_721EFoSTdBGA@mail.gmail.com>
Subject: Re: [PATCH 2/7] watchdog/hardlockup: Make the config checks more straightforward
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        sparclinux@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Hi,

On Wed, Jun 7, 2023 at 8:25=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrote=
:
>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 422f0ffa269e..13c6e596cf9e 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -404,17 +404,27 @@ config HAVE_NMI_WATCHDOG
>         depends on HAVE_NMI
>         bool
>         help
> -         The arch provides a low level NMI watchdog. It provides
> -         asm/nmi.h, and defines its own watchdog_hardlockup_probe() and
> -         arch_touch_nmi_watchdog().
> +         The arch provides its own hardlockup detector implementation in=
stead
> +         of the generic perf one.

nit: did you mean to have different wording here compared to
HAVE_HARDLOCKUP_DETECTOR_ARCH? Here you say "the generic perf one" and
there you say "the generic ones", though it seems like you mean them
to be the same.

> +
> +         Sparc64 defines this variable without HAVE_HARDLOCKUP_DETECTOR_=
ARCH.
> +         It does _not_ use the command line parameters and sysctl interf=
ace
> +         used by generic hardlockup detectors. Instead it is enabled/dis=
abled
> +         by the top-level watchdog interface that is common for both sof=
tlockup
> +         and hardlockup detectors.
>
>  config HAVE_HARDLOCKUP_DETECTOR_ARCH
>         bool
>         select HAVE_NMI_WATCHDOG
>         help
> -         The arch chooses to provide its own hardlockup detector, which =
is
> -         a superset of the HAVE_NMI_WATCHDOG. It also conforms to config
> -         interfaces and parameters provided by hardlockup detector subsy=
stem.
> +         The arch provides its own hardlockup detector implementation in=
stead
> +         of the generic ones.
> +
> +         It uses the same command line parameters, and sysctl interface,
> +         as the generic hardlockup detectors.
> +
> +         HAVE_NMI_WATCHDOG is selected to build the code shared with
> +         the sparc64 specific implementation.
>
>  config HAVE_PERF_REGS
>         bool
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 3e91fa33c7a0..d201f5d3876b 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1035,16 +1035,33 @@ config BOOTPARAM_SOFTLOCKUP_PANIC
>
>           Say N if unsure.
>
> +config HAVE_HARDLOCKUP_DETECTOR_BUDDY
> +       bool
> +       depends on SMP
> +       default y

I think you simplify your life if you also add:

  depends on !HAVE_NMI_WATCHDOG

The existing config system has always assumed that no architecture
defines both HAVE_HARDLOCKUP_DETECTOR_PERF and HAVE_NMI_WATCHDOG
(symbols would have clashed and you would get a link error as two
watchdogs try to implement the same weak symbol). If you add the extra
dependency to "buddy" as per above, then a few things below fall out.
I'll try to point them out below.


> +
>  #
> -# arch/ can define HAVE_HARDLOCKUP_DETECTOR_ARCH to provide their own ha=
rd
> -# lockup detector rather than the perf based detector.
> +# Global switch whether to build a hardlockup detector at all. It is ava=
ilable
> +# only when the architecture supports at least one implementation. There=
 are
> +# two exceptions. The hardlockup detector is newer enabled on:

s/newer/never/


> +#
> +#      s390: it reported many false positives there
> +#
> +#      sparc64: has a custom implementation which is not using the commo=
n
> +#              hardlockup command line options and sysctl interface.
> +#
> +# Note that HAVE_NMI_WATCHDOG is used to distinguish the sparc64 specifi=
c
> +# implementaion. It is automatically enabled also for other arch-specifi=
c
> +# variants which set HAVE_HARDLOCKUP_DETECTOR_ARCH. It makes the check
> +# of avaialable and supported variants quite tricky.
>  #
>  config HARDLOCKUP_DETECTOR
>         bool "Detect Hard Lockups"
>         depends on DEBUG_KERNEL && !S390
> -       depends on HAVE_HARDLOCKUP_DETECTOR_NON_ARCH || HAVE_HARDLOCKUP_D=
ETECTOR_ARCH
> +       depends on ((HAVE_HARDLOCKUP_DETECTOR_PERF || HAVE_HARDLOCKUP_DET=
ECTOR_BUDDY) && !HAVE_NMI_WATCHDOG) || HAVE_HARDLOCKUP_DETECTOR_ARCH

Adding the dependency to buddy (see ablove) would simplify the above
to just this:

depends on HAVE_HARDLOCKUP_DETECTOR_PERF ||
HAVE_HARDLOCKUP_DETECTOR_BUDDY || HAVE_HARDLOCKUP_DETECTOR_ARCH

As per above, it's simply a responsibility of architectures not to
define that they have both "perf" if they have the NMI watchdog, so
it's just buddy to worry about.


> +       imply HARDLOCKUP_DETECTOR_PERF
> +       imply HARDLOCKUP_DETECTOR_BUDDY
>         select LOCKUP_DETECTOR
> -       select HARDLOCKUP_DETECTOR_NON_ARCH if HAVE_HARDLOCKUP_DETECTOR_N=
ON_ARCH
>
>         help
>           Say Y here to enable the kernel to act as a watchdog to detect
> @@ -1055,9 +1072,15 @@ config HARDLOCKUP_DETECTOR
>           chance to run.  The current stack trace is displayed upon detec=
tion
>           and the system will stay locked up.
>
> +#
> +# Note that arch-specific variants are always preferred.
> +#
>  config HARDLOCKUP_DETECTOR_PREFER_BUDDY
>         bool "Prefer the buddy CPU hardlockup detector"
> -       depends on HAVE_HARDLOCKUP_DETECTOR_PERF && SMP
> +       depends on HARDLOCKUP_DETECTOR
> +       depends on HAVE_HARDLOCKUP_DETECTOR_PERF && HAVE_HARDLOCKUP_DETEC=
TOR_BUDDY
> +       depends on !HAVE_NMI_WATCHDOG

Can get rid of above "!HAVE_NMI_WATCHDOG" if it's added to
HAVE_HARDLOCKUP_DETECTOR_BUDDY.


> +       default n

I'm pretty sure "default n" isn't needed.


>         help
>           Say Y here to prefer the buddy hardlockup detector over the per=
f one.
>
> @@ -1071,39 +1094,27 @@ config HARDLOCKUP_DETECTOR_PREFER_BUDDY
>
>  config HARDLOCKUP_DETECTOR_PERF
>         bool
> -       depends on HAVE_HARDLOCKUP_DETECTOR_PERF
> +       depends on HARDLOCKUP_DETECTOR
> +       depends on HAVE_HARDLOCKUP_DETECTOR_PERF && !HARDLOCKUP_DETECTOR_=
PREFER_BUDDY
> +       depends on !HAVE_NMI_WATCHDOG

We don't really need the "!HAVE_NMI_WATCHDOG". A user wouldn't be able
to mess this up and it's up to an architecture not to define both
HAVE_HARDLOCKUP_DETECTOR_PERF and HAVE_NMI_WATCHDOG.


>         select HARDLOCKUP_DETECTOR_COUNTS_HRTIMER
>
>  config HARDLOCKUP_DETECTOR_BUDDY
>         bool
> -       depends on SMP
> +       depends on HARDLOCKUP_DETECTOR
> +       depends on HAVE_HARDLOCKUP_DETECTOR_BUDDY
> +       depends on !HAVE_HARDLOCKUP_DETECTOR_PERF || HARDLOCKUP_DETECTOR_=
PREFER_BUDDY
> +       depends on !HAVE_NMI_WATCHDOG

Get rid of "!HAVE_NMI_WATCHDOG" and it should be in
HAVE_HARDLOCKUP_DETECTOR_BUDDY


Overall, though, I agree that this improves things! Thanks! :-)

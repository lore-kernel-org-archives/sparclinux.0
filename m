Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCFCC77B7A
	for <sparclinux@archiver.kernel.org>; Thu,  8 Jun 2023 00:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjFHAUl (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 7 Jun 2023 20:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjFHAUk (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 7 Jun 2023 20:20:40 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7512128
        for <sparclinux@vger.kernel.org>; Wed,  7 Jun 2023 17:20:39 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-394c7ba4cb5so42193b6e.1
        for <sparclinux@vger.kernel.org>; Wed, 07 Jun 2023 17:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686183638; x=1688775638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhl3RV14fXn8RdG370rcvuPNBbtc0Bpx0+NmOZMVtZc=;
        b=niKHunaDhmE6o1Kpv24Wf396NkfydHRVRnYV/oNYBZQ97fYq3ibIDu1lPynyhJ1iez
         vFuCzuQI5D5P6wJDCcXqP/yqXwD0Z3Z399futDFXrDsJ+8Nf2TicGCzvURZOdVLvTpdp
         MXSQ4JW1mbliN71ljCBR/h8Nn0LYny/5L2ptg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686183638; x=1688775638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nhl3RV14fXn8RdG370rcvuPNBbtc0Bpx0+NmOZMVtZc=;
        b=E53oAlqRi+FM2/BsdXXMuBarBNSVBoU1PS1uOneDpZEZozmJkuf6ff30OPtdXnUb7z
         Nq04IEPW2EHODPkSuVUAAgRxdJ0x0/PFr7pDZ6AFnPcobl3+Q7RJE4IkC+mjuxBtssKv
         hzuYDFaSLEuPlpGDjUJyFiNvvPJnmMJJtxOYZcVeMXYE6EZJyfQwnSJAH0vx1yA7ECw+
         V92KQI6XCc8pFgdlV9HJ5qf3aeZI5QestfAFtlWlT1VyaQB5O1EZ7EXs9IL5f4BG5b68
         V8cMt4TDk2Zqd6gH12wOb2tIC+H7Qp+vekyzpeA4z66fqlNFjmS1m2F1vGYNp54LuyGB
         nn1Q==
X-Gm-Message-State: AC+VfDz2KNv2mCcVWRIUuH7xdfpWNLsUDP3sDfiZvoJxQSvKCnTsQRem
        AtZR+DEly3cLft61KcG46YEAjiOltedFm1KlMc0=
X-Google-Smtp-Source: ACHHUZ4UCybmlozmtJLRrJ5BtGap7MV/l8BORo9ZGHvoZqGzgwozAois9WJIHsI5mxhNFnHJ+CqClQ==
X-Received: by 2002:aca:230c:0:b0:39a:a847:f08d with SMTP id e12-20020aca230c000000b0039aa847f08dmr6505443oie.39.1686183638331;
        Wed, 07 Jun 2023 17:20:38 -0700 (PDT)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com. [209.85.214.174])
        by smtp.gmail.com with ESMTPSA id l13-20020a654c4d000000b005307501cfe4sm30396pgr.44.2023.06.07.17.20.37
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 17:20:38 -0700 (PDT)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1b1b51ec3e9so74535ad.0
        for <sparclinux@vger.kernel.org>; Wed, 07 Jun 2023 17:20:37 -0700 (PDT)
X-Received: by 2002:a92:c54d:0:b0:33e:6b65:6f78 with SMTP id
 a13-20020a92c54d000000b0033e6b656f78mr16489ilj.27.1686181007418; Wed, 07 Jun
 2023 16:36:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230607152432.5435-1-pmladek@suse.com> <20230607152432.5435-5-pmladek@suse.com>
In-Reply-To: <20230607152432.5435-5-pmladek@suse.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 7 Jun 2023 16:36:35 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VV3Y7KoZWPtZfmfRsUCftAgo_CLRDazrYSgbR2XJKf=g@mail.gmail.com>
Message-ID: <CAD=FV=VV3Y7KoZWPtZfmfRsUCftAgo_CLRDazrYSgbR2XJKf=g@mail.gmail.com>
Subject: Re: [PATCH 4/7] watchdog/hardlockup: Enable HAVE_NMI_WATCHDOG only on sparc64
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
> index 13c6e596cf9e..57f15babe188 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -404,10 +404,9 @@ config HAVE_NMI_WATCHDOG
>         depends on HAVE_NMI
>         bool
>         help
> -         The arch provides its own hardlockup detector implementation in=
stead
> +         Sparc64 provides its own hardlockup detector implementation ins=
tead
>           of the generic perf one.

It's a little weird to document generic things with the specifics of
the user. The exception, IMO, is when something is deprecated.
Personally, it would sound less weird to me to say something like:

The arch provides its own hardlockup detector implementation instead
of the generic perf one. This is a deprecated thing to do and kept
around until sparc64 provides a full hardlockup implementation or
moves to generic code.


> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index d201f5d3876b..4b4aa0f941f9 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1050,15 +1050,13 @@ config HAVE_HARDLOCKUP_DETECTOR_BUDDY
>  #      sparc64: has a custom implementation which is not using the commo=
n
>  #              hardlockup command line options and sysctl interface.
>  #
> -# Note that HAVE_NMI_WATCHDOG is used to distinguish the sparc64 specifi=
c
> -# implementaion. It is automatically enabled also for other arch-specifi=
c
> -# variants which set HAVE_HARDLOCKUP_DETECTOR_ARCH. It makes the check
> -# of avaialable and supported variants quite tricky.
> +# Note that HAVE_NMI_WATCHDOG is set when the sparc64 specific implement=
ation
> +# is used.
>  #
>  config HARDLOCKUP_DETECTOR
>         bool "Detect Hard Lockups"
> -       depends on DEBUG_KERNEL && !S390
> -       depends on ((HAVE_HARDLOCKUP_DETECTOR_PERF || HAVE_HARDLOCKUP_DET=
ECTOR_BUDDY) && !HAVE_NMI_WATCHDOG) || HAVE_HARDLOCKUP_DETECTOR_ARCH
> +       depends on DEBUG_KERNEL && !S390 && !HAVE_NMI_WATCHDOG
> +       depends on HAVE_HARDLOCKUP_DETECTOR_PERF || HAVE_HARDLOCKUP_DETEC=
TOR_BUDDY || HAVE_HARDLOCKUP_DETECTOR_ARCH

If you add the "!HAVE_NMI_WATCHDOG" as a dependency to
HAVE_HARDLOCKUP_DETECTOR_BUDDY, as discussed in a previous patch, you
can skip adding it here.


>         imply HARDLOCKUP_DETECTOR_PERF
>         imply HARDLOCKUP_DETECTOR_BUDDY
>         select LOCKUP_DETECTOR
> @@ -1079,7 +1077,7 @@ config HARDLOCKUP_DETECTOR_PREFER_BUDDY
>         bool "Prefer the buddy CPU hardlockup detector"
>         depends on HARDLOCKUP_DETECTOR
>         depends on HAVE_HARDLOCKUP_DETECTOR_PERF && HAVE_HARDLOCKUP_DETEC=
TOR_BUDDY
> -       depends on !HAVE_NMI_WATCHDOG
> +       depends on !HAVE_HARLOCKUP_DETECTOR_ARCH

Don't need this. Architectures never are allowed to define
HAVE_HARDLOCKUP_DETECTOR_PERF and HAVE_HARLOCKUP_DETECTOR_ARCH


>         default n
>         help
>           Say Y here to prefer the buddy hardlockup detector over the per=
f one.
> @@ -1096,7 +1094,7 @@ config HARDLOCKUP_DETECTOR_PERF
>         bool
>         depends on HARDLOCKUP_DETECTOR
>         depends on HAVE_HARDLOCKUP_DETECTOR_PERF && !HARDLOCKUP_DETECTOR_=
PREFER_BUDDY
> -       depends on !HAVE_NMI_WATCHDOG
> +       depends on !HAVE_HARDLOCKUP_DETECTOR_ARCH

Similarly, don't need this.


>         select HARDLOCKUP_DETECTOR_COUNTS_HRTIMER
>
>  config HARDLOCKUP_DETECTOR_BUDDY
> @@ -1104,7 +1102,7 @@ config HARDLOCKUP_DETECTOR_BUDDY
>         depends on HARDLOCKUP_DETECTOR
>         depends on HAVE_HARDLOCKUP_DETECTOR_BUDDY
>         depends on !HAVE_HARDLOCKUP_DETECTOR_PERF || HARDLOCKUP_DETECTOR_=
PREFER_BUDDY
> -       depends on !HAVE_NMI_WATCHDOG
> +       depends on !HAVE_HARDLOCKUP_DETECTOR_ARCH

Similarly, don't need this.


In general I don't object to splitting out HAVE_NMI_WATCHDOG from
HAVE_HARDLOCKUP_DETECTOR_ARCH.

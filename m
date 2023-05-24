Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E242C77B7C
	for <sparclinux@archiver.kernel.org>; Wed, 24 May 2023 19:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjEXTrA (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 24 May 2023 15:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjEXTq7 (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 24 May 2023 15:46:59 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F2E132
        for <sparclinux@vger.kernel.org>; Wed, 24 May 2023 12:46:58 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-75b04e897a5so16274085a.2
        for <sparclinux@vger.kernel.org>; Wed, 24 May 2023 12:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684957617; x=1687549617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XIB0HReKptcGBTosdBXg1PO+NrPRx+I4udNpoc6AMN0=;
        b=HwMeYcrgygHdepBJJClCaKq/dvM0hdhDIHUPKe5aIIu45QNrnn/UPQd0s9QRfB1PGZ
         kCHfeBtqiLd6OD+bDnIVs5Tk6lGMjqMGjtKAReuBKZTvgytXIpwVZbFN7Pv7yU/+2kfK
         y0zIy9q8o9HR+6TR4zZgLWuO409kUbBzutD84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684957617; x=1687549617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XIB0HReKptcGBTosdBXg1PO+NrPRx+I4udNpoc6AMN0=;
        b=czPRrD2/cDvbTqmyVogoi17cbblH0EfPen1r/hLnXjMy3ulwDGBXQ4y7B6NDJpVXCH
         6WBcD0Jf0B7QPrGBpdi4Pa31FoDpHLc57LbXo8ed4mXV3AhvNYZmVH2NSnMMDyzxIS35
         tYKXMQozLjUH7icAfR7sBaAD0ntaZ3gm+tR5GY/CfGrqrqm285SubpQJdDb6/SQcZy73
         wEkQV8j89HMPoZPrp1dbLOrpP0oJ/q88UWuRBplMhUqsTWU2pT8jTkioa6I2kva7Kqx5
         8s+pj8eo8H3Wi+ecSfDR1A7F/IAYii3qq1657xb/cX5KWgAcBTKTb2QDW7fJpv7nKOTk
         /s5Q==
X-Gm-Message-State: AC+VfDzc7W8+4sAMEiXbWckOxdeekzcydWIJZ1fapWQG71SOmaa9DNZS
        oMRLRFj38wohdX8OLkUcrMjXmagsApw3zPCZ7eQ=
X-Google-Smtp-Source: ACHHUZ5HsbNqCnjolciSDADv6lDd2wGP2/9ZG8mw7ehq9Fgc8tj322HKjxuPHzD5LCmFhpM332X/AQ==
X-Received: by 2002:a05:6214:20a5:b0:621:6bcb:e49 with SMTP id 5-20020a05621420a500b006216bcb0e49mr27308663qvd.0.1684957617075;
        Wed, 24 May 2023 12:46:57 -0700 (PDT)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com. [209.85.160.174])
        by smtp.gmail.com with ESMTPSA id p7-20020a0cf687000000b006238cf6d2a8sm3833354qvn.2.2023.05.24.12.46.56
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 12:46:56 -0700 (PDT)
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-3f38824a025so42331cf.0
        for <sparclinux@vger.kernel.org>; Wed, 24 May 2023 12:46:56 -0700 (PDT)
X-Received: by 2002:a05:6e02:194e:b0:331:d42:d06e with SMTP id
 x14-20020a056e02194e00b003310d42d06emr33974ilu.17.1684957143210; Wed, 24 May
 2023 12:39:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230519101840.v5.18.Ia44852044cdcb074f387e80df6b45e892965d4a1@changeid>
 <20230519101840.v5.13.I847d9ec852449350997ba00401d2462a9cb4302b@changeid> <ZG4YMyifGLOBJxLo@alley>
In-Reply-To: <ZG4YMyifGLOBJxLo@alley>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 24 May 2023 12:38:49 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X+LEcSrArV+w35MX4oP1sC9KoRM0puJLT1RFmyS84Hxw@mail.gmail.com>
Message-ID: <CAD=FV=X+LEcSrArV+w35MX4oP1sC9KoRM0puJLT1RFmyS84Hxw@mail.gmail.com>
Subject: Re: [PATCH v5 13/18] watchdog/hardlockup: Have the perf hardlockup
 use __weak functions more cleanly
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Stephane Eranian <eranian@google.com>, mpe@ellerman.id.au,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linuxppc-dev@lists.ozlabs.org, Sumit Garg <sumit.garg@linaro.org>,
        npiggin@gmail.com, davem@davemloft.net,
        Marc Zyngier <maz@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>, sparclinux@vger.kernel.org,
        christophe.leroy@csgroup.eu,
        Catalin Marinas <catalin.marinas@arm.com>,
        ravi.v.shankar@intel.com, Randy Dunlap <rdunlap@infradead.org>,
        Pingfan Liu <kernelfans@gmail.com>,
        Guenter Roeck <groeck@chromium.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Ian Rogers <irogers@google.com>, ito-yuichi@fujitsu.com,
        ricardo.neri@intel.com, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Hi,

On Wed, May 24, 2023 at 6:59=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrot=
e:
>
> On Fri 2023-05-19 10:18:37, Douglas Anderson wrote:
> > The fact that there watchdog_hardlockup_enable(),
> > watchdog_hardlockup_disable(), and watchdog_hardlockup_probe() are
> > declared __weak means that the configured hardlockup detector can
> > define non-weak versions of those functions if it needs to. Instead of
> > doing this, the perf hardlockup detector hooked itself into the
> > default __weak implementation, which was a bit awkward. Clean this up.
> >
> > >From comments, it looks as if the original design was done because the
> > __weak function were expected to implemented by the architecture and
> > not by the configured hardlockup detector. This got awkward when we
> > tried to add the buddy lockup detector which was not arch-specific but
> > wanted to hook into those same functions.
> >
> > This is not expected to have any functional impact.
> >
> > @@ -187,27 +187,33 @@ static inline void watchdog_hardlockup_kick(void)=
 { }
> >  #endif /* !CONFIG_HARDLOCKUP_DETECTOR_PERF */
> >
> >  /*
> > - * These functions can be overridden if an architecture implements its
> > - * own hardlockup detector.
> > + * These functions can be overridden based on the configured hardlockd=
up detector.
> >   *
> >   * watchdog_hardlockup_enable/disable can be implemented to start and =
stop when
> > - * softlockup watchdog start and stop. The arch must select the
> > + * softlockup watchdog start and stop. The detector must select the
> >   * SOFTLOCKUP_DETECTOR Kconfig.
> >   */
> > -void __weak watchdog_hardlockup_enable(unsigned int cpu)
> > -{
> > -     hardlockup_detector_perf_enable();
> > -}
> > +void __weak watchdog_hardlockup_enable(unsigned int cpu) { }
> >
> > -void __weak watchdog_hardlockup_disable(unsigned int cpu)
> > -{
> > -     hardlockup_detector_perf_disable();
> > -}
> > +void __weak watchdog_hardlockup_disable(unsigned int cpu) { }
> >
> >  /* Return 0, if a hardlockup watchdog is available. Error code otherwi=
se */
> >  int __weak __init watchdog_hardlockup_probe(void)
> >  {
> > -     return hardlockup_detector_perf_init();
> > +     /*
> > +      * If CONFIG_HAVE_NMI_WATCHDOG is defined then an architecture
> > +      * is assumed to have the hard watchdog available and we return 0=
.
> > +      */
> > +     if (IS_ENABLED(CONFIG_HAVE_NMI_WATCHDOG))
> > +             return 0;
> > +
> > +     /*
> > +      * Hardlockup detectors other than those using CONFIG_HAVE_NMI_WA=
TCHDOG
> > +      * are required to implement a non-weak version of this probe fun=
ction
> > +      * to tell whether they are available. If they don't override the=
n
> > +      * we'll return -ENODEV.
> > +      */
> > +     return -ENODEV;
> >  }
>
> When thinking more about it. It is weird that we need to handle
> CONFIG_HAVE_NMI_WATCHDOG in this default week function.
>
> It should be handled in watchdog_hardlockup_probe() implemented
> in kernel/watchdog_perf.c.
>
> IMHO, the default __weak function could always return -ENODEV;
>
> Would it make sense, please?

I don't quite understand. I'd agree that the special case for
CONFIG_HAVE_NMI_WATCHDOG is ugly, but it was also ugly before. IMO
it's actually a little less ugly / easier to understand after my
patch. ...but let me walk through how I think this special case works
and maybe you can tell me where I'm confused.

The first thing to understand is that CONFIG_HARDLOCKUP_DETECTOR_PERF
and CONFIG_HAVE_NMI_WATCHDOG are mutually exclusive from each other.
This was true before any of my patches and is still true after them.
Specifically, if CONFIG_HAVE_NMI_WATCHDOG is defined then an
architecture implements arch_touch_nmi_watchdog() (as documented in
the Kconfig docs for HAVE_NMI_WATCHDOG). Looking at the tree before my
series you can see that the perf hardlockup detector also implemented
arch_touch_nmi_watchdog(). This would have caused a conflict. The
mutual exclusion was presumably enforced by an architecture not
defining both HAVE_NMI_WATCHDOG and HAVE_HARDLOCKUP_DETECTOR_PERF.

The second thing to understand is that an architecture that defines
CONFIG_HAVE_NMI_WATCHDOG is _not_ required to implement
watchdog_hardlockup_probe() (used to be called watchdog_nmi_probe()).
Maybe this should change, but at the very least it appears that
SPARC64 defines HAVE_NMI_WATCHDOG but doesn't define
watchdog_hardlockup_probe() AKA watchdog_nmi_probe(). Anyone who
defines CONFIG_HAVE_NMI_WATCHDOG and doesn't implement
watchdog_hardlockup_probe() is claiming that their watchdog needs no
probing and is always available.

So with that context:

1. We can't handle any special cases for CONFIG_HAVE_NMI_WATCHDOG in
"kernel/watchdog_perf.c". The special cases that we need to handle are
all for the cases where CONFIG_HARDLOCKUP_DETECTOR_PERF isn't defined
and that means "kernel/watchdog_perf.c" isn't included.

2. We can't have the default __weak function return -ENODEV because
CONFIG_HAVE_NMI_WATCHDOG doesn't require an arch to implement
watchdog_hardlockup_probe(), but we want watchdog_hardlockup_probe()
to return "no error" in that case so that
"watchdog_hardlockup_available" gets set to true.

Does that sound right?

I'd agree that a future improvement saying that
CONFIG_HAVE_NMI_WATCHDOG means you _must_ implement
watchdog_hardlockup_probe() would make sense and that would allow us
to get rid of the special case. IMO, though, that's a separate patch.
I'd be happy to review that patch if you wanted to post it up. :-)

If we want to add that requirement, I _think_ the only thing you'd
need to do is to add watchdog_hardlockup_probe() to sparc64 and have
it return 0 and put that definition in the same file containing
arch_touch_nmi_watchdog(). powerpc also gets CONFIG_HAVE_NMI_WATCHDOG
as a side effect of selecting CONFIG_HAVE_HARDLOCKUP_DETECTOR_ARCH but
it looks like they implement watchdog_hardlockup_probe() already. Oh,
but maybe this will fix a preexisting (existed before my patches)
minor bug... Unless I'm missing something (entirely possible!) on
powerpc today I guess if you turn off CONFIG_PPC_WATCHDOG then
CONFIG_HAVE_HARDLOCKUP_DETECTOR_ARCH and CONFIG_HAVE_NMI_WATCHDOG
would still be defined and we'd end up returning 0 (no error) from
watchdog_hardlockup_probe(). That means that on powerpc today if you
turn off CONFIG_PPC_WATCHDOG that '/proc/sys/kernel/nmi_watchdog' will
still think the watchdog is enabled?


-Doug

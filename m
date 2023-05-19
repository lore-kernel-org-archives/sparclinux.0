Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 383E5C77B7A
	for <sparclinux@archiver.kernel.org>; Fri, 19 May 2023 17:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjESRZA (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 19 May 2023 13:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbjESRYz (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 19 May 2023 13:24:55 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D1910C0
        for <sparclinux@vger.kernel.org>; Fri, 19 May 2023 10:24:24 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-76f06c0f58cso93842039f.1
        for <sparclinux@vger.kernel.org>; Fri, 19 May 2023 10:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684516976; x=1687108976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GYXxQ1/HyN04Wnp4N53Q5scLF2D44b2WUzFjxPSR5OI=;
        b=am1tWw6lHhzSwU2Wjsq9SmhSR4e01aWT3byfdJHlpVWpcDqBwcqDvMOHngPzLsOCUP
         7xRBb5/JtdHNiLIJILFvvrDeua06rbUrohFG4ngsnIhHd9TfsK+goaae6uEOsybxfzDe
         G1j4udLGUnfqHtpOtEyezfRO86f/ExIzvBs14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684516976; x=1687108976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GYXxQ1/HyN04Wnp4N53Q5scLF2D44b2WUzFjxPSR5OI=;
        b=gEH25+cACEkqybuUvzFcNwusdFjDj6FlMcdJ0iRMiuRkGvre3Yy7eAq+rkj7Iuu0p/
         cMyndKunNJM0HZ0ucyDd/OYXxk+4EiuSZqcFCJOS7azm0BB14SF19Qamw4sTX+zPgQwg
         VhsFJSZnX6Bg7q6IC4fqPOn1f1ug0ad8Vl02+0omX0VhlgNEX1vzNotQOBVofdnXVrGy
         kuR4oF1PBzFi3zc2amAoe949zasi+Y22zHafsWQpFhwziof41ewkiVxNYCraItuHdinh
         wfPoLUyx8j8tBvKXYBQ8JbU0VKy+msfuXgdUwkkFCD0qC3NMkj6YCOUyaLEXajnOWmb7
         k8aA==
X-Gm-Message-State: AC+VfDxInHxipwM9MCTjNjt3RRoE/SEl3TjL7I+WuobQPojNjakPgTjU
        HMLE+4GfC9LFmfNUP9foTe6twMMhfi7e21nnf10=
X-Google-Smtp-Source: ACHHUZ7hwwwHfOwuDa8EscrKJIcLhL3HOgPA4X8jLzatrCI8lwR+QZvfSw0pjbfzQ/JbVO6tCx/Vvg==
X-Received: by 2002:a6b:5903:0:b0:758:917b:c313 with SMTP id n3-20020a6b5903000000b00758917bc313mr1607159iob.13.1684516976542;
        Fri, 19 May 2023 10:22:56 -0700 (PDT)
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com. [209.85.166.173])
        by smtp.gmail.com with ESMTPSA id i45-20020a023b6d000000b0040da7c39465sm1309065jaf.25.2023.05.19.10.22.54
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 10:22:56 -0700 (PDT)
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-33828a86ee2so8435ab.0
        for <sparclinux@vger.kernel.org>; Fri, 19 May 2023 10:22:54 -0700 (PDT)
X-Received: by 2002:a05:6e02:1c8c:b0:331:8db2:5d13 with SMTP id
 w12-20020a056e021c8c00b003318db25d13mr246620ill.8.1684516953136; Fri, 19 May
 2023 10:22:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230504221349.1535669-1-dianders@chromium.org>
 <20230504151100.v4.10.I00dfd6386ee00da25bf26d140559a41339b53e57@changeid> <ZF0NzSCRCapqDbC4@alley>
In-Reply-To: <ZF0NzSCRCapqDbC4@alley>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 19 May 2023 10:22:21 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VXn07rgC=OUtHAz5v5h2g2gcrLCc5BYr6LMWFkyNKASw@mail.gmail.com>
Message-ID: <CAD=FV=VXn07rgC=OUtHAz5v5h2g2gcrLCc5BYr6LMWFkyNKASw@mail.gmail.com>
Subject: Re: [PATCH v4 10/17] watchdog/hardlockup: Move perf hardlockup
 watchdog petting to watchdog.c
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephane Eranian <eranian@google.com>,
        Stephen Boyd <swboyd@chromium.org>, ricardo.neri@intel.com,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Guenter Roeck <groeck@chromium.org>,
        Pingfan Liu <kernelfans@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, ito-yuichi@fujitsu.com,
        Randy Dunlap <rdunlap@infradead.org>,
        Chen-Yu Tsai <wens@csie.org>, christophe.leroy@csgroup.eu,
        davem@davemloft.net, sparclinux@vger.kernel.org,
        mpe@ellerman.id.au, Will Deacon <will@kernel.org>,
        ravi.v.shankar@intel.com, npiggin@gmail.com,
        linuxppc-dev@lists.ozlabs.org, Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Hi,

On Thu, May 11, 2023 at 8:46=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrot=
e:
>
> > @@ -111,6 +125,11 @@ static void watchdog_hardlockup_interrupt_count(vo=
id)
> >
> >  void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs)
> >  {
> > +     if (__this_cpu_read(watchdog_hardlockup_touch)) {
> > +             __this_cpu_write(watchdog_hardlockup_touch, false);
> > +             return;
> > +     }
>
> If we clear watchdog_hardlockup_touch() here then
> watchdog_hardlockup_check() won't be called yet another
> watchdog_hrtimer_sample_threshold perior.
>
> It means that any touch will cause ignoring one full period.
> The is_hardlockup() check will be done after full two periods.
>
> It is not ideal, see below.
>
> > +
> >       /*
> >        * Check for a hardlockup by making sure the CPU's timer
> >        * interrupt is incrementing. The timer interrupt should have
> > diff --git a/kernel/watchdog_perf.c b/kernel/watchdog_perf.c
> > index 9be90b2a2ea7..547917ebd5d3 100644
> > --- a/kernel/watchdog_perf.c
> > +++ b/kernel/watchdog_perf.c
> > @@ -112,11 +98,6 @@ static void watchdog_overflow_callback(struct perf_=
event *event,
> >       /* Ensure the watchdog never gets throttled */
> >       event->hw.interrupts =3D 0;
> >
> > -     if (__this_cpu_read(watchdog_nmi_touch) =3D=3D true) {
> > -             __this_cpu_write(watchdog_nmi_touch, false);
> > -             return;
> > -     }
>
> The original code looks wrong. arch_touch_nmi_watchdog() caused
> skipping only one period of the perf event.
>
> I would expect that it caused restarting the period,
> something like:
>
>         if (__this_cpu_read(watchdog_nmi_touch) =3D=3D true) {
>                 /*
>                  * Restart the period after which the interrupt
>                  * counter is checked.
>                  */
>                 __this_cpu_write(nmi_rearmed, 0);
>                 __this_cpu_write(last_timestamp, now);
>                 __this_cpu_write(watchdog_nmi_touch, false);
>                 return;
>         }
>
> By other words, we should restart the period in the very next perf
> event after the watchdog was touched.
>
> That said, the new code looks better than the original.
> IMHO, the original code was prone to false positives.

I had a little bit of a hard time following, but I _think_ the "tl;dr"
of all the above is that my change is fine. If I misunderstood, please
yell.


> Best Regards,
> Petr
>
> PS: It might be worth fixing this problem in a separate patch at the
>     beginning of this patchset. It might be a candidate for stable
>     backports.

Done. It's now its own patch and early in the series.

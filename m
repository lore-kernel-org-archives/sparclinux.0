Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C312C77B7F
	for <sparclinux@archiver.kernel.org>; Mon,  8 May 2023 15:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234673AbjEHPxV (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Mon, 8 May 2023 11:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234716AbjEHPxT (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Mon, 8 May 2023 11:53:19 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A189C
        for <sparclinux@vger.kernel.org>; Mon,  8 May 2023 08:53:09 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-3f390fb063cso4230881cf.2
        for <sparclinux@vger.kernel.org>; Mon, 08 May 2023 08:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683561188; x=1686153188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7an4MsU+A1D/BiDTLfn7jyyo8mReHeEE9qn6uLYEhzQ=;
        b=oNYaQUT3rQ4ijau0pTQQVlvIxM8K2nUnc3y4nk747J+Kx626kgonJH8zSTVraIag4V
         jHyq8slUEb/dTxfPJXjnDQcv7A05MwWo639bmustuj6KJZJY/QBiEpnL91N5wn/5U+ta
         xf0Thp4fZd5SmMFL65B8c+nMS8lGXkp5nyTXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683561188; x=1686153188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7an4MsU+A1D/BiDTLfn7jyyo8mReHeEE9qn6uLYEhzQ=;
        b=gUnuHOgLlDX/0H7XauqCmmgdFfJCiICHkzh6+4T4DzP1DMAfKd4iaxGa4xAO7c2TDj
         /gvsgLqhHLEF67kJfYop8chFPAn5BvSuwBRtoo/pkGzzxEl4CJ1vL1aQZLu/wkF26Mfd
         G+zCy/0wkRLMeChCU7MEju6AxPPdHRYQTGkzMvMh4qEDu795UqC/l5l+/63HralgX7aB
         J6CiTJQV/i8TX7z3ItOnGXpxJGJXKFOUMsndId9mMHWEjpWXjzQ178GU2QWUH2jg86l7
         yXVmp+1TkCbdfP0ytoYJzjKhJTo7fyMKRGA1ivDRPwrJ/6f2/K79HACPKVpzb//VhX43
         IUkw==
X-Gm-Message-State: AC+VfDzm/luR0AZDbyJ1N8/A3SAfVzzaqelEzx8CyOOb2poJw5yWUaXx
        ZnLIDnl4xfayqBmJ6FW56H6k9ctvx8Ya/sRtvjA=
X-Google-Smtp-Source: ACHHUZ52OUExfLLrXR1wAGoKcvM7wa6Mekgzw0TJ1apenaVfxqhzSOv4RvyLoT8ATa+PYxMPoxS5iw==
X-Received: by 2002:a05:622a:285:b0:3f3:8a0a:f1a8 with SMTP id z5-20020a05622a028500b003f38a0af1a8mr7722218qtw.61.1683561187915;
        Mon, 08 May 2023 08:53:07 -0700 (PDT)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com. [209.85.160.181])
        by smtp.gmail.com with ESMTPSA id c25-20020ae9e219000000b00746b2ca65edsm2628052qkc.75.2023.05.08.08.53.07
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 08:53:07 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-3ef34c49cb9so1485201cf.1
        for <sparclinux@vger.kernel.org>; Mon, 08 May 2023 08:53:07 -0700 (PDT)
X-Received: by 2002:ac8:57c9:0:b0:3ef:3083:a437 with SMTP id
 w9-20020ac857c9000000b003ef3083a437mr518031qta.18.1683561166909; Mon, 08 May
 2023 08:52:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230504221349.1535669-1-dianders@chromium.org>
 <20230504151100.v4.13.I6bf789d21d0c3d75d382e7e51a804a7a51315f2c@changeid>
 <CSDZSKA38AEF.FY7J3JXBJX4I@wheely> <CAD=FV=XDfbx3UaP7DV63tASE5Md7siS-EnORD_3T-4yYaEQ7ww@mail.gmail.com>
 <CSGHQJAJHWVS.1UAJOF8P5UXSK@wheely>
In-Reply-To: <CSGHQJAJHWVS.1UAJOF8P5UXSK@wheely>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 8 May 2023 08:52:35 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WEp23wDm2=cFO66uSjqw1UfYSczGSrQh32DGiqHnUDkg@mail.gmail.com>
Message-ID: <CAD=FV=WEp23wDm2=cFO66uSjqw1UfYSczGSrQh32DGiqHnUDkg@mail.gmail.com>
Subject: Re: [PATCH v4 13/17] watchdog/hardlockup: detect hard lockups using
 secondary (buddy) CPUs
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        ravi.v.shankar@intel.com, linuxppc-dev@lists.ozlabs.org,
        Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Colin Cross <ccross@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Hi,

On Sun, May 7, 2023 at 6:05=E2=80=AFPM Nicholas Piggin <npiggin@gmail.com> =
wrote:
>
> > No, I wasn't aware of it. Interesting, it seems to basically enable
> > both types of hardlockup detectors together. If that really catches
> > more lockups, it seems like we could do the same thing for the buddy
> > system.
>
> It doesn't catch more lockups. On powerpc we don't have a reliable
> periodic NMI hence the SMP checker. But it is preferable that a CPU
> detects its own lockup because NMI IPIs can result in crashes if
> they are taken in certain critical sections.

Ah, interesting. Is the fact that NMI IPIs can crash the system
something specific to the way they're implemented in powerpc, or is
this something common in Linux? I've been assuming that IPI NMIs would
be roughly as reliable (or perhaps more reliable) than the NMI
timer/perf counter.


> > > It's all to
> > > all rather than buddy which makes it more complicated but arguably
> > > bit better functionality.
> >
> > Can you come up with an example crash where the "all to all" would
> > work better than the simple buddy system provided by this patch?
>
> CPU2                     CPU3
> spin_lock_irqsave(A)     spin_lock_irqsave(B)
> spin_lock_irqsave(B)     spin_lock_irqsave(A)
>
> CPU1 will detect the lockup on CPU2, but CPU3's lockup won't be
> detected so we don't get the trace that can diagnose the bug.

Ah, that makes sense as a benefit if
"sysctl_hardlockup_all_cpu_backtrace" is false, which you'd probably
want if you had massively SMP systems. ...of course, if you had a lot
of cores then I'd imagine the "all-to-all" might become a lot of
overhead...

Hmmm, but I don't think you really need "all-to-all" checking to get
the stacktraces you want, do you? Each CPU can be "watching" exactly
one other CPU, but then when we actually lock up we could check all of
them and dump stacks on all the ones that are locked up. I think this
would be a fairly easy improvement for the buddy system. I'll leave it
out for now just to keep things simple for the initial landing, but it
wouldn't be hard to add. Then I think the two SMP systems  (buddy vs.
all-to-all) would be equivalent in terms of functionality?


Thinking about this more, I guess you must be assuming coordination
between the "SMP" and "non-SMP" checker. Specifically I guess you'd
want some guarantee that the "SMP" checker always fires before the
non-SMP checker because that would have a higher chance of getting a
stack trace without tickling the IPI NMI crash. ...but then once the
non-SMP checker printed its own stack trace you'd like the SMP checker
running on the same CPU to check to see if any other CPUs were locked
up so you could get their stacks as well. With my simplistic solution
of just allowing the buddy detector to be enabled in parallel with a
perf-based detector then we wouldn't have this level of coordination,
but I'll assume that's OK for the initial landing.


> Another thing I actually found it useful for is you can easily
> see if a core (i.e., all threads in the core) or a chip has
> died. Maybe more useful when doing presilicon and bring up work
> or firmware hacking, but still useful.

I'm probably biased, but for bringup work and stuff like this I
usually have kdb/kgdb enabled and then I could get stack traces for
whichever CPUs I want. :-P

-Doug

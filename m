Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE60C77B7C
	for <sparclinux@archiver.kernel.org>; Fri,  5 May 2023 16:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbjEEQiO (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 5 May 2023 12:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232137AbjEEQiN (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 5 May 2023 12:38:13 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7A7160B4
        for <sparclinux@vger.kernel.org>; Fri,  5 May 2023 09:38:12 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-33393c4c23dso1402525ab.0
        for <sparclinux@vger.kernel.org>; Fri, 05 May 2023 09:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683304692; x=1685896692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+yj1n8SZYpHx6GcDEfBZNc+Nz+lwlz9tugCt27cvkK8=;
        b=ZOpEQsosTbUmst8Ienf3nWALr0I43tuU6QG5nC9malggLvjl9COYLJOwf+H0XsKvTn
         l5ggtBESitzNF1+b1OZCsXuHMIB0MST6OOsXxIX0FaXAxgTqaf48l9nLSmwaLV5vDoqG
         GJdteCFXtZG4TrybH3jjPxNFm2oVJtQqUj2Xc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683304692; x=1685896692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+yj1n8SZYpHx6GcDEfBZNc+Nz+lwlz9tugCt27cvkK8=;
        b=jkEvY0aWE9EKhw7rNG8d7X9v5DamI8ho7e3WqPO7AnZFrQQTNGOd8CarbzIA+mJjtx
         auURqE6YU6H3Tj9VmqSAusBW04NqGmiTop4ydb7S53RJ5VncJ6Q4Ghd4OWACOEgTHCRn
         p00irkXcZefWvl6wuUf4GJ2N+FhRTAy4y97AglL+8SEgOLF2+lctFqpTWMA6EjUbECo5
         CX/cpv1TiWO8RDXrO+LSYGOMPGwPZWz6xA1i0TKNEb7oAjJcr3qcKv73RDHxSZedildf
         /o7qgwVFdj8OkyFAG9wz2UTJ9l0k6yJpuJNe2NL5Lo/jQWxnXwvbwPuZMIHAPQfnyBAt
         Mp3w==
X-Gm-Message-State: AC+VfDxSJi7yBGhttwVI6JxJTIKb5LwXcZ/J/PKO0lOX0mli7APxvlZX
        sp4YcqryVQuS5tUX3V0Gmqd770MvBmn20QBqhl4=
X-Google-Smtp-Source: ACHHUZ6mdXyxUxeJ6rX91gnN4tVx4kgAuHD0Inyz/496/Ton2A8JD/fJ6x7RdNN6EzK/C5XAOVsdCg==
X-Received: by 2002:a92:ce05:0:b0:32b:1536:f3e9 with SMTP id b5-20020a92ce05000000b0032b1536f3e9mr1258580ilo.18.1683304691821;
        Fri, 05 May 2023 09:38:11 -0700 (PDT)
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com. [209.85.166.171])
        by smtp.gmail.com with ESMTPSA id f6-20020a056638112600b00411b5ea8576sm51470jar.108.2023.05.05.09.38.10
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 09:38:11 -0700 (PDT)
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-330ec047d3bso798885ab.0
        for <sparclinux@vger.kernel.org>; Fri, 05 May 2023 09:38:10 -0700 (PDT)
X-Received: by 2002:a05:622a:206:b0:3db:1c01:9d95 with SMTP id
 b6-20020a05622a020600b003db1c019d95mr335755qtx.4.1683304668543; Fri, 05 May
 2023 09:37:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230504221349.1535669-1-dianders@chromium.org>
 <20230504151100.v4.5.I4e47cbfa1bb2ebbcdb5ca16817aa2887f15dc82c@changeid> <CSE04EI159N2.2TSXHBN2QLFCM@wheely>
In-Reply-To: <CSE04EI159N2.2TSXHBN2QLFCM@wheely>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 5 May 2023 09:37:35 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XXzo3m2dqwtNST+uXGQz6NW_e-B6-tWkJMrHoCTZBT9Q@mail.gmail.com>
Message-ID: <CAD=FV=XXzo3m2dqwtNST+uXGQz6NW_e-B6-tWkJMrHoCTZBT9Q@mail.gmail.com>
Subject: Re: [PATCH v4 05/17] watchdog/hardlockup: Rename touch_nmi_watchdog()
 to touch_hardlockup_watchdog()
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
        Daniel Thompson <daniel.thompson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Hi,

On Thu, May 4, 2023 at 7:51=E2=80=AFPM Nicholas Piggin <npiggin@gmail.com> =
wrote:
>
> On Fri May 5, 2023 at 8:13 AM AEST, Douglas Anderson wrote:
> > In preparation for the buddy hardlockup detector, rename
> > touch_nmi_watchdog() to touch_hardlockup_watchdog() to make it clear
> > that it will touch whatever hardlockup detector is configured. We'll
> > add a #define for the old name (touch_nmi_watchdog) so that we don't
> > have to touch every piece of code referring to the old name.
>
> Is this really helpful? Now it's got two names Could just leave it.
> If you insist then it'd be better just to rename everything in one
> go at the end of a merge window IMO. Conflicts would be trivial.

I'm not picky here. I changed the name since Petr requested names to
be changed for any code I was touching [1] and so I threw this out as
a proposal. I agree that having two names can be confusing, but in
this case it didn't feel too terrible to me.

I'd love to hear Petr's opinion on this name change. I'm happy with:

a) This patch as it is.

b) Dropping this patch (or perhaps just changing it to add comments).

c) Changing this patch to rename all 70 uses of the old name. Assuming
this will go through Andrew Morton's tree, I'd be interested in
whether he's OK w/ this.

d) Dropping this patch from this series but putting it on the
backburner to try to do later (so that the rename can happen at a time
when it's least disruptive).


> > Ideally this change would also rename the arch_touch_nmi_watchdog(),
> > but that is harder since arch_touch_nmi_watchdog() is exported with
> > EXPORT_SYMBOL() and thus is ABI. Add a comment next to the call to
> > hopefully alleviate some of the confusion here.
>
> We don't keep ABI fixed upstream.

I'm happy to be corrected, but my understanding was that kernel devs
made an effort not to mess with things exported via "EXPORT_SYMBOL",
but things exported via "EXPORT_SYMBOL_GPL" were fair game.

I guess maybe my patch calling it "ABI" is a stronger statement than
that, though. Doing a little more research, nobody wants to say that
things exported with "EXPORT_SYMBOL" are ABI, they just want to say
that we make an effort to have them be more stable.

So certainly I should adjust my patch series not to call it ABI, but
I'm still on the fence about whether I should rename this or not. I'd
love to hear other opinions. This rename actually would be a lot
easier than the touch_nmi_watchdog() one since the code referencing
the name "arch_touch_nmi_watchdog" isn't spread so broadly through the
kernel.

[1] https://lore.kernel.org/r/ZFErmshcrcikrSU1@alley

-Doug

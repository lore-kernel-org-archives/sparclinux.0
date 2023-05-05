Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D6D5C77B75
	for <sparclinux@archiver.kernel.org>; Fri,  5 May 2023 16:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232955AbjEEQic (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 5 May 2023 12:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232137AbjEEQib (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 5 May 2023 12:38:31 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08C61940D
        for <sparclinux@vger.kernel.org>; Fri,  5 May 2023 09:38:29 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-3310c01beb9so14233475ab.2
        for <sparclinux@vger.kernel.org>; Fri, 05 May 2023 09:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683304707; x=1685896707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aPJ3eJX3Wd0Hq9EHdr00dwY2jAtHzFmYEuKOc8G/h4A=;
        b=GM6bTJMKQFw8PaqWkjnEP0CqGUQH0bmhtZ0hatT9ClX52ITD8Qy/c3IkYzUkwXgi+5
         uKOxQ2bjSBykOb46htzKC5xtQRZ+R833bYPV+hmeBnm6Q6rRxP3BuY1xsynpOs7aXWII
         5zK/sg7Pyvxt/ycCTtj4ErpLyMsC7FpATOqho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683304707; x=1685896707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aPJ3eJX3Wd0Hq9EHdr00dwY2jAtHzFmYEuKOc8G/h4A=;
        b=UKhNHggi6Sqx6GXwtkoNn4B9X1AM8h1dVALKf3O7Et6SuvSENYo+pr7zBjG4qEr6dE
         veL6QTb1kZqRgXgMMK/OIsB6F8aBOUBJCEBhoKEsYqGJPsnwtvYDcrfzKXwxmsld7avF
         WgVBesdtpKiJlPn8ociHOBE3NhL8legGb8F+RbADOU6IxGz/xjGI8Hv2KmKSE5tUbybg
         U7mYwJEYC2v32BudXKXeoUjK5Pclf46pRdOphtgT7cm8sU8XZFU6XrQ3kHRSc8N0INSq
         csfBGCkaN0fixJ87VGclrhqFtJ/p1GcVpr6SsumToAXj7KWY39ri0bsNVQ+5Ov9mtXit
         m4mw==
X-Gm-Message-State: AC+VfDybBTZCfHU1yiBQe4r7cv/CRthu5HYB8REg4aXsA3zfosEtK1Sf
        dfskQLKMmPhHVAJs5rR/GFLwJzcHOc4KIjj6aGY=
X-Google-Smtp-Source: ACHHUZ6FavdIfqAo/gj+frB59ltHeJBlCOetp0kRjTllxby40q5DMPlExo+fBEUnIcTBc828Bnq6nw==
X-Received: by 2002:a92:c60f:0:b0:332:dd0a:c6df with SMTP id p15-20020a92c60f000000b00332dd0ac6dfmr1278997ilm.22.1683304706777;
        Fri, 05 May 2023 09:38:26 -0700 (PDT)
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com. [209.85.166.176])
        by smtp.gmail.com with ESMTPSA id c41-20020a023f69000000b004141e72be1asm41672jaf.175.2023.05.05.09.38.24
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 09:38:26 -0700 (PDT)
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-330ec047d3bso798955ab.0
        for <sparclinux@vger.kernel.org>; Fri, 05 May 2023 09:38:24 -0700 (PDT)
X-Received: by 2002:ac8:5716:0:b0:3ef:330c:8f9e with SMTP id
 22-20020ac85716000000b003ef330c8f9emr343597qtw.10.1683304683433; Fri, 05 May
 2023 09:38:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230504221349.1535669-1-dianders@chromium.org>
 <20230504151100.v4.7.Id4133d3183e798122dc3b6205e7852601f289071@changeid> <CSE09YL4X0XY.1GAQWAFOOEK42@wheely>
In-Reply-To: <CSE09YL4X0XY.1GAQWAFOOEK42@wheely>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 5 May 2023 09:37:50 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vom15dOxnp=x5RFsk7ZCXGVwUjjrA4z1js-cCB=PDLFg@mail.gmail.com>
Message-ID: <CAD=FV=Vom15dOxnp=x5RFsk7ZCXGVwUjjrA4z1js-cCB=PDLFg@mail.gmail.com>
Subject: Re: [PATCH v4 07/17] watchdog/hardlockup: Move perf hardlockup
 checking/panic to common watchdog.c
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

On Thu, May 4, 2023 at 7:58=E2=80=AFPM Nicholas Piggin <npiggin@gmail.com> =
wrote:
>
> On Fri May 5, 2023 at 8:13 AM AEST, Douglas Anderson wrote:
> > The perf hardlockup detector works by looking at interrupt counts and
> > seeing if they change from run to run. The interrupt counts are
> > managed by the common watchdog code via its watchdog_timer_fn().
> >
> > Currently the API between the perf detector and the common code is a
> > function: is_hardlockup(). When the hard lockup detector sees that
> > function return true then it handles printing out debug info and
> > inducing a panic if necessary.
> >
> > Let's change the API a little bit in preparation for the buddy
> > hardlockup detector. The buddy hardlockup detector wants to print
>
> I think the name change is a gratuitous. Especially since it's now
> static.
>
> watchdog_hardlockup_ is a pretty long prefix too, hardlockup_
> should be enough?
>
> Seems okay otherwise though.

I went back and forth on names far too much when constructing this
patch series. Mostly I was trying to balance what looked good to me
and what Petr suggested [1]. I'm not super picky about the names and
I'm happy to change them all to a "hardlockup_" prefix. I'd love to
hear Petr's opinion.

[1] https://lore.kernel.org/r/ZFErmshcrcikrSU1@alley

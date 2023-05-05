Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D98FC77B7C
	for <sparclinux@archiver.kernel.org>; Fri,  5 May 2023 16:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbjEEQiy (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 5 May 2023 12:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232643AbjEEQix (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 5 May 2023 12:38:53 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B432D160B4
        for <sparclinux@vger.kernel.org>; Fri,  5 May 2023 09:38:52 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-61af33bdf1dso9464766d6.2
        for <sparclinux@vger.kernel.org>; Fri, 05 May 2023 09:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683304730; x=1685896730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hx/Z1QGIGo513DGFRHbMqQT6fmsKMlQd8/3rs/cumNc=;
        b=e3/kZ4SXyQ54Z4+fxOZ7r8jebEMbuqn0q+ZO74ArEzkLBNEg5QMJoaQkS8ZLj4hrUp
         Cu01U5m1ZN+MDwvYqQkC4m9n/1BV84q28dZNCj0rkay1VbkAmSEgnmdx4ISMoks87Qvv
         BZWv/jwLoLz/ZHBmPpFP2OBBJrqeU+go/wGH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683304730; x=1685896730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hx/Z1QGIGo513DGFRHbMqQT6fmsKMlQd8/3rs/cumNc=;
        b=bahqwOEPAFSIcKYjjMjMCdayhSalMMhGNboxXnz9X7oKsHromYInYFsOkx6DAhYdgf
         y8IJRYIHKlNo0tWHoXPXJjZH318u1eoMZC5bICkczsmPgXSAjwINSncAqmrtSms4w9WI
         sdt4Z2eV8Wkt1mCDt+f8eOqFueTt8FceBDIINxX+we03Fj2jauHPH3Pi7bYjQFx7CzaI
         MiGviXxDO9EMUwOneKuCOPJBGOleicrVn8FQWs+F1CiU7e5Ldd+AYXhiQ4I0StH/NNr+
         e08mNXctbj0lAi/Y33QLBwqqKM/Li31U8BxoxJP/jQUGDBUCix/9JkU9GIcAGLcjaUGh
         CjKA==
X-Gm-Message-State: AC+VfDwhPopjOoismcBPNa2hqH0AfMTQezHr6ILiARQPWB5UVhG7Tx4g
        /PWm0E02phPF7kZmhnNosu1otpp1KnyP3trAkPc=
X-Google-Smtp-Source: ACHHUZ5+HEbAkiYSHsVUu0fet65DwhvrwxiMyRg5cBnjEhC8Ip087g0FuYaJlbSjQ3Drb87FQL/leA==
X-Received: by 2002:ad4:594b:0:b0:621:78a:dd84 with SMTP id eo11-20020ad4594b000000b00621078add84mr1013828qvb.47.1683304730587;
        Fri, 05 May 2023 09:38:50 -0700 (PDT)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com. [209.85.160.172])
        by smtp.gmail.com with ESMTPSA id i3-20020a37c203000000b0074ad0812747sm695553qkm.77.2023.05.05.09.38.49
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 09:38:49 -0700 (PDT)
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-3ef36d814a5so1117941cf.0
        for <sparclinux@vger.kernel.org>; Fri, 05 May 2023 09:38:49 -0700 (PDT)
X-Received: by 2002:a05:622a:1898:b0:3ef:31a5:13c with SMTP id
 v24-20020a05622a189800b003ef31a5013cmr206117qtc.3.1683304708084; Fri, 05 May
 2023 09:38:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230504221349.1535669-1-dianders@chromium.org>
 <20230504151100.v4.8.I818492c326b632560b09f20d2608455ecf9d3650@changeid> <CSE0CI3TFK72.2I4E5TJIRHDGM@wheely>
In-Reply-To: <CSE0CI3TFK72.2I4E5TJIRHDGM@wheely>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 5 May 2023 09:38:14 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vuad+gxrUirhyx8aFuLbh2M1hMnoY5NUVBxdycd8kFiQ@mail.gmail.com>
Message-ID: <CAD=FV=Vuad+gxrUirhyx8aFuLbh2M1hMnoY5NUVBxdycd8kFiQ@mail.gmail.com>
Subject: Re: [PATCH v4 08/17] watchdog/hardlockup: Style changes to
 watchdog_hardlockup_check() / ..._is_lockedup()
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

On Thu, May 4, 2023 at 8:02=E2=80=AFPM Nicholas Piggin <npiggin@gmail.com> =
wrote:
>
> On Fri May 5, 2023 at 8:13 AM AEST, Douglas Anderson wrote:
> > These are tiny style changes:
> > - Add a blank line before a "return".
> > - Renames two globals to use the "watchdog_hld" prefix.
>
> Particularly static ones don't really need the namespace prefixes.

Renames are mostly at Petr's request. If I've misunderstood what he
wants here that I'm happy to remove them.


> Not sure if processed is better than warn.

I can undo this one if you want. It felt like we were doing more than
just warning, but if people think "warn" is a better way to describe
it then that's fine with me.


> allcpu_dumped is better
> than dumped_stacks though because the all-CPUs-dump is a particular
> thing.

OK, I can undo this and leave it as "allcpu_dumped".


[1] https://lore.kernel.org/r/ZFErmshcrcikrSU1@alley

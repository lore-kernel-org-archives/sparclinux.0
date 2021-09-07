Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B4EBC433F5
	for <sparclinux@archiver.kernel.org>; Tue,  7 Sep 2021 06:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 016D460F21
	for <sparclinux@archiver.kernel.org>; Tue,  7 Sep 2021 06:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233430AbhIGG7q convert rfc822-to-8bit (ORCPT
        <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 7 Sep 2021 02:59:46 -0400
Received: from mail-ua1-f42.google.com ([209.85.222.42]:46936 "EHLO
        mail-ua1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234243AbhIGG7p (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Tue, 7 Sep 2021 02:59:45 -0400
Received: by mail-ua1-f42.google.com with SMTP id z3so1161883uav.13;
        Mon, 06 Sep 2021 23:58:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OxTwiIZcFGYmcioqpYJ/pvuPc70Vbjt+tQekWzFjIis=;
        b=SdL2eQ06G+bGdf+2O+m7yKel+yZ5JtfCdU65UuQVIRLNtsHUigvlN8WzkS2Dl4Hths
         FlbCxw6v+/00dnzE9loFRWOgy7o4MhmrQeRZMM07k9VEpyB1g8z+C5I4FUQtyAo/S7FM
         svNTg7A4mcxCObgQRCwy0MAdfHXgDvM/wyFvBpEvOO1eE/Ye9SdXjswjUJyVb455TwJv
         u7c+mP5pjMVo4Ei75EpcGzuqklDRn8XjzGfiR/zDEbiiIwrUcJyHrEJSgnxUXd2JgDAV
         Zz1kiw92dfl5A3Z3C9yf5Txw/SWwU42J12vltiUlhdE8wIyZk9d0iqAgDPmfLl7vNLID
         OY2A==
X-Gm-Message-State: AOAM533i/3TdYbNjQ/dVKIYD40lyR8A1EUe82v94FrT4YD/V/OTB5Ke5
        BteqGrOnjyIcHq2ZYaBar5Kj726muMM3fZqPMJI=
X-Google-Smtp-Source: ABdhPJwQHpBxcwsSXGhYI1+38cTNcYrcYNi3iCBos6MWHoRITEh4uPlzvhLr+vAbbFMFspfvxoQavqL4ifhK+hMVgfo=
X-Received: by 2002:ab0:6887:: with SMTP id t7mr7737407uar.114.1630997919262;
 Mon, 06 Sep 2021 23:58:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210906142615.GA1917503@roeck-us.net> <CAHk-=wgjTePY1v_D-jszz4NrpTso0CdvB9PcdroPS=TNU1oZMQ@mail.gmail.com>
 <c3790fb9-b83f-9596-18a1-21ace987c850@roeck-us.net> <CAHk-=wi4NW3NC0xWykkw=6LnjQD6D_rtRtxY9g8gQAJXtQMi8A@mail.gmail.com>
 <20210907053236.GB3271077@hr-amd> <0d63f82c-7bdc-1bf0-f64b-8331291e2d4e@amd.com>
In-Reply-To: <0d63f82c-7bdc-1bf0-f64b-8331291e2d4e@amd.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 7 Sep 2021 08:58:28 +0200
Message-ID: <CAMuHMdXgxSMiABLkizoTQrBXvRq20w97+LMGEgNZM8D0BsS6sw@mail.gmail.com>
Subject: Re: [PATCH] Enable '-Werror' by default for all kernel builds
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Huang Rui <ray.huang@amd.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-sparc <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Tue, Sep 7, 2021 at 8:25 AM Christian König <christian.koenig@amd.com> wrote:
> Am 07.09.21 um 07:32 schrieb Huang Rui:
> > On Tue, Sep 07, 2021 at 07:06:04AM +0800, Linus Torvalds wrote:
> >> [ Adding some subsystem maintainers ]
> >>
> >> On Mon, Sep 6, 2021 at 10:06 AM Guenter Roeck <linux@roeck-us.net> wrote:
> >>>> But hopefully most cases are just "people haven't cared enough" and
> >>>> easily fixed.
> >>> We'll see. For my testbed I disabled the new configuration flag
> >>> for the time being because its primary focus is boot tests, and
> >>> there won't be any boot tests if images fail to build.
> >> Sure, reasonable.
> >>
> >> I've checked a few of the build errors by doing the appropriate cross
> >> compiles, and it doesn't seem bad - but it does seem like we have a
> >> number of really pointless long-standing warnings that should have
> >> been fixed long ago.
> >>
> >> For example, looking at sparc64, there are several build errors due to
> >> those warnings now being fatal:
> >>
> >>   - drivers/gpu/drm/ttm/ttm_pool.c:386
> >>
> >>     This is a type mismatch error. It looks like __fls() on sparc64
> >> returns 'int'. And the ttm_pool.c code assumes it returns 'unsigned
> >> long'.
> >>
> >>     Oddly enough, the very line after that line does "min_t(unsigned
> >> int" to get the types in line.
> >>
> >>     So  the immediate reason is "sparc64 is different". But the deeper
> >> reason seems to be that ttm_pool.c has odd type assumptions. But that
> >> warning should have been fixed long ago, either way.
> >>
> >>     Christian/Huang? I get the feeling that both lines in that file
> >> should use the min_t(). Hmm?
> >
> > Shall we align the return type like __fls() on all the arches?
>
> I think so, yes. IIRC I was a bit surprised that it returns UL on x86. I
> mean the maximum possible value here is 63.

And ffs() returns int, like in ffs(3).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

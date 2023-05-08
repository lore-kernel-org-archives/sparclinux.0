Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A16C77B7C
	for <sparclinux@archiver.kernel.org>; Mon,  8 May 2023 01:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbjEHBfH (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Sun, 7 May 2023 21:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232461AbjEHBfG (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Sun, 7 May 2023 21:35:06 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE7B6A6D;
        Sun,  7 May 2023 18:35:05 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-52c6f81193cso2697372a12.1;
        Sun, 07 May 2023 18:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683509705; x=1686101705;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HU/mjP7Ap3TZEbMspJ2h6V5QMnaNP2Fmf0Z6DZ7aqHE=;
        b=L14pxpyy1Yc8+HiewNaTQb+1joh8hYSOP3/eSCWmsTMJDnd6785STORT8kwjkGo2Se
         0i8+WagpXa8hJmR6t/LT7/sRKpmf+/KhkH0cbQcr2O6uaSzqM3ZscCvvnujixJA1Ohtz
         +TDocKRxq9Z7oFDz3JTmqk+qGJoW7sLBtQtnhjtT1o4Jbh/kSUAEi1DayHu/qBKsz9g0
         OpLBg/55IJVmGITHmhJsf02wK5FPOZWzon9TAgZuxFxmSXGX2tWCWkv+4B/RWRpA1i4X
         sWQkpWNXRRqS1ceEPdkUmdpxnwjVOPZRPR/xEDB1D4aX3s85+ine5OJy93J2i3tU985P
         Pejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683509705; x=1686101705;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HU/mjP7Ap3TZEbMspJ2h6V5QMnaNP2Fmf0Z6DZ7aqHE=;
        b=Ys/t9LjWq1idt0eml2xy1FTL9FrWKUGUIuIwDfQDHw44BptST341e71uPqysCe/Uqs
         pDF/YF3wjKkLeHtYhyzQA2VGGKk8NoT3XS4Gs1Cvwd5PCznfVIyUB/oRzCxwTO20iqFv
         DoTYPn4sCVChKtt/m0I7sRNMO3DKJEzMnCVWrGadxUibqFgx1fGp2eC2ssRFI3SFvl9X
         oruJN+MBlCjc9aq9oFMWiQmfc1tK4hZMUNeEmvnuMQwlJoDUdZn3m+U8tfX78dfpWMA9
         uau4+h38qPuAViUjf9FK/ocG2gp+AryezQdk+KKDNzABYl3JUXB2sdBH6ahfPScLvZop
         CDMw==
X-Gm-Message-State: AC+VfDxGj7mS1cil6Rq3V1zBQYCpA0U20UJzJmmef8FMNksSr4AjSmNN
        D78YdSbz3MtmqC+3wkwe97Y=
X-Google-Smtp-Source: ACHHUZ7wpMgBNBiHQoh+RV3/6p2Xa+RAutLvbhq2Sce/KNFSy1fHPppI+Mwi880EABIulXrieqwNrA==
X-Received: by 2002:a17:90b:19ce:b0:24e:1177:f467 with SMTP id nm14-20020a17090b19ce00b0024e1177f467mr9325645pjb.12.1683509704923;
        Sun, 07 May 2023 18:35:04 -0700 (PDT)
Received: from localhost (58-6-235-78.tpgi.com.au. [58.6.235.78])
        by smtp.gmail.com with ESMTPSA id n14-20020a170902968e00b001a4edbabad3sm5814967plp.230.2023.05.07.18.34.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 May 2023 18:35:04 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 08 May 2023 11:34:49 +1000
Message-Id: <CSGIDMMFXIVH.3SFPYD19Y5WQX@wheely>
To:     "Doug Anderson" <dianders@chromium.org>
Cc:     "Petr Mladek" <pmladek@suse.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Sumit Garg" <sumit.garg@linaro.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Matthias Kaehlcke" <mka@chromium.org>,
        "Stephane Eranian" <eranian@google.com>,
        "Stephen Boyd" <swboyd@chromium.org>, <ricardo.neri@intel.com>,
        "Tzung-Bi Shih" <tzungbi@chromium.org>,
        "Lecopzer Chen" <lecopzer.chen@mediatek.com>,
        <kgdb-bugreport@lists.sourceforge.net>,
        "Masayoshi Mizuma" <msys.mizuma@gmail.com>,
        "Guenter Roeck" <groeck@chromium.org>,
        "Pingfan Liu" <kernelfans@gmail.com>,
        "Andi Kleen" <ak@linux.intel.com>,
        "Ian Rogers" <irogers@google.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>, <ito-yuichi@fujitsu.com>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Chen-Yu Tsai" <wens@csie.org>, <christophe.leroy@csgroup.eu>,
        <davem@davemloft.net>, <sparclinux@vger.kernel.org>,
        <mpe@ellerman.id.au>, "Will Deacon" <will@kernel.org>,
        <ravi.v.shankar@intel.com>, <linuxppc-dev@lists.ozlabs.org>,
        "Marc Zyngier" <maz@kernel.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Daniel Thompson" <daniel.thompson@linaro.org>
Subject: Re: [PATCH v4 05/17] watchdog/hardlockup: Rename
 touch_nmi_watchdog() to touch_hardlockup_watchdog()
From:   "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.14.0
References: <20230504221349.1535669-1-dianders@chromium.org>
 <20230504151100.v4.5.I4e47cbfa1bb2ebbcdb5ca16817aa2887f15dc82c@changeid>
 <CSE04EI159N2.2TSXHBN2QLFCM@wheely>
 <CAD=FV=XXzo3m2dqwtNST+uXGQz6NW_e-B6-tWkJMrHoCTZBT9Q@mail.gmail.com>
In-Reply-To: <CAD=FV=XXzo3m2dqwtNST+uXGQz6NW_e-B6-tWkJMrHoCTZBT9Q@mail.gmail.com>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Sat May 6, 2023 at 2:37 AM AEST, Doug Anderson wrote:
> Hi,
>
> On Thu, May 4, 2023 at 7:51=E2=80=AFPM Nicholas Piggin <npiggin@gmail.com=
> wrote:
> >
> > On Fri May 5, 2023 at 8:13 AM AEST, Douglas Anderson wrote:
> > > In preparation for the buddy hardlockup detector, rename
> > > touch_nmi_watchdog() to touch_hardlockup_watchdog() to make it clear
> > > that it will touch whatever hardlockup detector is configured. We'll
> > > add a #define for the old name (touch_nmi_watchdog) so that we don't
> > > have to touch every piece of code referring to the old name.
> >
> > Is this really helpful? Now it's got two names Could just leave it.
> > If you insist then it'd be better just to rename everything in one
> > go at the end of a merge window IMO. Conflicts would be trivial.
>
> I'm not picky here. I changed the name since Petr requested names to
> be changed for any code I was touching [1] and so I threw this out as
> a proposal. I agree that having two names can be confusing, but in
> this case it didn't feel too terrible to me.
>
> I'd love to hear Petr's opinion on this name change. I'm happy with:
>
> a) This patch as it is.
>
> b) Dropping this patch (or perhaps just changing it to add comments).
>
> c) Changing this patch to rename all 70 uses of the old name. Assuming
> this will go through Andrew Morton's tree, I'd be interested in
> whether he's OK w/ this.
>
> d) Dropping this patch from this series but putting it on the
> backburner to try to do later (so that the rename can happen at a time
> when it's least disruptive).
>
>
> > > Ideally this change would also rename the arch_touch_nmi_watchdog(),
> > > but that is harder since arch_touch_nmi_watchdog() is exported with
> > > EXPORT_SYMBOL() and thus is ABI. Add a comment next to the call to
> > > hopefully alleviate some of the confusion here.
> >
> > We don't keep ABI fixed upstream.
>
> I'm happy to be corrected, but my understanding was that kernel devs
> made an effort not to mess with things exported via "EXPORT_SYMBOL",
> but things exported via "EXPORT_SYMBOL_GPL" were fair game.

I don't think that's the case. If anything people might be a bit more
inclined to accommodate GPL exports for out of tree modules that use
them.

> I guess maybe my patch calling it "ABI" is a stronger statement than
> that, though. Doing a little more research, nobody wants to say that
> things exported with "EXPORT_SYMBOL" are ABI, they just want to say
> that we make an effort to have them be more stable.

We wouldn't break any symbol for no reason, but in this case there is a
good reason. If the name change is important for clarity then we change
it. And this is about the easiest change for an out of tree module to
deal with, so it should be no big deal for them.

Thanks,
Nick

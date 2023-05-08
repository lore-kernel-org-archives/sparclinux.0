Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C7BC7EE24
	for <sparclinux@archiver.kernel.org>; Mon,  8 May 2023 15:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234460AbjEHP5m (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Mon, 8 May 2023 11:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234406AbjEHP5i (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Mon, 8 May 2023 11:57:38 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71B2729D
        for <sparclinux@vger.kernel.org>; Mon,  8 May 2023 08:57:31 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-769036b48b0so380264039f.0
        for <sparclinux@vger.kernel.org>; Mon, 08 May 2023 08:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683561449; x=1686153449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f5S/FC+4loxuZb2hQfcppwnscYEX/EcpE8zM8Zwa0M8=;
        b=NN4MDMMwkVkNRx2jJ2wDOHSqzQaaGeSu/bq+lttMuJ3G8FUu1QoUiBc0+nh8uRftU0
         A/CCvQrWqt5BKGZrXuShTLE5EFdVAH14FWk6TCedHezLuIfalQZ/5+L72rTbOGGKH1sY
         RgwnQ6k7dSu0CCaiV7EzratNYX+Z1v+Js1K0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683561449; x=1686153449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f5S/FC+4loxuZb2hQfcppwnscYEX/EcpE8zM8Zwa0M8=;
        b=XkLsjS8HfPWfioW1zqi+/sTZD7SApzksGWGnCdQ/HKq750hWCvL1E5rj4VDVxNDJmQ
         hlKWfDyBg0drA0glQZQhg6JZ14BOTJ4jZcCMa5lwIapTas4y0AG4kJh933scCvU1itPv
         zJQu7ZZx/O8JYmYUOS8oCePYCVE3jTl60Ix3Sq8hz3MXNJH40eWMcyDbyNB6Qlz76Rkn
         Empd9LtER9pp064ZA8QZo+ZlCRzgEyPRfztsMFOnuVqgO488l6JTJ9RZ2JetBVzNBZ8y
         2zBX/ZTozN3Ud5RjvNyUh0BNXdAw93YfGI4mwR9uy51RhbqIxvHnSW5JFvJngZSlTEVb
         o+qQ==
X-Gm-Message-State: AC+VfDx9j+E13PdCkLX50kIhgPEOnqebe9cfEPNtFMW2Q9jcsBYlTNjd
        d299/TsrZw3CpVqN3j81Hov3+gYulaMUtsIdN9Y=
X-Google-Smtp-Source: ACHHUZ4faHuOeb8lPL/3j2BN3ckpR9GdjlY/l+ZRWUrSmOv6EoStJj1wTCVlWZKU1dbe6yaGVCsbGA==
X-Received: by 2002:a92:c886:0:b0:331:da8:5cdb with SMTP id w6-20020a92c886000000b003310da85cdbmr7714517ilo.31.1683561449734;
        Mon, 08 May 2023 08:57:29 -0700 (PDT)
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com. [209.85.166.177])
        by smtp.gmail.com with ESMTPSA id cb9-20020a0566381b0900b0041669a9fb62sm1494691jab.131.2023.05.08.08.57.28
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 08:57:28 -0700 (PDT)
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-330ec047d3bso1163945ab.0
        for <sparclinux@vger.kernel.org>; Mon, 08 May 2023 08:57:28 -0700 (PDT)
X-Received: by 2002:a05:622a:1813:b0:3bf:e4e0:26a0 with SMTP id
 t19-20020a05622a181300b003bfe4e026a0mr581724qtc.14.1683561427207; Mon, 08 May
 2023 08:57:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230504221349.1535669-1-dianders@chromium.org>
 <20230504151100.v4.5.I4e47cbfa1bb2ebbcdb5ca16817aa2887f15dc82c@changeid>
 <CSE04EI159N2.2TSXHBN2QLFCM@wheely> <CAD=FV=XXzo3m2dqwtNST+uXGQz6NW_e-B6-tWkJMrHoCTZBT9Q@mail.gmail.com>
 <CSGIDMMFXIVH.3SFPYD19Y5WQX@wheely>
In-Reply-To: <CSGIDMMFXIVH.3SFPYD19Y5WQX@wheely>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 8 May 2023 08:56:56 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V7XQog=OSESB8-BLaeSDRg+0cGnK-YoccdLYeFh7_bmA@mail.gmail.com>
Message-ID: <CAD=FV=V7XQog=OSESB8-BLaeSDRg+0cGnK-YoccdLYeFh7_bmA@mail.gmail.com>
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

On Sun, May 7, 2023 at 6:35=E2=80=AFPM Nicholas Piggin <npiggin@gmail.com> =
wrote:
>
> On Sat May 6, 2023 at 2:37 AM AEST, Doug Anderson wrote:
> > Hi,
> >
> > On Thu, May 4, 2023 at 7:51=E2=80=AFPM Nicholas Piggin <npiggin@gmail.c=
om> wrote:
> > >
> > > On Fri May 5, 2023 at 8:13 AM AEST, Douglas Anderson wrote:
> > > > In preparation for the buddy hardlockup detector, rename
> > > > touch_nmi_watchdog() to touch_hardlockup_watchdog() to make it clea=
r
> > > > that it will touch whatever hardlockup detector is configured. We'l=
l
> > > > add a #define for the old name (touch_nmi_watchdog) so that we don'=
t
> > > > have to touch every piece of code referring to the old name.
> > >
> > > Is this really helpful? Now it's got two names Could just leave it.
> > > If you insist then it'd be better just to rename everything in one
> > > go at the end of a merge window IMO. Conflicts would be trivial.
> >
> > I'm not picky here. I changed the name since Petr requested names to
> > be changed for any code I was touching [1] and so I threw this out as
> > a proposal. I agree that having two names can be confusing, but in
> > this case it didn't feel too terrible to me.
> >
> > I'd love to hear Petr's opinion on this name change. I'm happy with:
> >
> > a) This patch as it is.
> >
> > b) Dropping this patch (or perhaps just changing it to add comments).
> >
> > c) Changing this patch to rename all 70 uses of the old name. Assuming
> > this will go through Andrew Morton's tree, I'd be interested in
> > whether he's OK w/ this.
> >
> > d) Dropping this patch from this series but putting it on the
> > backburner to try to do later (so that the rename can happen at a time
> > when it's least disruptive).
> >
> >
> > > > Ideally this change would also rename the arch_touch_nmi_watchdog()=
,
> > > > but that is harder since arch_touch_nmi_watchdog() is exported with
> > > > EXPORT_SYMBOL() and thus is ABI. Add a comment next to the call to
> > > > hopefully alleviate some of the confusion here.
> > >
> > > We don't keep ABI fixed upstream.
> >
> > I'm happy to be corrected, but my understanding was that kernel devs
> > made an effort not to mess with things exported via "EXPORT_SYMBOL",
> > but things exported via "EXPORT_SYMBOL_GPL" were fair game.
>
> I don't think that's the case. If anything people might be a bit more
> inclined to accommodate GPL exports for out of tree modules that use
> them.
>
> > I guess maybe my patch calling it "ABI" is a stronger statement than
> > that, though. Doing a little more research, nobody wants to say that
> > things exported with "EXPORT_SYMBOL" are ABI, they just want to say
> > that we make an effort to have them be more stable.
>
> We wouldn't break any symbol for no reason, but in this case there is a
> good reason. If the name change is important for clarity then we change
> it. And this is about the easiest change for an out of tree module to
> deal with, so it should be no big deal for them.

OK, fair enough. My current plan is to wait a few more days to see if
anyone else chimes in with opinions. If I don't hear anything, in my
next version I will rename _neither_ touch_nmi_watchdog() nor
arch_touch_nmi_watchdog(). I'll still add comments indicating that
these functions touch the "hardlockup" watchdog but I won't attempt
the rename just to keep the series simpler.

-Doug

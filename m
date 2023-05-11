Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B66C77B7C
	for <sparclinux@archiver.kernel.org>; Thu, 11 May 2023 09:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234840AbjEKJ0r (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Thu, 11 May 2023 05:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237110AbjEKJYf (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Thu, 11 May 2023 05:24:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF6B6E9D;
        Thu, 11 May 2023 02:24:33 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0BD4A219EB;
        Thu, 11 May 2023 09:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683797072; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3x+A1oAvkOFARznkC50c0SLUXNmMY3RdCi2ozgXXvgw=;
        b=f/46rLYe7nyx5+kH1sYpIAw20pQoZZ4k+Ask8EvmsmiWBbtNmUShXHyprr6FXGe31OW383
        tKjPbpzXi9nwMp5HsjAkNXfozdukoqdCei/XT/10RlTfaTVyada91hl3TnVvYiIg9PrxY7
        ZOTKjflhV/IQZ/2lqefV+OAZ6FjZ7Dg=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9D6172C141;
        Thu, 11 May 2023 09:24:30 +0000 (UTC)
Date:   Thu, 11 May 2023 11:24:29 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
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
Subject: Re: [PATCH v4 05/17] watchdog/hardlockup: Rename
 touch_nmi_watchdog() to touch_hardlockup_watchdog()
Message-ID: <ZFy0TX1tfhlH8gxj@alley>
References: <20230504221349.1535669-1-dianders@chromium.org>
 <20230504151100.v4.5.I4e47cbfa1bb2ebbcdb5ca16817aa2887f15dc82c@changeid>
 <CSE04EI159N2.2TSXHBN2QLFCM@wheely>
 <CAD=FV=XXzo3m2dqwtNST+uXGQz6NW_e-B6-tWkJMrHoCTZBT9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=XXzo3m2dqwtNST+uXGQz6NW_e-B6-tWkJMrHoCTZBT9Q@mail.gmail.com>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Fri 2023-05-05 09:37:35, Doug Anderson wrote:
> Hi,
> 
> On Thu, May 4, 2023 at 7:51 PM Nicholas Piggin <npiggin@gmail.com> wrote:
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

IMHO, it is worth renaming to make the code easier to follow.
Especially after adding the buddy hardlockup detector that is
not using NMI context.

And I agree that that we should rename all callers as well.
Otherwise, it might be seen just as an extra churn.

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

d) sounds reasonable given that there is about 70 callers.

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

My understanding is that kernel guarantees ABI compatibility only for
the userspace (do-not-break-userspace rule). But the kernel ABI
is not guaranteed [*]

It actually has even a positive side effect because it motivates
module developers to upstream the code.

Of course, there should be a good reason for the change. And I think
that we have a good reason.

[*] This is valid for upstream. Another story is with linux
    distributions. They usually maintain the kernel KABI
    stability to some degree when backporting upstream changes.

Best Regards,
Petr

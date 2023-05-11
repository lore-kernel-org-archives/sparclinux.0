Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89789C7EE22
	for <sparclinux@archiver.kernel.org>; Thu, 11 May 2023 12:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238034AbjEKMFI (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Thu, 11 May 2023 08:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237959AbjEKMEp (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Thu, 11 May 2023 08:04:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F317DD865;
        Thu, 11 May 2023 05:03:20 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D62961FE4F;
        Thu, 11 May 2023 12:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683806598; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YGmP0u0OFjbVyESVuzglMRxquKrNFdNgsdI3jgZKbt0=;
        b=g9sUnPfOIY8lwxWdiiWc/xnL7HCVL9aggbspPeONqRftNaW6qY3P89Jgww7yxDbnrlvevV
        Uo0u1si4QYQaBK2mS23fDev9ZvfnecluMX3ytVJmRVyfXpbcJwaaJ0t1xCWpu1iCrGJW8X
        t5wOiT1q7D9yde/8RgZQtfeGxu5jj3k=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4C8CA2C141;
        Thu, 11 May 2023 12:03:15 +0000 (UTC)
Date:   Thu, 11 May 2023 14:03:12 +0200
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
Subject: Re: [PATCH v4 07/17] watchdog/hardlockup: Move perf hardlockup
 checking/panic to common watchdog.c
Message-ID: <ZFzZgPBkhJokN1QJ@alley>
References: <20230504221349.1535669-1-dianders@chromium.org>
 <20230504151100.v4.7.Id4133d3183e798122dc3b6205e7852601f289071@changeid>
 <CSE09YL4X0XY.1GAQWAFOOEK42@wheely>
 <CAD=FV=Vom15dOxnp=x5RFsk7ZCXGVwUjjrA4z1js-cCB=PDLFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=Vom15dOxnp=x5RFsk7ZCXGVwUjjrA4z1js-cCB=PDLFg@mail.gmail.com>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Fri 2023-05-05 09:37:50, Doug Anderson wrote:
> Hi,
> 
> On Thu, May 4, 2023 at 7:58 PM Nicholas Piggin <npiggin@gmail.com> wrote:
> >
> > On Fri May 5, 2023 at 8:13 AM AEST, Douglas Anderson wrote:
> > > The perf hardlockup detector works by looking at interrupt counts and
> > > seeing if they change from run to run. The interrupt counts are
> > > managed by the common watchdog code via its watchdog_timer_fn().
> > >
> > > Currently the API between the perf detector and the common code is a
> > > function: is_hardlockup(). When the hard lockup detector sees that
> > > function return true then it handles printing out debug info and
> > > inducing a panic if necessary.
> > >
> > > Let's change the API a little bit in preparation for the buddy
> > > hardlockup detector. The buddy hardlockup detector wants to print
> >
> > I think the name change is a gratuitous. Especially since it's now
> > static.
> >
> > watchdog_hardlockup_ is a pretty long prefix too, hardlockup_
> > should be enough?
> >
> > Seems okay otherwise though.
> 
> I went back and forth on names far too much when constructing this
> patch series. Mostly I was trying to balance what looked good to me
> and what Petr suggested [1]. I'm not super picky about the names and
> I'm happy to change them all to a "hardlockup_" prefix. I'd love to
> hear Petr's opinion.

Sigh, the original code was a real mess of naming schemes. It is hard
to say how to move forward.

My opinion:

  + watchdog_hardlockup_check(): looks fine. It is consistent with
	watchdog_hardlockup_enable()/disable().

  + watchdog_hardlockup_is_lockedup() is really overly complicated.
	I would personally keep is_hardlockup(). It is static.
	And it will be consitent with is_softlockup().

  + watchdog_hardlockup_interrupt_count() looks better then
	the original. It clearly shows that it makes sense only
	for the hardlockup detector ("bug" fixed by this patch).

	Well, I would personally call it watchdog_hardlockup_kick()
	and remove the comment.


That said, I could live with this patch. It is better than the
original.

Best Regards,
Petr

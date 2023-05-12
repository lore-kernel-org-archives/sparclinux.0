Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC72C77B7F
	for <sparclinux@archiver.kernel.org>; Fri, 12 May 2023 11:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241067AbjELLVy (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 12 May 2023 07:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241112AbjELLVt (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 12 May 2023 07:21:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295C53C03;
        Fri, 12 May 2023 04:21:43 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id AA27E228E0;
        Fri, 12 May 2023 11:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683890501; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8Mll1DAMbLGCFXSubtx4QEn03KKOCJspxVpDzXoQOQ4=;
        b=KpIW+Hu8ySVymSB28TiB64CYpeKVwXlVWvacchzaLtI9q7FObkmBCPO2LZ7HOgvYh0awWb
        Vu/XmXFI2k4C5E7HKbYqv+kv7F2CMc4cHuQv9iabvQkMtDDbD2aVX1La9fkct2gRNR0/Iu
        dWM7bdtfBmqRCNU9EtJIGZIfqdvJIxc=
Received: from suse.cz (pmladek.tcp.ovpn2.prg.suse.de [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A80022C152;
        Fri, 12 May 2023 11:21:37 +0000 (UTC)
Date:   Fri, 12 May 2023 13:21:34 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
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
Subject: Re: [PATCH v4 11/17] watchdog/hardlockup: Rename some "NMI watchdog"
 constants/function
Message-ID: <ZF4hPiEjvr4_ditV@alley>
References: <20230504221349.1535669-1-dianders@chromium.org>
 <20230504151100.v4.11.I91f7277bab4bf8c0cb238732ed92e7ce7bbd71a6@changeid>
 <CSE0GBQQDUAY.1QAJIC3D3OBVU@wheely>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CSE0GBQQDUAY.1QAJIC3D3OBVU@wheely>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Fri 2023-05-05 13:06:41, Nicholas Piggin wrote:
> On Fri May 5, 2023 at 8:13 AM AEST, Douglas Anderson wrote:
> > Do a search and replace of:
> > - NMI_WATCHDOG_ENABLED => HARD_WATCHDOG_ENABLED
> > - watchdog_nmi_ => watchdog_hardlockup_
> 
> These are just making prefixes inconsistent again.

Yeah, HARD_WATCHDOG_ENABLED does not fit in. I would personally
rename:

  - NMI_WATCHDOG_ENABLED => WATCHDOG_HARDLOCKUP_ENABLED
  - SOFT_WATCHDOG_ENABLED => WATCHDOG_SOFTOCKUP_ENABLED

to follow the new name space.

> If you really want to do a prefix, I would call it hardlockup which

I wish, we found a good short prefix. My problem with hardlockup_
is that for example "hardlockup_enable() looks ugly.

Also some stuff is common for both softlockup and hardlockup
detectors. And some stuff will be common for both perf and
buddy hardlockup detectors.

Possible alternatives:

   a) watchdog_, watchdog_sl_ and watchdog_hl_, watchdog_hl_buddy_
   b) wd_, wd_hardlockup_, wd_softlockup_, wd_hardlockup_buddy_
   c) wd_, wd_hl_, wd_sl_, wd_hl_buddy_
   d_ wd_, wdhl_, wdsl_, wdhl_buddy_

If you want something shorter then c) looks the best to me.

The wd_ prefix seems to be already used in:

   + arch/powerpc/kernel/watchdog.c
   + kernel/time/clocksource.c

, but it is not used in the core watchdog code at all so it
would require renaming almost everything.


> probably best matches existing code and sysctl / boot stuff, and
> concentrate on non-static symbols.

Yeah, we could hardly change the sysctl interface visible to
userspace. But we could change at least the internal code.

And if we are changing the API anyway because of the
nmi/perf/buddy/hardlockup/hard mess then lets choose
something that will help to distinguish the common watchdog
vs. softlockup/hardlockup/buddy/perf-specific watchdog code.

And I would change it to the watchdog_hardlockup_ as it is
done in this patchset:

   + the names were mostly long even before
   + the code mostly stayed within the 80-chars per-line limit
   + the patches are ready


> No problem with minor things like this that touch arch/powerpc
> going through Andrew's tree though. I'm sure sparc maintainers
> wouldn't mind either.

Good to know.

Best Regards,
Petr

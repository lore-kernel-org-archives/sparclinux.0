Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E1CC7EE24
	for <sparclinux@archiver.kernel.org>; Thu, 11 May 2023 08:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233866AbjEKIkA (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Thu, 11 May 2023 04:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233552AbjEKIj7 (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Thu, 11 May 2023 04:39:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B5549D6;
        Thu, 11 May 2023 01:39:58 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 373C81F388;
        Thu, 11 May 2023 08:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683794397; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NXRHuyXM8rpe4qUASDvyNmrhcGnhIuyAUOQ0j7TuG3M=;
        b=KRxlm6KuhcYRuut5Ld+57zEuix1UM/lh3QaDTebljqkZebiCmbRUL2VE5j6KhI8NLtUF6g
        uTz4Fqa7EcHubjpJkiY38RTszd30kTaJWb0AFgyM3QYWNyVx3UpSzltfsdsXOZYEOXEXvF
        q3IjA46B7zTin0OxRhwRS2niCS9Bhi4=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B50ED2C141;
        Thu, 11 May 2023 08:39:54 +0000 (UTC)
Date:   Thu, 11 May 2023 10:39:53 +0200
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
Subject: Re: [PATCH v4 01/17] watchdog/perf: Define dummy
 watchdog_update_hrtimer_threshold() on correct config
Message-ID: <ZFyp2aCIf8W5w65v@alley>
References: <20230504221349.1535669-1-dianders@chromium.org>
 <20230504151100.v4.1.I8cbb2f4fa740528fcfade4f5439b6cdcdd059251@changeid>
 <CSDZYTDN5EHC.1AOZO6QV1UGJR@wheely>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CSDZYTDN5EHC.1AOZO6QV1UGJR@wheely>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Fri 2023-05-05 12:43:49, Nicholas Piggin wrote:
> On Fri May 5, 2023 at 8:13 AM AEST, Douglas Anderson wrote:
> > The real watchdog_update_hrtimer_threshold() is defined in
> > watchdog_hardlockup_perf.c. That file is included if
> 
> In kernel/watchdog_hld.c.

With this fixed path:

Reviewed-by: Petr Mladek <pmladek@suse.com>

> > CONFIG_HARDLOCKUP_DETECTOR_PERF and the function is defined in that
> > file if CONFIG_HARDLOCKUP_CHECK_TIMESTAMP.
> >
> > The dummy version of the function in "nmi.h" didn't get that quite
> > right. While this doesn't appear to be a huge deal, it's nice to make
> > it consistent.
> 
> It doesn't break builds because CHECK_TIMESTAMP is only defined by
> x86 so others don't get a double definition, and x86 uses perf lockup
> detector, so it gets the out of line version.
> 
> So has no functional change but should be fixed.
> 
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> 
> >
> > Fixes: 7edaeb6841df ("kernel/watchdog: Prevent false positives with turbo modes")
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>

Best Regards,
Petr

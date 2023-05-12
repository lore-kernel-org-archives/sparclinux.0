Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17ABAC77B7F
	for <sparclinux@archiver.kernel.org>; Fri, 12 May 2023 11:55:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240512AbjELLza (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 12 May 2023 07:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbjELLz3 (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 12 May 2023 07:55:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B42D8A60;
        Fri, 12 May 2023 04:55:28 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D7F82221B0;
        Fri, 12 May 2023 11:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683892526; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xyID2nrfRFvnCmCCEoDqrRJb/SLL4bOOzyPEcVWhIcg=;
        b=lEQ0yjMIPHRMyl9VsYuE8tD7yo0iFTwLUXaORxnhA7t8728sX0q4aRdF3iN6dqy1aC3q8/
        YPm1Tcs8DZ1wYKRHJ8/JPaw9/W3ekjR2+D3gmP9Tk3pQE/UABRQW6NVwrkr0j2R28omH/o
        DCRZdesZpFrDMAZ/mT4KGYDe+egXfWo=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6A61A2C152;
        Fri, 12 May 2023 11:55:25 +0000 (UTC)
Date:   Fri, 12 May 2023 13:55:24 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
        ravi.v.shankar@intel.com, npiggin@gmail.com,
        linuxppc-dev@lists.ozlabs.org, Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH v4 12/17] watchdog/hardlockup: Have the perf hardlockup
 use __weak functions more cleanly
Message-ID: <ZF4pLJUpvec7vvXT@alley>
References: <20230504221349.1535669-1-dianders@chromium.org>
 <20230504151100.v4.12.I847d9ec852449350997ba00401d2462a9cb4302b@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504151100.v4.12.I847d9ec852449350997ba00401d2462a9cb4302b@changeid>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Thu 2023-05-04 15:13:44, Douglas Anderson wrote:
> The fact that there watchdog_hardlockup_enable(),
> watchdog_hardlockup_disable(), and watchdog_hardlockup_probe() are
> declared __weak means that the configured hardlockup detector can
> define non-weak versions of those functions if it needs to. Instead of
> doing this, the perf hardlockup detector hooked itself into the
> default __weak implementation, which was a bit awkward. Clean this up.
> 
> >From comments, it looks as if the original design was done because the
> __weak function were expected to implemented by the architecture and
> not by the configured hardlockup detector. This got awkward when we
> tried to add the buddy lockup detector which was not arch-specific but
> wanted to hook into those same functions.
> 
> This is not expected to have any functional impact.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

I like this change:

Reviewed-by: Petr Mladek <pmladek@suse.com>

See a comment below.

> --- a/kernel/watchdog_perf.c
> +++ b/kernel/watchdog_perf.c
> @@ -147,12 +151,16 @@ void hardlockup_detector_perf_enable(void)
>  }
>  
>  /**
> - * hardlockup_detector_perf_disable - Disable the local event
> + * watchdog_hardlockup_disable - Disable the local event
> + *
> + * @cpu: The CPU to enable hard lockup on.
>   */
> -void hardlockup_detector_perf_disable(void)
> +void watchdog_hardlockup_disable(unsigned int cpu)
>  {
>  	struct perf_event *event = this_cpu_read(watchdog_ev);
>  
> +	WARN_ON_ONCE(cpu != smp_processor_id());
> +

It makes sense. But it just shows how the code is weird.
@cpu is passed as a parameter and the code expects that it is
running on the given CPU.

It seems that @cpu is passed as a parameter because this is
called from:

  + [CPUHP_AP_WATCHDOG_ONLINE].teardown.single()
    + lockup_detector_offline_cpu()
      + watchdog_disable()

and the CPU hotplug API passes @cpu parameter.

IMHO, the clean solution would be to use per_cpu*() instead
of this_cpu*() API everywhere in this code path.

But it is yet another cleanup. It seems to be out-of-scope of
this patchset.

>  	if (event) {
>  		perf_event_disable(event);
>  		this_cpu_write(watchdog_ev, NULL);

Best Regards,
Petr

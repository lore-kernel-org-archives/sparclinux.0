Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E59FC77B7C
	for <sparclinux@archiver.kernel.org>; Thu, 11 May 2023 15:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238421AbjEKPvd (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Thu, 11 May 2023 11:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238452AbjEKPvb (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Thu, 11 May 2023 11:51:31 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4042B46BE;
        Thu, 11 May 2023 08:51:30 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8888221DF6;
        Thu, 11 May 2023 15:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683819988; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O+WNLGZ1q9D+gmD3l0BETAfuL1MeSiB7Zp5Utl633Ws=;
        b=Zq7AfBNF97Xrqxden+m2xxxrVOT7WIdxT4zaU0B11ZzrDPPF4umix8ROjZsj1Yqduhj2K4
        wGM3tgBLn5jPechHV8jYrk1e745lz7lAaGx8uE8MrE1r6njfUsjcmkhOBF6Rp/hp5Ezzds
        PDX4wIbB8mhF/MQqunXnk9vf5g/lR4s=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 50A782C145;
        Thu, 11 May 2023 15:46:24 +0000 (UTC)
Date:   Thu, 11 May 2023 17:46:21 +0200
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
Subject: Re: [PATCH v4 10/17] watchdog/hardlockup: Move perf hardlockup
 watchdog petting to watchdog.c
Message-ID: <ZF0NzSCRCapqDbC4@alley>
References: <20230504221349.1535669-1-dianders@chromium.org>
 <20230504151100.v4.10.I00dfd6386ee00da25bf26d140559a41339b53e57@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504151100.v4.10.I00dfd6386ee00da25bf26d140559a41339b53e57@changeid>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Thu 2023-05-04 15:13:42, Douglas Anderson wrote:
> In preparation for the buddy hardlockup detector, which wants the same
> petting logic as the current perf hardlockup detector, move the code
> to watchdog.c. While doing this, rename the global variable to match
> others nearby. The arch_touch_nmi_watchdog() function is not renamed
> since that is exported with "EXPORT_SYMBOL" and is thus ABI.
> 
> Currently the code in watchdog.c is guarded by
> CONFIG_HARDLOCKUP_DETECTOR_PERF, which makes this change seem
> silly. However, a future patch will change this.
> 
> NOTE: there is a slight side effect to this change, though from code
> analysis I believe it to be a beneficial one. Specifically the perf
> hardlockup detector will now do check the "timestamp" before clearing
> any watchdog pets. Previously the order was reversed. With the old
> order if the watchdog perf event was firing super fast then it would
> also be clearing existing watchdog pets super fast. The new behavior
> of handling super-fast perf before clearing watchdog pets seems
> better.

Ah, I think that this was actually pretty serious bug in the perf
detector. But I think that it should work another way, see below.

> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> @@ -111,6 +125,11 @@ static void watchdog_hardlockup_interrupt_count(void)
>  
>  void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs)
>  {
> +	if (__this_cpu_read(watchdog_hardlockup_touch)) {
> +		__this_cpu_write(watchdog_hardlockup_touch, false);
> +		return;
> +	}

If we clear watchdog_hardlockup_touch() here then
watchdog_hardlockup_check() won't be called yet another
watchdog_hrtimer_sample_threshold perior.

It means that any touch will cause ignoring one full period.
The is_hardlockup() check will be done after full two periods.

It is not ideal, see below.

> +
>  	/*
>  	 * Check for a hardlockup by making sure the CPU's timer
>  	 * interrupt is incrementing. The timer interrupt should have
> diff --git a/kernel/watchdog_perf.c b/kernel/watchdog_perf.c
> index 9be90b2a2ea7..547917ebd5d3 100644
> --- a/kernel/watchdog_perf.c
> +++ b/kernel/watchdog_perf.c
> @@ -112,11 +98,6 @@ static void watchdog_overflow_callback(struct perf_event *event,
>  	/* Ensure the watchdog never gets throttled */
>  	event->hw.interrupts = 0;
>  
> -	if (__this_cpu_read(watchdog_nmi_touch) == true) {
> -		__this_cpu_write(watchdog_nmi_touch, false);
> -		return;
> -	}

The original code looks wrong. arch_touch_nmi_watchdog() caused
skipping only one period of the perf event.

I would expect that it caused restarting the period,
something like:

	if (__this_cpu_read(watchdog_nmi_touch) == true) {
		/*
		 * Restart the period after which the interrupt
		 * counter is checked.
		 */
		__this_cpu_write(nmi_rearmed, 0);
		__this_cpu_write(last_timestamp, now);
		__this_cpu_write(watchdog_nmi_touch, false);
		return;
	}

By other words, we should restart the period in the very next perf
event after the watchdog was touched.

That said, the new code looks better than the original.
IMHO, the original code was prone to false positives.

Best Regards,
Petr

PS: It might be worth fixing this problem in a separate patch at the
    beginning of this patchset. It might be a candidate for stable
    backports.

> -
>  	if (!watchdog_check_timestamp())
>  		return;
>  

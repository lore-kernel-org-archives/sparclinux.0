Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7601C7EE23
	for <sparclinux@archiver.kernel.org>; Thu, 11 May 2023 14:15:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238149AbjEKOP5 (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Thu, 11 May 2023 10:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238455AbjEKOPu (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Thu, 11 May 2023 10:15:50 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FE8D2D3;
        Thu, 11 May 2023 07:15:24 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 75A5A21D09;
        Thu, 11 May 2023 14:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683814480; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RsbmH7Uqop/nnM3vjIRjHRqffBOelcetDOasqeW6Jho=;
        b=pOJqJS5iXtgLyWgNrYikAH8lcP9VErhN6vam0bviIGKv5MIKfAJuXwdEnozUAl1mFiB4qM
        Td/bamTw2bqEgQNfkm93ZRlv/TH+VmTSwCohSr4w9x5dduYiCKpI5GaFu6jyUYqF9cD6Qa
        q9wqaGcZN1O3kEmspF38GXvD5Hh7KCE=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5B4622C141;
        Thu, 11 May 2023 14:14:37 +0000 (UTC)
Date:   Thu, 11 May 2023 16:14:37 +0200
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
Subject: Re: [PATCH v4 09/17] watchdog/hardlockup: Add a "cpu" param to
 watchdog_hardlockup_check()
Message-ID: <ZFz4TVOyEU51b898@alley>
References: <20230504221349.1535669-1-dianders@chromium.org>
 <20230504151100.v4.9.I3a7d4dd8c23ac30ee0b607d77feb6646b64825c0@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504151100.v4.9.I3a7d4dd8c23ac30ee0b607d77feb6646b64825c0@changeid>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Thu 2023-05-04 15:13:41, Douglas Anderson wrote:
> In preparation for the buddy hardlockup detector where the CPU
> checking for lockup might not be the currently running CPU, add a
> "cpu" parameter to watchdog_hardlockup_check().
> 
> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> @@ -92,14 +92,14 @@ static DEFINE_PER_CPU(unsigned long, hrtimer_interrupts_saved);
>  static DEFINE_PER_CPU(bool, watchdog_hardlockup_processed);
>  static unsigned long watchdog_hardlockup_dumped_stacks;
>  
> -static bool watchdog_hardlockup_is_lockedup(void)
> +static bool watchdog_hardlockup_is_lockedup(unsigned int cpu)
>  {
> -	unsigned long hrint = __this_cpu_read(hrtimer_interrupts);
> +	unsigned long hrint = per_cpu(hrtimer_interrupts, cpu);

My radar tells me that this should be
READ_ONCE(per_cpu(hrtimer_interrupts, cpu)) when the value might
be modified on another CPU. Otherwise, the compiler is allowed
to split the read into more instructions.

It will be needed for the buddy detector. And it will require
also incrementing the value in watchdog_hardlockup_interrupt_count()
an atomic way.

Note that __this_cpu_inc_return() does not guarantee atomicity
according to my understanding. In theory, the following should
work because counter will never be incremented in parallel:

static unsigned long watchdog_hardlockup_interrupt_count(void)
{
	unsigned long count;

	count = __this_cpu_read(hrtimer_interrupts);
	count++;
	WRITE_ONCE(*raw_cpu_ptr(hrtimer_interrupts), count);
}

but it is nasty. A more elegant solution might be using atomic_t
for hrtimer_interrupts counter.

> -	if (__this_cpu_read(hrtimer_interrupts_saved) == hrint)
> +	if (per_cpu(hrtimer_interrupts_saved, cpu) == hrint)
>  		return true;
>  
> -	__this_cpu_write(hrtimer_interrupts_saved, hrint);
> +	per_cpu(hrtimer_interrupts_saved, cpu) = hrint;

IMHO, hrtimer_interrupts_saved might be handled this way.
The value is read/written only by this function.

The buddy watchdog should see consistent values even when
the buddy CPU goes offline. This check should never race
because this CPU should get touched when another buddy
gets assigned.

Well, it would deserve a comment.

>  
>  	return false;
>  }
> @@ -117,35 +117,50 @@ void watchdog_hardlockup_check(struct pt_regs *regs)
>  	 * fired multiple times before we overflow'd. If it hasn't
>  	 * then this is a good indication the cpu is stuck
>  	 */
> -	if (watchdog_hardlockup_is_lockedup()) {
> +	if (watchdog_hardlockup_is_lockedup(cpu)) {
>  		unsigned int this_cpu = smp_processor_id();
> +		struct cpumask backtrace_mask = *cpu_online_mask;
>  
>  		/* Only handle hardlockups once. */
> -		if (__this_cpu_read(watchdog_hardlockup_processed))
> +		if (per_cpu(watchdog_hardlockup_processed, cpu))

This should not need READ_ONCE()/WRITE_ONCE() because it is just bool.
Also it is read/modified only in this function on the same CPU.

>  			return;
>  
> -		pr_emerg("Watchdog detected hard LOCKUP on cpu %d\n", this_cpu);
> +		pr_emerg("Watchdog detected hard LOCKUP on cpu %d\n", cpu);
>  		print_modules();
>  		print_irqtrace_events(current);
> -		if (regs)
> +		if (regs) {
>  			show_regs(regs);
> -		else
> -			dump_stack();
> +			cpumask_clear_cpu(cpu, &backtrace_mask);
> +		} else {
> +			/*
> +			 * If the locked up CPU is different than the CPU we're
> +			 * running on then we'll try to backtrace the CPU that
> +			 * locked up and then exclude it from later backtraces.
> +			 * If that fails or if we're running on the locked up
> +			 * CPU, just do a normal backtrace.
> +			 */
> +			if (cpu != this_cpu && trigger_single_cpu_backtrace(cpu)) {
> +				cpumask_clear_cpu(cpu, &backtrace_mask);
> +			} else {
> +				dump_stack();
> +				cpumask_clear_cpu(this_cpu, &backtrace_mask);

This will dump the stack on the current CPU when
trigger_single_cpu_backtrace(cpu) is not supported.
It would be confusing because the buddy watchdog
could be here only when this_cpu is not hardlocked.

It should be:

	if (cpu == this_cpu) {
		if (regs)
			show_regs(regs);
		else
			dump_stack();
		cpumask_clear_cpu(cpu, &backtrace_mask);
	} else {
		if (trigger_single_cpu_backtrace(cpu)
			cpumask_clear_cpu(cpu, &backtrace_mask);
	}

> +			}
> +		}
>  
>  		/*
> -		 * Perform all-CPU dump only once to avoid multiple hardlockups
> -		 * generating interleaving traces
> +		 * Perform multi-CPU dump only once to avoid multiple
> +		 * hardlockups generating interleaving traces
>  		 */
>  		if (sysctl_hardlockup_all_cpu_backtrace &&
>  		    !test_and_set_bit(0, &watchdog_hardlockup_dumped_stacks))
> -			trigger_allbutself_cpu_backtrace();
> +			trigger_cpumask_backtrace(&backtrace_mask);
>  
>  		if (hardlockup_panic)
>  			nmi_panic(regs, "Hard LOCKUP");
>  
> -		__this_cpu_write(watchdog_hardlockup_processed, true);
> +		per_cpu(watchdog_hardlockup_processed, cpu) = true;
>  	} else {
> -		__this_cpu_write(watchdog_hardlockup_processed, false);
> +		per_cpu(watchdog_hardlockup_processed, cpu) = false;
>  	}
>  }
>  

Best Regards,
Petr

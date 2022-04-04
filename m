Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0410BC433F5
	for <sparclinux@archiver.kernel.org>; Mon,  4 Apr 2022 14:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377007AbiDDOTI (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Mon, 4 Apr 2022 10:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237149AbiDDOTI (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Mon, 4 Apr 2022 10:19:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC973B033;
        Mon,  4 Apr 2022 07:17:12 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CE90D210E5;
        Mon,  4 Apr 2022 14:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649081830; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rze0Jhi/DK5kWoGoABbHFZ2g0bO59w1puNqIyew0fbQ=;
        b=NuRhmVsuuISJsd8BJFS2w0AHxAChlUR+Zs2Tk2CD2BmcBSysouRnrwBdtqDhwT9tV/yFRj
        20+uWtwlHvQG33Dsa4yw9cZL/CaMGO65jV2JdiPcjTxITG45cXnXxWZTOcbkamzJ/CR1L7
        VutDnw+unMqssuQ2wjCE1x4SPcCENTo=
Received: from suse.cz (pathway.suse.cz [10.100.12.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 38BECA3B82;
        Mon,  4 Apr 2022 14:17:09 +0000 (UTC)
Date:   Mon, 4 Apr 2022 16:17:09 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Lecopzer Chen <lecopzer.chen@mediatek.com>
Cc:     linux-kernel@vger.kernel.org, acme@kernel.org,
        akpm@linux-foundation.org, alexander.shishkin@linux.intel.com,
        catalin.marinas@arm.com, davem@davemloft.net, jolsa@redhat.com,
        jthierry@redhat.com, keescook@chromium.org, kernelfans@gmail.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        masahiroy@kernel.org, matthias.bgg@gmail.com, maz@kernel.org,
        mcgrof@kernel.org, mingo@redhat.com, namhyung@kernel.org,
        nixiaoming@huawei.com, peterz@infradead.org,
        sparclinux@vger.kernel.org, sumit.garg@linaro.org,
        wangqing@vivo.com, will@kernel.org, yj.chiang@mediatek.com
Subject: Re: [PATCH v3 5/5] arm64: Enable perf events based hard lockup
 detector
Message-ID: <20220404141709.GA26840@pathway.suse.cz>
References: <20220324141405.10835-1-lecopzer.chen@mediatek.com>
 <20220324141405.10835-6-lecopzer.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324141405.10835-6-lecopzer.chen@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Thu 2022-03-24 22:14:05, Lecopzer Chen wrote:
> With the recent feature added to enable perf events to use pseudo NMIs
> as interrupts on platforms which support GICv3 or later, its now been
> possible to enable hard lockup detector (or NMI watchdog) on arm64
> platforms. So enable corresponding support.
> 
> One thing to note here is that normally lockup detector is initialized
> just after the early initcalls but PMU on arm64 comes up much later as
> device_initcall(). To cope with that, overriding watchdog_nmi_probe() to
> let the watchdog framework know PMU not ready, and inform the framework
> to re-initialize lockup detection once PMU has been initialized.
> 
> [1]: http://lore.kernel.org/linux-arm-kernel/1610712101-14929-1-git-send-email-sumit.garg@linaro.org
> 
> --- /dev/null
> +++ b/arch/arm64/kernel/watchdog_hld.c
> @@ -0,0 +1,37 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/nmi.h>
> +#include <linux/cpufreq.h>
> +#include <linux/perf/arm_pmu.h>
> +
> +/*
> + * Safe maximum CPU frequency in case a particular platform doesn't implement
> + * cpufreq driver. Although, architecture doesn't put any restrictions on
> + * maximum frequency but 5 GHz seems to be safe maximum given the available
> + * Arm CPUs in the market which are clocked much less than 5 GHz. On the other
> + * hand, we can't make it much higher as it would lead to a large hard-lockup
> + * detection timeout on parts which are running slower (eg. 1GHz on
> + * Developerbox) and doesn't possess a cpufreq driver.
> + */
> +#define SAFE_MAX_CPU_FREQ	5000000000UL // 5 GHz
> +u64 hw_nmi_get_sample_period(int watchdog_thresh)
> +{
> +	unsigned int cpu = smp_processor_id();
> +	unsigned long max_cpu_freq;
> +
> +	max_cpu_freq = cpufreq_get_hw_max_freq(cpu) * 1000UL;
> +	if (!max_cpu_freq)
> +		max_cpu_freq = SAFE_MAX_CPU_FREQ;
> +
> +	return (u64)max_cpu_freq * watchdog_thresh;
> +}

This change is not mentioned in the commit message.
Please, put it into a separate patch.

> +int __init watchdog_nmi_probe(void)
> +{
> +	if (!allow_lockup_detector_init_retry)
> +		return -EBUSY;

How do you know that you should return -EBUSY
when retry in not enabled?

I guess that it is an optimization to make it fast
during the first call. But the logic is far from
obvious.

> +
> +	if (!arm_pmu_irq_is_nmi())
> +		return -ENODEV;
> +
> +	return hardlockup_detector_perf_init();
> +}

Is this just an optimization or is it really needed?
Why this was not needed in v2 patchset?

If it is just an optimization then I would remove it.
IMHO, it just adds confusion and it is not worth it.

Best Regards,
Petr

Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBA1C433F5
	for <sparclinux@archiver.kernel.org>; Fri, 25 Feb 2022 12:50:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233524AbiBYMvK (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 25 Feb 2022 07:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiBYMvK (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 25 Feb 2022 07:51:10 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E33B715F;
        Fri, 25 Feb 2022 04:50:38 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id AECEE2114E;
        Fri, 25 Feb 2022 12:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645793436; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p+z7dhR5AVpWtS+uySTHMyttMo1Oz60T/1wMsyvp/Uo=;
        b=vRXiEwcWBV/NU3KG7hCbXIHY7ZCeuXt2JIUb6LQjB+Bb45u4uabozrc4q4xG2VTL3xaU/Q
        TN2Ed5kkkeZ8EmQiaWkhGGWie6kCPEMKWWybX+Tq+kGm9jW9N1bbouSmgAdXKpHtgjqcRn
        iBRB6rxjni2WvxifF30a5dS+Rjonp2s=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 54B8EA3B83;
        Fri, 25 Feb 2022 12:50:36 +0000 (UTC)
Date:   Fri, 25 Feb 2022 13:50:36 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Lecopzer Chen <lecopzer.chen@mediatek.com>
Cc:     linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, davem@davemloft.net,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Julien Thierry <jthierry@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wang Qing <wangqing@vivo.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-mediatek@lists.infradead.org, sumit.garg@linaro.org,
        kernelfans@gmail.com, yj.chiang@mediatek.com
Subject: Re: [PATCH 2/5] kernel/watchdog: change watchdog_nmi_enable() to void
Message-ID: <YhjQnMZahzu1w2lj@alley>
References: <20220212104349.14266-1-lecopzer.chen@mediatek.com>
 <20220212104349.14266-3-lecopzer.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220212104349.14266-3-lecopzer.chen@mediatek.com>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Sat 2022-02-12 18:43:46, Lecopzer Chen wrote:
> 
> Nobody cares about the return value of watchdog_nmi_enable(),
> changing its prototype to void.
> 
> --- a/arch/sparc/kernel/nmi.c
> +++ b/arch/sparc/kernel/nmi.c
> @@ -282,11 +282,11 @@ __setup("nmi_watchdog=", setup_nmi_watchdog);
>   * sparc specific NMI watchdog enable function.
>   * Enables watchdog if it is not enabled already.
>   */
> -int watchdog_nmi_enable(unsigned int cpu)
> +void watchdog_nmi_enable(unsigned int cpu)
>  {
>  	if (atomic_read(&nmi_active) == -1) {
>  		pr_warn("NMI watchdog cannot be enabled or disabled\n");
> -		return -1;
> +		return;
>  	}
>  
>  	/*
> @@ -295,11 +295,11 @@ int watchdog_nmi_enable(unsigned int cpu)
>  	 * process first.
>  	 */
>  	if (!nmi_init_done)
> -		return 0;
> +		return;
>  
>  	smp_call_function_single(cpu, start_nmi_watchdog, NULL, 1);
>  
> -	return 0;
> +	return;

Return at the end of the function is superfluous.

>  }
>  /*
>   * sparc specific NMI watchdog disable function.

Otherwise, it looks good.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

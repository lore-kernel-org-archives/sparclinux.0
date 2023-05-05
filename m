Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10889C77B73
	for <sparclinux@archiver.kernel.org>; Fri,  5 May 2023 03:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjEEDCc (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Thu, 4 May 2023 23:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjEEDCA (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Thu, 4 May 2023 23:02:00 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABAB11B7C;
        Thu,  4 May 2023 20:01:57 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1aad5245571so8527655ad.1;
        Thu, 04 May 2023 20:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683255717; x=1685847717;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4PZDk7grPMVm0G4plF1AOyfal6UfKUjeqMY34ZW+ZAQ=;
        b=l8NOWx+JbMx094FOTHTTAYeieKLG6l+RoxKooetFCoRg01JgRpRgmVK4EEnqQGp5Rv
         Wo7jd5ZE+BhoTQ83yfVxkRWDV8+8fYgzKrUQG+mG2SKoUwQzV4PiqCThKZNktLEkx80D
         dbZRbHCpWflzRiQ+5dUIKlwArRroFaTk4Ds/n3538KW17NDJa0a+h/l5niHUznruDebe
         bM/9WMTgDrGpzcJNg2dEdXkiWqJTXpKVuu+xjnqek1SKKSYnqTk3zeH62sRwe7eJhyjM
         UEdL7abKjXNavxqB2b/VypuWuDH+efkVGB6cwaNtCumipgGM0sxe7eY6ZqTznd4UjVkh
         DJMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683255717; x=1685847717;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4PZDk7grPMVm0G4plF1AOyfal6UfKUjeqMY34ZW+ZAQ=;
        b=Ygs6vUg5fCcp0X2SbhMGiWqNTzfwa0n6dboX2JfdfMp/zt5fxU3YWS9vP2mm7YF5aD
         LwLnoBXIBEoXWQPPjstUgFMWfgtAJuOllqL4jpPF6I+zi34Z4sZ3YdVwBuR2UewIlHGj
         XI9ZyXWtF0kMrfHZktp9hg2XidPoxpm0OC2WYvDvyCWsIRUYvWsSwpRhHwWTLEYSyhmA
         skPId+uWE4Fc9QmJJonAZKw3M7ezWMyZtwIbW7jwU/hQqHdsOIWhkHJ17p/evnHykKSU
         28RjKOSX/NUv/s0jTCLXap3tid1mQpBBqGGa4uxjnAUe4O7dxAOQ0Q7EyLSCtE/d9FDQ
         JQBA==
X-Gm-Message-State: AC+VfDx/A6wbo2G3VCsOj+gKQcEpVB7B7yjuZG3pYYiXU52mZUlLjwt7
        TPaUG5TU3ymzgbfx9YTJGno=
X-Google-Smtp-Source: ACHHUZ5Ox+yCPXhRH+Zo/Bf0YWlPnoiHwxarQldt5h1nNQM5kPEVVWcuprv1MbKY8J2RKwbHQwgMKQ==
X-Received: by 2002:a17:903:187:b0:1a2:8c7e:f301 with SMTP id z7-20020a170903018700b001a28c7ef301mr6214939plg.45.1683255717124;
        Thu, 04 May 2023 20:01:57 -0700 (PDT)
Received: from localhost ([203.59.190.92])
        by smtp.gmail.com with ESMTPSA id jj22-20020a170903049600b0019fea4d61c9sm354034plb.198.2023.05.04.20.01.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 20:01:56 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 05 May 2023 13:01:41 +1000
Message-Id: <CSE0CI3TFK72.2I4E5TJIRHDGM@wheely>
Cc:     "Sumit Garg" <sumit.garg@linaro.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Matthias Kaehlcke" <mka@chromium.org>,
        "Stephane Eranian" <eranian@google.com>,
        "Stephen Boyd" <swboyd@chromium.org>, <ricardo.neri@intel.com>,
        "Tzung-Bi Shih" <tzungbi@chromium.org>,
        "Lecopzer Chen" <lecopzer.chen@mediatek.com>,
        <kgdb-bugreport@lists.sourceforge.net>,
        "Masayoshi Mizuma" <msys.mizuma@gmail.com>,
        "Guenter Roeck" <groeck@chromium.org>,
        "Pingfan Liu" <kernelfans@gmail.com>,
        "Andi Kleen" <ak@linux.intel.com>,
        "Ian Rogers" <irogers@google.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>, <ito-yuichi@fujitsu.com>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Chen-Yu Tsai" <wens@csie.org>, <christophe.leroy@csgroup.eu>,
        <davem@davemloft.net>, <sparclinux@vger.kernel.org>,
        <mpe@ellerman.id.au>, "Will Deacon" <will@kernel.org>,
        <ravi.v.shankar@intel.com>, <linuxppc-dev@lists.ozlabs.org>,
        "Marc Zyngier" <maz@kernel.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Daniel Thompson" <daniel.thompson@linaro.org>
Subject: Re: [PATCH v4 08/17] watchdog/hardlockup: Style changes to
 watchdog_hardlockup_check() / ..._is_lockedup()
From:   "Nicholas Piggin" <npiggin@gmail.com>
To:     "Douglas Anderson" <dianders@chromium.org>,
        "Petr Mladek" <pmladek@suse.com>,
        "Andrew Morton" <akpm@linux-foundation.org>
X-Mailer: aerc 0.14.0
References: <20230504221349.1535669-1-dianders@chromium.org>
 <20230504151100.v4.8.I818492c326b632560b09f20d2608455ecf9d3650@changeid>
In-Reply-To: <20230504151100.v4.8.I818492c326b632560b09f20d2608455ecf9d3650@changeid>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Fri May 5, 2023 at 8:13 AM AEST, Douglas Anderson wrote:
> These are tiny style changes:
> - Add a blank line before a "return".
> - Renames two globals to use the "watchdog_hld" prefix.

Particularly static ones don't really need the namespace prefixes.

Not sure if processed is better than warn. allcpu_dumped is better
than dumped_stacks though because the all-CPUs-dump is a particular
thing.

Other style bits seem fine.

Thanks,
Nick

> - Store processor id in "unsigned int" rather than "int".
> - Minor comment rewording.
> - Use "else" rather than extra returns since it seemed more symmetric.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
> Changes in v4:
> - ("Style changes to watchdog_hardlockup_check ...") new for v4.
>
>  kernel/watchdog.c | 32 +++++++++++++++-----------------
>  1 file changed, 15 insertions(+), 17 deletions(-)
>
> diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> index 2d319cdf64b9..f46669c1671d 100644
> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> @@ -89,8 +89,8 @@ __setup("nmi_watchdog=3D", hardlockup_panic_setup);
> =20
>  static DEFINE_PER_CPU(unsigned long, hrtimer_interrupts);
>  static DEFINE_PER_CPU(unsigned long, hrtimer_interrupts_saved);
> -static DEFINE_PER_CPU(bool, hard_watchdog_warn);
> -static unsigned long hardlockup_allcpu_dumped;
> +static DEFINE_PER_CPU(bool, watchdog_hardlockup_processed);
> +static unsigned long watchdog_hardlockup_dumped_stacks;
> =20
>  static bool watchdog_hardlockup_is_lockedup(void)
>  {
> @@ -100,6 +100,7 @@ static bool watchdog_hardlockup_is_lockedup(void)
>  		return true;
> =20
>  	__this_cpu_write(hrtimer_interrupts_saved, hrint);
> +
>  	return false;
>  }
> =20
> @@ -110,21 +111,20 @@ static void watchdog_hardlockup_interrupt_count(voi=
d)
> =20
>  void watchdog_hardlockup_check(struct pt_regs *regs)
>  {
> -	/* check for a hardlockup
> -	 * This is done by making sure our timer interrupt
> -	 * is incrementing.  The timer interrupt should have
> -	 * fired multiple times before we overflow'd.  If it hasn't
> +	/*
> +	 * Check for a hardlockup by making sure the CPU's timer
> +	 * interrupt is incrementing. The timer interrupt should have
> +	 * fired multiple times before we overflow'd. If it hasn't
>  	 * then this is a good indication the cpu is stuck
>  	 */
>  	if (watchdog_hardlockup_is_lockedup()) {
> -		int this_cpu =3D smp_processor_id();
> +		unsigned int this_cpu =3D smp_processor_id();
> =20
> -		/* only print hardlockups once */
> -		if (__this_cpu_read(hard_watchdog_warn) =3D=3D true)
> +		/* Only handle hardlockups once. */
> +		if (__this_cpu_read(watchdog_hardlockup_processed))
>  			return;
> =20
> -		pr_emerg("Watchdog detected hard LOCKUP on cpu %d\n",
> -			 this_cpu);
> +		pr_emerg("Watchdog detected hard LOCKUP on cpu %d\n", this_cpu);
>  		print_modules();
>  		print_irqtrace_events(current);
>  		if (regs)
> @@ -137,18 +137,16 @@ void watchdog_hardlockup_check(struct pt_regs *regs=
)
>  		 * generating interleaving traces
>  		 */
>  		if (sysctl_hardlockup_all_cpu_backtrace &&
> -				!test_and_set_bit(0, &hardlockup_allcpu_dumped))
> +		    !test_and_set_bit(0, &watchdog_hardlockup_dumped_stacks))
>  			trigger_allbutself_cpu_backtrace();
> =20
>  		if (hardlockup_panic)
>  			nmi_panic(regs, "Hard LOCKUP");
> =20
> -		__this_cpu_write(hard_watchdog_warn, true);
> -		return;
> +		__this_cpu_write(watchdog_hardlockup_processed, true);
> +	} else {
> +		__this_cpu_write(watchdog_hardlockup_processed, false);
>  	}
> -
> -	__this_cpu_write(hard_watchdog_warn, false);
> -	return;
>  }
> =20
>  #else /* CONFIG_HARDLOCKUP_DETECTOR_PERF */
> --=20
> 2.40.1.521.gf1e218fcd8-goog


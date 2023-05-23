Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753E6C77B75
	for <sparclinux@archiver.kernel.org>; Tue, 23 May 2023 09:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235479AbjEWJ60 (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 23 May 2023 05:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236384AbjEWJ6Z (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Tue, 23 May 2023 05:58:25 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C26B18C;
        Tue, 23 May 2023 02:58:18 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id ABFEE228CB;
        Tue, 23 May 2023 09:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1684835895; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nijlHHOQkzUZvFPKISvsuCEtH+liiy/rrVmusLy93j8=;
        b=ukTNS+LA6LnEMXgs7TAWMh1IEmoqBA7OQZDzqQXjQCWc5jDXPfiss/BRVs+P68hkc1jpJr
        c6osfgyH7PPHg1SaA9cUw8ILMGtVpU6UYgIiSt2i5Y85hLTxvlKanmjx7xXSsVqooWm2a+
        O77Wy9lZcLNnFK6dGprQMn1Tn2HdM8E=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 305BA2C141;
        Tue, 23 May 2023 09:58:14 +0000 (UTC)
Date:   Tue, 23 May 2023 11:58:13 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Stephane Eranian <eranian@google.com>, mpe@ellerman.id.au,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linuxppc-dev@lists.ozlabs.org, Sumit Garg <sumit.garg@linaro.org>,
        npiggin@gmail.com, davem@davemloft.net,
        Marc Zyngier <maz@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>, sparclinux@vger.kernel.org,
        christophe.leroy@csgroup.eu,
        Catalin Marinas <catalin.marinas@arm.com>,
        ravi.v.shankar@intel.com, Randy Dunlap <rdunlap@infradead.org>,
        Pingfan Liu <kernelfans@gmail.com>,
        Guenter Roeck <groeck@chromium.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Ian Rogers <irogers@google.com>, ito-yuichi@fujitsu.com,
        ricardo.neri@intel.com, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v5 06/18] watchdog/hardlockup: Add comments to
 touch_nmi_watchdog()
Message-ID: <ZGyONWPXpE1DcxA5@alley>
References: <20230519101840.v5.18.Ia44852044cdcb074f387e80df6b45e892965d4a1@changeid>
 <20230519101840.v5.6.I4e47cbfa1bb2ebbcdb5ca16817aa2887f15dc82c@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519101840.v5.6.I4e47cbfa1bb2ebbcdb5ca16817aa2887f15dc82c@changeid>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Fri 2023-05-19 10:18:30, Douglas Anderson wrote:
> In preparation for the buddy hardlockup detector, add comments to
> touch_nmi_watchdog() to make it obvious that it touches the configured
> hardlockup detector regardless of whether it's backed by an NMI. Also
> note that arch_touch_nmi_watchdog() may not be architecture-specific.
> 
> Ideally, we'd like to rename these functions but that is a fairly
> disruptive change touching a lot of drivers. After discussion [1] the
> plan is to defer this until a good time.
> 
> [1] https://lore.kernel.org/r/ZFy0TX1tfhlH8gxj@alley
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
> Changes in v5:
> - No longer rename touch_nmi_watchdog(), just add comments.
> 
> Changes in v4:
> - ("Rename touch_nmi_watchdog() to ...") new for v4.
> 
>  include/linux/nmi.h | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/nmi.h b/include/linux/nmi.h
> index 454fe99c4874..fafab128f37e 100644
> --- a/include/linux/nmi.h
> +++ b/include/linux/nmi.h
> @@ -125,15 +125,30 @@ void watchdog_nmi_disable(unsigned int cpu);
>  void lockup_detector_reconfigure(void);
>  
>  /**
> - * touch_nmi_watchdog - restart NMI watchdog timeout.
> + * touch_nmi_watchdog - manually pet the hardlockup watchdog.
>   *
> - * If the architecture supports the NMI watchdog, touch_nmi_watchdog()
> - * may be used to reset the timeout - for code which intentionally
> - * disables interrupts for a long time. This call is stateless.
> + * If we support detecting hardlockups, touch_nmi_watchdog() may be
> + * used to pet the watchdog (reset the timeout) - for code which

Nit: I personally prefer "reset the timeout" over "pet the watchdog".
     "pet" is just another ambiguous name as "touch" ;-)

> + * intentionally disables interrupts for a long time. This call is stateless.
> + *
> + * Though this function has "nmi" in the name, the hardlockup watchdog might
> + * not be backed by NMIs. This function will likely be renamed to
> + * touch_hardlockup_watchdog() in the future.
>   */
>  static inline void touch_nmi_watchdog(void)
>  {
> +	/*
> +	 * Pass on to the hardlockup detector selected via CONFIG_. Note that
> +	 * the hardlockup detector may not be arch-specific nor using NMIs
> +	 * and the arch_touch_nmi_watchdog() function will likely be renamed
> +	 * in the future.
> +	 */
>  	arch_touch_nmi_watchdog();
> +
> +	/*
> +	 * Touching the hardlock detector implcitily pets the
> +	 * softlockup detector too
> +	 */

s/implcitily/implicitly/

That said, I would remove this comment completely. It describes what
is clear from the code.

A more useful information would be why it is done. But it is probably
clear as well. CPU could not schedule when interrupts are disabled.

>  	touch_softlockup_watchdog();
>  }

With the removed comment above touch_softlockup_watchdog():

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

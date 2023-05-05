Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E2CC77B73
	for <sparclinux@archiver.kernel.org>; Fri,  5 May 2023 02:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjEECv1 (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Thu, 4 May 2023 22:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjEECv0 (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Thu, 4 May 2023 22:51:26 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606A6120B9;
        Thu,  4 May 2023 19:51:24 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-64115eef620so16690154b3a.1;
        Thu, 04 May 2023 19:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683255084; x=1685847084;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gVzHKIeVTs5o2uUKP+mQkds3ksDwFVvhqkKafztg4+4=;
        b=ktqHNk5loLtU/KCwR//Z7tYcVQSm8JM7u7EDXu2OxKQQsBws43LRUPjwNVbUHAGJBj
         gc3DxpQtC1/OOyHW26dX3MwFbgdfWwpOVxdtbuQThRVEzgfI1BNUZ5OhrxthomwTTvW9
         KuWgSVznYjqLHRiyHmWJk+LT2L2s0ufFsPGG+IURgPieshXMcNyyDt/Kzo+DCv0xKjZe
         DyDKfQZeNNs/8VMonmfGERnmO5tTqr0eHZh+Y875AJRCzvNs9yxUih9l0rhqWFmBJrRo
         cV/9lUiVQ0pbHb4cFF5mCXAHtl60nbslHtAtfWdEsj03EbDyIlSOcirz6VnmjBK9H4/J
         ow4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683255084; x=1685847084;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gVzHKIeVTs5o2uUKP+mQkds3ksDwFVvhqkKafztg4+4=;
        b=FPSOrNZxM2XVbwmJ09iFGO1aWAquy5LHRUlXjiduGkuOWU7kOyZ34C/ElMMsEcwZj1
         bW+kfpZvmzwO6GANy3aPUe8Rw9e/jMKOn9SlLOEw+QSJxLd4P79hsc6FgcFDrW++uKuX
         zbpdyJ7o/sWVzt42+/2qHoMhnFq6YEtHTv8mk2FxEas/g36AkdQqjZ1R4DgtjZ0N2t6n
         y/yIRJj7CTnIbDIozrKrgfCYRIRjj3iyZy7wJnAqMZZ1/1rF4dhDFR5RSTuMwT2wGY2a
         XdupCLGtJbfEKmzhBczkojB/zohaySLxU4+Ue7kzUgpxCx5WQXh76A8H9iLl7wqfuBj6
         fP7g==
X-Gm-Message-State: AC+VfDyZmaWOSQiX9iEvXDw/YCTbK6/rozSAUOGJZzuzv/kAtAcwvomP
        M6b9bJMbmKd0IrhlIehLGh4=
X-Google-Smtp-Source: ACHHUZ5BRoOs+9WXOczfgGoXbf4YZMUc/Uu5++G5XcOuyogjStZoqiKceepZC/RfSwAcQqdM6F1UUg==
X-Received: by 2002:a17:902:d48e:b0:1a9:68d2:e4ae with SMTP id c14-20020a170902d48e00b001a968d2e4aemr6701878plg.2.1683255083704;
        Thu, 04 May 2023 19:51:23 -0700 (PDT)
Received: from localhost ([203.59.190.92])
        by smtp.gmail.com with ESMTPSA id t4-20020a170902bc4400b001ab29e002fbsm367141plz.17.2023.05.04.19.51.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 19:51:23 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 05 May 2023 12:51:06 +1000
Message-Id: <CSE04EI159N2.2TSXHBN2QLFCM@wheely>
From:   "Nicholas Piggin" <npiggin@gmail.com>
To:     "Douglas Anderson" <dianders@chromium.org>,
        "Petr Mladek" <pmladek@suse.com>,
        "Andrew Morton" <akpm@linux-foundation.org>
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
Subject: Re: [PATCH v4 05/17] watchdog/hardlockup: Rename
 touch_nmi_watchdog() to touch_hardlockup_watchdog()
X-Mailer: aerc 0.14.0
References: <20230504221349.1535669-1-dianders@chromium.org>
 <20230504151100.v4.5.I4e47cbfa1bb2ebbcdb5ca16817aa2887f15dc82c@changeid>
In-Reply-To: <20230504151100.v4.5.I4e47cbfa1bb2ebbcdb5ca16817aa2887f15dc82c@changeid>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Fri May 5, 2023 at 8:13 AM AEST, Douglas Anderson wrote:
> In preparation for the buddy hardlockup detector, rename
> touch_nmi_watchdog() to touch_hardlockup_watchdog() to make it clear
> that it will touch whatever hardlockup detector is configured. We'll
> add a #define for the old name (touch_nmi_watchdog) so that we don't
> have to touch every piece of code referring to the old name.

Is this really helpful? Now it's got two names Could just leave it.
If you insist then it'd be better just to rename everything in one
go at the end of a merge window IMO. Conflicts would be trivial.

> Ideally this change would also rename the arch_touch_nmi_watchdog(),
> but that is harder since arch_touch_nmi_watchdog() is exported with
> EXPORT_SYMBOL() and thus is ABI. Add a comment next to the call to
> hopefully alleviate some of the confusion here.

We don't keep ABI fixed upstream.

Thanks,
Nick

>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
> Changes in v4:
> - ("Rename touch_nmi_watchdog() to ...") new for v4.
>
>  include/linux/nmi.h | 27 ++++++++++++++++++++++-----
>  1 file changed, 22 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/nmi.h b/include/linux/nmi.h
> index 454fe99c4874..35d09d70f394 100644
> --- a/include/linux/nmi.h
> +++ b/include/linux/nmi.h
> @@ -125,18 +125,35 @@ void watchdog_nmi_disable(unsigned int cpu);
>  void lockup_detector_reconfigure(void);
> =20
>  /**
> - * touch_nmi_watchdog - restart NMI watchdog timeout.
> + * touch_hardlockup_watchdog - manually pet the hardlockup watchdog.
>   *
> - * If the architecture supports the NMI watchdog, touch_nmi_watchdog()
> - * may be used to reset the timeout - for code which intentionally
> - * disables interrupts for a long time. This call is stateless.
> + * If we support detecting hardlockups, touch_hardlockup_watchdog() may =
be
> + * used to pet the watchdog (reset the timeout) - for code which
> + * intentionally disables interrupts for a long time. This call is state=
less.
>   */
> -static inline void touch_nmi_watchdog(void)
> +static inline void touch_hardlockup_watchdog(void)
>  {
> +	/*
> +	 * Pass on to the hardlockup detector selected via CONFIG_. Note that
> +	 * the hardlockup detector may not be arch-specific nor using NMIs,
> +	 * but arch_touch_nmi_watchdog() is exported with EXPORT_SYMBOL() and
> +	 * is thus ABI.
> +	 */
>  	arch_touch_nmi_watchdog();
> +
> +	/*
> +	 * Touching the hardlock detector implcitily pets the
> +	 * softlockup detector too
> +	 */
>  	touch_softlockup_watchdog();
>  }
> =20
> +/*
> + * It's encouraged for code to refer to the new name, but allow the old
> + * name as well.
> + */
> +#define touch_nmi_watchdog	touch_hardlockup_watchdog
> +
>  /*
>   * Create trigger_all_cpu_backtrace() out of the arch-provided
>   * base function. Return whether such support was available,
> --=20
> 2.40.1.521.gf1e218fcd8-goog


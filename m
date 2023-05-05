Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C28C77B73
	for <sparclinux@archiver.kernel.org>; Fri,  5 May 2023 02:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjEECpR (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Thu, 4 May 2023 22:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjEECpQ (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Thu, 4 May 2023 22:45:16 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8890DAD38;
        Thu,  4 May 2023 19:45:15 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1aad6f2be8eso11302405ad.3;
        Thu, 04 May 2023 19:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683254715; x=1685846715;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VPayZxQXhn5fHUUTNLTNfbsixo+tOxhKRUmk7oh5a/w=;
        b=WY+pVFDrtbMq8x5EimKII2bW9WUx1lTIueOxBuy+296TzJv/lBCs2CVAl95G11oi+6
         OZNsCVJXRYwNOUePuVJ0+7z9G92HLzFZEMU/ej0a0B82cu11Q9UTbuSiZAbzM14CvYQr
         vSBwEP/zedkJKPWlTT86wxJPoMzMwlMsssbc0ETJDwX1uinKmleFDpH+izvPPzVQ2LlX
         GBO/I7GPjSznEYiBLpenS8d5vQj8J9utS5crxpbEVjZ/mmpFvTw1bfgpr3vdS/SdWaXC
         fm0hYT4RrH3rTkpnTHaFTuS8OW6QdYF/oypQk9UEjTZoOxeIHIMj1e8JUXXQYGHF51Uc
         39eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683254715; x=1685846715;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VPayZxQXhn5fHUUTNLTNfbsixo+tOxhKRUmk7oh5a/w=;
        b=VLMcL4bySc+b45NoIAbafAr6j5kL07wu5Gd7fGeTx7PGxybx2mJfemQXSp8lkRwT3g
         luq8RWKHgA/yOUtyI9+s25s5szMhRIAiRAcApixptEIQwM2p4Z2fX9gT+A5fU/lgcon8
         THouziQy90qkRZ4ZHkbU6W58AkWRYj5x6iSjxaarlOxRZkrC3HVln40lDB19jx/BHwaM
         W5N+h7IprxpmQNnCkmQ76Rn31naYVHOsTBcZG7JbYR9DqEWXpKyYqPLuAXKt/mxPJ6h3
         cIGkpQH/683M3iuc3B63V64DQy+wfVIA9lkr0ldWCVz0DE5J4qK7z21liKytC/sAcihE
         hGSw==
X-Gm-Message-State: AC+VfDzOsaSVRutPGOkdieRsUPOH4UMaVPv8NEyHRan8szozRdawoon9
        Jo+Ocqv54x1B+8SzxGOCDyE=
X-Google-Smtp-Source: ACHHUZ7idBWKbQjk10tpmFWDhGOiQRpg+CYPjBMjjCmko/Hu86hwsF4Jk+5iuKMKBjLrW41Iwy8Stg==
X-Received: by 2002:a17:902:d315:b0:1ab:13bd:5f96 with SMTP id b21-20020a170902d31500b001ab13bd5f96mr5830962plc.4.1683254714963;
        Thu, 04 May 2023 19:45:14 -0700 (PDT)
Received: from localhost ([203.59.190.92])
        by smtp.gmail.com with ESMTPSA id o5-20020a1709026b0500b001a6cd1e4205sm320934plk.279.2023.05.04.19.45.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 19:45:14 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 05 May 2023 12:45:00 +1000
Message-Id: <CSDZZQEL28W8.1WE80JHITRBKA@wheely>
Subject: Re: [PATCH v4 03/17] watchdog/hardlockup: change
 watchdog_nmi_enable() to void
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
X-Mailer: aerc 0.14.0
References: <20230504221349.1535669-1-dianders@chromium.org>
 <20230504151100.v4.3.Ic3a19b592eb1ac4c6f6eade44ffd943e8637b6e5@changeid>
In-Reply-To: <20230504151100.v4.3.Ic3a19b592eb1ac4c6f6eade44ffd943e8637b6e5@changeid>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Fri May 5, 2023 at 8:13 AM AEST, Douglas Anderson wrote:
> From: Lecopzer Chen <lecopzer.chen@mediatek.com>
>
> Nobody cares about the return value of watchdog_nmi_enable(),
> changing its prototype to void.
>

Acked-by: Nicholas Piggin <npiggin@gmail.com>

> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> I yanked this patch from the mailing lists [1] into my series just to
> make it easier to avoid conflicts between my series and the one adding
> the arm64 perf hardlockup detector, in case someone wanted to test
> them both together. This is a nice cleanup and could land together
> with the rest of my series if that makes sense.
>
> I changed the patch prefix to match others in my series.
>
> [1] https://lore.kernel.org/r/20220903093415.15850-3-lecopzer.chen@mediat=
ek.com/
>
> Changes in v4:
> - Pulled ("change watchdog_nmi_enable() to void") into my series for v4.
>
>  arch/sparc/kernel/nmi.c | 8 +++-----
>  include/linux/nmi.h     | 2 +-
>  kernel/watchdog.c       | 3 +--
>  3 files changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/arch/sparc/kernel/nmi.c b/arch/sparc/kernel/nmi.c
> index 060fff95a305..5dcf31f7e81f 100644
> --- a/arch/sparc/kernel/nmi.c
> +++ b/arch/sparc/kernel/nmi.c
> @@ -282,11 +282,11 @@ __setup("nmi_watchdog=3D", setup_nmi_watchdog);
>   * sparc specific NMI watchdog enable function.
>   * Enables watchdog if it is not enabled already.
>   */
> -int watchdog_nmi_enable(unsigned int cpu)
> +void watchdog_nmi_enable(unsigned int cpu)
>  {
>  	if (atomic_read(&nmi_active) =3D=3D -1) {
>  		pr_warn("NMI watchdog cannot be enabled or disabled\n");
> -		return -1;
> +		return;
>  	}
> =20
>  	/*
> @@ -295,11 +295,9 @@ int watchdog_nmi_enable(unsigned int cpu)
>  	 * process first.
>  	 */
>  	if (!nmi_init_done)
> -		return 0;
> +		return;
> =20
>  	smp_call_function_single(cpu, start_nmi_watchdog, NULL, 1);
> -
> -	return 0;
>  }
>  /*
>   * sparc specific NMI watchdog disable function.
> diff --git a/include/linux/nmi.h b/include/linux/nmi.h
> index 771d77b62bc1..454fe99c4874 100644
> --- a/include/linux/nmi.h
> +++ b/include/linux/nmi.h
> @@ -119,7 +119,7 @@ static inline int hardlockup_detector_perf_init(void)=
 { return 0; }
>  void watchdog_nmi_stop(void);
>  void watchdog_nmi_start(void);
>  int watchdog_nmi_probe(void);
> -int watchdog_nmi_enable(unsigned int cpu);
> +void watchdog_nmi_enable(unsigned int cpu);
>  void watchdog_nmi_disable(unsigned int cpu);
> =20
>  void lockup_detector_reconfigure(void);
> diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> index 582d572e1379..c705a18b26bf 100644
> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> @@ -93,10 +93,9 @@ __setup("nmi_watchdog=3D", hardlockup_panic_setup);
>   * softlockup watchdog start and stop. The arch must select the
>   * SOFTLOCKUP_DETECTOR Kconfig.
>   */
> -int __weak watchdog_nmi_enable(unsigned int cpu)
> +void __weak watchdog_nmi_enable(unsigned int cpu)
>  {
>  	hardlockup_detector_perf_enable();
> -	return 0;
>  }
> =20
>  void __weak watchdog_nmi_disable(unsigned int cpu)
> --=20
> 2.40.1.521.gf1e218fcd8-goog


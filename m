Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D21C77B7C
	for <sparclinux@archiver.kernel.org>; Fri,  5 May 2023 02:44:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjEECoG (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Thu, 4 May 2023 22:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjEECoF (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Thu, 4 May 2023 22:44:05 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F05DAD38;
        Thu,  4 May 2023 19:44:04 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-64115e652eeso16772131b3a.0;
        Thu, 04 May 2023 19:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683254644; x=1685846644;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6p6u1lFjW4Kf09rSTKWsXMKlDYVeiQSooaSY9v1sr/Q=;
        b=QbKGfhq0/VukYKNOHSY0v6xool59GlcBA7iNCg/HZdPbfNOI2U2wcnjPXAdf3zpDkj
         neU9jKCAtRwHCKxj/dP2KmEw7WoZ+/fSgnPuru60Zr2cLV8DFMTJpFsvQUp0osYoWylv
         rT8pWaBnXgiHvYDJMiG4neHu+4VqKhfWNnr1tIHtYOjRAWtH4DTqcyx92QPeDmU7q82E
         frpiNSAXqak7qrwnnS0dIUPjc5fXWsiEuhJKdxFLctM5Zvbjdi+fLfjCp2V83M1r4jnH
         XnrKN5LRxqq3UGh5iew5MwCe4VHRQcAXT4k2Gtdn/87diQ/0Tf+k5/0FugOrgI2Vifc8
         agSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683254644; x=1685846644;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6p6u1lFjW4Kf09rSTKWsXMKlDYVeiQSooaSY9v1sr/Q=;
        b=L5ekQbkZHtWH51W3Sabydq4SwZI+SRDKDdghlzHsgNxcrL813KxuI7X6/F9k56gmh7
         Ya/D4wuO83wBkMD9NKnwpLCYM/36Nj/flnTnUsTcBjOwidYOaIm8x/YEBARed31oMfpW
         HgrzmiErBkgWYsivqq5eE0NcAGbnaVEHKl9fZWczAfGjA7LZaVwwGB7FDIvpZOj8Qz+B
         McOdewwepS90/mEzJgQSzQo73b7jFSK00u1u+RlYm44Ta5oziw42+7PsPT8eRRl017A7
         1rvHR0NPPUZMDFn5X6YKW4eg0j4CZWQeMTuNAArb9y4Mpokk5wyPHr2oZ3FirGHYL16Z
         pXIg==
X-Gm-Message-State: AC+VfDxSntdqslAhy73dOnTiIW57AdqpWEjPbdDca3mwMZP1OVO6+E+u
        8sRcAm1B04I2lRE26hGND6g=
X-Google-Smtp-Source: ACHHUZ4FBwflGrFFYjYNCYAzAyBJY99qsAdoPf2uCzMYjlcj4Lp1AfSMQ3BwlsR14zq5zCM3V2Gwxg==
X-Received: by 2002:a05:6a20:4309:b0:f4:c0d6:87c with SMTP id h9-20020a056a20430900b000f4c0d6087cmr202733pzk.14.1683254643632;
        Thu, 04 May 2023 19:44:03 -0700 (PDT)
Received: from localhost ([203.59.190.92])
        by smtp.gmail.com with ESMTPSA id n7-20020aa79047000000b00642ea56f06fsm435666pfo.0.2023.05.04.19.43.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 19:44:02 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 05 May 2023 12:43:49 +1000
Message-Id: <CSDZYTDN5EHC.1AOZO6QV1UGJR@wheely>
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
Subject: Re: [PATCH v4 01/17] watchdog/perf: Define dummy
 watchdog_update_hrtimer_threshold() on correct config
From:   "Nicholas Piggin" <npiggin@gmail.com>
To:     "Douglas Anderson" <dianders@chromium.org>,
        "Petr Mladek" <pmladek@suse.com>,
        "Andrew Morton" <akpm@linux-foundation.org>
X-Mailer: aerc 0.14.0
References: <20230504221349.1535669-1-dianders@chromium.org>
 <20230504151100.v4.1.I8cbb2f4fa740528fcfade4f5439b6cdcdd059251@changeid>
In-Reply-To: <20230504151100.v4.1.I8cbb2f4fa740528fcfade4f5439b6cdcdd059251@changeid>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Fri May 5, 2023 at 8:13 AM AEST, Douglas Anderson wrote:
> The real watchdog_update_hrtimer_threshold() is defined in
> watchdog_hardlockup_perf.c. That file is included if

In kernel/watchdog_hld.c.

> CONFIG_HARDLOCKUP_DETECTOR_PERF and the function is defined in that
> file if CONFIG_HARDLOCKUP_CHECK_TIMESTAMP.
>
> The dummy version of the function in "nmi.h" didn't get that quite
> right. While this doesn't appear to be a huge deal, it's nice to make
> it consistent.

It doesn't break builds because CHECK_TIMESTAMP is only defined by
x86 so others don't get a double definition, and x86 uses perf lockup
detector, so it gets the out of line version.

So has no functional change but should be fixed.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>
> Fixes: 7edaeb6841df ("kernel/watchdog: Prevent false positives with turbo=
 modes")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
> Changes in v4:
> - ("Define dummy watchdog_update_hrtimer_threshold() ...") new for v4.
>
>  include/linux/nmi.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/nmi.h b/include/linux/nmi.h
> index 048c0b9aa623..771d77b62bc1 100644
> --- a/include/linux/nmi.h
> +++ b/include/linux/nmi.h
> @@ -197,7 +197,7 @@ u64 hw_nmi_get_sample_period(int watchdog_thresh);
>  #endif
> =20
>  #if defined(CONFIG_HARDLOCKUP_CHECK_TIMESTAMP) && \
> -    defined(CONFIG_HARDLOCKUP_DETECTOR)
> +    defined(CONFIG_HARDLOCKUP_DETECTOR_PERF)
>  void watchdog_update_hrtimer_threshold(u64 period);
>  #else
>  static inline void watchdog_update_hrtimer_threshold(u64 period) { }
> --=20
> 2.40.1.521.gf1e218fcd8-goog


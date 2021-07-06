Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48269C07E96
	for <sparclinux@archiver.kernel.org>; Tue,  6 Jul 2021 12:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30E1061C2B
	for <sparclinux@archiver.kernel.org>; Tue,  6 Jul 2021 12:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233169AbhGFMhR (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 6 Jul 2021 08:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244872AbhGFMMQ (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Tue, 6 Jul 2021 08:12:16 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15802C03B59A;
        Tue,  6 Jul 2021 04:51:18 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id k184so33779355ybf.12;
        Tue, 06 Jul 2021 04:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EUqiM+3sovMCSxZugj4dOEUdyxj90f62USiqd8nMbvc=;
        b=dUHcOxA9Z3K4fuOSf4/X9ejYOakvVH8gm27L1L7NuH39/kIEG7dvLiIaap+MlnOuPP
         0z3eKXPp5OmCxK8XZNhhdCFQ7OlFDKDAyV+d3zkBs8wsyHYwXvNMe5jyYoYsFIPNJU0k
         uzytw0KFZ15VtcODtgLyVv003ZuZhWBBTdP+xARTy1vCE7mSdnw9PZFgZdt5rZoccG9r
         qP2rI8G6/fgs9/XUHwtNx7TZ02Ugk5N2lRqLOB/lSU6AltSMmgMQwvRCtFplplETAGDf
         D0viZCWdxc0x0Tv2Ztu15sTduzGstlA23ldAuSsZZtlOVZMXmYuAtplldedD2xvrbOu0
         l9Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EUqiM+3sovMCSxZugj4dOEUdyxj90f62USiqd8nMbvc=;
        b=DFkr8bgCSF/98gIGMxT6E4i8Tk+xW6SdRR3pYz1CPAwyZhDZ0uS7vHLYBuQV3YSc8h
         yUQjVSF1xIEWtSZvJX6YqUFBhuVT3ZPutrDt3MbAbgnmidMLFjecuz7vVSKcXJF1T6yK
         +ufbHxLyBtB0JFB5kVcTOKnYfu4GXUVyHUZnrt9wDw2ppBlK70jkzpwZi0qx+MZpnkqB
         1CU3eP7SDvGG4gUVNsvsgGDjzqLuXm5cRbvZsWn9nYcsMn4de89KV4MsXqjDCQ+aMt0l
         LOCJ1huv4refxSKYAsQ4vhEXmg0oLEAnsoMJ9vi9rbO9Tlq/xnkSsGDkxsTpTVT4hB1p
         B50g==
X-Gm-Message-State: AOAM533eqlMFfSqW3XPJn/fliRFRTztOrhkqw2Rlnis/NVZeylQkfpwQ
        wHGx39arrh4/nDxufZJay2ErrvSauGJTK203Ga8=
X-Google-Smtp-Source: ABdhPJzAXilEGJY2grPyAOUOwxAL/Y/XaPvGQdL7nMQ6QaZMLhLFJL9d96wZZ8R+dmgQBjfyOOw0jt98XHqNmhyt0s0=
X-Received: by 2002:a25:2345:: with SMTP id j66mr23364777ybj.287.1625572277399;
 Tue, 06 Jul 2021 04:51:17 -0700 (PDT)
MIME-Version: 1.0
References: <CADxRZqzcrnSMzy50T+kWb_mQVguWDCMu6RoXsCc+-fNDPYXbaw@mail.gmail.com>
 <20210705195638.GA53988@C02TD0UTHF1T.local> <20210706091104.GA69200@C02TD0UTHF1T.local>
In-Reply-To: <20210706091104.GA69200@C02TD0UTHF1T.local>
From:   Anatoly Pugachev <matorola@gmail.com>
Date:   Tue, 6 Jul 2021 14:51:06 +0300
Message-ID: <CADxRZqxNdYBAs1daPJTAPKGeJx30D+v7xz87K2sB_dXYKdTrVg@mail.gmail.com>
Subject: Re: [sparc64] locking/atomic, kernel OOPS on running stress-ng
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Peter Zijlstra <peterz@lists.infradead.org>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        Sparc kernel list <sparclinux@vger.kernel.org>,
        debian-sparc <debian-sparc@lists.debian.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Tue, Jul 6, 2021 at 12:11 PM Mark Rutland <mark.rutland@arm.com> wrote:
> Fixes: ff5b4f1ed580c59d ("locking/atomic: sparc: move to ARCH_ATOMIC")
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Reported-by: Anatoly Pugachev <matorola@gmail.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Peter Zijlstra <peterz@lists.infradead.org>
> ---
>  arch/sparc/include/asm/cmpxchg_64.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/sparc/include/asm/cmpxchg_64.h b/arch/sparc/include/asm/cmpxchg_64.h
> index 8c39a9981187..12d00a42c0a3 100644
> --- a/arch/sparc/include/asm/cmpxchg_64.h
> +++ b/arch/sparc/include/asm/cmpxchg_64.h
> @@ -201,7 +201,7 @@ static inline unsigned long __cmpxchg_local(volatile void *ptr,
>  #define arch_cmpxchg64_local(ptr, o, n)                                        \
>    ({                                                                   \
>         BUILD_BUG_ON(sizeof(*(ptr)) != 8);                              \
> -       cmpxchg_local((ptr), (o), (n));                                 \
> +       arch_cmpxchg_local((ptr), (o), (n));                                    \
>    })
>  #define arch_cmpxchg64(ptr, o, n)      arch_cmpxchg64_local((ptr), (o), (n))


Mark, thanks, fixed...
tested on git kernel 5.13.0-11788-g79160a603bdb-dirty (dirty - cause
patch has been applied).

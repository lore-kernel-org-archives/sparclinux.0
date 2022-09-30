Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C33C433FE
	for <sparclinux@archiver.kernel.org>; Fri, 30 Sep 2022 02:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiI3CVY (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Thu, 29 Sep 2022 22:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiI3CVN (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Thu, 29 Sep 2022 22:21:13 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E33EBD7F
        for <sparclinux@vger.kernel.org>; Thu, 29 Sep 2022 19:21:09 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id w10so2765487pll.11
        for <sparclinux@vger.kernel.org>; Thu, 29 Sep 2022 19:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=FXFqlQxnzn1RAyuY90QGDEaTvBKFU5j4Xh7//yYY9xU=;
        b=I69w6qHuv2FrBDUxW3wRGIzd1evwxaO5pfHf+ya81O6Ht13tLf0MWMAhfhrqNnz/9l
         PQS96gXei6wrpSys8pYz5zQFLPTvYhzmUV1PCuTk7iTN0/TB5k/j9ZthTYwo71LPBGpM
         EhJBe5r3IfE2B8+xIrnROCwkE1tTu5nzoS5Eg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=FXFqlQxnzn1RAyuY90QGDEaTvBKFU5j4Xh7//yYY9xU=;
        b=5CPfxjfqJoCXOtE+aBcNdwhEv5R9Yf6EtCN6Yi8Uee2R+0ZDNMKqiy+rzxkismBEfR
         qKqy0baDyDVfuOJRYiiS41VZ+ia7/IC4l5j1LUJm2iotLl4iCZtgz6hzRICA68pGrpD/
         KgjMyMSCHz6E5uFPWVxSPM32KnWofyHgLqAqIyW63vpeMAvOMMMroor8lU+kCuJru8iq
         R6KI1q4mHJVJ+kv3Z5vb9Yv6N8gJHTUjVsEgkSr0hL99CQ+99aV7YHlJ+TEtGBN4+psB
         hTtrsZ1E6oRRmXvl+LZhTcnINjJEaXP1QZhlqe9grrh0pBzj4ONy1iLpEceKL238Ctpv
         hVVw==
X-Gm-Message-State: ACrzQf28PM7zhMQ+52neKE3TIawazPL+hvURuanHJL8r011Bvg3MvSrH
        gJKu/dGn3OniifXRiEPyq9/Hmg==
X-Google-Smtp-Source: AMsMyM4gpmuyrSC++Qd5ou8hrSjlKA6Kn0/7pH58+uU5n3ZfXLqUfb5qB3f17ZCIPasUNavUqToZuQ==
X-Received: by 2002:a17:90b:19ce:b0:203:182d:2c77 with SMTP id nm14-20020a17090b19ce00b00203182d2c77mr19789003pjb.45.1664504469294;
        Thu, 29 Sep 2022 19:21:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m5-20020a62a205000000b0054087e1aea4sm424396pff.15.2022.09.29.19.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 19:21:08 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     davem@davemloft.net, bvanassche@acm.org
Cc:     Kees Cook <keescook@chromium.org>, sparclinux@vger.kernel.org,
        gustavoars@kernel.org
Subject: Re: [PATCH] sparc: Unbreak the build
Date:   Thu, 29 Sep 2022 19:20:21 -0700
Message-Id: <166450440458.2153982.8042224641635890359.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220830205854.1918026-1-bvanassche@acm.org>
References: <20220830205854.1918026-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Tue, 30 Aug 2022 13:58:42 -0700, Bart Van Assche wrote:
> Fix the following build errors:
> 
> arch/sparc/mm/srmmu.c: In function ‘smp_flush_page_for_dma’:
> arch/sparc/mm/srmmu.c:1639:13: error: cast between incompatible function types from ‘void (*)(long unsigned int)’ to ‘void (*)(long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int)’ [-Werror=cast-function-type]
>  1639 |         xc1((smpfunc_t) local_ops->page_for_dma, page);
>       |             ^
> arch/sparc/mm/srmmu.c: In function ‘smp_flush_cache_mm’:
> arch/sparc/mm/srmmu.c:1662:29: error: cast between incompatible function types from ‘void (*)(struct mm_struct *)’ to ‘void (*)(long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int)’ [-Werror=cast-function-type]
>  1662 |                         xc1((smpfunc_t) local_ops->cache_mm, (unsigned long) mm);
>       |
> [ ... ]
> 
> [...]

I can take this, since it's related to the the hardening work. Dave,
let me know if you'd rather I drop it.

Applied to for-next/hardening, thanks!

[1/1] sparc: Unbreak the build
      https://git.kernel.org/kees/c/3052b17c604c

-- 
Kees Cook


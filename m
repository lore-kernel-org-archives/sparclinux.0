Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D5BECAAD3
	for <sparclinux@archiver.kernel.org>; Mon,  5 Sep 2022 19:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbiIEThC (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Mon, 5 Sep 2022 15:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbiIEThB (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Mon, 5 Sep 2022 15:37:01 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E7950705
        for <sparclinux@vger.kernel.org>; Mon,  5 Sep 2022 12:36:58 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id nc14so18864074ejc.4
        for <sparclinux@vger.kernel.org>; Mon, 05 Sep 2022 12:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=O2DU+lG5b8y7EdeArqWJ87q1UTfo/e0aDc12mvcyfm8=;
        b=P29yBnD7GQ40f4AnWx+txwzRZ0KpX90wZtHMGAf8ZJJ2h6fpyvstil2DDR8hDCsmpq
         7ptdSkvLvHefmcVrsgvme3esqjzDTaw14yJ+gL5pJID33afB8bnjs4rmpV+DNNhJALfu
         7KxCw6T1NqTnUmk8JBn7NDfjM/0kY1ZPWZSR+HQUczueK9H8zKMEGgLtPevK1eCZb0n7
         Im3mDKIQB8IwJfzmXaWmZQtvjQmFMjt6th4ldisOxeBgx81ofhzZy6VB1vgoEUhuI44J
         2/V1tS588Tu6yhSTzSq2/J367DW3T6S7udDnzHYRVQeOyLwCuve7KE2Nmp3mqCKLwj2f
         dJsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=O2DU+lG5b8y7EdeArqWJ87q1UTfo/e0aDc12mvcyfm8=;
        b=D3muINJn3+aj2FFE2FLwukrFgmDLB4UkY9FhYL5O5eZj/3BdClssNU+IhVzAuZzLYC
         wWrdLE+TGNxlw7QlpOU2TXJvZc9w8SIsQK2eUopleWyNMyvtK26vFFKZO8r/MaR8eDAE
         8ckTzpH8/WVgebFLLVfgSxRM0Qi4Pmf3vLvTBRw/OHLC8tkmpNYg+8GbhMGw4WLK9St/
         +cVdzwka8Kb/dB4yiE/qqgr5+hFh4XpWEF+OX7K8Wngi8HmcTwIFkT73+TLTnXwx8JDg
         smeLoY+vTdHcCLJ9necXa65S5/pHvKixuw87v51m90rpFbndnPhcIDv3DxT3pPo4BseN
         fqTQ==
X-Gm-Message-State: ACgBeo3ae3Cp9I1oZI9kbaTS/nyJK2kX9wkPnmR3g2dsVpP2XaMOtZvw
        CKEEpPV9BrliLfZSZujxS2BWm+KGsd3Qy1MLzfDyew==
X-Google-Smtp-Source: AA6agR5J15ANtu9dvLuy1kAEBMKj6rtt3G7LSxHAClbzxJvyPEjQKVrPT2inAKr8pFO4IeppvsxndwcJISbTJqlctG4=
X-Received: by 2002:a17:906:cc5a:b0:741:5240:d91a with SMTP id
 mm26-20020a170906cc5a00b007415240d91amr30533842ejb.500.1662406617460; Mon, 05
 Sep 2022 12:36:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220831195553.129866-1-linus.walleij@linaro.org>
In-Reply-To: <20220831195553.129866-1-linus.walleij@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 5 Sep 2022 21:36:46 +0200
Message-ID: <CACRpkdZzBu4ZmQFvkiyD8ZefZL9FNNKdWgUYTzHhH0ttStUE6g@mail.gmail.com>
Subject: Re: [PATCH v2] sparc: Fix the generic IO helpers
To:     "David S . Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     sparclinux@vger.kernel.org, kernel test robot <lkp@intel.com>,
        linux-arch@vger.kernel.org, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Wed, Aug 31, 2022 at 9:57 PM Linus Walleij <linus.walleij@linaro.org> wrote:

> This enables the Sparc to use <asm-generic/io.h> to fill in the
> missing (undefined) [read|write]sq I/O accessor functions.
>
> This is needed if Sparc[64] ever wants to uses CONFIG_REGMAP_MMIO
> which has been patches to use accelerated _noinc accessors
> such as readsq/writesq that Sparc64, while being a 64bit platform,
> as of now not yet provide.
>
> This comes with the requirement that everything the architecture
> already provides needs to be defined, rather than just being,
> say, static inline functions.
>
> Bite the bullet and just provide the definitions and make it work.
> Compile-tested on sparc32 and sparc64.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/linux-arm-kernel/202208201639.HXye3ke4-lkp@intel.com/
> Cc: David S. Miller <davem@davemloft.net>
> Cc: sparclinux@vger.kernel.org
> Cc: linux-arch@vger.kernel.org
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:

This might be a candidate for the arch tree as well, I have seen that most
code merged into arch/sparc these days seem to come through other
trees than the sparc tree, which has not been updated for 18 months.

Yours,
Linus Walleij

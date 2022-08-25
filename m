Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24EDAECAA27
	for <sparclinux@archiver.kernel.org>; Thu, 25 Aug 2022 19:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243162AbiHYThf (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Thu, 25 Aug 2022 15:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243068AbiHYThe (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Thu, 25 Aug 2022 15:37:34 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0C7BC824
        for <sparclinux@vger.kernel.org>; Thu, 25 Aug 2022 12:37:33 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id lx1so5074734ejb.12
        for <sparclinux@vger.kernel.org>; Thu, 25 Aug 2022 12:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=ug3fzDG0QYxiY3xSd7c4nZwCEdS86ZeW5WM3LA5MHSM=;
        b=g0uJOozT5lU6a75DvEj4h4KqrNPs35pLZkIU4MKoz44BuRVm2ldEff9+o9XfvwCUfA
         6CB6GJ168eYVhTnYKDQ92K/VsTEwnZ3TZqKhODN5kABVXGlU1ASH7oyqrll6gyjBmG3c
         VDI1lNLSTqiDONp8h/eQmERKYaafeOs8Kr8dT9KSTqUeoZvupkP/MnwvMm6rLdSaBj/s
         X0Q0gTjN6ccSlAv795W096/9/y+aZ94j8sXhxc3bSZZaKM6vE/PZnh0U9O4pmR+PI6vD
         fVcqNtGjcEWDRgm27Gyt6RqKsdYSJobymxtbwGVMmXIV+krZT2bCZhQnr6PDHP6IWbUU
         Pc7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ug3fzDG0QYxiY3xSd7c4nZwCEdS86ZeW5WM3LA5MHSM=;
        b=dWXi2SLCGU17R35VaW03APzpP613AAcrdhe+/xOlW8HT1ebpiOs0WaNdNB5xb32nFc
         cp7SMndlByaD8DbDNHDucj9oz2bKXp+sLAzPOG+UvnWOuEJEqsoVIoWGhLiRy0TxVuka
         HSeOMekQgEl2lQoLDUWadI6c5rYYvqXxNgkcJHkhMmAJvZ08dgrp6JTB0NgM6vlNd0SQ
         sDuXRPH56ljACRhG6uMYUVR0tcMhizXjbt2D+m10yuy7fv2ATsHdCxp0MLT9k0fYDJ5j
         mWY54HFmVg8A7SqcKX7EzqLvbcxkA5YuG1teadFSE0E27p9ViOKA/4TDkrVphVksenFs
         n5Ww==
X-Gm-Message-State: ACgBeo0Yev6S6ZpoB2KejQAoKi5SCLPvbPYiGqrqJnTD+WPTI9fWiTkg
        ZqatLRFaf+87S+z/nO160VE5CdWfoxlPpwmXIXigwQ==
X-Google-Smtp-Source: AA6agR7Vmn67v3s4dfV6Z2gSOqTOSHLYzwBGRCw6TengerfmZk7/zFC9K75wXTb1hZHhmc7K57ZZODg47J8yw06KyJM=
X-Received: by 2002:a17:906:58c8:b0:6fe:91d5:18d2 with SMTP id
 e8-20020a17090658c800b006fe91d518d2mr3538212ejs.190.1661456251980; Thu, 25
 Aug 2022 12:37:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220823085014.208791-1-linus.walleij@linaro.org> <48f9ddc8-02e2-2f2a-8bde-2d7346998096@infradead.org>
In-Reply-To: <48f9ddc8-02e2-2f2a-8bde-2d7346998096@infradead.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 25 Aug 2022 21:37:20 +0200
Message-ID: <CACRpkdbG1_eH9kGnGosODfOJto-DZ6C5etnGORjQfesB8ipUsg@mail.gmail.com>
Subject: Re: [PATCH] sparc64: Fix the generic IO helpers
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, kernel test robot <lkp@intel.com>,
        linux-arch@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Thu, Aug 25, 2022 at 12:15 AM Randy Dunlap <rdunlap@infradead.org> wrote:

> Both alpha

https://lore.kernel.org/linux-arch/20220818092059.103884-1-linus.walleij@linaro.org/

>  & parisc (32 and 64 bits) need this fix also.

Yeah I'll try to send something for them too. Also fixed Hexagon.
The problem is installing all the cross compilers just to test this
stuff.... It's a lot of work.

> Is it always safe to do this?

I think the arch part is fine, i.e. I don't think it will fix something
broken.

Then it is the matter of testing the new accessors.

That is done by a usecase, in this case, a usecase using
a fixed address in 64bit registers write under regmap MMIO.

Not sure someone will ever have a usecase for that to test
with. The people making use of it need to test it when they
use it.

As mentioned in the alpha patch, the alternative is to leave
regmap-mmio broken for the arch, until someone uses is.
It feels wrong to develop generic code for all archs that cannot
even compile on all of them, so I prefer to fix it to the point
of compiling at least. The generic helpers try their best to
be, well generic helpers.

Yours,
Linus Walleij

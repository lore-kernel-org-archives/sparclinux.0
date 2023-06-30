Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D69EB64DA
	for <sparclinux@archiver.kernel.org>; Fri, 30 Jun 2023 06:47:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbjF3Gr2 (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 30 Jun 2023 02:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjF3Gr1 (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 30 Jun 2023 02:47:27 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B72635A0
        for <sparclinux@vger.kernel.org>; Thu, 29 Jun 2023 23:47:24 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-51d946d2634so1633915a12.3
        for <sparclinux@vger.kernel.org>; Thu, 29 Jun 2023 23:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688107643; x=1690699643;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zlchbRYXZ2GmgikakdfRkYq9RUe43aExK7E5sqwL0Bw=;
        b=OVM0ZV3RlyGGrzqXh/mYvoDZ5ojO6xDLhkM+h9nlpBjAJdWSXNvxPWWSHpG4c/kb4x
         Lm1vrIizQ0GK71+cqFpC4vDwoa0Q/Nbv1tAv2wZzBwsBzkljWsffXJsWoNmrQLselfDp
         jGVWIsBfkJ7mQKMorzGKto7GvzyKZlgUROgrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688107643; x=1690699643;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zlchbRYXZ2GmgikakdfRkYq9RUe43aExK7E5sqwL0Bw=;
        b=daonVIH5EGQTTa31HMkAe9J0UGygnky/IeU7BiwPy1VOgdDNADBjZic40vXHu2EhUQ
         Q2v31lKrtWjbsBBaItAD89BHqlcRJfUgbG1Mkrg8i/98qKhayz2MqlV7Rtn9al4lSnZQ
         5UouZp4pP8amobTq/djdcaUH4U0TNiuorSHFC2muZ5/XIUlI95C3xu8foPUUntzSJ1h8
         Z6MebV8bjiMMp7j+PeNgSPhzcc967m+RlqU7LYzeb7Ee/8R18M5tatCRU3tPrjzPRVsG
         PXdeUSTQ73QriUuEF9Ma1mhP11ENE4mJuWZbdbZrKH85BpWU3oGrN6LUWs/wmDvMJoh0
         er4w==
X-Gm-Message-State: ABy/qLZCn+jYE87vPYWuSFSqrbj74mVoOUpEYOVsYj//gOzPBUMBJAOb
        K71UYQWix7DttBRXKzRRP32c8shmZkAjLBZubBvml53Z
X-Google-Smtp-Source: APBJJlFntxsv2b6nNqSfR9GfjST18FWgR+8336UAPxue5BmZsz2RcRSINLyLJX74NP8orOoIvgeoEg==
X-Received: by 2002:aa7:da0d:0:b0:514:a110:6bed with SMTP id r13-20020aa7da0d000000b00514a1106bedmr973128eds.27.1688107642936;
        Thu, 29 Jun 2023 23:47:22 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id d17-20020aa7ce11000000b0051a409e752asm6412019edv.17.2023.06.29.23.47.21
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 23:47:22 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-51d80d81d6eso1637063a12.1
        for <sparclinux@vger.kernel.org>; Thu, 29 Jun 2023 23:47:21 -0700 (PDT)
X-Received: by 2002:a05:6402:217:b0:51d:7ed9:c65 with SMTP id
 t23-20020a056402021700b0051d7ed90c65mr915784edv.21.1688107641560; Thu, 29 Jun
 2023 23:47:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230629184151.888604958@linuxfoundation.org> <CA+G9fYsM2s3q1k=+wHszvNbkKbHGe1pskkffWvaGXjYrp6qR=g@mail.gmail.com>
 <CAHk-=whaO3RZmKj8NDjs4f6JEwuwQWWesOfFu-URzOqTkyPoxw@mail.gmail.com>
 <fbe57907-b03f-ac8c-f3f4-4d6959bbc59c@roeck-us.net> <CAHk-=wgE9iTd_g20RU+FYa0NPhGSdiUDPW+moEqdHR4du1jmVA@mail.gmail.com>
In-Reply-To: <CAHk-=wgE9iTd_g20RU+FYa0NPhGSdiUDPW+moEqdHR4du1jmVA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 29 Jun 2023 23:47:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiN5H-2dh2zCo_jXE7_ekrxSHvQcMw4xfUKjuQs2=BN4w@mail.gmail.com>
Message-ID: <CAHk-=wiN5H-2dh2zCo_jXE7_ekrxSHvQcMw4xfUKjuQs2=BN4w@mail.gmail.com>
Subject: Re: [PATCH 6.4 00/28] 6.4.1-rc1 review
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        linux-parisc <linux-parisc@vger.kernel.org>,
        sparclinux@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Helge Deller <deller@gmx.de>,
        Jason Wang <wangborong@cdjrlc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Thu, 29 Jun 2023 at 23:33, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Oh well.  We'll get them all. Eventually. Let me go fix up that csky case.

It's commit e55e5df193d2 ("csky: fix up lock_mm_and_find_vma() conversion").

Let's hope all the problems are these kinds of silly - but obvious -
naming differences between different architectures.

Because as long as they cause build errors, they may be embarrassing,
but easy to find and notice.

I may not have cared enough about some of these architectures, and it
shows. sparc32. parisc. csky...

             Linus

Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C17C433F5
	for <sparclinux@archiver.kernel.org>; Wed,  8 Sep 2021 04:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A94B461139
	for <sparclinux@archiver.kernel.org>; Wed,  8 Sep 2021 04:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbhIHE4h (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 8 Sep 2021 00:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbhIHE4f (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 8 Sep 2021 00:56:35 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E882C06175F
        for <sparclinux@vger.kernel.org>; Tue,  7 Sep 2021 21:55:28 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id h16so2297260lfk.10
        for <sparclinux@vger.kernel.org>; Tue, 07 Sep 2021 21:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BGSSG1KppTdhFpfh0S8ytn/P5QNiyuOhgVXWuDULhJw=;
        b=CStPE9Hcsdp2M1zY8oDqlEXMK/e5mZky8VCHUR91VZTviVdYGsdmvADXEb6nRid6Eg
         AyzfyCf8pn634OVDyYLaboh2MKQybfXA96gozDLPvD9u3+wlsU46n50D/m0FqJGR5ayU
         VSuh+rFPr8/9ITNGdZWNdcCUB8bE11xCmIFdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BGSSG1KppTdhFpfh0S8ytn/P5QNiyuOhgVXWuDULhJw=;
        b=KXqZBSZ+AjuuzTwG/h9vaEC6DxHIb9slb4CyQAA08zofwnJcdU3wJ/UmDonuwOwDY+
         ZYQ8S8fY2qk5yY5UVZfZFYgG2EWY3s/61zW2Fw7eBuLSJ/IQuDGMehanLxZA9XdFMV/U
         wk05VUEjaVQjDe8rDxxErbp2l2aEcAKEJT3mHzgOoMKf5A2gYT2NB2YBejH7rLIJExbM
         Y7tijDjjigP4LLXcVDMnimYX9baji5wKoEMK21N5th758+664mmpRwdVnNdeWrfGwL+O
         5iocPnpPvSC5K0WfUQGDdY5FCxxnb3lKtZ1/9WTPwMjcp0I4xvg4hhyqTPmm8hCFeLxo
         YZmw==
X-Gm-Message-State: AOAM531Ku7e1lWkWU3mueZXNI1DdyQUpmkxal7aIAfOiQ3t2RSOn/JF/
        gdPuFxK7VV6qt1qXoJnk/4f1vPEwFbUMSCnTof0=
X-Google-Smtp-Source: ABdhPJx9EX9u2XVTRkgMlfymUk6ThrldrCvShINM30HLXMJUu4yVC9Dm5h74U7/VZaYu6e44nTrgRQ==
X-Received: by 2002:a05:6512:11e8:: with SMTP id p8mr1382290lfs.682.1631076925761;
        Tue, 07 Sep 2021 21:55:25 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id u3sm80208lfb.284.2021.09.07.21.55.24
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 21:55:25 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id l10so2341012lfg.4
        for <sparclinux@vger.kernel.org>; Tue, 07 Sep 2021 21:55:24 -0700 (PDT)
X-Received: by 2002:a05:6512:1112:: with SMTP id l18mr1314095lfg.402.1631076924200;
 Tue, 07 Sep 2021 21:55:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210906142615.GA1917503@roeck-us.net> <CAHk-=wgjTePY1v_D-jszz4NrpTso0CdvB9PcdroPS=TNU1oZMQ@mail.gmail.com>
 <c3790fb9-b83f-9596-18a1-21ace987c850@roeck-us.net> <CAHk-=wi4NW3NC0xWykkw=6LnjQD6D_rtRtxY9g8gQAJXtQMi8A@mail.gmail.com>
 <20210906234921.GA1394069@roeck-us.net> <20210908042838.GA2585993@roeck-us.net>
In-Reply-To: <20210908042838.GA2585993@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Sep 2021 21:55:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=whVDMcg==vcOopR0Mci2FQ8bzJjufyCg+WPh003K2i2ww@mail.gmail.com>
Message-ID: <CAHk-=whVDMcg==vcOopR0Mci2FQ8bzJjufyCg+WPh003K2i2ww@mail.gmail.com>
Subject: Re: [PATCH] Enable '-Werror' by default for all kernel builds
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-sparc <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Tue, Sep 7, 2021 at 9:28 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> It is seen with gcc 11.x whenever a memXXX or strXXX function parameter
> is a pointer to a fixed address.

I wonder why I don't see it with gcc 11.2 here on x86-64.

> gcc is happy if "(void *) 0xfffc1f2c"
> is passed to a global function which does nothing but return the address,
> such as:
>
> void *sanitize_address(void *address)
> {
>         return address;
> }

We have had reasons to do things like that before for somewhat similar
(well, opposite) reasons - trying to disassociate some pointer from
its originating symbol type.

Look at RELOC_HIDE().

It might be worth it having something similar for "absolute_pointer()".

Entirely untested "written-in-the-MUA" garbage:

   #define absolute_pointer(val) \
        ({ void *__res; __asm__("":"=r" (__res):"0" ((unsigned
long)(val))); __res; })

I dunno.

               Linus

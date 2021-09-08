Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A459C433FE
	for <sparclinux@archiver.kernel.org>; Wed,  8 Sep 2021 07:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61E7E60E94
	for <sparclinux@archiver.kernel.org>; Wed,  8 Sep 2021 07:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349046AbhIHHNE (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 8 Sep 2021 03:13:04 -0400
Received: from mail-vs1-f45.google.com ([209.85.217.45]:38707 "EHLO
        mail-vs1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348992AbhIHHNE (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 8 Sep 2021 03:13:04 -0400
Received: by mail-vs1-f45.google.com with SMTP id a25so1167854vso.5;
        Wed, 08 Sep 2021 00:11:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6SOp9qzgb+7OLbzhEnYOxzUm312xgb+yIQvHHl06QRQ=;
        b=JN0fGn7B6D81XWBoc1ZBusruvP+QEqcIpFyx+x9Jz2OlDlDRjW36Ls3Mblw6SlZpit
         srJfIbyVlWHrCFOMiT4nfjs3Wg5a5Kci6Uk6jdi0N1LCm+OOomIJ7+UhT9rMPK4bKMkL
         8v8HVHuOIA2v/bOmIgq4Iyn0jks/QXN/jz5YFkHBqgo8vc6e26lpAszLzwnsnEX+KuIR
         T/f3ITaJGvdiQgKivRHJPI8eMkIU24/PUp4huwKXZtj/Nb3BewI/IlgU3mRZ4KAh7bfr
         21HQrr/7k7Vxfo1DI8mDXIQb3HP9dnHE2ZYeaLyvVslRl9+UFRCSj7nbCmJyk31shkjE
         I+FQ==
X-Gm-Message-State: AOAM530lYEB/Xqf+QGMm+tct0Ueb5yKOZvjPJcN8c7C/aRFr/EGnjOUW
        3+to1qVeZT1wv/6AA7cyb7mfn7dDyd7y2Q2HKsM=
X-Google-Smtp-Source: ABdhPJzjGNGylzP8LxtbraFdz4alRjQZDJJTUIPo6jsA4z7q7jbMwhO+Z7i4SE3fylrJCV6B+DQIMmJdF43oArWG9O8=
X-Received: by 2002:a67:efd6:: with SMTP id s22mr1272938vsp.50.1631085116034;
 Wed, 08 Sep 2021 00:11:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210906142615.GA1917503@roeck-us.net> <CAHk-=wgjTePY1v_D-jszz4NrpTso0CdvB9PcdroPS=TNU1oZMQ@mail.gmail.com>
 <c3790fb9-b83f-9596-18a1-21ace987c850@roeck-us.net> <CAHk-=wi4NW3NC0xWykkw=6LnjQD6D_rtRtxY9g8gQAJXtQMi8A@mail.gmail.com>
 <20210906234921.GA1394069@roeck-us.net> <20210908042838.GA2585993@roeck-us.net>
 <YThAgIhKPQZq5UZn@zeniv-ca.linux.org.uk> <f4817c3d-c051-4030-e9ca-ea8b3f846119@roeck-us.net>
In-Reply-To: <f4817c3d-c051-4030-e9ca-ea8b3f846119@roeck-us.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 8 Sep 2021 09:11:43 +0200
Message-ID: <CAMuHMdWhzL+aWosce71Xm-7dKsgXFyL42tQ2gV2HyEZp5r0N7A@mail.gmail.com>
Subject: Re: [PATCH] Enable '-Werror' by default for all kernel builds
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-sparc <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Wed, Sep 8, 2021 at 7:16 AM Guenter Roeck <linux@roeck-us.net> wrote:
> On 9/7/21 9:48 PM, Al Viro wrote:
> > On Tue, Sep 07, 2021 at 09:28:38PM -0700, Guenter Roeck wrote:
> >>      memcpy(eth_addr, sanitize_address((void *) 0xfffc1f2c), ETH_ALEN);
> >>
> >> but that just seems weird. Is there a better solution ?
> >
> > (char (*)[ETH_ALEN])?  Said that, shouldn't that be doing something like
> > ioremap(), rather than casting explicit constants?
>
> Typecasts or even assigning the address to a variable does not help.
> The sanitizer function can not be static either.

So it can only be fixed by obfuscating the constant address in a
chain of out-of-line functions...
How is this compiler to be used for bare-metal programming?

> I don't know the hardware, so I can not answer the ioremap() question.

Yes it should.  But this driver dates back to 2.1.110, when only
half of the architectures already had ioremap().

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

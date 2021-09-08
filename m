Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50AA4C433EF
	for <sparclinux@archiver.kernel.org>; Wed,  8 Sep 2021 09:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 304B461139
	for <sparclinux@archiver.kernel.org>; Wed,  8 Sep 2021 09:50:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349664AbhIHJvn (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 8 Sep 2021 05:51:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:43944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347816AbhIHJvh (ORCPT <rfc822;sparclinux@vger.kernel.org>);
        Wed, 8 Sep 2021 05:51:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 39C0561153;
        Wed,  8 Sep 2021 09:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631094630;
        bh=pALvF7M+XI7KvL2Ye+Dan7R66fI5IMIY5AnMkVhaGZA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Hu8znGAF933lSrOEjX5Y437Z3cjumDU8SVjYn3wF7GpkYBYcX/vmcf7Az7QmY+qPG
         WscydilWg1WyNOi2IeY9LiNtZON6Thwc//9vvDDQkTnShRuVSnzW81F2Ia0nLjeWkZ
         ywCvF/ovuLBoZpzW5pq5zBsmlSQwJRrFjcGp5YcIoLiuZjwE2LDtvG9apX0/upWTlf
         ba0WuUqM+EURiPIoQo17Gj+zkKfYBRbRIg+ssKfrfG149xEqMPOms94z0yLqBRVCD8
         Sol0DBl5a6MYlQ6IfMR6tTACux1tLpP/42phjRRyGESlTAjh5qimDK6407R+zqWJ0o
         LK7ETwEP/tYeQ==
Received: by mail-wm1-f45.google.com with SMTP id m25-20020a7bcb99000000b002e751bcb5dbso1037397wmi.5;
        Wed, 08 Sep 2021 02:50:30 -0700 (PDT)
X-Gm-Message-State: AOAM531THLyCmjYCkqENi2l/lOeOxOZPQXXBgxrjxnUL67DnnJNitcw5
        o0uoRwXyrUJ146ktuTs5+LA3HVHXR+3bZfzWkBQ=
X-Google-Smtp-Source: ABdhPJyjQz0aG1A7Wh2jtxAexnoQ3Gh0b3xkfz/BVL4I9O9KubjY5cmiX48a++wBCzpuxYyoUEg9/PArvbEaJ0vm9wQ=
X-Received: by 2002:a7b:c956:: with SMTP id i22mr2660378wml.82.1631094628852;
 Wed, 08 Sep 2021 02:50:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210906142615.GA1917503@roeck-us.net> <CAHk-=wgjTePY1v_D-jszz4NrpTso0CdvB9PcdroPS=TNU1oZMQ@mail.gmail.com>
 <c3790fb9-b83f-9596-18a1-21ace987c850@roeck-us.net> <CAHk-=wi4NW3NC0xWykkw=6LnjQD6D_rtRtxY9g8gQAJXtQMi8A@mail.gmail.com>
 <20210906234921.GA1394069@roeck-us.net> <20210908042838.GA2585993@roeck-us.net>
 <YThAgIhKPQZq5UZn@zeniv-ca.linux.org.uk> <f4817c3d-c051-4030-e9ca-ea8b3f846119@roeck-us.net>
 <CAMuHMdWhzL+aWosce71Xm-7dKsgXFyL42tQ2gV2HyEZp5r0N7A@mail.gmail.com>
In-Reply-To: <CAMuHMdWhzL+aWosce71Xm-7dKsgXFyL42tQ2gV2HyEZp5r0N7A@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 8 Sep 2021 11:50:12 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3yJHvJaFHUh2+5GPm2n_g9gSfX2rFbrSLzDt6yC4eDog@mail.gmail.com>
Message-ID: <CAK8P3a3yJHvJaFHUh2+5GPm2n_g9gSfX2rFbrSLzDt6yC4eDog@mail.gmail.com>
Subject: Re: [PATCH] Enable '-Werror' by default for all kernel builds
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-sparc <sparclinux@vger.kernel.org>,
        Martin Sebor <msebor@gcc.gnu.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Wed, Sep 8, 2021 at 9:49 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Wed, Sep 8, 2021 at 7:16 AM Guenter Roeck <linux@roeck-us.net> wrote:
> > On 9/7/21 9:48 PM, Al Viro wrote:
> > > On Tue, Sep 07, 2021 at 09:28:38PM -0700, Guenter Roeck wrote:
> > >>      memcpy(eth_addr, sanitize_address((void *) 0xfffc1f2c), ETH_ALEN);
> > >>
> > >> but that just seems weird. Is there a better solution ?
> > >
> > > (char (*)[ETH_ALEN])?  Said that, shouldn't that be doing something like
> > > ioremap(), rather than casting explicit constants?
> >
> > Typecasts or even assigning the address to a variable does not help.
> > The sanitizer function can not be static either.
>
> So it can only be fixed by obfuscating the constant address in a
> chain of out-of-line functions...
> How is this compiler to be used for bare-metal programming?

I reported this as a gcc bug when I first saw it back in March:

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=99578

Martin Sebor suggested marking the pointer as 'volatile' as a workaround,
which is probably fine for bare-metal programming, but I would consider
that bad style for the kernel boot arguments. The RELOC_HIDE trick is probably
fine here, as there are only a couple of instances, and for the network
driver, using volatile is probably appropriate as well.

I still hope this can be fixed in a future gcc-11.x release. Maybe we should
add further instances of the problem on the gcc bug to boost the priority?

> > I don't know the hardware, so I can not answer the ioremap() question.
>
> Yes it should.  But this driver dates back to 2.1.110, when only
> half of the architectures already had ioremap().

How does  mvme16x even create the mapping? Is this a virtual address
that is hardwired to the bus or do you have a static mapping somewhere?
I see two other drivers accessing the nvram here

arch/m68k/mvme16x/config.c:static MK48T08ptr_t volatile rtc =
(MK48T08ptr_t)MVME_RTC_BASE;
arch/m68k/mvme16x/rtc.c:        volatile MK48T08ptr_t rtc =
(MK48T08ptr_t)MVME_RTC_BASE;

The same trick should work here, just create a local variable with a
volatile pointer and read from that.

       Arnd

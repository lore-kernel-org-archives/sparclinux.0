Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0C6C433EF
	for <sparclinux@archiver.kernel.org>; Wed,  8 Sep 2021 10:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FB2B60EE1
	for <sparclinux@archiver.kernel.org>; Wed,  8 Sep 2021 10:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbhIHKMS (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 8 Sep 2021 06:12:18 -0400
Received: from mail-vs1-f47.google.com ([209.85.217.47]:43644 "EHLO
        mail-vs1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347877AbhIHKMQ (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 8 Sep 2021 06:12:16 -0400
Received: by mail-vs1-f47.google.com with SMTP id u1so1510814vsq.10;
        Wed, 08 Sep 2021 03:11:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IbTzHHY/WI6T/MMG5snxRp97B/nG4as15XsvK/bKWX4=;
        b=fBW3TtAosz9IDzfFHHzIYfivloccAdP+HvWiQ9qlFR/eD6A3PLK14QLW3XCckDFXlF
         WNz9HVVNyOX+vuzJ2LyojJkdbW5euu3WxJ1zk1q7Pg3rwsXUQYcLAYExmMt9z6gpxA0I
         OkU3lCqMqj1nWFZjksQRbWJQjjApdke4Yo/nRL8BQxtOM+4iZ24OD/7SNhTKy2fG2Zfp
         kchTBnMKY02j7nRHPxCOpqOARzZTh4OWEq5n9JqZkZ33NWdnxKNylyL75vKDIHAaPytK
         oze+QeIDquA63AUPP0OuSrQZvkWphVr+f5llLJ+PwZe0Ix7IpGxq6LUZDaC7GgN1Ja59
         YMGQ==
X-Gm-Message-State: AOAM533VbkLq61wlEcR1jBp1ACiS4uocyfBYO8GW0SorTMbXetosYlPU
        R2FX/w24W3IDMTsmTx1dDxh/Shd73fe8+r+HCsw=
X-Google-Smtp-Source: ABdhPJyphSeifnjOp7oNIUahNJmyU6J5WjkkLDF0tVnZsBz1aPZxxoo6jIFvaLs1SeQPQMM8/visQwCk23wD9oVuNPg=
X-Received: by 2002:a67:cb0a:: with SMTP id b10mr1424921vsl.9.1631095868938;
 Wed, 08 Sep 2021 03:11:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210906142615.GA1917503@roeck-us.net> <CAHk-=wgjTePY1v_D-jszz4NrpTso0CdvB9PcdroPS=TNU1oZMQ@mail.gmail.com>
 <c3790fb9-b83f-9596-18a1-21ace987c850@roeck-us.net> <CAHk-=wi4NW3NC0xWykkw=6LnjQD6D_rtRtxY9g8gQAJXtQMi8A@mail.gmail.com>
 <20210906234921.GA1394069@roeck-us.net> <20210908042838.GA2585993@roeck-us.net>
 <YThAgIhKPQZq5UZn@zeniv-ca.linux.org.uk> <f4817c3d-c051-4030-e9ca-ea8b3f846119@roeck-us.net>
 <CAMuHMdWhzL+aWosce71Xm-7dKsgXFyL42tQ2gV2HyEZp5r0N7A@mail.gmail.com> <CAK8P3a3yJHvJaFHUh2+5GPm2n_g9gSfX2rFbrSLzDt6yC4eDog@mail.gmail.com>
In-Reply-To: <CAK8P3a3yJHvJaFHUh2+5GPm2n_g9gSfX2rFbrSLzDt6yC4eDog@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 8 Sep 2021 12:10:57 +0200
Message-ID: <CAMuHMdV51YuBYg6bvoQW9fBXFv8BRtnG9YTZST3AnbFwOsdW9g@mail.gmail.com>
Subject: Re: [PATCH] Enable '-Werror' by default for all kernel builds
To:     Arnd Bergmann <arnd@kernel.org>
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

Hi Arnd,

On Wed, Sep 8, 2021 at 11:50 AM Arnd Bergmann <arnd@kernel.org> wrote:
> On Wed, Sep 8, 2021 at 9:49 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Wed, Sep 8, 2021 at 7:16 AM Guenter Roeck <linux@roeck-us.net> wrote:
> > > On 9/7/21 9:48 PM, Al Viro wrote:
> > > > On Tue, Sep 07, 2021 at 09:28:38PM -0700, Guenter Roeck wrote:
> > > >>      memcpy(eth_addr, sanitize_address((void *) 0xfffc1f2c), ETH_ALEN);
> > > >>
> > > >> but that just seems weird. Is there a better solution ?
> > > >
> > > > (char (*)[ETH_ALEN])?  Said that, shouldn't that be doing something like
> > > > ioremap(), rather than casting explicit constants?
> > >
> > > Typecasts or even assigning the address to a variable does not help.
> > > The sanitizer function can not be static either.
> >
> > So it can only be fixed by obfuscating the constant address in a
> > chain of out-of-line functions...
> > How is this compiler to be used for bare-metal programming?
>
> I reported this as a gcc bug when I first saw it back in March:
>
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=99578
>
> Martin Sebor suggested marking the pointer as 'volatile' as a workaround,
> which is probably fine for bare-metal programming, but I would consider
> that bad style for the kernel boot arguments. The RELOC_HIDE trick is probably
> fine here, as there are only a couple of instances, and for the network
> driver, using volatile is probably appropriate as well.

Yeah, volatile should be fine for drivers.
In fact this is one of the few places where I/O registers are accessed
without involving volatile.

> I still hope this can be fixed in a future gcc-11.x release. Maybe we should
> add further instances of the problem on the gcc bug to boost the priority?
>
> > > I don't know the hardware, so I can not answer the ioremap() question.
> >
> > Yes it should.  But this driver dates back to 2.1.110, when only
> > half of the architectures already had ioremap().
>
> How does  mvme16x even create the mapping? Is this a virtual address
> that is hardwired to the bus or do you have a static mapping somewhere?

It's part of the transparent mapping of the top address space for
I/O devices in arch/m68k/kernel/head.S.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

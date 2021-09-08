Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F02C433EF
	for <sparclinux@archiver.kernel.org>; Wed,  8 Sep 2021 10:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7A3061132
	for <sparclinux@archiver.kernel.org>; Wed,  8 Sep 2021 10:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348527AbhIHKXM convert rfc822-to-8bit (ORCPT
        <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 8 Sep 2021 06:23:12 -0400
Received: from mail-vs1-f43.google.com ([209.85.217.43]:40846 "EHLO
        mail-vs1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345299AbhIHKXD (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 8 Sep 2021 06:23:03 -0400
Received: by mail-vs1-f43.google.com with SMTP id d6so1546877vsr.7;
        Wed, 08 Sep 2021 03:21:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8g1MXx8tPZJgEtHuWN2FTujyN4+VHT0fVsMeMam6ogc=;
        b=kcED//ERt5trE8d7hnPV7Qcgck0m/iuCWcHpc8bGLMS5U7rj1GS0G+dB5xUN33P+Dt
         jo5kdiQKuznjnOMk8wn3lyATBtPRBT03MC7a1UfFCGQH+p0Nyh08OmpYUPwcWeJ4sKG8
         StdQKQkc3Dy0eBgek3n/WD6ctZ899CyH0mNLp1ncbtBAgMbFuNfHKEiUV6/mQmgNJenR
         TGRiGi/DO2Q2FQl8bOnjJ5BNJhP4XpeHqz9VaUMSurXjp/EyNQO0IfPWvGliSrjWpYxt
         ChQV9S6YKeUi2smrMgNVClWNYDF6giiXl8mgp0xcuQpxFyMVL72l9/NdNv/GiJ8oYYE8
         lalw==
X-Gm-Message-State: AOAM532RL6BbbMVs+PIcHWTwMsnWTM+bKrTCs7V65oxMY80af1s230Mg
        JMLhuEbODwlNX6qpglBHydd8X5PgQQl7wPiFk6c=
X-Google-Smtp-Source: ABdhPJwesct4erqU/THhxBqimdnSW2qDvyqSXH/Z9bFCp2dBvUaImTAJYv/+9mlsSscBCDOvzxRNjcaQ/XqI3i97b5g=
X-Received: by 2002:a05:6102:b10:: with SMTP id b16mr1287001vst.41.1631096515454;
 Wed, 08 Sep 2021 03:21:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210906142615.GA1917503@roeck-us.net> <CAHk-=wgjTePY1v_D-jszz4NrpTso0CdvB9PcdroPS=TNU1oZMQ@mail.gmail.com>
 <c3790fb9-b83f-9596-18a1-21ace987c850@roeck-us.net> <CAHk-=wi4NW3NC0xWykkw=6LnjQD6D_rtRtxY9g8gQAJXtQMi8A@mail.gmail.com>
 <20210906234921.GA1394069@roeck-us.net> <20210908042838.GA2585993@roeck-us.net>
 <YThAgIhKPQZq5UZn@zeniv-ca.linux.org.uk> <f4817c3d-c051-4030-e9ca-ea8b3f846119@roeck-us.net>
 <CAMuHMdWhzL+aWosce71Xm-7dKsgXFyL42tQ2gV2HyEZp5r0N7A@mail.gmail.com> <CAK8P3a3yJHvJaFHUh2+5GPm2n_g9gSfX2rFbrSLzDt6yC4eDog@mail.gmail.com>
In-Reply-To: <CAK8P3a3yJHvJaFHUh2+5GPm2n_g9gSfX2rFbrSLzDt6yC4eDog@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 8 Sep 2021 12:21:44 +0200
Message-ID: <CAMuHMdU5SWFVvMkuEWY5hvv4aro=cGogGi-Xw+Qtden-1m7fOQ@mail.gmail.com>
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
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

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

A related one, I guess, is:

    arch/m68k/include/asm/string.h:72:25: error: argument 2 null where
non-null expected [-Werror=nonnull]
       72 | #define memcpy(d, s, n) __builtin_memcpy(d, s, n)
          |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
    drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:387:4:
note: in expansion of macro ‘memcpy’
      387 |    memcpy((char *)kmap(pages[0]) +
          |    ^~~~~~

Seen with my sun3-allmodconfig build.
As NO_DMA=y, dmam_alloc_coherent() returns NULL, and the compiler
discovers that g_fragments_base is never assigned to and thus must
be NULL.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

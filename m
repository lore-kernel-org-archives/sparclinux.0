Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F9D6C433F5
	for <sparclinux@archiver.kernel.org>; Wed,  6 Oct 2021 13:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A55860FD8
	for <sparclinux@archiver.kernel.org>; Wed,  6 Oct 2021 13:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbhJFNDx (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 6 Oct 2021 09:03:53 -0400
Received: from condef-08.nifty.com ([202.248.20.73]:56709 "EHLO
        condef-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbhJFNDx (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 6 Oct 2021 09:03:53 -0400
X-Greylist: delayed 347 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Oct 2021 09:03:52 EDT
Received: from conssluserg-06.nifty.com ([10.126.8.85])by condef-08.nifty.com with ESMTP id 196CsH2v011392
        for <sparclinux@vger.kernel.org>; Wed, 6 Oct 2021 21:54:17 +0900
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 196CrtAO003873;
        Wed, 6 Oct 2021 21:53:56 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 196CrtAO003873
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1633524836;
        bh=2urYqRpQOPLkXeqFaqK5WGjp3qwohqBRnzDNoFyjX5E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AkytsekUP+8dLZwCyk5z0xPlkYm/8Mp0dfCnumdu2uc/fgnYuV5MSYN6RosJo3hRB
         wugNicRKwHBj3Gh1+jMX079WrZOi+davLkaACgA2Ravi8eriW8Gyy5XUF9gZtWet1f
         PNwVFcEj8utSj6ZFJO1sDbtHIidOU09WO6JjStCJ/B/BpX5B7etevd1hDnniJK7hyo
         olNWIo47pC1BzTWcQOxKb4xRnZhuIGlLj2G8kdUs2Y/U1CHXiryEljufWt3JDE87Lp
         EU8SLUy7fDqQYtvjCixvBQbXTn2v9NL8LRngVGknFOkbrAAT/jdeYswWk0mVURTkFZ
         eQIkX//kJRsDA==
X-Nifty-SrcIP: [209.85.216.53]
Received: by mail-pj1-f53.google.com with SMTP id na16-20020a17090b4c1000b0019f5bb661f9so2261176pjb.0;
        Wed, 06 Oct 2021 05:53:56 -0700 (PDT)
X-Gm-Message-State: AOAM531TaeeSCRqPpGaRbCiq/nho/eCcbSJOCCkrR+5Q7EE2ismK9qSY
        z6lDT6QlZUXhFKA3dY01+uhvJV6KgDAzApKws5w=
X-Google-Smtp-Source: ABdhPJwtZ1OJRVKlgVuSgn4O8szQOkDxdm0+QT605WYDW9qZNXDVj5R8bLV+NjFqsV6Wjz7uCmiLbK7ponM2TPTHoFY=
X-Received: by 2002:a17:90a:9306:: with SMTP id p6mr10777738pjo.119.1633524835305;
 Wed, 06 Oct 2021 05:53:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210923215418.3936726-1-keescook@chromium.org>
 <YU1WYLN4eptJhuIX@deb-nschier.ads.avm.de> <202110052144.25B30F2D4F@keescook>
In-Reply-To: <202110052144.25B30F2D4F@keescook>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 6 Oct 2021 21:53:18 +0900
X-Gmail-Original-Message-ID: <CAK7LNASWgdULqBJMQMkoy=mXtAj_xxcYXXXi0wYojMkWW4ktGA@mail.gmail.com>
Message-ID: <CAK7LNASWgdULqBJMQMkoy=mXtAj_xxcYXXXi0wYojMkWW4ktGA@mail.gmail.com>
Subject: Re: [PATCH] sparc: Add missing "FORCE" target when using if_changed
To:     Kees Cook <keescook@chromium.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Nicolas Schier <n.schier@avm.de>,
        sparclinux <sparclinux@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Wed, Oct 6, 2021 at 1:45 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Sep 24, 2021 at 06:38:56AM +0200, Nicolas Schier wrote:
> > On Thu, Sep 23, 2021 at 02:54:18PM -0700, Kees Cook wrote:
> > > Fix observed warning:
> > >
> > >     /builds/linux/arch/sparc/boot/Makefile:35: FORCE prerequisite is missing
> > >
> > > Fixes: e1f86d7b4b2a5213 ("kbuild: warn if FORCE is missing for if_changed(_dep,_rule) and filechk")
> > > Cc: "David S. Miller" <davem@davemloft.net>
> > > Cc: Masahiro Yamada <masahiroy@kernel.org>
> > > Cc: sparclinux@vger.kernel.org
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> >
> > Acked-by: Nicolas Schier <n.schier@avm.de>
>
> Thanks!
>
> Masahiro, are you able to add this to your kbuild tree?

Sure, applied to linux-kbuild. Thanks.


> -Kees
>
> >
> > > ---
> > > I'm not sure if this should go via sparc or via kbuild. :)
> > > ---
> > >  arch/sparc/boot/Makefile | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/arch/sparc/boot/Makefile b/arch/sparc/boot/Makefile
> > > index 849236d4eca4..45e5c76d449e 100644
> > > --- a/arch/sparc/boot/Makefile
> > > +++ b/arch/sparc/boot/Makefile
> > > @@ -22,7 +22,7 @@ ifeq ($(CONFIG_SPARC64),y)
> > >
> > >  # Actual linking
> > >
> > > -$(obj)/zImage: $(obj)/image
> > > +$(obj)/zImage: $(obj)/image FORCE
> > >     $(call if_changed,gzip)
> > >     @echo '  kernel: $@ is ready'
> > >
> > > @@ -31,7 +31,7 @@ $(obj)/vmlinux.aout: vmlinux FORCE
> > >     @echo '  kernel: $@ is ready'
> > >  else
> > >
> > > -$(obj)/zImage: $(obj)/image
> > > +$(obj)/zImage: $(obj)/image FORCE
> > >     $(call if_changed,strip)
> > >     @echo '  kernel: $@ is ready'
> > >
> > > @@ -44,7 +44,7 @@ OBJCOPYFLAGS_image.bin := -S -O binary -R .note -R .comment
> > >  $(obj)/image.bin: $(obj)/image FORCE
> > >     $(call if_changed,objcopy)
> > >
> > > -$(obj)/image.gz: $(obj)/image.bin
> > > +$(obj)/image.gz: $(obj)/image.bin FORCE
> > >     $(call if_changed,gzip)
> > >
> > >  UIMAGE_LOADADDR = $(CONFIG_UBOOT_LOAD_ADDR)
> > > @@ -56,7 +56,7 @@ quiet_cmd_uimage.o = UIMAGE.O $@
> > >                       -r -b binary $@ -o $@.o
> > >
> > >  targets += uImage
> > > -$(obj)/uImage: $(obj)/image.gz
> > > +$(obj)/uImage: $(obj)/image.gz FORCE
> > >     $(call if_changed,uimage)
> > >     $(call if_changed,uimage.o)
> > >     @echo '  Image $@ is ready'
> > > --
> > > 2.30.2
> > >
>
> --
> Kees Cook



-- 
Best Regards
Masahiro Yamada

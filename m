Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E9F8C07E95
	for <sparclinux@archiver.kernel.org>; Wed,  7 Jul 2021 07:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 676AD61CAA
	for <sparclinux@archiver.kernel.org>; Wed,  7 Jul 2021 07:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbhGGHt6 (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 7 Jul 2021 03:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbhGGHt6 (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 7 Jul 2021 03:49:58 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB250C061574;
        Wed,  7 Jul 2021 00:47:17 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id p22so1751129yba.7;
        Wed, 07 Jul 2021 00:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4TPOrmLvXTK/lOyUIguBrYsawf0hzfPaU/71ZDPhFBY=;
        b=oF4suRKDgbX4F6O7jTJ4r9d+PDoMMhY/Z6W3uZLsXiZNVuvutzTwcHojXUaT+2R8T/
         rSronkfAeygaL6UbidUXFMGOEoXnhfW1Rxc14eiMSRQZ3e22h+NiNB49biKkqQ/nC8xU
         vI7XVV5lzNvQicOReiYxkjfOevvjKkNnQhpjzCoJFaAse0fit9eq8UKULK4jW13O5yWc
         RxipySbYRXe9+RgE1/dBHPCDkZjR5mJYcMFrf1wIHR1W9f9yYx/v0mfStfs7tBcdi5MC
         MiUhS3hZSp0/d+hTatWE0BQeSt4J+teh9p8dCXkOfkJGtSLBaGgwCsR1kYUcr35PRxb4
         bc0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4TPOrmLvXTK/lOyUIguBrYsawf0hzfPaU/71ZDPhFBY=;
        b=kGitEyvyXVMD5EQ59J9G8m5L8sguZDDEHBgnm1WrcAZxwkbRPAwctUZg/BDzKne6dk
         tf3gOps6vtlitmWx1NoCuXq2fdBRYkzc0LBTzyZZNOeUESYaKhgWjRVwtRHNDiBusgaM
         C/R811/HzELE1lh6AlOKfi4o4yE/hHRFdTGHHqA1nzqTa2WBgO8gVKwhRf0Vzx1FvEHO
         NGCkmzGEf3t2UB2FEvAR21rT2izK0RxTNU9Zri8MTyB0Z+1WJd3gqqMUjhJOP2iDGPp/
         WbELQTznpCB6F+QPCdBM0A+1lWLVelXYdCBBcMryCp/pPHTNq0yWW3FJiKLECOp3Huu/
         JI8A==
X-Gm-Message-State: AOAM530dgF0Jab6israx8XYRaq7VRSxO9xsgkpVOlvXB8yQr5ZBkQd46
        Iedor7y7u2/lYkIM/Efk/iI4zJZGGy7t43BL4Fg=
X-Google-Smtp-Source: ABdhPJxyut9g/FWzn2WJEwmrKOWmZrHqkw5OlBr5bfdsVXbwDLAuqFtbYVAYbv284vuzM83CPfKQR7ubJp1qqqUujR8=
X-Received: by 2002:a25:4109:: with SMTP id o9mr30719793yba.353.1625644036957;
 Wed, 07 Jul 2021 00:47:16 -0700 (PDT)
MIME-Version: 1.0
References: <CADxRZqzcrnSMzy50T+kWb_mQVguWDCMu6RoXsCc+-fNDPYXbaw@mail.gmail.com>
 <20210705195638.GA53988@C02TD0UTHF1T.local> <20210706091104.GA69200@C02TD0UTHF1T.local>
 <CADxRZqxNdYBAs1daPJTAPKGeJx30D+v7xz87K2sB_dXYKdTrVg@mail.gmail.com> <20210706120030.GB69200@C02TD0UTHF1T.local>
In-Reply-To: <20210706120030.GB69200@C02TD0UTHF1T.local>
From:   Anatoly Pugachev <matorola@gmail.com>
Date:   Wed, 7 Jul 2021 10:47:06 +0300
Message-ID: <CADxRZqyQq4X-p=BpkpwcKUnLJAeZBLBLZ1u9fOkp74URR4Nb0Q@mail.gmail.com>
Subject: Re: [sparc64] locking/atomic, kernel OOPS on running stress-ng
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Peter Zijlstra <peterz@lists.infradead.org>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        Sparc kernel list <sparclinux@vger.kernel.org>,
        debian-sparc <debian-sparc@lists.debian.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Tue, Jul 6, 2021 at 3:00 PM Mark Rutland <mark.rutland@arm.com> wrote:
> On Tue, Jul 06, 2021 at 02:51:06PM +0300, Anatoly Pugachev wrote:
> > On Tue, Jul 6, 2021 at 12:11 PM Mark Rutland <mark.rutland@arm.com> wrote:
> > > Fixes: ff5b4f1ed580c59d ("locking/atomic: sparc: move to ARCH_ATOMIC")
> > > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > > Reported-by: Anatoly Pugachev <matorola@gmail.com>
> > > Cc: "David S. Miller" <davem@davemloft.net>
> > > Cc: Peter Zijlstra <peterz@lists.infradead.org>
> > > ---
> > >  arch/sparc/include/asm/cmpxchg_64.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/arch/sparc/include/asm/cmpxchg_64.h b/arch/sparc/include/asm/cmpxchg_64.h
> > > index 8c39a9981187..12d00a42c0a3 100644
> > > --- a/arch/sparc/include/asm/cmpxchg_64.h
> > > +++ b/arch/sparc/include/asm/cmpxchg_64.h
> > > @@ -201,7 +201,7 @@ static inline unsigned long __cmpxchg_local(volatile void *ptr,
> > >  #define arch_cmpxchg64_local(ptr, o, n)                                        \
> > >    ({                                                                   \
> > >         BUILD_BUG_ON(sizeof(*(ptr)) != 8);                              \
> > > -       cmpxchg_local((ptr), (o), (n));                                 \
> > > +       arch_cmpxchg_local((ptr), (o), (n));                                    \
> > >    })
> > >  #define arch_cmpxchg64(ptr, o, n)      arch_cmpxchg64_local((ptr), (o), (n))
> >
> >
> > Mark, thanks, fixed...
> > tested on git kernel 5.13.0-11788-g79160a603bdb-dirty (dirty - cause
> > patch has been applied).
>
> Great! Thanks for confirming.
>
> Peter, are you happy to pick that (full commit in last mail), or should
> I send a new copy?

It would be nice if patch could hit the kernel before v5.14-rc1

Thanks.

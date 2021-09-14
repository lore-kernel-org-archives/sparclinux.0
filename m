Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 115C0C433F5
	for <sparclinux@archiver.kernel.org>; Tue, 14 Sep 2021 15:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E22BE60EE7
	for <sparclinux@archiver.kernel.org>; Tue, 14 Sep 2021 15:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233617AbhINPTH (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 14 Sep 2021 11:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbhINPTH (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Tue, 14 Sep 2021 11:19:07 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4762C061762;
        Tue, 14 Sep 2021 08:17:49 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id w144so19431787oie.13;
        Tue, 14 Sep 2021 08:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NIqISq5kyGyxn6lso7aloBgg8et/zHxKVMufJ4ZAVqU=;
        b=hQWeP0FIwUtKzXeWomGsCttQ4q1uiTlibaiX+8VKGgPFTz6cFjx9lZLqQ/5wwtfxW/
         uL71c4jBsoTfAGshka+jeOEYYmOz/mor2uHIsgb4QK5idmE2UMNZkw7JlYjNYGvZ1Ogz
         1jWxi0w5H+Rx4EeVeS/YXSkFN//okinFyiVmfXayhXg/XN/F3pkbj2LIeXB2+Q6vb2He
         M6+Gvvb9jKL2pYY+bOQjeQliIOmI+HncWa00y0UG5UpHMPlyueWQpaYdt4grC1f9Wbhg
         UA3TAOe7YOsV9JHaG0TkY6FshRBaPvDsP1ZBIgS8Zpbuf5e9z1UaFwicT2gBsSTdfhBl
         weVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=NIqISq5kyGyxn6lso7aloBgg8et/zHxKVMufJ4ZAVqU=;
        b=r8l9t7ZGP8QdDkx49LEORlorbGyP9Ykvvj/+TO9Pvpe2n9Px38rioa3GouvaiOFiat
         e0Y88r7KAB/qQE9FAzA8Y+FcTSvFLhYtOQf4kd7Jyjajgl9f9RYNr7Qf9YMgDJ88mlfq
         ivW33IYZ6o85j0ayStw7A76X9HCobCmqxynVhzflNjhVCwmtUEkLMNWUQSnNBCpnVfuw
         LbVMyjZ7jjfotGaXNn1uhA3ZskQ8nYWhbjesPpYh4VG9hj+KBY32sM9QCbSMLTb+dK3W
         YkjXOWDCkEI4qYkwoaD9FAIoUneTBSODLFPmXP0VG/E7wOIV+qPhqAvBRP8AMzHiz2Xl
         0RFA==
X-Gm-Message-State: AOAM530G8u4wTiI5SGd6rrUv20oCGPb3qFMYHvO1iUjf/2bbz01+Qm9j
        Ts3ZyS4NTVgMVE/+cy7wg7c=
X-Google-Smtp-Source: ABdhPJypTuRytG8Hj20qO41Btjs5P/8rJs8mRBuu6YJZr3+NCsokUyKXObMKggPKKVM9J3Jh7Yd8qg==
X-Received: by 2002:a05:6808:150:: with SMTP id h16mr1877835oie.25.1631632669230;
        Tue, 14 Sep 2021 08:17:49 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d8sm2564662oij.53.2021.09.14.08.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 08:17:48 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 14 Sep 2021 08:17:47 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Arnd Bergmann' <arnd@kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
        "David S . Miller" <davem@davemloft.net>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sparc: mdesc: Fix compile error seen with gcc 11.x
Message-ID: <20210914151747.GC3457579@roeck-us.net>
References: <20210913163712.922188-1-linux@roeck-us.net>
 <YT+SPIAl0IdWOAn/@ravnborg.org>
 <d0a4b46a-2f0e-f6a2-1342-777e738d9525@roeck-us.net>
 <2d8f45425f024fd9a3d91a4b4a1304cf@AcuMS.aculab.com>
 <3b069cde-6f15-1df1-fbed-e8d94d0ef173@roeck-us.net>
 <CAK8P3a1mrZHHfN0dK6nV3jpBmnYm+jG=M8j2u=1=ZPkLuf2DXQ@mail.gmail.com>
 <549b61046b134234bd4bffd85315f29a@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <549b61046b134234bd4bffd85315f29a@AcuMS.aculab.com>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Tue, Sep 14, 2021 at 03:03:51PM +0000, David Laight wrote:
> From: Arnd Bergmann
> > Sent: 14 September 2021 15:54
> > 
> > On Tue, Sep 14, 2021 at 4:24 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > > On 9/14/21 7:17 AM, David Laight wrote:
> > > >> Sorry, I didn't realize that a field of size 0 increases the structure size
> > > >> on sparc. I had checked the size of the old and the new structure with gcc
> > > >> on x86_64 and didn't see a field size increase.
> > > >
> > > > clang output doesn't change:
> > > >
> > > > https://godbolt.org/z/bTeeq19j1
> > > >
> > > > gcc ought to generate the same size.
> > > >
> > > > It ought to be 'char data[];' though.
> > > >
> > >
> > > I am never sure if [] or [0] is "correct". Anyway, is there agreement that this
> > > is an acceptable solution ? I'll be happy to resend if that is the case.
> > 
> > Yes, looks good to me, in the [] version. I think the [0] version can be
> > interpreted as a zero-length array that may not be accessed, while the
> > [] flexible array syntax clearly means that extra data follows, and it's
> > part of the C standard now, while [0] is a gcc extension.
> 
> More problematic is where is the correct place for the 'char data[]'.
> It follows the header rather than being part of it.

I personally always prefer the simple solution, and I don't really care
about such nuances. I take it as granted that a header is followed by data,
and I think that a zero-length field at the end of a header is a perfectly
valid means to express that, but that is just my personal opinion.

Anyway, I take that as non-agreement and won't resend at this time.

Thanks,
Guenter

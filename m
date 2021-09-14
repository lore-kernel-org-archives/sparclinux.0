Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF81C433EF
	for <sparclinux@archiver.kernel.org>; Tue, 14 Sep 2021 14:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F141F610E6
	for <sparclinux@archiver.kernel.org>; Tue, 14 Sep 2021 14:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234203AbhINOzL (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 14 Sep 2021 10:55:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:44334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234229AbhINOzL (ORCPT <rfc822;sparclinux@vger.kernel.org>);
        Tue, 14 Sep 2021 10:55:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 98E0C61151;
        Tue, 14 Sep 2021 14:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631631233;
        bh=UyPfgRf8uNvLL2Xoph5eeknTt2rDlA/6yr/mXz4e9fc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AErxpXCpEOQqU82TMQhzoDhGmr2/469JKSupeG6eotJUeKOVof2Kcxh6b6odFGtNr
         KKk6aG1F/Nk3uu/5UblbKBbrpFjvO5djWyEVGHMjp5xKFko8wegbT8hwv3xxYcp6/w
         gPh408iehUCBe3wVX5uHflQPuUBiDBHxHPVW0owuGhwpwdyyLoeUomxyjPTMaLjGVv
         pZ4NzSo/qLQX89eP2craJtaW5Y8EKdLjpSeV1OmbNt8I6JpAwsJ2u3ZAGU4QbBXTri
         /X1SbBnp304M4Td3rafIKWLmp71yI6T87IJn4hGGkZ4obi6cBQOcEXpIQNbNbajAfO
         +gmVXE73WU08g==
Received: by mail-wr1-f47.google.com with SMTP id g16so20737670wrb.3;
        Tue, 14 Sep 2021 07:53:53 -0700 (PDT)
X-Gm-Message-State: AOAM530TBt9UoKzI3XO/wp1FhMV6Dg5LaAClfhKuXt6s0tsBgDro8+20
        BbW9k0UGUJTJXcgi6CG1RwNfqJL+6w4oPIzzPHQ=
X-Google-Smtp-Source: ABdhPJx5ztYtEKc6yogUXMZL70X9nXnPBmct5T5kg4jZV1+wT3mtMsQKg31y65wrSbIFHbrJAKnwayH234TEtY5Vgdc=
X-Received: by 2002:adf:f884:: with SMTP id u4mr18727055wrp.411.1631631232200;
 Tue, 14 Sep 2021 07:53:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210913163712.922188-1-linux@roeck-us.net> <YT+SPIAl0IdWOAn/@ravnborg.org>
 <d0a4b46a-2f0e-f6a2-1342-777e738d9525@roeck-us.net> <2d8f45425f024fd9a3d91a4b4a1304cf@AcuMS.aculab.com>
 <3b069cde-6f15-1df1-fbed-e8d94d0ef173@roeck-us.net>
In-Reply-To: <3b069cde-6f15-1df1-fbed-e8d94d0ef173@roeck-us.net>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 14 Sep 2021 16:53:35 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1mrZHHfN0dK6nV3jpBmnYm+jG=M8j2u=1=ZPkLuf2DXQ@mail.gmail.com>
Message-ID: <CAK8P3a1mrZHHfN0dK6nV3jpBmnYm+jG=M8j2u=1=ZPkLuf2DXQ@mail.gmail.com>
Subject: Re: [PATCH] sparc: mdesc: Fix compile error seen with gcc 11.x
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     David Laight <David.Laight@aculab.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        "David S . Miller" <davem@davemloft.net>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Tue, Sep 14, 2021 at 4:24 PM Guenter Roeck <linux@roeck-us.net> wrote:
> On 9/14/21 7:17 AM, David Laight wrote:
> >> Sorry, I didn't realize that a field of size 0 increases the structure size
> >> on sparc. I had checked the size of the old and the new structure with gcc
> >> on x86_64 and didn't see a field size increase.
> >
> > clang output doesn't change:
> >
> > https://godbolt.org/z/bTeeq19j1
> >
> > gcc ought to generate the same size.
> >
> > It ought to be 'char data[];' though.
> >
>
> I am never sure if [] or [0] is "correct". Anyway, is there agreement that this
> is an acceptable solution ? I'll be happy to resend if that is the case.

Yes, looks good to me, in the [] version. I think the [0] version can be
interpreted as a zero-length array that may not be accessed, while the
[] flexible array syntax clearly means that extra data follows, and it's
part of the C standard now, while [0] is a gcc extension.

        Arnd

Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D797C433F5
	for <sparclinux@archiver.kernel.org>; Wed, 15 Sep 2021 14:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E96B361263
	for <sparclinux@archiver.kernel.org>; Wed, 15 Sep 2021 14:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234729AbhIOOF6 (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 15 Sep 2021 10:05:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:55550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236295AbhIOOF5 (ORCPT <rfc822;sparclinux@vger.kernel.org>);
        Wed, 15 Sep 2021 10:05:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C83FE61263;
        Wed, 15 Sep 2021 14:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631714678;
        bh=H27IuGY14sfE01ZBOE3qbr+Aje0qknX6KxWJUz9aISY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Mt8iYkeCpuvxp25RAeN9quGvNziHP1pgXw2GB8fKD/mymlhyyAxICQ7hbRwUyFg9Y
         Dz6lOg2rFDJ1x29vlxBrU13sefeeVpzxfxhmMneSoMVFyYNw6dgVv/qeP2+fN8Is47
         2Df2I+LHlOIw6U5A/kHf/wi/ketSqO0Jwrt5NNw8mH/ilzWxgVY7C0Co0ubil1VKC6
         0mTZqCfioBEvADdChAheA181Hb78J/ZmnwKyEjZiEi4DnVJ9GgnI5G5RLxRohXR/HG
         cAiCWcdQNM4yVMPvZMOcWEwIRFtHDlqQVihe+TYWg0OuNhev57eWppsU1mrNJYasbV
         CrubNIu5XLMDw==
Received: by mail-wm1-f46.google.com with SMTP id l7-20020a1c2507000000b002e6be5d86b3so2108261wml.3;
        Wed, 15 Sep 2021 07:04:38 -0700 (PDT)
X-Gm-Message-State: AOAM531DDI/AnaxIYwjTJl7kL5pkcS+mt92K6H74Ai7JdqYqe4Tms2J2
        1uN4iSQurMHfRqhqkOzpa7Z1o8Qzb05KJl8tLkA=
X-Google-Smtp-Source: ABdhPJyjXfJKM6vyDJu6ychD3He3pDf7+1/YRPwn/p4sPd8URfURxCd23cro1bdM922Ixa76Pgelwn3dchKZ3Lf21nE=
X-Received: by 2002:a1c:4c14:: with SMTP id z20mr4802564wmf.82.1631714677368;
 Wed, 15 Sep 2021 07:04:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210914224709.601156-1-linux@roeck-us.net>
In-Reply-To: <20210914224709.601156-1-linux@roeck-us.net>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 15 Sep 2021 16:04:22 +0200
X-Gmail-Original-Message-ID: <CAK8P3a36YHAnDyhy+nQEo9x=c2Dq8pf44sBsksXj2xb+Fnk-bA@mail.gmail.com>
Message-ID: <CAK8P3a36YHAnDyhy+nQEo9x=c2Dq8pf44sBsksXj2xb+Fnk-bA@mail.gmail.com>
Subject: Re: [PATCH v2] sparc: mdesc: Fix compile error seen with gcc 11.x
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     "David S . Miller" <davem@davemloft.net>,
        sparclinux <sparclinux@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Anatoly Pugachev <matorola@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Wed, Sep 15, 2021 at 12:47 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> sparc64 images fail to compile with gcc 11.x, reporting the following
> errors.
>
> arch/sparc/kernel/mdesc.c:647:22: error:
>         'strcmp' reading 1 or more bytes from a region of size 0
> arch/sparc/kernel/mdesc.c:692:22: error:
>         'strcmp' reading 1 or more bytes from a region of size 0
> arch/sparc/kernel/mdesc.c:719:21:
>         error: 'strcmp' reading 1 or more bytes from a region of size 0
>
> The underlying problem is that node_block() returns a pointer beyond
> the end of struct mdesc_hdr. gcc 11.x detects that and reports the error.
> Adding an additional zero-length field to struct mdesc_hdr and pointing
> to that field fixes the problem.
>
> Cc: Arnd Bergmann <arnd@kernel.org>
> Cc: David Laight <David.Laight@ACULAB.COM>
> Cc: Anatoly Pugachev <matorola@gmail.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: data[0] => data[]
>
> I am not sure if there was agreement to accept this patch or not, but
> I was asked to resend it with the above change, so here it is. An open
> question was if it is acceptable to have a structure named xxx_hdr
> include an element pointing to the data following that header.
>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

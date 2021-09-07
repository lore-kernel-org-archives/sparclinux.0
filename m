Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08486C433F5
	for <sparclinux@archiver.kernel.org>; Tue,  7 Sep 2021 01:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D088B61051
	for <sparclinux@archiver.kernel.org>; Tue,  7 Sep 2021 01:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbhIGBNb (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Mon, 6 Sep 2021 21:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbhIGBNb (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Mon, 6 Sep 2021 21:13:31 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82860C061575
        for <sparclinux@vger.kernel.org>; Mon,  6 Sep 2021 18:12:25 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id z2so16312136lft.1
        for <sparclinux@vger.kernel.org>; Mon, 06 Sep 2021 18:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=buovdfuVwAYJ1wdL40xpZvGrNDWI2KNqFgBPmPDh630=;
        b=fuQfTafv4uneL2AzwltGo4ZWCS3xmlXhvTfaWdXPcpqErjQyMz3g6ew9quCkVeUZdR
         X0gHcxtFLBJg+SYSmchrwATm1Xb1uxbZjxVz/87MUSvQntnDeHgJkbIMmJCgDwCX/vPJ
         0YlupHDDkh2Qz5u75srCW2zHTRG5msU6vsIYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=buovdfuVwAYJ1wdL40xpZvGrNDWI2KNqFgBPmPDh630=;
        b=meeZyh9mqNEt1CSd6UoWyPv2UeTwL541+XL+FgGK0rGt2BRPuY8lC7NNtnGaEoP4iV
         aK73eaELDQXW3Z/cHtnEGiQaRj2R5c0IqMIlrK+9vwCdOH+xwur/5apHwma8Aogsv27t
         G2DYNxRuvBDRh+k6q6z8mo50qrGfTmoMl5xCdDXqqNEd5bdxrSlrOM9ottQkr3AcgCEd
         U3Y98oSejnOKhaCt7TZvn5TTD6NMMtfIDlaiRp4kkC9bUJx8CVcRTrMWesmyZ6BO65Bj
         L//S7imbN91rh5ZZ90waDHkLZMI+vNcUuvJ4bPfBTvHR3eQOZIaRPkzmcMrBXdzJijXt
         lAWw==
X-Gm-Message-State: AOAM532EPlkbsLBUDN7vP8nE7pCQc1hdAHv4KXTKMRV2CypqNCp2vEG2
        JrUJUmdtI3/Qt1bjjiuJMgDnrgA92ssTY8dW
X-Google-Smtp-Source: ABdhPJzKLiWddUXxxTKfBiz0xjk0Mq2qyxkXkrg9tzyxU5ODzaSCK/rNRvjj+EC6Lo4BsBZz6DQQzQ==
X-Received: by 2002:a05:6512:1584:: with SMTP id bp4mr10912073lfb.188.1630977143336;
        Mon, 06 Sep 2021 18:12:23 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id i21sm860075lfc.92.2021.09.06.18.12.22
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Sep 2021 18:12:22 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id w4so13823139ljh.13
        for <sparclinux@vger.kernel.org>; Mon, 06 Sep 2021 18:12:22 -0700 (PDT)
X-Received: by 2002:a2e:a363:: with SMTP id i3mr12459242ljn.56.1630977142525;
 Mon, 06 Sep 2021 18:12:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210906142615.GA1917503@roeck-us.net> <CAHk-=wgjTePY1v_D-jszz4NrpTso0CdvB9PcdroPS=TNU1oZMQ@mail.gmail.com>
 <c3790fb9-b83f-9596-18a1-21ace987c850@roeck-us.net> <CAHk-=wi4NW3NC0xWykkw=6LnjQD6D_rtRtxY9g8gQAJXtQMi8A@mail.gmail.com>
 <20210906234921.GA1394069@roeck-us.net>
In-Reply-To: <20210906234921.GA1394069@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 Sep 2021 18:12:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjvfUpPJLbWz6Jezr4ZNjhC6j2WYi5MHUd9bjK94JC24A@mail.gmail.com>
Message-ID: <CAHk-=wjvfUpPJLbWz6Jezr4ZNjhC6j2WYi5MHUd9bjK94JC24A@mail.gmail.com>
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

On Mon, Sep 6, 2021 at 4:49 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> > but I'm not seeing why that one happens on sparc64, but not on arm64
> > or x86-64. There doesn't seem to be anything architecture-specific
> > anywhere in that area.
> >
> > Funky.
>
> Not really. That is because de->di_fname is always 16 bytes but size
> can be 48 if the node is really a link. The use of de is overloaded
> in that case; de is struct qnx4_inode_entry (where di_fname is 16 bytes)
> but the actual data is struct qnx4_link_info where the name is 48 bytes
> long. A possible fix (compile tested only) is below.
>
> I think the warning/error is only reported with gcc 11.x. Do you possibly
> use an older compiler for x86/arm64 ?

No. Literally the same exact version. All of them are

    gcc version 11.2.1 20210728

from F34.

I suspect it's something about the config - a sparc64 allmodconfig
presumably doesn't end up having some of the things x86-64 has enabled
(because of different core config parameters), and then optimizes
differently as a result and shows the issue that way.

Or something. <wild handwaving>

                Linus

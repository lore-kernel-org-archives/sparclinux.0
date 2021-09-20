Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70265C433EF
	for <sparclinux@archiver.kernel.org>; Mon, 20 Sep 2021 18:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 517AF60F6E
	for <sparclinux@archiver.kernel.org>; Mon, 20 Sep 2021 18:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387730AbhITS6g (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Mon, 20 Sep 2021 14:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387193AbhITS4c (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Mon, 20 Sep 2021 14:56:32 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A207CC0A88D8
        for <sparclinux@vger.kernel.org>; Mon, 20 Sep 2021 10:05:04 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id t10so64169981lfd.8
        for <sparclinux@vger.kernel.org>; Mon, 20 Sep 2021 10:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NGaD6AlZjPBokDnZ02tpVPzh3NsPwqmIjeFWkEkRoSE=;
        b=QsSxLzq+ps4dQfN/nfLkDVGEJRoUNVw2MarI+2uXV9KE0AtrzhKx+qI0WZs8h23Sn/
         CAe3GHPOAKPXLZfEibFPhZiKWJIh7VgFay4UPqOp/tI/ALdW4lwCTcJIkobR53QMS+5U
         NGuoJf50rRach+FLajqQuJW9lPW2IFgECqmXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NGaD6AlZjPBokDnZ02tpVPzh3NsPwqmIjeFWkEkRoSE=;
        b=isQWUi7U4sY9OnRAtRH6IoOyWm4lwvOGWxQxMRs5LlbLvvR4Qln5UM6vRMdl1d6/ho
         0sU7yGwRNM6F+QF5cgVr6QjPJ/r5WgUghf5vyKeH0mY5XsH40CtohBzic6mKlE8fQvCX
         SjCmJ0kFYlBB/I1KS/NSVsQm2PK53RboJeBhgdywAoOuUg/igXWfdERgGk68Zxbx3KL8
         VV285eBM+9SSPgDEpabAzOVeGlrw3BV6owKg7gvdGSV/Pc+p7CoThgQQ4QVGH2ia5C6K
         yI7J9kySiqiAC042t1lQ0gZDA72JlQLh5fhgjOKHqLrYYu1NZjpgI11sP9g4Q9TdDXCW
         bTGg==
X-Gm-Message-State: AOAM531zgpXOGTSeHK11pD/AiuzQ7r484uKuB1osQVuGv3osYKlbxatr
        iW4OZmoso9vjN7z3gYmN6u/Xw1NUi/L8db3s
X-Google-Smtp-Source: ABdhPJzQk2xOd6lf3djtycw7uFoCgvf6exzYj8LiQG5aOh0lXnX93qX2Vh1YEKLFLKV25GMFk0eXRA==
X-Received: by 2002:a2e:3910:: with SMTP id g16mr23870173lja.499.1632157501706;
        Mon, 20 Sep 2021 10:05:01 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id q18sm1797287ljp.19.2021.09.20.10.05.01
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 10:05:01 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id x27so70517776lfu.5
        for <sparclinux@vger.kernel.org>; Mon, 20 Sep 2021 10:05:01 -0700 (PDT)
X-Received: by 2002:a05:6512:b8f:: with SMTP id b15mr7635650lfv.655.1632157498590;
 Mon, 20 Sep 2021 10:04:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wirexiZR+VO=H3xemGKOMkh8OasmXaKXTKUmAKYCzi8AQ@mail.gmail.com>
 <20210920134424.GA346531@roeck-us.net> <CAHk-=wgheheFx9myQyy5osh79BAazvmvYURAtub2gQtMvLrhqQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgheheFx9myQyy5osh79BAazvmvYURAtub2gQtMvLrhqQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 20 Sep 2021 10:04:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgnSFePkt9_TxgdgFvMz6ZyofLFQLuV_Tc7MQVXYdgSng@mail.gmail.com>
Message-ID: <CAHk-=wgnSFePkt9_TxgdgFvMz6ZyofLFQLuV_Tc7MQVXYdgSng@mail.gmail.com>
Subject: Re: Linux 5.15-rc2
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-sparc <sparclinux@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Mon, Sep 20, 2021 at 9:18 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Anyway, this email ended up being a long explanation of what the code
> _should_ do, in the hope that some enterprising kernel developer
> decides "Oh, this sounds like an easy thing to fix". But you do need
> to be able to test the end result at least a tiny bit.

In the meantime, the build fix is trivial: make that broken sparc
pci_iounmap() definition depend on CONFIG_PCI being set.

But let me build a few more sparc configs (and this time do it
properly for both 32-bit and 64-bit) before I actually commit it and
push it out.

              Linus

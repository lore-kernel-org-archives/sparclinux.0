Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2BBAC433FE
	for <sparclinux@archiver.kernel.org>; Tue, 21 Sep 2021 02:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9007E61183
	for <sparclinux@archiver.kernel.org>; Tue, 21 Sep 2021 02:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351298AbhIUCjb (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Mon, 20 Sep 2021 22:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239973AbhIUB7r (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Mon, 20 Sep 2021 21:59:47 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F246CC08EB22
        for <sparclinux@vger.kernel.org>; Mon, 20 Sep 2021 11:04:19 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id y28so69567188lfb.0
        for <sparclinux@vger.kernel.org>; Mon, 20 Sep 2021 11:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C96pDQyYyFg5qDGVLf3sLPlA5hQ7a8vVkj08bMsCj8M=;
        b=EGycjJn+wnDLv4w5lW3U5Wn7gsAcaf6LTG1FqdE09AUzqmx2sOt3hXMLK/y4zNH99+
         fl7CiEBkM9aBwsZrcqA4birLn9joAVXIKzRyWchC462H9YmTKBBw+fnnMc/T3VbhuGn3
         Xr99GVBCb/6unRKmeB3xNNMDiBYkcm1rJQ8Fs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C96pDQyYyFg5qDGVLf3sLPlA5hQ7a8vVkj08bMsCj8M=;
        b=NrBn+Go0KU7EhPNCLld6qjS6QE7RCt1f28H9nTD6G8zU/h3XI6TVosEb94Ne2dYhxO
         TsoooHKkaRpzXEYoy+J7G/bNRoPMiAUr+125RGRcvGr9dL0BE4e4pOOA/na+azWCb8x/
         mjKCEW9cmwQggT3jptV3rgJi7Y104mlrjdr7CcKmbWtfHnCr4prDgpQhUxhj/howRVCW
         Q+z4OhdiNYHvYT9ICpv3Hugam4VrnAQqDRV2xOXlan9Mw8zN9v2OoLt1D3HaFooNrqj4
         c5QSCAGLAjB0SBMAJPbwBC9gPWfI4+A7aaGitTzsN6uWW+eZvGp4yfl/mXTjDV+VJpN+
         UMvw==
X-Gm-Message-State: AOAM531PXsyWgy5YJyYZIhXpSED80qj9NgOBe2DuDmfuqEPXU0VYAsFc
        YqaqWST9x2Cvt4+UO3zWlsDw408ivhtTcsgC
X-Google-Smtp-Source: ABdhPJyYQ20Pqh7z399eJFNBDz3IbGZqxpHjEGh9AHJZzEq73NzEwpR0jHIlExI/jjUK9iDdIfYLuw==
X-Received: by 2002:a05:6512:1392:: with SMTP id p18mr20439058lfa.437.1632161055234;
        Mon, 20 Sep 2021 11:04:15 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id s10sm1679392lji.67.2021.09.20.11.04.14
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 11:04:14 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id m3so68681932lfu.2
        for <sparclinux@vger.kernel.org>; Mon, 20 Sep 2021 11:04:14 -0700 (PDT)
X-Received: by 2002:a05:651c:1250:: with SMTP id h16mr4886099ljh.68.1632161051649;
 Mon, 20 Sep 2021 11:04:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wirexiZR+VO=H3xemGKOMkh8OasmXaKXTKUmAKYCzi8AQ@mail.gmail.com>
 <20210920134424.GA346531@roeck-us.net> <CAHk-=wgheheFx9myQyy5osh79BAazvmvYURAtub2gQtMvLrhqQ@mail.gmail.com>
 <CAHk-=wgnSFePkt9_TxgdgFvMz6ZyofLFQLuV_Tc7MQVXYdgSng@mail.gmail.com>
In-Reply-To: <CAHk-=wgnSFePkt9_TxgdgFvMz6ZyofLFQLuV_Tc7MQVXYdgSng@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 20 Sep 2021 11:03:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg9Th7A8eGiWK4gY8fGG41k6J3JQhip=4NCa9xUR7kMVQ@mail.gmail.com>
Message-ID: <CAHk-=wg9Th7A8eGiWK4gY8fGG41k6J3JQhip=4NCa9xUR7kMVQ@mail.gmail.com>
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

On Mon, Sep 20, 2021 at 10:04 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> But let me build a few more sparc configs (and this time do it
> properly for both 32-bit and 64-bit) before I actually commit it and
> push it out.

Actually, I think I _had_ tested sparc64 properly before, it's just
that I had only done the bigger configurations that had CONFIG_PCI
enabled and that didn't show the failure due to that.

But I have now done the allnoconfig and tinyconfig builds that showed
the problem, and verified that the trivial "depend on CONFIG_PCI"
fixes things for me.

Looks like the only remaining problem in your build configuration list
that isn't queued up somewhere is that odd nouveau use of pwrsrc and
the errno range thing. I'll apply it directly.

I'm sure that other configs will have a lot of other cases, but it is
good to see at least your set shrinking.

            Linus

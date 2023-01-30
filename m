Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFA3C05027
	for <sparclinux@archiver.kernel.org>; Mon, 30 Jan 2023 01:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234004AbjA3BgR (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Sun, 29 Jan 2023 20:36:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjA3BgQ (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Sun, 29 Jan 2023 20:36:16 -0500
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E9B19F1B
        for <sparclinux@vger.kernel.org>; Sun, 29 Jan 2023 17:36:15 -0800 (PST)
Received: by mail-vk1-xa2b.google.com with SMTP id l129so5059928vkh.6
        for <sparclinux@vger.kernel.org>; Sun, 29 Jan 2023 17:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b0Mic7GKL4N/y1hjzEZDBJNa8o16mwGG4oqZUjeMQmI=;
        b=wuVVSA88CSh8e96SliMukxAUr6oxB+MqD2LlifFN1inXZs1DEfoZXi395gt9ilcC7g
         jBu8o0EJWRHeOk/08pEwogP/4drNsDFveEmunoeT92pO/DzYNGrZUXGBgSB5IMHjHoOE
         h0G55/xmMAxDph7Z3zAJ1yGvG6DS0n/6YLplShyaOVEV9mgn9EQhQ+CnwPXKnVtWdHF3
         7BcjIDbg8JXeYik/NpcU19Us02aLdqyoZ+PZSHcf69stOqlHB5EL/A1QlEATCCl4GpwY
         UT0SDkL1iG9Z/uM3gSI4Z6s5qcn879Z+wyyerYcNdpEV4EEPEnCk/rC7NakZhO06eQPB
         ya3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b0Mic7GKL4N/y1hjzEZDBJNa8o16mwGG4oqZUjeMQmI=;
        b=pXmjghTZzXw35KyPVWwXe+ho4RALRE1568VqatRDgQn9c/pXINwW54f55NwnLzNBfR
         t2jMyLnvFQJriRZ3OPEwa94UwKDtbXXOSmNRS3cE/SIjk0QM7PcR2Wxiu7cI8BwPEOjx
         W7hj7elfvmOFmLsCtj5Xk9C2pZiW1mJX6u6eOroblnHrkXQowv9FSB9ThzOMuypvxPWT
         fgNLH6KGalydThsWJlCRCqcuJt+eCQoGefRI6XDjBFuajZjwaZUp7D/1zQLjLyMyZGgy
         gtB5RPHgAY8KgqYWJ4CNV1aDePmtU+gUpCpz2J3nx/vfyulpuocJCkK4ovfKqSvpjanH
         xuuQ==
X-Gm-Message-State: AFqh2krEVpyNDsPZjuaa3VLh00EghU/yuLoL36LMmDpAYus0E4PY5FtW
        601cYYF84caUtuj0YDdEEGQm4sQrKi6d2GD+/h2UQA==
X-Google-Smtp-Source: AMrXdXs8NqbH4wKmN5lqGURkFNYAQ0NbT8FgOm3q4ilQ60x0Cd/mmexe1pWPP28IFEW+oKNIlHu1328DzLkC+F2LvvI=
X-Received: by 2002:a1f:9d58:0:b0:3e1:9f39:5c46 with SMTP id
 g85-20020a1f9d58000000b003e19f395c46mr6037580vke.20.1675042572859; Sun, 29
 Jan 2023 17:36:12 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6130:1015:b0:559:9619:d862 with HTTP; Sun, 29 Jan 2023
 17:36:12 -0800 (PST)
X-Originating-IP: [24.53.241.20]
In-Reply-To: <Y9bvwz4FIOQ+D8c4@x1n>
References: <CADyTPExpEqaJiMGoV+Z6xVgL50ZoMJg49B10LcZ=8eg19u34BA@mail.gmail.com>
 <Y9bvwz4FIOQ+D8c4@x1n>
From:   Nick Bowler <nbowler@draconx.ca>
Date:   Sun, 29 Jan 2023 20:36:12 -0500
Message-ID: <CADyTPEzvCLoMWJwfTMQZOkNXUgao5ZydUkD_bLewi9K5fCf2vg@mail.gmail.com>
Subject: Re: PROBLEM: sparc64 random crashes starting w/ Linux 6.1 (regression)
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
        regressions@lists.linux.dev,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On 2023-01-29, Peter Xu <peterx@redhat.com> wrote:
> There's a similar report previously but interestingly it was exactly
> reported against commit 0ccf7f168e17, which was the one you reported all
> good:
>
> https://lore.kernel.org/all/20221021160603.GA23307@u164.east.ru/
>
> It's probably because for some reason the thp split didn't really happen in
> your system (maybe thp disabled?) or it should break too.

This seems an accurate assessment: CONFIG_TRANSPARENT_HUGEPAGE is not set

> It also means 624a2c94f5b7a didn't really fix all the issues.  So I assumed
> that's the only issue we had after verified with 624a2c94f5b7a on two
> existing reproducers and we assumed all issues fixed.
>
> However then with this report I looked into the whole set and I did notice
> the page migration code actually has similar problem.  Sorry I should have
> noticed this even earlier.  So very likely the previous two reports came
> from environment where page migration is either rare or not enabled.  And
> now I suspect your system has page migration enabled.

I'd say that sounds correct too: I have CONFIG_COMPACTION=y which sets
CONFIG_MIGRATION=y

> Could you try below patch to see whether it fixes your problem?  It should
> cover the last piece of possible issue with dirty bit on sparc after that
> patchset.  It's based on latest master branch (commit ab072681eabe1ce0).

I applied this on top of 6.2-rc6 and will give this a spin now.

Thanks,
  Nick

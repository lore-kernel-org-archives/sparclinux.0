Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864B3C636D3
	for <sparclinux@archiver.kernel.org>; Sun,  5 Feb 2023 20:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjBEUlw (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Sun, 5 Feb 2023 15:41:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjBEUlp (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Sun, 5 Feb 2023 15:41:45 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20321C5B3
        for <sparclinux@vger.kernel.org>; Sun,  5 Feb 2023 12:41:38 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id ud5so29003775ejc.4
        for <sparclinux@vger.kernel.org>; Sun, 05 Feb 2023 12:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nA/a76A+HUu/p3q1j/ksBjPXLniSmCFkRwLsRUtoauc=;
        b=RAXg4fKD/6SPLwBhZz74xHccwCI6WZIYpGpGHWQ9ObJeCvGoohTSAtwCqfiD+ZaDQ1
         aIRLI8OL+avYEEBlM4uINCdq7A3GKoZhraxTCpB9pYCimwQ4kIElEWhkml7G/7PEKTT6
         Vy21ly1st4HkkM+1bI4kXV+bK57J6A6HvWAas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nA/a76A+HUu/p3q1j/ksBjPXLniSmCFkRwLsRUtoauc=;
        b=K/CSDqv1dCuzbyMqAK1pGI6puUGpvag8/JYp0Im3i/LegcMJeB74qh2Wh5rKYpYRCg
         Btrswj9YVvZCpcOi1Afe7+A3oBc3dlwbA6WwNVUTwvNKpiiJPoNNhHAiTggzqFSVvwDj
         y2Sxb4tvDIJM8rnDuGsnpbtmv9d0/fZO4JjqJeO/ARey9XNpcM9f/kjVbJFwZRRTTlRW
         cNnMUjOnLw9oKK7kYtJ3XzrkoWrNCYKgFOqzKg67bnk0NYNJTmmA28h6pcrKJ2Vmc0/F
         te3EXs3ii20S7V1XWnyJgHp11LX4UymUYwSYt6HxQ6E0+8+klm01mWg1o+kGz9ETVORb
         +NCg==
X-Gm-Message-State: AO0yUKVt53acAnghz87ca5qMy67HL+r5yM/ENOGOsqTr0ERIO1XztXEF
        kCfWsMmn2lKDn5SuN1hO8hwzD23gvLtTD2lCtGU=
X-Google-Smtp-Source: AK7set9fdQHAwln2EmWLPrtA9FrOL0iSfPu8ajHj7eEBlCO6KO3HWiha9Oyo0RyhCK+2w6s0dguJ7Q==
X-Received: by 2002:a17:906:8a70:b0:84c:a863:ebe6 with SMTP id hy16-20020a1709068a7000b0084ca863ebe6mr15914992ejc.43.1675629697232;
        Sun, 05 Feb 2023 12:41:37 -0800 (PST)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id me17-20020a170906aed100b0083f91a32131sm4525487ejb.0.2023.02.05.12.41.35
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Feb 2023 12:41:36 -0800 (PST)
Received: by mail-ej1-f50.google.com with SMTP id m2so28944131ejb.8
        for <sparclinux@vger.kernel.org>; Sun, 05 Feb 2023 12:41:35 -0800 (PST)
X-Received: by 2002:a17:906:892:b0:87a:7098:ca09 with SMTP id
 n18-20020a170906089200b0087a7098ca09mr4402604eje.78.1675629695651; Sun, 05
 Feb 2023 12:41:35 -0800 (PST)
MIME-Version: 1.0
References: <Y9lz6yk113LmC9SI@ZenIV> <Y9l0aBPUEpf1bci9@ZenIV>
 <92a4aa45-0a7c-a389-798a-2f3e3cfa516f@linux-m68k.org> <Y+AUEJpWYdUzW0OD@ZenIV>
In-Reply-To: <Y+AUEJpWYdUzW0OD@ZenIV>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 5 Feb 2023 12:41:18 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh8+LsDDd8AFMwaYHAA+eLT8O2ziEJfpoeo_H6MCg2NKg@mail.gmail.com>
Message-ID: <CAHk-=wh8+LsDDd8AFMwaYHAA+eLT8O2ziEJfpoeo_H6MCg2NKg@mail.gmail.com>
Subject: Re: [PATCH 04/10] m68k: fix livelock in uaccess
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Finn Thain <fthain@linux-m68k.org>, linux-arch@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        Michal Simek <monstr@monstr.eu>,
        Dinh Nguyen <dinguyen@kernel.org>,
        linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Sun, Feb 5, 2023 at 12:39 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> BTW, since these patches would be much easier to backport than any unification
> work, I think the right thing to do would be to have further unification done on
> top of them.

Ack. I'm not NAKing the patches, I was just hoping that we also have
some way forward.

So "fix the issues, then unify" sounds like the right thing to do to me.

               Linus

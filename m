Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D50C433ED
	for <sparclinux@archiver.kernel.org>; Fri, 14 May 2021 19:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D456D61454
	for <sparclinux@archiver.kernel.org>; Fri, 14 May 2021 19:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbhENTbQ (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 14 May 2021 15:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbhENTbQ (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 14 May 2021 15:31:16 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5D0C061574
        for <sparclinux@vger.kernel.org>; Fri, 14 May 2021 12:30:04 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id i9so37985384lfe.13
        for <sparclinux@vger.kernel.org>; Fri, 14 May 2021 12:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l72hh61/tsn5KiliU7+ZN3a6OPF8Vv4B7h1Pke4bt3c=;
        b=aWXI51EnV/k9pge5GKaDOkkJQD5K/MYP7A5XMnLlSW2Sy2l/sTiI3B9cP8d8ZTB5m2
         R3v2CKeD8i8Tb7rfnKNvLFWu6ekM3Dp1YyH8ufyfZgWCClPGJSZE/oeAn63KZeLaEQ45
         fGizC1SmBVw+3SgkMIXS5j/6qsc7gTws56N4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l72hh61/tsn5KiliU7+ZN3a6OPF8Vv4B7h1Pke4bt3c=;
        b=W7cvSGbahseAJ0Eqp/sBhmUC5PyCHvLM57AaOBeW1qAk4TfhWtiWgz7bTgEzpcnebx
         Ew7bxY511WZU8k8bh86zuGgVX62nb+hri6Q8POmURyE4qWFBm7uTpJIqUQKcrEqLoJ33
         c6O9xjPJP8J4f1+bZ33wkqhnrO3FJfMZ23/IClfiaOOSx0Ijs3cG9V1UcWCsNIBiOTxQ
         nmWoFI8kHBCaVklw1AyLxThfKP1ja0jHXKVKjk4LFtU0GYeLEugjoGplFxttcjHpng/4
         1dj4dwcYBHjMs1fh8v30tvMR+bWyJiOKy0r4/5r/g3jbVQNhX1Bhl/XY64d1oxkPf4fJ
         MGlg==
X-Gm-Message-State: AOAM532OgJZlOFWcRphfvZvdfJY9EtDP3q/erm8B9tG0VvxzWl+mgSzx
        c/7R91/1cOr+0RHDDgL4KTcAKRrx1HLSi2IYdEs=
X-Google-Smtp-Source: ABdhPJwmZ2MLkx9Mz3vpFTq0o8ZSljLwbySe5N1GCp3Lw70mHqWv8HKrVRqGn7FU2ZyCLAQTkgcEGg==
X-Received: by 2002:ac2:5deb:: with SMTP id z11mr33265334lfq.367.1621020602590;
        Fri, 14 May 2021 12:30:02 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id g19sm1369491lja.139.2021.05.14.12.30.02
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 12:30:02 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id r5so27343745lfr.5
        for <sparclinux@vger.kernel.org>; Fri, 14 May 2021 12:30:02 -0700 (PDT)
X-Received: by 2002:a05:651c:33a:: with SMTP id b26mr40099556ljp.220.1621020178319;
 Fri, 14 May 2021 12:22:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210514100106.3404011-1-arnd@kernel.org> <CAHk-=whGObOKruA_bU3aPGZfoDqZM1_9wBkwREp0H0FgR-90uQ@mail.gmail.com>
 <2408c893-4ae7-4f53-f58c-497c91f5b034@synopsys.com>
In-Reply-To: <2408c893-4ae7-4f53-f58c-497c91f5b034@synopsys.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 14 May 2021 12:22:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wih8UHDwJ8x6m-p0PQ7o4S4gOBwGNs=w=q10GNY7A-70w@mail.gmail.com>
Message-ID: <CAHk-=wih8UHDwJ8x6m-p0PQ7o4S4gOBwGNs=w=q10GNY7A-70w@mail.gmail.com>
Subject: Re: [PATCH v2 00/13] Unify asm/unaligned.h around struct helper
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Borislav Petkov <bp@alien8.de>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        James Morris <jmorris@namei.org>, Jens Axboe <axboe@kernel.dk>,
        John Johansen <john.johansen@canonical.com>,
        Jonas Bonn <jonas@southpole.se>,
        Kalle Valo <kvalo@codeaurora.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Rich Felker <dalias@libc.org>,
        "Richard Russon (FlatCap)" <ldm@flatcap.org>,
        Russell King <linux@armlinux.org.uk>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Stafford Horne <shorne@gmail.com>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linux-sparc <sparclinux@vger.kernel.org>,
        "linux-ntfs-dev@lists.sourceforge.net" 
        <linux-ntfs-dev@lists.sourceforge.net>,
        linux-block <linux-block@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Fri, May 14, 2021 at 11:52 AM Vineet Gupta
<Vineet.Gupta1@synopsys.com> wrote:
>
> Wasn't the new zlib code slated for 5.14. I don't see it in your master yet

You're right, I never actually committed it, since it was specific to
ARC and -O3 and I wasn't entirely happy with the amount of testing it
got (with Heiko pointing out that the s390 stuff needed more fixes for
the change).

So in fact it's not even queued up for 5.14 due to this all, I just dropped it.

> >   and the biggy
> > case didn't even use "get_unaligned()").
>
> Indeed this series is sort of orthogonal to that bug, but IMO that bug
> still exists in 5.13 for -O3 build, granted that is not enabled for !ARC.

Right, the zlib bug is still there.

But Arnd's series wouldn't even fix it: right now inffast has its own
- ugly and slow - special 2-byte-only version of "get_unaligned()",
called "get_unaligned16()".

And because it's ugly and slow, it's not actually used for
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS.

Vineet - maybe the fix is to not take my patch to update to a newer
zlib, but to just fix inffast to use the proper get_unaligned(). Then
Arnd's series _would_ actually fix all this..

              Linus

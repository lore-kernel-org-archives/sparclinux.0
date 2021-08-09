Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A80C4338F
	for <sparclinux@archiver.kernel.org>; Mon,  9 Aug 2021 11:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19DEB61004
	for <sparclinux@archiver.kernel.org>; Mon,  9 Aug 2021 11:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235196AbhHILce (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Mon, 9 Aug 2021 07:32:34 -0400
Received: from mail-vk1-f173.google.com ([209.85.221.173]:44895 "EHLO
        mail-vk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235183AbhHILce (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Mon, 9 Aug 2021 07:32:34 -0400
Received: by mail-vk1-f173.google.com with SMTP id n198so2893600vkc.11;
        Mon, 09 Aug 2021 04:32:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mxj7N5l+b6Ocx4OGg4kcLd2JjUTHm+lBGfue7CumrBY=;
        b=BN+TNEis+XtWOynXwScQmCRpb7Nx9IdHEiAqgkxRPw1iIPjyl3nC5K64oZBOgcRjSo
         3o37EDOhAbGNILFu3km1hH9wPIaVoT1eg0tzyqfDfa2wTNMRQiVSCikxdyyhLjbc7yZM
         IRcBXkARt8EgAGfCot7iBiMLjVl9Akg3/NGF4617JmsR4Mnx35YQPTuIqcprct6C1p/X
         5wnooWYL/3/mb19C4zctv2zBZr1RYv+LCzBioccffWyjSj1dSE9l2Mq4T/fbQp5c9scC
         0ltgnGZRF4CCSuBab6CmkTtyy8wJYjK3TeR4BJbM2TjcpedA1FJT7fqYSqx0SnfN2z7E
         5dsw==
X-Gm-Message-State: AOAM532/xVSvM9yDoXF/8ANJDl1W2EQFGr9Z4/kFS8FT05QYWB3oBEb/
        QL9lzcYHNZoTMt1PgIFoc5d4i3QWCpcASwzhmCXHCTktz0ptqg==
X-Google-Smtp-Source: ABdhPJx3wAYkRm3eJ+66cSDjS8+PNQXarfaMmWelDYznJPqBIfXcwRcmEQZsQpKVkJcV+6qXUld4wYZQW+kt2AXQ5Dc=
X-Received: by 2002:a1f:99cf:: with SMTP id b198mr573186vke.2.1628508733075;
 Mon, 09 Aug 2021 04:32:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210809075016.414276-1-geert@linux-m68k.org>
In-Reply-To: <20210809075016.414276-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 9 Aug 2021 13:32:02 +0200
Message-ID: <CAMuHMdUDPic==++UDbdTWTa_a+qThiJ2_8uYw6gNe_v0Rn4XpA@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.14-rc5
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     sparclinux <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Mon, Aug 9, 2021 at 11:51 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> JFYI, when comparing v5.14-rc5[1] to v5.14-rc4[3], the summaries are:
>   - build errors: +4/-9

  + error: arch/sparc/kernel/head_32.o: relocation truncated to fit:
R_SPARC_WDISP22 against `.init.text':  => (.head.text+0x5040),
(.head.text+0x5100)
  + error: arch/sparc/kernel/head_32.o: relocation truncated to fit:
R_SPARC_WDISP22 against symbol `leon_smp_cpu_startup' defined in .text
section in arch/sparc/kernel/trampoline_32.o:  => (.init.text+0xa4)
  + error: arch/sparc/kernel/process_32.o: relocation truncated to
fit: R_SPARC_WDISP22 against `.text':  => (.fixup+0xc), (.fixup+0x4)
  + error: arch/sparc/kernel/signal_32.o: relocation truncated to fit:
R_SPARC_WDISP22 against `.text':  => (.fixup+0x4), (.fixup+0x34),
(.fixup+0x1c), (.fixup+0x10), (.fixup+0x28)

sparc64/sparc-allmodconfig

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/36a21d51725af2ce0700c6ebcb6b9594aac658a6/ (182 out of 189 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/c500bee1c5b2f1d59b1081ac879d73268ab0ff17/ (182 out of 189 configs)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

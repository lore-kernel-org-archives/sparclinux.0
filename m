Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6ED6C072A2
	for <sparclinux@archiver.kernel.org>; Sun, 19 Nov 2023 19:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjKSTef convert rfc822-to-8bit (ORCPT
        <rfc822;sparclinux@archiver.kernel.org>);
        Sun, 19 Nov 2023 14:34:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjKSTee (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Sun, 19 Nov 2023 14:34:34 -0500
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B519EA4;
        Sun, 19 Nov 2023 11:34:30 -0800 (PST)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5c9169300caso12670567b3.2;
        Sun, 19 Nov 2023 11:34:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700422470; x=1701027270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=adTtj6Nuat+3kPZs0twhHhp0MgcrTsqJHcTyGQnaplM=;
        b=tRSIiG2RMs4wXZEi9Lv4GsIEzPx0E5S9Vow2Ewv3CXBHZDtl9voroXC//387PtDN4c
         Kv7gY9WJpJ0v+TbBDJw/w1X+ZYjdCetv9tHRSZA1YleTO7aq1yJP1+nKGgzMkirKC+X9
         wyrWWPIIUuuww5wtfbkmR9VzyuANeJL7/ec7vDjzTiQFEKQGRmeYpFRxay7s+rFEAD/r
         JQSuGLw4zWrPtWqkWW/HAGqGvvQo0aCSxzoygOlUnuHAOevyZvLMTtaqWiCcTpFiqxLr
         nQqwALAX2K7ELKXDZGlGRV+8XSLop4ZkJchN2pAY2HxK21uleuJXLuTvwWyJjtA1guaX
         pqkA==
X-Gm-Message-State: AOJu0YwT/3UFyRdFXwowGx+eRVS8ibprmmXWcP9CkeNFs5gWuZ1u2j0G
        Gt+BPAIMy4Jx5ZrGreMPf2YpqMWNhGdg6A==
X-Google-Smtp-Source: AGHT+IHRGAmYwxfdBbSD1094cjJKxMqRnAoPvUG0JNV65/DztmKQtHNYcd1s9a1d3zMDoa/+dYCtlQ==
X-Received: by 2002:a81:4742:0:b0:5a7:d937:6f27 with SMTP id u63-20020a814742000000b005a7d9376f27mr5036802ywa.19.1700422469793;
        Sun, 19 Nov 2023 11:34:29 -0800 (PST)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id c7-20020a81df07000000b005a815346d95sm1863106ywn.71.2023.11.19.11.34.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Nov 2023 11:34:27 -0800 (PST)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5ca8c606bb7so1057327b3.1;
        Sun, 19 Nov 2023 11:34:27 -0800 (PST)
X-Received: by 2002:a0d:e004:0:b0:5a8:207b:48d with SMTP id
 j4-20020a0de004000000b005a8207b048dmr5075104ywe.11.1700422467692; Sun, 19 Nov
 2023 11:34:27 -0800 (PST)
MIME-Version: 1.0
References: <20231118100827.1599422-1-wangkefeng.wang@huawei.com>
In-Reply-To: <20231118100827.1599422-1-wangkefeng.wang@huawei.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 19 Nov 2023 20:34:16 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU+MMiogx6TcBwxFL7AODZYhiAZpVHiafEBfnRsDaXTog@mail.gmail.com>
Message-ID: <CAMuHMdU+MMiogx6TcBwxFL7AODZYhiAZpVHiafEBfnRsDaXTog@mail.gmail.com>
Subject: Re: [PATCH] asm/io: remove unnecessary xlate_dev_mem_ptr() and unxlate_dev_mem_ptr()
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Russell King <linux@armlinux.org.uk>,
        Brian Cain <bcain@quicinc.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Sat, Nov 18, 2023 at 11:09 AM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> The asm-generic/io.h already has default definition, remove unnecessary
> arch's defination.
>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Brian Cain <bcain@quicinc.com>
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

>  arch/m68k/include/asm/io_mm.h  | 6 ------

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

>  arch/sh/include/asm/io.h       | 7 -------

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/arch/mips/include/asm/io.h
> +++ b/arch/mips/include/asm/io.h
> @@ -548,13 +548,6 @@ extern void (*_dma_cache_inv)(unsigned long start, unsigned long size);
>  #define csr_out32(v, a) (*(volatile u32 *)((unsigned long)(a) + __CSR_32_ADJUST) = (v))
>  #define csr_in32(a)    (*(volatile u32 *)((unsigned long)(a) + __CSR_32_ADJUST))
>
> -/*
> - * Convert a physical pointer to a virtual kernel pointer for /dev/mem
> - * access
> - */
> -#define xlate_dev_mem_ptr(p)   __va(p)
> -#define unxlate_dev_mem_ptr(p, v) do { } while (0)
> -
>  void __ioread64_copy(void *to, const void __iomem *from, size_t count);

Missing #include <asm-generic/io.h>, according to the build bot report.

>  #endif /* _ASM_IO_H */

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

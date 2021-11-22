Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F16C433F5
	for <sparclinux@archiver.kernel.org>; Mon, 22 Nov 2021 13:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbhKVN1p (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Mon, 22 Nov 2021 08:27:45 -0500
Received: from mail-vk1-f181.google.com ([209.85.221.181]:45672 "EHLO
        mail-vk1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238762AbhKVN1a (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Mon, 22 Nov 2021 08:27:30 -0500
Received: by mail-vk1-f181.google.com with SMTP id m19so10192130vko.12;
        Mon, 22 Nov 2021 05:24:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=xarPnle33Vd1NAVNINArZXI9fdyD3SNGNTfacLEzKQo=;
        b=KlvqecfGlnvLsbqzdvLgF1ojXbslWMuSdk/wAYQr5jUfxBQNFCOLNvOJXYr+9n9SEa
         x3T6U5StVu5fxjlHcWbZgyvBPX0zmHoFCqUbSh8HEk5VqEnFQMBkGjsRL7cntcWOlxM3
         QZPz3xvQs/PxHlwQrBIK25tJDIG8fjOaW5hss6Dusw9teuN9o5KOiNtD5l6ym3lJW3AQ
         w8JKJABXOHawKdjzJXq6q8ELbCyzxcevfSmE27jc2AkrRW8v55eOn/gq/mGSMmfWrwnj
         if2NXe7tHfZQDmZwB5RX/PBhEHPMlBTWRdvqoJtGfTYz+Pil5baFdUfEeJyTX9i1rc1z
         UTPA==
X-Gm-Message-State: AOAM531N3z0NXGHIYd1HO++s3Q3I6+WQngo/dhjLJtwnGsWDH4w6nFaj
        vaYHSQ94j13uKPM3diuB1ZFP7H3+qazSKQ==
X-Google-Smtp-Source: ABdhPJx17RU7ui0kgi1UHf+x9k2YHeHRASiW4eZAW7C52J/pinnD1Z08naWOHNtNRf31yqjTwWNZIg==
X-Received: by 2002:a05:6122:1803:: with SMTP id ay3mr163411550vkb.24.1637587463141;
        Mon, 22 Nov 2021 05:24:23 -0800 (PST)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id e13sm4376235vkd.21.2021.11.22.05.24.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Nov 2021 05:24:22 -0800 (PST)
Received: by mail-ua1-f43.google.com with SMTP id j14so26638821uan.10;
        Mon, 22 Nov 2021 05:24:22 -0800 (PST)
X-Received: by 2002:a9f:248b:: with SMTP id 11mr85736008uar.14.1637587462423;
 Mon, 22 Nov 2021 05:24:22 -0800 (PST)
MIME-Version: 1.0
References: <20211122111214.3801534-1-geert@linux-m68k.org>
In-Reply-To: <20211122111214.3801534-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 22 Nov 2021 14:24:11 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW7jcoNHyBomcbkkHU-m32uAureeHYj_PhaMC=O2b4wLA@mail.gmail.com>
Message-ID: <CAMuHMdW7jcoNHyBomcbkkHU-m32uAureeHYj_PhaMC=O2b4wLA@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.16-rc2
To:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-um@lists.infradead.org, sparclinux@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Mon, Nov 22, 2021 at 12:28 PM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Below is the list of build error/warning regressions/improvements in
> v5.16-rc2[1] compared to v5.15[2].
>
> Summarized:
>   - build errors: +13/-12
>   - build warnings: +3/-26
>
> JFYI, when comparing v5.16-rc2[1] to v5.16-rc1[3], the summaries are:
>   - build errors: +6/-12

  + /kisskb/src/drivers/mtd/nand/raw/mpc5121_nfc.c: error: unused
variable 'mtd' [-Werror=unused-variable]:  => 294:19

ppc32_allmodconfig (patch sent)

  + /kisskb/src/drivers/video/fbdev/nvidia/nvidia.c: error: passing
argument 1 of 'iounmap' discards 'volatile' qualifier from pointer
target type [-Werror=discarded-qualifiers]:  => 1439:10, 1414:10
  + /kisskb/src/drivers/video/fbdev/riva/fbdev.c: error: passing
argument 1 of 'iounmap' discards 'volatile' qualifier from pointer
target type [-Werror=discarded-qualifiers]:  => 2095:11, 2062:11

um-all{mod,yes}config

  + /kisskb/src/fs/netfs/read_helper.c: error: implicit declaration of
function 'flush_dcache_folio' [-Werror=implicit-function-declaration]:
 => 435:4

sparc-allmodconfig
sparc64-allmodconfig

  + /kisskb/src/fs/ntfs/aops.c: error: the frame size of 2192 bytes is
larger than 2048 bytes [-Werror=frame-larger-than=]:  => 1311:1

ppc64le_allmodconfig

  + /kisskb/src/fs/ntfs/aops.c: error: the frame size of 2256 bytes is
larger than 2048 bytes [-Werror=frame-larger-than=]:  => 1311:1

powerpc-allyesconfig

> Thanks to the linux-next team for providing the build service.
>
> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/136057256686de39cc3a07c2e39ef6bc43003ff6/ (all 90 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf/ (all 90 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

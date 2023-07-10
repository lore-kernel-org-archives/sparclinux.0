Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0507EB64DC
	for <sparclinux@archiver.kernel.org>; Mon, 10 Jul 2023 10:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbjGJKN5 (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Mon, 10 Jul 2023 06:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233194AbjGJKNk (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Mon, 10 Jul 2023 06:13:40 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2FFE173D
        for <sparclinux@vger.kernel.org>; Mon, 10 Jul 2023 03:11:41 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:f087:2614:ec9d:569f])
        by baptiste.telenet-ops.be with bizsmtp
        id KNBV2A00B1w4dBK01NBVv9; Mon, 10 Jul 2023 12:11:30 +0200
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qInrd-0010sR-3d;
        Mon, 10 Jul 2023 12:11:29 +0200
Date:   Mon, 10 Jul 2023 12:11:29 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
cc:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        sparclinux@vger.kernel.org, linux-sh@vger.kernel.org
Subject: Re: Build regressions/improvements in v6.5-rc1
In-Reply-To: <20230710100012.2625532-1-geert@linux-m68k.org>
Message-ID: <bd856932-c2fb-d5f2-17f7-f7f1a1773adf@linux-m68k.org>
References: <CAHk-=wj8sPDVoWgaceAs1AiwZrHV8mtC3vQNGbeV6-RypJi6aw@mail.gmail.com> <20230710100012.2625532-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Mon, 10 Jul 2023, Geert Uytterhoeven wrote:
> Below is the list of build error/warning regressions/improvements in
> v6.5-rc1[1] compared to v6.4[2].
>
> Summarized:
>  - build errors: +3/-4
>  - build warnings: +36/-18
>
> Note that there may be false regressions, as some logs are incomplete.
> Still, they're build errors/warnings.
>
> Happy fixing! ;-)
>
> Thanks to the linux-next team for providing the build service.
>
> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5/ (all 162 configs)
> [2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/6995e2de6891c724bfeb2db33d7b87775f913ad1/ (160 out of 162 configs)
>
>
> *** ERRORS ***
>
> 3 error regressions:
>  + /kisskb/src/drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c: error: the frame size of 1392 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]:  => 1036:1

m68k-gcc8/m68k-allmodconfig

>  + error: modpost: "__xchg_called_with_bad_pointer" [lib/atomic64_test.ko] undefined!:  => N/A

sparc64-gcc11/sparc64-allmodconfig

>  + {standard input}: Error: unknown pseudo-op: `.glo':  => 1097

sh4-gcc11/sh-allmodconfig (ICE)

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds

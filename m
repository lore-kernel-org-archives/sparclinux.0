Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E391CC77B7D
	for <sparclinux@archiver.kernel.org>; Mon, 15 May 2023 08:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjEOIiL (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Mon, 15 May 2023 04:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjEOIh5 (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Mon, 15 May 2023 04:37:57 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88375184
        for <sparclinux@vger.kernel.org>; Mon, 15 May 2023 01:37:55 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed30:3f77:5127:1ef7:f210])
        by laurent.telenet-ops.be with bizsmtp
        id wwdt290015WeK8L01wdtn7; Mon, 15 May 2023 10:37:53 +0200
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pyTiL-002E1z-1B;
        Mon, 15 May 2023 10:37:53 +0200
Date:   Mon, 15 May 2023 10:37:53 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
cc:     sparclinux@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: Build regressions/improvements in v6.4-rc2
In-Reply-To: <20230515082657.3129685-1-geert@linux-m68k.org>
Message-ID: <6e20425a-a44c-916a-33d5-7b86ef6ad7c@linux-m68k.org>
References: <CAHk-=wj3jDtVCi2LqyijGzut2cq=AkPrAMfF0+6gtZ1WB6ruWQ@mail.gmail.com> <20230515082657.3129685-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Mon, 15 May 2023, Geert Uytterhoeven wrote:
> JFYI, when comparing v6.4-rc2[1] to v6.4-rc1[3], the summaries are:
>  - build errors: +8/-4

   + error: modpost: "ebus_dma_enable" [drivers/parport/parport_pc.ko] undefined!:  => N/A
   + error: modpost: "ebus_dma_irq_enable" [drivers/parport/parport_pc.ko] undefined!:  => N/A
   + error: modpost: "ebus_dma_prepare" [drivers/parport/parport_pc.ko] undefined!:  => N/A
   + error: modpost: "ebus_dma_register" [drivers/parport/parport_pc.ko] undefined!:  => N/A
   + error: modpost: "ebus_dma_request" [drivers/parport/parport_pc.ko] undefined!:  => N/A
   + error: modpost: "ebus_dma_residue" [drivers/parport/parport_pc.ko] undefined!:  => N/A
   + error: modpost: "ebus_dma_unregister" [drivers/parport/parport_pc.ko] undefined!:  => N/A
   + error: modpost: "ns87303_lock" [drivers/parport/parport_pc.ko] undefined!:  => N/A

sparc64-gcc{5,11}/sparc-allmodconfig

>  - build warnings: +1456/-0
>
> Happy fixing! ;-)
>
> Thanks to the linux-next team for providing the build service.
>
> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6/ (all 152 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/ac9a78681b921877518763ba0e89202254349d1b/ (all 152 configs)

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds

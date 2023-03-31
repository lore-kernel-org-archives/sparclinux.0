Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C889CC77B6E
	for <sparclinux@archiver.kernel.org>; Fri, 31 Mar 2023 09:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjCaJLB (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 31 Mar 2023 05:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjCaJLA (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 31 Mar 2023 05:11:00 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5FA1985
        for <sparclinux@vger.kernel.org>; Fri, 31 Mar 2023 02:10:57 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-536af432ee5so404417447b3.0
        for <sparclinux@vger.kernel.org>; Fri, 31 Mar 2023 02:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680253856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h5CSdrZ6l2xgXTKH1xLlq+jBgcd46ofV0BIoXJ6/6jM=;
        b=NHiE7PIU/1phremrSsF3/CQl6d7YKEdlDtlJ9Vwel53T7D2fDOz9Eopk4FcpZ1dSIm
         yu9e8Xh0JHbk1x3sJ/r5+kRcRDuV43DeZbQfu0w/kMYchm+WG+IUDHf/BC224Jw6v7Hy
         BSChRpraLXKpD4dnyCnfqBFCzvRsPoxHhXE18GrmUrPhY5zXpmqt7RX+zSjGr8+FpZWf
         ToQfnMbBgbPLRwCOIxrk4oSI0MRhYms+6xQVhERPGNAPOHshN0F5ZLgiT7jrBiYwUPBP
         vXOpSg0fjuin5LV315t/YgapeHNpqFNhTohezab0YMYOQMGNlql4NMgvD7BZ1XLyiAEG
         j5lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680253856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h5CSdrZ6l2xgXTKH1xLlq+jBgcd46ofV0BIoXJ6/6jM=;
        b=hE2YTR2dAmtD7uJj6vRtWZ6gL7T3vVJpWBzUFfKgYq/2NKiLta5b7ZrJB6h+hovMFu
         1Mvr1jyJVsAPuAFGf6R6X0lXM2dQgPbrlOW2t0LosICw7uM6wKMa+DUBzn82LBID7Bop
         TwP627yF3XFdytIs4MLRqiGoPh1VmzVPtGANK2mhl5hJEK9d9b4ZiNxGhiSyH0tRVEyC
         2mOFMWiYF4FfyS18ceTOBPrLy5ElkjPM3R8bWEQr5q4eOeaqIqiN4vl7WtzW5I6ih7W3
         bGCoyXaFsEndr4B2Gz3IDYTsItjvoWN3EzlgFLu2xDHaeKZ3Sh7cPrr4DOfzkLyLk5lv
         xakA==
X-Gm-Message-State: AAQBX9fbfD10HceXniPoL6Y8xm4FnOVe8LCiId4fVQMKkk4auBy2ggyI
        BYE3Tcl+QvPFAOWJaZ2NO44CIVUpGUIXIlFzkefDmg==
X-Google-Smtp-Source: AKy350bTzBXM6ycL3U98ZDogsouHVf6LJB3iu5qAKOjHJ8TlZEoTyW1DjaakW8G4QqD9ZcHPHI8e6e7vqfXcHXD2Pfk=
X-Received: by 2002:a81:b388:0:b0:545:8202:bbcf with SMTP id
 r130-20020a81b388000000b005458202bbcfmr12463339ywh.9.1680253856716; Fri, 31
 Mar 2023 02:10:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230327121317.4081816-1-arnd@kernel.org> <20230327121317.4081816-18-arnd@kernel.org>
In-Reply-To: <20230327121317.4081816-18-arnd@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 31 Mar 2023 11:10:44 +0200
Message-ID: <CACRpkdZdnTX4-jnnXZveXxwOg76yH4Zyoa-ZSGeC7KzOnn+6Lg@mail.gmail.com>
Subject: Re: [PATCH 17/21] ARM: dma-mapping: use arch_sync_dma_for_{device,cpu}()
 internally
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Vineet Gupta <vgupta@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Brian Cain <bcain@quicinc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Stafford Horne <shorne@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-oxnas@groups.io,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Mon, Mar 27, 2023 at 2:16=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The arm specific iommu code in dma-mapping.c uses the page+offset based
> __dma_page_cpu_to_dev()/__dma_page_dev_to_cpu() helpers in place of the
> phys_addr_t based arch_sync_dma_for_device()/arch_sync_dma_for_cpu()
> wrappers around the.

Broken sentence?

> In order to be able to move the latter part set of functions into
> common code, change the iommu implementation to use them directly
> and remove the internal ones as a separate interface.
>
> As page+offset and phys_address are equivalent, but are used in
> different parts of the code here, this allows removing some of
> the conversion but adds them elsewhere.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Looks good to me, took me some time to verify and understand
the open-coded version of PFN_UP() and this refactoring alone
makes the patch highly valuable.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

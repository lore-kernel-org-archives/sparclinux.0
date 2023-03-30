Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE31EC77B6E
	for <sparclinux@archiver.kernel.org>; Thu, 30 Mar 2023 08:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjC3IMx (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Thu, 30 Mar 2023 04:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjC3IMq (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Thu, 30 Mar 2023 04:12:46 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2460C7AA1
        for <sparclinux@vger.kernel.org>; Thu, 30 Mar 2023 01:12:18 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-536af432ee5so341331767b3.0
        for <sparclinux@vger.kernel.org>; Thu, 30 Mar 2023 01:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680163931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LQCYgbZHrv29At0jbIiZAbPjoR2bcYIsz7/d6inu7f8=;
        b=ExPqwkg7v1NJaAb/s/k5m0AsXdPeqWANvICm34UN83+g91kLHVNxTL6wIK95elgwZ0
         BsoWOOEBJNZZMuzO0jd9e5ZnX+piu95PYHJc8aCAeb74EZLSXYYZcUnjlcrwcSx9uUSn
         +ZylXYodLpHskZhPbl4FteqkYPSevcOTC9viahsIQVrxIIJjVrJEKuNvoC6mbX+9pqR3
         89vqEOP7c1GfiVA/eOXrKlUJ2J9zGfYuC7KwccmlIyO2J0GIlDQpCElJBkH4Lwj1h0sT
         ooCHH5PYBMyLFmPU8W7WigILMi6/95wflgUZh1w0ygoWmHzMdYahkSPYjw44g9lyJXD6
         gNjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680163931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LQCYgbZHrv29At0jbIiZAbPjoR2bcYIsz7/d6inu7f8=;
        b=wJz2gd9xYIm1gXAY8vxrnivQjk7lipxYHX/Y1mO57Gwi0lP0S6IywYVFNS7ylPVvT2
         VdVgqGQcf+8XCsf6ZyRL1BvHmTYyZbWRba6q4+1xvHFOfA8SgsZKqUs3ZGXIDkSZC3i1
         8JYr/jgE4iz9FoFbJjxWSYvdYqpD/5eAbikB/IXfVu0EKRdo0IBEg2p52bpBuZMNeLsD
         CFMlIIO4AuNyt/EkTzE85VcSA31WMVHm2ZZJfPfrCTsuAUMpMAd8U8w9gyzgY+74aGLq
         0CzhIs0Bk0WcjEicZl2/+gAJkk7Ph7G7d9lZZ4qHERoXIZNLQzG48scoIEeEQOW6uLzn
         QzXA==
X-Gm-Message-State: AAQBX9e0BwmggIrguO8b8ZP47xGJElw7AAmBxbgVDuxO2tAncxgaPpxh
        jers6bq8gsOevLkeVE+2fM7EDnZElbY929bIxLaH9w==
X-Google-Smtp-Source: AKy350a/1aBIXwj5sRzvro+POKQZrQ8u1qzHA9lYRVf8cH3+kLmmcEZ591QzYhrOYx7KtYdusctEvAjdnpZqGPXhdtA=
X-Received: by 2002:a81:c84a:0:b0:541:753d:32f9 with SMTP id
 k10-20020a81c84a000000b00541753d32f9mr10995359ywl.9.1680163931243; Thu, 30
 Mar 2023 01:12:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230327121317.4081816-1-arnd@kernel.org> <20230327121317.4081816-19-arnd@kernel.org>
In-Reply-To: <20230327121317.4081816-19-arnd@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 30 Mar 2023 10:12:00 +0200
Message-ID: <CACRpkdYuyzkvSQY0sQJei39d9ZoGM_DbJQ5LxUg3sXsBmzJyaQ@mail.gmail.com>
Subject: Re: [PATCH 18/21] ARM: drop SMP support for ARM11MPCore
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
        linux-xtensa@linux-xtensa.org, Daniel Golle <daniel@makrotopia.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Mon, Mar 27, 2023 at 2:16=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The cache management operations for noncoherent DMA on ARMv6 work
> in two different ways:
>
>  * When CONFIG_DMA_CACHE_RWFO is set, speculative prefetches on in-flight
>    DMA buffers lead to data corruption when the prefetched data is writte=
n
>    back on top of data from the device.
>
>  * When CONFIG_DMA_CACHE_RWFO is disabled, a cache flush on one CPU
>    is not seen by the other core(s), leading to inconsistent contents
>    accross the system.
>
> As a consequence, neither configuration is actually safe to use in a
> general-purpose kernel that is used on both MPCore systems and ARM1176
> with prefetching enabled.
>
> We could add further workarounds to make the behavior more dynamic based
> on the system, but realistically, there are close to zero remaining
> users on any ARM11MPCore anyway, and nobody seems too interested in it,
> compared to the more popular ARM1176 used in BMC2835 and AST2500.
>
> The Oxnas platform has some minimal support in OpenWRT, but most of the
> drivers and dts files never made it into the mainline kernel, while the
> Arm Versatile/Realview platform mainly serves as a reference system but
> is not necessary to be kept working once all other ARM11MPCore are gone.
>
> Take the easy way out here and drop support for multiprocessing on
> ARMv6, along with the CONFIG_DMA_CACHE_RWFO option and the cache
> management implementation for it. This also helps with other ARMv6
> issues, but for the moment leaves the ability to build a kernel that
> can run on both ARMv7 SMP and single-processor ARMv6, which we probably
> want to stop supporting as well, but not as part of this series.
>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Daniel Golle <daniel@makrotopia.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: linux-oxnas@groups.io
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Yeah, we discussed this earlier, let's just drop it. Not worth the effort.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

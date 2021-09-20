Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 996D9C4321E
	for <sparclinux@archiver.kernel.org>; Mon, 20 Sep 2021 18:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 832E560724
	for <sparclinux@archiver.kernel.org>; Mon, 20 Sep 2021 18:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357374AbhITSGC (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Mon, 20 Sep 2021 14:06:02 -0400
Received: from mout.gmx.net ([212.227.15.19]:54279 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1357240AbhITSDn (ORCPT <rfc822;sparclinux@vger.kernel.org>);
        Mon, 20 Sep 2021 14:03:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1632160919;
        bh=qs0DArqAPOvJVRu48rowJhF8MgdjMaPpAg6EqgXnKTY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=HfeksWb8LsK1BsT0Rl64NbuI6PRBJqR+5afGmXMVOpT9MQ1sGhbd4aj4wKnqg/u0/
         WrfhZhz7yfGSieU/yXeb42bdH/pP+Foq5+xtvqElrDnj/AmkUWvZ7qETaZTC3if+Vg
         lCzK14K/5EENOL21FIyHBP400DgQNiVDIJ3AgrjY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.139.149]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M9FnZ-1mYijQ0r9L-006KF7; Mon, 20
 Sep 2021 20:01:59 +0200
Subject: Re: [PATCH] agp: define proper stubs for empty helpers
To:     Arnd Bergmann <arnd@kernel.org>, linux-fbdev@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     dri-devel@lists.freedesktop.org, Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org
References: <20210920121728.94045-1-arnd@kernel.org>
From:   Helge Deller <deller@gmx.de>
Message-ID: <964b57bd-d9ea-2df7-72f8-4fe0a24e365c@gmx.de>
Date:   Mon, 20 Sep 2021 20:01:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210920121728.94045-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ielC16M4jNM8r9XDB90QignHCy/6YlUha15mhFWovRcMy9O1zzb
 8QypFMtAxF5MzAHK++H1MBI81Sa75wLy/setk5x13DasmVS0AKNKY6GfUyCrzNgdbtkCKTc
 kwWR86U72xfpyB6Hrky0K/RNzjOCDlpPupfFbZssjNmoecQixWFYM7O/WLC1GhFaR6lMazX
 yBDHtqk4g/mtZryfF0OBQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:C/wqI77xvAo=:HRjvLc6nN+tv6C/BrmKRSq
 WKcOglc7y5AqtARLrn1+leF9neQNkKr82co/040Gxm7EJ+yY13wgWDcHM+ltiUt6FxyBZ9d5k
 1bwC0RiNnFLO3gEM4KXxkyl8qK0jX4PAeuysc0Hnh+wrIJvBeAN45i4J8tguZxMTYVp6BTA95
 xXAfx5a28vu9RZlTaN7V1RPjnVwRxsOVSUA1IBORZprdzG4zoegm8ZHIFL/kV+s+T1Bpd81cH
 EVfVEyM2p5HFn6ozGuaV/xi7QlFhdFtDHCsvAPeYdRu/vDFjLyXsUXVRTf40igCLBe/sCuF0I
 4dzjsZ/xCGzQ2vqidVfuKnOqUmdO6cx3TcKHiXMHyZpbHgzmHlxde0nH2nRRxHuvDSDdqOkXG
 QETmwXxWNyc6vJJE5fe6vA7bPIV7Hvw8xkqtZDG8z7jHxsuAsi88u3RRl9/Ia0crUKPBDiB8F
 z13T5dDSmqJcSTU3gUzmPoNxJD83aRFGY+CbrFxrDSexaNijgHO4vympYNcO3SfmeAi2QF9VN
 MPiFrqCqLcx/6JF59MRnLlyM/MmX5WjIwtJNazFd8JFcnKvqEmMemQX9OdzVTh85d62mKRxx8
 LXmQOSl2PJyciYWePTbhHhDSRUpyVo/pcL10CsBPaZX3Ux+qgMEfAKTXKhFTTXalsDbImF2TV
 zQJfbjEy3qdXrNtasPETDkJmPo2FeuBXtV5v8osPkxZo7Ew+Xyo2NpHRH7Wh9+ChnT9xiMcQC
 e0IuZ5Ktpgz1Y2nmng13PrGWD7VgOBPzLnYPikjlAxgrp/r5E4OAU20frGFDyWal0RYppWlWk
 BczjLrqVR9i+2f64AKfli9cYRTpvBDhzXssdxzqzO3QQEc+Fvdmo8qRQTkBWutfqRL2PF2QE/
 A+y/5JftYjrOUQ+nJNqmLunrtUpUbygu7fxX+sC4PfE/+LYDEzTfm/rVjbf2lqRrtzQPOaTd1
 1/wVfzKDreknGXRA5+Sfjykp1RGHZ3JhqOZpuYBdHzVhKiMcwtTrHCIw3smrupIOF88E2wMbn
 SdlleS7Lfiw9A+j4ou7ClrVwGe5QYtPpZQ1Jyu87gSVLfdM0Cs+A6o1Tw06Eia4zbUX4l4kyz
 ULO/TkD8wCoZS0=
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On 9/20/21 2:17 PM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> The empty unmap_page_from_agp() macro causes a warning when
> building with 'make W=3D1' on a couple of architectures:
>
> drivers/char/agp/generic.c: In function 'agp_generic_destroy_page':
> drivers/char/agp/generic.c:1265:28: error: suggest braces around empty b=
ody in an 'if' statement [-Werror=3Dempty-body]
>   1265 |   unmap_page_from_agp(page);
>
> Change the definitions to a 'do { } while (0)' construct to
> make these more reliable.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Helge Deller <deller@gmx.de> # parisc

Thanks,
Helge

> ---
>   arch/parisc/include/asm/agp.h  | 4 ++--
>   arch/powerpc/include/asm/agp.h | 4 ++--
>   arch/sparc/include/asm/agp.h   | 6 +++---
>   3 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/arch/parisc/include/asm/agp.h b/arch/parisc/include/asm/agp=
.h
> index cb04470e63d0..14ae54cfd368 100644
> --- a/arch/parisc/include/asm/agp.h
> +++ b/arch/parisc/include/asm/agp.h
> @@ -8,8 +8,8 @@
>    *
>    */
>
> -#define map_page_into_agp(page)		/* nothing */
> -#define unmap_page_from_agp(page)	/* nothing */
> +#define map_page_into_agp(page)		do { } while (0)
> +#define unmap_page_from_agp(page)	do { } while (0)
>   #define flush_agp_cache()		mb()
>
>   /* GATT allocation. Returns/accepts GATT kernel virtual address. */
> diff --git a/arch/powerpc/include/asm/agp.h b/arch/powerpc/include/asm/a=
gp.h
> index b29b1186f819..6b6485c988dd 100644
> --- a/arch/powerpc/include/asm/agp.h
> +++ b/arch/powerpc/include/asm/agp.h
> @@ -5,8 +5,8 @@
>
>   #include <asm/io.h>
>
> -#define map_page_into_agp(page)
> -#define unmap_page_from_agp(page)
> +#define map_page_into_agp(page) do {} while (0)
> +#define unmap_page_from_agp(page) do {} while (0)
>   #define flush_agp_cache() mb()
>
>   /* GATT allocation. Returns/accepts GATT kernel virtual address. */
> diff --git a/arch/sparc/include/asm/agp.h b/arch/sparc/include/asm/agp.h
> index efe0d6a12e5a..2d0ff84cee3f 100644
> --- a/arch/sparc/include/asm/agp.h
> +++ b/arch/sparc/include/asm/agp.h
> @@ -4,9 +4,9 @@
>
>   /* dummy for now */
>
> -#define map_page_into_agp(page)
> -#define unmap_page_from_agp(page)
> -#define flush_agp_cache() mb()
> +#define map_page_into_agp(page)		do { } while (0)
> +#define unmap_page_from_agp(page)	do { } while (0)
> +#define flush_agp_cache()		mb()
>
>   /* GATT allocation. Returns/accepts GATT kernel virtual address. */
>   #define alloc_gatt_pages(order)		\
>


Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C20C433EF
	for <sparclinux@archiver.kernel.org>; Mon, 20 Jun 2022 09:52:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240025AbiFTJwP (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Mon, 20 Jun 2022 05:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240201AbiFTJwN (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Mon, 20 Jun 2022 05:52:13 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CFB13E28
        for <sparclinux@vger.kernel.org>; Mon, 20 Jun 2022 02:52:11 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id i7so340202ybe.11
        for <sparclinux@vger.kernel.org>; Mon, 20 Jun 2022 02:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8DyE/KWQUZrty8rXx81JIsG8zxsuYBbuRVM0whdGKxU=;
        b=YMx5LG7Wdq+ZbP+hmySua4p+q8ITcfNOgA4wNN233s19a/7cF/MJtq3fr/LfgGQy4p
         ogvSHl2Cf2DYFO76BS+OtDLYvlEEfUWUUgII7m+zE9Wag3P6PJmdocnBsDRN/vqEINWI
         ESFYkAqEprhYE9UBRvqjrDhG4Bu6CEiZVt9gmH+r/aYAAW3S3pWUCuTKX2VFxgqZG2fL
         7fcp5qJdRksrTWb/CAUc1PuUQq8hnng4kyvcesKz7U2bEjUgU6ubETbvxyw0B2MBoO4B
         lteMT6G/lEy2Rzwd8AoL9zq5hwcwZzAfUZEWGcxA46w79qz+mEgvNVgv0mt59z/DFyWm
         ty1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8DyE/KWQUZrty8rXx81JIsG8zxsuYBbuRVM0whdGKxU=;
        b=yUxj5JpnZE4SuHJ/D2THds6qOEBtcdpssMOGrXIY/oUueOOyoYv1Zj5olIttL6Phdq
         oaAskcoNzHe0Ok48kShasx3JTGq1zWg9+TQyRoXyZ1ZLNTuNj4VjCM1zK5woiciku2NV
         GnHKGAmTLH3FwfTv7NcgInF8u27c2ie3AIGtTYs3LqQeUZOtcucjpSjPP5yK0Baw+tw5
         ipCfuhKFzwXTGLy/B5TDg6HKNUfaIltWj7ZDUbqEE2VQe0cDr7goRUvkCXnFg2K9VkpD
         VfJ2OGmXeKKWD0RsMoE3at4FCR0lgHYEYv649AUIPl65Crgmr6tQ8iWEmhUp3kcfy74H
         R0DA==
X-Gm-Message-State: AJIora8GTnrNOi3YrPyw64s0fzsHxeOE4dhkg4O9uM3YVHPJAEym3pNk
        x4IdYTIhoODRQ2EgFuupcukasnwKGcqd3XH9LbPemw==
X-Google-Smtp-Source: AGRyM1sSBAv2oiSQZ55yekxja+O5pLkAMEu8ApBXNKvRuqsuhhN0KQ8acs5PUATsPYeMSQGzVNfHa1GTg72DYCPq9DI=
X-Received: by 2002:a25:94a:0:b0:668:df94:fdf4 with SMTP id
 u10-20020a25094a000000b00668df94fdf4mr9911328ybm.425.1655718730567; Mon, 20
 Jun 2022 02:52:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220617144031.2549432-1-alexandr.lobakin@intel.com> <20220617144031.2549432-7-alexandr.lobakin@intel.com>
In-Reply-To: <20220617144031.2549432-7-alexandr.lobakin@intel.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 20 Jun 2022 11:51:34 +0200
Message-ID: <CANpmjNMi_kOGsiuSmNpg_yDVoFzw7zSGT7u+zk3HJZ9UER7Yrg@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] bitops: let optimize out non-atomic bitops on
 compile-time constants
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matt Turner <mattst88@gmail.com>,
        Brian Cain <bcain@quicinc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-alpha@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Fri, 17 Jun 2022 at 19:00, Alexander Lobakin
<alexandr.lobakin@intel.com> wrote:
>
> Currently, many architecture-specific non-atomic bitop
> implementations use inline asm or other hacks which are faster or
> more robust when working with "real" variables (i.e. fields from
> the structures etc.), but the compilers have no clue how to optimize
> them out when called on compile-time constants. That said, the
> following code:
>
>         DECLARE_BITMAP(foo, BITS_PER_LONG) = { }; // -> unsigned long foo[1];
>         unsigned long bar = BIT(BAR_BIT);
>         unsigned long baz = 0;
>
>         __set_bit(FOO_BIT, foo);
>         baz |= BIT(BAZ_BIT);
>
>         BUILD_BUG_ON(!__builtin_constant_p(test_bit(FOO_BIT, foo));
>         BUILD_BUG_ON(!__builtin_constant_p(bar & BAR_BIT));
>         BUILD_BUG_ON(!__builtin_constant_p(baz & BAZ_BIT));
>
> triggers the first assertion on x86_64, which means that the
> compiler is unable to evaluate it to a compile-time initializer
> when the architecture-specific bitop is used even if it's obvious.
> In order to let the compiler optimize out such cases, expand the
> bitop() macro to use the "constant" C non-atomic bitop
> implementations when all of the arguments passed are compile-time
> constants, which means that the result will be a compile-time
> constant as well, so that it produces more efficient and simple
> code in 100% cases, comparing to the architecture-specific
> counterparts.
>
> The savings are architecture, compiler and compiler flags dependent,
> for example, on x86_64 -O2:
>
> GCC 12: add/remove: 78/29 grow/shrink: 332/525 up/down: 31325/-61560 (-30235)
> LLVM 13: add/remove: 79/76 grow/shrink: 184/537 up/down: 55076/-141892 (-86816)
> LLVM 14: add/remove: 10/3 grow/shrink: 93/138 up/down: 3705/-6992 (-3287)
>
> and ARM64 (courtesy of Mark):
>
> GCC 11: add/remove: 92/29 grow/shrink: 933/2766 up/down: 39340/-82580 (-43240)
> LLVM 14: add/remove: 21/11 grow/shrink: 620/651 up/down: 12060/-15824 (-3764)
>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  include/linux/bitops.h | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/bitops.h b/include/linux/bitops.h
> index 3c3afbae1533..26a43360c4ae 100644
> --- a/include/linux/bitops.h
> +++ b/include/linux/bitops.h
> @@ -33,8 +33,24 @@ extern unsigned long __sw_hweight64(__u64 w);
>
>  #include <asm-generic/bitops/generic-non-atomic.h>
>
> +/*
> + * Many architecture-specific non-atomic bitops contain inline asm code and due
> + * to that the compiler can't optimize them to compile-time expressions or
> + * constants. In contrary, gen_*() helpers are defined in pure C and compilers
> + * optimize them just well.
> + * Therefore, to make `unsigned long foo = 0; __set_bit(BAR, &foo)` effectively
> + * equal to `unsigned long foo = BIT(BAR)`, pick the generic C alternative when
> + * the arguments can be resolved at compile time. That expression itself is a
> + * constant and doesn't bring any functional changes to the rest of cases.
> + * The casts to `uintptr_t` are needed to mitigate `-Waddress` warnings when
> + * passing a bitmap from .bss or .data (-> `!!addr` is always true).
> + */
>  #define bitop(op, nr, addr)                                            \
> -       op(nr, addr)
> +       ((__builtin_constant_p(nr) &&                                   \
> +         __builtin_constant_p((uintptr_t)(addr) != (uintptr_t)NULL) && \
> +         (uintptr_t)(addr) != (uintptr_t)NULL &&                       \
> +         __builtin_constant_p(*(const unsigned long *)(addr))) ?       \
> +        const##op(nr, addr) : op(nr, addr))
>
>  #define __set_bit(nr, addr)            bitop(___set_bit, nr, addr)
>  #define __clear_bit(nr, addr)          bitop(___clear_bit, nr, addr)
> --
> 2.36.1
>

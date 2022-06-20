Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A29C43334
	for <sparclinux@archiver.kernel.org>; Mon, 20 Jun 2022 09:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239976AbiFTJuc (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Mon, 20 Jun 2022 05:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239832AbiFTJu3 (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Mon, 20 Jun 2022 05:50:29 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F48913E02
        for <sparclinux@vger.kernel.org>; Mon, 20 Jun 2022 02:50:27 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-3178acf2a92so60617607b3.6
        for <sparclinux@vger.kernel.org>; Mon, 20 Jun 2022 02:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c5v3S7Zkd9PrYC84ZzumNRLfIqFWNrQTW2/cBzQcLYg=;
        b=mIpWvLd42Zk3qDlC1lJPcvqz7M92/WQXcIoyM0LykA88iAo+rdgJDoHazph31kdSjO
         VUG7i/8HNZaOHLdu3N7nDqHPuwIY9fq9FvuOy2YX4EQM5bkG55ZAVqX3dyMqhKkf3Zrp
         wdgsnCqcf5yU/1gR7FrWP0Ud1NWBTI4TQjIzmZlty8pgPxfb7xHnM8DyqjB9t4bddRHR
         O64X//fr0z/4HxfkqMa1L+YEzzaQ9IobIbQsg9BgYcppkG2JYM76WtyvjDHFXlKlUAJ0
         15NorsK1RaWXrUbZhIe7SdlsQlOhJzxaaCKzH9GSm4bD8dAmvyeOcvf0LOG2jFT9DYh9
         yfrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c5v3S7Zkd9PrYC84ZzumNRLfIqFWNrQTW2/cBzQcLYg=;
        b=zW1mwLXmAPcy/pzdOssMfT2SvEfphv0T9PlUYs9Tnp8A+yP+MhIVC7gO8VrOVrewGr
         VJlh4fbPH3d3OvFFk97gio7kLs0tkoKBtTAYA1GgF1z71X1PcKCNX5/O6pFxUpZSKRWJ
         m53hM6CYYJheGbkAq3WKTL52sLfxqquNmEH+SP94WubRnYDoe0WUkw8jdeG5mLMkLvAJ
         P4q4avnK5QI5pTz4Z4htZS8RPI9brOug70ghTUgh2NVoCILGI9781nRcyfOUywzyuLSb
         7GtRisolk6dsWzjmYF0TV0/vK/tYRaWLBLdREheiyI1ZPKXa5uA7mNuZT3qPz3pbkIXn
         UOYg==
X-Gm-Message-State: AJIora+57Np33zCGRo2e1vpMTfhDvn3slPfhiDQScVb1/DSNdUu9XkfJ
        u5zgof+0DG8RvCGkKXU3jEONwFecukh5SlH+jiT4vw==
X-Google-Smtp-Source: AGRyM1uqwPv5EEm+1mfuSKwMODskeRwUAmI9vr2ZogkAKlsFAi/E6OQyVuET36WKVD2vqMmJlAF716hcyW0OfDGtk5M=
X-Received: by 2002:a05:690c:681:b0:317:e92b:7f8d with SMTP id
 bp1-20020a05690c068100b00317e92b7f8dmr1282353ywb.264.1655718625831; Mon, 20
 Jun 2022 02:50:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220617144031.2549432-1-alexandr.lobakin@intel.com> <20220617144031.2549432-5-alexandr.lobakin@intel.com>
In-Reply-To: <20220617144031.2549432-5-alexandr.lobakin@intel.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 20 Jun 2022 11:49:50 +0200
Message-ID: <CANpmjNMU86pKB37OcnZ34Avd8+gBn-Ekz_6uYvF94zFZY0itCw@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] bitops: define const_*() versions of the non-atomics
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

On Fri, 17 Jun 2022 at 19:21, Alexander Lobakin
<alexandr.lobakin@intel.com> wrote:
>
> Define const_*() variants of the non-atomic bitops to be used when
> the input arguments are compile-time constants, so that the compiler
> will be always able to resolve those to compile-time constants as
> well. Those are mostly direct aliases for generic_*() with one
> exception for const_test_bit(): the original one is declared
> atomic-safe and thus doesn't discard the `volatile` qualifier, so
> in order to let optimize code, define it separately disregarding
> the qualifier.
> Add them to the compile-time type checks as well just in case.
>
> Suggested-by: Marco Elver <elver@google.com>
> Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  .../asm-generic/bitops/generic-non-atomic.h   | 31 +++++++++++++++++++
>  include/linux/bitops.h                        |  1 +
>  2 files changed, 32 insertions(+)
>
> diff --git a/include/asm-generic/bitops/generic-non-atomic.h b/include/asm-generic/bitops/generic-non-atomic.h
> index b85b8a2ac239..3d5ebd24652b 100644
> --- a/include/asm-generic/bitops/generic-non-atomic.h
> +++ b/include/asm-generic/bitops/generic-non-atomic.h
> @@ -127,4 +127,35 @@ generic_test_bit(unsigned long nr, const volatile unsigned long *addr)
>         return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
>  }
>
> +/*
> + * const_*() definitions provide good compile-time optimizations when
> + * the passed arguments can be resolved at compile time.
> + */
> +#define const___set_bit                        generic___set_bit
> +#define const___clear_bit              generic___clear_bit
> +#define const___change_bit             generic___change_bit
> +#define const___test_and_set_bit       generic___test_and_set_bit
> +#define const___test_and_clear_bit     generic___test_and_clear_bit
> +#define const___test_and_change_bit    generic___test_and_change_bit
> +
> +/**
> + * const_test_bit - Determine whether a bit is set
> + * @nr: bit number to test
> + * @addr: Address to start counting from
> + *
> + * A version of generic_test_bit() which discards the `volatile` qualifier to
> + * allow a compiler to optimize code harder. Non-atomic and to be called only
> + * for testing compile-time constants, e.g. by the corresponding macros, not
> + * directly from "regular" code.
> + */
> +static __always_inline bool
> +const_test_bit(unsigned long nr, const volatile unsigned long *addr)
> +{
> +       const unsigned long *p = (const unsigned long *)addr + BIT_WORD(nr);
> +       unsigned long mask = BIT_MASK(nr);
> +       unsigned long val = *p;
> +
> +       return !!(val & mask);
> +}
> +
>  #endif /* __ASM_GENERIC_BITOPS_GENERIC_NON_ATOMIC_H */
> diff --git a/include/linux/bitops.h b/include/linux/bitops.h
> index 87087454a288..d393297287d5 100644
> --- a/include/linux/bitops.h
> +++ b/include/linux/bitops.h
> @@ -37,6 +37,7 @@ extern unsigned long __sw_hweight64(__u64 w);
>  /* Check that the bitops prototypes are sane */
>  #define __check_bitop_pr(name)                                         \
>         static_assert(__same_type(arch_##name, generic_##name) &&       \
> +                     __same_type(const_##name, generic_##name) &&      \
>                       __same_type(name, generic_##name))
>
>  __check_bitop_pr(__set_bit);
> --
> 2.36.1
>

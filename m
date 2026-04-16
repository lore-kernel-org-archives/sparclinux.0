Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C6C3126B2
	for <sparclinux@vger.kernel.org>; Thu, 16 Apr 2026 10:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776335394; cv=none; b=hNETTX5AuA1P89ivwoQT1I7TcGgTXVfsSQe+LTR7KEejgbMpoOM3Z90CsFGTYc6091pKhzrliAy4bLnrHA2UhT0dYj1FzLfTQ1eM4NSeHYifS+598zhUavzv70COe4Q1CLRaSE31K/WDI0jj002thySzga67esvFOR+aPs2JznE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776335394; c=relaxed/simple;
	bh=Il5EilNKbQmVM1qv4XgxLAe02Z9+zxydkwUqJc2BPRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wm5pUp5UGa/bEXNsoB2OvCTlnP7ErEkAT3fYLkWkdE8OMLyv94Dk6gDbuAryGU44Bg2YfLXoggc2OGVUkaR3YSlp7r0F4+mDBaYYzl48SAtG0V41vWdDRrtTxwUh0mXW23vE33VMJ1tIFieZMjgWZc/JxrmjUzq2zsE7OKt6xB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-40efc77933fso5166940fac.3
        for <sparclinux@vger.kernel.org>; Thu, 16 Apr 2026 03:29:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776335390; x=1776940190;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9HEDsaws+1AaPEcUyrGjtCss1Kv3jZQFAB8Oib7mmY=;
        b=jy+fRSxFRDtGDsTwTauyncMI4p9XtRZqY2HQ+PhFXc08NYbWGYDR7kkHlC3+WMpY5r
         71vR5L8LP908L4NGJ04MNSMcol3SzlYiSOLQjZbt2s/jK+u6QtKSEA93Bvru/FJrTQm4
         Yc1GQ94jhYQbKxhe0ndYCcZQrVMytIaweMD/5qEuf8iJ5E1ohdSQsqI0yEegzBpwRU0E
         2t4oiDWMTQE6vW8Xpmy2MU9Wc6ixh3/54vdd8izjlF0QYBjli2z6tNtuYrhPA2jNBroQ
         2BOiHVtDjCxTb5EGSKSE38A7rF6s8fPjcSGCd3WjaQkxalZd2jBPlkdfs0jpGfnbdn53
         xHjA==
X-Forwarded-Encrypted: i=1; AFNElJ8xATZ/ixDRTzC6GxKif8RGVRgt1OzAx/8Riiu0W+BlNWTsOw9NzaCatSxKV76IEXlkYL2UM3824/L7@vger.kernel.org
X-Gm-Message-State: AOJu0YxlJYcmzwOj+CuyapyrqrEdBDHuG4KE5Fi1qPUni0E/kANJ32w9
	2Xc6aat1Qvreb4e+z7Gc3+B0pMpr4myYgLF4gQ6at64ovnGV2eDpPqBP0EAWahRi
X-Gm-Gg: AeBDies07OLTBtx2qlOqNJysk0P4FjghtXMrD6Qi2UIl9UU3YCBKAOom18Izk2mEDT9
	JMCM7RdCIKJm5/Lqb13UzocQTTNhIiurP9Xd1J0uM2r7nEaz6TQcelE53I/QTRkik3Dx95H8XlA
	v0sWiwOJ3qsgyB9pmoe52QvCjdNTMPofCUbfIS38kpH4fpeJ2XBQ5ihzRxWNTuEkB0/VUK46sB1
	cD/7tG8kz13ZLlOmEbqyIxxj7qqpTrt2jq2Hnxc6pfI8Z474y+WgzdmNed3FtcoUbCTSMdb/xnB
	4QT6R470mUnu97xopfOQg/piaasJPN69HoLNzIwZ/P9GwLP81LMM3qOH1bu30x/dugTTl2apl4z
	ZfsCPhfkFFol0HdVRjwtQLCt8PZbtRwXccl8Gg3ewyBohq+hE3pAZmfYTj9+VOjiESP1hq8ho7p
	XQO3m83TsN4SbqL9x965FKrDAvms2+dOOV4KL421yMh5FmRVdQgYV2xyAHlOGVQTsgnv2TTT4=
X-Received: by 2002:a05:6870:31ad:b0:424:88f:e8e8 with SMTP id 586e51a60fabf-424089014b7mr11930142fac.36.1776335390534;
        Thu, 16 Apr 2026 03:29:50 -0700 (PDT)
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com. [209.85.161.51])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-42666bcb7afsm3554347fac.7.2026.04.16.03.29.50
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 03:29:50 -0700 (PDT)
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6841e6a5e51so4350636eaf.3
        for <sparclinux@vger.kernel.org>; Thu, 16 Apr 2026 03:29:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9TqUU+Qvt9JBB28NPJahf5e0jJ7a7LK0KnHzQtJWrEx0NT48HFCxV8MRsEcbxv6pRDklIpo+x3YXaG@vger.kernel.org
X-Received: by 2002:a05:6102:c48:b0:608:cd24:354c with SMTP id
 ada2fe7eead31-609fe9b0d22mr11966750137.3.1776335071251; Thu, 16 Apr 2026
 03:24:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410120044.031381086@kernel.org> <20260410120318.794680738@kernel.org>
In-Reply-To: <20260410120318.794680738@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 16 Apr 2026 12:24:18 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVerN6Pz07CQH+hcvT=-ZD-r9VNrSrGzTQZBEsuecK_ig@mail.gmail.com>
X-Gm-Features: AQROBzDRGGELVSySTko37h6zEj8YoV3p6pwZDCVQUlUW6sZbw_W5mbJzFIh35nQ
Message-ID: <CAMuHMdVerN6Pz07CQH+hcvT=-ZD-r9VNrSrGzTQZBEsuecK_ig@mail.gmail.com>
Subject: Re: [patch 18/38] lib/tests: Replace get_cycles() with ktime_get()
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, 
	Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	linux-crypto@vger.kernel.org, Vlastimil Babka <vbabka@kernel.org>, 
	David Woodhouse <dwmw2@infradead.org>, Bernie Thompson <bernie@plugable.com>, linux-fbdev@vger.kernel.org, 
	Theodore Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org, Marco Elver <elver@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Thomas Sailer <t.sailer@alumni.ethz.ch>, 
	linux-hams@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	Richard Henderson <richard.henderson@linaro.org>, linux-alpha@vger.kernel.org, 
	Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Huacai Chen <chenhuacai@kernel.org>, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, linux-openrisc@vger.kernel.org, 
	Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, 
	Paul Walmsley <pjw@kernel.org>, linux-riscv@lists.infradead.org, 
	Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Thomas,

On Fri, 10 Apr 2026 at 14:20, Thomas Gleixner <tglx@kernel.org> wrote:
> get_cycles() is the historical access to a fine grained time source, but it
> is a suboptimal choice for two reasons:
>
>    - get_cycles() is not guaranteed to be supported and functional on all
>      systems/platforms. If not supported or not functional it returns 0,
>      which makes benchmarking moot.
>
>    - get_cycles() returns the raw counter value of whatever the
>      architecture platform provides. The original x86 Time Stamp Counter
>      (TSC) was despite its name tied to the actual CPU core frequency.
>      That's not longer the case. So the counter value is only meaningful
>      when the CPU operates at the same frequency as the TSC or the value is
>      adjusted to the actual CPU frequency. Other architectures and
>      platforms provide similar disjunct counters via get_cycles(), so the
>      result is operations per BOGO-cycles, which is not really meaningful.
>
> Use ktime_get() instead which provides nanosecond timestamps with the
> granularity of the underlying hardware counter, which is not different to
> the variety of get_cycles() implementations.
>
> This provides at least understandable metrics, i.e. operations/nanoseconds,
> and is available on all platforms. As with get_cycles() the result might
> have to be put into relation with the CPU operating frequency, but that's
> not any different.
>
> This is part of a larger effort to remove get_cycles() usage from
> non-architecture code.
>
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>

Thanks for your patch!

> --- a/lib/interval_tree_test.c
> +++ b/lib/interval_tree_test.c
> @@ -65,13 +65,13 @@ static void init(void)
>  static int basic_check(void)
>  {
>         int i, j;
> -       cycles_t time1, time2, time;
> +       ktime_t time1, time2, time;
>
>         printk(KERN_ALERT "interval tree insert/remove");
>
>         init();
>
> -       time1 = get_cycles();
> +       time1 = ktime_get();
>
>         for (i = 0; i < perf_loops; i++) {
>                 for (j = 0; j < nnodes; j++)
> @@ -80,11 +80,11 @@ static int basic_check(void)
>                         interval_tree_remove(nodes + j, &root);
>         }
>
> -       time2 = get_cycles();
> +       time2 = ktime_get();
>         time = time2 - time1;
>
>         time = div_u64(time, perf_loops);
> -       printk(" -> %llu cycles\n", (unsigned long long)time);
> +       printk(" -> %llu nsecs\n", (unsigned long long)time);

While cycles_t was unsigned long or long long, ktime_t is always s64,
so "%lld", and the cast can be dropped (everywhere).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

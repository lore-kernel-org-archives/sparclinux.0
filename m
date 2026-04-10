Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1843C553F
	for <sparclinux@vger.kernel.org>; Fri, 10 Apr 2026 13:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775828409; cv=pass; b=HH6v797T/uxHwNEE2WiOvzCUBFYJ+q09P1n6+nvajVrvoGHw8/xoGYl+WZDuX1iXA9AHx1aw06PXawTP5fo301DHkYsZC3y4JqIhHN92840NaVIYAJNXFc5s9ous4SCLsiU7omNEzAbQllQLRA/Pg/qMdyXfcsxkPL5oDz5Ssn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775828409; c=relaxed/simple;
	bh=LSR04DrYd2CNPoGkLuzcgQfT1tMVn5ZfdEM6iihG19s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eIMaxW8jLtbWR3hVjZbpmw3t3q6EFnzQIl75U4063oGC2Npyu5WWRqgkCa323/nH46BXYPOEvL+bXgpl860GxmzFEUxSxrV9wR6/kKcLzKIUmmblcnlWo2uMVSk/+loI0hm0EnG/jOb1IJ7VEb2FYBAjUwropQOqmGGR+aqNEzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WXkk7MjG; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WXkk7MjG"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-128e4d0cc48so9423203c88.1
        for <sparclinux@vger.kernel.org>; Fri, 10 Apr 2026 06:40:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775828407; cv=none;
        d=google.com; s=arc-20240605;
        b=hLS9YNTnvwOBoJJEQpSJylZ+F5KEWwZ/FqH0RzhruFigEBBTeC73CHJhUTXJcXiZtY
         3L4t/bdxC6gCY9szMnKV0H0ewY6CmQVHArt3dG8lD4Xia/flwvN29NV/BlUSR24HVD8W
         u1xPSHCxgQwe0PKrPmz1xNIqdcljewgIqJFoKVKsIeI/wABCZ+3KUBAdCseDb2fnTLeL
         PpK8uWwmXgckhMtSoid9gMBTHfspSnrPn7GT7x0SmNWAgC4ydBUp3ylrUDHWZYII6DzA
         WrEFl90rN7G3Gkqur7mFqKTsKqew4aqUPwfLz+OlCKDPeceMHvLwTwOePHYKfqguTSdI
         x4RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=iCXB7w7ko4o+lkpt1Tfr/OwLPxl1m2l/vGRhYm7vF9w=;
        fh=4DxECkPNyL6gIdHbw/uOOFjgFJa/IJmm3H1l5NX0uW4=;
        b=NXNesniKCOsURpJrDMUi+iUhfEIRSopQDcrFiRyt2a3WHBeiBBGIkzW5CsdKd7aANT
         2fgetNUbocRayY4eAPC+XjKnrPhu2obOpuI917szzUZvyAbArTHnzMyQ1OEBrjKtcjl4
         T6ExzSg5aDifVrK+/jnx7Sf7QO3K28n9CZpOyUMKhmA2fPHpMbbrrdOrZxD2UXoiDldM
         wJIR9gh1Z/oBU+ZS+y6bnDXGWC8b4o/Sw8+HmmUIYtJM/wK48WJg7ZF/fifBm9tGNDB+
         LRLHgTut0HZOvITZkD+Uw/URg3VvdJpGbagVvs/QzfCHA5GACJfZVOUL+RT4CLL4Slad
         RCXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775828407; x=1776433207; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iCXB7w7ko4o+lkpt1Tfr/OwLPxl1m2l/vGRhYm7vF9w=;
        b=WXkk7MjGsWCUHEg1iU7liVQxxmn76Z2Blc65Af4B1zix0M2rF8QfzApVNMifY6ss0I
         o28bXJ2WoZKKs4P+RMYVL7Cyz5rTozkqN1LFEZKxQrY0UWy/+P4MTVZ7JlV/GmTfYw7g
         BHdpmSI3dFIhezek0dIMEojwsl7VI9CpBDtWrVKxWRCyxE8FKu9tCx05MK1Z19mpDbLY
         UAmVUcxpvcLdZE3bWKkeviuFv+z6weHemrn+Q1dbNj19BdhmlV3lYWFxMcZ5yjPYSXjG
         1ICMvCFl+bVV4g0F5SiLzhG+oRaoJBenKb2hyA5tkvyV436rK7zq2Le6HAfSbviCkDzM
         W8gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775828407; x=1776433207;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iCXB7w7ko4o+lkpt1Tfr/OwLPxl1m2l/vGRhYm7vF9w=;
        b=bUDeOUVHU7dRcay5d9LCM7JDkVM6nucBDENc9HBcy+e/S+d0cxd8FwvdvV5fUuu8O1
         lcnVC3D0O+3SkgBKz/vyIj22Rm3j7yBEM6078lGcllFvNN6sovSHQHeoC/dsf8csdlQn
         ZsGDPz2p5tHCoetiQmfCvblgLb/eYXx1S0y/QQD8Lvl4CY4zDADQA8IL58VvchMR4OXl
         xpKoTKzpXCAhFKqYASRvEp/P+3zEEfYv4lwE3Clqf6w/43WWfvdXU6NhYv8rRPCC3BOt
         7lCHKwJfafry2r7QspJso5qvZ9V5Bh//Q7cKG7ciD9x8xbLEXftz9DB+ZHlI/21BYhYC
         Ku5w==
X-Forwarded-Encrypted: i=1; AJvYcCXnocfRQGoDrK1lX28WJaUqMQlQ9t8Hmjn6YHx4MES8mxgOjKK6ssb36UMy89IpL6dvQox2AnvfQNJm@vger.kernel.org
X-Gm-Message-State: AOJu0YxdR0xDy0Ii3+IdLz4MbuE2CU3XrCtSwVNzkKdHH28RmkW29P26
	0X7EzPPerDVeu+u8OCQlIjUehNVUgsyrE6mB/FDl70ck8AUUEbqYbEBJL4VKLbMNIfBK9t8/Tyn
	+tYirceGUwU1OKNEK7xGlq7tXp7xbyXc5uEdffMEZ
X-Gm-Gg: AeBDiev8O2nWzXbTpaWlpEIg0SRvPkTPOuqdNpyTmG3DGKBnZX78I4h0Io7nOFgwiQE
	fiH4YLY5KPWAWixD/7qHFpVhGvfSnSJUAv/qsjOIMk8i9v+zIn7v/PdP3tXKwzh5jjnmAwJysfB
	EJ8zjdt3KjcGdLrSQmlROMpHDSGGK6w/9B81zecABkIEDsrVziwzsFFPOsW5gkPUd9pK0WdzwkU
	DWVTv5o4U8+DcPmjOfjteOWyLyqcHLu9z62Wf1NMRj1beyZbtPZrthASMSKKYCUhZ+w8CNAi3uT
	uBYD2lW8CLGodgz/lmHW0z40ZnZ0AA4+FjJSDVQyfuVX6jeE
X-Received: by 2002:a05:7022:fa04:b0:12c:2ed4:62fa with SMTP id
 a92af1059eb24-12c34ef907emr1882312c88.32.1775828406651; Fri, 10 Apr 2026
 06:40:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410120044.031381086@kernel.org> <20260410120318.862164111@kernel.org>
In-Reply-To: <20260410120318.862164111@kernel.org>
From: Marco Elver <elver@google.com>
Date: Fri, 10 Apr 2026 15:39:30 +0200
X-Gm-Features: AQROBzBE-9UxDQG5mMJLgipEeL_Y5pwE-Y_PUrJGxDBLilqBu51b8lLzxdip708
Message-ID: <CANpmjNO1vsO1LT6xijhz3nsjQa+_A=9omfgOSz=aGn293-LqTg@mail.gmail.com>
Subject: Re: [patch 19/38] kcsan: Replace get_cycles() usage
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Dmitry Vyukov <dvyukov@google.com>, 
	kasan-dev@googlegroups.com, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, 
	Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	linux-crypto@vger.kernel.org, Vlastimil Babka <vbabka@kernel.org>, linux-mm@kvack.org, 
	David Woodhouse <dwmw2@infradead.org>, Bernie Thompson <bernie@plugable.com>, linux-fbdev@vger.kernel.org, 
	Theodore Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Thomas Sailer <t.sailer@alumni.ethz.ch>, 
	linux-hams@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	Richard Henderson <richard.henderson@linaro.org>, linux-alpha@vger.kernel.org, 
	Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Huacai Chen <chenhuacai@kernel.org>, 
	loongarch@lists.linux.dev, Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-m68k@lists.linux-m68k.org, Dinh Nguyen <dinguyen@kernel.org>, 
	Jonas Bonn <jonas@southpole.se>, linux-openrisc@vger.kernel.org, 
	Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, 
	Paul Walmsley <pjw@kernel.org>, linux-riscv@lists.infradead.org, 
	Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 Apr 2026 at 14:20, Thomas Gleixner <tglx@kernel.org> wrote:
>
> KCSAN uses get_cycles() for two purposes:
>
>   1) Seeding the random state with get_cycles() is a historical leftover.
>
>   2) The microbenchmark uses get_cycles(), which provides an unit less
>      counter value and is not guaranteed to be functional on all
>      systems/platforms.
>
> Use random_get_entropy() for seeding the random state and ktime_get() which
> is universaly functional and provides at least a comprehensible unit.
>
> This is part of a larger effort to remove get_cycles() usage from
> non-architecture code.
>
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Marco Elver <elver@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: kasan-dev@googlegroups.com

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  kernel/kcsan/core.c    |    2 +-
>  kernel/kcsan/debugfs.c |    8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> --- a/kernel/kcsan/core.c
> +++ b/kernel/kcsan/core.c
> @@ -798,7 +798,7 @@ void __init kcsan_init(void)
>         BUG_ON(!in_task());
>
>         for_each_possible_cpu(cpu)
> -               per_cpu(kcsan_rand_state, cpu) = (u32)get_cycles();
> +               per_cpu(kcsan_rand_state, cpu) = (u32)random_get_entropy();
>
>         /*
>          * We are in the init task, and no other tasks should be running;
> --- a/kernel/kcsan/debugfs.c
> +++ b/kernel/kcsan/debugfs.c
> @@ -58,7 +58,7 @@ static noinline void microbenchmark(unsi
>  {
>         const struct kcsan_ctx ctx_save = current->kcsan_ctx;
>         const bool was_enabled = READ_ONCE(kcsan_enabled);
> -       u64 cycles;
> +       ktime_t nsecs;
>
>         /* We may have been called from an atomic region; reset context. */
>         memset(&current->kcsan_ctx, 0, sizeof(current->kcsan_ctx));
> @@ -70,16 +70,16 @@ static noinline void microbenchmark(unsi
>
>         pr_info("%s begin | iters: %lu\n", __func__, iters);
>
> -       cycles = get_cycles();
> +       nsecs = ktime_get();
>         while (iters--) {
>                 unsigned long addr = iters & ((PAGE_SIZE << 8) - 1);
>                 int type = !(iters & 0x7f) ? KCSAN_ACCESS_ATOMIC :
>                                 (!(iters & 0xf) ? KCSAN_ACCESS_WRITE : 0);
>                 __kcsan_check_access((void *)addr, sizeof(long), type);
>         }
> -       cycles = get_cycles() - cycles;
> +       nsecs = ktime_get() - nsecs;
>
> -       pr_info("%s end   | cycles: %llu\n", __func__, cycles);
> +       pr_info("%s end   | nsecs: %llu\n", __func__, nsecs);
>
>         WRITE_ONCE(kcsan_enabled, was_enabled);
>         /* restore context */
>

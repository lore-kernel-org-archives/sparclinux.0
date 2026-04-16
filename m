Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A243A874D
	for <sparclinux@vger.kernel.org>; Thu, 16 Apr 2026 11:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776339012; cv=none; b=OxclJhwPTRU/6VHVCuUZnyjhBmEoDFNJbH2zL0lqPK8Fo0Whg9X7x3o7KazQpuleAyHOVRVEx69HGp/bgLPvRoKBkXE1VLY4MEeZCFh8ftdyb2XW6WGWKjlBiiTc670I5pU7C7ixNCPaP9YdR8b+xos0MvYp4kv7xhCcv5ZMW88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776339012; c=relaxed/simple;
	bh=onL90hyVAUlPY0ASaWQwK2lX8QEYr5m106IAfPoIE0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sXJnfOnmgQ+W/YVEFEKSr3KC02G86mwvQfqgC6NjVKrbSbWQbmPnsNT6euZenPEZErLdelrn2Vd6KXJqQ7R0U+26uXRkRmZV66pIjCB8Ht4cIyQM5WIjxjP9XS5EcdCARAzkduPjq+gsVIJ44tKV4mvgMhKvHpAeHj8x2zfRiYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8cb40149037so729445685a.2
        for <sparclinux@vger.kernel.org>; Thu, 16 Apr 2026 04:30:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776339010; x=1776943810;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0N28AiHhMQm9a3ncbvMl4jwXcNZbOrN6OiiJm2DjJOE=;
        b=RfT09WhpZXsBC3Zf2UMQXylbGM4jW0fV4vF/9ItUGyePGW4qh1S++vldAQjWMlOcvt
         vxx0OvLHLuus90DWecDLIICjJCQWUNXd6fFT4E6DtyTnTGi7arFBcYWBI7gEIYofn8cD
         U/92gxFooi7Hal4ELMsFTUCxnBe+Dyt4FIpszH+h37rlE/NKraohDJh+jj2OqXHlWUaF
         p7sfpA4ZitowHx3fLE0lLre/Qz3I5vfF466ZWlTr9zYDnXIO7zKshfCMrFGYfBnnjKba
         qvTKvDX/bwqO+MiIIQa19lRmgSsuj6WnnyufwCGEaljYPEZ8Eu2RhcSwNhxbrbSpuz1K
         qu/A==
X-Forwarded-Encrypted: i=1; AFNElJ9FKJIuIGfzTHaing+MoGJue3CJGeHNLfCXRivqP4Jko1iOMil328y9J9NeLyyJ2F3rYuL7OP9nrFs9@vger.kernel.org
X-Gm-Message-State: AOJu0YzGIfnxnBOscW+K5albCX4KDVES/PKCgbBcrKcsT6yVVQSlkSKb
	32e38JcUmX2x1x17TZXCsH5FZ7lYjzAM9ULuTgHsKa5ALVE710XBnp5qmpJQK0Wk
X-Gm-Gg: AeBDieveCrJHnpwa/qo+UGQDa6Vw2/QYyAedOjBk+26zVb3e6OcldkymuKr+u4NPnDH
	GPwux/5+I25NZCeaaF96rQjmY7ZqpnSOMnDFVyd2u/l29FqSWIRpefX94z0gReZPZZkUK6OexT7
	coH+B/hvmd1hIlnfBOnF/K2sdm6nVXqsNnZQXKSFEtz0iUkHS+ShV/rtxSj6cIf1VzgPhP8KWB3
	GUcvka0g4MV/XVloSmVDiF/IeVpcqs+N/fY7C9dL5rdZXtf8MuvqefPzRW0vWtRq/cN0DvLX8lF
	hDseY5F0WGEiVe7w0TqSHPU8FVrvG7cTHG2QanFNdYnSaIn+5d9yM0l6lPk6LkUyS/iNkDux+6r
	GZSvDWt6LbU7RFZeGDNl5+uGJQ6Ih36181tmzG9Bp+0qoyA2ZsfUbUrZ+lddnOG89PZQgUmX1vG
	WqpuNXxQpeSKAwR9ByZUxA1y+NPTWokOe14IcezkoFld79TcKGFmHftVXRoGi4P2xegpVohY9Sj
	t5FVa/iDdvJnQ==
X-Received: by 2002:a05:620a:4725:b0:8d7:531:cb8e with SMTP id af79cd13be357-8ddcfca6257mr3885044285a.49.1776339009564;
        Thu, 16 Apr 2026 04:30:09 -0700 (PDT)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com. [209.85.222.172])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e4f31f8d27sm341230285a.44.2026.04.16.04.30.09
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 04:30:09 -0700 (PDT)
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8d560ede296so924669985a.0
        for <sparclinux@vger.kernel.org>; Thu, 16 Apr 2026 04:30:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9n1KsDfe9CQRtvU+dSqm64nNsR3aXKr9jxkjXiEWP4IZJMq0f98Mfj0X8hvUNE/cCJ4DN/ePW15/l3@vger.kernel.org
X-Received: by 2002:a05:6102:3fa2:b0:608:1b6e:f4dc with SMTP id
 ada2fe7eead31-609ff0c50e9mr11028119137.11.1776338540828; Thu, 16 Apr 2026
 04:22:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410120044.031381086@kernel.org> <20260410120318.045532623@kernel.org>
In-Reply-To: <20260410120318.045532623@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 16 Apr 2026 13:22:09 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXtR7T62Wf+yDM=J0+96C64qRws=ffX_xXbfzfbS0Xz8g@mail.gmail.com>
X-Gm-Features: AQROBzCyA8BqoTVnHFn7fWQMKVWyMF2wrQlYn44P8f0X0RsdCOwGnnxui8decDA
Message-ID: <CAMuHMdXtR7T62Wf+yDM=J0+96C64qRws=ffX_xXbfzfbS0Xz8g@mail.gmail.com>
Subject: Re: [patch 07/38] treewide: Consolidate cycles_t
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, 
	Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	linux-crypto@vger.kernel.org, Vlastimil Babka <vbabka@kernel.org>, linux-mm@kvack.org, 
	David Woodhouse <dwmw2@infradead.org>, Bernie Thompson <bernie@plugable.com>, linux-fbdev@vger.kernel.org, 
	Theodore Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Thomas Sailer <t.sailer@alumni.ethz.ch>, 
	linux-hams@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	Richard Henderson <richard.henderson@linaro.org>, linux-alpha@vger.kernel.org, 
	Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Huacai Chen <chenhuacai@kernel.org>, 
	loongarch@lists.linux.dev, Dinh Nguyen <dinguyen@kernel.org>, 
	Jonas Bonn <jonas@southpole.se>, linux-openrisc@vger.kernel.org, 
	Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, 
	Paul Walmsley <pjw@kernel.org>, linux-riscv@lists.infradead.org, 
	Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 Apr 2026 at 14:19, Thomas Gleixner <tglx@kernel.org> wrote:
> Most architectures define cycles_t as unsigned long execpt:
>
>  - x86 requires it to be 64-bit independent of the 32-bit/64-bit build.
>
>  - parisc and mips define it as unsigned int
>
>    parisc has no real reason to do so as there are only a few usage sites
>    which either expand it to a 64-bit value or utilize only the lower
>    32bits.
>
>    mips has no real requirement either.
>
> Move the typedef to types.h and provide a config switch to enforce the
> 64-bit type for x86.
>
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>

>  arch/m68k/include/asm/timex.h      |    2 --

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

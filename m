Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2253A7F70
	for <sparclinux@vger.kernel.org>; Thu, 16 Apr 2026 11:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776338996; cv=none; b=FihI5jaBOen9v8kHvt+qPqdrVzlU04oQOjF5KO8J6mZ2ltezpiNaoDrNmlkbUNP2DbtG65XYytDdqf1s0t+HL5543BFynKfgM+GI7KeyCbEcIhaXmBYFRN3MtR7Fj7rrH/Z9d0GJ+oVhLKjBL9Pv9pGpdr0Ycm7uZubDMyIvgIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776338996; c=relaxed/simple;
	bh=5RcGmn3E6IkK/4PLTUVN24XJ2jAiV11BodM4t9S5uGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kxEybIqeH3D+ZPV0QPUAGybUZE3sYye47qlkL86l1Ncm+FFyKQotyddMKxA60Jlnu71YLnPNwz4zGW1lGb1vp4EuZAEUokniJJe6/TnKJ2vZg4SWVCHR2prNsBFcDRaRHDjPy1zbR5YuwujlCMyHKcGCQLzayYUBowXJs9gHCTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8aca4e14411so58191026d6.3
        for <sparclinux@vger.kernel.org>; Thu, 16 Apr 2026 04:29:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776338993; x=1776943793;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6jqlHRyBmHp78NPQbVn/INUSPCxYZ/sUXVIyq1nXfE=;
        b=IZT/nBN+K4MOcgfBiQBJ5CSDCqH/TQaLZ+rWMkxm0nBIVKZRBgUN3xiH4L1wTePj+2
         vBrQpoj0j7BIIDQp3zxQSL05QXMOxLABlGV7LJDx/CYzO9TeGenb+kyt2vD4iuM7ojH+
         konDTatu7VPJ6qOODrYFj5lkGQgKd3d82Pku7XhFvRDmHcN2lkG4emRdN5mfpfSxTry4
         OgEf+otN0eerxSDUw12aW+FNenQ0fYOgldrUBpU8DWUy+AxkZAe/7ZO0zDZxMPosfwRY
         ozO9mM0Y+Ngno+lhJXbfeqmQP9dbjU6o0A8sJZaCNxEEXV/dQCSWF02lDOvdOieynP90
         ypDg==
X-Forwarded-Encrypted: i=1; AFNElJ+ijnSypTIl/Lm3Q6FQCgpns2Yg4gk1fXSUqNLxIht+c5je92j1HNQnBCr2vCaCmnD+kQQMSZpQrWHx@vger.kernel.org
X-Gm-Message-State: AOJu0Yzciro8L4w3TwyUx6tS7DmVmErtWmwYGozJRUMOUEmJSn1I66YN
	DOY/Ka4Q/jM00k3HA5k6QcG3LH/Jnei0fBtmyqZSWmV2e0RFpSw3UL2qrixieA==
X-Gm-Gg: AeBDiesKgCF4PZR0vJyHbavcgJ7Oz4FOMUe2r7+s4WScYbXcFSYdCdMCbdQtqDmFnEj
	xKUhSSMQ3S19Ikn6M1UzQwRHzZsNMLPAKxPTfiAn5bCHk1kesiabSRLGVT5MFhaEs73S04ByTga
	eyA8krHjp0rvJHNSxxVap8+CRj62qqjOVuN7YpjG30rrSk/J3eix9JvqOdAMnsKcFVed3olyA1e
	ahX1P8w14/W+j+jAemn+AJ+55qsNPULk/1b92EqvgcRwrzJ0BJiheE9gVDbYRjkXwFZ52LOso+w
	twt2IikeM1tROTJOvZwwJeyk5d/H4yIM8xshvAet/BxGvxseasGh3BAY/dQ7bxXbzPBfNGhjm9c
	JrYX4RKLm/8W9TBt0peIVEZ1J4zNmtsLZvvo/KXyObDrO3EVEEyRC0KGc0gFbfCO3ajzWQCeFxU
	77TpM/8MUFqX/jpZ/EThuxsLDKUPd92FZxO31GoO02UZcd321abxURGRz3wsCK1LMDx/2LewD/O
	MM=
X-Received: by 2002:a05:6214:2123:b0:8ae:64c0:c914 with SMTP id 6a1803df08f44-8ae64c0cc6cmr151866106d6.10.1776338992874;
        Thu, 16 Apr 2026 04:29:52 -0700 (PDT)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com. [209.85.222.169])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ae6c93830esm43055786d6.9.2026.04.16.04.29.52
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 04:29:52 -0700 (PDT)
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8dfd34c9ac0so362964885a.0
        for <sparclinux@vger.kernel.org>; Thu, 16 Apr 2026 04:29:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+vT+VvVNGNH/BQce0aYAYM4d6Rw4Uel9/uOL0uhk6ruoyhoRrGXh9Zbc0jfPYjNrbYCxqGteVZLDzt@vger.kernel.org
X-Received: by 2002:a05:6102:6044:b0:5ff:c64d:2283 with SMTP id
 ada2fe7eead31-60a0157295cmr11348128137.30.1776338547396; Thu, 16 Apr 2026
 04:22:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410120044.031381086@kernel.org> <20260410120319.397219631@kernel.org>
In-Reply-To: <20260410120319.397219631@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 16 Apr 2026 13:22:16 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVoo_6i9=2oQj-=yjW7nK8eL4og08bdYvk_EGj=_cQvQA@mail.gmail.com>
X-Gm-Features: AQROBzCJ6rVnwwfhi99PI36wWXAFQ5DEgo1zw3RhVwYNSXoxkTYAcgIxt5Z0K1g
Message-ID: <CAMuHMdVoo_6i9=2oQj-=yjW7nK8eL4og08bdYvk_EGj=_cQvQA@mail.gmail.com>
Subject: Re: [patch 27/38] m68k: Select ARCH_HAS_RANDOM_ENTROPY
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-m68k@lists.linux-m68k.org, 
	Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, Lu Baolu <baolu.lu@linux.intel.com>, 
	iommu@lists.linux.dev, Michael Grzeschik <m.grzeschik@pengutronix.de>, netdev@vger.kernel.org, 
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

On Fri, 10 Apr 2026 at 14:20, Thomas Gleixner <tglx@kernel.org> wrote:
> The only remaining usage of get_cycles() is to provide
> random_get_entropy().
>
> Switch m68k over to the new scheme of selecting ARCH_HAS_RANDOM_ENTROPY and
> providing random_get_entropy() in asm/random.h.
>
> Remove asm/timex.h as it has no functionality anymore.
>
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

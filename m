Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043473F9288
	for <sparclinux@vger.kernel.org>; Thu,  9 Jul 2026 08:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783586534; cv=none; b=GE+YgOGInCdqHhQB86ax5/sdcetplp72xx+cgeBFeZl39njEgD68vy+slNr8dzXTfj9gr44GvQzL3MLYKMz4C4m+eexIvILxanX5d0ODu9B2oZFMLiOFSWer/IFGAWiC/SSVOy19ax21iA5fFZgW9UrcO5wWBBuEtX7+GzUZ78c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783586534; c=relaxed/simple;
	bh=vcIYcFn8wOu64JToHCd3V3ghUBsco6aWxPDuriYHfZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m2ay5/chJW8EPv9YUUPskHI4U/4AJvwACLlIHIBCwQGr1SI8w/gBLLMM7HII7GrIqRV87eomY+3IQxF6PTxgGPpYVUyLh7VMBgv2n4ToGZyKBQUQYb/xA4fenvptlie6G7Bv8ew8kfDG+mY/LqNZLFi/Rn1mxGOP1vUz2ghmRvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5bef75a83e4so497811e0c.2
        for <sparclinux@vger.kernel.org>; Thu, 09 Jul 2026 01:42:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783586530; x=1784191330;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=O3mkBNkViagFAJs3obyg41kBlrTMtmvpPUP/R2gZOPo=;
        b=TA/e6CjA/t9+lY7aMTJrA4sA6PuZUgTfRewg9SzQHggNqVzOVVUQwYZCa4/+xniyXb
         T9+btn9922y1wKK6yTafjNOvx8uAKET9Gya+2Zl2rTJeF/5U+zwClp42jC/OLOUcmKbr
         fc/jXG41whZBlaoWW42MimIlC8ZXrxYDKE9oy5eNMsaemJ/rZRPL1LCleAW9Ihsb9wQi
         pgYnpXUATvfhWXoWAeziWo86tVJ8cKEZOu/5GNGLyEIqJwpfGkWBwMSpghe1Ou83l73x
         2FLkECBx3NcgVBxx/3eR1GbfqHX2ZaaJpXIjvh8YvnOkPD/l7BLRloHec3OEv/IApUex
         ncNA==
X-Forwarded-Encrypted: i=1; AHgh+Rp5TDR6y2vWillU6YrQiWVOQAE/bThANQqp4r8Uc6DYGhpLngCFH252HAHkxn+wbUy3LszYpBFtAmjh@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0/LYY9iyQSELeLxdJsh4+8DCEuvYUw7jDSNnQFiQuDivDk5Ae
	x30tD7Y3kaHpO7ir7KchdS7l3R0qUaqpUoPjfrooSm0+a9tgNbR6h8CwCwTfU1EXhsU=
X-Gm-Gg: AfdE7clWXZcA0/A+/8pleJvb4qHSobf1cnfAMS/LrQPVNmzjOhwHAvRb1F0X9e1FxJG
	cyqpTlNMd0qhWI/F9ZN0LQwQfhVbJI7oXtS7vZjaRq48V2QuQGdnrp0ONxnrptFzDL+TAxchHhB
	j1wFMIty9LpymXVY7TQFAvpIaVm0d3UvE++agf1SA1ZkSDDbjsfJ+k9aSkH+oaU8KEchc533MyV
	JVut/wNa3yYWiGf2Ibbd1EL8BOiX3pJ9MZ3OS2H9lEsOOADImGoV83Sox8447WKmSbfcTYqJT0R
	xx/AWBz4FWr6Ah/j8onah9EX6cOx/WecXlfQQoEDCPU4wPFTxAnAWoNf28RwHgg1G6WXUdZ2X9K
	e8idDxd6Z7It3Ekst63a8+mzCONfFKwUK4Xke3zhaAIqVLDslnzouyOe93LTw3n2Uslo+aAbPDr
	QhEEZAvRvzUgSq2h9Z9TaTGkDsgBNKroYC1iuW0dtgAz1ivr7gSA==
X-Received: by 2002:a05:6122:4fa2:b0:5bd:aa13:c992 with SMTP id 71dfb90a1353d-5bf75f05075mr3319094e0c.12.1783586529776;
        Thu, 09 Jul 2026 01:42:09 -0700 (PDT)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bf6f68d099sm3375373e0c.8.2026.07.09.01.42.08
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 01:42:08 -0700 (PDT)
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-9696369925aso494414241.0
        for <sparclinux@vger.kernel.org>; Thu, 09 Jul 2026 01:42:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqV68C1c4f34l3ogB9lJf9LbVoN5GdKHLrb86Y7bG2xdDdLcWewIkjC7lN20O9giH2QALq/f0PjpqL4@vger.kernel.org
X-Received: by 2002:a05:6102:6895:b0:738:9dd5:9b03 with SMTP id
 ada2fe7eead31-744e03a337dmr3306957137.20.1783586528282; Thu, 09 Jul 2026
 01:42:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707181957.433213175@kernel.org> <20260707190254.280015701@kernel.org>
In-Reply-To: <20260707190254.280015701@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 9 Jul 2026 10:41:56 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWe1D0CZrav5h6EhDDbeJzgJcHvT89jrs6109Bdj-pdTw@mail.gmail.com>
X-Gm-Features: AUfX_mw8w2Kp5VuAYozzfDNS6gDbdKhQdYzfXsv-G72F3LS58UBytbGwOmplITc
Message-ID: <CAMuHMdWe1D0CZrav5h6EhDDbeJzgJcHvT89jrs6109Bdj-pdTw@mail.gmail.com>
Subject: Re: [patch 12/18] ptrace, treewide: Rename ptrace_report_syscall_entry()
 to ptrace_report_syscall_permit_entry()
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>, 
	Richard Henderson <richard.henderson@linaro.org>, Vineet Gupta <vgupta@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@kernel.org>, 
	Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Dinh Nguyen <dinguyen@kernel.org>, Helge Deller <deller@gmx.de>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Chris Zankel <chris@zankel.net>, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-arch@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, x86@kernel.org, 
	Mark Rutland <mark.rutland@arm.com>, Jinjie Ruan <ruanjinjie@huawei.com>, 
	Andy Lutomirski <luto@kernel.org>, Richard Weinberger <richard@nod.at>, =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>, 
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 Jul 2026 at 21:06, Thomas Gleixner <tglx@kernel.org> wrote:
> The return value of that function is boolean and tells the caller whether
> to permit the syscall processing or not.
>
> Rename the function so the purpose is clear and make the return type bool.

>  arch/m68k/kernel/ptrace.c       |    2 +-

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

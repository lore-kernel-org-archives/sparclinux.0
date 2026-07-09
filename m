Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07FC3C98A2
	for <sparclinux@vger.kernel.org>; Thu,  9 Jul 2026 18:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783622084; cv=none; b=su9FqjX+2s7XsKmunsnZvjXkoSE0qwv0+eFgkr2Od2Wic+ut7ZFfVIngtCETGBAjT4LeWlQt3hKmFmJf62Qkf924T7ZMRahYLzOMapkzRcejd8uzlqwm2hgXfLNxFghzTZvqIOkHBBlfrYs0o3Gl958N5SM97HlD7mV8j1b9DDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783622084; c=relaxed/simple;
	bh=jgoYslbmrTXQwTFPwDFZi/esOXDuFRs3hpbsZJU8/Hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Adwbnq01vGgmddD6A1oJG4WgsrdCFEnMN2vqe9n1cbmEyJGsU25PlMbQuBsFhoHBBnyrVUx0sznSIj9vEtyNrrlwDckmIfHnN+Mg17IdWiqUmg6/F2BkXWv9JdcC2HmYN6v2CBiT3/1IfnmlCzZFszrdrQjeZuLaAMRb+9KJUoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n0fzrpMD; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n0fzrpMD"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-380cda7f00cso245905a91.0
        for <sparclinux@vger.kernel.org>; Thu, 09 Jul 2026 11:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783622081; x=1784226881; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yghYN6q10g6FdWlsVt4/TtDo8QYt/j/TS6a9b2++LOM=;
        b=n0fzrpMD9onrNxJeLrNwUTvzxEDOaOsMTVI4DCm8+KkbMQ1ZVT5Wep9O4PFcqc268F
         jTR83NVpdxid3LRXc9zk3RKZ0yWcWN+koM9Ez4cI6P74BUUpnh4FAcDDlHkIMeGMMuCk
         lU4eyiXoxCXPUbh7sTljXrRBeeM0/UHowJJqDGbjSRWad/8fp2KHzEhlT6cC+TtLe71q
         6dpI3K3ByC3JIDyaG9+XF5CjXDgMmLUq2e1O3u98csTW8lqZaDndi9hVZauqr9GXL1pZ
         BT/EbI0wmgaTEceVfC9iUvhc9a7Bi6CpCttbk5MuGRldVWGkvixEYrwznVv91AeNaVqG
         cdLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783622081; x=1784226881;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yghYN6q10g6FdWlsVt4/TtDo8QYt/j/TS6a9b2++LOM=;
        b=iu2TLX2YR3WHk0b+IOwgeS2mQCXixsePJexNUwhUE7PrG+iqjlqD/uvDHeLVIKP9YP
         b3MObvf2UKKsOqH/ozDW5zVA8oPbr1jv/IXAh/fVfhZNeWuL97gcovJpqscAliUV9pOx
         VyhkDRuDpFmKnp753TCGsxck6+qtvEs6ApZH4S/7A/hOGW8WWwYmNg48hytWAlgJyy00
         u2Z8OtfnyMF3Qd8bywbEM6EPV1ONZVDDcpxRZC+zBrnRZiBT71mbS72Y1vrmh+H7PAmX
         Rkyo/JOX/aRpOx/JZuw0yvsalm5MnXDcjbppSsFkbMKGFZKITqDNG9Pexbq9QgryeyVl
         VekA==
X-Forwarded-Encrypted: i=1; AHgh+RpjPekZ6LQd+jlYKCI3EqxE9mTonFcRDoWEr05H21zTWpDj0GUcFpTSFVgD4WA0uqM+sZ/nz3aRUu7L@vger.kernel.org
X-Gm-Message-State: AOJu0YxL9ZgLEA84viE2awMxUo2WmB/9aIEmEF6fQeFVJtYKa8Wrasl/
	llRL3TFFsS79qTZr3l00F6K7dFNFSka8tPJOPG4thhNeyRZeTeo16YBG
X-Gm-Gg: AfdE7clEAJ3RSKJcLpdYpW014Z5heXybTPVhuc5P3XpK73C5KCKtFiDAzI9xCWCvzNl
	V/Ug9eapLo6aqOu30XlxVi0MpKs2jMPJ2nz7LJiNC0MHNMbsXdjIKkfPrzCDVMuM9j+50xY1ojp
	VHv97qXKmArhGPQPk9LJ1CzJBzGXrfxlVF3GTsjW7m8wG7lPnjJH4PSmI3QUCHX4uaJTNL/XSod
	LD/vc+iKOmPEQE7WUgLZ3XWEoXFyw7LGQfZY3mREemjhdqbaQfvPr4IVcxJUuwExT3fB559KhFy
	tLC/QlVte0YN1cniOQPJdE6BrZw7bbdlmRi5Fpo8qlv6fij2FgGJ1wpjkWJ7M2YF7mpUnyt1buk
	O71tSDB2yCKVxFh5mKAqebP9JiCAo/l85veigLL4RO3hMLaVx2JRUD0NJvX2oLyBGmnyxWEaxvl
	8vRhwJjaPFwHvOZYydIl9c4DMWlCFA68NvjcgAfcNZxqTELZahd4W3ojASFiNl
X-Received: by 2002:a17:90b:2752:b0:37e:10d1:c05b with SMTP id 98e67ed59e1d1-389417e4858mr8140301a91.22.1783622081049;
        Thu, 09 Jul 2026 11:34:41 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311a6115e61sm11123455eec.22.2026.07.09.11.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 11:34:40 -0700 (PDT)
Date: Fri, 10 Jul 2026 00:04:21 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Kees Cook <kees@kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	linux-riscv@lists.infradead.org, Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, 
	x86@kernel.org, Mark Rutland <mark.rutland@arm.com>, 
	Jinjie Ruan <ruanjinjie@huawei.com>, Andy Lutomirski <luto@kernel.org>, 
	Oleg Nesterov <oleg@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Guo Ren <guoren@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Helge Deller <deller@gmx.de>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Weinberger <richard@nod.at>, 
	Chris Zankel <chris@zankel.net>, linux-arm-kernel@lists.infradead.org, 
	linux-alpha@vger.kernel.org, linux-csky@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-um@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>, 
	Will Deacon <will@kernel.org>, Brian Cain <bcain@kernel.org>, Michal Simek <monstr@monstr.eu>, 
	Dinh Nguyen <dinguyen@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, linux-snps-arc@lists.infradead.org, 
	linux-hexagon@vger.kernel.org, linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-arch@vger.kernel.org, Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>, 
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [patch 02/18] randomize_kstack: Provide
 add_random_kstack_offset_irqsoff()
Message-ID: <ak_piRRvfiMc9m7N@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260707181957.433213175@kernel.org>
 <20260707190253.768842729@kernel.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707190253.768842729@kernel.org>

On Tue, Jul 07, 2026 at 09:06:02PM +0200, Thomas Gleixner wrote:
> add_random_kstack_offset() uses get/put_cpu_var() which is pointless
> overhead when it is invoked from low level entry code with interrupts
> disabled.
> 
> Provide a irqsoff() variant, which avoids that.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Kees Cook <kees@kernel.org>
> ---
>  include/linux/randomize_kstack.h |   19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> --- a/include/linux/randomize_kstack.h
> +++ b/include/linux/randomize_kstack.h
> @@ -77,8 +77,27 @@ static __always_inline u32 get_kstack_of
>  	}								\
>  } while (0)
>  
> +/**
> + * add_random_kstack_offset_irqsoff - Increase stack utilization by a random offset.
> + *
> + * This should be used in the syscall entry path after user registers have been
> + * stored to the stack. Interrupts must be still disabled.
> + */
> +#define add_random_kstack_offset_irqsoff()					\
> +do {										\
> +	lockdep_assert_irqs_disabled();						\
> +	if (static_branch_maybe(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,		\
> +				&randomize_kstack_offset)) {			\
> +		u32 offset = prandom_u32_state(raw_cpu_ptr(&kstack_rnd_state));	\
> +		u8 *ptr = __kstack_alloca(KSTACK_OFFSET_MAX(offset));		\
> +		/* Keep allocation even after "ptr" loses scope. */		\
> +		asm volatile("" :: "r"(ptr) : "memory");			\
> +	}									\
> +} while (0)
> +
>  #else /* CONFIG_RANDOMIZE_KSTACK_OFFSET */
>  #define add_random_kstack_offset()		do { } while (0)
> +#define add_random_kstack_offset_irqsoff()	do { } while (0)
>  #endif /* CONFIG_RANDOMIZE_KSTACK_OFFSET */
>  
>  #endif
> 
LGTM.

Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> 
> _______________________________________________
> linux-snps-arc mailing list
> linux-snps-arc@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-snps-arc

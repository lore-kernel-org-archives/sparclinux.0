Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFBB4446F6
	for <sparclinux@vger.kernel.org>; Thu,  9 Jul 2026 18:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783622565; cv=none; b=JgjPaD2LRCn8Q/HNvwRD36X8DQpD+LhHdEjLHKkvd+7dbNpnvmbfEzLko7kKNBYQNcxzniApsgjeISBZ5ZfiNIhzmtF8pxHUh8cpImtBu6wg/LsYG4PL1vPBhdN2BihBRDB7O7z847RwAN3r+eqmQGdZa9iOJF6v15CxDnhJUoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783622565; c=relaxed/simple;
	bh=jxrFwpuvrTS1XNI/bITRNy4rM5f6KM69+ytcvmY9Kws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dsH/8/EPlrEAal3PtHHCluON9YppZbBDJ3ptyBBNsGpDb1Q1uwQMW22jymL/DDZv+n22sM0iwX8UWlCu3WA54Dr5UgxzVcxqhW1crHcr/T+VlDCWHFMy4j4fGXJqjrfIbH/8RrjRd2u5qvFHpXRk4+HsJZe2HgHswFkjfoUsUQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6gvfzDj; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6gvfzDj"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3817f800c8bso231876a91.1
        for <sparclinux@vger.kernel.org>; Thu, 09 Jul 2026 11:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783622563; x=1784227363; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SzGAEyDF8npliwHJTsZ1x6gPZlMpJ+A+8igDYDtce2g=;
        b=U6gvfzDjo4nu8YyTuL1rd4RldHrXshiAzCDQI0Op6aGgTYJr7abS6n1/CkidpgGpgo
         qEuUwuKusDonHWkcq5kScBASsmzOJ7UM/6j+aMrGQOd019d6S88tbOlTIGLHRQ6dW/PV
         kSRMrTwvUFbc7HdyE2VVbt6u0XmS0tWN6Z9KTqlW/ss+ZJd1tOqGRlWk761zGt4Vaoql
         x1s3NoTr+xJINeE94lVp55FIi43Ex8fxtSfF+E8R6O6b6kZskp/BrWnI7tbkn0ePHktX
         GaU2ywLRtMc1KZoHoHHieb8c3DTeztRs0k/MG3m73q3GaJjt2+5mg0yO0v1qZEjnqoSd
         ywPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783622563; x=1784227363;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SzGAEyDF8npliwHJTsZ1x6gPZlMpJ+A+8igDYDtce2g=;
        b=FrdAkG/Eq3AGv4EjDWFcF6lQ45uddxfwgLAFQrmeuLpXrShMHGcjVSZE3qi+TWw6UP
         qCoaVCgIipFdZO6SpSZuK3luo4b0AlYaGsICJEz9vzYB4NSghr/9tfwrqEhNBLsh3cS1
         22Z6hIuFXouWwz42ZU4151cSE3tPhfCiZ3Z0BAVmJpD5al410lMJfXa1uI8CjOmNmKfw
         j6qiSD8mKGN8RRGkeioEF5fiAS+K2gZnZOyRVLvYyRfXJXU21/WZ2xpzA/RNA2GEFtjB
         IgwWzyvwW8cWmc1jIT/JpR1PCCBQoO/ZwnKN9byU8lYv4pBQkUvDbTIs7uHpQs+zLtxf
         L1Fw==
X-Forwarded-Encrypted: i=1; AHgh+Rp19J3wv0ar7hCdU4KjrO7e6tS4yJZUNLG1VJLp7my5KvwLo7FXoMOE2ox9wMULdnZEYbYSXhnjav4e@vger.kernel.org
X-Gm-Message-State: AOJu0YxRW20T/qig1j/LllNrAiNxSEWcxYg5kS0Hi39UdSgLayse+/rw
	s9qf15OEuuCRH64DyJUbrP+CiS/IOkAl6zhnubeYJBQB3b6BG68qQtGx
X-Gm-Gg: AfdE7cm7m7jEUMLFEPsw2GWFt23KhLEq6WMlkryjvio4Ckfkb57muxT0pQAg63KuefK
	+jKD7cQLLsAA0ZNjx6dA4A2HZkI7syglpIO1sN3fKqmlMKfnUUA0RpOt9NCOAkHcxWRF8BF9Dw3
	KLBAhwblJGUz7LkFFQfoclBZa7aITduxUWNC912JCZ6ztQGtbYRziPQQXQSnO3CoCPqjlcW+1CX
	u3M1+eZE2i6AkjfnE/jf2bzF3BSoUietHFxXDklLwy1otY/b+UNM3/R8z5RHB5kycumQw5DbFv9
	hpiLsrmvZUb4SdMDfq1mpytT1tvHohycSpw/RrVw7HyrKMpEVAIxB+SGVEyQsUW4u4cRxGNsoQA
	izMDlKwXwt9AuqyaUCkc45o5UxGFkmg1tyYFEZt+H0LNi4V65DlPKIHYmq1uRhKdcTotHMU1cdw
	DKx+iv4NkIRoDGgsLvzpUuhus9fFbmzZtD4+te4e1AtIy/XlNC9zMHIRKggg+B
X-Received: by 2002:a05:6a21:682:b0:3bf:b50f:71bb with SMTP id adf61e73a8af0-3c0bc9acb33mr9806931637.27.1783622563297;
        Thu, 09 Jul 2026 11:42:43 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3118ee6080dsm19491362eec.17.2026.07.09.11.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 11:42:42 -0700 (PDT)
Date: Fri, 10 Jul 2026 00:12:23 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Michael Ellerman <mpe@ellerman.id.au>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
	loongarch@lists.linux.dev, Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, 
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
Subject: Re: [patch 06/18] riscv/syscall: Use
 syscall_enter_from_user_mode_randomize_stack()
Message-ID: <ak_rfwwd1OtaQxka@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260707181957.433213175@kernel.org>
 <20260707190253.974626922@kernel.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707190253.974626922@kernel.org>

On Tue, Jul 07, 2026 at 09:06:19PM +0200, Thomas Gleixner wrote:
> syscall_enter_from_user_mode_randomize_stack() replaces
> syscall_enter_from_user_mode() and the subsequent invocation of
> add_random_kstack_offset().
> 
> The advantage is that it applies the stack randomization right after
> enter_from_user_mode() and thereby avoids the overhead of get/put_cpu_var()
> as that code is invoked with interrupts disabled.
> 
> No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Paul Walmsley <pjw@kernel.org>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: linux-riscv@lists.infradead.org
> ---
>  arch/riscv/kernel/traps.c |    5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -7,7 +7,6 @@
>  #include <linux/kernel.h>
>  #include <linux/init.h>
>  #include <linux/irqflags.h>
> -#include <linux/randomize_kstack.h>
>  #include <linux/sched.h>
>  #include <linux/sched/debug.h>
>  #include <linux/sched/signal.h>
> @@ -333,9 +332,7 @@ void do_trap_ecall_u(struct pt_regs *reg
>  
>  		riscv_v_vstate_discard(regs);
>  
> -		syscall = syscall_enter_from_user_mode(regs, syscall);
> -
> -		add_random_kstack_offset();
> +		syscall = syscall_enter_from_user_mode_randomize_stack(regs, syscall);
>  
>  		if (syscall >= 0 && syscall < NR_syscalls) {
>  			syscall = array_index_nospec(syscall, NR_syscalls);
> 
Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>

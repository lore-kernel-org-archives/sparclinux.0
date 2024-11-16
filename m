Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481B9191473;
	Sat, 16 Nov 2024 08:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731747021; cv=none; b=TkM7vgS30MY21cOVaw9Qv6JN9FUxXx/WxXJUULa60AsPukry2ONUfrJZREohZi63beal1WXmN2ofEMOkkcq+cQ4EKzOB4sbPYOMGF/qXSA3ST+4/ShRgxtdyvd6EtcWkPbKg/xVehLndZT4+DNKYZTBzgXCJc2skl5HbouTmmrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731747021; c=relaxed/simple;
	bh=/AqZjsfLHbwWLhWnF2fxEidplvG+eTjqPL8M7lql9Wk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rIrRqYEAgpSUMV+GS9aDfCzm/ly4DhF+cuH4Hqq/DyVfJwMjg41l8O/XYHcShzSQVzGmbJ73UWL4fT8aj6kemrt6oX+CJn18xz+8D9b3J3+sTkFKfey3+MCCYZARaQc7ge5h+vwjMsoIfQj9agAyy4AVZ2TSiKs+3ELE8VGmWH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=Rqr/4dSD; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="Rqr/4dSD"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4Xr6zF4bYFz1DHVj;
	Sat, 16 Nov 2024 09:50:17 +0100 (CET)
Received: from [10.10.15.6] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4Xr6zF10RTz1DHnj;
	Sat, 16 Nov 2024 09:50:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1731747017;
	bh=Jw2FGYGLsXubsQKc2ACIJgB3hzH9w9bWmRLoh9D2NJU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Rqr/4dSD52oLIpbqwEtjWZxm4PzOSY9nN5U5M9ZexVQsADBtFJYdTneiH+dUxIMBo
	 ndfUrT7Vqdtd+FgeKHRFdKeWdMOeu50H/FSdVVue7pgmVRzAv5f/cjI2oKJPUqysaX
	 A75gH6dbKHKJRViWcfACIj30nVvZ6zEvumlC5xjA=
Message-ID: <1b2e776e-0ae3-4f48-a2b9-99b486d49368@gaisler.com>
Date: Sat, 16 Nov 2024 09:50:16 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sparc/vdso: Add helper function for 64-bit right shift
 on 32-bit target
To: koachan@protonmail.com, "David S. Miller" <davem@davemloft.net>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
References: <20240808-sparc-shr64-v2-1-fd18f1b2cea9@protonmail.com>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20240808-sparc-shr64-v2-1-fd18f1b2cea9@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-08-08 04:05, Koakuma via B4 Relay wrote:
> From: Koakuma <koachan@protonmail.com>
> 
> Add helper function for 64-bit right shift on 32-bit target so that
> clang does not emit a runtime library call.
> 
> Signed-off-by: Koakuma <koachan@protonmail.com>
> ---
> Hi~
> 
> This adds a small function to do 64-bit right shifts for use in vDSO
> code, needed so that clang does not emit a call to runtime library.
> ---
> Changes in v2:
> - Move __shr64 to sparc code since there are no other users of it.
> - Now that __shr64 is not in portable code, redo it in inline asm for simpler implementation & better performance.
> - Link to v1: https://lore.kernel.org/r/20240804-sparc-shr64-v1-1-25050968339a@protonmail.com
> ---
>  arch/sparc/vdso/vclock_gettime.c | 28 ++++++++++++++++++++++++----
>  1 file changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/sparc/vdso/vclock_gettime.c b/arch/sparc/vdso/vclock_gettime.c
> index e794edde6755..79607804ea1b 100644
> --- a/arch/sparc/vdso/vclock_gettime.c
> +++ b/arch/sparc/vdso/vclock_gettime.c
> @@ -86,6 +86,11 @@ notrace static long vdso_fallback_gettimeofday(struct __kernel_old_timeval *tv,
>  }
>  
>  #ifdef	CONFIG_SPARC64
> +notrace static __always_inline u64 __shr64(u64 val, int amt)
> +{
> +	return val >> amt;
> +}
> +
>  notrace static __always_inline u64 vread_tick(void)
>  {
>  	u64	ret;
> @@ -102,6 +107,21 @@ notrace static __always_inline u64 vread_tick_stick(void)
>  	return ret;
>  }
>  #else
> +notrace static __always_inline u64 __shr64(u64 val, int amt)
> +{
> +	u64 ret;
> +
> +	__asm__ __volatile__("sllx %H1, 32, %%g1\n\t"
> +			     "srl %L1, 0, %L1\n\t"
> +			     "or %%g1, %L1, %%g1\n\t"
> +			     "srlx %%g1, %2, %L0\n\t"
> +			     "srlx %L0, 32, %H0"
> +			     : "=r" (ret)
> +			     : "r" (val), "r" (amt)
> +			     : "g1");
> +	return ret;
> +}

Can not residual in bits 63:32 of %L0 potentially pose a problem?


> +
>  notrace static __always_inline u64 vread_tick(void)
>  {
>  	register unsigned long long ret asm("o4");
> @@ -154,7 +174,7 @@ notrace static __always_inline int do_realtime(struct vvar_data *vvar,
>  		ts->tv_sec = vvar->wall_time_sec;
>  		ns = vvar->wall_time_snsec;
>  		ns += vgetsns(vvar);
> -		ns >>= vvar->clock.shift;
> +		ns = __shr64(ns, vvar->clock.shift);
>  	} while (unlikely(vvar_read_retry(vvar, seq)));
>  
>  	ts->tv_sec += __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
> @@ -174,7 +194,7 @@ notrace static __always_inline int do_realtime_stick(struct vvar_data *vvar,
>  		ts->tv_sec = vvar->wall_time_sec;
>  		ns = vvar->wall_time_snsec;
>  		ns += vgetsns_stick(vvar);
> -		ns >>= vvar->clock.shift;
> +		ns = __shr64(ns, vvar->clock.shift);
>  	} while (unlikely(vvar_read_retry(vvar, seq)));
>  
>  	ts->tv_sec += __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
> @@ -194,7 +214,7 @@ notrace static __always_inline int do_monotonic(struct vvar_data *vvar,
>  		ts->tv_sec = vvar->monotonic_time_sec;
>  		ns = vvar->monotonic_time_snsec;
>  		ns += vgetsns(vvar);
> -		ns >>= vvar->clock.shift;
> +		ns = __shr64(ns, vvar->clock.shift);
>  	} while (unlikely(vvar_read_retry(vvar, seq)));
>  
>  	ts->tv_sec += __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
> @@ -214,7 +234,7 @@ notrace static __always_inline int do_monotonic_stick(struct vvar_data *vvar,
>  		ts->tv_sec = vvar->monotonic_time_sec;
>  		ns = vvar->monotonic_time_snsec;
>  		ns += vgetsns_stick(vvar);
> -		ns >>= vvar->clock.shift;
> +		ns = __shr64(ns, vvar->clock.shift);
>  	} while (unlikely(vvar_read_retry(vvar, seq)));
>  
>  	ts->tv_sec += __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
> 
> ---
> base-commit: defaf1a2113a22b00dfa1abc0fd2014820eaf065
> change-id: 20240717-sparc-shr64-2f00a7884770
> 
> Best regards,

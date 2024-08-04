Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5309376048;
	Sun,  4 Aug 2024 15:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722786287; cv=none; b=ELpBTbBgm8yiQY1DCxkPUCn/JPSs0r6EF8tXvG5oBKr+J9L1wLRyHKvU3x05sxypgYz2+edYwhBDy2pwK7SioaBKn5J0uzPgwW9x4H/l+2ug+GUvVUtO8ESR97QyFzHwKMG1FjLcUTlD4LJVbCeGhQ7HAn19Y3rYvmnFjflblQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722786287; c=relaxed/simple;
	bh=jjsqjyevgR8nj0LUR652BZZNzSUXeU2Wv2C8jMwCi60=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K98MZc1KOnqzKoSw5pv/gRndyaeV57MBlqfF0y6OraTTLFV7UHgrJ1UkyqdYHjFVnUNFpoYwiwSWGOsuQimZFpJkQmBLjVeXsAg5X6bpH3thpl5RAIgb1ThrCsm7WonCCwhBl1Q/6kYFzDBAWcu765sxfZZux+gceZOaTDQ2OoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=B28wd9a1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oLG2dYA5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B28wd9a1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oLG2dYA5"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722786284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9PRY1CFqlIzSqbDXhGPctanQ/REMZNZMr4UIxhNB5ks=;
	b=B28wd9a1QW3OTEzklFt8ziiH1LYm2OLqn2jqiYdjhD4ak2SeYvSmNrFr8x4+z3RNRmyegh
	Kf4LKxu3PnyDtpqXXRUv6r/pX/kME4S+65WlTQykEhqmQOW+MUgOpCc9aw8dDIDODSZPpc
	tzMuqMRkYnyputh09/0kIkdLNluNX8sWmQb2caeN7SnXzWFUr8eCl5JjdbdiV00afHUaBw
	mDZveLBpznd+cXnbAn5EICtRtk1ScPTZ00bo65skiAiTymFngmOWdkPIZ9afyHqB7ybmYi
	a3TDXfSmr8y9a0Z9FYnQW/MV10agu7PAF0L65VeXuAev8u3hEU7dNDIdfp9/3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722786284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9PRY1CFqlIzSqbDXhGPctanQ/REMZNZMr4UIxhNB5ks=;
	b=oLG2dYA5uEGWMcl5AmvAFhkkXEGzIt7iFGIe2DMtsTbQRjA2MOpqqVkL7X0cbL4C6u+C0g
	GlsnAFnjZHNLfMBA==
To: Koakuma via B4 Relay <devnull+koachan.protonmail.com@kernel.org>, "David
 S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>,
 Andy Lutomirski <luto@kernel.org>, Vincenzo Frascino
 <vincenzo.frascino@arm.com>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, Koakuma <koachan@protonmail.com>
Subject: Re: [PATCH] sparc/vdso: Add helper function for 64-bit right shift
 on 32-bit target
In-Reply-To: <20240804-sparc-shr64-v1-1-25050968339a@protonmail.com>
References: <20240804-sparc-shr64-v1-1-25050968339a@protonmail.com>
Date: Sun, 04 Aug 2024 17:44:44 +0200
Message-ID: <871q3470nn.ffs@tglx>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Aug 04 2024 at 10:39, Koakuma via wrote:
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
>  arch/sparc/vdso/vclock_gettime.c |  8 ++++----
>  include/vdso/math64.h            | 28 ++++++++++++++++++++++++++++

> --- a/include/vdso/math64.h
> +++ b/include/vdso/math64.h
> @@ -21,6 +21,34 @@ __iter_div_u64_rem(u64 dividend, u32 divisor, u64 *remainder)
>  	return ret;
>  }
>  
> +#if BITS_PER_LONG == 32
> +/* This is to prevent the compiler from emitting a call to __lshrdi3. */
> +static __always_inline u64
> +__shr64(u64 val, int amt)
> +{
> +	u32 mask = (1U << amt) - 1;
> +	u32 lo = val;
> +	u32 hi = val >> 32;
> +	u32 mi;
> +
> +	if (amt >= 32)
> +		return hi >> (amt - 32);
> +
> +
> +	mi = (hi & mask) << (32 - amt);
> +	hi >>= amt;
> +	lo = (lo >> amt) | mi;
> +
> +	return ((u64) hi) << 32 | lo;
> +}
> +#else
> +static __always_inline u64
> +__shr64(u64 val, int amt)
> +{
> +	return val >> amt;
> +}

Why does this sparc'ism need to be in generic code?

Thanks,

        tglx

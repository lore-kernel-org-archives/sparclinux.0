Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143142066DE;
	Tue,  8 Jul 2025 05:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751953153; cv=none; b=F0MSelbnlF5tamyxVvNbkPJmgREZLJN88F1xoB+kD2KpQD05MMNlK5AGlFc0Z3QcVOEIDR4Xf3Hih1b8y8t/aPIvqoSjiPcLZBYb6IDGSGvLXW3NQcTccE814ieTWzCjc0XHfec09fuOnbdy1su9gN3w1sRgNqBnQ1oRIN+jYDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751953153; c=relaxed/simple;
	bh=NZWQkkh1LvOo5VYGeid5YFRirCci5Yi0s4zWLiGD4fQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W3LC1OAL2d2U6jC2VwuqBKBoxFnkWfCHOw1FkMa+kmXNVhpdstxtg7JgJ2ipT0G27xXG8OjbrzCW4Qefc0uZDRFYP5vJC2Xm3EmnOdKuZFt20trHfbbIs7UZJMZ0biOBROAcj+wwrON9Q/NJDv36s8+/lDn7Wn6kAMcxTGkhxNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lFsNl0pL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cYEyFzQQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lFsNl0pL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cYEyFzQQ"
Date: Tue, 8 Jul 2025 07:39:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751953150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fl7wLQ4GgSJMdfBRZNRETA8GIOa3a2MkSqRioQI6uyY=;
	b=lFsNl0pLD87rF6sP4vRyFTlOdDRF7Zhq5fUgz8j1c2Zx+iAu8WNx0ff9rUxVT0dprgwBvl
	oedm2j/u1uFxW9zhrNey/ClyzB/l3znH/jhNhIIsKrnn7155Pm7gJ2SLKTTvAA7dlA+Aes
	dIsO8EVUjobZX3zk11DqiyYWMvSiZzVxiMNk7OyHy8Y+WeCeR/XP+lHpWy/ykl6I3Fyho/
	4VHlChdf7w6m6Kunvrlv07Ozsu2B1ojChYSprLk8yVzdkCn9TNxCZz6Np1xE908kLGQJBC
	26Bj/N0Q5C8Fm9EyY8BrMFPDnTNTJPFV8QoZlkAdOsSmC9BFy33gB/uOmPyaXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751953150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fl7wLQ4GgSJMdfBRZNRETA8GIOa3a2MkSqRioQI6uyY=;
	b=cYEyFzQQUeauKKTZWun0p2DqgHO9DGlgfVcGInG0RjtS5nBTYqNlNIlJ5cZ+bMBJcMWq+i
	RQnyJ2NKSwwwiwAg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	Andy Lutomirski <luto@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	shuah <shuah@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Frederic Weisbecker <frederic@kernel.org>, John Stultz <jstultz@google.com>, 
	Stephen Boyd <sboyd@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Eric Biggers <ebiggers@google.com>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] vdso: sparc: stub out custom vdso implementation
Message-ID: <20250708073204-b67226e4-b140-4a1a-ae98-47769c1b2f98@linutronix.de>
References: <20250707144726.4008707-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250707144726.4008707-1-arnd@kernel.org>

On Mon, Jul 07, 2025 at 04:46:37PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> sparc64 is the only remaining architecture that has its own implementation
> of the vdso clock_gettime/gettimeofday helpers in place of the generic
> code. This causes a number of issues:
> 
>  - Changes to the vdso interfaces require adding sparc64 specific hacks
>    even when nothing else needs them
> 
>  - The prototypes in <vdso/gettime.h> don't match the function implementation,
>    and not including that header to avoid the build error from that causes
>    another warning:
> 
>   arch/sparc/vdso/vclock_gettime.c:274:1: error: no previous prototype for '__vdso_clock_gettime' [-Werror=missing-prototypes]
>     274 | __vdso_clock_gettime(clockid_t clock, struct __kernel_old_timespec *ts)
>         | ^~~~~~~~~~~~~~~~~~~~
> 
>  - Nobody has ever implemented the clock_gettime64() vdso that is required for
>    32-bit compat tasks
> 
>  - The warning about the missing executable-stack flag was missed:
> 
>   sparc-linux-ld: warning: arch/sparc/vdso/vdso-note.o: missing .note.GNU-stack section implies executable stack
>   sparc-linux-ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker

IMO this should be in its own patch.

> Most of the removed code only exists on sparc in order to dynamically
> patch the vdso based on the presence of the tick vs vtick based
> clocksource.
> 
> Rip out the whole thing and replace it with a minimal stub as we do
> on parisc and uml. This introduces a small performance regression when
> using a libc that is aware of the vdso (glibc-2.29 or higher).
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks, this makes things easier.

Reviewed-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
Tested-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>

But why do we even need the stubs? Removing the time functions from the
vDSO completely should also work, no?
For parisc there was no reasoning why stubs were used. On uml the stubs are
necessary to prevent the libc from calling into the host vsyscall [0], but
that looks irrelevant for SPARC.

[0] f1c2bb8b9964 ("um: implement a x86_64 vDSO")

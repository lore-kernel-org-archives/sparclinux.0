Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961A32F43;
	Wed, 23 Jul 2025 10:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753268238; cv=none; b=CN78vnod6zJAjr6X4xrhGLGrCuwQU5ZS+JP8ufshKC+NdC42V3RY9WXYSo+6dRGE4mBmfrnWf+53qFbsPcnLyq931gKRwqKHAVDmizH8oLr7piw3KtsRgtg5Lk3g1AMj5+PgGF/wMmimdvo5S+Go5K5GyIyRX0ahjTSqP/pfmBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753268238; c=relaxed/simple;
	bh=Kqw1qjxBJdNpp7oAYMS1mtF4qJIL11nZA8tuU98BbyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ebjzMF3wNpZnmOmdmeFYD3NIL+IkKfMw/d3uY57x6Z91d5DKlOq7Xm04t1SH+iJW71fWosL56ct4QNRlwc4NOAgjtS4IL1tkBHuwz9IS5LDOnC2wX6IwEbFhwzbtVh/BzpR/FgEt13JZe8Xt18a4hl7WvyP/9fakKUYeXhghFxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2zwwClEo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mKPoT27N; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2zwwClEo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mKPoT27N"
Date: Wed, 23 Jul 2025 12:57:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753268233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mtq58+V1BXgKxSSsGnA+n2SgFL7o76UXfNA2oUaNiVY=;
	b=2zwwClEoDAgu6t2PFWkYEkfqxAcrZyMS0h6usgWv1X+IQFSOTejQQhqRx4NI2Fs9yqcErN
	CYkVHdKGh/HX4UQZn20SrmxwTG8+lV5FW/0qyHhsgx0XXqklSG976kgzJlBDlX72bFOiU9
	dBTjJYBIcrgWnM+wZVmeJ1pbNNYq2pi9vHLg4OnyCsBKf65ymwon32+kAwg3Egz6Xgj9f9
	mtD3QnVfQE3K74ghFERtClAItpdZ7j7btKvuYxtb1tZ3/cV4US3/A76RCp0KCzVhhjvxZn
	vf1+gCeC7BTQDXse+wxSGnvTmdR/Uq10sKS1mK7yrKbazj3SrDd8YgtuRtANFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753268233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mtq58+V1BXgKxSSsGnA+n2SgFL7o76UXfNA2oUaNiVY=;
	b=mKPoT27NEKy1CyD2MwMTOxPcWeyir0pLs11o02bZpBEKntsuggfBeNMI3FJdcs3P8yftRq
	GefrrQD6jRVdkbCg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Andreas Larsson <andreas@gaisler.com>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Thomas Gleixner <tglx@linutronix.de>, 
	"David S. Miller" <davem@davemloft.net>, Andy Lutomirski <luto@kernel.org>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, shuah <shuah@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Eric Biggers <ebiggers@google.com>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] vdso: sparc: stub out custom vdso implementation
Message-ID: <20250723125455-92ce2791-cb22-4389-a3cf-a9407a14ece8@linutronix.de>
References: <20250707144726.4008707-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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
> 
> Most of the removed code only exists on sparc in order to dynamically
> patch the vdso based on the presence of the tick vs vtick based
> clocksource.
> 
> Rip out the whole thing and replace it with a minimal stub as we do
> on parisc and uml. This introduces a small performance regression when
> using a libc that is aware of the vdso (glibc-2.29 or higher).
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

FYI I have a series prepared that will move SPARC to the generic vDSO and also
addresses the problems listed above and mentioned by tglx.

I'll send it after the merge window.

(...)


Thomas

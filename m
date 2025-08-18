Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429E412DDA1;
	Mon, 18 Aug 2025 13:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755522033; cv=none; b=aWctfwfZkoXWSl2RC4GXoQhtP3v9cXZfRg4UK+S9t2/vgYZlLLWfwXHjiVtM/zVE6omvfd42VLbWwusVBD5mc6+doEBFjD5KT2J8K7pUNnvxvZW0L81Sf+YhMWHq+opmD9XyzUezzsJMFAd95kkG0GlRL3ROV40fetdInY+sH98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755522033; c=relaxed/simple;
	bh=rwIcZvamGi0R3xjBsyaRP7wptDP5Fy8bAr7esWQjoC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lr3/rGHXfzH/UBj2DoOVWpzvBY6PdM40FIZwmEuVuIeMQe4vCtTlR8z0DpJXwT7Kk+Oe3cwTRqWMfTfESsfbeQTHFnRPzif3eKRnfCM0Q9wZJJ/eaxLigBfnQ/5rhxrYsYyB5Ap2N6UW5NZxjnekzjfoL+4XxrQMua8zKSeMRJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aM0zkgb7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Eo3dzI0L; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aM0zkgb7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Eo3dzI0L"
Date: Mon, 18 Aug 2025 15:00:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755522030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o/oNdMrHXcdGOe6ffadQvm016mzALXzhUKBuz6wHW6Q=;
	b=aM0zkgb7pKHh+rBqF0njpRbY3jXpY9RunftkNxM6mASganKQphWshiIB6VJ4j8K1PbymMm
	avIuL7EDecE6rLcqvB20GZhX3EdwkWNsiytpc530rHZM6vaeoP8yqvMZlKy2kr87Zb/e/n
	adeTEU5JXo+fvQMFqKC5w2+nJJRpzQbWVwKCbj4Ofpn/bt5K8G2mZrirDXaxzlOjue1j6J
	jd17imW7Evw4oYpPdYNYmK8BQEH0GWfrvS+2Z3/X+2DKLJS+bDWkOb+n9MdK1h0IS8D1CX
	Ma+r1Wsr8GV5xMfvsqWwHUtXhEgNDqxF/Iz3dkMdPTKNXivz5J7/5APBr2mw0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755522030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o/oNdMrHXcdGOe6ffadQvm016mzALXzhUKBuz6wHW6Q=;
	b=Eo3dzI0L9GO7rUONVLcXssJ8pzAKLorBWlF1HOC+yT5rqJqMHOPaj7Vu7tmPaSqvzVCqE/
	qtFA4i2PngcNuoCg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	"David S . Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>, Nick Alcock <nick.alcock@oracle.com>, 
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v2 12/13] sparc64: vdso: Implement clock_getres()
Message-ID: <20250818141851-c185a57d-3081-479c-a32a-add4e5600f3e@linutronix.de>
References: <20250815-vdso-sparc64-generic-2-v2-0-b5ff80672347@linutronix.de>
 <20250815-vdso-sparc64-generic-2-v2-12-b5ff80672347@linutronix.de>
 <bf9ec82b-af1b-4684-ada5-8529b7ceb06a@app.fastmail.com>
 <20250815142418-d28c6551-bec1-4a65-9c52-f1afd7b630ed@linutronix.de>
 <5309ef99-9ae7-4525-8d58-f954c13797bc@app.fastmail.com>
 <20250818073135-130dfc53-225c-48a3-b960-e982faa866bf@linutronix.de>
 <dd77ac1f-9251-4ad2-ad5b-9d2b8969a476@app.fastmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dd77ac1f-9251-4ad2-ad5b-9d2b8969a476@app.fastmail.com>

On Mon, Aug 18, 2025 at 08:54:53AM +0200, Arnd Bergmann wrote:
> On Mon, Aug 18, 2025, at 07:50, Thomas Weißschuh wrote:
> > On Fri, Aug 15, 2025 at 10:09:23PM +0200, Arnd Bergmann wrote:
> >> On Fri, Aug 15, 2025, at 14:34, Thomas Weißschuh wrote:
> >> > On Fri, Aug 15, 2025 at 02:13:46PM +0200, Arnd Bergmann wrote:
> >> >> On Fri, Aug 15, 2025, at 12:41, Thomas Weißschuh wrote:

(...)

> >> For time64 userspace, this means that glibc always calls
> >> the system call instead of the vdso, and old time32
> >> userspace wouldn't use the clock_getres() vdso because
> >> there was no vdso implementation when it was compiled.
> >
> > Is this paragraph meant to be specific for SPARC? Glibc does use the
> > clock_getres() vdso fastpath on time64 architectures. But on SPARC no
> > application would ever use clock_getres() through the vdso today,
> > as it doesn't exist yet.
> 
> The glibc code has a weird mixup of the time32 and time64
> function names, but from what I can tell, it only ever sets
> dl_vdso_clock_getres_time64 on 64-bit architectures, where it
> gets set to the normal clock_getres vdso symbol. On 32-bit,
> glibc always skips vdso_clock_getres_time64() since it
> does not exist, and then it always calls clock_getres_time64()
> through the syscall interface, unless it runs on pre-5.6
> kernels that fall back to the time32 vdso or syscall.

Ack.

So with 'time64 userspace', you mean '32-bit, time64 userspace', correct?
This was my misunderstanding.

> From the kernel's perspective there is no such thing as a
> 'time64 architecture', all 32-bit architectures (except x32)
> implement the time64 syscalls, most 32-bit architectures also
> have the old syscalls, and all 64-bit architectures (plus x32)
> only have the old syscalls.
> 
> glibc introduced a different view of the same thing, the
> internal names on some 32-bit architectures (rv32, arc) get
> redirected so they look more like x32. However, those
> architectures don't use vdso.

Ack.

> > In any case, I have no strong opinions about this patch and am happy to drop it or support only SPARC64. Most likely nobody will bother to update glibc anyways.
> 
> Agreed, I think the only real concern is maintainability here, so
> if you think it helps to have __vdso_clock_getres(), please keep
> that for sparc64, but let's leave it out for 32-bit altogether.

Let's drop it altogether; the code is out there if anybody ever cares.

> Two related points:
> 
> - something we could add on all 32-bit architectures after
>   everything uses the generic vdso implementation is
>   vdso_gettimeofday_time64(), this can shave off a few cycles
>   because it avoids a division that may be expensive on some
>   architectures, making it marginally more useful than
>   vdso_clock_getres_time64().

You mean this division in __cvdso_gettimeofday_data()?

	tv->tv_usec = (u32)ts.tv_nsec / NSEC_PER_USEC;

Switching the subseconds field to nanoseconds to avoid the division and the
seconds field to 64bit to avoid overflows brings us back to
'struct __kernel_timespec' again, no? What would be the advantage of this over
vdso_clock_gettime(CLOCK_REALTIME, &ts)?

> - there is one catch on sparc64 in the way it defines
>   __kernel_old_timeval with a 32-bit __kernel_suseconds_t,
>   unlike all other 64-bit architectures. This is incompatible
>   with glibc's __timeval64 definition on sparc32, so there
>   would need to be a special case for sparc32 somewhere,
>   either in the kernel or in glibc.

This is only a problem together with vdso_gettimeofday() from above, right?


Thomas

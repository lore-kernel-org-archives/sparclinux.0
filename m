Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFE22222AB;
	Tue,  8 Jul 2025 07:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751958816; cv=none; b=nKvPXPOKplyJdMcF8IXxp+ntknpmPVNyr7bdT+hRooo0jowiGVx9vn8EQ4e8VE2zVqfo6OceIIwg0eAPP+92wIzNB03vGyzfcfCoNsQDPOlvG6PNHgdDevzRYj62n+9cjKqnHimQlwg0e1HUlfgfpSUAg5jKgq+0+z5iW4mlTEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751958816; c=relaxed/simple;
	bh=NFG7tc8UTm9bOEQ3JtgVmTw8KnluhgyUo5dQrIKFNgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tHs1F0T8v82pSeO7qnLfQZ1Z4XBr1/Vd+hlTZ3Sm61qbrCkfQd/RoUkeUJ5JdIQIgSFdfdAHcoG6maSDdiv1iDVqGVzriqJ83uEDgQvXQ9OFkMSBWz7YN2i0fULIeu9uRLiyF/mlvZ33ddIx1ajEyhEOSmuZbxTftMEhsqc8uwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vnVaxxj9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yM00VvVq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vnVaxxj9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yM00VvVq"
Date: Tue, 8 Jul 2025 09:13:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751958811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ympaAWm94nimBbLSB44cFlzL0ReHl4pqgXPNgXg0fJE=;
	b=vnVaxxj9vBakEJd2VUPbt070U636JKrtQ48/ngadwJhLuaCZHleGPmVE/QmBIBhnbiqj1z
	jub0dmIdKwpuPC2z11BoZlKZrLFEQzjTyqJmtU5mIHSchmy658mh+pjnukN+uIL9uuIe1S
	sZKxmbmfO/03wXK6JWey5NWUd67S6SNYpqk6F6WIYu/3VQMvciJKdYdABnt1lEFMoTPmZM
	qxjSOkUopE0yLPN2f/ibYvA4u0m83KcE6doLkJRzBhPsvy+9jj5m9vevHC4yhK0Xhmqozd
	Yo6B7WvC0b090vgDf3Q5o3brAoYOvtiDZl0bmOBU5HH5ghmkj54bkRiEjOAomA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751958811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ympaAWm94nimBbLSB44cFlzL0ReHl4pqgXPNgXg0fJE=;
	b=yM00VvVqopMj29HkLSAW2Nw4uUtpOkDyM4cme3wQhV+FjWQa1r0jz+APTnzidApFbiv/bZ
	8KsEp6vRsBnK+xCg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	"David S . Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	Andy Lutomirski <luto@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	shuah <shuah@kernel.org>, Anna-Maria Gleixner <anna-maria@linutronix.de>, 
	Frederic Weisbecker <frederic@kernel.org>, John Stultz <jstultz@google.com>, 
	Stephen Boyd <sboyd@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Eric Biggers <ebiggers@google.com>, sparclinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Helge Deller <deller@gmx.de>
Subject: Re: [PATCH 1/2] vdso: sparc: stub out custom vdso implementation
Message-ID: <20250708085740-dc559080-2551-427c-9134-41fa7f9898d1@linutronix.de>
References: <20250707144726.4008707-1-arnd@kernel.org>
 <20250708073204-b67226e4-b140-4a1a-ae98-47769c1b2f98@linutronix.de>
 <59e6bb77-1f11-4e30-9bbd-51bf077d9840@app.fastmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <59e6bb77-1f11-4e30-9bbd-51bf077d9840@app.fastmail.com>

On Tue, Jul 08, 2025 at 08:40:27AM +0200, Arnd Bergmann wrote:
> On Tue, Jul 8, 2025, at 07:39, Thomas Weißschuh wrote:

(...)

> > But why do we even need the stubs? Removing the time functions from the
> > vDSO completely should also work, no?
> > For parisc there was no reasoning why stubs were used. On uml the stubs are
> > necessary to prevent the libc from calling into the host vsyscall [0], but
> > that looks irrelevant for SPARC.
> >
> > [0] f1c2bb8b9964 ("um: implement a x86_64 vDSO")
> 
> I was wondering about this myself, I thought this might have been
> for runtime environments that just assume the vDSO is there, possibly
> some non-C libraries, or future glibc versions that may error
> out when the vdso is absent instead of falling back to the syscall.

libc erroring out if the vdso is missing sounds unlikely to me.

(...)

> The arch/x86/um/vdso/um_vdso.c version for 32-bit seems to still
> be missing the clock_gettime64() entry, any idea what the
> resulting behavior is for time64 userspace?

The vsyscall page is for 64-bit userspace only, and I think always ways.

In any case, modern distro kernels don't provide the vsyscall page at all or
emulate it through syscall stubs, which are affected by the uml host access issue.
Also glibc dropped vsyscall page support in 2020.


Thomas

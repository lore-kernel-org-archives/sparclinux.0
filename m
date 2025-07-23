Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F9B1F3FF8;
	Wed, 23 Jul 2025 17:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753291452; cv=none; b=NIZ3PsXJwiLVt9nHiG1Vwz4BYltmcgAhgShRiC+BNI7rgdqfiqtRttX70qZjKGOZWg7Iow8S/QDxVEiW63j3HSyo/c6s8bx55QPsaFpJk3lHdZPMwlZAou3JRs3M6TI1j7tOEdFOiebZAYTCrU5dAgmJ77iMu+m79HyY9qsy28Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753291452; c=relaxed/simple;
	bh=l1eRbN/GfJZ42Z6vgZneSwXNjXjpfJxX1MyJe8fmBpk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MdnjKXqd/o/wUOxi6CYmhFGYLSOyISiWvhU/JYxfEigdHkvBnM6SjoQwx/vefLZOk2mTYa6Zk5uwkcfRaqNMfx5QG9/HbNmsINfd8g1Ks7yKi6sYA0kNWLRcVvhcp19geXhtXXL3ZdMr0Bv4VPk/trDTw1VBaWG231WG8F5NHpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v4FmxTGm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LGCxVdBH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v4FmxTGm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LGCxVdBH"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753291448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l1eRbN/GfJZ42Z6vgZneSwXNjXjpfJxX1MyJe8fmBpk=;
	b=v4FmxTGm22Z0Y2niPhorI9KHMu8WWlDph9XAI7sPa1QR+60TzBidQgy39hCYWF0Ze8Oy2D
	EntzXGKu7uO6UnTEX0dh3m+d8fNAFzPjYMezJd0dK7MHCT5mW0yrSj2WAuPOU/LX67JPFb
	/MOmcYO2IYqUHEKY0KiAC2ULsG/opBjhvZ0+OrmG3zX1s098IguMDozLnFrYFAzu8zQ1He
	Q5wHxgOvE9sRO4OPjghYrRi6ydocc446aitbgpWchy9MaJTMRduyhFO127qrkbLwQqSTTP
	KsvE8Vv0acgge2fRv01fgxihAkd4mSJG1kdIRsb6awYlvA76CBPptHIqRQLmQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753291448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l1eRbN/GfJZ42Z6vgZneSwXNjXjpfJxX1MyJe8fmBpk=;
	b=LGCxVdBHjVo275MBe15j6WdbLkYYp8KSwMiKHiDn8MIggAnBJk+MgHDOIf7QRr2R5BNqJ6
	I11xqlGt2WI8Y4BA==
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Arnd Bergmann
 <arnd@kernel.org>
Cc: Andreas Larsson <andreas@gaisler.com>, John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>, "David S. Miller" <davem@davemloft.net>,
 Andy Lutomirski <luto@kernel.org>, Vincenzo Frascino
 <vincenzo.frascino@arm.com>, shuah <shuah@kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>,
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, Catalin
 Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Arnd
 Bergmann <arnd@arndb.de>, Eric Biggers <ebiggers@google.com>,
 sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] vdso: sparc: stub out custom vdso implementation
In-Reply-To: <20250723125455-92ce2791-cb22-4389-a3cf-a9407a14ece8@linutronix.de>
References: <20250707144726.4008707-1-arnd@kernel.org>
 <20250723125455-92ce2791-cb22-4389-a3cf-a9407a14ece8@linutronix.de>
Date: Wed, 23 Jul 2025 19:24:08 +0200
Message-ID: <877bzystvr.ffs@tglx>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23 2025 at 12:57, Thomas Wei=C3=9Fschuh wrote:
> FYI I have a series prepared that will move SPARC to the generic vDSO and=
 also
> addresses the problems listed above and mentioned by tglx.
>
> I'll send it after the merge window.

Just post it as an RFC, so people can test it.

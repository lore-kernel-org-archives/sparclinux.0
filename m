Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E730A1514E4;
	Tue, 26 Aug 2025 05:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756187813; cv=none; b=ei5KyxSUyuEV1sDABgc40/NRrXUduMPac9jvhshcPc0hnbTdonONf6ALSNz97W42t+xR7e7fSBMw1B1oycENnUTfqWbs6zMnWLhdktqrjcUaVJvAJwnOreoTOlBqdPRCnnqguw1ZuU70fLzE5qgoevC25/LI9rOCclQNk6m5VMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756187813; c=relaxed/simple;
	bh=j02ZoAtSA1uZjXue5PrQ9okoLepVqZdZQod0qqHwbUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A7d58lrSkbbKXcFZDZUuzak+OgY57OAAI8agTH+CLelPKfyPLm+wYehPuzPx2YvgcgbJGHvW78n3kg/sIO8JwLOcfq0KOherWlpHTiVe7Nhw+ns4MC5P0tYUu6+6MhQaM5F6CUlTYDSWto7p9P8q4+wwgZ56RvXleMA2FUH8pQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1VzaLkWX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ed/NODVk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1VzaLkWX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ed/NODVk"
Date: Tue, 26 Aug 2025 07:56:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756187810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mtvWv6/yFUPFvOI9eBuJsRFgng8gzu79ka920jl7CaY=;
	b=1VzaLkWXBPYfHLmrGgLg2VoUnIWHl9akZLhe6YsexT+6mldca4MuBhr3SiAbhMKwgsPLfH
	tXBYWSEaEo28t8QYAlVxBPGpbD4M55kLbr1O06TsF7HLzYOwqd1j8vd+Tj6d4A4xxCFBFW
	n1MKj9BUT1v4QipOC/vI7byviCg688czN8fxxMyEi9AYvYs5VKKISCYXFvlKdEJ79TURaV
	LroraU7bcek0RYcZ1MHP+9czxjQ6OZrDN9DOuLEGqOW+MQpyZQ/vNtOQ4wB8jo7TRLsEt2
	bIP6SkJ0Ad3e3iCimJLrN08xrtaxRHeFapaezwAgUI8glWE/rskbyOipBvAIzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756187810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mtvWv6/yFUPFvOI9eBuJsRFgng8gzu79ka920jl7CaY=;
	b=ed/NODVk9y47VwSPpXwpF0bl0tTRBDinZ1dIn8j8xZYG0CKKkdVwwk0i/fzHZdkht/HkKe
	FeeBMH1AdbKmsRBg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Andreas Larsson <andreas@gaisler.com>
Cc: Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, 
	Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>, Nick Alcock <nick.alcock@oracle.com>, 
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v2 08/13] sparc64: vdso: Switch to the generic vDSO
 library
Message-ID: <20250826074526-a1463084-366a-44d1-874b-b898f4747451@linutronix.de>
References: <20250815-vdso-sparc64-generic-2-v2-0-b5ff80672347@linutronix.de>
 <20250815-vdso-sparc64-generic-2-v2-8-b5ff80672347@linutronix.de>
 <0b223e3d-25af-4897-b513-699dfeedfa04@gaisler.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0b223e3d-25af-4897-b513-699dfeedfa04@gaisler.com>

Hi Andreas,

thaks for testing!

On Mon, Aug 25, 2025 at 05:55:20PM +0200, Andreas Larsson wrote:
> On 2025-08-15 12:41, Thomas Weiﬂschuh wrote:
> > The generic vDSO provides a lot common functionality shared between
> > different architectures. SPARC is the last architecture not using it,
> > preventing some necessary code cleanup.
> > 
> > Make use of the generic infrastructure.
> > 
> > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > ---
> >  arch/sparc/Kconfig                         |   4 +-
> >  arch/sparc/include/asm/clocksource.h       |   9 --
> >  arch/sparc/include/asm/vdso/clocksource.h  |  10 ++
> >  arch/sparc/include/asm/vdso/gettimeofday.h |  58 ++++++++--
> >  arch/sparc/include/asm/vdso/vsyscall.h     |  10 ++
> >  arch/sparc/include/asm/vvar.h              |  75 -------------
> >  arch/sparc/kernel/Makefile                 |   1 -
> >  arch/sparc/kernel/time_64.c                |   6 +-
> >  arch/sparc/kernel/vdso.c                   |  69 ------------
> >  arch/sparc/vdso/Makefile                   |   6 +-
> >  arch/sparc/vdso/vclock_gettime.c           | 169 ++++-------------------------
> >  arch/sparc/vdso/vdso-layout.lds.S          |   7 +-
> >  arch/sparc/vdso/vma.c                      |  70 +++---------
> >  13 files changed, 119 insertions(+), 375 deletions(-)
> 
> With the first seven patches (applied on v6.17-rc1) I don't run into any
> problems, but from this patch (and onwards) things do not work properly.
> With patches 1-8 applied, Debian running on a sun4v (in a Solaris LDOM)
> stops being able to mount the root filesystem with the patches applied
> up to and including this patch.

Could you give me the kernel log of the failures? Is there any chance to get
access to the machine? Can you reproduce this issue on sun4u? sun4v in QEMU is
"work in progress" and instantly crashes for me. Can you provide me your Debian
image?

> As an aside, with all patches applied, it panics when the kernel
> attempts to kill init.

It is suprising that the error changes between patches.
The later patches don't change any lowlevel stuff, so if rootfs mounting
was broken earlier I don't see how it could go on to start init later.
Are these results repeatable?


Thomas

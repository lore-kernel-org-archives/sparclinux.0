Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C6A1401C;
	Fri,  8 Nov 2024 14:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731075915; cv=none; b=E9lHgV/eEvNY9kAllBjnXWq1G0KH5DfJ7mRsIvzGxAJRKFTNcsgiXftQPQiQcr3nvNUbfZurRFpNPhUDXbuuvRD1blE1NSQ+u0Ex7vb8m7TP8BGQ+nncglIYP4v+BGr00WZJQDgOqNSQ7xBNTHfQZnnpr6eObytgRj+DrWBszuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731075915; c=relaxed/simple;
	bh=xPGTJfqchSlQ6jueLrU84/Ezt2oTBGmaVYC2TJWstuU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=glGEgzNaXoU+W9PQDQuOEYeZwihgeYEbbFpug5swGOqhVs1HngNuKd1nnuvvgzFipqEct6drXl6SEeaIE5dMs4NChcw6q/Lp1bJJ5FQeehAwM49zRYxfUL/b/cshs4kfmvvHrqQ4ybomqwPEzeXoIOPE+hbke9+JhfdhxXrJGsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TAmLIgJp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jj/8EwA6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TAmLIgJp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jj/8EwA6"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731075911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v+f+g8yyOKXMQlbG8MpvRrvh4tIxLok0rEAYYuf18pU=;
	b=TAmLIgJpFi3WYWagfHvvZLAAirgZXLul++2EA0xNzLlguNFCXkuNJTpfHNo69/tyI8iOQg
	u4vLFaU7ceFS/iJcWPNqKOQUlm2pysPD3aoU/TClqt+39Nz5Y0kWGOGhLQeX2ZKEaluvX7
	JrFFbixe2hezzdMtdwmRw+Mm/Mg0eoiw8AdWn8T0VHbVO2fBuftlG4I5TkyBjYHjxurTBW
	WPvm4i8miTfv9X6bPrBoFZRtSiKtjorssIDWzxQ/wC7gTIqCeMwplVMFDMlGu3C6JC0MYz
	3ECnyr7+hH5tijyg0p6vRJtVJ1V7xWwN+rOmq60anQwvSzqzIVmDRCYZPzF3KQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731075911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v+f+g8yyOKXMQlbG8MpvRrvh4tIxLok0rEAYYuf18pU=;
	b=jj/8EwA6cJ5MUQOonh7MRj4YYMI1ZD0f2sju/5TUx8FC8GyPnd68uaGGplLfknboD/bc7G
	2i/uKKIRBVnxttBA==
To: David Wang <00107082@163.com>, richard.henderson@linaro.org,
 linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
 guoren@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name,
 James.Bottomley@HansenPartnership.com, deller@gmx.de, mpe@ellerman.id.au,
 paul.walmsley@sifive.com, ysato@users.sourceforge.jp, dalias@libc.org,
 glaubitz@physik.fu-berlin.de, davem@davemloft.net, andreas@gaisler.com,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, chris@zankel.net, jcmvbkbc@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
 loongarch@lists.linux.dev, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, David Wang
 <00107082@163.com>
Subject: Re: [PATCH] kernel/irq/proc: performance: replace seq_printf with
 seq_put_decimal_ull_width
In-Reply-To: <20241103080552.4787-1-00107082@163.com>
References: <20241103080552.4787-1-00107082@163.com>
Date: Fri, 08 Nov 2024 15:25:13 +0100
Message-ID: <87r07lol9y.ffs@tglx>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

David!

On Sun, Nov 03 2024 at 16:05, David Wang wrote:

$Subject: [PATCH] kernel/irq/proc: performance: ...

That's not a valid subsystem prefix.

> seq_printf is costy, when stress reading /proc/interrupts, profiling indicates
> seq_printf takes about ~47% of show_interrupts samples:

Also please follow the documentation for denoting functions in change
logs:

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#function-references-in-changelogs

>  arch/alpha/kernel/irq.c     |   8 +--
>  arch/arm/kernel/smp.c       |   4 +-
>  arch/arm64/kernel/smp.c     |   3 +-
>  arch/csky/kernel/smp.c      |   4 +-
>  arch/loongarch/kernel/smp.c |   2 +-
>  arch/parisc/kernel/irq.c    |  34 ++++++------
>  arch/powerpc/kernel/irq.c   |  44 ++++++++--------
>  arch/riscv/kernel/smp.c     |   3 +-
>  arch/sh/kernel/irq.c        |   4 +-
>  arch/sparc/kernel/irq_32.c  |  12 ++---
>  arch/sparc/kernel/irq_64.c  |   4 +-
>  arch/x86/kernel/irq.c       | 100 ++++++++++++++++++------------------
>  arch/xtensa/kernel/irq.c    |   2 +-
>  arch/xtensa/kernel/smp.c    |   4 +-
>  kernel/irq/proc.c           |   6 ++-

There is no dependency on these changes. So please split them up into
seperate patches for core and the individual architectures.

Thanks,

        tglx

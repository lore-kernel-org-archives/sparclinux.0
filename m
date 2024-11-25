Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194CA1B4F2B;
	Mon, 25 Nov 2024 17:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732556623; cv=none; b=uDtk7Y/QZljh4g0EHsXpHS1ilER658CoX8MCqeyiClEWOD6r4OkR38BGdAci6nI7/MXkjqqjP2PxwLsR6aZifueCuhLpFcKjjf9HWs4PWMQUAua+faqgJp4EyfLHJ6wsFTXGtYmn/iCWdqAlv05K1c/ZvXGnttmb8/1mb0Az0gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732556623; c=relaxed/simple;
	bh=CWqVzIiuNxykcuB0iYdBtVRB6E8SRFf383iahP+I3vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jf3DaFQdh0MVhsPCPB7L3ZQO/2fZ2Afoq1n8cOpvWwPt/0iBwrwSJ0OnIwE/HVIj70pnOc4O778AXPXSYXa4u8pQDKZhgSjU1+9OTKvFXrMDK8jmI0e+IYp/Bwx5oUGdclTttd6je10Bxp9IwIvPKXz/IS/ijwZuk9lpVRMa4W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nqYAq9KD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HBgydeSv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nqYAq9KD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HBgydeSv"
Date: Mon, 25 Nov 2024 18:43:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732556618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jQdt7h/RJdrkpacfF5rToM6/IVO2Lwg4EZBlo4SlFgI=;
	b=nqYAq9KDP6ZLMrM8gj/QtkCO+WHftWyQAnqwvic1HSFpahwEkPWeQBwRWufHP7V3wTkx/H
	RG70MbVyQiRv21wzm8SHreaGpo9kTN1rlcMtjcX7Nbll7IOfiFXIe6mfTxwjNuXuZhF1HP
	Z13iAk1AU8QUTDdZlGuqZt1NYjnM93utsc/t7p5onfHtt4HJ53wSMDmoZD0hnwEd8Hb7qy
	SEvDxjAB1ljcx8NLOvFaSiCk7hUfBbE0kRQpBB/6w95i+sx/87Lx69lg/FUbOyraR3uB1b
	3fRak5NSCUdbbbPMDjKGo0HgcygmGI+U4F4vfFJdQqMFpNm0WbuSn1fJsUg0bA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732556618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jQdt7h/RJdrkpacfF5rToM6/IVO2Lwg4EZBlo4SlFgI=;
	b=HBgydeSvGuHtpcM2alb0WM8q0OuJwZwEXyiZ+qTPnLIa1d9TMPGW1LvUwK47dXIs09uwEM
	gmlyYNVYvZvXTCAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
	Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Subject: Re: [PATCH] sparc/pci: Make pci_poke_lock a raw_spinlock_t.
Message-ID: <20241125174336.8nEhFXIw@linutronix.de>
References: <20241009161041.1018375-1-bigeasy@linutronix.de>
 <20241009161041.1018375-2-bigeasy@linutronix.de>
 <7656395b-58fc-4874-a9f3-6d934e2ef7ee@roeck-us.net>
 <20241125085314.1iSDFulg@linutronix.de>
 <b776ca37-d51c-47e2-b3bb-aee8e7910630@roeck-us.net>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b776ca37-d51c-47e2-b3bb-aee8e7910630@roeck-us.net>

On 2024-11-25 09:01:33 [-0800], Guenter Roeck wrote:
> Unfortunately it doesn't make a difference.

stunning. It looks like the exact same error message.

> [    1.050499] =============================
> [    1.050801] [ BUG: Invalid wait context ]
> [    1.051200] 6.12.0+ #1 Not tainted
> [    1.051571] -----------------------------
> [    1.051875] swapper/0/1 is trying to lock:
> [    1.052201] 0000000001b694c8 (pci_poke_lock){....}-{3:3}, at: pci_config_read16+0x8/0x80
> [    1.052994] other info that might help us debug this:
> [    1.053331] context-{5:5}
> [    1.053641] 2 locks held by swapper/0/1:
> [    1.053959]  #0: fffff800042b50f8 (&dev->mutex){....}-{4:4}, at: __driver_attach+0x80/0x160
> [    1.054388]  #1: 0000000001d29078 (pci_lock){....}-{2:2}, at: pci_bus_read_config_word+0x18/0x80
> [    1.054793] stack backtrace:
> [    1.055171] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.0+ #1
> [    1.055632] Call Trace:
> [    1.055985] [<00000000004e31d0>] __lock_acquire+0xa50/0x3160
> [    1.056329] [<00000000004e63e8>] lock_acquire+0xe8/0x340
> [    1.056645] [<00000000010f0dfc>] _raw_spin_lock_irqsave+0x3c/0x80
> [    1.056966] [<0000000000443828>] pci_config_read16+0x8/0x80
> [    1.057278] [<000000000044442c>] sun4u_read_pci_cfg+0x12c/0x1a0
> [    1.057593] [<0000000000b7657c>] pci_bus_read_config_word+0x3c/0x80
> [    1.057913] [<0000000000b7fa78>] pci_find_capability+0x18/0xa0
> [    1.058228] [<0000000000b794b0>] set_pcie_port_type+0x10/0x160
> [    1.058543] [<0000000000442a98>] pci_of_scan_bus+0x158/0xb00
> [    1.058854] [<00000000010c74a0>] pci_scan_one_pbm+0xd0/0xf8
> [    1.059167] [<0000000000446174>] sabre_probe+0x1f4/0x5c0
> [    1.059476] [<0000000000c13a48>] platform_probe+0x28/0x80
> [    1.059785] [<0000000000c11158>] really_probe+0xb8/0x340
> [    1.060098] [<0000000000c11584>] driver_probe_device+0x24/0xe0
> [    1.060413] [<0000000000c117ac>] __driver_attach+0x8c/0x160
> [    1.060728] [<0000000000c0ef54>] bus_for_each_dev+0x54/0xc0
> 
> The original call trace also included _raw_spin_lock_irqsave(), and
> I don't have CONFIG_PREEMPT_RT enabled in my sparc64 builds to start with.

You don't have to. "CONFIG_PROVE_RAW_LOCK_NESTING" looks if you try to
acquire raw_spinlock_t -> spinlock_t. Which it did before I made the
patch.
The pci_lock is from drivers/pci/access.c and is defined as
raw_spinlock_t. And I made pci_poke_lock of the same time. But debug
says 3:3 which suggests LD_WAIT_CONFIG. (No patch applied).

> FWIW, I don't understand the value of
> 	pr_warn("context-{%d:%d}\n", curr_inner, curr_inner);
> Why print curr_inner twice ?

The syntax was once (or is) inner:outer. If you look from the top, you
have 4 (mutex_t) followed pci_lock (the raw_spinlock_t) 2. You are at
level 2 now and try to acquire spin_lock_t (3).

> Thanks,
> Guenter

Sebastian

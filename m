Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52E01F2393;
	Wed, 11 Dec 2024 22:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733956350; cv=none; b=RIfDmc5ocYpWKC5ywhrYJobpruTeez7PrNOxo4QmWzNNJ/Zp2S2y+8U6XzY2ygH3kMv3jdhLZjlGTXVnjK8XPHrkli952q3doGaYO/zpN3dOTxv00jHlgYtoGyJ/uwello2BztJyutQuKTf9MCL/UwdR55YE2TPc5w1VUwOad6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733956350; c=relaxed/simple;
	bh=Lj6m1KGdu6A9P37ePkeHmGhpEOYrC07Re+9IHx97taY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aHsABgRV+o3XqCesclcHGcKoz8TCYHm7Zpvti/bFtfTiNiPrKV5CkTbDja0AAzugz7Hy5IaEI0IBiXF5wmvFmxfYUA/FNdUlIrfeSHGO9iSH8lX6E5BRFizN1NzjzT6NjF3pabD8Jzn5Ff3Tqo1GjzGQFTpSD8IA36ci1+A6p0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+h6JdhY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+h6JdhY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ABF1C4CED2;
	Wed, 11 Dec 2024 22:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733956350;
	bh=Lj6m1KGdu6A9P37ePkeHmGhpEOYrC07Re+9IHx97taY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Q+h6JdhYbgWkkJZKxxBpvzzMrsNxkGoEdza4YFJyky6PGRqvTppB4WWSHpF2XbZEp
	 3RmwDTIJ+IWZiPF6URzM7AFAUrovMRw7D8NbXB+92TG9vVWaXrcU/MsgUuSOZ3vPex
	 o0MaFjihetIadNNvJTpEn+nlZctZbXnS0fVYRMWoku2hOngBPg/UbRT+WKkxpgNf2d
	 SwvyT1mNlDgHbiMNbtlfPoLzmzqTgNvTIuq+Jo3m/NabxJ757iMFljbIUWU4KxUn8N
	 5ID5hDIVQ1/ODfWBnJSI9qXoWm4SM9dKAfh3gfNA/Y4dMt1mVhzEjFLVbDxspwHNRS
	 2u3nMpWh8Eo9Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C81380A965;
	Wed, 11 Dec 2024 22:32:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] kernel/irq/proc: performance: replace seq_printf with
 seq_put_decimal_ull_width
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <173395636600.1729195.17930169527159894833.git-patchwork-notify@kernel.org>
Date: Wed, 11 Dec 2024 22:32:46 +0000
References: <20241103080552.4787-1-00107082@163.com>
In-Reply-To: <20241103080552.4787-1-00107082@163.com>
To: David Wang <00107082@163.com>
Cc: linux-riscv@lists.infradead.org, tglx@linutronix.de,
 richard.henderson@linaro.org, linux@armlinux.org.uk, catalin.marinas@arm.com,
 will@kernel.org, guoren@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name,
 James.Bottomley@HansenPartnership.com, deller@gmx.de, mpe@ellerman.id.au,
 paul.walmsley@sifive.com, ysato@users.sourceforge.jp, dalias@libc.org,
 glaubitz@physik.fu-berlin.de, davem@davemloft.net, andreas@gaisler.com,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 chris@zankel.net, jcmvbkbc@gmail.com, linux-kernel@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-csky@vger.kernel.org, loongarch@lists.linux.dev,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Michael Ellerman <mpe@ellerman.id.au>:

On Sun,  3 Nov 2024 16:05:52 +0800 you wrote:
> seq_printf is costy, when stress reading /proc/interrupts, profiling indicates
> seq_printf takes about ~47% of show_interrupts samples:
> 
>     show_interrupts(94.495% 5166019/5466991)
> 	seq_printf(47.429% 2450210/5166019)
> 	    vsnprintf(89.232% 2186366/2450210)
> 		format_decode(24.005% 524831/2186366)
> 		number(19.488% 426084/2186366)
> 		memcpy_orig(3.739% 81753/2186366)
> 		...
> 	_raw_spin_unlock_irqrestore(26.643% 1376379/5166019)
> 	mtree_load(8.059% 416304/5166019)
> 
> [...]

Here is the summary with links:
  - kernel/irq/proc: performance: replace seq_printf with seq_put_decimal_ull_width
    https://git.kernel.org/riscv/c/5b881c1f8379

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



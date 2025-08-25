Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187AA2FCBF4;
	Mon, 25 Aug 2025 16:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756137773; cv=none; b=I02l8Y2CGsgkhHjZCBtMEmq8A2/ymLGnbeGSq+g8+gTwqo1v7nyIibDfPmBkNr2QQ0R2fFpr87PwaQ9JtlXplVkVi4/T8jC0uoUhmHxZcUWud5nBy3IbkAxxYincn135GgwEo7U47xfLlIA86xyaBakAKTQkOXl77P+YSnfNQYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756137773; c=relaxed/simple;
	bh=V5M7Uz8Gq9kOsjqDC2LZcLvwZ5f7W0zPaN3CQziwQ4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i8GCysKG8PvyQXCJNLhV+NQfw4vv1llfhnTfWr1OrXRwNFgmMOU1JWmDFTJ4+COMRI+jM9GhhX1TjiKM29IpvAze18pwvqZJYBch7zPPp+dWqnCGA/tgYPzOvtsesjQi9shLjhYM4YohfnFXlTvgj+cXV6GiAMQf5taeYT3fBpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=DGYZWQ6w reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="DGYZWQ6w"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4c9b3Y4vMXz1FbZH;
	Mon, 25 Aug 2025 17:55:21 +0200 (CEST)
Received: from [10.10.15.10] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4c9b3Y1DGJz1DDXf;
	Mon, 25 Aug 2025 17:55:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1756137321;
	bh=0aXwnh60FryoKY16vZa9A72ClzBSpD9XFHsMTXX24vs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=DGYZWQ6wbTL5qBh9rPu3AK81zl60k9DJ2aRqgR914G7wXh2Zw3Ido+qVU0TrJvbf6
	 zo4cKyTGAkkhjRm3vACE/Q72ZjO8mMANLBNPAxNpT0Tiuhp+87uliUC1VB0CM+YN9o
	 ZMf0oLNKHUhM7HxHzT/zNEI2gcHDZiDzdsEamZddhMPTeIC2pwBkQ2+9EpFj+OL8FP
	 E2/uT9p0qx5aXUFAHfjbGnJdZt5wwfCb8dUheFMh22BOO94XGWBZayqOVi5Cpiau63
	 lEtu8IxnlSZ/XcVVaWTko7tBonfIZnVpl2ty/rPgDVZhuQ19fMY3JZBHf8i8ZaKl3r
	 dHff2v7ufh2Kg==
Message-ID: <0b223e3d-25af-4897-b513-699dfeedfa04@gaisler.com>
Date: Mon, 25 Aug 2025 17:55:20 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/13] sparc64: vdso: Switch to the generic vDSO
 library
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, Arnd Bergmann
 <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>,
 Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>,
 Nick Alcock <nick.alcock@oracle.com>, John Stultz <jstultz@google.com>,
 Stephen Boyd <sboyd@kernel.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
References: <20250815-vdso-sparc64-generic-2-v2-0-b5ff80672347@linutronix.de>
 <20250815-vdso-sparc64-generic-2-v2-8-b5ff80672347@linutronix.de>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20250815-vdso-sparc64-generic-2-v2-8-b5ff80672347@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2025-08-15 12:41, Thomas Weißschuh wrote:
> The generic vDSO provides a lot common functionality shared between
> different architectures. SPARC is the last architecture not using it,
> preventing some necessary code cleanup.
> 
> Make use of the generic infrastructure.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---
>  arch/sparc/Kconfig                         |   4 +-
>  arch/sparc/include/asm/clocksource.h       |   9 --
>  arch/sparc/include/asm/vdso/clocksource.h  |  10 ++
>  arch/sparc/include/asm/vdso/gettimeofday.h |  58 ++++++++--
>  arch/sparc/include/asm/vdso/vsyscall.h     |  10 ++
>  arch/sparc/include/asm/vvar.h              |  75 -------------
>  arch/sparc/kernel/Makefile                 |   1 -
>  arch/sparc/kernel/time_64.c                |   6 +-
>  arch/sparc/kernel/vdso.c                   |  69 ------------
>  arch/sparc/vdso/Makefile                   |   6 +-
>  arch/sparc/vdso/vclock_gettime.c           | 169 ++++-------------------------
>  arch/sparc/vdso/vdso-layout.lds.S          |   7 +-
>  arch/sparc/vdso/vma.c                      |  70 +++---------
>  13 files changed, 119 insertions(+), 375 deletions(-)

Hi,

With the first seven patches (applied on v6.17-rc1) I don't run into any
problems, but from this patch (and onwards) things do not work properly.
With patches 1-8 applied, Debian running on a sun4v (in a Solaris LDOM)
stops being able to mount the root filesystem with the patches applied
up to and including this patch.

As an aside, with all patches applied, it panics when the kernel
attempts to kill init.

Cheers,
Andreas


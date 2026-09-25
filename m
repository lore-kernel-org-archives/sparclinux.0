Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF59334C1C;
	Fri, 25 Sep 2026 07:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790322931; cv=none; b=VYmW+yyUtz0bpspzuy3Ed71ez6Wngfmq9xLAgPeGYTLEDKAZJS+q1ll4HRWVxYAnN5QslC0CTVw8c5iwOIJsaFYGcF0UJrjM06DVQLmhRt8nHT/NN3HQFiLaDMs4Y76F0S0pRI8WnrU81UfyjDCL+ZcVLrLNbHRt3kVMBscNT/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790322931; c=relaxed/simple;
	bh=FEriidh8hrTW9zhAzYrdkT9DirOAghCUjIpSzYMVIyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jak8pXlejS0bolNLPkcg0dIjnVahpU1ZQjVhMPhQi+Bn/2Q/TrX5cNOhX/3f4Vl0kkGoHuRi/g+TKP8T+c6zHuVjsCO87xh9bds30mC219yylBKNhHL6imA7ns4s9BWkDNXVUfTRas/IlOhTG54+yvXfhMAfTJW3IHQyQ65I/1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kMLP34kE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x1lxp934; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kMLP34kE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x1lxp934"
Date: Fri, 25 Sep 2026 09:55:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790322928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j1oZoiwpPSm7nESXGXLFH2Hf/eAbcdLh5BfdFI5GWpE=;
	b=kMLP34kE5V1K/qvVD8uDJT0bGop6QnHVqQ+ldM2Dt0kk9X8Q6s9CuhJ2hBS7e2oiXLBBDN
	8jwNmbpkCm6mdn0oGtukr6ReuA9E9oApqygRRpl1DAPCmbISEAutIz1Oz1Gowe4EfVuNmI
	a7N8SsQiVucP1QDigaad3nR5EP1s+mFt1jAbWcG7b81pasSYuGTOkNAkVtC5HMyRqoq9Oo
	ybVUKQ5LVV+siKtGhSI3qRd2BX68NNdxSMRpIzgfiddeSUNUuwQbHb53zmkQjZMHsrHtJx
	fXaMM1beuarp0XekGVAvIW51Quo3ndqmdZsLDaWTFO3Ayb24nl+zqX6TYGEjug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790322928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j1oZoiwpPSm7nESXGXLFH2Hf/eAbcdLh5BfdFI5GWpE=;
	b=x1lxp934dw0G0QEMIvf3mDnZ57P/vfsx+HTmqRVMbuLa2TCqKM5ChzWo1/qbIWafq+10xE
	1bOyv+WJs7xNUJAA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Stian Halseth <stian@itx.no>
Cc: davem@davemloft.net, Andreas Larsson <andreas@gaisler.com>, 
	Thomas Gleixner <tglx@kernel.org>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sparc64: vdso: Flush the D-cache after updating the time
 data
Message-ID: <20260925094635-9b01777e-a9fa-41b4-9d4c-3a25961182b4@linutronix.de>
References: <20260917082547.223729-1-stian@itx.no>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260917082547.223729-1-stian@itx.no>

On Thu, Sep 17, 2026 at 10:25:47AM +0200, Stian Halseth wrote:
> The vDSO time data page is written through the kernel linear mapping
> and read through a user mapping placed without colour alignment.  On
> sun4u the L1 D-cache is virtually indexed, so when the two differ in
> colour the timekeeping CPU's stores leave stale lines behind the user
> alias in its own D-cache.  The seqcount does not catch this: the line
> holding seq and the lines holding the clock data are refreshed
> independently, so a reader sees an even, unchanged seq together with a
> mix of old and new fields.

(...)

> Fixes: 9a08862a5d2e ("vDSO for sparc")

I'd like to *also* have a fixes tag for the migration to the generic
infrastructure here:

Fixes: 7c5fc16c7a56 ("sparc64: vdso: Switch to the generic vDSO library")

While it was broken before, the diff is against that commit.

> Closes: https://github.com/sparclinux/issues/issues/94
> Signed-off-by: Stian Halseth <stian@itx.no>

Reviewed-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>

> ---
>  arch/sparc/include/asm/vdso/vsyscall.h | 10 ++++++++++
>  arch/sparc/vdso/vma.c                  |  6 ++++++
>  2 files changed, 16 insertions(+)

(...)

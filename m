Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F4B19992C;
	Thu,  7 May 2026 09:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778147451; cv=none; b=gX5ff4EBeKaQNbP0+yYSXvXG9oiKiNZNBJO+h6HHd/mXUMyNJGrtk9viS7gHsVoyZLR7LGjmT68Grr9PJK17vosDNVN8+b4BnFnF1F1jWH7+Ok83v3qRzAJs7UyYBLf15bF3oIxJm7UnkLYxg6leTN7Gz4AcJAplfgz9xQfQ7Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778147451; c=relaxed/simple;
	bh=6/O4g5sKOzC1QkhFRj0XV8eT+wsdg3hxXAqmP1cUrkw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aK0WwUYIfNboo2tFVHzKUwTpRGumG5daSKkymYg3gkAf1e/MaC8asdlhrvo5giPojaOppK34xhAd0keFw4r38AznyW/tbTTi2EGyz2MjqhBduzmWLfzvIKAFQh6SFzIZrp6pJrlZ5HFZ3/rQcvk40pPYQpIc5Bg30njPn8A8YHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=leWMdPdy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Tq2nphDt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="leWMdPdy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Tq2nphDt"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1778147447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NBH0jyNZrOzmMWTTXswtxOpylKAjIZZm3k5vmlmFTBY=;
	b=leWMdPdyfke1PG9kBHkhG5M8+CkYZqJLTLAqeCjYiODinG+/j5IfywZS4BLtwSeOnAhR6D
	pw/eSfCLzgoMv61xYkcFltHJt75Aj5NL592c/QId6geF4NJndJWESdEbRgVpzZJaKCAEAk
	S46RxvcRAIZA9ahHYcTAxrtRU+Lc+i248yF5/kVapuIJ8z3dVEqbikVTF3jyXqEuOI+x3T
	3bevzAN4DzkSVknLp5v6SvQ6O8TC9Rp1nxTnpME2Yz+kDQdJ86k1KXyx7rg0SDmJQCUrew
	Jl0XoiQVfdJ919Xfgwb85G6jo2BOn+QjO9UZmH6nOsM9NQzLPu3et2OdyeeYug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1778147447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NBH0jyNZrOzmMWTTXswtxOpylKAjIZZm3k5vmlmFTBY=;
	b=Tq2nphDtcvBpFn3zxihLGoMnyKDvoUWprRrJufVzWFnDKGTEAFUEQ7hCJcHsFd6FLZEOal
	HAqr18N14WAjRFBg==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Ilpo =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Thomas Fourier <fourier.thomas@gmail.com>,
	Kees Cook <kees@kernel.org>, linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH tty v4 2/6] serial: Replace driver usage of UPF_CONS_FLOW
In-Reply-To: <20260506121606.5805-3-john.ogness@linutronix.de>
References: <20260506121606.5805-1-john.ogness@linutronix.de>
 <20260506121606.5805-3-john.ogness@linutronix.de>
Date: Thu, 07 May 2026 11:56:46 +0206
Message-ID: <87lddvy2dl.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

(This email is particularly directed at the Samsung folks.)

Responding to Sashiko:

https://sashiko.dev/#/patchset/20260506121606.5805-1-john.ogness%40linutronix.de

On 2026-05-06, Sashiko wrote:
>> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
>> index e27806bf2cf3e..2f94fc798cffb 100644
>> --- a/drivers/tty/serial/samsung_tty.c
>> +++ b/drivers/tty/serial/samsung_tty.c
>> @@ -319,7 +319,7 @@ static void s3c24xx_serial_stop_tx(struct uart_port *port)
>>  	ourport->tx_enabled = 0;
>>  	ourport->tx_in_progress = 0;
>>  
>> -	if (port->flags & UPF_CONS_FLOW)
>> +	if (uart_cons_flow_enabled(port))
>>  		s3c24xx_serial_rx_enable(port);
>
> This isn't a new bug introduced by this patch, but does this code
> result in a recursive spinlock acquisition and deadlock when console
> flow control is enabled?
>
> The serial core framework calls port->ops->stop_tx() with the
> port->lock spinlock already held. When uart_cons_flow_enabled(port)
> evaluates to true, s3c24xx_serial_stop_tx() invokes
> s3c24xx_serial_rx_enable().
>
> Looking at s3c24xx_serial_rx_enable(), it unconditionally attempts to
> acquire the exact same lock again:
>
> static void s3c24xx_serial_rx_enable(struct uart_port *port)
> {
> 	struct s3c24xx_uart_port *ourport = to_ourport(port);
> 	unsigned long flags;
> 	...
> 	uart_port_lock_irqsave(port, &flags);
> 	...
> }
>
> Because spinlocks are not recursive in the kernel, it appears this
> sequence would cause an immediate deadlock on the same CPU.

Although out of scope for my series, the reported issue is real. Perhaps
something for Krzysztof or Alim to look into.

>> @@ -493,7 +493,7 @@ static void s3c24xx_serial_start_tx(struct uart_port *port)
>>  	struct tty_port *tport = &port->state->port;
>>  
>>  	if (!ourport->tx_enabled) {
>> -		if (port->flags & UPF_CONS_FLOW)
>> +		if (uart_cons_flow_enabled(port))
>>  			s3c24xx_serial_rx_disable(port);
>
> Similarly here, s3c24xx_serial_start_tx() is also called with
> port->lock held, and s3c24xx_serial_rx_disable() will attempt to
> acquire port->lock again:
>
> static void s3c24xx_serial_rx_disable(struct uart_port *port)
> {
> 	struct s3c24xx_uart_port *ourport = to_ourport(port);
> 	unsigned long flags;
> 	...
> 	uart_port_lock_irqsave(port, &flags);
> 	...
> }
>
> Could this pre-existing locking issue in the samsung_tty driver be
> addressed so that the rx enable/disable helpers do not try to take the
> port lock when it is already held by the caller?

Also legitimate. But out of scope for my series.

John Ogness

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552663B776C;
	Wed, 13 May 2026 19:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778701848; cv=none; b=SkKsfu9kF/BUb7GQC+j6ySIJ70nzC+Zi9Bp9yZ8V3rME6xPtUljt0pS9NtwlBxrRJeN4O2ecB9gbXbfKd/a3FvkRZYoSHCkY0/EO0aFpkxbzb1rn4KKlMnww+YNNuhsrNvDI9fguQS/Ox9jxK8w5X4PPgfk4oQPoZH/rEeus1Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778701848; c=relaxed/simple;
	bh=DUyitwcj2pqGB9DvTz8dhmsbk8ZH1JOgKGFr5wFe24s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q62eLw3tp6Is35pCB1JVdCN5F9DbIMo30vuW6rlOZMFS+aaFlXaN+BuEnsE+TZ4sJcQp2pxYlGuF9xuIK/myZD7LMnPQCL8Gy/3l2tee+ASJX1hTojCLDtmPwzAvy3l5ISJRkQlUiqprcBz3MiiImQB0hRcDiM/nQtJEfXO1fSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W4xkVuoZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4xkVuoZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFD33C19425;
	Wed, 13 May 2026 19:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778701848;
	bh=DUyitwcj2pqGB9DvTz8dhmsbk8ZH1JOgKGFr5wFe24s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=W4xkVuoZtpqwljl1IJw98+ExgePhhSGwfgR5puXpO22uMy+CUH/gGXLVFPWf+QNxC
	 WATz4gIt6B5+d1BhgFI5QKk3KRsGRV5BCPkahkz1OBGhG/TYVE0L3CkEz9l8FnSE++
	 VC3eHwHtrm/kNEGHSuNLBOqUAzf1B79imGShcRIsbfDLTD/AW+O8Kgs7Q+XROZ3Su0
	 6E7Gaeu6kJ4iZOeeKwA2tCEKFOUcsoWp8c6wrbJCqYCgvf7iZtGLLEhxBHOx2SJs79
	 IwyEpaNd3tY97rrvpsVcauOoY0Oy9Nas0+1EwhYqdnQ+po7nTr5sSJxmMV35yReq8a
	 R25xr/k/Lwrqg==
Message-ID: <1a5abd2e-e9ab-4a48-94c2-5e082f57adde@kernel.org>
Date: Wed, 13 May 2026 21:50:42 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH tty v4 2/6] serial: Replace driver usage of UPF_CONS_FLOW
To: John Ogness <john.ogness@linutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
 linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Thomas Fourier <fourier.thomas@gmail.com>, Kees Cook <kees@kernel.org>,
 linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, sparclinux@vger.kernel.org,
 Peter Griffin <peter.griffin@linaro.org>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Alexey Klimov <alexey.klimov@linaro.org>
References: <20260506121606.5805-1-john.ogness@linutronix.de>
 <20260506121606.5805-3-john.ogness@linutronix.de>
 <87lddvy2dl.fsf@jogness.linutronix.de>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <87lddvy2dl.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/05/2026 11:50, John Ogness wrote:
> Hi,
> 
> (This email is particularly directed at the Samsung folks.)
> 
> Responding to Sashiko:
> 
> https://sashiko.dev/#/patchset/20260506121606.5805-1-john.ogness%40linutronix.de
> 
> On 2026-05-06, Sashiko wrote:
>>> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
>>> index e27806bf2cf3e..2f94fc798cffb 100644
>>> --- a/drivers/tty/serial/samsung_tty.c
>>> +++ b/drivers/tty/serial/samsung_tty.c
>>> @@ -319,7 +319,7 @@ static void s3c24xx_serial_stop_tx(struct uart_port *port)
>>>  	ourport->tx_enabled = 0;
>>>  	ourport->tx_in_progress = 0;
>>>  
>>> -	if (port->flags & UPF_CONS_FLOW)
>>> +	if (uart_cons_flow_enabled(port))
>>>  		s3c24xx_serial_rx_enable(port);
>>
>> This isn't a new bug introduced by this patch, but does this code
>> result in a recursive spinlock acquisition and deadlock when console
>> flow control is enabled?
>>
>> The serial core framework calls port->ops->stop_tx() with the
>> port->lock spinlock already held. When uart_cons_flow_enabled(port)
>> evaluates to true, s3c24xx_serial_stop_tx() invokes
>> s3c24xx_serial_rx_enable().
>>
>> Looking at s3c24xx_serial_rx_enable(), it unconditionally attempts to
>> acquire the exact same lock again:
>>
>> static void s3c24xx_serial_rx_enable(struct uart_port *port)
>> {
>> 	struct s3c24xx_uart_port *ourport = to_ourport(port);
>> 	unsigned long flags;
>> 	...
>> 	uart_port_lock_irqsave(port, &flags);
>> 	...
>> }
>>
>> Because spinlocks are not recursive in the kernel, it appears this
>> sequence would cause an immediate deadlock on the same CPU.
> 
> Although out of scope for my series, the reported issue is real. Perhaps
> something for Krzysztof or Alim to look into.
> 
>>> @@ -493,7 +493,7 @@ static void s3c24xx_serial_start_tx(struct uart_port *port)
>>>  	struct tty_port *tport = &port->state->port;
>>>  
>>>  	if (!ourport->tx_enabled) {
>>> -		if (port->flags & UPF_CONS_FLOW)
>>> +		if (uart_cons_flow_enabled(port))
>>>  			s3c24xx_serial_rx_disable(port);
>>
>> Similarly here, s3c24xx_serial_start_tx() is also called with
>> port->lock held, and s3c24xx_serial_rx_disable() will attempt to
>> acquire port->lock again:
>>
>> static void s3c24xx_serial_rx_disable(struct uart_port *port)
>> {
>> 	struct s3c24xx_uart_port *ourport = to_ourport(port);
>> 	unsigned long flags;
>> 	...
>> 	uart_port_lock_irqsave(port, &flags);
>> 	...
>> }
>>
>> Could this pre-existing locking issue in the samsung_tty driver be
>> addressed so that the rx enable/disable helpers do not try to take the
>> port lock when it is already held by the caller?
> 
> Also legitimate. But out of scope for my series.


Thanks for letting us know. Deadlock did not happen so far, so something
is missing in Sashiko's report. :)

I am just back from vacation, so I won't have time to dig into this, but
I will keep your email in the inbox. Cc-ing also a few Linaro folks
which are using this platform and might be able to help us here.

Best regards,
Krzysztof

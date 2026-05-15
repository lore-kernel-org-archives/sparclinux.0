Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C063E92B7;
	Fri, 15 May 2026 07:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778831639; cv=none; b=eyjWHHnvdtwAPFtuJoR5faLHvcEYnuJltyIO2vecDC2Vs34o4jBfrKK8bezvDSg6OZqm3n45GGLhnfk+6FfJx55qLmsRE37D5DJ4WpWHo/qYHXqpwMrAgmQOnAsqSw/tBuHsQY2nlK7/hDOmakPGyKCu03YMNx8RTHjemFk0uz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778831639; c=relaxed/simple;
	bh=/nFq4OHmE8dbUM03xwqrDzHTp3KweVGytErCxZHr5oY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=koNpz73XYphgDAcl+sZ7NgGtft5mBK7tc/iC2bNHFZfy5IeoHbEl6aLc4iyD1Yc1j2o3dcQnOmiVeOLYxGQfK/fiSKxwux6H1FEmh5n9DEtaiHcl/SWPXkF2dtfyr50Dm9be1xEwGx/fajAMQOl7mzj8QqDeCsoFKp7Cizo16iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qtpUpvoc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8QaW9UMC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qtpUpvoc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8QaW9UMC"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1778831636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P5i3jr/Ze5LIkO9MuiHcaAM6dwhzewxwm2J6/ovcRNo=;
	b=qtpUpvocYMS6ga/mG6+yHhgkECgfN4/AWHu4OEWfwDxipL5TsdQ5X3k+V+I7b14vol/Ctv
	LpOvxyM8j8DcbYElrkoCF4USg0Lz7TKZMixJ4X1GEElr76JRimy/rGExHvpN/mrdb65GAW
	Gc77mhFCmV1DUq3wnCiPLUmslcUvKlBQpEPW+dzhPRlGUMbflE3JJl5GUP5p/3x3KtYgMx
	7ZEghSFNU3wSI5T898bHC4ltszzph/Mv7J+ibXEOR2XJ56jj7LNt0FNxcZunVNUB6npV9g
	XpgT7vJpFDejIJEdJDPY6myZJhftYdOLHgFgzvdR/lv4jJVSrKgRs/ww97oMGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1778831636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P5i3jr/Ze5LIkO9MuiHcaAM6dwhzewxwm2J6/ovcRNo=;
	b=8QaW9UMC9D6WJDmRgFabqQSsEY7fzsi0K5cWTpOqVGgiQzDFkqENkkeARQkt0ciOL8/adq
	qTcPuuNMZL70cODQ==
To: Krzysztof Kozlowski <krzk@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Alim
 Akhtar <alim.akhtar@samsung.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
 linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Ilpo =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Andy
 Shevchenko
 <andriy.shevchenko@linux.intel.com>, Thomas Fourier
 <fourier.thomas@gmail.com>, Kees Cook <kees@kernel.org>,
 linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, sparclinux@vger.kernel.org, Peter
 Griffin <peter.griffin@linaro.org>, Tudor Ambarus
 <tudor.ambarus@linaro.org>, =?utf-8?Q?Andr=C3=A9?= Draszik
 <andre.draszik@linaro.org>,
 Alexey Klimov <alexey.klimov@linaro.org>
Subject: Re: [PATCH tty v4 2/6] serial: Replace driver usage of UPF_CONS_FLOW
In-Reply-To: <1a5abd2e-e9ab-4a48-94c2-5e082f57adde@kernel.org>
References: <20260506121606.5805-1-john.ogness@linutronix.de>
 <20260506121606.5805-3-john.ogness@linutronix.de>
 <87lddvy2dl.fsf@jogness.linutronix.de>
 <1a5abd2e-e9ab-4a48-94c2-5e082f57adde@kernel.org>
Date: Fri, 15 May 2026 09:59:55 +0206
Message-ID: <87wlx56rcc.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2026-05-13, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>> (This email is particularly directed at the Samsung folks.)
>> 
>> Responding to Sashiko:
>> 
>> https://sashiko.dev/#/patchset/20260506121606.5805-1-john.ogness%40linutronix.de
>> 
>> On 2026-05-06, Sashiko wrote:
>>>> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
>>>> index e27806bf2cf3e..2f94fc798cffb 100644
>>>> --- a/drivers/tty/serial/samsung_tty.c
>>>> +++ b/drivers/tty/serial/samsung_tty.c
>>>> @@ -319,7 +319,7 @@ static void s3c24xx_serial_stop_tx(struct uart_port *port)
>>>>  	ourport->tx_enabled = 0;
>>>>  	ourport->tx_in_progress = 0;
>>>>  
>>>> -	if (port->flags & UPF_CONS_FLOW)
>>>> +	if (uart_cons_flow_enabled(port))
>>>>  		s3c24xx_serial_rx_enable(port);
>>>
>>> This isn't a new bug introduced by this patch, but does this code
>>> result in a recursive spinlock acquisition and deadlock when console
>>> flow control is enabled?
>>>
>>> The serial core framework calls port->ops->stop_tx() with the
>>> port->lock spinlock already held. When uart_cons_flow_enabled(port)
>>> evaluates to true, s3c24xx_serial_stop_tx() invokes
>>> s3c24xx_serial_rx_enable().
>>>
>>> Looking at s3c24xx_serial_rx_enable(), it unconditionally attempts to
>>> acquire the exact same lock again:
>>>
>>> static void s3c24xx_serial_rx_enable(struct uart_port *port)
>>> {
>>> 	struct s3c24xx_uart_port *ourport = to_ourport(port);
>>> 	unsigned long flags;
>>> 	...
>>> 	uart_port_lock_irqsave(port, &flags);
>>> 	...
>>> }
>>>
>>> Because spinlocks are not recursive in the kernel, it appears this
>>> sequence would cause an immediate deadlock on the same CPU.
>> 
>> Although out of scope for my series, the reported issue is real. Perhaps
>> something for Krzysztof or Alim to look into.
>> 
>>>> @@ -493,7 +493,7 @@ static void s3c24xx_serial_start_tx(struct uart_port *port)
>>>>  	struct tty_port *tport = &port->state->port;
>>>>  
>>>>  	if (!ourport->tx_enabled) {
>>>> -		if (port->flags & UPF_CONS_FLOW)
>>>> +		if (uart_cons_flow_enabled(port))
>>>>  			s3c24xx_serial_rx_disable(port);
>>>
>>> Similarly here, s3c24xx_serial_start_tx() is also called with
>>> port->lock held, and s3c24xx_serial_rx_disable() will attempt to
>>> acquire port->lock again:
>>>
>>> static void s3c24xx_serial_rx_disable(struct uart_port *port)
>>> {
>>> 	struct s3c24xx_uart_port *ourport = to_ourport(port);
>>> 	unsigned long flags;
>>> 	...
>>> 	uart_port_lock_irqsave(port, &flags);
>>> 	...
>>> }
>>>
>>> Could this pre-existing locking issue in the samsung_tty driver be
>>> addressed so that the rx enable/disable helpers do not try to take the
>>> port lock when it is already held by the caller?
>> 
>> Also legitimate. But out of scope for my series.
>
>
> Thanks for letting us know. Deadlock did not happen so far, so something
> is missing in Sashiko's report. :)

Nothing is missing. I am guessing you never use console flow
control. The deadlock is clearly visible:

->stop_tx() (always called with the port locked)
  s3c24xx_serial_stop_tx()
    s3c24xx_serial_rx_enable()
      uart_port_lock_irqsave() (DEADLOCK!)

John Ogness

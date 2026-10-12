Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A71A1DB95E;
	Mon, 12 Oct 2026 06:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791787596; cv=none; b=W4/0mztSL8eE7c0UKyEXOryGcTnGXugPwImnTaCa+bISBYGKZDC132uipV/8RjpjPMNOFDZMDSCeKwBVtWwGJ0xPRoXVGsJJQsKyoSbOQtFhoI/KpH1taNQjS/KvbgQxWiFRGlQVRbbk10JGJ1+CtF7xJk74EYLZErFz5IjO1ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791787596; c=relaxed/simple;
	bh=U3KfXKdEMgL10QyENu9mAQCgxY51Iu08VIuskFAv1/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=naJVZ/FXhNsS6rhuE61OvkdeMB3S6qw5Joyzh7RixDRxA7/PhUBc/5EFhthyqMX+QhfXlzQ+vxSAqVRjZeL58+6mmoC5xsPsKRb1b7qVQ1V16ykoseKlOLlToAWEZd9U6+6nfn5OyGjInEQ5Uq18A9hpr5a8+xsl5KLSVjI3iKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mP4GUgGY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mP4GUgGY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E65741F008A1;
	Mon, 12 Oct 2026 06:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791787595;
	bh=1er6KN0USDluOlCwl7bI7udanJGh8XBrVh6eYmX9B2E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=mP4GUgGYNCxnuPmvg1lujMqLPA7vMvng2SS0pBMHoCRbwwxluGZ1CHCAITsQFxIwd
	 x7wKsblnmPblKZwTGS63Z/VPkeuzGjAUyGwhVXZx5K7K7unAzwoOLZVUFY+nkDURjW
	 X0PNZL/iyeF9Cmy/UiMXAC9LcPt+sCJ2zDtDxDVofUzZDrWFH4BbiVCkN31UXOkwew
	 7cFyBQv7+jpMiLRzknsZ4/q2Gv1tg6cM3zuY9oI8TvIJk3SVGG9xD3lPxaYZfAFa/o
	 FSMhNavBKkxYI/LnLbQ/SDmexIWtlzK0PhS9vRqFDnFRDwv0wP34GrPxp+Iu/3/Ysz
	 nTnGWliycn2uQ==
Message-ID: <1f66c850-faa7-477f-9535-761074ccc077@kernel.org>
Date: Mon, 12 Oct 2026 08:46:30 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] hvc: add an M3000 firmware console backend
To: Magnus Lindholm <linmag7@gmail.com>, davem@davemloft.net,
 andreas@gaisler.com, sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
 linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 krzk@kernel.org, oleg@redhat.com
References: <20261011195729.981243-1-linmag7@gmail.com>
 <20261011195729.981243-7-linmag7@gmail.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 xsFNBE6S54YBEACzzjLwDUbU5elY4GTg/NdotjA0jyyJtYI86wdKraekbNE0bC4zV+ryvH4j
 rrcDwGs6tFVrAHvdHeIdI07s1iIx5R/ndcHwt4fvI8CL5PzPmn5J+h0WERR5rFprRh6axhOk
 rSD5CwQl19fm4AJCS6A9GJtOoiLpWn2/IbogPc71jQVrupZYYx51rAaHZ0D2KYK/uhfc6neJ
 i0WqPlbtIlIrpvWxckucNu6ZwXjFY0f3qIRg3Vqh5QxPkojGsq9tXVFVLEkSVz6FoqCHrUTx
 wr+aw6qqQVgvT/McQtsI0S66uIkQjzPUrgAEtWUv76rM4ekqL9stHyvTGw0Fjsualwb0Gwdx
 ReTZzMgheAyoy/umIOKrSEpWouVoBt5FFSZUyjuDdlPPYyPav+hpI6ggmCTld3u2hyiHji2H
 cDpcLM2LMhlHBipu80s9anNeZhCANDhbC5E+NZmuwgzHBcan8WC7xsPXPaiZSIm7TKaVoOcL
 9tE5aN3jQmIlrT7ZUX52Ff/hSdx/JKDP3YMNtt4B0cH6ejIjtqTd+Ge8sSttsnNM0CQUkXps
 w98jwz+Lxw/bKMr3NSnnFpUZaxwji3BC9vYyxKMAwNelBCHEgS/OAa3EJoTfuYOK6wT6nadm
 YqYjwYbZE5V/SwzMbpWu7Jwlvuwyfo5mh7w5iMfnZE+vHFwp/wARAQABzSFKaXJpIFNsYWJ5
 IDxqaXJpc2xhYnlAa2VybmVsLm9yZz7CwXcEEwEIACEFAlW3RUwCGwMFCwkIBwIGFQgJCgsC
 BBYCAwECHgECF4AACgkQvSWxBAa0cEnVTg//TQpdIAr8Tn0VAeUjdVIH9XCFw+cPSU+zMSCH
 eCZoA/N6gitEcnvHoFVVM7b3hK2HgoFUNbmYC0RdcSc80pOF5gCnACSP9XWHGWzeKCARRcQR
 4s5YD8I4VV5hqXcKo2DFAtIOVbHDW+0okOzcecdasCakUTr7s2fXz97uuoc2gIBB7bmHUGAH
 XQXHvdnCLjDjR+eJN+zrtbqZKYSfj89s/ZHn5Slug6w8qOPT1sVNGG+eWPlc5s7XYhT9z66E
 l5C0rG35JE4PhC+tl7BaE5IwjJlBMHf/cMJxNHAYoQ1hWQCKOfMDQ6bsEr++kGUCbHkrEFwD
 UVA72iLnnnlZCMevwE4hc0zVhseWhPc/KMYObU1sDGqaCesRLkE3tiE7X2cikmj/qH0CoMWe
 gjnwnQ2qVJcaPSzJ4QITvchEQ+tbuVAyvn9H+9MkdT7b7b2OaqYsUP8rn/2k1Td5zknUz7iF
 oJ0Z9wPTl6tDfF8phaMIPISYrhceVOIoL+rWfaikhBulZTIT5ihieY9nQOw6vhOfWkYvv0Dl
 o4GRnb2ybPQpfEs7WtetOsUgiUbfljTgILFw3CsPW8JESOGQc0Pv8ieznIighqPPFz9g+zSu
 Ss/rpcsqag5n9rQp/H3WW5zKUpeYcKGaPDp/vSUovMcjp8USIhzBBrmI7UWAtuedG9prjqfO
 wU0ETpLnhgEQAM+cDWLL+Wvc9cLhA2OXZ/gMmu7NbYKjfth1UyOuBd5emIO+d4RfFM02XFTI
 t4MxwhAryhsKQQcA4iQNldkbyeviYrPKWjLTjRXT5cD2lpWzr+Jx7mX7InV5JOz1Qq+P+nJW
 YIBjUKhI03ux89p58CYil24Zpyn2F5cX7U+inY8lJIBwLPBnc9Z0An/DVnUOD+0wIcYVnZAK
 DiIXODkGqTg3fhZwbbi+KAhtHPFM2fGw2VTUf62IHzV+eBSnamzPOBc1XsJYKRo3FHNeLuS8
 f4wUe7bWb9O66PPFK/RkeqNX6akkFBf9VfrZ1rTEKAyJ2uqf1EI1olYnENk4+00IBa+BavGQ
 8UW9dGW3nbPrfuOV5UUvbnsSQwj67pSdrBQqilr5N/5H9z7VCDQ0dhuJNtvDSlTf2iUFBqgk
 3smln31PUYiVPrMP0V4ja0i9qtO/TB01rTfTyXTRtqz53qO5dGsYiliJO5aUmh8swVpotgK4
 /57h3zGsaXO9PGgnnAdqeKVITaFTLY1ISg+Ptb4KoliiOjrBMmQUSJVtkUXMrCMCeuPDGHo7
 39Xc75lcHlGuM3yEB//htKjyprbLeLf1y4xPyTeeF5zg/0ztRZNKZicgEmxyUNBHHnBKHQxz
 1j+mzH0HjZZtXjGu2KLJ18G07q0fpz2ZPk2D53Ww39VNI/J9ABEBAAHCwV8EGAECAAkFAk6S
 54YCGwwACgkQvSWxBAa0cEk3tRAAgO+DFpbyIa4RlnfpcW17AfnpZi9VR5+zr496n2jH/1ld
 wRO/S+QNSA8qdABqMb9WI4BNaoANgcg0AS429Mq0taaWKkAjkkGAT7mD1Q5PiLr06Y/+Kzdr
 90eUVneqM2TUQQbK+Kh7JwmGVrRGNqQrDk+gRNvKnGwFNeTkTKtJ0P8jYd7P1gZb9Fwj9YLx
 jhn/sVIhNmEBLBoI7PL+9fbILqJPHgAwW35rpnq4f/EYTykbk1sa13Tav6btJ+4QOgbcezWI
 wZ5w/JVfEJW9JXp3BFAVzRQ5nVrrLDAJZ8Y5ioWcm99JtSIIxXxt9FJaGc1Bgsi5K/+dyTKL
 wLMJgiBzbVx8G+fCJJ9YtlNOPWhbKPlrQ8+AY52Aagi9WNhe6XfJdh5g6ptiOILm330mkR4g
 W6nEgZVyIyTq3ekOuruftWL99qpP5zi+eNrMmLRQx9iecDNgFr342R9bTDlb1TLuRb+/tJ98
 f/bIWIr0cqQmqQ33FgRhrG1+Xml6UXyJ2jExmlO8JljuOGeXYh6ZkIEyzqzffzBLXZCujlYQ
 DFXpyMNVJ2ZwPmX2mWEoYuaBU0JN7wM+/zWgOf2zRwhEuD3A2cO2PxoiIfyUEfB9SSmffaK/
 S4xXoB6wvGENZ85Hg37C7WDNdaAt6Xh2uQIly5grkgvWppkNy4ZHxE+jeNsU7tg=
In-Reply-To: <20261011195729.981243-7-linmag7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11. 10. 26, 21:55, Magnus Lindholm wrote:
...
> --- /dev/null
> +++ b/drivers/tty/hvc/hvc_m3000.c
> @@ -0,0 +1,205 @@

> +struct m3000_console {
> +	int stdin;
> +	bool ready;
> +	u8 buffer[256];
> +	raw_spinlock_t buffer_lock;
> +	struct timer_list poll_timer;
> +	struct mutex poll_mutex; /* Serialize open against synchronous close. */
> +	spinlock_t poll_lock; /* Protect active state and timer rearming. */
> +	bool poll_active;

Perhaps group these a bit better, so that there are not such holes?

> +};
...
> +/*
> + * HVC's idle backoff can exceed the firmware input FIFO's capacity.
> + * Wake its worker each tick while open; keep PROM calls out of the timer.
> + */
> +static void m3000_poll_tick(struct timer_list *timer)
> +{
> +	struct m3000_console *con = timer_container_of(con, timer, poll_timer);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&con->poll_lock, flags);

Any reason not to use guard()s?

> +	if (con->poll_active) {
> +		hvc_kick();
> +		mod_timer(&con->poll_timer, jiffies + 1);
> +	}
> +	spin_unlock_irqrestore(&con->poll_lock, flags);
> +}
> +
> +static int m3000_open(struct hvc_struct *hp, int data)
> +{
> +	struct m3000_console *con = m3000_console(hp->vtermno);
> +	unsigned long flags;
> +
> +	if (!con)
> +		return -ENODEV;
> +	mutex_lock(&con->poll_mutex);
> +	spin_lock_irqsave(&con->poll_lock, flags);

Same here.

> +	con->poll_active = true;
> +	mod_timer(&con->poll_timer, jiffies + 1);
> +	spin_unlock_irqrestore(&con->poll_lock, flags);
> +	mutex_unlock(&con->poll_mutex);
> +	return 0;
> +}
> +
> +static void m3000_close(struct hvc_struct *hp, int data)
> +{
> +	struct m3000_console *con = m3000_console(hp->vtermno);
> +	unsigned long flags;
> +
> +	if (!con)
> +		return;
> +	mutex_lock(&con->poll_mutex);
> +	spin_lock_irqsave(&con->poll_lock, flags);

And here.

> +	con->poll_active = false;
> +	spin_unlock_irqrestore(&con->poll_lock, flags);
> +	/* Block reopen until the callback has finished and cannot rearm. */
> +	timer_delete_sync(&con->poll_timer);
> +	mutex_unlock(&con->poll_mutex);
> +}
> +
> +static ssize_t m3000_io(struct m3000_console *con, u8 *in,
> +			const u8 *out, size_t count)
> +{
> +	unsigned long args[7], flags;
> +	bool input = in;

You can test "in" below directly, right?

> +	int ret;
> +
> +	if (!count)
> +		return 0;
> +	count = min(count, input ? 1 : sizeof(con->buffer));
> +	/* Console writes can run with interrupts disabled; this lock cannot sleep. */
> +	raw_spin_lock_irqsave(&con->buffer_lock, flags);

scoped_guard()

> +	if (!input)
> +		memcpy(con->buffer, out, count);
> +	args[0] = (unsigned long)(input ? "read" : "write");
> +	args[1] = 3;
> +	args[2] = 1;
> +	args[3] = (unsigned int)(input ? con->stdin : prom_stdout);
> +	args[4] = (unsigned long)con->buffer;
> +	args[5] = count;
> +	args[6] = (unsigned long)-1;
> +	p1275_cmd_direct(args);
> +	ret = (int)args[6];
> +	if (ret > 0 && ret <= count && input)
> +		memcpy(in, con->buffer, ret);
> +	raw_spin_unlock_irqrestore(&con->buffer_lock, flags);
> +	if (ret == -2 || ret == 0)

That's full of magic constants. Can we have defines for those?

> +		return 0;
> +	if (ret < 0 || ret > count)
> +		return -EIO;
> +	return ret;
thanks,
-- 
js
suse labs

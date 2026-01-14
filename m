Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B8738A701;
	Wed, 14 Jan 2026 08:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768380039; cv=none; b=OUGn3zqcHqnbGif+fxvQyEMMRfLpQgDJK0kmK8EYijaKPDOsuccaNrWFgMyGzTAa09m5ltn8mo26XmnT2PWsk9F2hgtADRWcJTGJgluu8nrWUY4pHj/ybTYhLl0nR+U/beXYnO2ESYko8qq5SiL5Z9txUYTOoaM7jJDBKQTcxyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768380039; c=relaxed/simple;
	bh=DQpq7j5o1Szd64FJZlI9MRLRGX04nOFETd0XURpz/Fw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SWdePDG0sGgy3GIfM/ByIon0j2FZCSlPS4GAz2byGFzPGHcJTfx0eb9Hv64pI5FHApIkqbTgc7pp4MvUe9dUXUyCOCo9pXOtR0uI8X556e1De+up8DH8fm5lrBTBa0w3AMFx42OTPd8vfLkbv/5S5mTJLIBzoglrnvZZk60xwS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=ZBB5JVMx reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="ZBB5JVMx"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4drfhG01K0z1FDXr;
	Wed, 14 Jan 2026 09:40:30 +0100 (CET)
Received: from [192.168.0.25] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4drfhF3nR8z1DDSf;
	Wed, 14 Jan 2026 09:40:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1768380029;
	bh=CHOZOjSAVpzpC0OqFE2eYDcAsyEDfjeXMhIuAg3lWbg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ZBB5JVMxm0vkoonNB+zNyqDfgBvaGqNg8tNFd39FuISIVzZoJBJII4FHWEyQYUcKI
	 vhkEcVWhOPLzyGb++icdb4ynwBUyEypCy9+SI8Qo0BhUYS+1ei3bOf/U2c51g7Onsk
	 +AK0TAuu80MyI4SCER3Nl010QfpzdcZG4LEqyhxQKYJC0VrjBcMgZqTYZHxOOiv9JV
	 pQnP113mge5cwGVBshXyiswjBY49ER3w49k6G7dSdTHcNdVA8lh8dy0VqWeW4bjvH1
	 F/gop2F3SHnqyJMNPN8g08J4xzgTjGsbA/YbbK8B+DWNsJAP9qnhwbFHzL6evE9m5Z
	 t2MOZH5sx0EKQ==
Message-ID: <ea889379-7cc9-4e03-8040-2797acfb375c@gaisler.com>
Date: Wed, 14 Jan 2026 09:40:28 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sparc/led: prevent buffer underflow on zero-length write
To: Miaoqian Lin <linmq006@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Ingo Molnar <mingo@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Lars Kotthoff
 <metalhead@metalhead.ws>, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20251030072156.30656-1-linmq006@gmail.com>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20251030072156.30656-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-10-30 08:21, Miaoqian Lin wrote:
> Fix out-of-bounds access in led_proc_write() when count is 0.
> Accessing buf[count - 1] with count=0 reads/writes buf[-1].
> 
> Check for count==0 and return -EINVAL early to fix this.
> 
> Found via static analysis and code review.
> 
> Fixes: ee1858d3122d ("[SPARC]: Add sun4m LED driver.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  arch/sparc/kernel/led.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/sparc/kernel/led.c b/arch/sparc/kernel/led.c
> index f4fb82b019bb..aa0ca0d8d0e2 100644
> --- a/arch/sparc/kernel/led.c
> +++ b/arch/sparc/kernel/led.c
> @@ -70,6 +70,9 @@ static ssize_t led_proc_write(struct file *file, const char __user *buffer,
>  {
>  	char *buf = NULL;
>  
> +	if (count == 0)
> +		return -EINVAL;
> +
>  	if (count > LED_MAX_LENGTH)
>  		count = LED_MAX_LENGTH;
>  

Thank you for the patch.

I see no need to fail on the empty string in particular when further
down we have a default case:

	} else {
		auxio_set_led(AUXIO_LED_OFF);
	}

for any string not matching particular cases.

Instead, please stop the incorrect buffer access with something like:

diff --git a/arch/sparc/kernel/led.c b/arch/sparc/kernel/led.c
index f4fb82b019bb9..9b53ac1fe533d 100644
--- a/arch/sparc/kernel/led.c
+++ b/arch/sparc/kernel/led.c
@@ -78,7 +78,7 @@ static ssize_t led_proc_write(struct file *file, const char __user *buffer,
                return PTR_ERR(buf);
 
        /* work around \n when echo'ing into proc */
-       if (buf[count - 1] == '\n')
+       if (count > 0 && buf[count - 1] == '\n')
                buf[count - 1] = '\0';
 
        /* before we change anything we want to stop any running timers,

Thanks,
Andreas


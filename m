Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FC447A48
	for <sparclinux@vger.kernel.org>; Fri, 22 Mar 2024 14:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711116749; cv=none; b=rmDwTOSOz7RXI9rwsO6yqU2ynT1MQcr/idfQuDrdtwvhkdgB4S/Q4ud9pOEJ6/t48+er3J1BjcNmj00ijgMt2udeJ/dmEoWdR4u4y0VAkJ+zkDfI4KiTk4/2KKT67PJ46HqB/i0BLEmFdl11mRK4Abj9k9OEaD/rzxNj5Pyxo5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711116749; c=relaxed/simple;
	bh=xaP3sAbLubt6f1b7wDUbIs8Zobt3RgckgcUvcMqq0tw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dDV0D50Vu2qeDzY1twLP78gvnbsgpKrhrOLSlL/b8PFKP9RvNWGC8KWtydQA3YXRA767n6tok/H/+nLMs18iu8FJ3SXgcJuhLWgh762yUWOHnHaR0EtXjyKw9ObWtBdq3oYvoChraT5gHIQFqoskNi5edh6z6bPwAfGVB4kcEPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca; spf=none smtp.mailfrom=draconx.ca; dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b=CyTnfEUJ; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=draconx.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b="CyTnfEUJ"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-789e3f17a6eso150821885a.0
        for <sparclinux@vger.kernel.org>; Fri, 22 Mar 2024 07:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20230601.gappssmtp.com; s=20230601; t=1711116747; x=1711721547; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ccm1mtAb95qdb6lkqB0FItmGid6eaARPcUgc6MW739g=;
        b=CyTnfEUJHsymqTdVoMVhR2UT1dVcu8qtdw/0rW/bYjqnRmbzZQ53SD1Pq1LgyE44Ff
         B7YukyopaeBiXcJ7xV1Ul2U2Gar76bJItz4p6XUhgCfdrt+epVoNCQyVNytimSfv6YMe
         P5Y7XyAd17UzMkon81/v1e2zl1nS2ZRtiratCi0TL0aafrJckRSbBFl3qo7cEFr+iZcv
         /RrZmQhm0+oyAGHhbBKd9lH9Gpzahmk0KgMcn9XYG1vPE+MRImwtXoBH4UzGDL6qU3N7
         bEF7FxlBB6tcp+gq3LHA+V+7cu6fVsMmPUPv9bYSkmXdBFsSZaLChNPHOZ2/WIwYRE7r
         Q5vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711116747; x=1711721547;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ccm1mtAb95qdb6lkqB0FItmGid6eaARPcUgc6MW739g=;
        b=PfMDB1N2nEc0dX08TN0uLuAYtNohZ8NgPtJjHrjCP4pJdIukVtkK4sgffULLRpVWky
         5z1DnkU6BfDDPYnFonZCVqBD2oL1G/1yCYKX/kBNZexln0AvsOBcWr+RLgASYromxymP
         hUALUWZT1LhHXwB72uIY76oee9Nu06lyLFGVjxeb6MrjWvnvhWIt8Dd+8+tVZIvZeUWA
         e9vqy8bbVTwUn8wJLJg2GO4My6gSyrHUH4sYgKIvMa0aJJjgBU0UplbG+ue1dMTZKg/5
         OvvQniNLeSDwhMXEiDN5eoCEnRL8npONhQbk33uepQvmT+vpxETmyIONljG3emoK6cPz
         a23A==
X-Forwarded-Encrypted: i=1; AJvYcCWyxtDO4ig4uj12NZEs1pJEjgwnLKXcVMMpaPrt/iZH0qNYfBnnbubQBbo2vjRpwspTyPq+AXyLD/tg/tkpqiVVimaIXsai2aSZjw==
X-Gm-Message-State: AOJu0YxXv5VVN5AWH7JKDNCzKHB2vfOpMEQtRF91QgoB/uCwEbqFCg/B
	YwOT02gj210EthGdctxNwpbj/WmUdjuDQjNcRRv3g04ynQo8BoGzbcNeaxV2LrU=
X-Google-Smtp-Source: AGHT+IFnfaJOCDK6cUge2Q0kmiLhh1+As+3fWIT4dvDOMO5Q9mrgQY3RBqSVCXK7jYSLUb7CSofK/A==
X-Received: by 2002:a05:620a:5605:b0:789:d306:879a with SMTP id vu5-20020a05620a560500b00789d306879amr2427097qkn.7.1711116746679;
        Fri, 22 Mar 2024 07:12:26 -0700 (PDT)
Received: from [192.168.0.50] (dhcp-24-53-241-2.cable.user.start.ca. [24.53.241.2])
        by smtp.gmail.com with ESMTPSA id bj23-20020a05620a191700b00789f34f225dsm782925qkb.71.2024.03.22.07.12.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 07:12:26 -0700 (PDT)
Message-ID: <193a134c-f0da-4a45-b45a-a3605f91cfa4@draconx.ca>
Date: Fri, 22 Mar 2024 10:12:25 -0400
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PROBLEM: Sun Ultra 60 hangs on boot since Linux 6.8
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 regressions@lists.linux.dev, linux-serial@vger.kernel.org
References: <d84baa5d-a092-3647-8062-ed7081d329d4@draconx.ca>
 <20240322051531.GA5132@atomide.com>
 <d7337014-09ac-8a35-7159-e75ecd2707b6@draconx.ca>
 <20240322064843.GC5132@atomide.com> <20240322090657.GD5132@atomide.com>
Content-Language: en-US
From: Nick Bowler <nbowler@draconx.ca>
In-Reply-To: <20240322090657.GD5132@atomide.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-03-22 05:06, Tony Lindgren wrote:
[...]
> I can't reproduce this on qemu-system-sparc64, probably as it does not use
> the sunsab driver.
> 
> I noticed something though, I think we need to test for the port device
> instead for being runtime PM enabled.
> 
> Can you please test if the updated patch below make things work again?

Yes, with the below patch applied on top of 6.8 things are working.

Thanks,
  Nick

> 8< -------------------
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -156,7 +156,7 @@ static void __uart_start(struct uart_state *state)
>  	 * enabled, serial_port_runtime_resume() calls start_tx() again
>  	 * after enabling the device.
>  	 */
> -	if (pm_runtime_active(&port_dev->dev))
> +	if (!pm_runtime_enabled(port->dev) || pm_runtime_active(&port_dev->dev))
>  		port->ops->start_tx(port);
>  	pm_runtime_mark_last_busy(&port_dev->dev);
>  	pm_runtime_put_autosuspend(&port_dev->dev)

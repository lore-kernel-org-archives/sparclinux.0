Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1490F567D
	for <sparclinux@vger.kernel.org>; Fri, 22 Mar 2024 06:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711089371; cv=none; b=Z18HyDaND6L4ywbad2f1/1rZkNN7B4+67EUVlp4/yZj33krxp5ZAD4K1fFg1nDFy3AuyOhWlP8rX/s5dK0p79jjXz+RX+oAQ4nQQtzpqkK058JCTMJHRkUBPxs6QpkxVMTx9LegJU5OYFv2dJ2rlDPCBAk3vpKwdqZeftC8t1S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711089371; c=relaxed/simple;
	bh=Yy2v2lCatp2/UK+Y5wd+nQJhtokBTEife0qtEPy4MZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z5OX5MHNIjqXu5k4bPG9PxJ18BaIbqbfbvxYl3FotUc0/mgiTAyTINf+PZRvZNpTxwyAsTf1ZUmXIDKlGjTIxIr8E0bHgdMdn94ZFwFBqw0s0fk8FDnPHn3rvzqdQtZYMo2REddL9jnmPw/RWRM+9D+9NF9KTwb8GgLJE/+wS+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca; spf=none smtp.mailfrom=draconx.ca; dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b=FMrs8lSj; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=draconx.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b="FMrs8lSj"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6917352b3f1so10071326d6.1
        for <sparclinux@vger.kernel.org>; Thu, 21 Mar 2024 23:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20230601.gappssmtp.com; s=20230601; t=1711089369; x=1711694169; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NaFfoW78A9EVG57HgkhXWh91V38WD1iQCj7Aj7G25XA=;
        b=FMrs8lSjLWbMByEoF/jA+F0RM0AcEBnkZJTTFlyQWjvclc8jdFsP03f/VA484Y/Wpl
         BK5PcIzw0cOgThORQCZfZ8dC3Rn9yUu+rShMVcgL3GM2Z+PGgT7mn/Yi2CuBB/9L76g/
         VId6e4CqAXyFGgbyZ+X+XiQAaqVXpW3VGEm4r3Zwwyzzl4mtacTEmDMMOS8zuuVK3kcG
         1mXnQcOYbTcAYqhtQrvEAkJxJdhDxwF4Me0N414+JSDPz2HFGf+U5dDFEkkQE0yiWSfQ
         8F5Yc0zoOF5Odj4fe5TN+IHDwiVkicjPA/IW5pcBEa7EXIihr5aHq525mynUzv4ZvwLg
         HhNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711089369; x=1711694169;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NaFfoW78A9EVG57HgkhXWh91V38WD1iQCj7Aj7G25XA=;
        b=hN4rF5mIXdTg36AtsE6ESl0vlFKJVQDXfMSibIjdCoQtZak46oJkBlL0SP03gpZS/3
         kf9T6vxq7lJMiWi5e7i8x9/3IAXxGfjvXZgdOmKKzX1PRJ6CYKAJxQKVj/W/fHmSHi5J
         cbaYmPCbVQjuvEn7JZeiZjtIv/1wRFkLn/D6B0DpuYqCqlpXLQMLlOS9qRBJHJ0RIZb0
         d2uU0O1iLlksiqJjzqS3n31UZYWn8YkOO6lnLDH8Dvsy4VSl9T8JlXircDHd7neTjYJr
         keg5mBah2Oq9w49GKed9Dg1iZsTCX/9l+EKRru6phepVCbefIipvk/daNR7x0NeIdC+w
         fneQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnygiDfvzTeCDpmPcvQjKu70ayh/PFf1fkUA5G8HSCOPbHPWBx3bEu5qsAkQ0f8EThmvqVqX9XChLfi5729e6y3emAFgIhJwjVyA==
X-Gm-Message-State: AOJu0YwJ/jwAMU0Q+ATHmJe9lpkHleLXu8Xer10+G2bm0UNUgwYByqrP
	W83wwUTzcz33U8f8caJlAyBL+5gmLEjhXy/jHfiwloxURBvDAv8cLDTGEiX12z8=
X-Google-Smtp-Source: AGHT+IF+JN3Bng2OpaUQIuC/DX2VCjkwGMkhxPOAM6wcBtN4i1DCa0fY96WGMslkHQ1PpW61tkGYPQ==
X-Received: by 2002:a05:6214:1bc9:b0:691:6311:eeff with SMTP id m9-20020a0562141bc900b006916311eeffmr1458488qvc.21.1711089369058;
        Thu, 21 Mar 2024 23:36:09 -0700 (PDT)
Received: from [192.168.0.51] (dhcp-24-53-241-2.cable.user.start.ca. [24.53.241.2])
        by smtp.gmail.com with ESMTPSA id gw2-20020a0562140f0200b00690cd39da04sm776784qvb.32.2024.03.21.23.36.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Mar 2024 23:36:08 -0700 (PDT)
Message-ID: <d7337014-09ac-8a35-7159-e75ecd2707b6@draconx.ca>
Date: Fri, 22 Mar 2024 02:36:07 -0400
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: PROBLEM: Sun Ultra 60 hangs on boot since Linux 6.8
Content-Language: en-US
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 regressions@lists.linux.dev, linux-serial@vger.kernel.org
References: <d84baa5d-a092-3647-8062-ed7081d329d4@draconx.ca>
 <20240322051531.GA5132@atomide.com>
From: Nick Bowler <nbowler@draconx.ca>
In-Reply-To: <20240322051531.GA5132@atomide.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-03-22 01:15, Tony Lindgren wrote:
> * Nick Bowler <nbowler@draconx.ca> [240322 04:29]:
>> I bisected to this commit:
>> 
>>   commit 45a3a8ef81291b63a2b50a1a145857dd9fc05e89
>>   Author: Tony Lindgren <tony@atomide.com>
>>   Date:   Mon Nov 13 10:07:53 2023 +0200
>>   
>>       serial: core: Revert checks for tx runtime PM state
>> 
>> Reverting this commit on top of Linux 6.8 is sufficient to get the
>> system booting again.
> 
> Thanks a lot for bisecting and reporting the issue.
> 
> Can you please test if the following change to add back the check for
> !pm_runtime_active() is enough to fix the issue?

I applied the below patch on top of 6.8 and unfortunately it does _not_
fix the problem (no obvious change in behaviour).

Thanks,
  Nick

> 8< -----------------------
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -156,7 +156,7 @@ static void __uart_start(struct uart_state *state)
>  	 * enabled, serial_port_runtime_resume() calls start_tx() again
>  	 * after enabling the device.
>  	 */
> -	if (pm_runtime_active(&port_dev->dev))
> +	if (!pm_runtime_enabled(&port_dev->dev) || pm_runtime_active(&port_dev->dev))
>  		port->ops->start_tx(port);
>  	pm_runtime_mark_last_busy(&port_dev->dev);
>  	pm_runtime_put_autosuspend(&port_dev->dev);

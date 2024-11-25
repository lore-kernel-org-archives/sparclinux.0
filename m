Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBCD1B87DB;
	Mon, 25 Nov 2024 17:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732557554; cv=none; b=LrFesfbo2geQ5En9J5XktLpfOiUEHRUtakS1bNH/Wj6eYTumGJXHsQXztGB730vLW0dLIsLSk3m4/hmLGtQrAvA+Bsd+qg0vORR23Z9DDGOGM4IrVuA4RVKMvotBV5/hgY0WqgmFvjYeGFkYvhe8H8fCWhKKFcHrwPvtl/K3RH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732557554; c=relaxed/simple;
	bh=iOyy8E/r6TpPnNmIgiOC3pPpZc6aAgM5vPI8OvvaIo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e1IqaKKZhHmCAtW8ewd95M7Ad9vVImNy+Dcqnf4EOo7soz8lSFNnIZ4EPoXzTJjmC2aKwF5lAxcfTwQ4z1N30uWKpmdaEZW5GPN435ElwyBHMaNNjZgOlKpxF2jT9ITPXqV35WiJqhwAPH8aMwZJr42zInjfpZet8BHq4uHPpZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HAC3RbZZ; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAC3RbZZ"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ea2bf25dc8so4017473a91.0;
        Mon, 25 Nov 2024 09:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732557552; x=1733162352; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=rsNI1mW/KPCqxvWt192M2VFUKGxVKxYNJJNsQGhoNvU=;
        b=HAC3RbZZzpaFMaSse9p1Pk1whdfZYuO866n5WJwfYxu/9xP8fGG/bfSjqEvA13je/h
         sY1XhMxGAUCSkc0itSetJ+y9dOBffhco3TLC0jXIhY15anCTe6RZ7m+Ap8wIk1lCVORg
         T390YWGNcRpy2I2WuS4DrSBlpUzJKhutHF1xSUA1STz7Ijwat0C1C50XzK0nFlr8G4QD
         70AQ9U/wE2wZu2qlZx+23wOaQauSJeQNStbRwSy4nq40aK/bRLXSOYQezAkV1EjYXl+9
         NlPRTOZ4Tz02r/3TzOA9cgVmywFW9rN2+iseeBesNWdOc4I7zfYtVLzADqjsTw2Ns7bU
         ePzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732557552; x=1733162352;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rsNI1mW/KPCqxvWt192M2VFUKGxVKxYNJJNsQGhoNvU=;
        b=nWE+lmnaMnangFc/jEHRHMfkq+r6qrY7NPcqpfN6vDPn7DELED4L3LCNfDTSpc+Fof
         FSb90bwqrkrTnWQCaDU7cc7rT3PGawkn/S0FG3pQjcz/dCEcMxyIVJoJriQVa3hW6nh9
         g2auuaB9S5bXKS2h+7U2bnN5STgQBUR4kCtcwY2CVqrjUquvZgQQFWABeJ4JzlLciEjG
         EjylDzmj3iKgQYVZEnzeIXhQz62XzF/Ghx3OgY6HHdlRL2eWuZZ/vLTcBbmzr6FIqgSv
         RSe3jF2U0GRspiFEv/YsWfVr8lc37MchbyecTTrpaLyqchskllYjjX5uKjo5twmvmGSn
         S7Yg==
X-Forwarded-Encrypted: i=1; AJvYcCUiEguM9FTkjnN65L6Oif3/0R3b2D10y3Xv/MGLPzmaUIWgAMDO4FuvueWzXqkLHF74Ddqw/MXO1L04BY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrJj6hIoZcmhvBALIHVOOSGTTTa2EsaXNEE8MYaW6zFqkimwLJ
	P2M7xCOQ0xeIr6FC8VhJBN0KsFLpxWe6RaVKIFtpfuuAhkbXbq/h
X-Gm-Gg: ASbGncuHIJRWLkEK4K20b0iwEtWCaAzwqMkp+kbmlCjrSPGVrzh19TaL8O3mnDH/lSR
	ks/wpIRpoy0eshVdu3W6joE4TqOg6UwH5WJJJ+ULBBYchvVu2nU3B8f1JTgb9pCvc2n7LTxmpap
	ulieAcc+gzP7x+/PXuRKpTuZQW8QwuIMvO64WD/0FzsQlx8O/9JHb2gu01rs/FCWdyUJSMK6K6p
	+8b7eFisFwGZdB0rDEWGzfvAsemYm5PpfEXaZHGxE3ipQUyaqx9V9aWyX2GN+iuuIuCADcW/QoW
	6nMPCrf6zbuHkdkRYLd/CH4=
X-Google-Smtp-Source: AGHT+IF43tPAQkBHF1Nb7Lm0QnxRfJsvobNeBhJZA6K6jXDGwLyDTO3k1h4vW+fOxxEVHNKnmvcDmA==
X-Received: by 2002:a17:90b:4c8e:b0:2ea:5054:6c48 with SMTP id 98e67ed59e1d1-2eb0e866094mr13701869a91.28.1732557551916;
        Mon, 25 Nov 2024 09:59:11 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2eb0d062828sm7008254a91.50.2024.11.25.09.59.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 09:59:10 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <c77c77d4-7f6e-450c-97d5-39dc50d81b1a@roeck-us.net>
Date: Mon, 25 Nov 2024 09:59:09 -0800
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sparc/pci: Make pci_poke_lock a raw_spinlock_t.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
 Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>
References: <20241009161041.1018375-1-bigeasy@linutronix.de>
 <20241009161041.1018375-2-bigeasy@linutronix.de>
 <7656395b-58fc-4874-a9f3-6d934e2ef7ee@roeck-us.net>
 <20241125085314.1iSDFulg@linutronix.de>
 <b776ca37-d51c-47e2-b3bb-aee8e7910630@roeck-us.net>
 <20241125174336.8nEhFXIw@linutronix.de>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20241125174336.8nEhFXIw@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/25/24 09:43, Sebastian Andrzej Siewior wrote:
> On 2024-11-25 09:01:33 [-0800], Guenter Roeck wrote:
>> Unfortunately it doesn't make a difference.
> 
> stunning. It looks like the exact same error message.
> 

I think it uses

#define spin_lock_irqsave(lock, flags)                          \
do {                                                            \
         raw_spin_lock_irqsave(spinlock_check(lock), flags);     \
} while (0)

from include/linux/spinlock.h, meaning your patch doesn't really make a difference.

>> [    1.050499] =============================
>> [    1.050801] [ BUG: Invalid wait context ]
>> [    1.051200] 6.12.0+ #1 Not tainted
>> [    1.051571] -----------------------------
>> [    1.051875] swapper/0/1 is trying to lock:
>> [    1.052201] 0000000001b694c8 (pci_poke_lock){....}-{3:3}, at: pci_config_read16+0x8/0x80
>> [    1.052994] other info that might help us debug this:
>> [    1.053331] context-{5:5}
>> [    1.053641] 2 locks held by swapper/0/1:
>> [    1.053959]  #0: fffff800042b50f8 (&dev->mutex){....}-{4:4}, at: __driver_attach+0x80/0x160
>> [    1.054388]  #1: 0000000001d29078 (pci_lock){....}-{2:2}, at: pci_bus_read_config_word+0x18/0x80
>> [    1.054793] stack backtrace:
>> [    1.055171] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.0+ #1
>> [    1.055632] Call Trace:
>> [    1.055985] [<00000000004e31d0>] __lock_acquire+0xa50/0x3160
>> [    1.056329] [<00000000004e63e8>] lock_acquire+0xe8/0x340
>> [    1.056645] [<00000000010f0dfc>] _raw_spin_lock_irqsave+0x3c/0x80
>> [    1.056966] [<0000000000443828>] pci_config_read16+0x8/0x80
>> [    1.057278] [<000000000044442c>] sun4u_read_pci_cfg+0x12c/0x1a0
>> [    1.057593] [<0000000000b7657c>] pci_bus_read_config_word+0x3c/0x80
>> [    1.057913] [<0000000000b7fa78>] pci_find_capability+0x18/0xa0
>> [    1.058228] [<0000000000b794b0>] set_pcie_port_type+0x10/0x160
>> [    1.058543] [<0000000000442a98>] pci_of_scan_bus+0x158/0xb00
>> [    1.058854] [<00000000010c74a0>] pci_scan_one_pbm+0xd0/0xf8
>> [    1.059167] [<0000000000446174>] sabre_probe+0x1f4/0x5c0
>> [    1.059476] [<0000000000c13a48>] platform_probe+0x28/0x80
>> [    1.059785] [<0000000000c11158>] really_probe+0xb8/0x340
>> [    1.060098] [<0000000000c11584>] driver_probe_device+0x24/0xe0
>> [    1.060413] [<0000000000c117ac>] __driver_attach+0x8c/0x160
>> [    1.060728] [<0000000000c0ef54>] bus_for_each_dev+0x54/0xc0
>>
>> The original call trace also included _raw_spin_lock_irqsave(), and
>> I don't have CONFIG_PREEMPT_RT enabled in my sparc64 builds to start with.
> 
> You don't have to. "CONFIG_PROVE_RAW_LOCK_NESTING" looks if you try to
> acquire raw_spinlock_t -> spinlock_t. Which it did before I made the
> patch.
> The pci_lock is from drivers/pci/access.c and is defined as
> raw_spinlock_t. And I made pci_poke_lock of the same time. But debug
> says 3:3 which suggests LD_WAIT_CONFIG. (No patch applied).
> 
>> FWIW, I don't understand the value of
>> 	pr_warn("context-{%d:%d}\n", curr_inner, curr_inner);
>> Why print curr_inner twice ?
> 
> The syntax was once (or is) inner:outer. If you look from the top, you
> have 4 (mutex_t) followed pci_lock (the raw_spinlock_t) 2. You are at
> level 2 now and try to acquire spin_lock_t (3).
> 

How does that explain the
	context-{5:5}
which is created from the following ?
	pr_warn("context-{%d:%d}\n", curr_inner, curr_inner);

Again, why print curr_inner twice ?

Thanks,
Guenter


Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C7F2500CC;
	Mon, 25 Nov 2024 20:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732565208; cv=none; b=lRPPto5ovSitVL2Nk1ylwKTfUn+J+qT1J0/tmZi1B5CHCSlRyGGikwm167bBEuLmE4cIfGrKf43/CCRoh8usO5tp+A4l/bTzQxv48LksZOTvAyGKKDhn75KneP2Z8IPXG/mT2d9iSSU/PMRwIIHIX1mkkinGoMDmkvVK0nOqHBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732565208; c=relaxed/simple;
	bh=xO8/n5I1makF+/m6Ubg19xuUU08mpaPHwssZh3eters=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EjSQiG5uK97pC7QGVM0g8nhVxZesU2yVcKMRZAnnW113uvJXZqya9FehOAL+/kkcHd6Em8a8AMgv/PZ4Gm7XOJXRmEuoDSL9YB0aKvrKqPwoWgnOjIPhlHeDMDOCPIWCi+ka1sR2Op9mpEUuZrKKDabmjc9ctUL8/JtjZ1ROfQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RenaFjWD; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RenaFjWD"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7250844b0ecso1418680b3a.1;
        Mon, 25 Nov 2024 12:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732565206; x=1733170006; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=hT3VueR9YC6tH8dQM2yskgrGy4zQ2cI7Yv0S2daE2i0=;
        b=RenaFjWDPFzKqTIk/iyYcd4GWrIyefpbsqBgBvkyC5/97ctrEleejTY1NO6PIDDG7L
         eKNLabaxsdNx93LfUyo0sfaVkkE73jK8+VirD7e1/uJm1/1bHmghdx5QL2XMbhU9PhBa
         7C2Vqiy7GjFzol+Zhheq7k26N1o9J+2RC6N3wuKigjN78UkChFKfE3B0AEK8+VF0ey/w
         MZO/+TC7mm4zW8RQqGImpcYLv77tAjirFwU62DHErELxpiEWOwGAmdsLiy5b/vAygBqs
         XlMZyqV3KUOOk+L9saSBAfUEk0RuGI0RxYUNd4SCsnkpER6kDwiPxwSkM4DKOynnWf2J
         D/jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732565206; x=1733170006;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hT3VueR9YC6tH8dQM2yskgrGy4zQ2cI7Yv0S2daE2i0=;
        b=PZg24MiY7WKaPPQV7HxJ6yGPSwhuLdwyo7SiUNX8oDe61LuAHgrCR11gCuTODdv0TL
         056e8wMDYWVaoqCe8N8M0xWOLI1SFgfUPxODjYARmks89qJOIOykGICPXTW+SfaVT9rS
         e555mNxKMOtOyr4G9K0beFGYQ8Owmnk9szdhNF8vIDXrxg2YG2pZKExUKS1G3ca6+ZjO
         gaoSoeoEO0bW5637XXF4/5hjM8NU/faCGxbZ8tRiuP0QaxtuSy8vbwrGiJiJp7vnoWZy
         I7yM5D1LB4i4ShFoL23H37s2rZHROpfENM7hhwb0ai1KwNd8ceV6h/vtaF93oXtHTX7O
         Vx3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUammAdW3j75Bad8h40cpSgjdMgVh/NoJ/NjNXpsy5IxFhzeitMlTRDNkso/Z/XP578Kab/s5Kdbaoz8CY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyuh9YIxJ7BxGrkGCxxeYWSkYl7PoIbqdPmdXiFY5BoglZgU0gk
	KJllGiKpHXcgca8t/ShFD9G2kKSitnz57/piudiaXyEB31Zvzy8y
X-Gm-Gg: ASbGncsCchodKSM6UnOCG5pHWE4vPhAGodcykeJYiI2zPnF1VdXATHqNVP7fePbbuuS
	SBLHopfDmp+9x2h2dc4TTy0+aSFNZW7lbHhQpxJ1dmmojNzGIZ6exzPCNknRZ4i0DdRf+byNCI3
	d+gaOihG/SDukupDiKzcrAsEhlsF6GA6tkslQACnx9EifximqA9Ldc9ovN/3bXqH4Lm4kMzbwJS
	/XyyX6Lm95dv1doNvN5Tyq2JWnKYJ4Nos6pMayt00qkmcVVDb7I5Eth3AI42SPve13qxtNWpIV3
	v8eLm09/mH4FyS/948xPzJA=
X-Google-Smtp-Source: AGHT+IElMKsLM5i0CmArQ+PDj7y2vGH9WQDr/5qzmvZ/oyGtYCX8Sg0r6RmpQ2pMWP1h38Pa5J3/eA==
X-Received: by 2002:aa7:88cb:0:b0:71d:f821:1981 with SMTP id d2e1a72fcca58-724df3c8232mr19013143b3a.4.1732565205643;
        Mon, 25 Nov 2024 12:06:45 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de532d59sm6814417b3a.130.2024.11.25.12.06.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 12:06:44 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <dea92bd5-65e5-4c5c-bc93-5bef547c935e@roeck-us.net>
Date: Mon, 25 Nov 2024 12:06:43 -0800
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sparc/pci: Make pci_poke_lock a raw_spinlock_t.
To: Waiman Long <llong@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
 Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>
References: <20241009161041.1018375-1-bigeasy@linutronix.de>
 <20241009161041.1018375-2-bigeasy@linutronix.de>
 <7656395b-58fc-4874-a9f3-6d934e2ef7ee@roeck-us.net>
 <20241125085314.1iSDFulg@linutronix.de>
 <b776ca37-d51c-47e2-b3bb-aee8e7910630@roeck-us.net>
 <20241125174336.8nEhFXIw@linutronix.de>
 <c77c77d4-7f6e-450c-97d5-39dc50d81b1a@roeck-us.net>
 <20241125181231.XpOsxxHx@linutronix.de>
 <72991b83-173e-492e-a4aa-5049304c1bd0@roeck-us.net>
 <5d269249-afd1-44f5-8faf-9ac11d9a3beb@redhat.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <5d269249-afd1-44f5-8faf-9ac11d9a3beb@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/25/24 11:33, Waiman Long wrote:
[ ... ]
>> Fixing that finally gives me a clean run. Nevertheless, that makes me wonder:
>> Should I just disable CONFIG_PROVE_RAW_LOCK_NESTING for sparc runtime tests ?
> 
> If no one is tryng to ever enable PREEMPT_RT on SPARC, I suppose you could disable CONFIG_PROVE_RAW_LOCK_NESTING to avoid the trouble.
> 

SGTM. I'll do that unless someone gives me a good reason to keep it enabled.

Thanks,
Guenter


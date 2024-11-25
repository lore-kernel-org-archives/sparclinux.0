Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707121474DA;
	Mon, 25 Nov 2024 20:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732566189; cv=none; b=coOpriTEVuv2/njtQtF6aBxy7MAmXL7gIHNwHm5wMgmZ/DI3Ngr2IwhNsgNNvn3pfSvFwXYmfR156iZUhWRbik4BPtk4f6l3OULt8SJocVGXi308kIezWCQ2uyWjnUbe+BDg3JCOq5o03vjpuXcWH+1KMc7IrbRs4Ed1XLouoa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732566189; c=relaxed/simple;
	bh=ZRYqODKzRb4zw50DK3MsXFr/FUCDUq7kiom5USJOtSs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=aq4MfiMeKsYy9xNiAv5OJlMrT4ZC2E+ySF1PeuhMrcGlZ+TdyNy+X3rhA5f0fFFxTVl9MnIDDWB/Krcrj1JVIcEzT2RQO7AfHxjQC1dIMmgIPIXbNAJwgQErzBR4l4HsrnGmJaiVP7colY1HVcHU/mO3UKTK7GBR2DQZWL1IJDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DdiTGRwh; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DdiTGRwh"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2edb222a786so1616105a91.1;
        Mon, 25 Nov 2024 12:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732566186; x=1733170986; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=H0Z+Q2anBrkHM1gdrQsft0OWrewR29CM75Kg6KLZI5c=;
        b=DdiTGRwhyb8hu0DSqOIGy6SWaDOPw+lWvVZDd8Z/6v4lVpw2qtYkOcpSVOo4ayvThD
         5vZADb80ZRk04WzyFx8vbqLy+4JPLAHwEDR+/75VoNQE7sLr0CChy0XWlLNuI3ITghsM
         pfn9wmU9wg7I/GP2l5lDeVsyttywBhFgjpBlR9CczddCnB4AegOh9JDD065bHnq2pY0J
         5G0NJeZHk2PwdjoRnOlG6rpU1Rm7J0jsJ69+lo5LEpIxGNIqzPClok0aSglMdoE4irdJ
         8KAnfKEOzIgG9C0zhakHkuZj4G6kGlsUMwQi+8YPpkKcfSE2VfwTMyRKbrIwvuRtp9b5
         4wGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732566186; x=1733170986;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H0Z+Q2anBrkHM1gdrQsft0OWrewR29CM75Kg6KLZI5c=;
        b=ZPkWQ2zPY4kJ7+LdtLi+tOyhPw6U/51ERGDg+h/fZ9iMnZCNPqZuowrdZoLN2LCVTP
         7FNKUajvFmLPSxoVt0I8iE1oxBPXp1GS7FvAXWgiojU7jta6B5GQjkKULArPaoG5910b
         jvRwCoj8mXRz65S28bDWbp3h4f9jOZmXztSsI3j7xTE/MV4B0+R4TgumL6BF2blafXp/
         4Eb878VHLITz4RS5sdR4UpeHcYtnwgAar9KJo2oGg4A5/IU/XuoBVJx89clcLzhCbMe2
         SqXUFWdDsSQDP5wEnlYhLOcXbtAYV9QGGK2rmOnTpWtRuShAV1XnOeOVg5sgpy9FV80W
         UNlg==
X-Forwarded-Encrypted: i=1; AJvYcCWBmN0tUvcWRWYlAQU5dp18nilFjwK0PFWuE8P5BWoQf5v71Bky0dHQYi6QQgtQT1INV1F+W1G+sO9KM4M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0SJP1EavcH1WnjPQ4hbG65eMipSNt6GiYJ1ao1KaJiCNQbY9/
	Bb7lVnqvAlpk3T5+Q0lRp5P5mNKMKAEfG3DskR3u+EqtGpdMLTkL
X-Gm-Gg: ASbGncsAroFWwgVXkvVh88Z922hn8Gz1nPSdDeUvMSOrxxT5Y/zjADNLxtp0yuyzDGk
	nySXwBCni1kQoDplN+xWXRyQAvpyTIJkZGOk9SIbMiG7ZHeeI1RrKm8cwBOlFH4BUlvpbURu0s4
	46v73oXm9mSgma6r5nvcFFv4UI9ZPn59QOmNa0UJk3Zqr2T34e2rLOMKg9QMtG74DoGlAG6fo2m
	qpsmBn1/jsVjNU/XdKFFIK2h5EYMoM1k42EtNaycmc3nBnqk/H0pU3zoTMs/IANULqx3a7ulby+
	jL/Tw4PjWE4NMuFv8XF7lDw=
X-Google-Smtp-Source: AGHT+IG2Dz0bh6oiAEKeBRS83SYmKEoShg6u17SIjS+NzepOZPuBzVROZQodWfoGLjl8B1vf1VMbaA==
X-Received: by 2002:a17:90b:1a8f:b0:2ea:2906:a6e8 with SMTP id 98e67ed59e1d1-2eb0e867d3amr17039939a91.37.1732566186595;
        Mon, 25 Nov 2024 12:23:06 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2eb0d048b3csm7177677a91.34.2024.11.25.12.23.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 12:23:06 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <2a940822-b4d4-43ea-b4f7-4294043b76ea@roeck-us.net>
Date: Mon, 25 Nov 2024 12:23:04 -0800
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sparc/pci: Make pci_poke_lock a raw_spinlock_t.
From: Guenter Roeck <linux@roeck-us.net>
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
 <dea92bd5-65e5-4c5c-bc93-5bef547c935e@roeck-us.net>
Content-Language: en-US
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <dea92bd5-65e5-4c5c-bc93-5bef547c935e@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/25/24 12:06, Guenter Roeck wrote:
> On 11/25/24 11:33, Waiman Long wrote:
> [ ... ]
>>> Fixing that finally gives me a clean run. Nevertheless, that makes me wonder:
>>> Should I just disable CONFIG_PROVE_RAW_LOCK_NESTING for sparc runtime tests ?
>>
>> If no one is tryng to ever enable PREEMPT_RT on SPARC, I suppose you could disable CONFIG_PROVE_RAW_LOCK_NESTING to avoid the trouble.
>>
> 
> SGTM. I'll do that unless someone gives me a good reason to keep it enabled.
> 

Actually it can not be disabled with a configuration flag. It is
automatically enabled. I'll have to disable PROVE_LOCKING to disable it.

config PROVE_RAW_LOCK_NESTING
         bool					<---- no longer user configurable
         depends on PROVE_LOCKING
         default y
         help
          Enable the raw_spinlock vs. spinlock nesting checks which ensure
          that the lock nesting rules for PREEMPT_RT enabled kernels are
          not violated.

I don't really like that, and I don't understand the logic behind it,
but it is what it is.

FWIW, the description of commit 560af5dc839 is misleading. It says "Enable
PROVE_RAW_LOCK_NESTING _by default_" (emphasis mine). That is not what the
commit does. It force-enables PROVE_RAW_LOCK_NESTING if PROVE_LOCKING is
enabled. It is all or nothing.

Guenter


Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E9518E359;
	Mon, 25 Nov 2024 21:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732569907; cv=none; b=mqGXRgUAdycRJd2ezVC8rB37IMoQwnDvY36GVugi5XPx6GJPOvtCYHOzOs1Nt7EW7iJxl9zjzxeoeoktlifdSpaHadhqdSY3vH7hhzXsZyLISXl8fGLl5+Z5B6+XsGBrW2UNqLVeaUgqgoJk3NfoMiFRdpIkG4N+JkizCdZviGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732569907; c=relaxed/simple;
	bh=4848Q5qkWqEb70fQE34W69OgPLMdpL8hE5v/Ar4VtA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LQ+gg1MCIzb5AXA7hoZk9oOpx9Vt7pySON++7hGYp/QT6DLlpawQob2DL5saBHnngtynf5n2PVFZVseTkae5f17gkE02obzxIf8LYQgu42s0ZmDCvguUAuAn7VJtu14qua5mzh3c05pAivgXoeW7NKbkXvArQ9RbgR6aucbI9Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lclt7VWy; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lclt7VWy"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-724f0f6300aso3050704b3a.2;
        Mon, 25 Nov 2024 13:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732569905; x=1733174705; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Gqa+Ia1mupTcZQ+kmVz0wGSy22sBAI+jlh/ndLAYvgo=;
        b=Lclt7VWy8+ZKBXaNTNxztLZx1Dibjhri2qXBCft9G7HzDkvptXGxbjkC/H8QCrtY1S
         m0jUbkFlWIyQpPR7fYPphqnwsv9hB1GwOnPfJbdoQu87qHKDcrvgPBQZxnKSxojMTP42
         l3raL54x0lyT0A/z6a9hXCugl1Q9UAxouRr/8tf1FLbLUZxLEoSGwzeyuM5IK15gbrBa
         hV2EtiQKHmmQHVu5gAC9QV9QvhRa8rsct0V9z9RgE7Xl1f+cvYGJ5qI71Ca1QT01BjVx
         oqbwGa5X13Jj1EFotM9DCJJZgaiDGfoN8V8APD/w3kH1tZ4jG/1hSdXuQTWJ+RpQ3MYn
         krJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732569905; x=1733174705;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gqa+Ia1mupTcZQ+kmVz0wGSy22sBAI+jlh/ndLAYvgo=;
        b=KYdqnjeAXWcH2zvmEKsfYs85us21Zpmk2ngth/IG1+VPHk5FMexN1fs7ZeyX6dqoZx
         4TIrhFRJoXORVgT53fpV4tqTnJH2BtOGRqqpmyNr17def94A4le1Cd/E7im2djyhkzIa
         OW9VR240TrB86XI6jbFVIiMmP0bZcUx+UOmqRkq+U0poGavB+kE8l5HVuqCBSrPaNbEF
         q20Zqfe/Dbe1B/WhMyXwz7ixFZ+BPDcVkVfX6Ib2ukI7gwgbvquabH13w6m64FlCy20i
         Gk1UuN4Rx0qF7XEehbt7zAaVKW3GV4r6SA7oqvV5IcZYrCWG5Tgqvcc+8W5DwjegjiQe
         0xfQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5sNkwZNDD+r3q2Bzca/fX9OF2Rdu/Um++/AyGZe2L9Kami8HxnTeLV9+xFjcb7QBUiCkgiZ2FFoX1T48=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFAEYUJELuKo68ubVRxg8i86M2eYCQFiFnbGjOvrzJxFmsJ7jm
	5GmmWyr/gV0awrl+pPdCa8zS69+bQivNNFlXTu3GZeuDXk+eZehPCvzMBQ==
X-Gm-Gg: ASbGncvB2DUPT59oKst+9/A8I1IeMJFWb3RuXJrNvyU/v5qBqLhrSLef71oy0w7QGZU
	xd/zh/Eq6yphKwycs9O5n82kxfDrPX5irjDTtrQ1BOlWvb7E44XQ4h4PFMwjRhcFQGYa+crpkqX
	a+ICRDN/fUDhY7YgyUR+uUn1eY3TmY7N83nopiuLJ5UOX3wg1MTKkG2RCZ1qxXLRWx/oJkjyUep
	IvZsRszD7ZQ69wbYBQhtVsN6ymAtaDEtBw9dVSiWj9I1ErJI7EvXsg66CCq+NcG1Lc/M5dBc6eS
	fomKpA/PYdkzezZkwTbRfqE=
X-Google-Smtp-Source: AGHT+IE51FD7RRx4sae+u+MEQdt5JrBBZjgFH3fbr5jAosQ5XhN8Ntpr/bI9WMCWMX5U1R5OW10IMA==
X-Received: by 2002:a05:6a00:9aa:b0:724:ea15:fc7a with SMTP id d2e1a72fcca58-724ea16268fmr15706577b3a.16.1732569904603;
        Mon, 25 Nov 2024 13:25:04 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de554fd6sm6888339b3a.139.2024.11.25.13.25.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 13:25:03 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b0e13a75-d068-4ad3-b0d7-4834ccec3d5a@roeck-us.net>
Date: Mon, 25 Nov 2024 13:25:02 -0800
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
 <dea92bd5-65e5-4c5c-bc93-5bef547c935e@roeck-us.net>
 <2a940822-b4d4-43ea-b4f7-4294043b76ea@roeck-us.net>
 <88f47cea-baba-4673-9bd7-7b7c3f421008@redhat.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <88f47cea-baba-4673-9bd7-7b7c3f421008@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/25/24 12:54, Waiman Long wrote:
> 
> On 11/25/24 3:23 PM, Guenter Roeck wrote:
>> On 11/25/24 12:06, Guenter Roeck wrote:
>>> On 11/25/24 11:33, Waiman Long wrote:
>>> [ ... ]
>>>>> Fixing that finally gives me a clean run. Nevertheless, that makes me wonder:
>>>>> Should I just disable CONFIG_PROVE_RAW_LOCK_NESTING for sparc runtime tests ?
>>>>
>>>> If no one is tryng to ever enable PREEMPT_RT on SPARC, I suppose you could disable CONFIG_PROVE_RAW_LOCK_NESTING to avoid the trouble.
>>>>
>>>
>>> SGTM. I'll do that unless someone gives me a good reason to keep it enabled.
>>>
>>
>> Actually it can not be disabled with a configuration flag. It is
>> automatically enabled. I'll have to disable PROVE_LOCKING to disable it.
>>
>> config PROVE_RAW_LOCK_NESTING
>>         bool                    <---- no longer user configurable
>>         depends on PROVE_LOCKING
>>         default y
>>         help
>>          Enable the raw_spinlock vs. spinlock nesting checks which ensure
>>          that the lock nesting rules for PREEMPT_RT enabled kernels are
>>          not violated.
>>
>> I don't really like that, and I don't understand the logic behind it,
>> but it is what it is.
>>
>> FWIW, the description of commit 560af5dc839 is misleading. It says "Enable
>> PROVE_RAW_LOCK_NESTING _by default_" (emphasis mine). That is not what the
>> commit does. It force-enables PROVE_RAW_LOCK_NESTING if PROVE_LOCKING is
>> enabled. It is all or nothing.
>>
> I think we can relax it by
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 5d9eca035d47..bfdbd3fa2d29 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1399,7 +1399,7 @@ config PROVE_LOCKING
>   config PROVE_RAW_LOCK_NESTING
>          bool
>          depends on PROVE_LOCKING
> -       default y
> +       default y if ARCH_SUPPORTS_RT
>          help
>           Enable the raw_spinlock vs. spinlock nesting checks which ensure
>           that the lock nesting rules for PREEMPT_RT enabled kernels are
> 
> Sebastian, what do you think?
> 

	depends on PROVE_LOCKING && ARCH_SUPPORTS_RT

seems to make more sense to me.

Guenter


Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913AD14F9CF;
	Mon, 25 Nov 2024 21:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732571661; cv=none; b=rFFTtN2Mj3zUpb0wRmdKSZWbnQlycUUP6A1AWalGDbs6gQZgPfkHeni0C1NVx9uOOH2E6f+WEqDx7b7uWgbg6pNa2SAHv56Yigm4ZpfglGyrpgLK5J8XkB1rjKpHGg00RfuOL6x1h9tXRIZYfVyxk+K3ppkNl6K7zxTcU8EpxUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732571661; c=relaxed/simple;
	bh=vQghFPwOakL2/S9yKhI5LNstgvG4wXUhh2VsFjSH7VQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T5cblt6XtYcm0yGW/uuvtQ59hPbGUOxAV0qvCbH6ea+7D1s+C5vNbRqfGxvrfMdzcW2qOiiWy3FUt2Jfa1sBKCgrIx9lk+RtllfZ6gmy/DnpDUa6VjHKXaBCgOw9NhP223J7tgCvAWN/g4rSSPndvacR30jxb4E9NAJz75UIS2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P25+7WEG; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P25+7WEG"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7fc2b84bc60so1232781a12.1;
        Mon, 25 Nov 2024 13:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732571657; x=1733176457; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=hzuzKr0ugYKRDB8J/LsU5oEu9Dne18LdLC3faV0ov8s=;
        b=P25+7WEGO1zjmAkDHdqnFX5BYqgrZfv9tC7l704H1ndR1SFw44mtNCPpF0R9dOSrzf
         t+VZ87MRzTOLzglY8zIMRuNPbBkiGndarlhoCPu7yT5wXMBsj5hfCuDVz9Buj6MeNfr5
         wck4/grHdICf3mwVTnzWVwlnd8gaTEUsh+05uh99NrDIXnlG7GfJ108ObzlliYdX762D
         s7F6QzU6Ukj2M/nUZMfpJGZ7KanWfFlGDXtiLdZzMDfF0kjUdHJ8+fmIyGUKD4mVg+cG
         HHP/402r3Fr8ps71SlxcGGEHSaV3NDl7IXmiHnWInT9Ld+KbXTnKNbP4yc+51vARgIt/
         eGdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732571657; x=1733176457;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hzuzKr0ugYKRDB8J/LsU5oEu9Dne18LdLC3faV0ov8s=;
        b=twxrBq8p6dDS/kJNOL5w5urpkWckdZCVvXnn6n6jth4yydWJJXuWVingZAXtgMQGRG
         QIIOAD2Yl+YxZ8ijB6WaRL/kZyA04VQeXW1gTkgLksNyel+Twcp3K4xEonpqIt6EUcPc
         hBmm5cfhb7tF6Xje3BKYHcXE8RhW25gaaq2PnMfAh+j31jNn4QJiqSC5tNOL9khbj2L/
         r6ALFDecdJ4NQgVRbm4EOvj4LEN9Bi+tlU49BbyR1sEnxT6DjHAxhu9q5NB/DzvFmFEQ
         Zfy7y9Hc5zu6YJpmE6B+Qon/1gnnjYPgtdgYC08neJJ18bJDlN8Shbf+SMLyXw+ScWHV
         Kbvw==
X-Forwarded-Encrypted: i=1; AJvYcCWBs20b2NfvhYrR18H4DtCx+qiP0LvyxyO7Sa4CC6ME20Xge8ErUuZIO1zAcjUwOk7Qw9GosjjxniMtpyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL5GKgngsDlxsMVlpgLjV3qKzmkCHDMPXHhWJRzoOTtiMtuaIo
	Ve7EVzTurXgBm4ktinZ9uJcWw6nHecIy/Mzy6lSupGTC3myE0qJ/
X-Gm-Gg: ASbGncv77aZS1j5kyIccxKgTfqOhFobuX3d1vevpB5TEWH+CcRC2pcqhc1XQYJXom/n
	jLu8cv+Z9NBJFfo9t/Oc9t+0IGo74FtqUn/rto9fxeeDEkRIl3rsJMeQqIm99+Vlro/HTRrFIRD
	JdNF0zpJ2cCGmPHE7h4Ll0CiOy9J1EwgelAYeGSGx0+mNMBaYHaO52zs52oD73ttP23iVLYF5AQ
	2woPCIWtNhqZVeCiH73StN7oZ+RgoiGnRSY1BCtTnyvMN5WvEIkQloLNVYl/zmFvA9KIqzHxKPX
	Lrew7yWFwvJ/v/dHWnmTe50=
X-Google-Smtp-Source: AGHT+IED+C0OafQQHk6o0bu2TwES7zCK/XISrURigwdFInd0r+eErQQ6zCJzyDEZiFhCRJEIWrw/wQ==
X-Received: by 2002:a17:90b:38ca:b0:2ea:3f34:f194 with SMTP id 98e67ed59e1d1-2eb0e233a0bmr17955627a91.10.1732571656766;
        Mon, 25 Nov 2024 13:54:16 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ead02ea3ddsm10829257a91.3.2024.11.25.13.54.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 13:54:15 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <55e2fcb8-dd06-42e4-b5de-4a0b46057571@roeck-us.net>
Date: Mon, 25 Nov 2024 13:54:14 -0800
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
 <b0e13a75-d068-4ad3-b0d7-4834ccec3d5a@roeck-us.net>
 <42effdc0-bfe7-49a5-a872-21a6f665fff3@redhat.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <42effdc0-bfe7-49a5-a872-21a6f665fff3@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/25/24 13:29, Waiman Long wrote:
> 
> On 11/25/24 4:25 PM, Guenter Roeck wrote:
>> On 11/25/24 12:54, Waiman Long wrote:
>>>
>>> On 11/25/24 3:23 PM, Guenter Roeck wrote:
>>>> On 11/25/24 12:06, Guenter Roeck wrote:
>>>>> On 11/25/24 11:33, Waiman Long wrote:
>>>>> [ ... ]
>>>>>>> Fixing that finally gives me a clean run. Nevertheless, that makes me wonder:
>>>>>>> Should I just disable CONFIG_PROVE_RAW_LOCK_NESTING for sparc runtime tests ?
>>>>>>
>>>>>> If no one is tryng to ever enable PREEMPT_RT on SPARC, I suppose you could disable CONFIG_PROVE_RAW_LOCK_NESTING to avoid the trouble.
>>>>>>
>>>>>
>>>>> SGTM. I'll do that unless someone gives me a good reason to keep it enabled.
>>>>>
>>>>
>>>> Actually it can not be disabled with a configuration flag. It is
>>>> automatically enabled. I'll have to disable PROVE_LOCKING to disable it.
>>>>
>>>> config PROVE_RAW_LOCK_NESTING
>>>>         bool                    <---- no longer user configurable
>>>>         depends on PROVE_LOCKING
>>>>         default y
>>>>         help
>>>>          Enable the raw_spinlock vs. spinlock nesting checks which ensure
>>>>          that the lock nesting rules for PREEMPT_RT enabled kernels are
>>>>          not violated.
>>>>
>>>> I don't really like that, and I don't understand the logic behind it,
>>>> but it is what it is.
>>>>
>>>> FWIW, the description of commit 560af5dc839 is misleading. It says "Enable
>>>> PROVE_RAW_LOCK_NESTING _by default_" (emphasis mine). That is not what the
>>>> commit does. It force-enables PROVE_RAW_LOCK_NESTING if PROVE_LOCKING is
>>>> enabled. It is all or nothing.
>>>>
>>> I think we can relax it by
>>>
>>> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
>>> index 5d9eca035d47..bfdbd3fa2d29 100644
>>> --- a/lib/Kconfig.debug
>>> +++ b/lib/Kconfig.debug
>>> @@ -1399,7 +1399,7 @@ config PROVE_LOCKING
>>>   config PROVE_RAW_LOCK_NESTING
>>>          bool
>>>          depends on PROVE_LOCKING
>>> -       default y
>>> +       default y if ARCH_SUPPORTS_RT
>>>          help
>>>           Enable the raw_spinlock vs. spinlock nesting checks which ensure
>>>           that the lock nesting rules for PREEMPT_RT enabled kernels are
>>>
>>> Sebastian, what do you think?
>>>
>>
>>     depends on PROVE_LOCKING && ARCH_SUPPORTS_RT
>>
>> seems to make more sense to me.
> 
> That will work too, but that will enforce that arches with no ARCH_SUPPORTS_RT will not be able to enable PROVE_RAW_LOCK_NESTING even if people want to try it out.
> 

No architecture will be able to enable anything because "bool" has no
string associated with it. As mentioned before, it is all or nothing.
Otherwise I could just configure "CONFIG_PROVE_RAW_LOCK_NESTING=n"
for sparc and be done.

Guenter


Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A54C1B86CC;
	Mon, 25 Nov 2024 19:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732562603; cv=none; b=nKEHARrnYkqbF7vfbJqUL0xINWkfKbA2yC4g2k+n9/bv/c1kbb5sLUIrudxFmFv0+bcHLbowMAcvD+ijnBuajJI/0w6/A1lk1zRs6YZsI7bHtDiZ1ujm24JinutGRpaE/A0/xX2WvyIO7Yf5SJT7slK5b+RXT4+Yfy1eSA5fogE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732562603; c=relaxed/simple;
	bh=uD3VVH5IFBkk9PNr4IfFqS2jXB7+BeEdSpayqPxcjEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Itanf7M3EO0Gs86JRBvZhCbubZSMV3a3AjH05cqOZ3aY/VC6khr0W3VqvX4cdukwFzFTiPPva4qzBK7W7SmVptdfGpXcVqZd8KDA2LQ7Bqy9pmUhETwXNQMhR4QkSWdhI1QNiErkNszV3DJ9GHEZAH/J2Cwwg4HaswSSmz74Kd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kMjN0+xN; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMjN0+xN"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7e6d04f74faso3371947a12.1;
        Mon, 25 Nov 2024 11:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732562601; x=1733167401; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=MHY2iHAQXEJzX8CnVChA63hkESjHb9bSUAORyU0PDi8=;
        b=kMjN0+xNMMR/IMjn5Or+lbYgwTbTsaLP1M66C7OS9qe0mvmisUXFKB9joqH3gp1ZcA
         3clJVjPu06qwT4IDj5dkbC7k/d1N+dDjB56ijb8VTkaLQiiNzd51B8zFEy8JjPSNtylK
         DkAdH/gPPR32aYnacWXzUNbr6Ekl4F+EBMinba326rgnBOAVZilTson6Bh+Kdvm70Wfb
         nWO8+bTVo3vg6QmRKNeItCduzCSfRMH3iCo4eQOQ2wnknuHISsIDrK+EOGSUcLXIGZC+
         v2qJA52Uo5LgUbDLJD+9js0JN5u4a5AxPC/6/M77O00gNN4U0N69AY340X98c3shgGBK
         bTGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732562601; x=1733167401;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MHY2iHAQXEJzX8CnVChA63hkESjHb9bSUAORyU0PDi8=;
        b=PIXA6isU3+xMO5kHYYJtY7I2YfqbW2u+iJQ+Q5uQzAm2ZOs2G8/gYUe1ckcJA1vY1x
         etdvlu/jLogp2FkxBci5OG5iPtM5aPGXRCzygl/ljoHxjkAn5TtXIu29T1WfXQVqbWQF
         G/PrzAmlT1poot+hEMpRVyZwqColK/03NNu+R7bPfps5HBvO2ucd+gTJ3oJok3jX7dfg
         OjERriglQxJ5XOsTFj+wK4WEdoI3dXsq0pGRKUYpqS7HRCPFESCWRS7LvWHtl4FDUjS6
         jS9iqu6yKzl9j6I6qVVymZFsUcoLLdrWDlRw7VhuT+4Z/h0TK0gbp/2T9PoONtZHhRoM
         htOA==
X-Forwarded-Encrypted: i=1; AJvYcCX0lX05n9FG6JfVGYaJmSDWucxrzJX7KbgGEK54fiE6We310xVnsugNZ0YA1oT5sv3rzkIQLVlaFM7K43o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFSAbAlyQz1s+qrtkEc790V5a7mh7K8xeClu4KqLwIm7kt/GxZ
	1Lwf/d9/1enUWSl8F6pODFKucJ1LwRQA9EyVFcc1VCD3ku2ksQMNMw6PxQ==
X-Gm-Gg: ASbGncs4Www/nfEDRf1LEHqCTdSGPTIpTl9Zc8bdeJF3m1f5OnXssakIWvwgvj5O+jC
	1R1r9T/GD74fGohAJ9WDk/emjrBf0KW4xceO0hRWyMAhTMFRwGVtNVv6qrYAnFETkK3okcpAuEr
	CCzxCf6PnB6GpVkhVfNe3DJPqgngfR9bYhZPVkBEpsLtU3/7cu1gtoeENoW1e62MJsDTqbtG9HA
	bHOk8qDqBiTgbArt1/+wd2mDm0rxhp/d10jfMNVw9cXQQejpYy/yW1G7IaIsStPdeTwhpTVuGL9
	5n1M3Tc1KMsuHBby25SjizI=
X-Google-Smtp-Source: AGHT+IFrGoyF8pMmDXmXBFA/pYoykofDtEnV/1KH/ZaDlZFg4jNobS1QYxHSplclgV8ni+14c4AvUg==
X-Received: by 2002:a17:902:d482:b0:212:3f13:d4bc with SMTP id d9443c01a7336-214e7065fa5mr7916655ad.27.1732562600679;
        Mon, 25 Nov 2024 11:23:20 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dbff326sm68665595ad.151.2024.11.25.11.23.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 11:23:19 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <72991b83-173e-492e-a4aa-5049304c1bd0@roeck-us.net>
Date: Mon, 25 Nov 2024 11:23:18 -0800
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
 <c77c77d4-7f6e-450c-97d5-39dc50d81b1a@roeck-us.net>
 <20241125181231.XpOsxxHx@linutronix.de>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20241125181231.XpOsxxHx@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/25/24 10:12, Sebastian Andrzej Siewior wrote:
> On 2024-11-25 09:59:09 [-0800], Guenter Roeck wrote:
>> On 11/25/24 09:43, Sebastian Andrzej Siewior wrote:
>>> On 2024-11-25 09:01:33 [-0800], Guenter Roeck wrote:
>>>> Unfortunately it doesn't make a difference.
>>>
>>> stunning. It looks like the exact same error message.
>>>
>>
>> I think it uses
>>
>> #define spin_lock_irqsave(lock, flags)                          \
>> do {                                                            \
>>          raw_spin_lock_irqsave(spinlock_check(lock), flags);     \
>> } while (0)
>>
>> from include/linux/spinlock.h, meaning your patch doesn't really make a difference.
> 
> The difference comes from DEFINE_SPINLOCK vs DEFINE_RAW_SPINLOCK. There
> is the .lock_type init which goes from LD_WAIT_CONFIG to LD_WAIT_SPIN.
> And this is all it matters.
> 

Ah, now I get it. Thanks for the explanation. And it turns out my log was wrong.
I must have taken it from the old image. Sorry for that.

That specific backtrace isn't seen anymore. But there is another one.

[    1.779653] =============================
[    1.779860] [ BUG: Invalid wait context ]
[    1.780139] 6.12.0+ #1 Not tainted
[    1.780394] -----------------------------
[    1.780600] swapper/0/1 is trying to lock:
[    1.780824] 0000000001b68888 (cpu_map_lock){....}-{3:3}, at: map_to_cpu+0x10/0x80
[    1.781393] other info that might help us debug this:
[    1.781624] context-{5:5}
[    1.781838] 3 locks held by swapper/0/1:
[    1.782055]  #0: fffff800042b90f8 (&dev->mutex){....}-{4:4}, at: __driver_attach+0x80/0x160
[    1.782345]  #1: fffff800040f2c18 (&desc->request_mutex){+.+.}-{4:4}, at: __setup_irq+0xa0/0x6e0
[    1.782632]  #2: fffff800040f2ab0 (&irq_desc_lock_class){....}-{2:2}, at: __setup_irq+0xc8/0x6e0
[    1.782912] stack backtrace:
[    1.783172] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.0+ #1
[    1.783498] Call Trace:
[    1.783734] [<00000000004e31d0>] __lock_acquire+0xa50/0x3160
[    1.783971] [<00000000004e63e8>] lock_acquire+0xe8/0x340
[    1.784191] [<00000000010f0dbc>] _raw_spin_lock_irqsave+0x3c/0x80
[    1.784417] [<000000000043ed90>] map_to_cpu+0x10/0x80
[    1.784633] [<000000000042b2b8>] sun4u_irq_enable+0x18/0x80
[    1.784854] [<00000000004fb6b4>] irq_enable+0x34/0xc0
[    1.785069] [<00000000004fb7b8>] __irq_startup+0x78/0xe0
[    1.785287] [<00000000004fb8f0>] irq_startup+0xd0/0x1a0
[    1.785503] [<00000000004f85b4>] __setup_irq+0x5f4/0x6e0
[    1.785726] [<00000000004f8754>] request_threaded_irq+0xb4/0x1a0
[    1.785950] [<0000000000439930>] power_probe+0x70/0xe0
[    1.786165] [<0000000000c13a68>] platform_probe+0x28/0x80
[    1.786382] [<0000000000c11178>] really_probe+0xb8/0x340
[    1.786599] [<0000000000c115a4>] driver_probe_device+0x24/0xe0
[    1.786820] [<0000000000c117cc>] __driver_attach+0x8c/0x160
[    1.787039] [<0000000000c0ef74>] bus_for_each_dev+0x54/0xc0

After replacing cpu_map_lock with a raw spinlock, I get:

[    2.015140] =============================
[    2.015247] [ BUG: Invalid wait context ]
[    2.015419] 6.12.0+ #1 Not tainted
[    2.015564] -----------------------------
[    2.015668] swapper/0/1 is trying to lock:
[    2.015791] fffff80004870610 (&mm->context.lock){....}-{3:3}, at: __schedule+0x410/0x5b0
[    2.016306] other info that might help us debug this:
[    2.016451] context-{5:5}
[    2.016539] 3 locks held by swapper/0/1:
[    2.016652]  #0: 0000000001d11f38 (key_types_sem){++++}-{4:4}, at: __key_create_or_update+0x5c/0x4c0
[    2.016934]  #1: 0000000001d1b850 (asymmetric_key_parsers_sem){++++}-{4:4}, at: asymmetric_key_preparse+0x18/0xa0
[    2.017197]  #2: fffff8001f811a98 (&rq->__lock){-.-.}-{2:2}, at: __schedule+0xdc/0x5b0
[    2.017412] stack backtrace:
[    2.017551] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.0+ #1
[    2.017800] Call Trace:
[    2.017910] [<00000000004e31d0>] __lock_acquire+0xa50/0x3160
[    2.018062] [<00000000004e63e8>] lock_acquire+0xe8/0x340
[    2.018192] [<00000000010f0dbc>] _raw_spin_lock_irqsave+0x3c/0x80
[    2.018341] [<00000000010e5050>] __schedule+0x410/0x5b0
[    2.018469] [<00000000010e5ae4>] schedule+0x44/0x1c0
[    2.018591] [<00000000010f0684>] schedule_timeout+0xa4/0x100
[    2.018730] [<00000000010e668c>] __wait_for_common+0xac/0x1a0
[    2.018869] [<00000000010e6878>] wait_for_completion_state+0x18/0x40
[    2.019022] [<000000000048ad18>] call_usermodehelper_exec+0x138/0x1c0
[    2.019177] [<000000000052eb40>] __request_module+0x160/0x2e0
[    2.019316] [<00000000009ba6dc>] crypto_alg_mod_lookup+0x17c/0x280
[    2.019466] [<00000000009ba990>] crypto_alloc_tfm_node+0x30/0x100
[    2.019614] [<00000000009dcc5c>] public_key_verify_signature+0xbc/0x260
[    2.019772] [<00000000009ded8c>] x509_check_for_self_signed+0xac/0x280
[    2.019928] [<00000000009dddec>] x509_cert_parse+0x14c/0x220
[    2.020065] [<00000000009dea08>] x509_key_preparse+0x8/0x1e0

The problem here is

typedef struct {
         spinlock_t              lock;		<--
         unsigned long           sparc64_ctx_val;
         unsigned long           hugetlb_pte_count;
         unsigned long           thp_pte_count;
         struct tsb_config       tsb_block[MM_NUM_TSBS];
         struct hv_tsb_descr     tsb_descr[MM_NUM_TSBS];
         void                    *vdso;
         bool                    adi;
         tag_storage_desc_t      *tag_store;
         spinlock_t              tag_lock;
} mm_context_t;

Replacing that with a raw spinlock just triggers the next one.

[    2.035384] =============================
[    2.035490] [ BUG: Invalid wait context ]
[    2.035660] 6.12.0+ #3 Not tainted
[    2.035802] -----------------------------
[    2.035906] kworker/u4:3/48 is trying to lock:
[    2.036036] 0000000001b6a790 (ctx_alloc_lock){....}-{3:3}, at: get_new_mmu_context+0x14/0x280
[    2.036558] other info that might help us debug this:
[    2.036697] context-{5:5}
[    2.036784] 4 locks held by kworker/u4:3/48:
[    2.036906]  #0: fffff80004838a70 (&sig->cred_guard_mutex){+.+.}-{4:4}, at: bprm_execve+0xc/0x8e0
[    2.037169]  #1: fffff80004838b08 (&sig->exec_update_lock){+.+.}-{4:4}, at: begin_new_exec+0x344/0xbe0
[    2.037411]  #2: fffff800047fc940 (&p->alloc_lock){+.+.}-{3:3}, at: begin_new_exec+0x3a0/0xbe0
[    2.037639]  #3: fffff80004848610 (&mm->context.lock){....}-{2:2}, at: begin_new_exec+0x41c/0xbe0

Fixing that finally gives me a clean run. Nevertheless, that makes me wonder:
Should I just disable CONFIG_PROVE_RAW_LOCK_NESTING for sparc runtime tests ?

Thanks,
Guenter


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9B617C7CA
	for <sparclinux@vger.kernel.org>; Mon, 25 Nov 2024 19:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732563195; cv=none; b=bxjCe4sMEhi2SBj4Cej0r/8EZLOgvJ0l4HFTbRor0tEtlJbuDya1XFd7pvuPnHks8/KXKeGrvtHNeKG0aUlQCyY/DipJfgN5mdJkYIBvixjRyQ73e8ImH+4YeUz2HoEh3gez481yo9dTgMyYhcADky5Tz1wXTIYYrC2gQ36FFjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732563195; c=relaxed/simple;
	bh=7cYtgsP3Su6K2SrZ/UMJuDt2M7yXmwcaLawh0yeObls=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=XAMObMn/HU4pp9o1OBW6AEjhEZ9RsTHGktdaeoAB/WnEKng9sOIO0OOkDIk8B5jeMQneG/9th6OqVcsmh/+HraHJVrG01hqIcNRIlekYDT6+lglyAwTrIAFAxWhb8tr/KUn2HxQmmYLUeV4v7VpOApRajt6k666jd8e5Cek0Fmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V5qcql4q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V5qcql4q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732563191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fltlq3QdnTcV73dsBXR/sCICcjYVCQiAqJanAUwRHIM=;
	b=V5qcql4qrckDHQFFy4TLF18R9bPSOqn6t39nEdMKTwVRFBYCiiTGroBEDiKBKgjaVcHcmh
	ecxj6UXgcgGHTTl2k8ddoGbPITCs7p/N5yVB3N3e82iU7wpHv5HInTTqRsCqWPGmBQHC4/
	afYgyQ8wi1DBlVkW+LDuMYDuDvi0URs=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-wfYaNVTnPcOr86gHOivD3w-1; Mon, 25 Nov 2024 14:33:08 -0500
X-MC-Unique: wfYaNVTnPcOr86gHOivD3w-1
X-Mimecast-MFC-AGG-ID: wfYaNVTnPcOr86gHOivD3w
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-46692410a9aso18077931cf.2
        for <sparclinux@vger.kernel.org>; Mon, 25 Nov 2024 11:33:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732563188; x=1733167988;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fltlq3QdnTcV73dsBXR/sCICcjYVCQiAqJanAUwRHIM=;
        b=ItNxLhd09eAnBdhM5UMnI1eommJ++VoGu6mbXJ70BnhczawiogA7iYUIyune8I3Zi2
         f/AaBuc4ClTyXywosN8tn1PwnioVwDYRib9iMGHsgtQSd+5t7r+cjMo3EHRanX39bQNC
         mWBL535CyP4sb9sz9+hi2z5FM41qsQG4w9PnqEMNLSTaW8YyOzDWD9canhw9SDHveM04
         aGcbaXhPCitHfte/zbIGsF8wR8E0lbpO8We/kzI0eggzWiHRZoSlSdeBm1Q6k7jzkEbg
         3mgvxwHU+e5R6LTAR5UIaOvvzVNAH2cxTVXMiPcfYJx21nHeL2vjpcQ0kxlD9RQIWGNv
         6gRg==
X-Gm-Message-State: AOJu0Yz+fWA4z4ictNaY8AYqLyiyczVKLBnJ0HmooDisPhzWiwsuA671
	wIM6JD5ApWwv0fV1R+1pVVykU9Os0IGes+6gfC6mJU5ZG8gpMIqdhYGSpm33KJdoPDgKVEtsIQn
	oSo/qbRqb4g16JFFNA+yYu3c1rmpGFGNwTtgsGSZMgBvekJI78iw3De2cuHI=
X-Gm-Gg: ASbGnctx6oXye75k0fCzeGpfxOpCiD91ypeQ7eBBi3xTI2OeJU1b6wMSKnXP9eamPDc
	734FaTboHJJb2T9dismHsraKSeD3YiiJ3v11Jx1HzocQfrUnJ8c0LBsse5sYmF35S0Ye1KDlTgW
	TQSN8XQo+OH94GnbDRBxBLfqFoVagu/+nyDMLFfmuoVlEaUDR/PVlGDj9gsijG5Fetz5wlsST9B
	zpgzEovqXvugrpJr4WdSVtbTCw3/V87KVQ28AOtJRbGg2Wg+aHXUGHugF2+ll35GQRymkgwq7Fi
	hHX+gfda0O86q+dJcfiD
X-Received: by 2002:ac8:7f54:0:b0:461:15fc:7f85 with SMTP id d75a77b69052e-4653d61ddefmr217084481cf.42.1732563187748;
        Mon, 25 Nov 2024 11:33:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFL2hTdhpW7tee3jxoLX3AQbNrP/nM/dP2pQw36W1PjAM8f4c7WwlRZkVInLnPDA/eGwgbN8w==
X-Received: by 2002:ac8:7f54:0:b0:461:15fc:7f85 with SMTP id d75a77b69052e-4653d61ddefmr217083911cf.42.1732563187174;
        Mon, 25 Nov 2024 11:33:07 -0800 (PST)
Received: from ?IPV6:2601:408:c180:2530:d041:4c25:86b8:e76a? ([2601:408:c180:2530:d041:4c25:86b8:e76a])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4669dcc25f4sm6565191cf.74.2024.11.25.11.33.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 11:33:06 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <5d269249-afd1-44f5-8faf-9ac11d9a3beb@redhat.com>
Date: Mon, 25 Nov 2024 14:33:04 -0500
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sparc/pci: Make pci_poke_lock a raw_spinlock_t.
To: Guenter Roeck <linux@roeck-us.net>,
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
Content-Language: en-US
In-Reply-To: <72991b83-173e-492e-a4aa-5049304c1bd0@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 11/25/24 2:23 PM, Guenter Roeck wrote:
> On 11/25/24 10:12, Sebastian Andrzej Siewior wrote:
>> On 2024-11-25 09:59:09 [-0800], Guenter Roeck wrote:
>>> On 11/25/24 09:43, Sebastian Andrzej Siewior wrote:
>>>> On 2024-11-25 09:01:33 [-0800], Guenter Roeck wrote:
>>>>> Unfortunately it doesn't make a difference.
>>>>
>>>> stunning. It looks like the exact same error message.
>>>>
>>>
>>> I think it uses
>>>
>>> #define spin_lock_irqsave(lock, flags)                          \
>>> do {                                                            \
>>>          raw_spin_lock_irqsave(spinlock_check(lock), flags);     \
>>> } while (0)
>>>
>>> from include/linux/spinlock.h, meaning your patch doesn't really 
>>> make a difference.
>>
>> The difference comes from DEFINE_SPINLOCK vs DEFINE_RAW_SPINLOCK. There
>> is the .lock_type init which goes from LD_WAIT_CONFIG to LD_WAIT_SPIN.
>> And this is all it matters.
>>
>
> Ah, now I get it. Thanks for the explanation. And it turns out my log 
> was wrong.
> I must have taken it from the old image. Sorry for that.
>
> That specific backtrace isn't seen anymore. But there is another one.
>
> [    1.779653] =============================
> [    1.779860] [ BUG: Invalid wait context ]
> [    1.780139] 6.12.0+ #1 Not tainted
> [    1.780394] -----------------------------
> [    1.780600] swapper/0/1 is trying to lock:
> [    1.780824] 0000000001b68888 (cpu_map_lock){....}-{3:3}, at: 
> map_to_cpu+0x10/0x80
> [    1.781393] other info that might help us debug this:
> [    1.781624] context-{5:5}
> [    1.781838] 3 locks held by swapper/0/1:
> [    1.782055]  #0: fffff800042b90f8 (&dev->mutex){....}-{4:4}, at: 
> __driver_attach+0x80/0x160
> [    1.782345]  #1: fffff800040f2c18 
> (&desc->request_mutex){+.+.}-{4:4}, at: __setup_irq+0xa0/0x6e0
> [    1.782632]  #2: fffff800040f2ab0 
> (&irq_desc_lock_class){....}-{2:2}, at: __setup_irq+0xc8/0x6e0
> [    1.782912] stack backtrace:
> [    1.783172] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 
> 6.12.0+ #1
> [    1.783498] Call Trace:
> [    1.783734] [<00000000004e31d0>] __lock_acquire+0xa50/0x3160
> [    1.783971] [<00000000004e63e8>] lock_acquire+0xe8/0x340
> [    1.784191] [<00000000010f0dbc>] _raw_spin_lock_irqsave+0x3c/0x80
> [    1.784417] [<000000000043ed90>] map_to_cpu+0x10/0x80
> [    1.784633] [<000000000042b2b8>] sun4u_irq_enable+0x18/0x80
> [    1.784854] [<00000000004fb6b4>] irq_enable+0x34/0xc0
> [    1.785069] [<00000000004fb7b8>] __irq_startup+0x78/0xe0
> [    1.785287] [<00000000004fb8f0>] irq_startup+0xd0/0x1a0
> [    1.785503] [<00000000004f85b4>] __setup_irq+0x5f4/0x6e0
> [    1.785726] [<00000000004f8754>] request_threaded_irq+0xb4/0x1a0
> [    1.785950] [<0000000000439930>] power_probe+0x70/0xe0
> [    1.786165] [<0000000000c13a68>] platform_probe+0x28/0x80
> [    1.786382] [<0000000000c11178>] really_probe+0xb8/0x340
> [    1.786599] [<0000000000c115a4>] driver_probe_device+0x24/0xe0
> [    1.786820] [<0000000000c117cc>] __driver_attach+0x8c/0x160
> [    1.787039] [<0000000000c0ef74>] bus_for_each_dev+0x54/0xc0
>
> After replacing cpu_map_lock with a raw spinlock, I get:
>
> [    2.015140] =============================
> [    2.015247] [ BUG: Invalid wait context ]
> [    2.015419] 6.12.0+ #1 Not tainted
> [    2.015564] -----------------------------
> [    2.015668] swapper/0/1 is trying to lock:
> [    2.015791] fffff80004870610 (&mm->context.lock){....}-{3:3}, at: 
> __schedule+0x410/0x5b0
> [    2.016306] other info that might help us debug this:
> [    2.016451] context-{5:5}
> [    2.016539] 3 locks held by swapper/0/1:
> [    2.016652]  #0: 0000000001d11f38 (key_types_sem){++++}-{4:4}, at: 
> __key_create_or_update+0x5c/0x4c0
> [    2.016934]  #1: 0000000001d1b850 
> (asymmetric_key_parsers_sem){++++}-{4:4}, at: 
> asymmetric_key_preparse+0x18/0xa0
> [    2.017197]  #2: fffff8001f811a98 (&rq->__lock){-.-.}-{2:2}, at: 
> __schedule+0xdc/0x5b0
> [    2.017412] stack backtrace:
> [    2.017551] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 
> 6.12.0+ #1
> [    2.017800] Call Trace:
> [    2.017910] [<00000000004e31d0>] __lock_acquire+0xa50/0x3160
> [    2.018062] [<00000000004e63e8>] lock_acquire+0xe8/0x340
> [    2.018192] [<00000000010f0dbc>] _raw_spin_lock_irqsave+0x3c/0x80
> [    2.018341] [<00000000010e5050>] __schedule+0x410/0x5b0
> [    2.018469] [<00000000010e5ae4>] schedule+0x44/0x1c0
> [    2.018591] [<00000000010f0684>] schedule_timeout+0xa4/0x100
> [    2.018730] [<00000000010e668c>] __wait_for_common+0xac/0x1a0
> [    2.018869] [<00000000010e6878>] wait_for_completion_state+0x18/0x40
> [    2.019022] [<000000000048ad18>] call_usermodehelper_exec+0x138/0x1c0
> [    2.019177] [<000000000052eb40>] __request_module+0x160/0x2e0
> [    2.019316] [<00000000009ba6dc>] crypto_alg_mod_lookup+0x17c/0x280
> [    2.019466] [<00000000009ba990>] crypto_alloc_tfm_node+0x30/0x100
> [    2.019614] [<00000000009dcc5c>] 
> public_key_verify_signature+0xbc/0x260
> [    2.019772] [<00000000009ded8c>] x509_check_for_self_signed+0xac/0x280
> [    2.019928] [<00000000009dddec>] x509_cert_parse+0x14c/0x220
> [    2.020065] [<00000000009dea08>] x509_key_preparse+0x8/0x1e0
>
> The problem here is
>
> typedef struct {
>         spinlock_t              lock;        <--
>         unsigned long           sparc64_ctx_val;
>         unsigned long           hugetlb_pte_count;
>         unsigned long           thp_pte_count;
>         struct tsb_config       tsb_block[MM_NUM_TSBS];
>         struct hv_tsb_descr     tsb_descr[MM_NUM_TSBS];
>         void                    *vdso;
>         bool                    adi;
>         tag_storage_desc_t      *tag_store;
>         spinlock_t              tag_lock;
> } mm_context_t;
>
> Replacing that with a raw spinlock just triggers the next one.
>
> [    2.035384] =============================
> [    2.035490] [ BUG: Invalid wait context ]
> [    2.035660] 6.12.0+ #3 Not tainted
> [    2.035802] -----------------------------
> [    2.035906] kworker/u4:3/48 is trying to lock:
> [    2.036036] 0000000001b6a790 (ctx_alloc_lock){....}-{3:3}, at: 
> get_new_mmu_context+0x14/0x280
> [    2.036558] other info that might help us debug this:
> [    2.036697] context-{5:5}
> [    2.036784] 4 locks held by kworker/u4:3/48:
> [    2.036906]  #0: fffff80004838a70 
> (&sig->cred_guard_mutex){+.+.}-{4:4}, at: bprm_execve+0xc/0x8e0
> [    2.037169]  #1: fffff80004838b08 
> (&sig->exec_update_lock){+.+.}-{4:4}, at: begin_new_exec+0x344/0xbe0
> [    2.037411]  #2: fffff800047fc940 (&p->alloc_lock){+.+.}-{3:3}, at: 
> begin_new_exec+0x3a0/0xbe0
> [    2.037639]  #3: fffff80004848610 (&mm->context.lock){....}-{2:2}, 
> at: begin_new_exec+0x41c/0xbe0
>
> Fixing that finally gives me a clean run. Nevertheless, that makes me 
> wonder:
> Should I just disable CONFIG_PROVE_RAW_LOCK_NESTING for sparc runtime 
> tests ?

If no one is tryng to ever enable PREEMPT_RT on SPARC, I suppose you 
could disable CONFIG_PROVE_RAW_LOCK_NESTING to avoid the trouble.

Cheers,
Longman


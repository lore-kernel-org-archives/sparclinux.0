Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F401DA2E5
	for <sparclinux@vger.kernel.org>; Tue, 26 Nov 2024 16:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732640361; cv=none; b=oFdENs03Ju+wdDow6F1hSr+6LsgguJU+PDYkOKLO807fnpSbtX9x2U5O/fQhO8km12pQ/075CSA/HBo68hWYfghyTEox27HNHnm9UWr14MsO3EjKDtrQBI/eODsroXp0ElFwUKDBOcbDvx9BiKOoGCfHn4lVxOVIDwUznzfFB6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732640361; c=relaxed/simple;
	bh=Wwm5m98lf1T8S9SwxIBtlmeTtv/4D+EhhHes4WNOA2E=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=FTgDbBLxNhRNKnLL5ZJ6SQtAjO/m69auJIJFZJfRJ5TOYDWg9h5HIS4EM4M05S8pchth+chPyjiQlxZbr4NGff9FVpL09nAUW8dAhfLvHh7XAbj4PFhK82F0BRS11ZMoD9dGebc0If9Erhg6W4cFZEcyp9SpLE+5kFiGgha9KBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GOqLmvIg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GOqLmvIg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732640356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FfwAUTEkCBSJRetY/z93FAYZhUtOgtlO/ePiMJ03JhU=;
	b=GOqLmvIgOC3GcgZ7S/DYkC9Dq+gYSQc+T/xsQw5N0t5pGXVp6dbjfZPlun3McIvefH3j58
	RDHeg/UWz1e4TObXetLJwMreg00ATlbUbDNFvfgYSgAewsIByhj7U22JbFuDP5lZWqPN5f
	LzZJL23oY366vRotL5pvYnqTG0iHhDM=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-T8YAXqMYNYWqrtSmj1LnJg-1; Tue, 26 Nov 2024 11:59:11 -0500
X-MC-Unique: T8YAXqMYNYWqrtSmj1LnJg-1
X-Mimecast-MFC-AGG-ID: T8YAXqMYNYWqrtSmj1LnJg
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-841a9ae0f26so217434039f.3
        for <sparclinux@vger.kernel.org>; Tue, 26 Nov 2024 08:59:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732640351; x=1733245151;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FfwAUTEkCBSJRetY/z93FAYZhUtOgtlO/ePiMJ03JhU=;
        b=QKTL0QMmvSTR58C1nQso6Dm+pbjQOCMrKUnH7xtrkJ5IpQciYitAzS7uI1G8u2+peO
         jKQqjPlYu4i6kdjchThEK1ym2K6PtRBfG+vETC7qNXHcs5psd/ToRFYoBUVFn3QrZO1h
         /TAdODSQ7X5zMs1iPVRAnatgK/Ofg5seO+hlmWm0rFbFHjIRHkehl/fyDr5bLF+MkIy9
         rx4XhdvrLKpLMGPGqORhxYvQbYTQ8X74zlWw2weNDxJBIYsTtrfTbYVuGtBXTeoPE4HZ
         CkYbRglxPF+bU2mJVJTpRe9rC1J/X96Cps+WgXxHfcRTtv/WOpTl5xGw8Lz+waVf4fpX
         ARGw==
X-Forwarded-Encrypted: i=1; AJvYcCVxAUzPWJ1T97YAAZsMEf4DP9dT+4cx3kdxhcpSHfsDFnDvCuPoN45akMDRIu6BDivOj8tyYbwyimyV@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj8VKEUKDSqJ2225LgGH6+PHJF0RThYMg0H7SzLJCGX6LYgG52
	VpriMMhoBW3XvjUs5mZxC/W7PzmPhGta2uZRtu2PfIM698kmC1jWgBiuFkm4umpb+xXW8SYsYIx
	vavreSsQphlxIdzzqdB3j6ilEaV3cKKufERYhQnbiiMgiFRagmCa1GmjyKhQ=
X-Gm-Gg: ASbGnctIQzO35kIogzJEK50ZalSdW6Mae52TquME8V/XjcIk1EJzAeQpGO54fmefMA+
	4YrGrmbDts+taL0KNp6XQkmLEQezfadmRE2eqTeZ0Bhvvf+rV2wLDDUQLWUbNZjGl+dN2BGD0hb
	sqLqi7iVJqBNl2+zeRW1AaIkhCPK274ltL9Lf7OPq8JyaS6hQThO0JQYFa9C2HqQiLkPshOziKC
	i9IGCHpRkxfIu75juarICTrcaGovINJzKBRzamZ76F9AQm2mggPfg/H80xP9UAKENiURhonxHTQ
	n1u+qc5SnHPbNeRbSSv/
X-Received: by 2002:a05:6602:3416:b0:83a:872f:4b98 with SMTP id ca18e2360f4ac-843eceaecf4mr11257539f.2.1732640351290;
        Tue, 26 Nov 2024 08:59:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHGuUIrsmpD2nyyr2nlz0r/65HSulSWQ8fTKZWOuQhPW1NivEiWGecHiw9sP62ticKt/lJs8A==
X-Received: by 2002:a05:6602:3416:b0:83a:872f:4b98 with SMTP id ca18e2360f4ac-843eceaecf4mr11256039f.2.1732640350992;
        Tue, 26 Nov 2024 08:59:10 -0800 (PST)
Received: from ?IPV6:2601:408:c180:2530:d041:4c25:86b8:e76a? ([2601:408:c180:2530:d041:4c25:86b8:e76a])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8419e23255asm101800839f.35.2024.11.26.08.59.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 08:59:10 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <48b9d642-9739-4333-b4b9-319df8a85e2d@redhat.com>
Date: Tue, 26 Nov 2024 11:59:09 -0500
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sparc/pci: Make pci_poke_lock a raw_spinlock_t.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Waiman Long <llong@redhat.com>
Cc: Guenter Roeck <linux@roeck-us.net>, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>
References: <20241125085314.1iSDFulg@linutronix.de>
 <b776ca37-d51c-47e2-b3bb-aee8e7910630@roeck-us.net>
 <20241125174336.8nEhFXIw@linutronix.de>
 <c77c77d4-7f6e-450c-97d5-39dc50d81b1a@roeck-us.net>
 <20241125181231.XpOsxxHx@linutronix.de>
 <72991b83-173e-492e-a4aa-5049304c1bd0@roeck-us.net>
 <5d269249-afd1-44f5-8faf-9ac11d9a3beb@redhat.com>
 <dea92bd5-65e5-4c5c-bc93-5bef547c935e@roeck-us.net>
 <2a940822-b4d4-43ea-b4f7-4294043b76ea@roeck-us.net>
 <88f47cea-baba-4673-9bd7-7b7c3f421008@redhat.com>
 <20241126112000.UkTwR0Iv@linutronix.de>
Content-Language: en-US
In-Reply-To: <20241126112000.UkTwR0Iv@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 11/26/24 6:20 AM, Sebastian Andrzej Siewior wrote:
> On 2024-11-25 15:54:48 [-0500], Waiman Long wrote:
>>> FWIW, the description of commit 560af5dc839 is misleading. It says
>>> "Enable
>>> PROVE_RAW_LOCK_NESTING _by default_" (emphasis mine). That is not what
>>> the
>>> commit does. It force-enables PROVE_RAW_LOCK_NESTING if PROVE_LOCKING is
>>> enabled. It is all or nothing.
>>>
>> I think we can relax it by
>>
>> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
>> index 5d9eca035d47..bfdbd3fa2d29 100644
>> --- a/lib/Kconfig.debug
>> +++ b/lib/Kconfig.debug
>> @@ -1399,7 +1399,7 @@ config PROVE_LOCKING
>>   config PROVE_RAW_LOCK_NESTING
>>          bool
>>          depends on PROVE_LOCKING
>> -       default y
>> +       default y if ARCH_SUPPORTS_RT
>>          help
>>           Enable the raw_spinlock vs. spinlock nesting checks which ensure
>>           that the lock nesting rules for PREEMPT_RT enabled kernels are
>>
>> Sebastian, what do you think?
> All the changes Guenter proposed make sense and were limited to sparc.
> So we could apply that. Limiting the option to the RT architectures
> would silence the warnings. If there is no interest in getting RT on
> sparc there is probably no interest in getting the lock ordering
> straight.
> I remember PeterZ did not like the option in the beginning but there was
> no way around it especially since printk triggered it on boot.
> I'm fine with both solutions (fixing sparc or limiting
> PROVE_RAW_LOCK_NESTING). I leave the final judgment to the locking
> people.

Right now, ARCH_SUPPORTS_RT is defined for most of the major arches 
where most of the testings are being done. So even if we limit this to 
just those arches, we will not lose much testing anyway. This does have 
the advantage of not forcing other legacy arches from doing extra works 
with no real gain from their point of view.

Cheers,
Longman


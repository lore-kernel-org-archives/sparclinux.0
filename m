Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442432D5432
	for <sparclinux@vger.kernel.org>; Fri, 12 Sep 2025 08:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757664261; cv=none; b=jiBvffV2QDiIGYB3V9kos+Tl+miXQdjcE5YXGZw6pPgp3m8lcgUGO8pVZ89ZYyg/vSoyOD3IrX4M5wa3bUQGBCLNw8IGJvk9UiYSNYb8v7MfxwrKUEl4pt5RrxOWGjQaJpFNXjpnwUWqstbV5RInkt1PTZXhbpz5b9BtCb1F0KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757664261; c=relaxed/simple;
	bh=2G52+ua4rxPciGHkYCV3x0m+xOwg0YmV2sZndN7ahlo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iF00JvAOm9haAAP9e0ReROnZXUvcA4IYXtmT+0shURyR9nYfE8jXBQfVkaxefTMjvyAyoEqEKX04UybVkd4ZRCpcyavy74RVU1kMEMRf3lhWBPxjjSBdx3Q6U5DaD+QUaq/7SenFdl7l9NsvmR4Nylz75VdG3ZqcCpMBk8F3pbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eaVxy06R; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eaVxy06R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757664259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=H5X75pHcHAnEM8zcD7ykTJjL5glq6wg6eQ+1uRSxWa4=;
	b=eaVxy06RIZK7fFnh8SLhx7CZtgyZI1I+YLuNK22L3tuXu/6kvI4gU7wrol7FHQjXz8O8bz
	jDgw19n6OIyoZR/emx+ieW/H4g9wDNVFAgs3Z0QuwozRE6b8bhagY4uKTU2jZr6To4NZg7
	7COUaSR8wnMhc10mMpTfpa5DLV+8Yn0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-ctBGofjKMSC6pErBNzfu9g-1; Fri, 12 Sep 2025 04:04:17 -0400
X-MC-Unique: ctBGofjKMSC6pErBNzfu9g-1
X-Mimecast-MFC-AGG-ID: ctBGofjKMSC6pErBNzfu9g_1757664256
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45cb612d362so8971285e9.3
        for <sparclinux@vger.kernel.org>; Fri, 12 Sep 2025 01:04:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757664256; x=1758269056;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H5X75pHcHAnEM8zcD7ykTJjL5glq6wg6eQ+1uRSxWa4=;
        b=CCU5ha01CLIbxRxJTwq+ka6mQIEMl4vpxrJuCf3Izv+SUTPE1DEfJGheLQZAI1b3+4
         RSf2o0p6t31VWooHU2kwZUnlmvjTbVFaLFMEXf074IVP3X+7ytD3Z11ou1UyNx34b9Zv
         eiJzLebxFaP57VIhflaDNBVai/hXYYfTmOlGDiROAoSzIekLYqhWaVktjEKHZSz6YGMQ
         3Bq8OwbqmzDDLW6mZzBZVFDi5nhmxDeHdWTO3iphLlfmwA0cEuqllejXGmpbjUeGDruG
         P4evzw72fkCUdQ0cNxih++J8nBguK4GEckOgeZuaY0YHE2OuhOXArM/+ey55Ws40u2ww
         Bdww==
X-Forwarded-Encrypted: i=1; AJvYcCUfsXFL7Wq8exU1kVctBMmREOABqQ7nPnLcbTsctSgs/4CHQ9gS6CoNiwqPNy/Q3CgAbMyOxO2yKGty@vger.kernel.org
X-Gm-Message-State: AOJu0YyYNjZA/OEqbMs+vAcDgh6R1GduYdqPtkwyLjUPTJi1s3mw4w8a
	znq/tgP+h9NZ6LOAYA6/sxWsPEfh5NS+CU555p/yOB8FB4EQDNN3HKuEmuURL9xLhC7jofayqI7
	rfWAyg9K1bgYcY1YMh7yH2JbZ3TsMfa3NeL1TLW1AVTywGOIa/bjWP+EEs7Z7x6U=
X-Gm-Gg: ASbGncsBkk159705BYjnu5kS/IGxPPQNawsk+p9IWUyEZRHLSykSxtgl6rHiQZdIs2J
	KX9Py5i/ttOwQrJ+d/hOd9w8zBjbV4Ul/sfpS4VP01MdiuWBkPXz2cFMJSW046tdag/su3GHHXH
	9/7xtoLMJyJxZeQNbp/hdvtaOOnrvTtUJXJZhZxyqPrvp9GUKI49x7l8ISDECiCw/xrs9jmsInr
	1qQyFSJuUqBBpL2fHDgJ++No0+b1FfW6SQyfZBBoMwD/sCr33SvNIHAqI2pgLMJrgxGoZjI74fV
	SqKVvCE+zmBmVaU5fDCRUEjO5D4Zx+mX8MjWt61Jq4xbx8uH2RoZx4fG1F/9OtmWEo0jYv/6HWB
	VxN1oTLVOpjXwi/xNtMtNS7ltqKxU2L+EtnIvAlb0GdEtUnQTjd45Ujc+txush11jWF8=
X-Received: by 2002:a05:600c:3b85:b0:45f:2207:ab2a with SMTP id 5b1f17b1804b1-45f25476d29mr270015e9.27.1757664255917;
        Fri, 12 Sep 2025 01:04:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6B4WHtwQniBOXl9TNxrOEZZoyaGGED6LI1RYVbwr7AHnntDCVEJCDe9m05fXcYWcUrUbEPw==
X-Received: by 2002:a05:600c:3b85:b0:45f:2207:ab2a with SMTP id 5b1f17b1804b1-45f25476d29mr269475e9.27.1757664255404;
        Fri, 12 Sep 2025 01:04:15 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f20:da00:b70a:d502:3b51:1f2d? (p200300d82f20da00b70ad5023b511f2d.dip0.t-ipconnect.de. [2003:d8:2f20:da00:b70a:d502:3b51:1f2d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e0157619fsm55845035e9.7.2025.09.12.01.04.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 01:04:14 -0700 (PDT)
Message-ID: <7953a735-6129-4d22-be65-ce736630d539@redhat.com>
Date: Fri, 12 Sep 2025 10:04:12 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] mm: introduce local state for lazy_mmu sections
To: Kevin Brodsky <kevin.brodsky@arm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Andreas Larsson <andreas@gaisler.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Borislav Petkov
 <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "David S. Miller" <davem@davemloft.net>, "H. Peter Anvin" <hpa@zytor.com>,
 Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
 Juergen Gross <jgross@suse.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>,
 Mike Rapoport <rppt@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner
 <tglx@linutronix.de>, Vlastimil Babka <vbabka@suse.cz>,
 Will Deacon <will@kernel.org>, Yeoreum Yun <yeoreum.yun@arm.com>,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org,
 Mark Rutland <Mark.Rutland@arm.com>
References: <20250908073931.4159362-1-kevin.brodsky@arm.com>
 <20250908073931.4159362-3-kevin.brodsky@arm.com>
 <d23ea683-cca4-4973-88b1-4f6fd9b22314@redhat.com>
 <ca2054ad-b163-4e61-8ec4-6f2e36461628-agordeev@linux.ibm.com>
 <e7acb889-1fe9-4db3-acf4-39f4960e8ccd@redhat.com>
 <2fecfae7-1140-4a23-a352-9fd339fcbae5-agordeev@linux.ibm.com>
 <e521b1f4-3f2b-48cd-9568-b9a4cf4c4830@redhat.com>
 <47ee1df7-1602-4200-af94-475f84ca8d80@arm.com>
 <29383ee2-d6d6-4435-9052-d75a263a5c45@redhat.com>
 <9de08024-adfc-421b-8799-62653468cf63@arm.com>
 <ef343405-c394-4763-a79f-21381f217b6c@redhat.com>
 <4b4971fd-0445-4d86-8f3a-6ba3d68d15b7@arm.com>
 <4aa28016-5678-4c66-8104-8dcc3fa2f5ce@redhat.com>
 <15d01c8b-5475-442e-9df5-ca37b0d5dc04@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <15d01c8b-5475-442e-9df5-ca37b0d5dc04@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

>>
>> struct lazy_mmu_state {
>>      uint8_t enabled_count;
>>      bool paused;
> 
> Looking at the arm64 implementation, I'm thinking: instead of the paused
> member, how about a PF_LAZY_MMU task flag? It would be set when lazy_mmu
> is actually enabled (i.e. inside an enter()/leave() section, and not
> inside a pause()/resume() section). This way, architectures could use
> that flag directly to tell if lazy_mmu is enabled instead of reinventing
> the wheel, all in slightly different ways. Namely:
> 
> * arm64 uses a thread flag (TIF_LAZY_MMU) - this is trivially replaced
> with PF_LAZY_MMU
> * powerpc and sparc use batch->active where batch is a per-CPU variable;
> I expect this can also be replaced with PF_LAZY_MMU
> * x86/xen is more complex as it has xen_lazy_mode which tracks both
> LAZY_MMU and LAZY_CPU modes. I'd probably leave that one alone, unless a
> Xen expert is motivated to refactor it.
> 
> With that approach, the implementation of arch_enter() and arch_leave()
> becomes very simple (no tracking of lazy_mmu status) on arm64, powerpc
> and sparc.
> 
> (Of course we could also have an "enabled" member in lazy_mmu_state
> instead of PF_LAZY_MMU, there is no functional difference.)
> 

No strong opinion, but to me it feels like PF_LAZY_MMU is rather "the 
effective state when combining nested+paused", and might complicate the 
code + sanity checks?

So we could maintain that in addition fairly easily of course from the 
core instead of letting archs do that manually.

I would probably have to see the end result to judge whether removing 
the "paused" bool makes things look more complicated or not.

>> }
>>
>> c) With that config, common-code lazy_mmu_*() functions implement the
>> updating of the lazy_mmu_state in task_struct and call into arch code
>> on the transition from 0->1, 1->0 etc.
> 
> Indeed, this is how I thought about it. There is actually quite a lot
> that can be moved to the generic functions:
> * Updating lazy_mmu_state
> * Sanity checks on lazy_mmu_state (e.g. underflow/overflow)
> * Bailing out if in_interrupt() (not done consistently across arch's at
> the moment)
> 
>>
>> Maybe that can be done through exiting
>> arch_enter_lazy_mmu_mode()/arch_leave_lazy_mmu_mode() callbacks, maybe
>> we need more. I feel like
>> we might be able to implement that through the existing helpers.
> 
> We might want to rename them to align with the new generic helpers, but
> yes otherwise the principle should remain unchanged.
> 
> In fact, we will also need to revive arch_flush_lazy_mmu_mode().

That's okay if it's all hidden behaind a sane core API.

> Indeed,
> in the nested situation, we need the following arch calls:
> 
> enter() -> arch_enter()
>      enter() -> [nothing]
>      leave() -> arch_flush()
> leave() -> arch_leave()
> 
> leave() must always flush whatever arch state was batched, as may be
> expected by the caller.
> 
> How does all that sound?

I am no expert on the "always flush when leaving", but it sounds 
reasonable to me.

Which arch operations would you call from

pause()
continue()

?

>> And on top of the proposal above we will have some
>>
>> struct arch_lazy_mmu_state;
>>
>> define by the architecture (could be an empty struct on most).
>>
>> We can store that inside "struct lazy_mmu_state;" or if we ever have
>> to, start returning only that from the enable/disable etc. functions.
> 
> I'm not sure we'd want to mix those styles (task_struct member + local
> variable), that's adding complexity without much upside... Also having a
> local variable at every nesting level only makes sense if we have an
> arch callback regardless of nesting level, which is unnecessary in this
> proposed API.

Yes, that was rather a "if we ever really run out of space we could look 
into that", I am not a fan of it obviously.

-- 
Cheers

David / dhildenb


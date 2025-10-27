Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA38C311C17
	for <sparclinux@vger.kernel.org>; Mon, 27 Oct 2025 16:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761582307; cv=none; b=t6lQPz+OvBl9udPHrzyB4lH+baUFQTw2V8yAzY4RicUZ7xP9FNIF8z9CiMTaBrATGqTOhjmajFnThLkV7i8zKZ1aKLLNWh8j+hYIczTeSCHebqu8OXGR+xJ+8DaLHLZjewtQVBvJktRUzEjJwickznJcjSF1b3HK7Tnmo8vWY/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761582307; c=relaxed/simple;
	bh=y02/AtkDsIqEhEZhlF1G83YBkQiApyyUcaAYo8+NE3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CaWkiPymA2OK0n2JylNije5cLeGcZk5XZ1WcWMrMGhdvAslJjMWHIHFhGv+F2DVGiH/oNSNQWwYAEARQGDg0Ctun3CRm/vXWs2b+Cv7LRrR7kTZHt0lsy2CfMxGrJvL3APL0HkTljuQI37RGajsYB9oZ5g+yqditPGBBJ+ytqsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QeidNnQY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QeidNnQY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761582304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=EJ5VPlj4otrH6ErEHjuzGdU9BRwHQ8d9NMaXu6e9vKY=;
	b=QeidNnQYyHxSTWWki/8j887F6dE8Wx3bcqfniLlnnmd02KFgmwLEkU+pkPY4t3VrV3OVFG
	Oti+Y+m+c6yJk6B81lVe14CsKqyN+OdHBz36X8u1rh6UFT+VR6L15G2EX+2ebbgxmfOGW+
	ZSdD1R+uWjiGBCrOPa+QXq6N/tjXA0A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-QCfJ9qfwPK2epXleljJ3vw-1; Mon, 27 Oct 2025 12:25:03 -0400
X-MC-Unique: QCfJ9qfwPK2epXleljJ3vw-1
X-Mimecast-MFC-AGG-ID: QCfJ9qfwPK2epXleljJ3vw_1761582302
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-475e032d81bso17397015e9.3
        for <sparclinux@vger.kernel.org>; Mon, 27 Oct 2025 09:25:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761582302; x=1762187102;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EJ5VPlj4otrH6ErEHjuzGdU9BRwHQ8d9NMaXu6e9vKY=;
        b=HidlLJkqRsS4CRuh8uUJQ5Y6Zo6b55zs+roWq9uogq0DTH8OZ2pmz5skXWTX24nSHW
         QE6JXqlCgh81nOLQ2r7w5w3EpAyT5z/eFR3alnNhy5p3Tcei8p3BcwcZRaIePzlYdJ5Y
         bj07nJskQcw8BBo7A8sCpEpzt6H3f8BqEIXkQi9QeF4Zd3zuWPP3GZXMEB10Sd4ePYwO
         CM7QqL3kKCBmyU7+8SHCrKpzsuvrTiRx0BJ+3MThhbvDqEbhFLsRtHxRVbIRGFM06fZb
         kT0STts0ZaLotiwoksbYITPaogQ/H0PbZK20ULUkbaEaeDZgK4UVbYfjj3cTtI9ySx9b
         gDWA==
X-Forwarded-Encrypted: i=1; AJvYcCXhsXwOiQXzBCIDuf5nINA4m4AR8hARhHc3pg5Zt3SFxIvdk2ibFVwHr0DW6LdH2Q/PnLGYmfUHVkAc@vger.kernel.org
X-Gm-Message-State: AOJu0YxmMyoTgJX/b8NluWDCkB/iWo+t80yJf+l+AqmDUuX3MMMmVk97
	ZmoUdtwZ9KjVlEBPXVx86K6Ekf2ZhwR8OTMJ5TQ7OYmi0/pP5jIlhfczvEYTFYvPCFpsKqDpdpe
	lQT9bW3uahVci0DQ/H1avei5cQTAXNI2K+l0ytdxeHCN5EUl1tZu2JETx0Kw/m5M=
X-Gm-Gg: ASbGncuOq8UTOGTcyu1vujB/4B+J+MwTQEZcqsuUv10Pe69PqpbQ+mzlbZp7V9lEn1S
	6GkiyF34vMcnP88Wc9HQlw7vYnYQdfX9X6WpHJrEiW3+SDQQ1LeNf5LNjxAgK7VDkmRdpWZdCbk
	mpzFV4+fIi7RZ3VS+cdeKS16D+kY/7UxfXsr0z04AK4rOap9FvE4pduLoaLPyqp7r933oOcPpA5
	22Fq+Sd1UNS6xexZ3dXHwqCYKgFs7KvFhK90ZA7U0FhiGtNRNIGiVyr4zLMtr7FeW9EF0uds5vh
	SBm5aPe7+uilQ3NQIX7C1Lmm0fyhasM2x4SN0Zgv+aM7hJktUAyFpqmHTAVDin2YBFea8d0jdL6
	pVUGo95HN/Aug+McLG+8NhHDEKetxqooo5OiqDIW0Gc1wNJAJfFUxEYs/0vffCmGsNy6wKRcmNW
	HsrrTOvjWTCW/wT+5JJeJ0XQArg38=
X-Received: by 2002:a05:600c:3e8d:b0:475:dd89:ac7 with SMTP id 5b1f17b1804b1-47717df7ef0mr2442695e9.1.1761582301726;
        Mon, 27 Oct 2025 09:25:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcpfk6BDA32rXrYsquQ4cz9qgC2WRauB7zTOhtVhTNHZoQZbKrXzlM5wPgRBa5cEga5fDZQQ==
X-Received: by 2002:a05:600c:3e8d:b0:475:dd89:ac7 with SMTP id 5b1f17b1804b1-47717df7ef0mr2442105e9.1.1761582301286;
        Mon, 27 Oct 2025 09:25:01 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3f:4b00:ee13:8c22:5cc5:d169? (p200300d82f3f4b00ee138c225cc5d169.dip0.t-ipconnect.de. [2003:d8:2f3f:4b00:ee13:8c22:5cc5:d169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd01c07fsm74064275e9.2.2025.10.27.09.24.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 09:25:00 -0700 (PDT)
Message-ID: <14030818-52e7-41eb-8ad7-602f3476d448@redhat.com>
Date: Mon, 27 Oct 2025 17:24:57 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/13] mm: introduce generic lazy_mmu helpers
To: Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
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
 sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org
References: <20251015082727.2395128-1-kevin.brodsky@arm.com>
 <20251015082727.2395128-7-kevin.brodsky@arm.com>
 <73b274b7-f419-4e2e-8620-d557bac30dc2@redhat.com>
 <390e41ae-4b66-40c1-935f-7a1794ba0b71@arm.com>
 <f8d22ae0-4e36-4537-903f-28164c850fdb@redhat.com>
 <28bf77c0-3aa9-4c41-aa2b-368321355dbb@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZoEEwEIAEQCGwMCF4ACGQEFCwkIBwICIgIG
 FQoJCAsCBBYCAwECHgcWIQQb2cqtc1xMOkYN/MpN3hD3AP+DWgUCaJzangUJJlgIpAAKCRBN
 3hD3AP+DWhAxD/9wcL0A+2rtaAmutaKTfxhTP0b4AAp1r/eLxjrbfbCCmh4pqzBhmSX/4z11
 opn2KqcOsueRF1t2ENLOWzQu3Roiny2HOU7DajqB4dm1BVMaXQya5ae2ghzlJN9SIoopTWlR
 0Af3hPj5E2PYvQhlcqeoehKlBo9rROJv/rjmr2x0yOM8qeTroH/ZzNlCtJ56AsE6Tvl+r7cW
 3x7/Jq5WvWeudKrhFh7/yQ7eRvHCjd9bBrZTlgAfiHmX9AnCCPRPpNGNedV9Yty2Jnxhfmbv
 Pw37LA/jef8zlCDyUh2KCU1xVEOWqg15o1RtTyGV1nXV2O/mfuQJud5vIgzBvHhypc3p6VZJ
 lEf8YmT+Ol5P7SfCs5/uGdWUYQEMqOlg6w9R4Pe8d+mk8KGvfE9/zTwGg0nRgKqlQXrWRERv
 cuEwQbridlPAoQHrFWtwpgYMXx2TaZ3sihcIPo9uU5eBs0rf4mOERY75SK+Ekayv2ucTfjxr
 Kf014py2aoRJHuvy85ee/zIyLmve5hngZTTe3Wg3TInT9UTFzTPhItam6dZ1xqdTGHZYGU0O
 otRHcwLGt470grdiob6PfVTXoHlBvkWRadMhSuG4RORCDpq89vu5QralFNIf3EysNohoFy2A
 LYg2/D53xbU/aa4DDzBb5b1Rkg/udO1gZocVQWrDh6I2K3+cCs7BTQRVy5+RARAA59fefSDR
 9nMGCb9LbMX+TFAoIQo/wgP5XPyzLYakO+94GrgfZjfhdaxPXMsl2+o8jhp/hlIzG56taNdt
 VZtPp3ih1AgbR8rHgXw1xwOpuAd5lE1qNd54ndHuADO9a9A0vPimIes78Hi1/yy+ZEEvRkHk
 /kDa6F3AtTc1m4rbbOk2fiKzzsE9YXweFjQvl9p+AMw6qd/iC4lUk9g0+FQXNdRs+o4o6Qvy
 iOQJfGQ4UcBuOy1IrkJrd8qq5jet1fcM2j4QvsW8CLDWZS1L7kZ5gT5EycMKxUWb8LuRjxzZ
 3QY1aQH2kkzn6acigU3HLtgFyV1gBNV44ehjgvJpRY2cC8VhanTx0dZ9mj1YKIky5N+C0f21
 zvntBqcxV0+3p8MrxRRcgEtDZNav+xAoT3G0W4SahAaUTWXpsZoOecwtxi74CyneQNPTDjNg
 azHmvpdBVEfj7k3p4dmJp5i0U66Onmf6mMFpArvBRSMOKU9DlAzMi4IvhiNWjKVaIE2Se9BY
 FdKVAJaZq85P2y20ZBd08ILnKcj7XKZkLU5FkoA0udEBvQ0f9QLNyyy3DZMCQWcwRuj1m73D
 sq8DEFBdZ5eEkj1dCyx+t/ga6x2rHyc8Sl86oK1tvAkwBNsfKou3v+jP/l14a7DGBvrmlYjO
 59o3t6inu6H7pt7OL6u6BQj7DoMAEQEAAcLBfAQYAQgAJgIbDBYhBBvZyq1zXEw6Rg38yk3e
 EPcA/4NaBQJonNqrBQkmWAihAAoJEE3eEPcA/4NaKtMQALAJ8PzprBEXbXcEXwDKQu+P/vts
 IfUb1UNMfMV76BicGa5NCZnJNQASDP/+bFg6O3gx5NbhHHPeaWz/VxlOmYHokHodOvtL0WCC
 8A5PEP8tOk6029Z+J+xUcMrJClNVFpzVvOpb1lCbhjwAV465Hy+NUSbbUiRxdzNQtLtgZzOV
 Zw7jxUCs4UUZLQTCuBpFgb15bBxYZ/BL9MbzxPxvfUQIPbnzQMcqtpUs21CMK2PdfCh5c4gS
 sDci6D5/ZIBw94UQWmGpM/O1ilGXde2ZzzGYl64glmccD8e87OnEgKnH3FbnJnT4iJchtSvx
 yJNi1+t0+qDti4m88+/9IuPqCKb6Stl+s2dnLtJNrjXBGJtsQG/sRpqsJz5x1/2nPJSRMsx9
 5YfqbdrJSOFXDzZ8/r82HgQEtUvlSXNaXCa95ez0UkOG7+bDm2b3s0XahBQeLVCH0mw3RAQg
 r7xDAYKIrAwfHHmMTnBQDPJwVqxJjVNr7yBic4yfzVWGCGNE4DnOW0vcIeoyhy9vnIa3w1uZ
 3iyY2Nsd7JxfKu1PRhCGwXzRw5TlfEsoRI7V9A8isUCoqE2Dzh3FvYHVeX4Us+bRL/oqareJ
 CIFqgYMyvHj7Q06kTKmauOe4Nf0l0qEkIuIzfoLJ3qr5UyXc2hLtWyT9Ir+lYlX9efqh7mOY
 qIws/H2t
In-Reply-To: <28bf77c0-3aa9-4c41-aa2b-368321355dbb@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24.10.25 16:32, Kevin Brodsky wrote:
> On 24/10/2025 15:27, David Hildenbrand wrote:
>> On 24.10.25 14:13, Kevin Brodsky wrote:
>>> On 23/10/2025 21:52, David Hildenbrand wrote:
>>>> On 15.10.25 10:27, Kevin Brodsky wrote:
>>>>> [...]
>>>>>
>>>>> * madvise_*_pte_range() call arch_leave() in multiple paths, some
>>>>>      followed by an immediate exit/rescheduling and some followed by a
>>>>>      conditional exit. These functions assume that they are called
>>>>>      with lazy MMU disabled and we cannot simply use pause()/resume()
>>>>>      to address that. This patch leaves the situation unchanged by
>>>>>      calling enable()/disable() in all cases.
>>>>
>>>> I'm confused, the function simply does
>>>>
>>>> (a) enables lazy mmu
>>>> (b) does something on the page table
>>>> (c) disables lazy mmu
>>>> (d) does something expensive (split folio -> take sleepable locks,
>>>>       flushes tlb)
>>>> (e) go to (a)
>>>
>>> That step is conditional: we exit right away if pte_offset_map_lock()
>>> fails. The fundamental issue is that pause() must always be matched with
>>> resume(), but as those functions look today there is no situation where
>>> a pause() would always be matched with a resume().
>>
>> We have matches enable/disable, so my question is rather "why" you are
>> even thinking about using pause/resume?
>>
>> What would be the benefit of that? If there is no benefit then just
>> drop this from the patch description as it's more confusing than just
>> ... doing what the existing code does :)
> 
> Ah sorry I misunderstood, I guess you originally meant: why would we use
> pause()/resume()?
> 
> The issue is the one I mentioned in the commit message: using
> enable()/disable(), we assume that the functions are called with lazy
> MMU mode is disabled. Consider:
> 
>    lazy_mmu_mode_enable()
>    madvise_cold_or_pageout_pte_range():
>      lazy_mmu_mode_enable()
>      ...
>      if (need_resched()) {
>        lazy_mmu_mode_disable()
>        cond_resched() // lazy MMU still enabled
>      }
> 
> This will explode on architectures that do not allow sleeping while in
> lazy MMU mode. I'm not saying this is an actual problem - I don't see
> why those functions would be called with lazy MMU mode enabled. But it
> does go against the notion that nesting works everywhere.

I would tackle it from a different direction: if code calls with lazy 
MMU enabled into random other code that might sleep, that caller would 
be wrong.

It's not about changing functions like this to use pause/resume.

Maybe the rule is simple: if you enable the lazy MMU, don't call any 
functions that might sleep.

Maybe we could support that later by handling it before/after sleeping, 
if ever required?

Or am I missing something regarding your point on pause()/resume()?

-- 
Cheers

David / dhildenb


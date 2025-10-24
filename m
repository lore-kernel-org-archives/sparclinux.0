Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DF42D3A75
	for <sparclinux@vger.kernel.org>; Fri, 24 Oct 2025 13:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761312460; cv=none; b=qdxfXoeTOeDFzxliJHmtw2VFAC+leIP5ReE6ZYntZ24eq7MVvCqVjDv8M0u15xESKr+/JzrwizLj985KV+3V861/byh8eMxZpA0yelSU4tELNDlO2nXBv9jNvpI5qQ1JhzohOcyreD7EOpUpySB7bxzfuTF+W1in8/5DlvMJW+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761312460; c=relaxed/simple;
	bh=2ZUHwXp2ysaRQs0zSD5QmaM8wmm4U6/OQbUL7/FYLSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g8eWqe/PUqOsIT0tiQ0VM8+WChvcaOufeu5YL7LjgVccygkKvyDdXTfIwILtRQHuCpalI5YSymPYPyPFHyJv7ykkLZdQMcVvqTElhFJ5nVdKl06UcS5fKRFOv/2RbzuHaNZn2b/z7QAn9gIK7va9y93P6Nr2O1PDA3Y4PC2mik4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EQ9cqlHY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EQ9cqlHY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761312458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=W95gCkBxowoa8sjYCMILYw6pqqluuwtxuEqICefNFQ8=;
	b=EQ9cqlHYeA+Irl1jc/Y/4xpr8sngwljhpizjQoVhiCDNTXiGWBR82HclDrm/eRDudUjJAb
	gZYQzvMaqbKKJf7PyubkSY//kEWLKKNnvErQzmDij9dZA54HZRmjZLa64DQHjp7pVxUcyd
	4owDdD+OpfREioM3SYxjzw8mz+wJ7DM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50--Kb2tlN9MWaN7g8-0yUjmA-1; Fri, 24 Oct 2025 09:27:36 -0400
X-MC-Unique: -Kb2tlN9MWaN7g8-0yUjmA-1
X-Mimecast-MFC-AGG-ID: -Kb2tlN9MWaN7g8-0yUjmA_1761312456
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-42992cb2ee8so162518f8f.3
        for <sparclinux@vger.kernel.org>; Fri, 24 Oct 2025 06:27:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761312455; x=1761917255;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W95gCkBxowoa8sjYCMILYw6pqqluuwtxuEqICefNFQ8=;
        b=TmxxEaNFlYW93x+6M0nRfz6x5pjTMT7mY2btxzB4prATXdL1e1pMa737JTmqlkexVG
         Uzok5ScZ8ciZNkVKwy1PyWEOMEvzlw3nIKbHNeRYa3qI3yJDvEwviEKLNGD81TD1+bjg
         Cp6stl55kiIO+1wqKtFaGsd3YMN9VKsY1VPZQWnr+a5LE88erJB2lCvsY3j+ec2kCcVH
         30q7O7jOc8gHNiOXMIJfnxldmflDO83Ephp6TkornTcTkl26LDMNU3/7wvuUUBWKkQcP
         wrGNM3YHNLqui9fcrmuM9hSV8rlW1NB/JW/jQA+h7mJCkcKq7D3DwyvlRgdfE9bMUom0
         LteQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQEQDF+fJERSHij6IqY6wNC2kepJgavd0Owvop8LvhBi/yLTiONBjXJ49BhlBl3arQYXuZ/+aBMNEF@vger.kernel.org
X-Gm-Message-State: AOJu0YzgrZc0hWLIgcNh6P2Z+dDDEbmtS8nG0fjrcchN3S+dQiyDUWlY
	OeFbgEiaoki7xf1M9/b4I3Nh1CV/WUj/SkG8noTVvU3D5oWUyqap17gK1p1vJMUZB6QjWmny5i+
	gQ/0iW9+oFHuYfxIWcHM/Oq5OjRbBDXs1U9KPZzPvZzcTXj9bLpKWBDVKiU+b3zo=
X-Gm-Gg: ASbGncu1V5WfykFB8Jk0KrryhqugaxjXjEaqD+30rJ5ma26Emxe043821dgITebytdE
	vN8YJhatSPkA0VFDXjieQ+FB/42cdWVNL3W1eko10SIhbPY9NMBos+Hf8xN1HbZfWEFTs0DmRGp
	fmHsC4aiH1ZWSlH8vFAjcy3W4f6GjOVFF60QTy/4Dny4HzRiz978fLDoUArRsEIq9oNbXBYlLrI
	oiwnTE74o1oIHGVyuA/9Mn2/YMnq7QabUmULzJ1zttPrhT7YNXPXGr9eEVMxrMIieCV4EwwM7sl
	hzfamd6BQjWyQm8k7XlFpvsX40xUX6qoqm9N+sNslP1w4Fhh/u+jn1ItMkIERnLXCLVtkGkBZUo
	lCKQ9+JgVOLLiZZF7GBGPWlu2kSdkVuNrSecjSNMDp1C+UPsiYYgN16uGUXVbAXxcukWI5+jwoY
	32g6Azqbem5Yc0IgglIcj2FTzzokI=
X-Received: by 2002:a5d:5f82:0:b0:3fa:5925:4b07 with SMTP id ffacd0b85a97d-42704d74f9fmr17804288f8f.18.1761312455512;
        Fri, 24 Oct 2025 06:27:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6q4w15VA7XMPgV1osu1aNNaqJ9bER4GrjuNDgzSEl5cHuxzuUI4S5/OhMi/rPVse+Lx9Gyg==
X-Received: by 2002:a5d:5f82:0:b0:3fa:5925:4b07 with SMTP id ffacd0b85a97d-42704d74f9fmr17804231f8f.18.1761312454926;
        Fri, 24 Oct 2025 06:27:34 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3? (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429898ccc60sm9453555f8f.34.2025.10.24.06.27.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 06:27:34 -0700 (PDT)
Message-ID: <f8d22ae0-4e36-4537-903f-28164c850fdb@redhat.com>
Date: Fri, 24 Oct 2025 15:27:32 +0200
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
In-Reply-To: <390e41ae-4b66-40c1-935f-7a1794ba0b71@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24.10.25 14:13, Kevin Brodsky wrote:
> On 23/10/2025 21:52, David Hildenbrand wrote:
>> On 15.10.25 10:27, Kevin Brodsky wrote:
>>> [...]
>>>
>>> * madvise_*_pte_range() call arch_leave() in multiple paths, some
>>>     followed by an immediate exit/rescheduling and some followed by a
>>>     conditional exit. These functions assume that they are called
>>>     with lazy MMU disabled and we cannot simply use pause()/resume()
>>>     to address that. This patch leaves the situation unchanged by
>>>     calling enable()/disable() in all cases.
>>
>> I'm confused, the function simply does
>>
>> (a) enables lazy mmu
>> (b) does something on the page table
>> (c) disables lazy mmu
>> (d) does something expensive (split folio -> take sleepable locks,
>>      flushes tlb)
>> (e) go to (a)
> 
> That step is conditional: we exit right away if pte_offset_map_lock()
> fails. The fundamental issue is that pause() must always be matched with
> resume(), but as those functions look today there is no situation where
> a pause() would always be matched with a resume().

We have matches enable/disable, so my question is rather "why" you are 
even thinking about using pause/resume?

What would be the benefit of that? If there is no benefit then just drop 
this from the patch description as it's more confusing than just ... 
doing what the existing code does :)

>>
>> Why would we use enable/disable instead?
>>
>>>
>>> * x86/Xen is currently the only case where explicit handling is
>>>     required for lazy MMU when context-switching. This is purely an
>>>     implementation detail and using the generic lazy_mmu_mode_*
>>>     functions would cause trouble when nesting support is introduced,
>>>     because the generic functions must be called from the current task.
>>>     For that reason we still use arch_leave() and arch_enter() there.
>>
>> How does this interact with patch #11?
> 
> It is a requirement for patch 11, in fact. If we called disable() when
> switching out a task, then lazy_mmu_state.enabled would (most likely) be
> false when scheduling it again.
> 
> By calling the arch_* helpers when context-switching, we ensure
> lazy_mmu_state remains unchanged. This is consistent with what happens
> on all other architectures (which don't do anything about lazy_mmu when
> context-switching). lazy_mmu_state is the lazy MMU status *when the task
> is scheduled*, and should be preserved on a context-switch.

Okay, thanks for clarifying. That whole XEN stuff here is rather horrible.

> 
>>
>>>
>>> Note: x86 calls arch_flush_lazy_mmu_mode() unconditionally in a few
>>> places, but only defines it if PARAVIRT_XXL is selected, and we are
>>> removing the fallback in <linux/pgtable.h>. Add a new fallback
>>> definition to <asm/pgtable.h> to keep things building.
>>
>> I can see a call in __kernel_map_pages() and
>> arch_kmap_local_post_map()/arch_kmap_local_post_unmap().
>>
>> I guess that is ... harmless/irrelevant in the context of this series?
> 
> It should be. arch_flush_lazy_mmu_mode() was only used by x86 before
> this series; we're adding new calls to it from the generic layer, but
> existing x86 calls shouldn't be affected.

Okay, I'd like to understand the rules when arch_flush_lazy_mmu_mode() 
would actually be required in such arch code, but that's outside of the 
scope of your patch series.


-- 
Cheers

David / dhildenb


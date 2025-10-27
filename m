Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7290C301484
	for <sparclinux@vger.kernel.org>; Mon, 27 Oct 2025 12:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761568171; cv=none; b=pG+tDybex+G8jgnfO4c4E5uy/xJ7dRFQm8mkDEtRs3rdX7ojkhFdMCxiPFc5RjkiyANx6+nNiHNrSSyRWrLb7l7uqXMOCHFAMqZEcscWxa9rOJurdE5PuCugUILaF30TB62gLdM+G9ikc07pzJAHVdNIPBOjdM9PZTBA2SArH1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761568171; c=relaxed/simple;
	bh=2eZ1btl2CBfiYOG5G4mlQs9bkLnd3qOs11pVNrpDFs0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=reKdmnuP/BSxHKZhr4K8vqCRyc70bs0RwE8OvKul4qgjyRrNSEdVwki9O2lZtzzR/OZHRj3V+7bhv5szAod86SGXf/jyj8otnASOpMBkJcUiw6ZKmh54wX4C8f5IL9JvHUb8q6OjyRUukOrdC7deNYhwMBYrz59vTb4CsWv7Px4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GjzL7CDj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GjzL7CDj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761568168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MxqhGs+kErj9QojSUYfqhMME1C+HzYz58U9mBz2oLoo=;
	b=GjzL7CDj0S0BLc5W69u1/FuWZP+xXmM0qsQ+oWjgr07ChdsV2F/b3jTNxuBUL6QHHgCelZ
	VLDaz/WWXZURQtMj2RN7LzIXgDso00pMrUat2qCbJ5oxy6Fs0IuzdP7yXHugMpLoCclouv
	QKCKBey16vgVRZWgmpx9u/rIram8z1E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-xIc5wZNSNtiSV1DR0n624Q-1; Mon, 27 Oct 2025 08:29:26 -0400
X-MC-Unique: xIc5wZNSNtiSV1DR0n624Q-1
X-Mimecast-MFC-AGG-ID: xIc5wZNSNtiSV1DR0n624Q_1761568166
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47106720618so31779765e9.1
        for <sparclinux@vger.kernel.org>; Mon, 27 Oct 2025 05:29:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761568165; x=1762172965;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MxqhGs+kErj9QojSUYfqhMME1C+HzYz58U9mBz2oLoo=;
        b=QYkaHVf9dYm/48/DDU0geZGtGLxuS81EnQD60wxKBlsJLXgDi+SfHJC1ag18KV0vbe
         kon+JRKOwmetbBYTofsMut5v+BRkA66FTh/KRas/eJ1wav7aUbwQnV9njvHUnlCF6AQ5
         4sYmqIchrfzMte0I9O6eYRM/HH/HY7eJaQ6ZDVV5pK0lhmipjlObhAtWdWAcg31B0sVf
         iQWltJzgur6ebhSLor9yBfb+xBwXvH7V2p0z82omRA2nr3sUlIEaMh91ipPfeToaeSzL
         PtBW3GABFMDoxLJY2SL/J29ce6shqXgu+y/7Cm7tt/NnC0RlAgs9tJ7Oa0qpiEgNoc+J
         d2Gw==
X-Forwarded-Encrypted: i=1; AJvYcCU/4R98B5EbxNxdnHl8gQqWK4/ule5pu9+4s8jOUpOhYBUYuQ37d8LmyXrtH+Gn3UDUtbCp6xdStF8N@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7/u4wyFF8KF5i7CdYP2B0AT7CUmQZM6EL+APyQFQFbFTxrnl8
	LgdF90A90GQtQyk/gA0jgNuI/9HopbRTG4S5DUMfHdnp+OXHvfNuf9qmpzA5F2AjiQKriA70bU0
	a3MzZ6UKT9XNRoa4Oerbiy9uXdE6/lJd04c5GGWLvXbHM7NagCfEiXvaIWK7v88o=
X-Gm-Gg: ASbGnctR95ce3/DuYNYnL0cLT8e53TIb03b2w/DQtYctMUo57Lqj2bgchDI+7NXf8s3
	tekvks8RH4iyo/LqhyU7I+BCyrlJr4hz5kK+/c+3hx3OloGo30pkdzLcIsbiDJIH13j5bYfmjCa
	gMUuEVcEkm1Ekz3SHEtGUwnMmzneFR/RPD5ooBfLn6v2If3Uof/RHYi7nU8HVgnit677oWaslzH
	C0SpR22ctTtCUsfXKWjsknivK2k48nFTFREycxoxqAqgkGWyfERg8RuzgCj3MDeFeTdFizXnNhy
	rcJ4eeYEIlpaZNdcsqH+sdjMt+ujz3YLIHMpKpgc5rgfRiJYjIEnIZTKWFRXeOCARhEhSgEIluG
	lBYbdQHO8DAnKwHe+xXEwFj1NZ0jRyAmzSj+lkb+twuJqERsio3pw7+giYjGmewYy9Yi3MjrkpL
	WHqKG6u3O9t/Gi7yCTYy6L2bFjzkQ=
X-Received: by 2002:a05:600c:6814:b0:46d:b665:1d95 with SMTP id 5b1f17b1804b1-475d2ed2703mr122459085e9.32.1761568165604;
        Mon, 27 Oct 2025 05:29:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERhDOSgpdu7IOhGUhd5vG2oGfH+FtLLHQ8h3X53cAF/bER/zOT53Nw9I8J5TYzsbcubMUbyA==
X-Received: by 2002:a05:600c:6814:b0:46d:b665:1d95 with SMTP id 5b1f17b1804b1-475d2ed2703mr122458775e9.32.1761568165180;
        Mon, 27 Oct 2025 05:29:25 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3f:4b00:ee13:8c22:5cc5:d169? (p200300d82f3f4b00ee138c225cc5d169.dip0.t-ipconnect.de. [2003:d8:2f3f:4b00:ee13:8c22:5cc5:d169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952db99asm14109118f8f.32.2025.10.27.05.29.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 05:29:24 -0700 (PDT)
Message-ID: <6c9bd0c6-0968-41ac-b0b4-53c881748cfb@redhat.com>
Date: Mon, 27 Oct 2025 13:29:22 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/13] x86/xen: use lazy_mmu_state when
 context-switching
To: Demi Marie Obenour <demiobenour@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, Kevin Brodsky
 <kevin.brodsky@arm.com>, linux-mm@kvack.org
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
 <20251015082727.2395128-12-kevin.brodsky@arm.com>
 <f0067f35-1048-4788-8401-f71d297f56f3@redhat.com>
 <348e5f1c5a90e4ab0f14b4d997baf7169745bf04.camel@infradead.org>
 <70723f4a-f42b-4d94-9344-5824e48bfad1@redhat.com>
 <3ff4aaeb-61ce-4b72-ba90-1b66374b1b95@gmail.com>
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
In-Reply-To: <3ff4aaeb-61ce-4b72-ba90-1b66374b1b95@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.10.25 00:52, Demi Marie Obenour wrote:
> On 10/24/25 10:51, David Hildenbrand wrote:
>> On 24.10.25 16:47, David Woodhouse wrote:
>>> On Thu, 2025-10-23 at 22:06 +0200, David Hildenbrand wrote:
>>>> On 15.10.25 10:27, Kevin Brodsky wrote:
>>>>> We currently set a TIF flag when scheduling out a task that is in
>>>>> lazy MMU mode, in order to restore it when the task is scheduled
>>>>> again.
>>>>>
>>>>> The generic lazy_mmu layer now tracks whether a task is in lazy MMU
>>>>> mode in task_struct::lazy_mmu_state. We can therefore check that
>>>>> state when switching to the new task, instead of using a separate
>>>>> TIF flag.
>>>>>
>>>>> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
>>>>> ---
>>>>
>>>>
>>>> Looks ok to me, but I hope we get some confirmation from x86 / xen
>>>> folks.
>>>
>>>
>>> I know tglx has shouted at me in the past for precisely this reminder,
>>> but you know you can test Xen guests under QEMU/KVM now and don't need
>>> to actually run Xen? Has this been boot tested?
>>
>> And after that, boot-testing sparc as well? :D
>>
>> If it's easy, why not. But other people should not suffer for all the
>> XEN hacks we keep dragging along.
> 
> Which hacks?  Serious question.  Is this just for Xen PV or is HVM
> also affected?

In the context of this series, XEN_LAZY_MMU.

Your question regarding PV/HVM emphasizes my point: how is a submitter 
supposed to know which XEN combinations to test (and how to test them), 
to not confidentially break something here.

We really need guidance+help from the XEN folks here.

-- 
Cheers

David / dhildenb


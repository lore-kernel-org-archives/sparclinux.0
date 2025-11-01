Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7D42F6182
	for <sparclinux@vger.kernel.org>; Sat,  1 Nov 2025 12:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761998739; cv=none; b=aIy1RzaVVwDsYdSLndXrcv4NhaO/MGqkiijddODGAdYMBpMEIB4YSuayh/F/pcp8f5UwGJkYUd3oF90ppBX1SkT7VoEmEFYv1/F9/+xgYpRTq5i0IOUOHTYiSNL/0h3T+vRCqaojEtIBc2h4WHBM7xHTpRth65jLr8Gvku3TJFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761998739; c=relaxed/simple;
	bh=J7IUCZ0bPZlXR+tr1rXTk63Za+FR2mBxuCqIX9ssnMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N6FV9DgvN+T62g94gfDSS6h1WIN2YLMUkwcn5CnZ/u2mB7IdnZMb66FbxAIrQNPEtb1V/EDKls8v3YCyie8XH1ioNURYI7YT5vfFn7wz1+GXaNMNFjceES9hBY7E0iWZsfa5fvaZHFa7oHNhqwnk2vyswXsvy/ZM5x1HQypncOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R3OomEQS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=o4MnhvxJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R3OomEQS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="o4MnhvxJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761998737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kMG4ZrGhtDivlDXT9Lf+Em5Cw+QAoMNy/XfdlpySJK0=;
	b=R3OomEQSi205HBBbecAHzGWrPl8pHj/FPmcUyYufGgr0tfQqvRg0tayrkFn8hsG7G5xtUe
	8MmGWoxYvHnpheR8kYRCJITSHsjM14SEDoqgMbxiMWEPJ7EYSyK8KSGa8L/6vSsIbtivos
	XO39WSe8MxutZ+WnhHeGM/9bvCgS/rQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-53HQEOKaNqiAnyTNAXSuTg-1; Sat, 01 Nov 2025 08:05:36 -0400
X-MC-Unique: 53HQEOKaNqiAnyTNAXSuTg-1
X-Mimecast-MFC-AGG-ID: 53HQEOKaNqiAnyTNAXSuTg_1761998735
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-476b8c02445so24808905e9.1
        for <sparclinux@vger.kernel.org>; Sat, 01 Nov 2025 05:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1761998735; x=1762603535; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kMG4ZrGhtDivlDXT9Lf+Em5Cw+QAoMNy/XfdlpySJK0=;
        b=o4MnhvxJvzMFKP7boK6o+YuWkUtDwRf3zcmSdzRVbw1POaUKmrIOSpdbPg2S9JfQwg
         fOTS8t8Q6Xru/ApEKdxCMGFJT7b+rY+3EGBKzy9P7rkyPmnq7ertCWN5g2y7llVfgj4N
         QVAicjy6fvCARIT+q73afx6w6of+JHAj3lqG/p62C2g0lbDU7JXinc+IVqLsMFIKmnQe
         2HnEwuVCcS0E3pBfRRzNhq7mfUwykiVRiu8COiD+JyFdOP7pBV7Na0PaJUQkZsapdgjU
         XHU4A3GU5Slc5Zhm0IuAD/50HIKp67HlyjKGlgP/1VWK7nE5kBg/aRfM1NANf7lYtTsj
         Mqvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761998735; x=1762603535;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kMG4ZrGhtDivlDXT9Lf+Em5Cw+QAoMNy/XfdlpySJK0=;
        b=o4RgaKXWaXmMSxej2JFnwRPnTsXqMR/iUk1rbQ2T6/WdboubqS/nn8HSv5XEH5qQiA
         yyW40sY/27iDhDG+ji6r/aXlH0atpuXEccD8GvSiGXTM+7AiYC1Wg4kEfalaLsL9sSBR
         GRQkR3/lTFuni3clHJs+fYByzQqwLbTtAPwCL3EreZ1aPt7q8+3C91+d2d2PHG7l43Rs
         k4i5pCBbZf6gEjADPn5FfNVeVWiKmKi5ZWlw7TFQf9Wm4v9/GgVtp2wdIrzmTWTlsDbj
         CcaViBi4BncVU6ImnjGtNA9VAaHNE5RZAwpXGNtwgzAyK/d/YnDSItEd+BNsIgVDeWz6
         J21Q==
X-Forwarded-Encrypted: i=1; AJvYcCWRq5OivWgUic+y35I/LwUBMH6E/RrggCM/6DtSrIkrxhttn8wp6lxs6WFURELT8IXfs1R055j/XMZ4@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz1bPbA2FYI3fjKk3pqc5tARTs+/nGt2euqOTOyBVk12JBFiDw
	AqmHMsnx3BHE7NZqcguFvrnPNJ/ndHkNwKA8fS0xZSfvFHwCyWSCGnmpVP7AIOwbE8X2LLmvGd3
	NCJSj4S3X3SnN8/y1OrlW7tqTJusFOY9O3nhgbTGt2ZtwwyG0Ija8slX62gxEdZU=
X-Gm-Gg: ASbGncsAJ1z3T+z6VJ8E9JMpP91PkBhS1/pOCe2TxQyZ1eXW2DAwBJz5FNoIsOo1rUx
	WqstLtloO0SdKgD9vuc55ic8YYT9k4/2T+u7JnBTYqcuh3yF3F1cqEKKL2Fy7zNiDFPF8Xn7X4X
	uIlvO0Ew9RzOL9T9Bjf8SfPTpAQK8kAEgKlQBJ/rqg++aIE2QiV98f75ViB3Znr17PrUu+mHAhS
	TL5Wy2YQf/gREweyFOBxbb0EgudJ8O942Q7dYY3+f9L9lUFSE8uAk7cJVJTvUc2xlp6qVGsEtkJ
	bPuYuX5n7AStCvMbpKbdm+N59nkscLKlVP6ff1QkMMxnfJMGGKtOtSW6i15GaGQurvzIfx4VOHG
	3eL93UuVOP1gw/EEWXNuZhMZjtF8IkVwTK2FY6PmSjHk92qiLWcHWKo6ugT2XlLJIeyolZwV4q5
	ip9ZNNhviwQpaUILaT4WEWBIo73TI=
X-Received: by 2002:a05:600c:3e8f:b0:475:dac3:699f with SMTP id 5b1f17b1804b1-477307c1470mr61733585e9.9.1761998734810;
        Sat, 01 Nov 2025 05:05:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEswSMAFiCrNpu5lyiFxKzugAwsfKeFqrIXw4LJyG0OxPKZu66BGogk4vu+xHj3Hhqm/A5QqQ==
X-Received: by 2002:a05:600c:3e8f:b0:475:dac3:699f with SMTP id 5b1f17b1804b1-477307c1470mr61733085e9.9.1761998734330;
        Sat, 01 Nov 2025 05:05:34 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3f:4b00:ee13:8c22:5cc5:d169? (p200300d82f3f4b00ee138c225cc5d169.dip0.t-ipconnect.de. [2003:d8:2f3f:4b00:ee13:8c22:5cc5:d169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c374f84sm45678605e9.0.2025.11.01.05.05.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Nov 2025 05:05:33 -0700 (PDT)
Message-ID: <07861e97-757c-48b2-829c-d1b1b5df81a0@redhat.com>
Date: Sat, 1 Nov 2025 13:05:29 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/12] powerpc/64s: Do not re-activate batched TLB
 flush
To: Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
 Andreas Larsson <andreas@gaisler.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Borislav Petkov
 <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "David S. Miller" <davem@davemloft.net>,
 David Woodhouse <dwmw2@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>,
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
References: <20251029100909.3381140-1-kevin.brodsky@arm.com>
 <20251029100909.3381140-2-kevin.brodsky@arm.com>
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
In-Reply-To: <20251029100909.3381140-2-kevin.brodsky@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.10.25 11:08, Kevin Brodsky wrote:
> From: Alexander Gordeev <agordeev@linux.ibm.com>
> 
> Since commit b9ef323ea168 ("powerpc/64s: Disable preemption in hash
> lazy mmu mode") a task can not be preempted while in lazy MMU mode.
> Therefore, the batch re-activation code is never called, so remove it.
> 
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


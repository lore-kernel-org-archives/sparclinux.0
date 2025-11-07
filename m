Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0827B2E6CBC
	for <sparclinux@vger.kernel.org>; Fri,  7 Nov 2025 14:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762526049; cv=none; b=UxTZvZICRd6cc7qh3w4e3IYymrxvHiQ/+MdSqPqHG3MZpon18lOLYEke++TLJt1cdHI5lfNXcvc+3KdZaXuFwqvVObVcQaDQnEpfz0Ha6LozysHGGKiuNLM3eAIAbjU5xWquqpqLdVkSdJmgwTJUwnQPSqPt4ZuxWq/pJfn2a2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762526049; c=relaxed/simple;
	bh=p+EbVViZ0HHmBC49y1+e03KRt8G/c1UUaMtXhf2zuk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j6Z6O3lS/XWRsZ7bmAXMFcu5CLDUgZBusTY4jjU4kHO6dCQ1QEChpNQfCnXosvPEuIoC8oZEezTIioucX3o3bUJTrdoL7vuSIg41cvCguV0rVgXUs8Gy38jfzrdSk7a8+XkTp59156QEylrpS9xEgUI4RdM+pww1mr8VsNddkQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jhP8L9fa; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhP8L9fa"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42557c5cedcso505764f8f.0
        for <sparclinux@vger.kernel.org>; Fri, 07 Nov 2025 06:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762526046; x=1763130846; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U9gy2Et/tdx42KkCuY9tv69YTLaLyxM7iG0J3rCGUz8=;
        b=jhP8L9fas13bVwOjejEiQtw9ioKKl8PCl2WEGCV1eC6Om7VKcsdeshWb+8BSp+nD6K
         5/rhv+mVxz3qFF2HWv4fVGeyoxkz+bYCbulSQtlBGgNeGlCKty/olTdD2zDn0pH5ZSvp
         HwOc9nct3BfF8iitZXHM9dxTQ0aWwQUvCoV4BXVEiJKy85sjgfIEi1ICcuJxqBSmYUAh
         IzhoesarMfpmnRfivDTALbsAO/qg23bzgVuR2ffUMDi2b+a6KtGGakYILzBYD9nh+hSJ
         Lpn3UCq0PBYTmKINQRMJ4hVwMfhpOyuBneYT0kQuU0MzlL++wTL0rXZleEDBqRMpxJJf
         09PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762526046; x=1763130846;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U9gy2Et/tdx42KkCuY9tv69YTLaLyxM7iG0J3rCGUz8=;
        b=w8oo5m4VeFyx4xZuf6FArsq1G9olWC+a/PHhjUS8joMpcPJPLSXaCfrdB08LhrX749
         BsoWuncUYmAcRJp7WLi4yObb/C6JIjmLMDUCmpiDGDq7epnTrGtZQRbi42XNU1fGlQnW
         FaFNFk2jqjX2LGhu0NAK+2qzKST/ocBTcFhIpnTMeic+0o4su0ksbVMMBrNBTJ0MrlDy
         RsgPHgQoOV0Jp7o6xDd/Nica2PkdqCkI1E6pEsD3M17aDpRxD4UnOb/Fw1/J20RCOCdZ
         qeMz4xfkwS1ZBjOlmDp8lG+LEtxm+PjtF1ii5dlJsHxIqgyyhSkCjKrcxb7euQn9m+2l
         Ghzw==
X-Forwarded-Encrypted: i=1; AJvYcCXo0H4DDwsCTokLA32DcHL37bmBUwOpko+8S4HFHFjYmi9PyPTudEKxRnrzwU/QxVO+BqWL+rkfboT4@vger.kernel.org
X-Gm-Message-State: AOJu0YxqRYqibMbmOHfXUPvgZm1qUyPZrJuseY1lFWsJWzU7ngjwa6PY
	0w0jQ8MXRihcET8+v+yEk7YjzT+zWhT/6ILdPYUVKTOcb6eRHtQpPWFr
X-Gm-Gg: ASbGncufSqqn6ENzHveK8lEUXPlgAG/HN8KczJRulwOJOGRd+Z2rqq4WTWhLDNc3HPj
	7kin6O4koc1Yvv6vR1P2iZrk7NtQTlyoIk336BKdKcreh4GZ5dAvSulawQ8dCJTrfHnoL/OG7Q4
	U9fPJYCiKeZKLL6kdRb0iFvSpy0lji9QRSmgawtgnwVZxhvk+wrdofDcTZOTOiQ3qSrh9dHFTsm
	R2yTGCFadD63sRThGYYpMy7Tr+G4VAI/G2lAp/hG3odIK2QFfGc9G8JE5OiR6mDyP0EPOSJO1l1
	fP9p6qxk76FUeFMH2XmFqEhzfzEDQYBX+aIbuaZbrBBQdqCoFxsXzjm3tzTYd9wNORvg8Gf1QmQ
	n5gnqZs92E1g+l60uP1fAIaP+q4HqQVejNGF1elGPs3s1D3a2EfNMGEM1IBZ+MFDgBYvQ7Jn/Z7
	ftjVcb6T/OMjUTeU+miCNqkcO2RZcMbSuLJ/NS+RLuc/C5ZiY43KBaxvxzZOwMzA6WzPzGzTbhn
	R/HvXZbzqSFoRt66B4Z4uYH+7qSpw4=
X-Google-Smtp-Source: AGHT+IEbeI8C8CzNAXSH/bs89gWIf/ZmK+BLjDzXB4QFwcXH6hASOjwiIfYomA42vxdn493DYIICBw==
X-Received: by 2002:a05:6000:2084:b0:427:e1bf:13bd with SMTP id ffacd0b85a97d-42ae5adfd73mr3148986f8f.52.1762526045768;
        Fri, 07 Nov 2025 06:34:05 -0800 (PST)
Received: from ?IPV6:2003:d8:2f30:b00:cea9:dee:d607:41d? (p200300d82f300b00cea90deed607041d.dip0.t-ipconnect.de. [2003:d8:2f30:b00:cea9:dee:d607:41d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac67845ccsm5465086f8f.36.2025.11.07.06.34.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 06:34:05 -0800 (PST)
Message-ID: <c764489e-0626-4a50-87b5-39e15d9db733@gmail.com>
Date: Fri, 7 Nov 2025 15:34:03 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/12] mm: introduce generic lazy_mmu helpers
To: Ryan Roberts <ryan.roberts@arm.com>, Kevin Brodsky
 <kevin.brodsky@arm.com>, linux-mm@kvack.org
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
 Peter Zijlstra <peterz@infradead.org>, Suren Baghdasaryan
 <surenb@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>,
 Yeoreum Yun <yeoreum.yun@arm.com>, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
 xen-devel@lists.xenproject.org, x86@kernel.org
References: <20251029100909.3381140-1-kevin.brodsky@arm.com>
 <20251029100909.3381140-7-kevin.brodsky@arm.com>
 <71418b31-aedb-4600-9558-842515dd6c44@arm.com>
From: "David Hildenbrand (Red Hat)" <davidhildenbrandkernel@gmail.com>
Content-Language: en-US
In-Reply-To: <71418b31-aedb-4600-9558-842515dd6c44@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>   #ifndef pte_batch_hint
>> diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
>> index 5d2a876035d6..c49b029d3593 100644
>> --- a/mm/kasan/shadow.c
>> +++ b/mm/kasan/shadow.c
>> @@ -305,7 +305,7 @@ static int kasan_populate_vmalloc_pte(pte_t *ptep, unsigned long addr,
>>   	pte_t pte;
>>   	int index;
>>   
>> -	arch_leave_lazy_mmu_mode();
>> +	lazy_mmu_mode_pause();
> 
> I wonder if there really are use cases that *require* pause/resume? I think
> these kasan cases could be correctly implemented using a new nest level instead?
> Are there cases where the effects really need to be immediate or do the effects
> just need to be visible when you get to where the resume is?
> 
> If the latter, that could just be turned into a nested disable (e.g. a flush).
> In this case, there is only 1 PTE write so no benefit, but I wonder if other
> cases may have more PTE writes that could then still be batched. It would be
> nice to simplify the API by removing pause/resume if we can?

It has clear semantics, clearer than some nest-disable IMHO.

Maybe you can elaborate how you would change ("simplify") the API in 
that regard? What would the API look like?

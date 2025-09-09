Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887C9274B5D
	for <sparclinux@vger.kernel.org>; Tue,  9 Sep 2025 09:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757408864; cv=none; b=M8d34sboynun1ZZPLK3vyxkPA8elvOREHGjbIoVdqq0FyyDiCfQQMd/9S29mTB4JJLZJz3j/OqjnUBhMxXLtKeqOwJ0W23jr+JK6jT/m1d7UZIa1RCtZMQ1GA970bSs5Efk2t4VNfsXjKY/DnAeP9lZL60ukFZ34wmYjPhG4IMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757408864; c=relaxed/simple;
	bh=5oN04YzrbbUs4MM+YtXO247v3vRfzCAdNsuETje/ukw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m4m4imJT4AGBquziN3pzTmQs/UpWEmi7a/svkL+MvDEv8BIBGBsrk6CZvNwSnkltvNgmYvlg/n08fLwY1fQS4stBvTH7KhPauizsl2jMnQpN7FaVJa2NZJDpm78q8jfeAA/WKD5dwOgQl0ft9ndqJAiKs4rkFUOv8+r4rvCtgfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Flnv04g4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Flnv04g4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757408861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wfLFN6eNqIPI3eYn2mOCbZpQPxjwFCGNIowHmmpIIeQ=;
	b=Flnv04g4BCDwhTa3Te2nd4UcEtZikSvaj5bIKeDTdNkORNU8G53l+63BLDD1z0tdO/t4AY
	hTXVsahiww91T+h9AzU9219OYaYlO/xUk/I78X1fGMDzOXQ5ObK6+lJO/owirQqlWgYF61
	yVyy4I8tKYgg3Slx7xjqomJpeyXUm4g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-b5B-edK9PZ6jIk3pFyCv8A-1; Tue, 09 Sep 2025 05:07:40 -0400
X-MC-Unique: b5B-edK9PZ6jIk3pFyCv8A-1
X-Mimecast-MFC-AGG-ID: b5B-edK9PZ6jIk3pFyCv8A_1757408859
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45cb5dbda9cso33005525e9.2
        for <sparclinux@vger.kernel.org>; Tue, 09 Sep 2025 02:07:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757408859; x=1758013659;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wfLFN6eNqIPI3eYn2mOCbZpQPxjwFCGNIowHmmpIIeQ=;
        b=XI84z7GOh6ZrHjX6V8BTUm9oCdl+5p4O8Qh1IJhs4A9iuOcYU0MnPVP1m0LLf5tf4m
         e25fsRNnaAPRNyuo6czqevtdMh0Jhbo2ka2rSad3e9PBdF23cJxUL7HFu03s6eLJyXqd
         NeAw+CZCINx9kVktsq1JgQUyEEY2dau2wYoxDqu2HcjASglT9BgzEZqWRP6g1LjDyCrV
         DF7z2asn4Br6hPMD7Grz2aihKOiBL8hlGCgvpz7U7XvF0V9spB0C/3ZDgYQhZNhtafyw
         mgjdgixbjRp/0Op5l4WZjVxVU0MzNMmKO8k1abqzGrPBa3hXkxHRIJblEgtX+CZkn5K/
         Vslw==
X-Forwarded-Encrypted: i=1; AJvYcCUhN1Zdz/Jp7koWgZEQx2j7fi7UaST7kyRbZyEItHNqgV+5e7cHUSUdy3EYkwiPBz3GnbRQreJuOC3V@vger.kernel.org
X-Gm-Message-State: AOJu0YxEuJtA5y7ZpU7bJgWHVx7c0seWe1yUPPqHmeEs6egWCVlRWJt/
	K8OdPRWfJuaqqDR3z34Flgk9rGkixEFSSzrBzfi/wzKas79xAhwoqlWdF3wr7UmPOv+oXdJvMvw
	D0KpL4aLnmGm6mlHYODMAx8hIE9Dyks+nTD2NelTZAdzOXLLGBiofRCtNs5stNfU=
X-Gm-Gg: ASbGnctQOPthrnGTC29OZfhfWUKLDAaNJS7dgjnltDXmdQHqCElKzVnb607Pzpc3zJG
	tLlBndUhsEB5T76Tz4eW3IF80pzoBx2FN8VHJs2n5dQRpl6/qq851on42+gzaO5ec0EBDp6EA9g
	PCsLmvZcJitp09cqMFCDvNB5fngX+qH+Dw/3ovLEgmgdL6k+D9tjsDz3pTc9H62qsMDePd5wTQW
	yLzHwdT1WsnGNDWARZDqB1cokRvwNLgb46CaBn6uNiX5nvJ+qGr2TdJyPaLSp7hG4mpOkMMfJrA
	VwhLNkDiR0Bb7WJEo95BFETzehByF5dZOgPVZAsflgcMmYPCTecMyOyAo4Lmoe5Ko6GulRzkJPR
	64q7wugfYwP7kYpfDNfi0Fp6XZTvcKMtC41N2BGrBzjVrTCKXlrgqH/SH9zVTlmzvsg0=
X-Received: by 2002:a05:600c:1387:b0:45d:d2cd:de36 with SMTP id 5b1f17b1804b1-45dddeb8e9emr100152935e9.12.1757408858962;
        Tue, 09 Sep 2025 02:07:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXDnypB5wJ5rDn/zJEyHS9xO4uduYWB/+gBqRR8sdBFWJ0cHWyM3HNnqaB+9K2c1SmVJ00yg==
X-Received: by 2002:a05:600c:1387:b0:45d:d2cd:de36 with SMTP id 5b1f17b1804b1-45dddeb8e9emr100152415e9.12.1757408858433;
        Tue, 09 Sep 2025 02:07:38 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f23:9c00:d1f6:f7fe:8f14:7e34? (p200300d82f239c00d1f6f7fe8f147e34.dip0.t-ipconnect.de. [2003:d8:2f23:9c00:d1f6:f7fe:8f14:7e34])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df16070bdsm5517555e9.3.2025.09.09.02.07.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 02:07:37 -0700 (PDT)
Message-ID: <d23ea683-cca4-4973-88b1-4f6fd9b22314@redhat.com>
Date: Tue, 9 Sep 2025 11:07:36 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] mm: introduce local state for lazy_mmu sections
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
 sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org
References: <20250908073931.4159362-1-kevin.brodsky@arm.com>
 <20250908073931.4159362-3-kevin.brodsky@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250908073931.4159362-3-kevin.brodsky@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.09.25 09:39, Kevin Brodsky wrote:
> arch_{enter,leave}_lazy_mmu_mode() currently have a stateless API
> (taking and returning no value). This is proving problematic in
> situations where leave() needs to restore some context back to its
> original state (before enter() was called). In particular, this
> makes it difficult to support the nesting of lazy_mmu sections -
> leave() does not know whether the matching enter() call occurred
> while lazy_mmu was already enabled, and whether to disable it or
> not.
> 
> This patch gives all architectures the chance to store local state
> while inside a lazy_mmu section by making enter() return some value,
> storing it in a local variable, and having leave() take that value.
> That value is typed lazy_mmu_state_t - each architecture defining
> __HAVE_ARCH_ENTER_LAZY_MMU_MODE is free to define it as it sees fit.
> For now we define it as int everywhere, which is sufficient to
> support nesting.
> 
> The diff is unfortunately rather large as all the API changes need
> to be done atomically. Main parts:
> 
> * Changing the prototypes of arch_{enter,leave}_lazy_mmu_mode()
>    in generic and arch code, and introducing lazy_mmu_state_t.
> 
> * Introducing LAZY_MMU_{DEFAULT,NESTED} for future support of
>    nesting. enter() always returns LAZY_MMU_DEFAULT for now.
>    (linux/mm_types.h is not the most natural location for defining
>    those constants, but there is no other obvious header that is
>    accessible where arch's implement the helpers.)
> 
> * Changing all lazy_mmu sections to introduce a lazy_mmu_state
>    local variable, having enter() set it and leave() take it. Most of
>    these changes were generated using the following Coccinelle script:
> 
> @@
> @@
> {
> + lazy_mmu_state_t lazy_mmu_state;
> ...
> - arch_enter_lazy_mmu_mode();
> + lazy_mmu_state = arch_enter_lazy_mmu_mode();
> ...
> - arch_leave_lazy_mmu_mode();
> + arch_leave_lazy_mmu_mode(lazy_mmu_state);
> ...
> }
> 
> * In a few cases (e.g. xen_flush_lazy_mmu()), a function knows that
>    lazy_mmu is already enabled, and it temporarily disables it by
>    calling leave() and then enter() again. Here we want to ensure
>    that any operation between the leave() and enter() calls is
>    completed immediately; for that reason we pass LAZY_MMU_DEFAULT to
>    leave() to fully disable lazy_mmu. enter() will then re-enable it
>    - this achieves the expected behaviour, whether nesting occurred
>    before that function was called or not.
> 
> Note: it is difficult to provide a default definition of
> lazy_mmu_state_t for architectures implementing lazy_mmu, because
> that definition would need to be available in
> arch/x86/include/asm/paravirt_types.h and adding a new generic
>   #include there is very tricky due to the existing header soup.

Yeah, I was wondering about exactly that.

In particular because LAZY_MMU_DEFAULT etc resides somewehere compeltely 
different.

Which raises the question: is using a new type really of any benefit here?

Can't we just use an "enum lazy_mmu_state" and call it a day?

-- 
Cheers

David / dhildenb


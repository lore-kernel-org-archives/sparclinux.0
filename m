Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A54C34C9B3
	for <sparclinux@vger.kernel.org>; Thu, 23 Oct 2025 19:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761248299; cv=none; b=buAUT140exyTNLTkWJB70eDzua3C67gjtrCyKcK8dpLvUlRTZfCsexjc+nKD6WI4RmRzspAYjDBdmEYVeEtl924tr6qv1uECX5x5G1TMO3gTnq7mWJN8JGWwMER8Tq+fYlsMBhT32MWpxf4xLbS3WRMMIezElH0sBQ7qWxVdy0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761248299; c=relaxed/simple;
	bh=sTUN+OOQ61RIqfM1uoiECgcH1Z+fsNbDFGTm9/X8/M8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fDtw+tOHOifluucfGUjcRJkqC8C6txsz3BRmXomnl7jX8L1ScsaqtGqAQISDhMtjvjKN0104E9XlIznyKtgXSyp0n/clmfXAkBL+15LUz6cGxh8qwb/LTb/z9/nQdfyhgEJ5aXCT4/9oAmTML1okr+61uQY2TNwqzQF2ucw+h28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WaUgJiS4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WaUgJiS4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761248297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VQ7IyiPkbQDl/6FlpFFPP3SSIBn2cmNYnYEr3eJHlB0=;
	b=WaUgJiS4lnTXdFuXbmtBc+ovBYRyZFk/GY87gSYhn6slSvAipbKaOrAXyF0pe0Lkq7PUqq
	H5TQdOzI4ta62Os8GBuYgX46aCuaOW3mFGqw9qF10rfyaee8X/ZwwBOO1+Fwm5uKu5HNH/
	NBND0Wh0hqI6OBLJWNdDn3ajtOJ7B/k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-NW99SKv2P7ad8l_xIwYmTQ-1; Thu, 23 Oct 2025 15:38:14 -0400
X-MC-Unique: NW99SKv2P7ad8l_xIwYmTQ-1
X-Mimecast-MFC-AGG-ID: NW99SKv2P7ad8l_xIwYmTQ_1761248293
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47111dc7c35so9582965e9.2
        for <sparclinux@vger.kernel.org>; Thu, 23 Oct 2025 12:38:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761248293; x=1761853093;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VQ7IyiPkbQDl/6FlpFFPP3SSIBn2cmNYnYEr3eJHlB0=;
        b=dLHhGJULV2AjSd+l6BOuxEAZdWy/Bf9QiSj+xoqzfse8qqQ2N4N+/y/n3rDEB2SbgW
         Tz/IWiYAZG6WE5/hHafrm+bSLI34GPjzxkk3wVVT+YJA2HPuRMWaJ6aVjV/d6W6hmDk2
         MIlaasYyVbSog6yPr7x5vHKPbmW73cgsFYOHvsZniC4yYXMJq4iESmyHLRFsWDsFSuUN
         YdjpH6S9WmGFI6WAWYo9azm7oItpS+pV17QNFN3Ir6un7VpBnoQDtKo3pBuICIs0fVKB
         qcgRAiopktPGUIs/RDfB8+fADYPetDRpWpd6as4t6d9LyzRW0PpQcA2m9nvsKzCWDFr3
         3X6w==
X-Forwarded-Encrypted: i=1; AJvYcCW09HBNJvbWldyahkXYo+xXu9YtHIO0Y/Lbd6A4vcN6MjsYbxcJKB1z7B3xNbbiUj41bQM3unZItbbw@vger.kernel.org
X-Gm-Message-State: AOJu0Yypt690CSzto2FwNEC2bZ//G0ceO7Q3FgjnQcKE6T1jmghInDjt
	bPOz7Pr7rlV1hRnkz9+DK/HdtM5QcBLNDvd6pZqu4XBLdzoOnylSyRHxN/kLO3CfXlba82QVTvI
	byCKDt7Oht3k4LplEwo8vXtkM+IlFJqZLvccR9wWu7yszu/nWNPfQU7BZcRr+W8Q=
X-Gm-Gg: ASbGncsnlJoOwkKfY+1nocbg672mpKvT9w6BB6d/mso3Wttp4XUqr1LD0Mpyt0rgEeQ
	/q8iAqBqU0kinC0DaCKXufktq45sVQv4HOHMt+/1YWDk2kGSXbtCRVsVt9M3uRppPN8+/KCxRPV
	6eGouea+x8bQMwB2krhuMGrzs6/tmfZG3I/uGziBMPbp0gi6T3lsqr01unRySO4rXLPU99KSXaT
	uZnzLqV98q6ubzFxg9ZpKA/uLK7TKgqF2K6HHdbsJ/XhZQhq2pRqmYXawyzMvm/aNZkIrmJACXu
	rAh9oiA252HSgtEEfQxSj1k9wh4u6KOc47fShs0K3QI/sq5ZoR7Z1e6F/N4za4pn0RgF+3rfjDR
	lrxHbiiN5BeYKect4jWUd3oLqE5ruC1khuBIyag49bdQqf8tX0/BuB/2Bfj4xdB7Wq8jMrLr/Ib
	kieO+WIQ8Smuet9HIqR4RFPcc515E=
X-Received: by 2002:a05:600c:3145:b0:45d:e6b6:55fe with SMTP id 5b1f17b1804b1-4711791e7a4mr225365545e9.34.1761248293302;
        Thu, 23 Oct 2025 12:38:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFK4kvb9VXDfRke79DTEDXEtAKVHmaVqzR/ZxHwP2FSjJo/KXXf7lv5KID4JKHr2iZrwUPcWA==
X-Received: by 2002:a05:600c:3145:b0:45d:e6b6:55fe with SMTP id 5b1f17b1804b1-4711791e7a4mr225365155e9.34.1761248292920;
        Thu, 23 Oct 2025 12:38:12 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3? (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429898eb549sm5405252f8f.41.2025.10.23.12.38.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 12:38:12 -0700 (PDT)
Message-ID: <dd3011ec-23cc-4431-95a3-a0c2965e7062@redhat.com>
Date: Thu, 23 Oct 2025 21:38:10 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/13] mm: introduce CONFIG_ARCH_LAZY_MMU
To: Kevin Brodsky <kevin.brodsky@arm.com>, Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Alexander Gordeev <agordeev@linux.ibm.com>,
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
 Nicholas Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Ryan Roberts <ryan.roberts@arm.com>, Suren Baghdasaryan <surenb@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, Vlastimil Babka <vbabka@suse.cz>,
 Will Deacon <will@kernel.org>, Yeoreum Yun <yeoreum.yun@arm.com>,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org
References: <20251015082727.2395128-1-kevin.brodsky@arm.com>
 <20251015082727.2395128-6-kevin.brodsky@arm.com>
 <aPNjd2dg3YN-TZKH@kernel.org> <3836a43f-809e-419d-a85d-74606d9daa0f@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <3836a43f-809e-419d-a85d-74606d9daa0f@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.10.25 12:37, Kevin Brodsky wrote:
> On 18/10/2025 11:52, Mike Rapoport wrote:
>>> @@ -231,7 +231,7 @@ static inline int pmd_dirty(pmd_t pmd)
>>>    * held, but for kernel PTE updates, no lock is held). Nesting is not permitted
>>>    * and the mode cannot be used in interrupt context.
>>>    */
>>> -#ifndef __HAVE_ARCH_ENTER_LAZY_MMU_MODE
>>> +#ifndef CONFIG_ARCH_LAZY_MMU
>>>   static inline void arch_enter_lazy_mmu_mode(void) {}
>>>   static inline void arch_leave_lazy_mmu_mode(void) {}
>>>   static inline void arch_flush_lazy_mmu_mode(void) {}
>>> diff --git a/mm/Kconfig b/mm/Kconfig
>>> index 0e26f4fc8717..2fdcb42ca1a1 100644
>>> --- a/mm/Kconfig
>>> +++ b/mm/Kconfig
>>> @@ -1372,6 +1372,9 @@ config PT_RECLAIM
>>>   config FIND_NORMAL_PAGE
>>>   	def_bool n
>>>   
>>> +config ARCH_LAZY_MMU
>>> +	bool
>>> +
>> I think a better name would be ARCH_HAS_LAZY_MMU and the config option fits
>> better to arch/Kconfig.
> 
> Sounds fine by me - I'm inclined to make it slightly longer still,
> ARCH_HAS_LAZY_MMU_MODE, to avoid making "LAZY_MMU" sound like some HW
> feature.

LGTM.

-- 
Cheers

David / dhildenb


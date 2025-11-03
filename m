Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F46314B90
	for <sparclinux@vger.kernel.org>; Mon,  3 Nov 2025 16:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762185831; cv=none; b=LsJi3AyGMrYTrTlrRTvoFGcnBA/+hKgagFM4s3HdOO1CU5mkkJgtqLT+1fPkffjnoeDRZxHqzxeqHUIvOxAiUjZdaRDE+ROADpN8XDIR2jpGUlHT9rgLLmCCBiSETmmKvFa/ESrxoR00rKPm+yyIwU5baX+Et7IK4SNQaonmLDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762185831; c=relaxed/simple;
	bh=W3vMDeaXnHo1OZjfJ7ogXCVgomGfM6sVhl807GF4qFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dre9h6B5yVDwLsIo6qS3D5QkqV2Kx16IUkYOnAe4djxgr/KH71PyP0cxRVHuBYvgOWrL/foczkpA9cW+YjebBfAuTPlChm8bsMcjR7hRwuOVoBT7/GMunZLG9W05q/1Rne6/7BjGpow06OEkPxT0ALFSkaIuN1XLZzO7/4cflK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CGOv8A+C; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IdnGTy7O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CGOv8A+C";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IdnGTy7O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762185829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lAB1nRPhZgw2D2F/txfufevKSsNDcd09VLHZkiGFvSY=;
	b=CGOv8A+C7rOGKqKlbbbSqZE9dX/Er5cOUdCLp2IRLzvRs5gu/aTRROl81ixake68mR5XUD
	XJsjQqMoOtokTA78QmGnISqYuRCtcXuXRf6UGtUqDAAoIFEseVx5YNUxpdpdfRSwxPuOpo
	Ho3FN1WCHM+/71K8vqR9W0iBH0frLAU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-FE07qSxsM-CGkKlpxtZzIw-1; Mon, 03 Nov 2025 11:03:46 -0500
X-MC-Unique: FE07qSxsM-CGkKlpxtZzIw-1
X-Mimecast-MFC-AGG-ID: FE07qSxsM-CGkKlpxtZzIw_1762185826
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-477171bbf51so24501505e9.3
        for <sparclinux@vger.kernel.org>; Mon, 03 Nov 2025 08:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762185825; x=1762790625; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lAB1nRPhZgw2D2F/txfufevKSsNDcd09VLHZkiGFvSY=;
        b=IdnGTy7OsnE2zAqC4uRNSHDv2nnsKWaWwDEKfkd6rOuqLLrNTH4UtkLbWj9oBRMkA/
         O90ZR+R9tBLL/gvJqe7FIVCHpjTLDhvZ8QHar5FAJiOn8xbkPSPXE5ZNH8naG87YzMDi
         ztr+nHuHD2IjWUnKbBSnvSMiNEGN5KJQSf/kZOj4f3nF1aYc8MhbWubL95Vz6VkW4GEZ
         iLTSHPeMsxctp5ksd3Czzpo5J1ytLcOO4oALhyJd3AueEKjjTQN0NCIc6+7x38CyW8me
         z62pAVlWVlKWv7/dWiB2GzT+pE4YqAgYfbHtCi+ROh9zHhoC1L95gMX9dOHdAWYpyvuR
         mKGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762185825; x=1762790625;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lAB1nRPhZgw2D2F/txfufevKSsNDcd09VLHZkiGFvSY=;
        b=eRSYEfrfFQv7NjN3GQ9Xv+JvotM+iA/GFVtftwU15Z/FKQWnnWzdhb3OEEk/SIEudf
         Dp5zdacd9m0w+zBYHNQYLiP1pmYHw7naROpb9WdRIroOyR4DHsOWQKNaz3olNdCvitGq
         03xjR6wKAyEU//ggXj/EL5aGevwO8EyC2J8b/V9yapwD7VPKQ/+mIvCCoxP5woDWPxcI
         16NLq08Su0Err3UMHrni+qql8iSveJ0EMy9BEleDOEuTcrwr1n/zfo84mBW2ZEDmL7kI
         vQXyxv68VCe4rZES8kpo0W/TAx+Pr9Z31LzHIw7fXVtBdcmyZETD6YO1HZy4/7ndlUUF
         WEfA==
X-Forwarded-Encrypted: i=1; AJvYcCWZZy/tlKIDWHaNt2nl8Bq7iX5hL+LGEccmlriUmXh9XPcxUUA81i+QaQekI3opswkMIH92D4dgiOgb@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw6u6j4RFdxQqDt9k5NV/uh9OYjereju1hf/tBiNQuofwQiyV4
	aW91aZsO2KzoCbVopd1nCcBS6pr3SDeI2bKdultO5ZhQhlvE/BTzbr9E4YsKD7gBaNuzp21H7EW
	T+3ZXGQs99QNtrO1jsABqnmL9A77PkbeL3qw77wx/z4epuuF4W1OjR92JIwHhkV8=
X-Gm-Gg: ASbGncusueFf7u6MgHp1pI5Z7esIrf2RLBwxx7TuNeoME9E/dRKqNkkJgNv9pweNT9M
	LQd0gM786FivOFex5fHYjn9G7s4fyMjOQR0ynxnq0w6RArvNj6pUPIxE8A6jumkQuoQD97l0CFw
	9rke8ajJ3VbJ6ofkEXsoEHhiCAKTMX0oawXGX5CL7EUFmBGHJ+K+7upiEoKLAvwZ3NavHUMAAEd
	qKP8YFcsarsuDUEQIk4KSR0o02Or1NWV2s2anNiYoiBEh8IdCuPqvphFB6TwR5CyyhKsTbdSRBC
	EV010GKnscaq7amOdCrq83hKiHzxYRef9AMF169UNd8k3S8KPsdhEB++qO2nRTtMVXlN+Dmprc3
	P57Fkt0XKETdZ3SHwC8SpQ2Nylodp1RjMVIHshyZSdxFc6v+rhCfXJDT8sVFA9minYpjBCGcJ5G
	FQwrqXRel/HRfgYEXYTAW2eqQc2SY=
X-Received: by 2002:a05:600d:831c:b0:477:542a:7ed1 with SMTP id 5b1f17b1804b1-477542a7ee4mr3985035e9.19.1762185825551;
        Mon, 03 Nov 2025 08:03:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5tyJHb+sues0m+7ZNZilqyo2L9Cho1JQDhJMCuFOgAOZW6Lsc8SY3FhL38SgCM772181+5A==
X-Received: by 2002:a05:600d:831c:b0:477:542a:7ed1 with SMTP id 5b1f17b1804b1-477542a7ee4mr3984625e9.19.1762185825048;
        Mon, 03 Nov 2025 08:03:45 -0800 (PST)
Received: from ?IPV6:2003:d8:2f3f:4b00:ee13:8c22:5cc5:d169? (p200300d82f3f4b00ee138c225cc5d169.dip0.t-ipconnect.de. [2003:d8:2f3f:4b00:ee13:8c22:5cc5:d169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c48daa0sm167032215e9.3.2025.11.03.08.03.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 08:03:44 -0800 (PST)
Message-ID: <b6f5b3cc-93a0-408a-b7e0-72462f3fd549@redhat.com>
Date: Mon, 3 Nov 2025 17:03:42 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/12] arm64: mm: replace TIF_LAZY_MMU with
 in_lazy_mmu_mode()
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
 <20251029100909.3381140-9-kevin.brodsky@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251029100909.3381140-9-kevin.brodsky@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.10.25 11:09, Kevin Brodsky wrote:
> The generic lazy_mmu layer now tracks whether a task is in lazy MMU
> mode. As a result we no longer need a TIF flag for that purpose -
> let's use the new in_lazy_mmu_mode() helper instead.
> 
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
> ---
>   arch/arm64/include/asm/pgtable.h     | 16 +++-------------
>   arch/arm64/include/asm/thread_info.h |  3 +--
>   2 files changed, 4 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 535435248923..61ca88f94551 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -62,30 +62,21 @@ static inline void emit_pte_barriers(void)
>   
>   static inline void queue_pte_barriers(void)
>   {
> -	unsigned long flags;
> -
>   	if (in_interrupt()) {
>   		emit_pte_barriers();
>   		return;
>   	}
>   
> -	flags = read_thread_flags();
> -
> -	if (flags & BIT(TIF_LAZY_MMU)) {
> -		/* Avoid the atomic op if already set. */
> -		if (!(flags & BIT(TIF_LAZY_MMU_PENDING)))
> -			set_thread_flag(TIF_LAZY_MMU_PENDING);
> -	} else {
> +	if (in_lazy_mmu_mode())
> +		test_and_set_thread_flag(TIF_LAZY_MMU_PENDING);

You likely don't want a test_and_set here, which would do a 
test_and_set_bit() -- an atomic rmw.

You only want to avoid the atomic write if already set.

So keep the current

	/* Avoid the atomic op if already set. */
	if (!(flags & BIT(TIF_LAZY_MMU_PENDING)))
		set_thread_flag(TIF_LAZY_MMU_PENDING);

-- 
Cheers

David


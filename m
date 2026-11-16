Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794812215;
	b=BZw8g9dM6buZILpnz9jZvkb2ovNFu2QVb4gXEmSJ7tm7xlnYeWGtV/xPKLArs/w6sFyq
	 xpvzsBXkgzIwFaUa7rVdgIoJMy/GELjJ0cn0ASfsh8rGyAPH9nNLSTeDW2tG8uXQBkba8
	 PFqjfJjug8lM7ebcObRfMyGeg/8qjlRVqkZZN1BS1VrNvlkeKJNnP9/pLGUvRXl239zwH
	 9FFLKIGzBZltF3qYirpS7bMhb5eX6Kot9xrOCNC14NxFSg1NRcUwy5MM5AKa0eZxpwgbI
	 +ZTijziJUds1c7+ijmv4K42LiUfU7lZQBvG+vtFn0AagmvZrKzE3zLDvu80OxRGFI5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794812215;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Av8Qql1PFCbNo0ym4O0ZY8gbj5FgwCTE5iiuHlTnyDA=;
	b=Vy7f6+KOLbyrd7zoPv4LRi9mpMtb/HdVwqmgbr4cS0Bjz1A/VyiG+ULBWAGALHYaJkZq
	 kgArktNZDu0NP7YD/r5EWvcsUbYWbhYd73RjitH/YZIlk4Y/fg4IYQDsMwKW9/yRSqwAz
	 ZdaWZEs4iezHHccpNIAXD+aAQQhVgV9UH7lmuNSuoEYe6Ba9hHe5aM+6DMR+D57BXKNXk
	 HNCGUaJMI2mTv3rcgRHN8Vpgmz7s6zu0PFEujQ3MyH4cH09jiRULmrz2Gcq6SYfEm/CVz
	 o9Z26O4DJh+XWHSVCUn/lDNliBHNdYTauEbuEKgUPpRao9t8euEBq9kLiqgSBSDArnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=C3aFddts;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618F4606A32C
	for <sparclinux@vger.kernel.org>; Mon, 16 Nov 2026 06:56:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 618F4606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=C3aFddts
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DB12143D;
	Sun, 15 Nov 2026 22:56:50 -0800 (PST)
Received: from [10.163.155.94] (unknown [10.163.155.94])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C5003F632;
	Sun, 15 Nov 2026 22:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794812213; bh=iJSVzWp3/nSBdi9cZI1iskHcjerH/hi74/XTquikmPQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=C3aFddts8iOCMXlkDDHaAcQg7bsRD+smfjKxKYK5fRswDNVlUKNtAQRdKxeFQ18Ta
	 T8LjGnwNYkkZPALZcA+TvIc+u1SUOSDDYIjLW8qbraexmbYBEdNluSHkqA3OMC/Y5J
	 qTrubTZPG8r87GvQScYmKm0/IzMAYOTALGAPvpsc=
Message-ID: <3dab1bbf-77e4-4ce6-8314-2b3154be74dd@arm.com>
Date: Mon, 16 Nov 2026 12:26:40 +0530
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 9/9] mm, sparc: batch arch_unmap_one()
To: sashiko-reviews@lists.linux.dev, david@kernel.org, ljs@kernel.org,
 akpm@linux-foundation.org, hughd@google.com, chrisl@kernel.org,
 kasong@tencent.com, davem@davemloft.net, andreas@gaisler.com
Cc: riel@surriel.com, liam@infradead.org, vbabka@kernel.org,
 harry@kernel.org, jannh@google.com, lance.yang@linux.dev,
 baolin.wang@linux.alibaba.com, shikemeng@huaweicloud.com, nphamcs@gmail.com,
 baoquan.he@linux.dev, baohua@kernel.org, youngjun.park@lge.com,
 linux-mm@kvack.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 pfalcato@suse.de, anshuman.khandual@arm.com, geert@linux-m68k.org,
 sparclinux@vger.kernel.org, ryan.roberts@arm.com
References: <20261115143905.3045084-1-dev.jain@arm.com>
 <20261115143905.3045084-10-dev.jain@arm.com>
 <sashiko-outbox-215629@kernel.org>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <sashiko-outbox-215629@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 15/11/26 8:53 pm, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] sparc: leak of ADI tag_users and tag storage in
>   adi_save_tags_range()

Legit, so I have no choice but to add the restore side of arch_unmap_one(),
brilliant :)


> --
> 
> commit ccbef0704b88d6e8aff2c2f0c82f32d9131dcc3f
> Author: Dev Jain <dev.jain@arm.com>
> 
> mm, sparc: batch arch_unmap_one()
> 
> This commit extends arch_unmap_one() to accept a page count so SPARC can
> save ADI tags across a PTE batch during anonymous large-folio unmapping.
> 
>> diff --git a/arch/sparc/kernel/adi_64.c b/arch/sparc/kernel/adi_64.c
>> index 18036a43cf568..ffa378accefe3 100644
>> --- a/arch/sparc/kernel/adi_64.c
>> +++ b/arch/sparc/kernel/adi_64.c
> [ ... ]
>> @@ -394,3 +395,23 @@ int adi_save_tags(struct mm_struct *mm, struct vm_area_struct *vma,
>>  
>>  	return 0;
>>  }
>> +
>> +int adi_save_tags_range(struct mm_struct *mm, struct vm_area_struct *vma,
>> +			unsigned long addr, pte_t oldpte, unsigned long nr)
>> +{
>> +	unsigned long i;
>> +
>> +	for (i = 0; i < nr; i++, addr += PAGE_SIZE,
>> +	     oldpte = pte_next_pfn(oldpte)) {
>> +		int ret;
>> +
>> +		if (!(pte_val(oldpte) & _PAGE_MCD_4V))
>> +			continue;
>> +
>> +		ret = adi_save_tags(mm, vma, addr, oldpte);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	return 0;
>> +}
> 
> [Severity: Medium]
> Does this leak tag_desc->tag_users references and tag storage when
> adi_save_tags() fails partway through a batch?
> 
> Each successful adi_save_tags() call invokes alloc_tag_store(), which
> allocates a tag_storage_desc_t slot (and its tag_desc->tags buffer) or
> increments tag_desc->tag_users on an existing descriptor:
> 
> arch/sparc/kernel/adi_64.c:alloc_tag_store() {
>     ...
> 				if ((addr >= tag_desc->start) &&
> 				    (tag_desc->end >= (addr + PAGE_SIZE - 1))) {
> 					tag_desc->tag_users++;
> 					goto out;
> 				}
>     ...
> }
> 
> If a batch crosses tag_desc->end at page i > 0 and alloc_tag_store() fails
> its GFP_NOWAIT allocation for the new range, adi_save_tags_range() returns
> an error without unwinding the first i pages.  In mm/rmap.c,
> __ttu_anon_swapbacked_folio() then fails and ttu_anon_swapbacked_folio()
> restores the present PTEs for the entire sub-batch via set_ptes().  Because
> those first i pages are not swapped out, adi_restore_tags() ->
> del_tag_store() never runs for them, leaking their tag_users references and
> preventing del_tag_store() from freeing tag_desc->tags or releasing the
> descriptor slot until process exit.
> 


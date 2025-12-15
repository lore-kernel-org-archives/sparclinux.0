Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95682DF6F4
	for <sparclinux@vger.kernel.org>; Mon, 15 Dec 2025 14:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765808822; cv=none; b=MryVyYivdYEAXs5hcK8Ay2NkbShseqkbIc7OBxF54cWq4xS90YJF66Uh592FB/+KOYdAboE4BfaEuDOtelwNaXcwN9xrfQhmf4BXSwPiGve327G7I81Km9suMqvWQ7CgWOYl4pzlvnm+VX/DqO9f+OptWGI/P22NUCSAsJmMIfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765808822; c=relaxed/simple;
	bh=a+opE07zuPxOMEv2JsJd9eHphXCCcd8mt0lFqJKDZ80=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mGtmZjQ5eoMOC/OGD3bJ8VBZ3/8B2NfObTGTa6EQ1gayEN+vZYU72rXnE+6XwOTfSwbXKpS+yp0xqx5cQ7hkHNHz8/RZTxzZ+zEAfbBGeFHGnB18H4Q7oeBdMTVdVCsjsl4TZhtIN1aWpDCMkXBCj2Heesz0Fkh69wGx9yx9vgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qo3ojefs; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qo3ojefs"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-78d6eb6956cso30123127b3.3
        for <sparclinux@vger.kernel.org>; Mon, 15 Dec 2025 06:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765808820; x=1766413620; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dcq1j6544AWTrXFS++mwFnDhDMKc8xPfVFYYuvKVzWQ=;
        b=Qo3ojefs8TogJLJuXutSeHcDjLSPQWZRjllT+uMh4+lzyRCSfnGSkdXwY/oTy+YR9j
         eOypG6ynchmXv9t9CsDD7iBU1S5nZiH4g90JTMITBWg2152z4g9O45VnvECyC75iQaRd
         1tnmi0odecSetkr7j7RQY01O6OHQOUzGXTvIWN7KUbOxs3FTtBnSaVZIyEJ0jvWiI747
         kTZurN73M11MokZvjoN0Ex8qr7x8BWeXRgbEU2IBSV13zzEdg+2dwKatCL3lvPoaocip
         j3WY526cfbz5Pg9mBXDBzI7IBp4XxqGnpqR4sm5wUWEMUhT0jVKnYj/iUU/VPjA7IxnR
         nSKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765808820; x=1766413620;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dcq1j6544AWTrXFS++mwFnDhDMKc8xPfVFYYuvKVzWQ=;
        b=NiJwpwGFN3rjugpZHW6C99O1p9I8+mVKsVUIWxvwjbXVeToDvDqCzPgFq1JXw0lpPz
         BLA+iEJHGd3F4v3ALv4eILHfDkMNCRyHiVX6SDzwb8Mb4CQTWgFH/JywuZafAOirtL/U
         1Jq41Pr1EnX0WXywXiF5/yiscpatkO4HcYl7WkNAOc0dGRmMm1WTFH6NpYnxCMngkzSV
         Q9a0wDQZ+FvHAwARBNFqmL5lM/wKT9VovHy5OeRsiSAd2EiklbNC+cjNGVWa6MCj9Njc
         B48amkYZ4pEl4k0GEwNvnbSmxxAmChrUbgKTNYcWTi+C1vZ+nSQVUgBNYH8PLmODYwcl
         jBEA==
X-Forwarded-Encrypted: i=1; AJvYcCXZACLeaDdKwS0Wu+t2/acsI9tCnFIfZAS+pX+w8BRvEmYqD8wHedLvzVTukBO1+2+vWPfIZrkEgcvZ@vger.kernel.org
X-Gm-Message-State: AOJu0YztovWaK4OvBK0NyVm4W0LanbHh42Du2h6JFkvyLXI4aFwZDb/R
	JzzWbUJ75DJhwKaIt1H60WEawBrOk0HKFfpAjnLjZ8Boj0MHfwL2jQIj
X-Gm-Gg: AY/fxX6IM/mSloVUuz+llK8/KCGUnny+/oLX1d/UxQPIOboM+32bpHsySajZgLqrrBI
	H4OAdEz1ZLydmlhNaXprGAmY3yz9cJjBAH5l1fH2h48PZNxOMR0KgyHNhv//7IrpqNPFCVofWyy
	XJSALrYaf7qme5Lw1Vg10nEVD4J2p9EyilGqHTzyMV8MAMy+BcJgwXrYA5AGPrfHR1gJcUtsoEx
	elLZkYSv8r54zbVmBxUdN9ccl+f8KChv3CvrlaiyH+AMGFsYZEn4HseaOi0DbCL+3Fmbog9aDuf
	BI2pv8VBVHc32lntBRlmCsx7I0I+2sNOKGleg4M/Uz5Z6KBsSxVFfDsGsSIBGTeS4RkxlYOVNxV
	3DTiftZlxt+38wf1Db06twC5uevN2vYVCl9zQn9iLqkNSsd1N0z/ixJnBY/a0okGSdDYD8YP4vw
	m9KtDeXq110nQ+KOMdXORPtfWLAab4XYM98q3QUg==
X-Google-Smtp-Source: AGHT+IF4a51y57BzF37Vo9369cXMn6T0B92c877kSdcZ6vwpnS/AOu/LuwtwBmWQVHYV+/9EHDVqvg==
X-Received: by 2002:a05:690c:dd6:b0:787:e015:8561 with SMTP id 00721157ae682-78e66d8030cmr89937457b3.20.1765808819563;
        Mon, 15 Dec 2025 06:26:59 -0800 (PST)
Received: from [192.168.2.226] (104.194.78.75.16clouds.com. [104.194.78.75])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78e749e55edsm28402847b3.33.2025.12.15.06.26.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Dec 2025 06:26:59 -0800 (PST)
Message-ID: <b9e3921a-2a54-4adb-b19c-802e2aa1aa75@gmail.com>
Date: Mon, 15 Dec 2025 22:26:42 +0800
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] mm/pgtable: use ptdesc for pmd_huge_pte
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, alexs@kernel.org,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, "David S . Miller"
 <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>, Thomas Huth <thuth@redhat.com>,
 Will Deacon <will@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Magnus Lindholm <linmag7@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org
References: <20251214065546.156209-1-alexs@kernel.org>
 <686b85ff-6a5a-4608-af97-55aee1582c5c@kernel.org>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <686b85ff-6a5a-4608-af97-55aee1582c5c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/12/15 14:06, Christophe Leroy (CS GROUP) wrote:
> 
> Le 14/12/2025 à 07:55, alexs@kernel.org a écrit :
>> From: Alex Shi <alexs@kernel.org>
>>
>> 'pmd_huge_pte' are pgtable variables, but used 'pgtable->lru'
>> instead of pgtable->pt_list in pgtable_trans_huge_deposit/withdraw
>> functions, That's a bit weird.
>>
>> So let's convert the pgtable_t to precise 'struct ptdesc *' for
>> ptdesc->pmd_huge_pte, and mm->pmd_huge_pte, then convert function
>> pgtable_trans_huge_deposit() to use correct ptdesc.
>>
>> This convertion works for most of arch, but failed on s390/sparc/powerpc
>> since they use 'pte_t *' as pgtable_t. Is there any suggestion for these
>> archs? If we could have a solution, we may remove the pgtable_t for other
>> archs.
> 
> The use of struct ptdesc * assumes that a pagetable is contained in one 
> (or several) page(s).
> 
> On powerpc, there can be several page tables in one page. For instance, 
> on powerpc 8xx the hardware require page tables to be 4k at all time, 
> allthough page sizes can be either 4k or 16k. So in the 16k case there 
> are 4 pages tables in one page.

Hi Christophe,

Thanks a lot for the info.

> 
> There is some logic in arch/powerpc/mm/pgtable-frag.c to handle that but 
> this is only for last levels (PTs and PMDs). For other levels 
> kmem_cache_alloc() is used to provide a PxD of the right size. Maybe the 
> solution is to convert all levels to using pgtable-frag, but this 
> doesn't look trivial. Probably it should be done at core level not at 
> arch level.

Uh, glad to hear some idea for this, would you like to give more 
detailed explanation of your ideas?

Thanks a lot

> 
> Christophe
> 
>>
>> Signed-off-by: Alex Shi <alexs@kernel.org>
>> ---
>>
>> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/ 
>> powerpc/include/asm/book3s/64/pgtable.h
>> index aac8ce30cd3b..f10736af296d 100644
>> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
>> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
>> @@ -1320,11 +1320,11 @@ pud_t pudp_huge_get_and_clear_full(struct 
>> vm_area_struct *vma,
>>   #define __HAVE_ARCH_PGTABLE_DEPOSIT
>>   static inline void pgtable_trans_huge_deposit(struct mm_struct *mm,
>> -                          pmd_t *pmdp, pgtable_t pgtable)
>> +                          pmd_t *pmdp, struct ptdesc *pgtable)
>>   {
>>       if (radix_enabled())
>> -        return radix__pgtable_trans_huge_deposit(mm, pmdp, pgtable);
>> -    return hash__pgtable_trans_huge_deposit(mm, pmdp, pgtable);
>> +        return radix__pgtable_trans_huge_deposit(mm, pmdp, 
>> page_ptdesc(pgtable));
>> +    return hash__pgtable_trans_huge_deposit(mm, pmdp, 
>> page_ptdesc(pgtable));
>>   }
> 
> I can't understand this change.
> 
> pgtable is a pointer to a page table, and you want to replace it to 
> something that returns a pointer to a struct page, how can it work ?

Sorry for the bothering. Right, it can't work as I mentioned in commit 
log. I just want to bring up this issue, and hope you expert to give 
some ideas.

Thanks

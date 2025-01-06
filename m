Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CF11DD0E7
	for <sparclinux@vger.kernel.org>; Mon,  6 Jan 2025 11:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736161363; cv=none; b=agB5k+JhEKzDXop4r5wkwCmvb4LMuUdeoKAXEOwT9kC8eLo/RgKj0NjMEPDoiIAMRvtE/CmbuW9G4X3m8mA9rIJQnFLKViKbv23qu07DHMeV7cCT/v2Q+OkAoWVWat1qAmESxRLi7gA7/3aY/Z7VRDArTFjty4xNRBJNiAQxSRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736161363; c=relaxed/simple;
	bh=30+xZQfb9yDuTIOe+TrzSZCg5DGlryILzZEnHJoiL0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iCIMdELotVwsa+prSTYFORnqq1SaybgMirVhDqZzZ7kntTmNhML6+Rot0sk442JLwJJiXMWyszxGe2eLIN9dTkgo8YjNq/EO6uRSA0sTmINiAqc0xKWQypqBpPu2bo5ejGBsI0/Z5n9oaP4VChtotKSM3ykIBK3UsvfUdz64ZJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=e9BO8x11; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="e9BO8x11"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-216401de828so190698115ad.3
        for <sparclinux@vger.kernel.org>; Mon, 06 Jan 2025 03:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1736161353; x=1736766153; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PtS7kKDFbbWBE6dlgb91yolih02/BD7li/VWMu2pf+Q=;
        b=e9BO8x11AH1QgI2kujJM472/6w1404H4PqWRzvoLs6Ix6ioP/bqjGrP8Z5j3y4WpXp
         P+oA+YYEpj2Hc1pKU2uZ2W5b49ym4KW7g5+BPwd9hw/NoDEQRiLgyFFaTBYmPtz/IqVm
         ACUrR3yo7UfwChTyck1sE6Mul1LfbGfDLU4l2cDJuHc08hZof/pXPnaWZ27o5ZTHJwZq
         CW5/tXH/s0eQNmiBJp9TunpWGl+11v2xKlWpJriisZ1p/weaU+bt1YkNllR+0Zlbb0Ng
         6hfA8PzCu+YbpoKwd7eyy+IlKqLTOCS+0Lnu+7obXPAgPYLbU6nq8WxJnpcdlHTKX5YE
         S33g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736161353; x=1736766153;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PtS7kKDFbbWBE6dlgb91yolih02/BD7li/VWMu2pf+Q=;
        b=Isd+BATzAB9EcQBsjQbvcb1UbD36dkq5kuTX5X9DGPzgSt858g02zNn60u1jZCoGqC
         IsVTqAxzwwNSEcZ3EddZw9MJ9yJxrBLxB3VT81UQzkyjxyOoq/5wZRaISMNnINCu7J/i
         ac+Z9uvQGkDFlxAWH2NFWkLdjyHhxYU3Xoe/vtEEwkafB4vIjxKkDU2TIrXrO4LEv2wB
         DeehFYSUOFU13V5qxxWYrtngU5xjTF/2doK2oFotcU3b8LHs/rXR0sR/My961iTfuzM4
         zxkNoKNBuyjoizq8HU3HWF7GPlnUFNdXp6RDiBf5D8KzPSgy5ovQfXpcez4mG3IqVzT3
         xuXA==
X-Forwarded-Encrypted: i=1; AJvYcCWugWW0Op0LYgyWIjqShGK7kEpWKEpv/LTy64RsT9OuHdUzAqmFxzMq3dODQq5+gkRXsbeYlzlJTPbT@vger.kernel.org
X-Gm-Message-State: AOJu0Yww116URi/WPlHWlGAYMT0zXOEThdFtrCBmVJjGIzgxikaZhM7A
	7huqyqPQ3upg8sss3R3je0AtgvwRvqDmwXNfnWmz/CVLwMCe/CZB1YHy+OH09ms=
X-Gm-Gg: ASbGncuKSwflXudy+vbvwXjWXJ4yL0+6yVyqdE0acpi0uNwJmGW3yGpPcuJDPRQV61y
	bNmvbeEeR8WhQtddAjPJXI3uJAhb36C4dga6dPyC1CfddPEs/1R9y7VmtkoJKMSTgsjhJw6Jg90
	VY2xJhaEwMzELkhLgaoFGEVVaWxL7me0Vy+3cKXl2xILFAX8fCmirTVXbfudZmq9HPYUrJT/pkV
	khAXpjNRKbADzyenq6fcSwYw9G2lm+EhhCsiweKgWFMWL8to/aRJ+D5DwZra18mSL5sd/W2GONO
	yoIXfg==
X-Google-Smtp-Source: AGHT+IFCeOw2arXEHpOUWAGun1CKXf9/XTpPQ1dFbIMLlKInW35U2LjXZ6DtTEzjdru/7w1/tbEHpw==
X-Received: by 2002:a05:6a00:4644:b0:725:b347:c3cc with SMTP id d2e1a72fcca58-72abdeb9c33mr83929136b3a.23.1736161353534;
        Mon, 06 Jan 2025 03:02:33 -0800 (PST)
Received: from [10.84.148.23] ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad816464sm31123318b3a.40.2025.01.06.03.02.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 03:02:33 -0800 (PST)
Message-ID: <2d16f0fe-9c7f-4229-b7b5-ffa3ab1b1143@bytedance.com>
Date: Mon, 6 Jan 2025 19:02:17 +0800
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/15] s390: pgtable: also move pagetable_dtor() of PxD
 to __tlb_remove_table()
Content-Language: en-US
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: peterz@infradead.org, kevin.brodsky@arm.com, palmer@dabbelt.com,
 tglx@linutronix.de, david@redhat.com, jannh@google.com, hughd@google.com,
 yuzhao@google.com, willy@infradead.org, muchun.song@linux.dev,
 vbabka@kernel.org, lorenzo.stoakes@oracle.com, akpm@linux-foundation.org,
 rientjes@google.com, vishal.moola@gmail.com, arnd@arndb.de, will@kernel.org,
 aneesh.kumar@kernel.org, npiggin@gmail.com, dave.hansen@linux.intel.com,
 rppt@kernel.org, ryan.roberts@arm.com, linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-arch@vger.kernel.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-um@lists.infradead.org
References: <cover.1735549103.git.zhengqi.arch@bytedance.com>
 <ad21b9392096336cf15aee46f68f9989a9cf877e.1735549103.git.zhengqi.arch@bytedance.com>
 <Z3uyJ2BjslzsjkZI@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <Z3uyJ2BjslzsjkZI@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/1/6 18:36, Alexander Gordeev wrote:
> On Mon, Dec 30, 2024 at 05:07:47PM +0800, Qi Zheng wrote:
>> To unify the PxD and PTE TLB free path, also move the pagetable_dtor() of
>> PMD|PUD|P4D to __tlb_remove_table().
> 
> The above and Subject are still incorrect: pagetable_dtor() is
> called from pagetable_dtor_free(), not from __tlb_remove_table().

Hmm, __tlb_remove_table() calls pagetable_dtor_free(), so moving to
pagetable_dtor_free() means moving to __tlb_remove_table(). Right?
And the main purpose of this patch is also to move pagetable_dtor()
to __tlb_remove_table(). So I think this description makes sense?

> 
> ...
>> diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
>> index 569de24d33761..c73b89811a264 100644
>> --- a/arch/s390/mm/pgalloc.c
>> +++ b/arch/s390/mm/pgalloc.c
>> @@ -180,7 +180,7 @@ unsigned long *page_table_alloc(struct mm_struct *mm)
>>   	return table;
>>   }
>>   
>> -static void pagetable_pte_dtor_free(struct ptdesc *ptdesc)
>> +static void pagetable_dtor_free(struct ptdesc *ptdesc)
>>   {
>>   	pagetable_dtor(ptdesc);
>>   	pagetable_free(ptdesc);
>> @@ -190,20 +190,14 @@ void page_table_free(struct mm_struct *mm, unsigned long *table)
>>   {
>>   	struct ptdesc *ptdesc = virt_to_ptdesc(table);
>>   
>> -	pagetable_pte_dtor_free(ptdesc);
>> +	pagetable_dtor_free(ptdesc);
>>   }
>>   
>>   void __tlb_remove_table(void *table)
>>   {
>>   	struct ptdesc *ptdesc = virt_to_ptdesc(table);
>> -	struct page *page = ptdesc_page(ptdesc);
>>   
>> -	if (compound_order(page) == CRST_ALLOC_ORDER) {
>> -		/* pmd, pud, or p4d */
>> -		pagetable_free(ptdesc);
>> -		return;
>> -	}
>> -	pagetable_pte_dtor_free(ptdesc);
>> +	pagetable_dtor_free(ptdesc);
>>   }

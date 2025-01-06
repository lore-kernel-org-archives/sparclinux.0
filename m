Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44ABF1DC1AF
	for <sparclinux@vger.kernel.org>; Mon,  6 Jan 2025 10:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736160976; cv=none; b=I+6HvNai2zJSoEahZWsS2uBQbyYNxk0+dhMGEiZBErCBrKsPhVOvIAHMNl3MwV+FM3u8vW45lvv6nBpoF4C1YcXg2Rm2cwv7Eug3aoi/cEYi33wtHedVm1mHjgue+OoyOG/kRKIgJvkv5Tj8mtkRVRdwmL45C2YqHU6PzBucwYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736160976; c=relaxed/simple;
	bh=r/bDpLsrew4AGrmhkoObL4mp3VlC7lbov5MqbBolj5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r6HYwbdRVO+Sw7AM/Rd26NRuhLSS0UCIC9SS/f18Kk60f7RfGBL0Lj6a3dl+NnaB/Jhw8z4UuF0XthG2DyDLDbfEyz7ITw0wPil6MiPP9+RDOoNldJne47BGRxUDZydoVMIfQVvL0sSpJntDpXLDFzQQVP2v8i4N4n6C0spTPYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=T+j+okKo; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="T+j+okKo"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ef87d24c2dso16478225a91.1
        for <sparclinux@vger.kernel.org>; Mon, 06 Jan 2025 02:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1736160974; x=1736765774; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AZLWPPKublXNhPBg34EaNBNy6TKJ9wneFJV35MDnpZc=;
        b=T+j+okKo2zRwuYSfffMrbTo6TknZew6YYiULJO+9bKi0BHmWKw7QokPt1Skt66fwlj
         eMmqN+oPD124G39eSvNTMwnUs7SB0dGpKFkK3XMEy95L7NM1VCNWV2hE5tX6oL627MK8
         wC57GG0O/2xauw2YLjCaXrrN9tye0bn0z52ql1FJe2UhsvbOiuaH7ebCTW7kfkaEPHij
         2JwZYVWxNe5uWIAiEK3PLKJG9ey+iGqLYgiBNk7skrKHCik6AMdGwrjlkHZ85MUbmTKD
         uW7ySurc3z49eojO5wjN6X21t2HrdGUgV2MIp0NgIb4Onz4+87KRMQVxwja2SMySjlyT
         cKrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736160974; x=1736765774;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AZLWPPKublXNhPBg34EaNBNy6TKJ9wneFJV35MDnpZc=;
        b=LO7WNZDUJVUKiTdZYEenFq8zLl0LI3HMobHZ9NgM+lF6b1M5kCmAqR1gFjtLNfXWHg
         Yfw2ukunozCQ8XfFoKiRzmBJfhpsnwJWg4mxAmOhrCsjrtNE2KMHflgUO9lXagkvVStS
         d/XYywpqX98Cd5qRDf179cHqUnaO4fjS1LAEfledHhb8g2MJKd9XroCj0JE3qRLzEV4D
         ixF9e8zvthFQq7aBqw5r9jJoz6yXVH0pC7GAqmZYmGybormSo6CT/aRY7vugp1ynifis
         7YNyofbdNZkZ6VhQHJNsPZEawCxDOGoYkZFvKTFiwRhbjFS38z7H9MMsp7cRnnVBtZFz
         9nAw==
X-Forwarded-Encrypted: i=1; AJvYcCWPKe+/009Hfx8DqrkDeYWMJDZqj1mM+joX+Zzs65e+MMkgkbWNZvBzuxbrvRuS6SW6mdmtwr4Jv0wq@vger.kernel.org
X-Gm-Message-State: AOJu0YzwxC+4WIfcfFnbLRBJqw8U7J157M4EYjpj0JobXART4TQYJjqh
	mA+yAh+9nAOISTUNelUOhoezcLlxg4lOEVl9llInZrSlQOChk6he51xvbGkr7wI=
X-Gm-Gg: ASbGncv6pqWQTBB5vx9izifZq3zcS7VEfXtdfPQmevT8/3YjWVFD8G6IZ/5NmqJDFRe
	6F64UoEWMqVdsbsHIpB65/igp/Gj6648gRMEP9th9gUecloh7XBIG0+S3Roa+ZXiSntDM1QZeJb
	I/eDngGM5U+YD741XFHdT7yFm6BFr7hgFiDxS/H4W+PVI5luPEFcPjvslH8ELvLj/FD1pgY3rMS
	cl2c8jB/a8nR0H38NNmynj7N57m0kwM685YywPLBc9rZ4ioGxBZ8k0hUP90AN3iONSjMt8gFDOL
	TMwvGA==
X-Google-Smtp-Source: AGHT+IHHEGVNBdeeeMKsfSrtRayn5rgDW+sVv93AHdkC2kua4+TBudPLJJX1AZ3o0AE+Wq0oFkgydg==
X-Received: by 2002:a17:90b:5347:b0:2ee:3fa7:ef4d with SMTP id 98e67ed59e1d1-2f452ec37bamr85837306a91.24.1736160973647;
        Mon, 06 Jan 2025 02:56:13 -0800 (PST)
Received: from [10.84.148.23] ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc96ead1sm290125115ad.91.2025.01.06.02.56.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 02:56:13 -0800 (PST)
Message-ID: <e1de887c-6193-48ee-a9b3-04c8a0cdda45@bytedance.com>
Date: Mon, 6 Jan 2025 18:55:58 +0800
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/15] mm: pgtable: introduce pagetable_dtor()
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
 <8ada95453180c71b7fca92b9a9f11fa0f92d45a6.1735549103.git.zhengqi.arch@bytedance.com>
 <Z3uxwiEhYHDqdTh3@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <Z3uxwiEhYHDqdTh3@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/1/6 18:34, Alexander Gordeev wrote:
> On Mon, Dec 30, 2024 at 05:07:42PM +0800, Qi Zheng wrote:
>> The pagetable_p*_dtor() are exactly the same except for the handling of
>> ptlock. If we make ptlock_free() handle the case where ptdesc->ptl is
>> NULL and remove VM_BUG_ON_PAGE() from pmd_ptlock_free(), we can unify
>> pagetable_p*_dtor() into one function. Let's introduce pagetable_dtor()
>> to do this.
>>
>> Later, pagetable_dtor() will be moved to tlb_remove_ptdesc(), so that
>> ptlock and page table pages can be freed together (regardless of whether
>> RCU is used). This prevents the use-after-free problem where the ptlock
>> is freed immediately but the page table pages is freed later via RCU.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> Originally-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ...
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 5d82f42ddd5cc..cad11fa10c192 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -2992,6 +2992,15 @@ static inline bool ptlock_init(struct ptdesc *ptdesc) { return true; }
>>   static inline void ptlock_free(struct ptdesc *ptdesc) {}
>>   #endif /* defined(CONFIG_SPLIT_PTE_PTLOCKS) */
>>   
>> +static inline void pagetable_dtor(struct ptdesc *ptdesc)
>> +{
>> +	struct folio *folio = ptdesc_folio(ptdesc);
>> +
>> +	ptlock_free(ptdesc);
>> +	__folio_clear_pgtable(folio);
>> +	lruvec_stat_sub_folio(folio, NR_PAGETABLE);
>> +}
>> +
> 
> If I am not mistaken, it is just pagetable_pte_dtor() rename.
> What is the point in moving the code around?

No, this is to unify pagetable_p*_dtor() into pagetable_dtor(), so
that we can move pagetable_dtor() to __tlb_remove_table(), and then
ptlock and PTE page can be freed together through RCU, which is
also the main purpose of this patch series.

Thanks!

> 
>>   static inline bool pagetable_pte_ctor(struct ptdesc *ptdesc)
>>   {
>>   	struct folio *folio = ptdesc_folio(ptdesc);
>> @@ -3003,15 +3012,6 @@ static inline bool pagetable_pte_ctor(struct ptdesc *ptdesc)
>>   	return true;
>>   }
>>   
>> -static inline void pagetable_pte_dtor(struct ptdesc *ptdesc)
>> -{
>> -	struct folio *folio = ptdesc_folio(ptdesc);
>> -
>> -	ptlock_free(ptdesc);
>> -	__folio_clear_pgtable(folio);
>> -	lruvec_stat_sub_folio(folio, NR_PAGETABLE);
>> -}
>> -
>>   pte_t *___pte_offset_map(pmd_t *pmd, unsigned long addr, pmd_t *pmdvalp);
>>   static inline pte_t *__pte_offset_map(pmd_t *pmd, unsigned long addr,
>>   			pmd_t *pmdvalp)

Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3402230983
	for <sparclinux@vger.kernel.org>; Tue, 14 Jan 2025 02:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736821636; cv=none; b=lcXQJ/tJnNU0uIcIu2DZgVQr32G0E8KoD65N2Km7G3rYB7NP+NUY2sRZtQRrIWGEcQHlLs8I82Jm6nNOhsIOIrlNWu/ywnHiqE5O6IvxL9FcjOnOOX+ex9gdrEkimZB2qLnqKLLdKLxrrOeCLOPDoUTCvIQ7DpczfTftzO2EAGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736821636; c=relaxed/simple;
	bh=Hom/cNZrW7mjFJzUlYAAyuZtoR84A5mWMLCiREKQDso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YiL4MlICESlycagNqoqnPLshMylgXBtSz9ckWrMhYz4MEvs5yA4QrHce/6chy+o7MN6Loh4PEuC09quaOcIiKpxVAtvrfXUNaSMREq/sviQKa9OU8BOIr/oMdf2e2EH8rQuzylNA25L2zOnwrmTtP/dQmha7bDyJ0xRWQ1ZYANs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Y/NQe4SJ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Y/NQe4SJ"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-219f8263ae0so81100805ad.0
        for <sparclinux@vger.kernel.org>; Mon, 13 Jan 2025 18:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1736821632; x=1737426432; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q3uCzTDF/NUXWi9pKun3Q1ZeVpbVlQmIUTgvJ2reRXQ=;
        b=Y/NQe4SJpABS9SMKo8sJ6ZJHSXwOWNedrB3gU4/b9TlGgmyjkcMxl59ayVFBky3918
         zBZt67kgvz9U473Cye5K0rwM49xz+FfkJcDxOJnp6v8B9Nc+iN3/z5Ae9hLirObCnl9l
         WIjxRr8dj6LC5OAWbsC8pONJqzhPG8pLi3KLMmzw5jDhgQ4YLWsBZ0riFWoERDRDSMmc
         9isWoGiNhn0KherO9CrV5GYFSiRn0wApXE6Z2HKrB3HqTTxQ2rAC2enWpHlq3RW2qmgY
         X3n5yrcvacLVA1B8RaIKH++54V0naeV7lOBX3p6Y+C8Xa7f5Hw/vPPN9fyKRICAs0nWn
         mNEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736821632; x=1737426432;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q3uCzTDF/NUXWi9pKun3Q1ZeVpbVlQmIUTgvJ2reRXQ=;
        b=wiLSq+9hh5XRLcRcdNZk1FHcIw6PlswU8sC65wE6N1iozbOZhW25FwuQAr3zpRgOa7
         3haECqGral4YkmZy4kGy0qJf2VQlkYW0WRkqjyiVTeXNlEK4M1wfqJsFmIK1nP+mDo+0
         ql4bQ7hY679xRXdM+D9+8lzwxgxaHB42oZ70rfPTcSKhTp3IwFtwFkFO7UaZaGJnivn/
         xs/+rI7q2Ewv7LDBUx5r8yuPLUHSmFOR3ioKt4u8f6iwctrLPmZ04HWrdJIiU+wi/9KA
         XbTGNeE9oSWDx0E4QX/JGoT0ldq9QsGMDoxcIjTFwaxCw9nw4LVvOAYqkDTX7TMWflCN
         JgYg==
X-Forwarded-Encrypted: i=1; AJvYcCWwsb6/LfMXobHOVZL09OpXEfkI6jUNSRRdEmHqWZONnKHUobemg+Hh9fnY7kIzo7F8qfmmzjyPW/yx@vger.kernel.org
X-Gm-Message-State: AOJu0YxrHI/q216EuOqwg2jg0UtWFUUR88vX5+V+zcGjv+tQY1pM/L+P
	UNQQn0k+zza0THNfMA0RQsE/JMMchF8cSJMYNvtNix6zbUI36GAnEn/4WDIZq7o=
X-Gm-Gg: ASbGncuoNZBPr+U5s9/XYZS17qj2wVKSDGHkoRxhKCIaaxzOCAZsircHmv8cneaxahB
	K0eac/csw4U9alEaqpMTRR10zTQkLGxnIwrEsIo1iSLQKgIo/6PYyIBaDogj8ZYiE3WRjBB8kBX
	dlDnADicKcP/4qT+S0sJm4sdd9s23I8e7IaKIKzcnQ9bRfScFAdZNounQvuV8xZKWX77BURO973
	5u+5nd4kctV/dzTduSGQ9yTTmLKULjMu5ebSajR2faHuwXg78PP+8DxmuPSMm0O0WDH/44aogUI
	FqwP
X-Google-Smtp-Source: AGHT+IFszANM2ttg3bHXqwu4kokOxCLHcRwKXlC7FRtBmzrGdqYoySfArdJur+xTrJx3xY86w59zAA==
X-Received: by 2002:a05:6a20:7f8a:b0:1db:de38:294b with SMTP id adf61e73a8af0-1e88d2f6820mr38362107637.38.1736821632027;
        Mon, 13 Jan 2025 18:27:12 -0800 (PST)
Received: from [10.84.148.23] ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d4056a5e8sm6847007b3a.53.2025.01.13.18.26.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 18:27:11 -0800 (PST)
Message-ID: <a017d072-943f-4008-bb1d-7be438804a44@bytedance.com>
Date: Tue, 14 Jan 2025 10:26:54 +0800
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/17] arm64: pgtable: use mmu gather to free p4d level
 page table
To: Will Deacon <will@kernel.org>
Cc: peterz@infradead.org, agordeev@linux.ibm.com, kevin.brodsky@arm.com,
 alex@ghiti.fr, andreas@gaisler.com, palmer@dabbelt.com, tglx@linutronix.de,
 david@redhat.com, jannh@google.com, hughd@google.com, yuzhao@google.com,
 willy@infradead.org, muchun.song@linux.dev, vbabka@kernel.org,
 lorenzo.stoakes@oracle.com, akpm@linux-foundation.org, rientjes@google.com,
 vishal.moola@gmail.com, arnd@arndb.de, aneesh.kumar@kernel.org,
 npiggin@gmail.com, dave.hansen@linux.intel.com, rppt@kernel.org,
 ryan.roberts@arm.com, linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-arch@vger.kernel.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-um@lists.infradead.org
References: <cover.1736317725.git.zhengqi.arch@bytedance.com>
 <3fd48525397b34a64f7c0eb76746da30814dc941.1736317725.git.zhengqi.arch@bytedance.com>
 <20250113162600.GA14101@willie-the-truck>
Content-Language: en-US
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20250113162600.GA14101@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Will,

On 2025/1/14 00:26, Will Deacon wrote:
> On Wed, Jan 08, 2025 at 02:57:21PM +0800, Qi Zheng wrote:
>> Like other levels of page tables, also use mmu gather mechanism to free
>> p4d level page table.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> Originally-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>> Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
>> Cc: linux-arm-kernel@lists.infradead.org
>> ---
>>   arch/arm64/include/asm/pgalloc.h |  1 -
>>   arch/arm64/include/asm/tlb.h     | 14 ++++++++++++++
>>   2 files changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
>> index 2965f5a7e39e3..1b4509d3382c6 100644
>> --- a/arch/arm64/include/asm/pgalloc.h
>> +++ b/arch/arm64/include/asm/pgalloc.h
>> @@ -85,7 +85,6 @@ static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgdp, p4d_t *p4dp)
>>   	__pgd_populate(pgdp, __pa(p4dp), pgdval);
>>   }
>>   
>> -#define __p4d_free_tlb(tlb, p4d, addr)  p4d_free((tlb)->mm, p4d)
>>   #else
>>   static inline void __pgd_populate(pgd_t *pgdp, phys_addr_t p4dp, pgdval_t prot)
>>   {
>> diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
>> index a947c6e784ed2..445282cde9afb 100644
>> --- a/arch/arm64/include/asm/tlb.h
>> +++ b/arch/arm64/include/asm/tlb.h
>> @@ -111,4 +111,18 @@ static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pudp,
>>   }
>>   #endif
>>   
>> +#if CONFIG_PGTABLE_LEVELS > 4
>> +static inline void __p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4dp,
>> +				  unsigned long addr)
>> +{
>> +	struct ptdesc *ptdesc = virt_to_ptdesc(p4dp);
>> +
>> +	if (!pgtable_l5_enabled())
>> +		return;
>> +
>> +	pagetable_p4d_dtor(ptdesc);
>> +	tlb_remove_ptdesc(tlb, ptdesc);
>> +}
> 
> Should we update p4d_free() to call the destructor, too? It looks like
> it just does free_page() atm.

The patch #3 introduces the generic p4d_free() and lets arm64 to use it.
The patch #4 adds the destructor to generic p4d_free(). So IIUC, there
is no problem here.

Thanks!

> 
> Will

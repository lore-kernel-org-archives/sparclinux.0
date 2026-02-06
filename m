Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEEA2C1598
	for <sparclinux@vger.kernel.org>; Fri,  6 Feb 2026 11:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770376455; cv=none; b=mlIv8MorSmaQ+ch8wvQrLwcwsdBNXQfVMLGokcDxN5FHmlJo4UidIHUNRIArcPZXnlILMk9/kOilp9rc8HakY0ecAs5vAR8ZLFDeCWQUm0U2q4+AahY42hUKuQDot6o+V3Eg1uRWKDDVEFgwi3KthX3Jpyh06lggY35ArHO6veg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770376455; c=relaxed/simple;
	bh=tRTch7DcVYVaxVVMhGdmN8hWxvXz/LeeIkso6ntFpkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DzmjPhHrMHA4CM/RrHqtEah1eYzgrGvAZoEb6um9aOth0+juXaCBv2b1EvNWkpF1OX7tBF9RT4Kyhiui0PVist4mNSgi0lwd2sc6u0a++gg0rMmdOEbvH/3eb7XXEyRv3yqPslE2G9fjMI7lerUesEphDvJHwZM4CbHHLg/Ia3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RaPi3BqZ; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RaPi3BqZ"
Message-ID: <1663ae90-3247-4e12-a25a-049fc3281e19@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770376450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t10+cy0YbJp1qzuAruOEDHFVPEgf+sIN5MYp954+hik=;
	b=RaPi3BqZPsLqUSHKWvjkyZ/Bf9ppgLwDMnRp3djinkfcParF3X0U5UOMZXVjnrIIj+XKGG
	qik03O+yZh0BczTm4tqsQ4ypqJYxgFR02cW1b2w7PUE2iHSCCwxRYQBdSb0+Sx1HZWERjm
	cI4FFTRQSuQeqxHQ+OOhNwrumpE+hso=
Date: Fri, 6 Feb 2026 19:13:59 +0800
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 7/8] mm: convert __HAVE_ARCH_TLB_REMOVE_TABLE to
 CONFIG_HAVE_ARCH_TLB_REMOVE_TABLE config
To: "David Hildenbrand (Arm)" <david@kernel.org>, andreas@gaisler.com,
 richard.weiyang@gmail.com, will@kernel.org, peterz@infradead.org,
 aneesh.kumar@kernel.org, npiggin@gmail.com, dev.jain@arm.com,
 ioworker0@gmail.com, linmag7@gmail.com, akpm@linux-foundation.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-alpha@vger.kernel.org, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-um@lists.infradead.org, sparclinux@vger.kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1769515122.git.zhengqi.arch@bytedance.com>
 <5ebfa3d4b56e63c6906bda5eccaa9f7194d3a86b.1769515122.git.zhengqi.arch@bytedance.com>
 <a404e9ec-35ff-44b1-b321-9cc4fbf72060@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <a404e9ec-35ff-44b1-b321-9cc4fbf72060@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2/6/26 7:06 PM, David Hildenbrand (Arm) wrote:
> On 1/27/26 13:13, Qi Zheng wrote:
>> From: Qi Zheng <zhengqi.arch@bytedance.com>
>>
>> For architectures that define __HAVE_ARCH_TLB_REMOVE_TABLE, the page
>> tables at the pmd/pud level are generally not of struct ptdesc type, and
>> do not have pt_rcu_head member, thus these architectures cannot support
>> PT_RECLAIM.
>>
>> In preparation for enabling PT_RECLAIM on more architectures, convert
>> __HAVE_ARCH_TLB_REMOVE_TABLE to CONFIG_HAVE_ARCH_TLB_REMOVE_TABLE config,
>> so that we can make conditional judgments in Kconfig.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>>   arch/powerpc/Kconfig            | 1 +
>>   arch/powerpc/include/asm/tlb.h  | 1 -
>>   arch/sparc/Kconfig              | 1 +
>>   arch/sparc/include/asm/tlb_64.h | 1 -
>>   include/asm-generic/tlb.h       | 2 +-
>>   mm/Kconfig                      | 3 +++
>>   6 files changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index 9537a61ebae02..b47aa8fd62742 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -304,6 +304,7 @@ config PPC
>>       select LOCK_MM_AND_FIND_VMA
>>       select MMU_GATHER_PAGE_SIZE
>>       select MMU_GATHER_RCU_TABLE_FREE
>> +    select HAVE_ARCH_TLB_REMOVE_TABLE
>>       select MMU_GATHER_MERGE_VMAS
>>       select MMU_LAZY_TLB_SHOOTDOWN        if PPC_BOOK3S_64
>>       select MODULES_USE_ELF_RELA
>> diff --git a/arch/powerpc/include/asm/tlb.h b/arch/powerpc/include/ 
>> asm/tlb.h
>> index 2058e8d3e0138..1ca7d4c4b90db 100644
>> --- a/arch/powerpc/include/asm/tlb.h
>> +++ b/arch/powerpc/include/asm/tlb.h
>> @@ -37,7 +37,6 @@ extern void tlb_flush(struct mmu_gather *tlb);
>>    */
>>   #define tlb_needs_table_invalidate()    radix_enabled()
>> -#define __HAVE_ARCH_TLB_REMOVE_TABLE
>>   /* Get the generic bits... */
>>   #include <asm-generic/tlb.h>
>> diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
>> index a630d373e6453..25fa2908d6152 100644
>> --- a/arch/sparc/Kconfig
>> +++ b/arch/sparc/Kconfig
>> @@ -74,6 +74,7 @@ config SPARC64
>>       select HAVE_KRETPROBES
>>       select HAVE_KPROBES
>>       select MMU_GATHER_RCU_TABLE_FREE if SMP
>> +    select HAVE_ARCH_TLB_REMOVE_TABLE if SMP
> 
> Why the SMP? At least in tlb_64.h, it was not protected by SMP IIUC.

Ah, It's just simply aligned with the MMU_GATHER_RCU_TABLE_FREE above.

> 
> Apart from that LGTM.

Thanks!

> 


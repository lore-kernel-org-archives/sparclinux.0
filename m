Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14ECD350A37
	for <sparclinux@vger.kernel.org>; Fri,  6 Feb 2026 11:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770379163; cv=none; b=szBhzMBl7LuK4NJJVZ9IvYfCLFm28/0w8ybOSDLu59Ku2h3pHDrG9/xbZxdxYU/UtavT7kcdD29Qz9JnEpzS0/ed/niWU7Y9NFP/TFvDkEl0CVmV9+JRuqd2xb0A/Ndoiz24O4oEMLvG5Cqv9q5FQiwlJplnxTpb0PhS75OdEt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770379163; c=relaxed/simple;
	bh=+A16dlSrpkLhww/zTmwRNkU01MPLmwD05fJiMnG/nig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kZtzwjBnB1ivzveCinZro/4v6eR03IMNqAZbden3FjDQb2OHAAxHEsYsoGV8yIYo20HFiSS43vVQ+Oz+oNUZqo5by8n52UVgp0h0WkV6Zo3n1XRU/Zhg3L4yUuFRhN6HDhLsEMIitHO5wBi2+vC0Bw2zo28mKhMgDgk34pfhLZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Aalvtl60; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Aalvtl60"
Message-ID: <53a1bbdd-26d1-454d-af06-169172278718@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770379151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5dYqXq1NRIfJySgnYSgnc1Tt2EdVmznlx20DFcIB6kE=;
	b=Aalvtl60ATdjvtCv049X0heOLjC3Ne6UC4Jnw9CBdMvR2rHyEUK1QbvxylKB+AHtJsEUAU
	qvz+5iU0N8RA5zOq5wxvvGIq8Nn3kg8PMVar5v/lHabP5zzzP0j4LoFOtXGenQaBOxygN1
	8rGXHcgmdNLdrCK3y2uriNFt0zpk2rs=
Date: Fri, 6 Feb 2026 19:58:47 +0800
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
 <1663ae90-3247-4e12-a25a-049fc3281e19@linux.dev>
 <538fef61-3903-407e-8486-538a28b99e9d@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <538fef61-3903-407e-8486-538a28b99e9d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2/6/26 7:45 PM, David Hildenbrand (Arm) wrote:
> On 2/6/26 12:13, Qi Zheng wrote:
>>
>>
>> On 2/6/26 7:06 PM, David Hildenbrand (Arm) wrote:
>>> On 1/27/26 13:13, Qi Zheng wrote:
>>>> From: Qi Zheng <zhengqi.arch@bytedance.com>
>>>>
>>>> For architectures that define __HAVE_ARCH_TLB_REMOVE_TABLE, the page
>>>> tables at the pmd/pud level are generally not of struct ptdesc type, 
>>>> and
>>>> do not have pt_rcu_head member, thus these architectures cannot support
>>>> PT_RECLAIM.
>>>>
>>>> In preparation for enabling PT_RECLAIM on more architectures, convert
>>>> __HAVE_ARCH_TLB_REMOVE_TABLE to CONFIG_HAVE_ARCH_TLB_REMOVE_TABLE 
>>>> config,
>>>> so that we can make conditional judgments in Kconfig.
>>>>
>>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>>> ---
>>>>   arch/powerpc/Kconfig            | 1 +
>>>>   arch/powerpc/include/asm/tlb.h  | 1 -
>>>>   arch/sparc/Kconfig              | 1 +
>>>>   arch/sparc/include/asm/tlb_64.h | 1 -
>>>>   include/asm-generic/tlb.h       | 2 +-
>>>>   mm/Kconfig                      | 3 +++
>>>>   6 files changed, 6 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>>>> index 9537a61ebae02..b47aa8fd62742 100644
>>>> --- a/arch/powerpc/Kconfig
>>>> +++ b/arch/powerpc/Kconfig
>>>> @@ -304,6 +304,7 @@ config PPC
>>>>       select LOCK_MM_AND_FIND_VMA
>>>>       select MMU_GATHER_PAGE_SIZE
>>>>       select MMU_GATHER_RCU_TABLE_FREE
>>>> +    select HAVE_ARCH_TLB_REMOVE_TABLE
>>>>       select MMU_GATHER_MERGE_VMAS
>>>>       select MMU_LAZY_TLB_SHOOTDOWN        if PPC_BOOK3S_64
>>>>       select MODULES_USE_ELF_RELA
>>>> diff --git a/arch/powerpc/include/asm/tlb.h b/arch/powerpc/include/ 
>>>> asm/tlb.h
>>>> index 2058e8d3e0138..1ca7d4c4b90db 100644
>>>> --- a/arch/powerpc/include/asm/tlb.h
>>>> +++ b/arch/powerpc/include/asm/tlb.h
>>>> @@ -37,7 +37,6 @@ extern void tlb_flush(struct mmu_gather *tlb);
>>>>    */
>>>>   #define tlb_needs_table_invalidate()    radix_enabled()
>>>> -#define __HAVE_ARCH_TLB_REMOVE_TABLE
>>>>   /* Get the generic bits... */
>>>>   #include <asm-generic/tlb.h>
>>>> diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
>>>> index a630d373e6453..25fa2908d6152 100644
>>>> --- a/arch/sparc/Kconfig
>>>> +++ b/arch/sparc/Kconfig
>>>> @@ -74,6 +74,7 @@ config SPARC64
>>>>       select HAVE_KRETPROBES
>>>>       select HAVE_KPROBES
>>>>       select MMU_GATHER_RCU_TABLE_FREE if SMP
>>>> +    select HAVE_ARCH_TLB_REMOVE_TABLE if SMP
>>>
>>> Why the SMP? At least in tlb_64.h, it was not protected by SMP IIUC.
>>
>> Ah, It's just simply aligned with the MMU_GATHER_RCU_TABLE_FREE above.
> 
> But does that work as expected for !SMP?

In the case of !SMP, tlb_remove_table() will not be called:

static inline void pgtable_free_tlb(struct mmu_gather *tlb, void *table, 
bool is_page)
{
	pgtable_free(table, is_page);
}


so I think it's okay to only select it in case of SMP.

> 


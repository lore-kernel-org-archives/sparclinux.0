Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1970533892F;
	Wed, 17 Dec 2025 10:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765965701; cv=none; b=ByJOfcfuJFsmsS1waYvKnV8h3fOmnqtgc6IEQb4455JnvbAAscGvcTAUB1JLPQ14MCHriwGUzBfem6WCGcorcrkaGH0youLn8bNQgqGD9EFhQ7DBRFkB9ULkCKLNbb+fo5CwrrfBXMRPuV6Kx3hcGCTdfvDmKZqSqzNsgG6cxtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765965701; c=relaxed/simple;
	bh=cAa9LkyHWIQO7QrMTWLIp7mb0Rh6ne9Dx1EwQ1QteaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q2yWw1mij1Qhs4HBTr4OqRYBqIANDKySHc0gZJK/CTyZ/zdostm2Tv31R4pX0UuFU1lIBNepIYxRZRIgndTn5GQAm+1RxV+JNu4QYat3aaBSsL2bmZh9jr8RN28iZK9nc6FIPZJQFJqI+DEFvbM11sEXy+cpeu46MTiDsirCLJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 326E314BF;
	Wed, 17 Dec 2025 02:01:32 -0800 (PST)
Received: from [10.57.91.77] (unknown [10.57.91.77])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B4ADE3F73B;
	Wed, 17 Dec 2025 02:01:32 -0800 (PST)
Message-ID: <ca0da7fd-245c-4d52-8f4d-f8fce4717494@arm.com>
Date: Wed, 17 Dec 2025 10:01:30 +0000
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 14/14] mm: Add basic tests for lazy_mmu
Content-Language: en-GB
To: Kevin Brodsky <kevin.brodsky@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Andreas Larsson <andreas@gaisler.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Borislav Petkov
 <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 David Hildenbrand <david@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, David Woodhouse <dwmw2@infradead.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
 Jann Horn <jannh@google.com>, Juergen Gross <jgross@suse.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>,
 Mike Rapoport <rppt@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner
 <tglx@linutronix.de>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
 Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>,
 Yeoreum Yun <yeoreum.yun@arm.com>, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
 xen-devel@lists.xenproject.org, x86@kernel.org
References: <20251215150323.2218608-1-kevin.brodsky@arm.com>
 <20251215150323.2218608-15-kevin.brodsky@arm.com>
 <20251216201403.4647a4f9861d3122ee9e90d7@linux-foundation.org>
 <f9550d22-8810-4145-aaa8-48961f6ea35e@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <f9550d22-8810-4145-aaa8-48961f6ea35e@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/12/2025 09:26, Kevin Brodsky wrote:
> On 17/12/2025 05:14, Andrew Morton wrote:
>> On Mon, 15 Dec 2025 15:03:23 +0000 Kevin Brodsky <kevin.brodsky@arm.com> wrote:
>>
>>> Add basic KUnit tests for the generic aspects of the lazy MMU mode:
>>> ensure that it appears active when it should, depending on how
>>> enable/disable and pause/resume pairs are nested.
>> I needed this for powerpc allmodconfig;
>>
>> --- a/arch/powerpc/mm/book3s64/hash_tlb.c~mm-add-basic-tests-for-lazy_mmu-fix
>> +++ a/arch/powerpc/mm/book3s64/hash_tlb.c
>> @@ -30,6 +30,7 @@
>>  #include <trace/events/thp.h>
>>  
>>  DEFINE_PER_CPU(struct ppc64_tlb_batch, ppc64_tlb_batch);
>> +EXPORT_SYMBOL_GPL(ppc64_tlb_batch);
>>  
>>  /*
>>   * A linux PTE was changed and the corresponding hash table entry
>> @@ -154,6 +155,7 @@ void __flush_tlb_pending(struct ppc64_tl
>>  		flush_hash_range(i, local);
>>  	batch->index = 0;
>>  }
>> +EXPORT_SYMBOL_GPL(__flush_tlb_pending);
>>  
>>  void hash__tlb_flush(struct mmu_gather *tlb)
>>  {
>> _
> 
> Oh indeed I hadn't considered that arch_{enter,leave}_lazy_mmu_mode()
> refer to those symbols on powerpc... Maybe a bit overkill to export
> those just for a test module, but I'm not sure there's a good
> alternative. Forcing LAZY_MMU_MODE_KUNIT_TEST=y is ugly as it would also
> force KUNIT=y. Alternatively we could depend on !PPC, not pretty either.

Does EXPORT_SYMBOL_IF_KUNIT() help?

> 
> - Kevin


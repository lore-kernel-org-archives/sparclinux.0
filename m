Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC022E8B66;
	Fri,  5 Dec 2025 12:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764938847; cv=none; b=TXeCxtaxYACbPQPWrZmWw0Ic7/WWyMQQDZtoqPqbuJ21qXxRJss6ARuJIzQTD9A/s0OJE4IRUmrVr0j3AM2sr3c/UZDsObAU75VPiwpHci+eav8oK2M9sStyZZp3OPour/+p+v0O9JofRb0HGD35K0hISND7Z+JR6WfTZpKR+j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764938847; c=relaxed/simple;
	bh=JJeIvK3HAabq88aBjXlSgNd8kvCZeiN2mpPzAxjpuEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W40ZpncSZjkTcSvlgVzpsVaVbdejnPfVG7ME6vl2VDdBEFySCMBvuSpV64qzUyNJ82FKR7oqleEZ42vq56Sj6CmkTboWZ1AAB6GuH8ZxFtth85CIFfZiRrgbpgyFZ6TrYCFC7aY351Of5z/hgqBfnI59ElP/CLyVsJkA+JBTUR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD460339;
	Fri,  5 Dec 2025 04:47:15 -0800 (PST)
Received: from [10.44.160.68] (e126510-lin.lund.arm.com [10.44.160.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A5F6D3F86F;
	Fri,  5 Dec 2025 04:47:15 -0800 (PST)
Message-ID: <573881f1-60f7-4eb3-a484-1df4858aa1b4@arm.com>
Date: Fri, 5 Dec 2025 13:47:12 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/12] mm: introduce generic lazy_mmu helpers
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
 Andreas Larsson <andreas@gaisler.com>,
 Andrew Morton <akpm@linux-foundation.org>,
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
 Ryan Roberts <ryan.roberts@arm.com>, Suren Baghdasaryan <surenb@google.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
 Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>,
 Yeoreum Yun <yeoreum.yun@arm.com>, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
 xen-devel@lists.xenproject.org, x86@kernel.org
References: <20251124132228.622678-1-kevin.brodsky@arm.com>
 <20251124132228.622678-7-kevin.brodsky@arm.com>
 <e43c147f-bff8-462a-88dc-4345500f4ed7@arm.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <e43c147f-bff8-462a-88dc-4345500f4ed7@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/12/2025 05:17, Anshuman Khandual wrote:
> On 24/11/25 6:52 PM, Kevin Brodsky wrote:
>> The implementation of the lazy MMU mode is currently entirely
>> arch-specific; core code directly calls arch helpers:
>> arch_{enter,leave}_lazy_mmu_mode().
>>
>> We are about to introduce support for nested lazy MMU sections.
>> As things stand we'd have to duplicate that logic in every arch
>> implementing lazy_mmu - adding to a fair amount of logic
>> already duplicated across lazy_mmu implementations.
>>
>> This patch therefore introduces a new generic layer that calls the
>> existing arch_* helpers. Two pair of calls are introduced:
>>
>> * lazy_mmu_mode_enable() ... lazy_mmu_mode_disable()
>>     This is the standard case where the mode is enabled for a given
>>     block of code by surrounding it with enable() and disable()
>>     calls.
>>
>> * lazy_mmu_mode_pause() ... lazy_mmu_mode_resume()
>>     This is for situations where the mode is temporarily disabled
>>     by first calling pause() and then resume() (e.g. to prevent any
>>     batching from occurring in a critical section).
>>
>> The documentation in <linux/pgtable.h> will be updated in a
>> subsequent patch.
>>> No functional change should be introduced at this stage.
>> The implementation of enable()/resume() and disable()/pause() is
>> currently identical, but nesting support will change that.
>>
>> Most of the call sites have been updated using the following
>> Coccinelle script:
>>
>> @@
>> @@
>> {
>> ...
>> - arch_enter_lazy_mmu_mode();
>> + lazy_mmu_mode_enable();
>> ...
>> - arch_leave_lazy_mmu_mode();
>> + lazy_mmu_mode_disable();
>> ...
>> }
>>
>> @@
>> @@
>> {
>> ...
>> - arch_leave_lazy_mmu_mode();
>> + lazy_mmu_mode_pause();
>> ...
>> - arch_enter_lazy_mmu_mode();
>> + lazy_mmu_mode_resume();
>> ...
>> }
> At this point arch_enter/leave_lazy_mmu_mode() helpers are still
> present on a given platform but now being called from new generic
> helpers lazy_mmu_mode_enable/disable(). Well except x86, there is
> direct call sites for those old helpers.

Indeed, see notes below regarding x86. The direct calls to arch_flush()
are specific to x86 and there shouldn't be a need for a generic abstraction.

- Kevin

> arch/arm64/include/asm/pgtable.h:static inline void arch_enter_lazy_mmu_mode(void)
> arch/arm64/include/asm/pgtable.h:static inline void arch_leave_lazy_mmu_mode(void)
>
> arch/arm64/mm/mmu.c:    lazy_mmu_mode_enable();
> arch/arm64/mm/pageattr.c:       lazy_mmu_mode_enable();
>
> arch/arm64/mm/mmu.c:    lazy_mmu_mode_disable();
> arch/arm64/mm/pageattr.c:       lazy_mmu_mode_disable();
>
>> A couple of notes regarding x86:
>>
>> * Xen is currently the only case where explicit handling is required
>>   for lazy MMU when context-switching. This is purely an
>>   implementation detail and using the generic lazy_mmu_mode_*
>>   functions would cause trouble when nesting support is introduced,
>>   because the generic functions must be called from the current task.
>>   For that reason we still use arch_leave() and arch_enter() there.
>>
>> * x86 calls arch_flush_lazy_mmu_mode() unconditionally in a few
>>   places, but only defines it if PARAVIRT_XXL is selected, and we
>>   are removing the fallback in <linux/pgtable.h>. Add a new fallback
>>   definition to <asm/pgtable.h> to keep things building.
>>
>> [...]

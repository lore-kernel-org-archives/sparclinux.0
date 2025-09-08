Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD24A45945;
	Mon,  8 Sep 2025 07:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757316763; cv=none; b=lj5wWXzMXTS3hCRJ7da65dvg+Z+2GO90wmIkoqLa6KTa4WAtfUTyowtFb/rcQRHWz1zHPe4pxqA5tgkmn756vMcM/gtZ50kSsVjTOFklutGhZOPm1CTmB2edHFcZnpwNnoywu0hT2X0KzepmEZshSZAH3FNQeg1+vxN/rU/nhdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757316763; c=relaxed/simple;
	bh=8R5P2dpDsvTASOuuyiS145RMT8QLk3YS+Df8VTYF/Hk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QMUqOsCYV7/koZlLFx53LUJXuaCp4coJTxqZCt2jzoieOt1j37UIo88hNKB8A6xHYPaXckKhbIrMNeYbdi3gTM/5gKaZtxVfggqSMSRN7Tec/CqtmM1Di7pkNlAYpIjOVYIpGOu4fqAxtqlVjGwoKt9UqHcygYOxVBmYmuUeYlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88AA2169C;
	Mon,  8 Sep 2025 00:32:32 -0700 (PDT)
Received: from [10.57.58.69] (unknown [10.57.58.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CFA563F63F;
	Mon,  8 Sep 2025 00:32:34 -0700 (PDT)
Message-ID: <1f822d8b-eb46-4998-b1c1-9996d70e1958@arm.com>
Date: Mon, 8 Sep 2025 09:32:32 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] powerpc/mm: support nested lazy_mmu sections
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Andreas Larsson <andreas@gaisler.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Borislav Petkov
 <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 David Hildenbrand <david@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, "H. Peter Anvin" <hpa@zytor.com>,
 Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
 Juergen Gross <jgross@suse.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>,
 Mike Rapoport <rppt@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner
 <tglx@linutronix.de>, Vlastimil Babka <vbabka@suse.cz>,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
 xen-devel@lists.xenproject.org
References: <20250904125736.3918646-1-kevin.brodsky@arm.com>
 <20250904125736.3918646-6-kevin.brodsky@arm.com>
 <074ff6ab-5868-4fde-b5bb-9e17632ad817-agordeev@linux.ibm.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <074ff6ab-5868-4fde-b5bb-9e17632ad817-agordeev@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/09/2025 17:52, Alexander Gordeev wrote:
> On Thu, Sep 04, 2025 at 01:57:34PM +0100, Kevin Brodsky wrote:
> ...
>>  static inline lazy_mmu_state_t arch_enter_lazy_mmu_mode(void)
>>  {
>>  	struct ppc64_tlb_batch *batch;
>> +	int lazy_mmu_nested;
>>  
>>  	if (radix_enabled())
>>  		return LAZY_MMU_DEFAULT;
>> @@ -39,9 +40,14 @@ static inline lazy_mmu_state_t arch_enter_lazy_mmu_mode(void)
>>  	 */
>>  	preempt_disable();
>>  	batch = this_cpu_ptr(&ppc64_tlb_batch);
>> -	batch->active = 1;
>> +	lazy_mmu_nested = batch->active;
>>  
>> -	return LAZY_MMU_DEFAULT;
>> +	if (!lazy_mmu_nested) {
> Why not just?
>
> 	if (!batch->active) {

Very fair question! I think the extra variable made sense in an earlier
version of that patch, but now it's used only once and doesn't really
improve readability either. Will remove it in v2, also in patch 6
(basically the same code). Thanks!

- Kevin

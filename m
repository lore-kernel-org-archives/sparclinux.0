Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1925E1E5B78;
	Thu,  6 Nov 2025 10:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762425117; cv=none; b=Nt15PTJclJwtNpYBRE+by3h+4qanZYiG0pMDrGHQpPflncDYL/OQOiTSkcPTq+Jl263C7rXFgipjsrGTeWQFFNj8pfkZGmeuUAz3MBNXtWhdZjQGm4U0FBMEAlN5dC80luAmbXpSWMTLrbL1QfCeC/4TmAvTEtIHFFhct906MYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762425117; c=relaxed/simple;
	bh=MwOtJ+XDknjQvh1eKSlSlxJD9OqwTD5oV9YcUA4abG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fObA9RJCI4ES+z/29D4ldajPtavxzUetXerh3LhvrAT2c8kgkGCO9R3Nk+gC0kjUZGza/W7h3r+kn1WInjpsU1JYkM0OyU7MEOEUZ8thmES3LgKHA1GDZDL+8Z9ektgQ5D75nlgaLgY/BnU7SqgcqxkM5y2vXE2CtlWBYPFpxhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 87B131596;
	Thu,  6 Nov 2025 02:31:47 -0800 (PST)
Received: from [10.1.34.75] (unknown [10.1.34.75])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 32C3E3F66E;
	Thu,  6 Nov 2025 02:31:49 -0800 (PST)
Message-ID: <0276c749-9418-47ea-85f1-0b0ab93b0225@arm.com>
Date: Thu, 6 Nov 2025 10:31:46 +0000
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/12] powerpc/mm: implement arch_flush_lazy_mmu_mode()
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, linux-mm@kvack.org
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
 Peter Zijlstra <peterz@infradead.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner
 <tglx@linutronix.de>, Vlastimil Babka <vbabka@suse.cz>,
 Will Deacon <will@kernel.org>, Yeoreum Yun <yeoreum.yun@arm.com>,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org
References: <20251029100909.3381140-1-kevin.brodsky@arm.com>
 <20251029100909.3381140-4-kevin.brodsky@arm.com>
 <87pl9x41c5.ritesh.list@gmail.com> <87jz044xn4.ritesh.list@gmail.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <87jz044xn4.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/11/2025 09:49, Ritesh Harjani (IBM) wrote:
> Ritesh Harjani (IBM) <ritesh.list@gmail.com> writes:
>
>> Kevin Brodsky <kevin.brodsky@arm.com> writes:
>>
>>> Upcoming changes to the lazy_mmu API will cause
>>> arch_flush_lazy_mmu_mode() to be called when leaving a nested
>>> lazy_mmu section.
>>>
>>> Move the relevant logic from arch_leave_lazy_mmu_mode() to
>>> arch_flush_lazy_mmu_mode() and have the former call the latter.
>>>
>>> Note: the additional this_cpu_ptr() on the
>>> arch_leave_lazy_mmu_mode() path will be removed in a subsequent
>>> patch.
>>>
>>> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
>>> ---
>>>  .../powerpc/include/asm/book3s/64/tlbflush-hash.h | 15 +++++++++++----
>>>  1 file changed, 11 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h b/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
>>> index 146287d9580f..7704dbe8e88d 100644
>>> --- a/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
>>> +++ b/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
>>> @@ -41,6 +41,16 @@ static inline void arch_enter_lazy_mmu_mode(void)
>>>  	batch->active = 1;
>>>  }
>>>  
>>> +static inline void arch_flush_lazy_mmu_mode(void)
>>> +{
>>> +	struct ppc64_tlb_batch *batch;
>>> +
>>> +	batch = this_cpu_ptr(&ppc64_tlb_batch);
>>> +
>>> +	if (batch->index)
>>> +		__flush_tlb_pending(batch);
>>> +}
>>> +
>> This looks a bit scary since arch_flush_lazy_mmu_mode() is getting
>> called from several of the places in later patches(). 
>>
>> Although I think arch_flush_lazy_mmu_mode() will only always be called
>> in nested lazy mmu case right?
>>
>> Do you think we can add a VM_BUG_ON(radix_enabled()); in above to make
>> sure the above never gets called in radix_enabled() case. 
>>
>> I am still going over the patch series, but while reviewing this I
>> wanted to take your opinion.
>>
>> Ohh wait.. There is no way of knowing the return value from
>> arch_enter_lazy_mmu_mode().. I think you might need a similar check to
>> return from arch_flush_lazy_mmu_mode() too, if radix_enabled() is true.
>>
> Now that I have gone through this series, it seems plaussible that since
> lazy mmu mode supports nesting, arch_flush_lazy_mmu_mode() can get
> called while the lazy mmu is active due to nesting.. 
>
> That means we should add the radix_enabled() check as I was talking in
> above i.e. 
>
> @@ -38,6 +38,9 @@ static inline void arch_flush_lazy_mmu_mode(void)
>  {
>         struct ppc64_tlb_batch *batch;
>
> +       if (radix_enabled())
> +               return;
> +
>         batch = this_cpu_ptr(&ppc64_tlb_batch);
>
>         if (batch->index)
>
> Correct? Although otherwise also I don't think it should be a problem
> because batch->index is only valid during hash, but I still think we can
> add above check so that we don't have to call this_cpu_ptr() to check
> for batch->index whenever flush is being called.

You're right! I missed this because v3 had an extra patch (13) that
turned all the lazy_mmu_mode_* into no-ops if radix_enabled(). The
optimisation didn't seem to be worth the noise so I dropped it, but it
does mean that arch_flush() will now be called in the nested case
regardless of radix_enabled().

Will fix in v5, thanks!

- Kevin

Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AEF2E091B;
	Mon, 24 Nov 2025 12:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763988488; cv=none; b=B6Xa/pIlSnF+0oJY7UJc1J+GTEamr2kdKJL8/xM3O+9jF+D1+Sy7z6WvLmJZ9dHP3YK2ci2RhT6eSfv4aMhcgKOxL4wSqaplcbKmSc31BWfwgejWYzinAEh7/cBKuP5k65zgYc91DG9il40N86EsnO2CGn6KGtfOX7kPpDpn4SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763988488; c=relaxed/simple;
	bh=QD5KIcTPUOqGYmRY/WOutCo+5EpteAf2SGkLndrJB6I=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=bbCi/MzcWmbE1QsN8B9AVAKJIGfh7mYUKhcYX+qBafKCC2BW20br7SqKCe1q+yxh9GvGci8Duh6t8tfE5r746s1L1tgv4/fsUncZbyXhUcAsQ6jKE4dJOiu6vCR/6mpEMJk4VB/dYoPLYL1OVtFcFaqbwxxWfcfOgATcxYXVaqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 57038497;
	Mon, 24 Nov 2025 04:47:57 -0800 (PST)
Received: from [10.57.40.193] (unknown [10.57.40.193])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AEF4F3F6A8;
	Mon, 24 Nov 2025 04:47:56 -0800 (PST)
Message-ID: <f36ebc15-c724-487a-8e4a-9ca95edc544a@arm.com>
Date: Mon, 24 Nov 2025 13:47:53 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/12] mm: introduce generic lazy_mmu helpers
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>, linux-mm@kvack.org
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
 Peter Zijlstra <peterz@infradead.org>, Suren Baghdasaryan
 <surenb@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>,
 Yeoreum Yun <yeoreum.yun@arm.com>, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
 xen-devel@lists.xenproject.org, x86@kernel.org
References: <20251029100909.3381140-1-kevin.brodsky@arm.com>
 <20251029100909.3381140-7-kevin.brodsky@arm.com>
 <71418b31-aedb-4600-9558-842515dd6c44@arm.com>
 <b44825dd-aef9-4d3e-91fd-a44122264c23@arm.com>
Content-Language: en-GB
In-Reply-To: <b44825dd-aef9-4d3e-91fd-a44122264c23@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/11/2025 11:45, Kevin Brodsky wrote:
>>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>>> index b8d37eb037fc..d9c8e94f140f 100644
>>> --- a/arch/arm64/mm/mmu.c
>>> +++ b/arch/arm64/mm/mmu.c
>>> @@ -731,7 +731,7 @@ int split_kernel_leaf_mapping(unsigned long start, unsigned long end)
>>>  		return -EINVAL;
>>>  
>>>  	mutex_lock(&pgtable_split_lock);
>>> -	arch_enter_lazy_mmu_mode();
>>> +	lazy_mmu_mode_enable();
>>>  
>>>  	/*
>>>  	 * The split_kernel_leaf_mapping_locked() may sleep, it is not a
>> This is a bit unfortunate, IMHO. The rest of this comment explains that although
>> you're not supposed to sleep inside lazy mmu mode, it's fine for arm64's
>> implementation. But we are no longer calling arm64's implementation; we are
>> calling a generic function, which does who knows what.
>>
>> I think it all still works, but we are no longer containing our assumptions in
>> arm64 code. We are relying on implementation details of generic code.
> I see your point. The change itself is still correct (and required
> considering patch 8), but maybe the documentation of the generic
> interface should be clarified to guarantee that the generic layer can
> itself cope with sleeping - without any guarantee regarding the
> behaviour of arch_*_lazy_mmu_mode.

Re-reading the existing comment in <linux/pgtable.h>, I think it already
makes clear that sleeping is not forbidden by design:

>  * In the general case, no lock is guaranteed to be held between entry
> and exit
>  * of the lazy mode. So the implementation must assume preemption may
> be enabled
>  * and cpu migration is possible; it must take steps to be robust
> against this.

The arch implementation may disable preemption, but arm64 code can rely
on the arm64 implementation allowing sleeping.

- Kevin


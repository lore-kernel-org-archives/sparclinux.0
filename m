Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026603207;
	Fri,  7 Nov 2025 11:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762514014; cv=none; b=QeaNeSrl51oTWojRv9EEd5GSBrcuRJLlXvd8Bv+5jHuwWyYtA3j9fLTjukrqR6hRelRXO2KB5l0y3cMxUjNQ2VKWeQjdLLLsXhpRxflM1zrBl4OZe3brucDmpNDY+C/uBDXEBokBo4h3wGSzX6DFQS3OEYwNouducuRaayZDLZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762514014; c=relaxed/simple;
	bh=wcjIESsao+1zJZZHHAcwvWkQUWvBcOdgvfdZlvxEZ8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P75uo9VLgdWyRdC9jqzJY5+kYQHSgCY2FBg6S0+sCCfnuK/jC7YXY7YzTSCg/ngoSZ3h+sD2buPJ65daJUtn4e7FUGO0MUy9X26KVM2uQdKOpUiHHmgd73ktpynQMc51aCwKyZhbtLo7wd7QlavIv0q5+dMLl63/I2+UsYUqQfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 802C51477;
	Fri,  7 Nov 2025 03:13:24 -0800 (PST)
Received: from [10.1.36.52] (unknown [10.1.36.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 21B713F63F;
	Fri,  7 Nov 2025 03:13:28 -0800 (PST)
Message-ID: <84dab8b1-ea28-4dcc-9721-9aaa6fcd12ba@arm.com>
Date: Fri, 7 Nov 2025 11:13:15 +0000
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/12] mm: enable lazy_mmu sections to nest
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
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
 <20251029100909.3381140-8-kevin.brodsky@arm.com>
 <87ms5050g0.ritesh.list@gmail.com>
 <50d1b63a-88d7-4484-82c0-3bde96e3207d-agordeev@linux.ibm.com>
 <87ikfn3yvs.ritesh.list@gmail.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <87ikfn3yvs.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/11/2025 16:32, Ritesh Harjani (IBM) wrote:
> Alexander Gordeev <agordeev@linux.ibm.com> writes:
>
>> On Wed, Nov 05, 2025 at 02:19:03PM +0530, Ritesh Harjani wrote:
>>>> + * in_lazy_mmu_mode() can be used to check whether the lazy MMU mode is
>>>> + * currently enabled.
>>>>   */
>>>>  #ifdef CONFIG_ARCH_HAS_LAZY_MMU_MODE
>>>>  static inline void lazy_mmu_mode_enable(void)
>>>>  {
>>>> -	arch_enter_lazy_mmu_mode();
>>>> +	struct lazy_mmu_state *state = &current->lazy_mmu_state;
>>>> +
>>>> +	VM_WARN_ON_ONCE(state->nesting_level == U8_MAX);
>>>> +	/* enable() must not be called while paused */
>>>> +	VM_WARN_ON(state->nesting_level > 0 && !state->active);
>>>> +
>>>> +	if (state->nesting_level++ == 0) {
>>>> +		state->active = true;
>>>> +		arch_enter_lazy_mmu_mode();
>>>> +	}
>>>>  }
>>> Some architectures disables preemption in their
>>> arch_enter_lazy_mmu_mode(). So shouldn't the state->active = true should
>>> happen after arch_enter_lazy_mmu_mode() has disabled preemption()? i.e.
>> Do you have some scenario in mind that could cause an issue?
>>
> No not really. But that's a deviation from what previous arch hooks were
> expecting. Although thinking this through - I don't have any usecase
> where this can be a problem.

Which arch hook expectations are you referring to?

> But let me re-visit some of the code paths on ppc64 lazy mmu... 
>
> Looking at the arch specific usecase I see we always do get_cpu_var()
> for accessing the per-cpu batch array which disables preemption before
> accessing the per-cpu structure.. This per-cpu structure is where we
> batch pte updates...

arch_enter() disables preemption so accesses to per-CPU variables
anywhere in the section shouldn't be an issue either way.

The bigger picture (regarding patch 9) is that what in_lazy_mmu_state()
returns is based on the current task's state (not a per-CPU variable),
and always false while in interrupt. As a result whether preemption is
disabled or not should make no difference, only program order matters.

- Kevin

> For e.g... 
>   
>     arch_enter_lazy_mmu_mode()
>         hpte_need_flush()
>             get_cpu_var()   // this takes care of preempt_disable() 
>             adds vpns to per-cpu batch[i]
>             put_cpu_var()   // 
>     arch_leave_lazy_mmu_mode()
>
>> IOW, what could go wrong if the process is scheduled to another
>> CPU before preempt_disable() is called?
> So from above - I don't think your sequence to update
>    state->active = true 
> before calling arch_enter hook should be a problem.
> Based on above this looks mostly ok to me.
>
> -ritesh

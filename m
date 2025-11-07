Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5886B2C21D5;
	Fri,  7 Nov 2025 12:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762518534; cv=none; b=aS9iPUhurT8zsWtfLdWLglZhfrZ+/G57bBhoKKXm+uAUExzOZ6XNT86s5XZBQ44Bzig0ugywBW/a9fdyb+5nnieWYpqKzQUXGnG00lsiUImcVHrQmnNp/POBhcHSAhvp0cV9wDzHorrdFeA/X10lGOtFZS5LQge8lbxRH2jhm+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762518534; c=relaxed/simple;
	bh=MtMQbLtwv24yuX917Y0IPR3WTx0g2/Bra0Rsc9lOeoY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=m49KZy70RUzPjrjIRb/w9j5hcYEWxiEfzaa0D+TKmRqruyrLDX3vgXLip0v8zE6pqw5Ah6Sj+A0z7o2EUNN6Abq49jMZW7bs/T+qvFkgQse9h/KMket85iaRuIoZ13UJxeF8lcue9j7TcCJwWb2pcJCrf7GEQ7wXmtfYGzKOr2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F191B1516;
	Fri,  7 Nov 2025 04:28:44 -0800 (PST)
Received: from [10.57.86.134] (unknown [10.57.86.134])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0EEB03F66E;
	Fri,  7 Nov 2025 04:28:47 -0800 (PST)
Message-ID: <2205a5de-de14-4718-a7b8-e49accb06f03@arm.com>
Date: Fri, 7 Nov 2025 12:28:46 +0000
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/12] powerpc/64s: Do not re-activate batched TLB
 flush
Content-Language: en-GB
From: Ryan Roberts <ryan.roberts@arm.com>
To: Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org
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
 <20251029100909.3381140-2-kevin.brodsky@arm.com>
 <daa2025c-43da-4c16-9393-a90574d74f64@arm.com>
In-Reply-To: <daa2025c-43da-4c16-9393-a90574d74f64@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/11/2025 12:25, Ryan Roberts wrote:
> On 29/10/2025 10:08, Kevin Brodsky wrote:
>> From: Alexander Gordeev <agordeev@linux.ibm.com>
>>
>> Since commit b9ef323ea168 ("powerpc/64s: Disable preemption in hash
>> lazy mmu mode") a task can not be preempted while in lazy MMU mode.
>> Therefore, the batch re-activation code is never called, so remove it.
>>
>> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
>> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
> 
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

I should also add, that as far as I can tell, this was dead code because the
powerpc implementation disables preemption in a lazy mmu region. It would
probably be preferable to understand why the preemption disabling approach was
added in the first place. Perhaps it would be better to remove that and keep
this code. But given you are not changing any current behaviour and this is
removing dead code, that's probably something for the ppc folks to look into
another day.

Thanks,
Ryan

> 
>> ---
>>  arch/powerpc/include/asm/thread_info.h |  2 --
>>  arch/powerpc/kernel/process.c          | 25 -------------------------
>>  2 files changed, 27 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
>> index b0f200aba2b3..97f35f9b1a96 100644
>> --- a/arch/powerpc/include/asm/thread_info.h
>> +++ b/arch/powerpc/include/asm/thread_info.h
>> @@ -154,12 +154,10 @@ void arch_setup_new_exec(void);
>>  /* Don't move TLF_NAPPING without adjusting the code in entry_32.S */
>>  #define TLF_NAPPING		0	/* idle thread enabled NAP mode */
>>  #define TLF_SLEEPING		1	/* suspend code enabled SLEEP mode */
>> -#define TLF_LAZY_MMU		3	/* tlb_batch is active */
>>  #define TLF_RUNLATCH		4	/* Is the runlatch enabled? */
>>  
>>  #define _TLF_NAPPING		(1 << TLF_NAPPING)
>>  #define _TLF_SLEEPING		(1 << TLF_SLEEPING)
>> -#define _TLF_LAZY_MMU		(1 << TLF_LAZY_MMU)
>>  #define _TLF_RUNLATCH		(1 << TLF_RUNLATCH)
>>  
>>  #ifndef __ASSEMBLER__
>> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
>> index eb23966ac0a9..9237dcbeee4a 100644
>> --- a/arch/powerpc/kernel/process.c
>> +++ b/arch/powerpc/kernel/process.c
>> @@ -1281,9 +1281,6 @@ struct task_struct *__switch_to(struct task_struct *prev,
>>  {
>>  	struct thread_struct *new_thread, *old_thread;
>>  	struct task_struct *last;
>> -#ifdef CONFIG_PPC_64S_HASH_MMU
>> -	struct ppc64_tlb_batch *batch;
>> -#endif
>>  
>>  	new_thread = &new->thread;
>>  	old_thread = &current->thread;
>> @@ -1291,14 +1288,6 @@ struct task_struct *__switch_to(struct task_struct *prev,
>>  	WARN_ON(!irqs_disabled());
>>  
>>  #ifdef CONFIG_PPC_64S_HASH_MMU
>> -	batch = this_cpu_ptr(&ppc64_tlb_batch);
>> -	if (batch->active) {
>> -		current_thread_info()->local_flags |= _TLF_LAZY_MMU;
>> -		if (batch->index)
>> -			__flush_tlb_pending(batch);
>> -		batch->active = 0;
>> -	}
>> -
>>  	/*
>>  	 * On POWER9 the copy-paste buffer can only paste into
>>  	 * foreign real addresses, so unprivileged processes can not
>> @@ -1369,20 +1358,6 @@ struct task_struct *__switch_to(struct task_struct *prev,
>>  	 */
>>  
>>  #ifdef CONFIG_PPC_BOOK3S_64
>> -#ifdef CONFIG_PPC_64S_HASH_MMU
>> -	/*
>> -	 * This applies to a process that was context switched while inside
>> -	 * arch_enter_lazy_mmu_mode(), to re-activate the batch that was
>> -	 * deactivated above, before _switch(). This will never be the case
>> -	 * for new tasks.
>> -	 */
>> -	if (current_thread_info()->local_flags & _TLF_LAZY_MMU) {
>> -		current_thread_info()->local_flags &= ~_TLF_LAZY_MMU;
>> -		batch = this_cpu_ptr(&ppc64_tlb_batch);
>> -		batch->active = 1;
>> -	}
>> -#endif
>> -
>>  	/*
>>  	 * Math facilities are masked out of the child MSR in copy_thread.
>>  	 * A new task does not need to restore_math because it will
> 


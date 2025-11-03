Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA301B87C0;
	Mon,  3 Nov 2025 19:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762197821; cv=none; b=HrhShMqWM0ZhilHzzn6NoIFAo/Ku4VqiF67roXzVjUZv7t8a+PU/YtB+7fFSEHhWiFPOrdIVF3NXWwPR9f4ECkZ387syKFgKlw8q7nUKJMU/23/ZhD9cYWP/vUgZuOkOQWfx8vR5ETcEBfOqulTMqjEnZJCMpT0LhHd3g+EfFc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762197821; c=relaxed/simple;
	bh=YF+Dh7k5RXyD8ZknLWrr6zckBVz5y8Jk5LVnJjqJxoY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NoelRET7XDSnU1FeTYwyUgIlFlYaqbHkrVkKalrVg4AXz8X4HYOwkYgoahQfC6sg9CC0qi0O5Yn7EccmD6Wh7hOwGujkYavYryjh4FVRxG+jtYM7gpUf4OmEFYttAVRIKn+aAHDJRKmRmvwNBveXi9xyZCqkFaWnJ+uf55YK/5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9UT0S1a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9UT0S1a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BEBEC4CEE7;
	Mon,  3 Nov 2025 19:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762197821;
	bh=YF+Dh7k5RXyD8ZknLWrr6zckBVz5y8Jk5LVnJjqJxoY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=c9UT0S1aE+oyoVDfFS4tVvZUGvWl9HiC7/F+Cp66KCVA7C4GhH0PqNtoBTarCw3iW
	 r2P630kamF4JSjUnf0EzY4gdgF4lREKNM2+yjmeoTw3nLHhjxYDny/gqAjP3iNUL7a
	 JzIyQ1aRH3QyNtDz4IpxtL5MX/fDHZSJh77cPeKd7LS92GluG1GXIy1BpAiLFwvlox
	 cRJrDCtLOcgMqEzgJxz44Oa9sLKyl40ixdJjaMo6LOW9qbHf4ryeTRFym1qVmpu9UH
	 uIilWOADkYHyRHPzn2EvdQ0ZptspxmBomG3l6lNVoh9BMoIycP2QxAs9MQX9p7Fs9q
	 9DzIobQXg5JOg==
Message-ID: <a326d1eb-62f1-4add-8dc9-cea7d7e4ed3c@kernel.org>
Date: Mon, 3 Nov 2025 20:23:30 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/12] x86/xen: use lazy_mmu_state when
 context-switching
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
 Peter Zijlstra <peterz@infradead.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner
 <tglx@linutronix.de>, Vlastimil Babka <vbabka@suse.cz>,
 Will Deacon <will@kernel.org>, Yeoreum Yun <yeoreum.yun@arm.com>,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org
References: <20251029100909.3381140-1-kevin.brodsky@arm.com>
 <20251029100909.3381140-12-kevin.brodsky@arm.com>
 <c7c8a233-2103-4b48-b65e-ec81666d20e4@kernel.org>
 <285faae4-dab6-4819-847a-889bdf87d5d7@arm.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <285faae4-dab6-4819-847a-889bdf87d5d7@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 03.11.25 19:29, Kevin Brodsky wrote:
> On 03/11/2025 16:15, David Hildenbrand (Red Hat) wrote:
>> On 29.10.25 11:09, Kevin Brodsky wrote:
>>> [...]
>>>
>>> @@ -437,7 +436,7 @@ static void xen_end_context_switch(struct
>>> task_struct *next)
>>>          xen_mc_flush();
>>>        leave_lazy(XEN_LAZY_CPU);
>>> -    if (test_and_clear_ti_thread_flag(task_thread_info(next),
>>> TIF_LAZY_MMU_UPDATES))
>>> +    if (next->lazy_mmu_state.active)
>>
>> This is nasty. If in_lazy_mmu_mode() is not sufficient, we will want
>> to have a separate helper that makes it clear what the difference
>> between both variants is.
> 
> in_lazy_mmu_mode() operates on current, but here we're operating on a
> different task. The difference is more fundamental than just passing a
> task_struct * or not: in_lazy_mmu_mode() is about whether we're
> currently in lazy MMU mode, i.e. not paused and not in interrupt
> context. A task that isn't scheduled is never in lazy MMU mode -
> lazy_mmu_state.active is just the saved state to be restored when
> scheduled again.
> 
> My point here is that we could have a helper for this use-case, but it
> should not be used in other situations (at least not on current). Maybe
> __task_lazy_mmu_active(task)? I do wonder if accessing lazy_mmu_state
> directly isn't expressing the intention well enough though (checking the
> saved state).


Likely there should be a

/**
  * task_lazy_mmu_active - test whether the lazy-mmu mode is active for a
  *			  task
  * @task: ...
  *
  * The lazy-mmu mode is active if a task has lazy-mmu mode enabled and
  * currently not paused.
  */
static inline bool task_lazy_mmu_active(struct task_struct *task)
{
	return task->lazy_mmu_state.active;
}

/**
  * in_lazy_mmu_mode() - test whether current is in lazy-mmu mode
  *
  * Test whether the current task is in lazy-mmu mode: whether the
  * interrupts are enabled and the lazy-mmu mode is active for the
  * current task.
  */
  static inline bool in_lazy_mmu_mode(void)
  {
+	if (in_interrupt())
+		return false;
+
  	return task_lazy_mmu_active(current);
  }


Something like that. Maybe we can find better terminology.

-- 
Cheers

David

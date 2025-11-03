Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8953285CA4;
	Mon,  3 Nov 2025 18:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762193338; cv=none; b=MwcCzFCDhgXOIO6nlWArroFR0sHv65fnuIWn/TzkSIdcyKmTopiW6ApTgduo8TfRZ0KuXF67rRIvA3eOVBAXhBkTyaTxJmjYZhrlAUWLnSHjrZOyAHd9kJ/mH3ooEh6cuXycrYn5hXPRvLQjXE3wB1qZtPI5K5XuO7GikxeekJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762193338; c=relaxed/simple;
	bh=oMupISCSYd/eNzrdMLFaLu2UlclpMU6/awU7/8GJBY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hkvtxROnV9n1eKH4RjN7bMByxbka6c6Vnk0Ejs5pmgrF97/3PEWHxwamPJSr6DYgG2qx0zdV8CZMm7ZiwWfNdmBNACwXtc8mJOjgzn8CokZJrGeY+pPJyjBG4WuuCRYqyVae6d7rgiFDxDkRb9cdA6VwF99gSvLzCkPn/pCm+uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4DBAF2A6B;
	Mon,  3 Nov 2025 10:08:48 -0800 (PST)
Received: from [10.1.30.16] (unknown [10.1.30.16])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 463A43F694;
	Mon,  3 Nov 2025 10:08:48 -0800 (PST)
Message-ID: <1965fe85-3734-45e9-af89-651c65845e8a@arm.com>
Date: Mon, 3 Nov 2025 18:08:45 +0000
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/12] mm: enable lazy_mmu sections to nest
To: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
 Andreas Larsson <andreas@gaisler.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Borislav Petkov
 <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "David S. Miller" <davem@davemloft.net>,
 David Woodhouse <dwmw2@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
 Juergen Gross <jgross@suse.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
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
 <ae1236da-2647-4d53-bf4d-ff8fc32eb734@redhat.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <ae1236da-2647-4d53-bf4d-ff8fc32eb734@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 01/11/2025 12:22, David Hildenbrand wrote:
>
>>   static inline void lazy_mmu_mode_pause(void)
>>   {
>> +    struct lazy_mmu_state *state = &current->lazy_mmu_state;
>> +
>> +    VM_WARN_ON(state->nesting_level == 0 || !state->active);
>> +
>> +    state->active = false;
>>       arch_leave_lazy_mmu_mode();
>
> Just one question:
>
> Don't we want to allow for pause/resume when not enabled? Would seem
> valid to me, because pause/resume code should actually not worry about
> that, right?

This does sound sensible, thanks for the suggestion. The initial goal
was to allow functions that know they're called with lazy MMU enabled to
be able to pause it temporarily if they need batching disabled. But we
could generalise this to: if you know batching would break things, then
you can preemptively add a pause/resume pair, and it won't do anything
unless you're called with lazy MMU enabled.

I also like this as this removes an invalid usage situation - now as
long as you have balanced enable/disable and pause/resume calls, you're
good. Will make that change in v5.

- Kevin

>
> if (!state->nesting_level) {
>     VM_WARN_ON(state->active);
>     return;
> }
> VM_WARN_ON(!state->active);
> state->active = false;
> arch_leave_lazy_mmu_mode();
>

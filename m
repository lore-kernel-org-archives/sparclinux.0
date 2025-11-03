Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7329F248F4D;
	Mon,  3 Nov 2025 18:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762194552; cv=none; b=AIb9DcDt70q0kIgb+941hM7cLYqA22GcWKwzFdmxqa+/inKxhdsouEYuyIvhpvMxe/BApEOMTHUBT6e67X+FE1rQ8ijmHpDeS97mCvWEY5kqhbxoAIt+0+2OyuSjaCnXHkqmJZDBVa+6sn8uTovHpnbIbFrkwwrGwR07EIew9Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762194552; c=relaxed/simple;
	bh=PejloQnKGuK3bpH0pnM/kdDvHB2ShDka/sYljxbJywo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AdHucotwj6ylNmn4Pp4IJOI/Lk8iAKtKIw5Wq7z8zqMkeCZBh5tVm7cwHgTKWgCUX8bTmXOlAKovz3u6rs2oOAZ2cPN2n7j+0kJzDGlni6xSUELHOuXvKFiqDPvj+3J6cWSzS896qkq2iH7CIQxTuQVm4/6EeiFIZabBd7R9fcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD0752A6B;
	Mon,  3 Nov 2025 10:29:02 -0800 (PST)
Received: from [10.1.30.16] (unknown [10.1.30.16])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 191F33F694;
	Mon,  3 Nov 2025 10:29:02 -0800 (PST)
Message-ID: <285faae4-dab6-4819-847a-889bdf87d5d7@arm.com>
Date: Mon, 3 Nov 2025 18:29:00 +0000
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/12] x86/xen: use lazy_mmu_state when
 context-switching
To: "David Hildenbrand (Red Hat)" <david@kernel.org>, linux-mm@kvack.org
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
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <c7c8a233-2103-4b48-b65e-ec81666d20e4@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 03/11/2025 16:15, David Hildenbrand (Red Hat) wrote:
> On 29.10.25 11:09, Kevin Brodsky wrote:
>> [...]
>>
>> @@ -437,7 +436,7 @@ static void xen_end_context_switch(struct
>> task_struct *next)
>>         xen_mc_flush();
>>       leave_lazy(XEN_LAZY_CPU);
>> -    if (test_and_clear_ti_thread_flag(task_thread_info(next),
>> TIF_LAZY_MMU_UPDATES))
>> +    if (next->lazy_mmu_state.active)
>
> This is nasty. If in_lazy_mmu_mode() is not sufficient, we will want
> to have a separate helper that makes it clear what the difference
> between both variants is.

in_lazy_mmu_mode() operates on current, but here we're operating on a
different task. The difference is more fundamental than just passing a
task_struct * or not: in_lazy_mmu_mode() is about whether we're
currently in lazy MMU mode, i.e. not paused and not in interrupt
context. A task that isn't scheduled is never in lazy MMU mode -
lazy_mmu_state.active is just the saved state to be restored when
scheduled again.

My point here is that we could have a helper for this use-case, but it
should not be used in other situations (at least not on current). Maybe
__task_lazy_mmu_active(task)? I do wonder if accessing lazy_mmu_state
directly isn't expressing the intention well enough though (checking the
saved state).

- Kevin

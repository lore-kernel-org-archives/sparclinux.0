Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8DDEAF9;
	Mon, 15 Sep 2025 11:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757935182; cv=none; b=Y27gFch6St9Bi2HX3LLfPb2OUCQwIo682NS2zDo9FL2c2tTz1FZbneUMnJuvaxXZu6+j/Wh9SVnUVz5abT0xsg5ITB0BsmefGpAOS5Oc5ODy9VNmTYphpCkH1RTQhac7yU4TTs3wNKE5MxuHHqrAKTxXGk8ln/nL7+s1ppknbtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757935182; c=relaxed/simple;
	bh=ezmIh4yAIIyC5Ofx9OYfMJK6a3eTs8fzX06OGshPKFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KJqa2OGm8VoRw0nlJUYq8N0MV2cKjrXBWBlL2jZI8vVKUCkCxJvOKOq8dg0R7LctRUQWeKLPG/MZA9euQCeAIe5CbaCzMk/ysEsHPcRsdMKpm5DMCs/9haFZAtNixQd9tuz3rt4rVxlIto5iE5ENp85yFGk+HnSFsGB+RdUWSeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D6971424;
	Mon, 15 Sep 2025 04:19:31 -0700 (PDT)
Received: from [10.57.70.220] (unknown [10.57.70.220])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C7D73F694;
	Mon, 15 Sep 2025 04:19:34 -0700 (PDT)
Message-ID: <d407a381-099b-4ec6-a20e-aeff4f3d750f@arm.com>
Date: Mon, 15 Sep 2025 13:19:32 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] Nesting support for lazy MMU mode
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Andreas Larsson <andreas@gaisler.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Borislav Petkov
 <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "David S. Miller" <davem@davemloft.net>, "H. Peter Anvin" <hpa@zytor.com>,
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
 sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org,
 Mark Rutland <Mark.Rutland@arm.com>
References: <20250908073931.4159362-1-kevin.brodsky@arm.com>
 <20250908191602.61160a7990b9ea418de758c7@linux-foundation.org>
 <d1b4ff2a-052f-4556-91ae-273962edbed0@redhat.com>
 <338ef811-1dab-4c4e-bc5f-8ebd8cb68435@arm.com>
 <5a0818bb-75d4-47df-925c-0102f7d598f4-agordeev@linux.ibm.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <5a0818bb-75d4-47df-925c-0102f7d598f4-agordeev@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 15/09/2025 08:28, Alexander Gordeev wrote:
> On Fri, Sep 12, 2025 at 05:25:27PM +0200, Kevin Brodsky wrote:
>
> Hi Kevin,
>
>> Based on the outcome of the discussion with David on patch 2 [1p], there
>> is indeed an alternative approach that we should seriously consider. In
>> summary:
>>
>> * Keep the API stateless, handle nesting with a counter in task_struct
>> * Introduce new functions to temporarily disable lazy_mmu without
>> impacting nesting, track that with a bool in task_struct (addresses the
>> situation in mm/kasan/shadow.c and possibly some x86 cases too)
>> * Move as much handling from arch_* to generic functions
>>
>> What the new generic infrastructure would look like:
>>
>> struct task_struct {
>>     ...
>> #ifdef CONFIG_ARCH_LAZY_MMU
>>     struct {
>>         uint8_t count;
>>         bool enabled; /* or paused, see below */
>>     } lazy_mmu_state;
>> #endif
>> }
>>
>> * lazy_mmu_mode_enable():
> This helper is parameter-free, assuming the MMU unit does not need any
> configuration other than turning it on/off. That is currently true, but
> (as I noted in my other mail) I am going to introduce a friend enable
> function that accepts parameters, creates an arch-specific state and
> uses it while the lazy mmu mode is active.

Yes I think that's fine.

> That does not impact your design (AFAICT), except one change below.
>
>>     if (!lazy_mmu_state.count) {
>>         arch_enter_lazy_mmu_mode();
>>         lazy_mmu_state.enabled = true;
>>     }
>>     lazy_mmu_state.count++;
>>
>> * lazy_mmu_mode_disable():
>>     lazy_mmu_count--;
>>     if (!lazy_mmu_state.count) {
>>         lazy_mmu_state.enabled = false;
>>         arch_leave_lazy_mmu_mode();
>>     } else {
>>         arch_flush_lazy_mmu_mode();
>>     }
>>
>> * lazy_mmu_mode_pause():
>>     lazy_mmu_state.enabled = false;
>>     arch_leave_lazy_mmu_mode();
> This needs to be arch_pause_lazy_mmu_mode(), otherwise the arch-specific
> state will be lost.
>
>> * lazy_mmu_mode_resume();
>>     arch_enter_lazy_mmu_mode();
> Conversely, this needs to be arch_resume_lazy_mmu_mode(). And it can not
> be arch_enter_lazy_mmu_mode(), since a lazy_mmu_mode_resume() caller does
> not know the parameters passed to the lazy_mmu_mode_enable(...)-friend.

Got it, that makes sense. Even without your proposal, it is probably a
good idea to allow arch's to behave differently on pause/resume.

I hope we can avoid forcing all arch's to define arch_pause/arch_resume
though, since only s390 will use it for the foreseeable future. Using
optional macros should do the trick.

- Kevin

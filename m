Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596C016F265;
	Thu, 27 Nov 2025 12:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764247546; cv=none; b=HTn1z6Qu4FV3nGgsON+5eJQXhh42jQIJJm/SKD03tx8DYdR9yTy5FUr9fBAfvjSrUUyGbNbCV6zy7tEf6fiHgbaZFU2S+2+fWsuv+wN+ZetDqAi0sftINAh+YYY9ZrufsRXFpaqF0nlyKTCzDhn6mmadpTDaS/o9JZSbMbybroU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764247546; c=relaxed/simple;
	bh=IQB95FKHSP+yfJcY/LSofG30x3xycq0f2RJwpAVAZJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sBEKoiRfI1oLbiJPKr43OUBkb+ZGp1xWjuVINHOziKG0ZguYsO3zg3DfSaTJAuOu12YzE8P7t4UA+SjVW/L2pi1+ZyQth1oErhB/mMPhO8pAWOtKY+qFusdFn7DvJGTcQtvdyaVEtkwylHdqYfNIiF+fGnePSTsjwUGSU6pwTZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11C781477;
	Thu, 27 Nov 2025 04:45:36 -0800 (PST)
Received: from [10.57.43.59] (unknown [10.57.43.59])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC00D3F73B;
	Thu, 27 Nov 2025 04:45:35 -0800 (PST)
Message-ID: <0cb512ba-de15-4ba6-a85a-8287ab67fb53@arm.com>
Date: Thu, 27 Nov 2025 13:45:33 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/12] mm: enable lazy_mmu sections to nest
To: Alexander Gordeev <agordeev@linux.ibm.com>
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
 <20251124132228.622678-9-kevin.brodsky@arm.com>
 <4d0eab1a-e1dc-49cf-8640-727c9734233d-agordeev@linux.ibm.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <4d0eab1a-e1dc-49cf-8640-727c9734233d-agordeev@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/11/2025 13:33, Alexander Gordeev wrote:
> On Mon, Nov 24, 2025 at 01:22:24PM +0000, Kevin Brodsky wrote:
>
> Hi Kevin,
>
> ...
>> +/**
>> + * lazy_mmu_mode_pause() - Pause the lazy MMU mode.
>> + *
>> + * Pauses the lazy MMU mode; if it is currently active, disables it and calls
>> + * arch_leave_lazy_mmu_mode().
>> + *
>> + * Must be paired with a call to lazy_mmu_mode_resume(). Calls to the
>> + * lazy_mmu_mode_* API have no effect until the matching resume() call.
> Sorry if it was discussed already - if yes, I somehow missed it. If I read
> the whole thing correctly enter()/pause() interleaving is not forbidden?

Correct, any call inside pause()/resume() is now allowed (but
effectively ignored). See discussion with Ryan in v4 [1].

[1]
https://lore.kernel.org/all/824bf705-e9d6-4eeb-9532-9059fa56427f@arm.com/

> lazy_mmu_mode_enable()
> 	lazy_mmu_mode_pause()
> 		lazy_mmu_mode_enable()
> 		...
> 		lazy_mmu_mode_disable()
> 	lazy_mmu_mode_resume()
> lazy_mmu_mode_disable()
>
>> + *
>> + * Has no effect if called:
>> + * - While paused (inside another pause()/resume() pair)
>> + * - In interrupt context
>> + */
>>  static inline void lazy_mmu_mode_pause(void)
>>  {
>> +	struct lazy_mmu_state *state = &current->lazy_mmu_state;
>> +
>>  	if (in_interrupt())
>>  		return;
>>  
>> -	arch_leave_lazy_mmu_mode();
>> +	VM_WARN_ON_ONCE(state->pause_count == U8_MAX);
>> +
>> +	if (state->pause_count++ == 0 && state->enable_count > 0)
>> +		arch_leave_lazy_mmu_mode();
>>  }
>>  
>> +/**
>> + * lazy_mmu_mode_pause() - Resume the lazy MMU mode.
>                     resume() ?

Good catch! One copy-paste too many...

- Kevin

>> + *
>> + * Resumes the lazy MMU mode; if it was active at the point where the matching
>> + * call to lazy_mmu_mode_pause() was made, re-enables it and calls
>> + * arch_enter_lazy_mmu_mode().
>> + *
>> + * Must match a call to lazy_mmu_mode_pause().
>> + *
>> + * Has no effect if called:
>> + * - While paused (inside another pause()/resume() pair)
>> + * - In interrupt context
>> + */
>>  static inline void lazy_mmu_mode_resume(void)
>>  {
>> +	struct lazy_mmu_state *state = &current->lazy_mmu_state;
>> +
>>  	if (in_interrupt())
>>  		return;
>>  
>> -	arch_enter_lazy_mmu_mode();
>> +	VM_WARN_ON_ONCE(state->pause_count == 0);
>> +
>> +	if (--state->pause_count == 0 && state->enable_count > 0)
>> +		arch_enter_lazy_mmu_mode();
>>  }
> ...
> Thanks!

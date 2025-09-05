Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB2334F498;
	Fri,  5 Sep 2025 12:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757074315; cv=none; b=D0ToZP8AJFylC/NnEFh16VjdY88HG5DiuX0Mlzej+OC+n/4fUsEdeez1jZotNWbeWO32hVqDKDNacFDwcZjP1x4MUdZWd8LbJUuS1DWLuW+R6tyqCk/LggA9nrgV12LYSiXu4cO316kn7b3Kv4kT6rYLfh1wwwvGL3qeI6y2iQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757074315; c=relaxed/simple;
	bh=VvyIHkUv5RRxBs59x2FA9ZxJ1T5Ll9H13cK44Xc+SPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dHMcaetZma5D0touVYT+892F+gdCzpHgVnva8H8LCWYCbWkcgNHcakSvRgjmmoRSvk/IHvSpnZ/VLD+nnwKj0+EsSNPbQ+yu2YI7cnY9Z3IU1Jzv9jefv87qwk5SwYzEXqrv8BMRYl/QctbveKU1UHnnnriLatbnwUUrEAXbbeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0A1B153B;
	Fri,  5 Sep 2025 05:11:42 -0700 (PDT)
Received: from [10.57.60.42] (unknown [10.57.60.42])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 65F093F63F;
	Fri,  5 Sep 2025 05:11:45 -0700 (PDT)
Message-ID: <66335cf3-d49d-4b27-a37b-0a8a5e2c5d78@arm.com>
Date: Fri, 5 Sep 2025 14:11:43 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] Nesting support for lazy MMU mode
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
 <9fd076c7-f163-4b92-8201-d8a259a338c1-agordeev@linux.ibm.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <9fd076c7-f163-4b92-8201-d8a259a338c1-agordeev@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/09/2025 11:46, Alexander Gordeev wrote:
> On Thu, Sep 04, 2025 at 01:57:29PM +0100, Kevin Brodsky wrote:
>
> Hi Kevin,
>
>> When the lazy MMU mode was introduced eons ago, it wasn't made clear
>> whether such a sequence was legal:
>>
>> 	arch_enter_lazy_mmu_mode()
>> 	...
>> 		arch_enter_lazy_mmu_mode()
>> 		...
>> 		arch_leave_lazy_mmu_mode()
>> 	...
>> 	arch_leave_lazy_mmu_mode()
> I did not take too deep - sorry if you already answered this.
> Quick question - whether a concern Ryan expressed is addressed
> in general case?

The short answer is yes - it's good that you're asking because I failed
to clarify this in the cover letter!

> https://lore.kernel.org/all/3cad01ea-b704-4156-807e-7a83643917a8@arm.com/
>
> 	enter_lazy_mmu
> 		for_each_pte {
> 			read/modify-write pte
>
> 			alloc_page
> 				enter_lazy_mmu
> 					make page valid
> 				exit_lazy_mmu
>
> 			write_to_page
> 		}
> 	exit_lazy_mmu
>
> <quote>
> This example only works because lazy_mmu doesn't support nesting. The "make page
> valid" operation is completed by the time of the inner exit_lazy_mmu so that the
> page can be accessed in write_to_page. If nesting was supported, the inner
> exit_lazy_mmu would become a nop and write_to_page would explode.
> </quote>

Further down in the cover letter I refer to the approach Catalin
suggested [4]. This was in fact in response to this concern from Ryan.
The key point is: leave() keeps the lazy MMU mode enabled if it is
nested, but it flushes any batched state *unconditionally*, regardless
of nesting level. See patch 3-6 on the practical implementation of this;
patch 7 also spells it out in the documentation.

Hope that clarifies the situation!

- Kevin

[4] https://lore.kernel.org/all/aEhKSq0zVaUJkomX@arm.com/

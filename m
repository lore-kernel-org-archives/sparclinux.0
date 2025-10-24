Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF783126CC;
	Fri, 24 Oct 2025 12:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761308236; cv=none; b=q/6nN+UrbqaAzOUiI15lw1NJZ3ZC63JJJiLFUtKU1pGrJ8zd0qCLavwAnMG8IF+4vbV++HGZyuEeBbqnV9dyfuAyWjQ9Xz5ditBKtrwlFk3Q9F8OETs193okktk9afiY4/VvjD69UISfFdFKyL9KukdvKT5+cJC1PSvyuvm7AB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761308236; c=relaxed/simple;
	bh=YioWD/IqA/1JOGO8+Y7wTQHhF26d2UKTg8w6nlGrrCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JfVawh4Ussvguu/eQLfTRsqEbFT/fu0Heqb07erQvMlj+72yFKz+PRKziFM7slYVXJvEIGwunK2OgSRn/MCfvnR33O//oJYqoNjy3wtONrUHcgdcsIHIfLDdR3PL+q99x80Nobd1pq32buFdtq3VqdsYFuRj8svP8dth5UcD+C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F3401E2F;
	Fri, 24 Oct 2025 05:17:05 -0700 (PDT)
Received: from [10.44.160.74] (e126510-lin.lund.arm.com [10.44.160.74])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 881823F66E;
	Fri, 24 Oct 2025 05:17:04 -0700 (PDT)
Message-ID: <ed949468-5425-4f82-826b-249c43a0df05@arm.com>
Date: Fri, 24 Oct 2025 14:17:04 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/13] mm: bail out of lazy_mmu_mode_* in interrupt
 context
To: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
 Andreas Larsson <andreas@gaisler.com>,
 Andrew Morton <akpm@linux-foundation.org>,
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
 sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org
References: <20251015082727.2395128-1-kevin.brodsky@arm.com>
 <20251015082727.2395128-13-kevin.brodsky@arm.com>
 <28f2ebe9-cfed-41c3-803f-8756dca0e300@redhat.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <28f2ebe9-cfed-41c3-803f-8756dca0e300@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 23/10/2025 22:08, David Hildenbrand wrote:
> On 15.10.25 10:27, Kevin Brodsky wrote:
>> The lazy MMU mode cannot be used in interrupt context. This is
>> documented in <linux/pgtable.h>, but isn't consistently handled
>> across architectures.
>>
>> arm64 ensures that calls to lazy_mmu_mode_* have no effect in
>> interrupt context, because such calls do occur in certain
>> configurations - see commit b81c688426a9 ("arm64/mm: Disable barrier
>> batching in interrupt contexts"). Other architectures do not check
>> this situation, most likely because it hasn't occurred so far.
>>
>> Both arm64 and x86/Xen also ensure that any lazy MMU optimisation is
>> disabled while in interrupt mode (see queue_pte_barriers() and
>> xen_get_lazy_mode() respectively).
>>
>> Let's handle this in the new generic lazy_mmu layer, in the same
>> fashion as arm64: bail out of lazy_mmu_mode_* if in_interrupt(), and
>> have in_lazy_mmu_mode() return false to disable any optimisation.
>> Also remove the arm64 handling that is now redundant; x86/Xen has
>> its own internal tracking so it is left unchanged.
>>
>> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
>> ---
>>   arch/arm64/include/asm/pgtable.h | 17 +----------------
>>   include/linux/pgtable.h          | 16 ++++++++++++++--
>>   include/linux/sched.h            |  3 +++
>>   3 files changed, 18 insertions(+), 18 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/pgtable.h
>> b/arch/arm64/include/asm/pgtable.h
>> index 944e512767db..a37f417c30be 100644
>> --- a/arch/arm64/include/asm/pgtable.h
>> +++ b/arch/arm64/include/asm/pgtable.h
>> @@ -62,37 +62,22 @@ static inline void emit_pte_barriers(void)
>>     static inline void queue_pte_barriers(void)
>>   {
>> -    if (in_interrupt()) {
>> -        emit_pte_barriers();
>> -        return;
>> -    }
>> -
>
> That took me a while. I guess this works because in_lazy_mmu_mode() ==
> 0 in interrupt context, so we keep calling emit_pte_barriers?

Yes exactly.

- Kevin

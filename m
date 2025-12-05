Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926B2313E07;
	Fri,  5 Dec 2025 12:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764939390; cv=none; b=kcCBpOY+py09YSSYSrnohAOPv6Gq0UYsz2kqxefwAXtulLt46QhQ7JUsylVKsEwDPjs69gTauiYhCQ3/MkrYX6Exg3uG4GtMSQdxxL8G5WDEijg3s4BonEydVRRVKxVrKrOMLAznDXxMBS/dmtHUx5yMCMQbom1/6a6QDDu0KqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764939390; c=relaxed/simple;
	bh=ajbQPSPbEpBcJTEjVuxdTkQqdnfH2neqkULLXUHjAC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r+OLBlM10wuxeczzlEsCUIyrkNBKaVmR/1Zsnq2fHjdBDce5rVRX0S+UHYpE7qX6slomF/p55ATDBmwLKPag8lbA7pthOgiYkYTn39yUuFr+Yjwrfh35dShlGCVhP4BZUcSUL9HSSTlr2EWFGSl/nJGQZzbP02Bv5FZcjvz29U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D48521575;
	Fri,  5 Dec 2025 04:56:14 -0800 (PST)
Received: from [10.44.160.68] (e126510-lin.lund.arm.com [10.44.160.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 903273F59E;
	Fri,  5 Dec 2025 04:56:14 -0800 (PST)
Message-ID: <89e76670-4a7b-46b6-ba55-d225dbb68cbd@arm.com>
Date: Fri, 5 Dec 2025 13:56:11 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/12] mm: enable lazy_mmu sections to nest
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
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
 <2dfd54d7-fe2a-4921-85ff-a581392a777a@arm.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <2dfd54d7-fe2a-4921-85ff-a581392a777a@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/12/2025 07:23, Anshuman Khandual wrote:
>> [...]
>>
>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>> index 8ff6fdb4b13d..24fdb6f5c2e1 100644
>> --- a/include/linux/pgtable.h
>> +++ b/include/linux/pgtable.h
>> @@ -230,39 +230,140 @@ static inline int pmd_dirty(pmd_t pmd)
>>   * (In practice, for user PTE updates, the appropriate page table lock(s) are
>>   * held, but for kernel PTE updates, no lock is held). The mode is disabled in
>>   * interrupt context and calls to the lazy_mmu API have no effect.
>> - * Nesting is not permitted.
>> + *
>> + * The lazy MMU mode is enabled for a given block of code using:
>> + *
>> + *   lazy_mmu_mode_enable();
>> + *   <code>
>> + *   lazy_mmu_mode_disable();
>> + *
>> + * Nesting is permitted: <code> may itself use an enable()/disable() pair.
>> + * A nested call to enable() has no functional effect; however disable() causes
>> + * any batched architectural state to be flushed regardless of nesting. After a
> Just wondering if there is a method for these generic helpers to ensure that platform
> really does the required flushing on _disable() or the expected platform semantics is
> only described via this comment alone ?

From the generic layer's perspective, flushing means calling
arch_flush_lazy_mmu_mode(). Like the other arch_*_lazy_mmu_mode helpers,
the actual semantics is unspecified - an arch could choose not to do
anything on flush if that's not required for page table changes to be
visible. There is actually an example of this in the kpkeys page table
hardening series [1] (this isn't doing any batching so there is nothing
to flush either).

[1]
https://lore.kernel.org/linux-hardening/20250815085512.2182322-19-kevin.brodsky@arm.com/

>> + * call to disable(), the caller can therefore rely on all previous page table
>> + * modifications to have taken effect, but the lazy MMU mode may still be
>> + * enabled.
>> + *
>> + * In certain cases, it may be desirable to temporarily pause the lazy MMU mode.
>> + * This can be done using:
>> + *
>> + *   lazy_mmu_mode_pause();
>> + *   <code>
>> + *   lazy_mmu_mode_resume();
>> + *
>> + * pause() ensures that the mode is exited regardless of the nesting level;
>> + * resume() re-enters the mode at the same nesting level. Any call to the
>> + * lazy_mmu_mode_* API between those two calls has no effect. In particular,
>> + * this means that pause()/resume() pairs may nest.
>> + *
>> + * in_lazy_mmu_mode() can be used to check whether the lazy MMU mode is
>> + * currently enabled.
> Just wondering - could a corresponding test be included probably via KUNIT_TEST
> to ensure the above described semantics are being followed.

Checking that is_lazy_mmu_mode_active() returns the right value at
different call depths should be doable, yes. I suppose that could live
in some file under mm/tests/ (doesn't exist yet but that's the preferred
approach for KUnit tests).

- Kevin

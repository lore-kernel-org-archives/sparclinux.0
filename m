Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E0722A4D8;
	Mon, 20 Oct 2025 10:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760956672; cv=none; b=r16S94ihATuu/6E147GTZ+b4sge3pbLefGfJyvTdncM1uksTUU/nnd52acaHFsA7izBg1blS8vBPNRt/uF/+R25zXbhVSMBhl6xQ2PRtquFZkxgcu1b2KcVYWqaE/n97mP192V5Gdh9iGg90zSHYPQFPvdXPawkseC8twUB6pIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760956672; c=relaxed/simple;
	bh=paWt8mUs1WHd7QLJQI0i4s8rgFnun7wqgJxl3u+yWSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I5qsc/V5DH1eujd0N+Ekfg41GegxdRkoTYYhimltlYNbjd3BvoqIa5C07gmCfhwz9Eny6Qwuy5o6hgg5rYj3TdKCCa0qP365vQ98b9y6E9w74Djz4JqjIgeXfIZjgz9EgHhSPmzi8W5XaSVAoV1DFTSrAy7fpvyVYYqNFJAMV+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6116D1063;
	Mon, 20 Oct 2025 03:37:42 -0700 (PDT)
Received: from [10.57.65.147] (unknown [10.57.65.147])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB2C53F63F;
	Mon, 20 Oct 2025 03:37:41 -0700 (PDT)
Message-ID: <3836a43f-809e-419d-a85d-74606d9daa0f@arm.com>
Date: Mon, 20 Oct 2025 12:37:38 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/13] mm: introduce CONFIG_ARCH_LAZY_MMU
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Alexander Gordeev <agordeev@linux.ibm.com>,
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
 Nicholas Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Ryan Roberts <ryan.roberts@arm.com>, Suren Baghdasaryan <surenb@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, Vlastimil Babka <vbabka@suse.cz>,
 Will Deacon <will@kernel.org>, Yeoreum Yun <yeoreum.yun@arm.com>,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org
References: <20251015082727.2395128-1-kevin.brodsky@arm.com>
 <20251015082727.2395128-6-kevin.brodsky@arm.com>
 <aPNjd2dg3YN-TZKH@kernel.org>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <aPNjd2dg3YN-TZKH@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/10/2025 11:52, Mike Rapoport wrote:
>> @@ -231,7 +231,7 @@ static inline int pmd_dirty(pmd_t pmd)
>>   * held, but for kernel PTE updates, no lock is held). Nesting is not permitted
>>   * and the mode cannot be used in interrupt context.
>>   */
>> -#ifndef __HAVE_ARCH_ENTER_LAZY_MMU_MODE
>> +#ifndef CONFIG_ARCH_LAZY_MMU
>>  static inline void arch_enter_lazy_mmu_mode(void) {}
>>  static inline void arch_leave_lazy_mmu_mode(void) {}
>>  static inline void arch_flush_lazy_mmu_mode(void) {}
>> diff --git a/mm/Kconfig b/mm/Kconfig
>> index 0e26f4fc8717..2fdcb42ca1a1 100644
>> --- a/mm/Kconfig
>> +++ b/mm/Kconfig
>> @@ -1372,6 +1372,9 @@ config PT_RECLAIM
>>  config FIND_NORMAL_PAGE
>>  	def_bool n
>>  
>> +config ARCH_LAZY_MMU
>> +	bool
>> +
> I think a better name would be ARCH_HAS_LAZY_MMU and the config option fits
> better to arch/Kconfig.

Sounds fine by me - I'm inclined to make it slightly longer still,
ARCH_HAS_LAZY_MMU_MODE, to avoid making "LAZY_MMU" sound like some HW
feature.

- Kevin

Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747B81DB127;
	Fri, 24 Oct 2025 12:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761307775; cv=none; b=XtC+fxThucPTehky7dP0zh62UKaZsHR79g4SuPropnZIEjZyHDvftwGVW6n4h9CvzdC+PPz5A4a6HeaSNH74IShRR+jeeREodUCMuvc2Innpv4/VOH1rkw8k4P7VfaEFGeUJJGOBIk94kHzOWSYnmCi5r6cZIZMqM4qXP7t5Co4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761307775; c=relaxed/simple;
	bh=vx0WzEGRG5T7hv6IU1TBe8wwTw3a6x50Kf2p0I05e9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H75fFk83pZ2mFjXgbmQUPwUFznt4F6c1II32wFSLvrb2QFwv3fli4RH0EsgSKngM/sGbph8rEIl4yATyxF42wq4/Ec/9mBk4js18FDWoxcvdPCFCs9OiCunnk2xvy/lgisJ9JeWUpEPFFIVos77tF3ziz6SAc1q8DNl89xMGw1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C614106F;
	Fri, 24 Oct 2025 05:09:24 -0700 (PDT)
Received: from [10.44.160.74] (e126510-lin.lund.arm.com [10.44.160.74])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1BA303F66E;
	Fri, 24 Oct 2025 05:09:24 -0700 (PDT)
Message-ID: <604f26cb-46c6-4533-8110-0b174eed821d@arm.com>
Date: Fri, 24 Oct 2025 14:09:21 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/13] powerpc/mm: implement arch_flush_lazy_mmu_mode()
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
 <20251015082727.2395128-4-kevin.brodsky@arm.com>
 <60c55686-87dd-46d0-884e-80f7d423663b@redhat.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <60c55686-87dd-46d0-884e-80f7d423663b@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 23/10/2025 21:36, David Hildenbrand wrote:
> On 15.10.25 10:27, Kevin Brodsky wrote:
>> [...]
>>
>> diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
>> b/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
>> index 146287d9580f..7704dbe8e88d 100644
>> --- a/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
>> +++ b/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
>> @@ -41,6 +41,16 @@ static inline void arch_enter_lazy_mmu_mode(void)
>>       batch->active = 1;
>>   }
>>   +static inline void arch_flush_lazy_mmu_mode(void)
>> +{
>> +    struct ppc64_tlb_batch *batch;
>> +
>> +    batch = this_cpu_ptr(&ppc64_tlb_batch);
>
> The downside is the double this_cpu_ptr() now on the
> arch_leave_lazy_mmu_mode() path.

This is only temporary, patch 9 removes it from arch_enter(). I don't
think having a redundant this_cpu_ptr() for a few commits is really a
concern?

Same idea for patch 4/10.

- Kevin

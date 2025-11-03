Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1297517AE11;
	Mon,  3 Nov 2025 18:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762194354; cv=none; b=d6eTRDbrjTBOxwymH2uOuby930g/lQr8SnHrCmZjnqHdRTFG1lVeIXNLogIkeatnm8Y4Vj/lV4sRWHMp4+guk1K7qXuNADaoSqokr3I9FTAa8LkiIUXgFlkf3Pf6JrB4aRN4uEAf7DKaDLYG85zrj+Ig0QWf91+4QPb7udRdac4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762194354; c=relaxed/simple;
	bh=6Xh/82epPYCxQQw2FW1rqZLFSQMgbCtmljXqcyGvdlI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=agVIHWd9HHdxQDQ1yi3Nd3Z/5WHf4uHY1CHyq1BQ2zRJICk2Va/rx6qIvxPWNLj13XJbX6yhQcm9XpSFJdKZekQIyruwWLPx1rj5hqZWWFkDszHHNZ462dYI5F2+lk4jdOvTRI3ZT0i+Hjgo4t37S+DDzgpBgWA94T7Pv/INryY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7EF862A6B;
	Mon,  3 Nov 2025 10:25:43 -0800 (PST)
Received: from [10.1.30.16] (unknown [10.1.30.16])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E06143F694;
	Mon,  3 Nov 2025 10:25:43 -0800 (PST)
Message-ID: <334d6272-a1c2-4075-a956-3f41908371a6@arm.com>
Date: Mon, 3 Nov 2025 18:25:41 +0000
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/12] arm64: mm: replace TIF_LAZY_MMU with
 in_lazy_mmu_mode()
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
 <20251029100909.3381140-9-kevin.brodsky@arm.com>
 <b6f5b3cc-93a0-408a-b7e0-72462f3fd549@redhat.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <b6f5b3cc-93a0-408a-b7e0-72462f3fd549@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 03/11/2025 16:03, David Hildenbrand wrote:
> On 29.10.25 11:09, Kevin Brodsky wrote:
>> The generic lazy_mmu layer now tracks whether a task is in lazy MMU
>> mode. As a result we no longer need a TIF flag for that purpose -
>> let's use the new in_lazy_mmu_mode() helper instead.
>>
>> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
>> ---
>>   arch/arm64/include/asm/pgtable.h     | 16 +++-------------
>>   arch/arm64/include/asm/thread_info.h |  3 +--
>>   2 files changed, 4 insertions(+), 15 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/pgtable.h
>> b/arch/arm64/include/asm/pgtable.h
>> index 535435248923..61ca88f94551 100644
>> --- a/arch/arm64/include/asm/pgtable.h
>> +++ b/arch/arm64/include/asm/pgtable.h
>> @@ -62,30 +62,21 @@ static inline void emit_pte_barriers(void)
>>     static inline void queue_pte_barriers(void)
>>   {
>> -    unsigned long flags;
>> -
>>       if (in_interrupt()) {
>>           emit_pte_barriers();
>>           return;
>>       }
>>   -    flags = read_thread_flags();
>> -
>> -    if (flags & BIT(TIF_LAZY_MMU)) {
>> -        /* Avoid the atomic op if already set. */
>> -        if (!(flags & BIT(TIF_LAZY_MMU_PENDING)))
>> -            set_thread_flag(TIF_LAZY_MMU_PENDING);
>> -    } else {
>> +    if (in_lazy_mmu_mode())
>> +        test_and_set_thread_flag(TIF_LAZY_MMU_PENDING);
>
> You likely don't want a test_and_set here, which would do a
> test_and_set_bit() -- an atomic rmw.

Ah yes good point, the new version would do an atomic RMW in all cases.
Simpler code but also slower :/

>
> You only want to avoid the atomic write if already set.
>
> So keep the current
>
>     /* Avoid the atomic op if already set. */
>     if (!(flags & BIT(TIF_LAZY_MMU_PENDING)))
>         set_thread_flag(TIF_LAZY_MMU_PENDING); 

Pretty much, since we're now only considering one flag we can simplify
it to:

if (!test_thread_flag(TIF_LAZY_MMU_PENDING))
    set_thread_flag(TIF_LAZY_MMU_PENDING);

- Kevin

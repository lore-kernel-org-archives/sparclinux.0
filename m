Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF1D2D3A70;
	Thu,  4 Dec 2025 11:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764848363; cv=none; b=vDhaTh+fFNqV6sT7lvdYLiz/CCes5CUMbMZBgSghKvP+y9DKVHb11kACzpXIpC7LCSBloKyJ+hYxGXtLMlC3StVvKzh467w47fpRLIKmfMvHbWSsx2eGGlesmBYIKVGO0QzvKn9XB7PainQ9c8Jw6w0v/UDBgzytqS83lYDAtYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764848363; c=relaxed/simple;
	bh=oGOR/Gy9sovZXJOpLcgTuOfyjEMxsxmxhHmHgTDnlvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UlZ7tRTGSnBLsu8OqQcOkc1C3oDcD7qsn64WOdNqeOiq6nIiv5n37hg4puBdy+GV2PIxcRz+kOXYSlaSELgu1XfJ5/PEmA/xNftxPFB4jNkdA7s9HLO9HHCkRrCfqnqPD9RCoTFmkX9bNl5s/AfnkXKWOyx7Ov1kOA0drfPjTOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PE+WiSnZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PE+WiSnZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D03C3C4CEFB;
	Thu,  4 Dec 2025 11:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764848362;
	bh=oGOR/Gy9sovZXJOpLcgTuOfyjEMxsxmxhHmHgTDnlvg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PE+WiSnZpBNNRcaVS0QWTpayXH+dWoN5nt+357dXYUJWSjuOlaAsOBoe3SqzwB59R
	 0BhfuC55fmyIKS+5sWgvrif65X9dIQNyx1j8zScdnb4JsSuXTbZHZKOdhJztBH13oI
	 Z2xVQUclq5bzMcDG9oXYqty7pxfA/Wou/aR2Tjfhg2wQpAVF58f5Wxsu7+lh42EsgU
	 tzePMKUtQaqGs3/m7uKwUZJa+NFZNeb3W7vSvEYI4cegv0lxJrfu/RurxuRx1OGmTe
	 IzJrQ0kiAZGVJ74Dcu7D6yrF3jlh37vFw4mnVpHVXtFq7j5uuCInmCGOIVhoeMwI7Z
	 muM8WetLK5bJw==
Message-ID: <b341e7fa-4382-48b5-896a-1a0d347b66ca@kernel.org>
Date: Thu, 4 Dec 2025 12:39:10 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/12] arm64: mm: replace TIF_LAZY_MMU with
 in_lazy_mmu_mode()
To: Anshuman Khandual <anshuman.khandual@arm.com>,
 Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org
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
 <20251124132228.622678-10-kevin.brodsky@arm.com>
 <89ecddb7-83ee-427b-823b-984204939ecf@arm.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <89ecddb7-83ee-427b-823b-984204939ecf@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/4/25 07:52, Anshuman Khandual wrote:
> On 24/11/25 6:52 PM, Kevin Brodsky wrote:
>> The generic lazy_mmu layer now tracks whether a task is in lazy MMU
>> mode. As a result we no longer need a TIF flag for that purpose -
>> let's use the new in_lazy_mmu_mode() helper instead.
>>
>> The explicit check for in_interrupt() is no longer necessary either
>> as in_lazy_mmu_mode() always returns false in interrupt context.
>>
>> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
>> ---
>>   arch/arm64/include/asm/pgtable.h     | 19 +++----------------
>>   arch/arm64/include/asm/thread_info.h |  3 +--
>>   2 files changed, 4 insertions(+), 18 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>> index a7d99dee3dc4..dd7ed653a20d 100644
>> --- a/arch/arm64/include/asm/pgtable.h
>> +++ b/arch/arm64/include/asm/pgtable.h
>> @@ -62,28 +62,16 @@ static inline void emit_pte_barriers(void)
>>   
>>   static inline void queue_pte_barriers(void)
>>   {
>> -	unsigned long flags;
>> -
>> -	if (in_interrupt()) {
>> -		emit_pte_barriers();
>> -		return;
>> -	}
>> -
>> -	flags = read_thread_flags();
>> -
>> -	if (flags & BIT(TIF_LAZY_MMU)) {
>> +	if (in_lazy_mmu_mode()) {
>>   		/* Avoid the atomic op if already set. */
>> -		if (!(flags & BIT(TIF_LAZY_MMU_PENDING)))
>> +		if (!test_thread_flag(TIF_LAZY_MMU_PENDING))
> 
> A small nit - will it be better not to use test_thread_flag() here and just
> keep checking flags like earlier to avoid non-related changes. Although not
> a problem TBH.

I'd assume the existing code wanted to avoid fetching the flags two 
times? So switching to test_thread_flag() should be fine now.

-- 
Cheers

David

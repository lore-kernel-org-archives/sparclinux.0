Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324E93054C4;
	Mon, 10 Nov 2025 10:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762771073; cv=none; b=FpeWxy8Zeq+sYFNK9PZjdIKM1UK6G1SR+37vA0ek9aTcd0YaebyjESpw+HGWJZDQw5xTA2KWw8EtWGHu8VIU7L2YP/Jze0iu4aqerYQDDuzz46ttPUbyxHKEExGG9BJqPtBzBISU369oaV56gyn84WuKh5/Vlx2gZJBXX+M43TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762771073; c=relaxed/simple;
	bh=eoFD0YFTsJTKbLlfwzGMf+Jg0P/3aPzXI9tcKHy77Yc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iOO+XAThnNsWHWqcldKG5nrhTRqUtNP+crJgpMgcNRmQS0EThiD+ogUlu/dFjifIOsfw+Atk32itRhuDr+f9kPjgXcDgXpXsckJR3K9ARWOBqpgRNuoKz967GWQUh37xSbAN2z9p/egilDcPtTYgnRVxqugAQhyTpsKbPDg2HRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B4A3CFEC;
	Mon, 10 Nov 2025 02:37:43 -0800 (PST)
Received: from [10.57.39.147] (unknown [10.57.39.147])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0EB953F66E;
	Mon, 10 Nov 2025 02:37:43 -0800 (PST)
Message-ID: <0d00dd6e-9e39-4ac6-8ea4-9407e75947eb@arm.com>
Date: Mon, 10 Nov 2025 11:37:41 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/12] mm: introduce CONFIG_ARCH_HAS_LAZY_MMU_MODE
To: Ryan Roberts <ryan.roberts@arm.com>, linux-mm@kvack.org
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
 Peter Zijlstra <peterz@infradead.org>, Suren Baghdasaryan
 <surenb@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>,
 Yeoreum Yun <yeoreum.yun@arm.com>, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
 xen-devel@lists.xenproject.org, x86@kernel.org
References: <20251029100909.3381140-1-kevin.brodsky@arm.com>
 <20251029100909.3381140-6-kevin.brodsky@arm.com>
 <6a9c846f-22b6-4d5f-81dc-6cdcd4905952@arm.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <6a9c846f-22b6-4d5f-81dc-6cdcd4905952@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/11/2025 13:56, Ryan Roberts wrote:
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 6663ffd23f25..e6bf5c7311b5 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -122,6 +122,7 @@ config ARM64
>>  	select ARCH_WANTS_NO_INSTR
>>  	select ARCH_WANTS_THP_SWAP if ARM64_4K_PAGES
>>  	select ARCH_HAS_UBSAN
>> +	select ARCH_HAS_LAZY_MMU_MODE
> nit: This list is mostly in alphabetical order. Further up the list there are a
> lot of ARCH_HAS_* entries. Perhaps move it to the correct position in that lot?
> Then ARCH_HAS_UBSAN stays out of order on its own.

That's fair, it does look like it's mostly in order apart from
ARCH_HAS_UBSAN. Will move it further up.

- Kevin

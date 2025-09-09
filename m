Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB68275854;
	Tue,  9 Sep 2025 09:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757409055; cv=none; b=t5h2TugzjishSE8NqYk9hWn+ym7gQ0e0MFZLCQkeoZh2k36d4M2Kw0H2dOI1+S3EzogV/sLIL9gr42ctxu0nTJolw23/TGFE21ff8IW5mndIYKIKipTGN6ufPCr/+Qmqmac/3vyoPQjoqw9LRaYO7tzFIQzyZT6AlkpJDOZsr6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757409055; c=relaxed/simple;
	bh=hx6F/O2pbkD2iJuvkw1ZAwJxbvLKRvEnkIoGGCOGwCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eN3Y5GQ2fXMt4N0dZIe0b0EVEjGJmIpm7Yx3DT0sCsUtIKiq+pmI0AHXMqD7OwhR1SMMIl+Q6xLSUOE+BU99iVbnz7/8UGe6A1l+TpEphKIxUVxp5ypuSTbsiEho6E+pa8+EwSriATWN9CaDik/ORV/lOH40PovahVYZLCF3jfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A03615A1;
	Tue,  9 Sep 2025 02:10:44 -0700 (PDT)
Received: from [10.57.60.124] (unknown [10.57.60.124])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 358583F63F;
	Tue,  9 Sep 2025 02:10:37 -0700 (PDT)
Message-ID: <652720ae-131e-4de0-bc65-e5c1bdc46186@arm.com>
Date: Tue, 9 Sep 2025 11:10:34 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] Nesting support for lazy MMU mode
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
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
 <Liam.Howlett@oracle.com>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>,
 Mike Rapoport <rppt@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner
 <tglx@linutronix.de>, Vlastimil Babka <vbabka@suse.cz>,
 Will Deacon <will@kernel.org>, Yeoreum Yun <yeoreum.yun@arm.com>,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org
References: <20250908073931.4159362-1-kevin.brodsky@arm.com>
 <c07b8a65-7cef-4ddd-bd94-d2e275edc2a8@lucifer.local>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <c07b8a65-7cef-4ddd-bd94-d2e275edc2a8@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/09/2025 18:56, Lorenzo Stoakes wrote:
> On Mon, Sep 08, 2025 at 08:39:24AM +0100, Kevin Brodsky wrote:
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
>>
>> It seems fair to say that nested calls to
>> arch_{enter,leave}_lazy_mmu_mode() were not expected, and most
>> architectures never explicitly supported it.
>
> This is compiling with CONFIG_USERFAULTFD at all commits and series is
> compiling with allmodconfig plus all mm selftests are passing so from my
> side this looks good, thanks for addressing issues and rebasing! :)

Great thank you for that extensive testing, very appreciated! Shall I
add your Reviewed-by to the whole series?

- Kevin

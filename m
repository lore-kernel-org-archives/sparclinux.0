Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5311034DCE1;
	Fri,  5 Sep 2025 12:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757074977; cv=none; b=jTsiry5uR3u07SCeFmgKfM0pdqGhtRiJkSJLjjhn63676RubiF21ks9FNC8sbtzoVyn5siQNocD2IMm32oYW2egJTVEQlj3IsYlhEGRfie67cUdq2ChnGXtn1/AXIo/AAIVJ6g9w/5YIcnhP5BdQAecfvNuN6L7k/hUGBEkaiVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757074977; c=relaxed/simple;
	bh=ywmDAG7PE2fj1+B2GkU5RbYTyU3sAGy8lTlonC3Qgos=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N/Ub+Cbrfh1YWRAkpLLrWo8uBfeEfeyhGM6piFcZ3Nd6WJ7C3Lk+t/uz4NyeGPB6uyG3IxdHujVRO/z8U4oMfQe6Rqufg8Wxwo3hEmbA32wUYJKd+4Hu/4L6yb4vp45dvAA72EW1SCnoZo7f5cf8Hz80j1AZH1GJ/nUL9jSPYHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2012D153B;
	Fri,  5 Sep 2025 05:22:46 -0700 (PDT)
Received: from [10.57.60.42] (unknown [10.57.60.42])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D7BF93F63F;
	Fri,  5 Sep 2025 05:22:48 -0700 (PDT)
Message-ID: <a18f9cbd-490d-4270-8707-4ed6d730cfcd@arm.com>
Date: Fri, 5 Sep 2025 14:22:46 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] mm: introduce local state for lazy_mmu sections
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
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
 xen-devel@lists.xenproject.org
References: <20250904125736.3918646-1-kevin.brodsky@arm.com>
 <20250904125736.3918646-3-kevin.brodsky@arm.com>
 <22131943-3f92-4f5a-be28-7b668c07a25c@lucifer.local>
 <75db1f58-98b3-463c-af4f-2ce9878cba9f@arm.com>
 <2aed0b3b-1a70-4c89-9177-8de4fabb2237@lucifer.local>
 <e6072568-1b98-4a7f-8d30-65417a440bb7@lucifer.local>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <e6072568-1b98-4a7f-8d30-65417a440bb7@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/09/2025 13:37, Lorenzo Stoakes wrote:
> On Fri, Sep 05, 2025 at 12:21:40PM +0100, Lorenzo Stoakes wrote:
>> You should really base on mm-new.
>>
>> You need to account for everything that is potentially going to go
>> upstream. mm-stable is generally not actually populated all too well until
>> shortly before merge window anyway.
> Just to note that mm-unstable is also fine. Despite its name, it's substantially
> more stable than mm-new, which can even break the build and appears to have no
> checks performed on it at all.

Thanks for the overview - I had a general idea about those branches but
I wasn't sure what the standard practice was. I'll rebase on mm-unstable
to start with.

- Kevin

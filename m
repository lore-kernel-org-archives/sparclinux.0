Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918AF3064A3;
	Mon, 10 Nov 2025 10:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762771043; cv=none; b=Ms7uic+kuz+aUb8Qhq4IQ/bF2eCbLBzrkhefgzOuHloyHBw6GQGHYYhvJrOR9mVUBq31oeeMbk/8FEXr+5mGjUyuWO+wspNUPgMKzZClhXYrYhAUU13buUQombmDFmYzvOYJmyRY+GKyeBoCqSe/zM+6BTpiqx+1UOK7GNdCS5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762771043; c=relaxed/simple;
	bh=wwdS1VB3vgYSOM1P254K506c5LfSj/vi1RAI9w6ktio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E6QjOFoGK5P5mnHc3pCVFeIVNdMktznrVh1SGD+bK1GwtHWLpePYreEh3+6z9quc9WP240SRKkC044/3ohImW2DWgYsh88M/V2zoqoYKzyfYHKGA6isgsJ1eTQ5fZTj562d9TWrB8GAp8q+OtaUfcTGAddaQNug9b/HHXKMvSqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CEEFE497;
	Mon, 10 Nov 2025 02:37:12 -0800 (PST)
Received: from [10.57.39.147] (unknown [10.57.39.147])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E4913F66E;
	Mon, 10 Nov 2025 02:37:12 -0800 (PST)
Message-ID: <b21fb5b9-2e7f-4cbc-ae62-015b1317a9bd@arm.com>
Date: Mon, 10 Nov 2025 11:36:52 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/12] x86/xen: simplify flush_lazy_mmu()
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
 <20251029100909.3381140-3-kevin.brodsky@arm.com>
 <b165098a-8164-4664-aaaf-1e8c4391d797@arm.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <b165098a-8164-4664-aaaf-1e8c4391d797@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/11/2025 12:31, Ryan Roberts wrote:
> On 29/10/2025 10:08, Kevin Brodsky wrote:
>> arch_flush_lazy_mmu_mode() is called when outstanding batched
>> pgtable operations must be completed immediately. There should
>> however be no need to leave and re-enter lazy MMU completely. The
>> only part of that sequence that we really need is xen_mc_flush();
>> call it directly.
>>
>> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
> This looks functionally equivalent to me, so:
>
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
>
> But I don't think this tidy up is strictly necessary for your series to work?
> (perhaps I'll change my mind on that as I go through it).

I initially thought it might be, but in the end I think you're right -
it should still work fine without this patch.

Still, I'd rather avoid unnecessary calls to arch_enter() and
arch_leave() as it makes it harder to reason about what is called where.
Namely, keeping them here means that a nested call to
lazy_mmu_mode_disable() would cause arch_leave() then arch_enter() to be
called - rather unexpected.

The only calls to arch_enter() and arch_leave() that are left after this
series are the ones in <linux/pgtable.h> and the Xen context-switching
logic (the one case where calling arch hooks directly is justified, see
discussion on v3 [1]).

- Kevin

[1]
https://lore.kernel.org/all/390e41ae-4b66-40c1-935f-7a1794ba0b71@arm.com/

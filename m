Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87204143736;
	Sat, 31 May 2025 07:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748677627; cv=none; b=Rrr2J4ueAgRLv5QTQa7QLpkJMNrgYymkOnvgWEFmhEyRCwymLKORgRReYcPF0BVw5yr0mMaBrELG9nXIa7WYDicx9T13zVU9VzTn+me6l/WL1t3UFSs4aTFNxcnqe8f4H3CHgW5avF+lIJkx1IngpdnDNZf3OlagUVcI8/Cj678=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748677627; c=relaxed/simple;
	bh=sT8ax5dbTHlITwDR7EB59IJncQ2gJREmL936Z5hIaHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=De0DmsTMkWvYx2KTIqKGsNmMiZwDlwR7cRT7PX+IX59zuSycU8likPhc2zA5ZxciTDg5hb6E6WovPPuFuXUUDhGpy4/Gn4ThWWNhEBaXKalYlsVJdtxenshPaxqt4zUe9HHJOkOvMr/jGJ8XHfqaTBiU1hyixrKmEEeOb4ITPIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m4l+/YKI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m4l+/YKI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEAB7C4CEE3;
	Sat, 31 May 2025 07:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748677627;
	bh=sT8ax5dbTHlITwDR7EB59IJncQ2gJREmL936Z5hIaHo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m4l+/YKIs/KGay8y5vMJQ2bX/6i3fxjZ0gJ0+6SfB85gTMv9isMoswQqVsv4Dm+Yl
	 5gBNStHJ++v6+O0EtdOWObMpAyqqJtKiiiHCvqbrRYRGbqgk54Gsoto2+2xSaTGEX/
	 UjUmkcVswzLe8hErYSg4k60I8QKcdT/ikfO8I1+QYom9bCQCk6Jq/eiD5Mj9Y39hlp
	 sAiyJS/N7snMk3XQ2/Bvj/0wr0qADR+cJOCyKzCUqM5WQ0/2ASiXFMHCRpT2zrg06m
	 ciDBHHpS087W/LZIa9rTY4pgSp3axMokcqCHGPjdvNd0LKzornyQw2tVBbwFtOMgVG
	 zRx/WnEiPnYpA==
Date: Sat, 31 May 2025 10:46:52 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Juergen Gross <jgross@suse.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>, David Hildenbrand <david@redhat.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Alexei Starovoitov <ast@kernel.org>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
	virtualization@lists.linux.dev, xen-devel@lists.xenproject.org,
	linux-mm@kvack.org, Jann Horn <jannh@google.com>
Subject: Re: [RFC PATCH v1 0/6] Lazy mmu mode fixes and improvements
Message-ID: <aDqz7H-oBo35FRXe@kernel.org>
References: <20250530140446.2387131-1-ryan.roberts@arm.com>
 <5b5d6352-9018-4658-b8fe-6eadaad46881@lucifer.local>
 <af9a96e1-064b-4627-bd34-e7e7e8a05452@arm.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af9a96e1-064b-4627-bd34-e7e7e8a05452@arm.com>

Hi Ryan,

On Fri, May 30, 2025 at 04:55:36PM +0100, Ryan Roberts wrote:
> On 30/05/2025 15:47, Lorenzo Stoakes wrote:
> > +cc Jann who is a specialist in all things page table-y and especially scary
> > edge cases :)
> > 
> > On Fri, May 30, 2025 at 03:04:38PM +0100, Ryan Roberts wrote:
> >> Hi All,
> >>
> >> I recently added support for lazy mmu mode on arm64. The series is now in
> >> Linus's tree so should be in v6.16-rc1. But during testing in linux-next we
> >> found some ugly corners (unexpected nesting). I was able to fix those issues by
> >> making the arm64 implementation more permissive (like the other arches). But
> >> this is quite fragile IMHO. So I'd rather fix the root cause and ensure that
> >> lazy mmu mode never nests, and more importantly, that code never makes pgtable
> >> modifications expecting them to be immediate, not knowing that it's actually in
> >> lazy mmu mode so the changes get deferred.
> > 
> > When you say fragile, are you confident it _works_ but perhaps not quite as well
> > as you want? Or are you concerned this might be broken upstream in any way?
> 
> I'm confident that it _works_ for arm64 as it is, upstream. But if Dev's series
> were to go in _without_ the lazy_mmu bracketting in some manner, then it would
> be broken if the config includes CONFIG_DEBUG_PAGEALLOC.
> 
> There's a lot more explanation in the later patches as to how it can be broken,
> but for arm64, the situation is currently like this, because our implementation
> of __change_memory_common() uses apply_to_page_range() which implicitly starts
> an inner lazy_mmu_mode. We enter multiple times, but we exit one the first call
> to exit. Everything works correctly but it's not optimal because C is no longer
> deferred:
> 
> arch_enter_lazy_mmu_mode()                        << outer lazy mmu region
>   <do some pte changes (A)>
>   alloc_pages()
>     debug_pagealloc_map_pages()
>       __kernel_map_pages()
>         __change_memory_common()
>           arch_enter_lazy_mmu_mode()              << inner lazy mmu region
>             <change kernel pte to make valid (B)>
>           arch_leave_lazy_mmu_mode()              << exit; complete A + B
>     clear_page()
>   <do some more pte changes (C)>                  << no longer in lazy mode
> arch_leave_lazy_mmu_mode()                        << nop
> 
> An alternative implementation would not add the nested lazy mmu mode, so we end
> up with this:
> 
> arch_enter_lazy_mmu_mode()                        << outer lazy mmu region
>   <do some pte changes (A)>
>   alloc_pages()
>     debug_pagealloc_map_pages()
>       __kernel_map_pages()
>         __change_memory_common()
>             <change kernel pte to make valid (B)> << deferred due to lazy mmu
>     clear_page()                                  << BANG! B has not be actioned
>   <do some more pte changes (C)>
> arch_leave_lazy_mmu_mode()
> 
> This is clearly a much worse outcome. It's not happening today but it could in
> future. That's why I'm claiming it's fragile. It's much better (IMHO) to
> disallow calling the page allocator when in lazy mmu mode.

First, I think it should be handled completely inside arch/arm64. Page
allocation worked on lazy mmu mode on other architectures, no reason it
should be changed because of the way arm64 implements lazy mmu.

Second, DEBUG_PAGEALLOC already implies that performance is bad, for it to
be useful the kernel should be mapped with base pages and there's map/unmap
for every page allocation so optimizing a few pte changes (C in your
example) won't matter much.

If there's a potential correctness issue with Dev's patches, it should be
dealt with as a part of those patches with the necessary updates of how
lazy mmu is implemented on arm64 and used in pageattr.c.

And it seems to me that adding something along the lines below to
__kernel_map_pages() would solve DEBUG_PAGEALLOC issue:

void __kernel_map_pages(struct page *page, int numpages, int enable)
{
	unsigned long flags;
	bool lazy_mmu = false;

	if (!can_set_direct_map())
		return;

	flags = read_thread_flags();
	if (flags & BIT(TIF_LAZY_MMU))
		lazy_mmu = true;

	set_memory_valid((unsigned long)page_address(page), numpages, enable);

	if (lazy_mmu)
		set_thread_flag(TIF_LAZY_MMU);
}

> Thanks,
> Ryan

-- 
Sincerely yours,
Mike.

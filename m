Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A8E2BE020;
	Fri,  5 Sep 2025 11:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757071164; cv=none; b=qniqAUSpk0ox4m041ZQ2mKVDRnbDluG7EzMA80PxIeUZeirkbjSNfyODYme/Q233mopGkFwUj+dbc5L1ckcJ6+Kydg4bC0m3wfWHlrMLjFK52YpmdWktA5zt9+v+gbWX84h5FtTO4aw3CyF0Jl53QBlWy7LKQHG6WzQz9PlDbz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757071164; c=relaxed/simple;
	bh=RHLqjtmoQ09sM+x+rrDllENxQeIkKdioDv+JW9P+Aos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BZkFlX8WdU0BYZXkuih1EDx9b9WFyZBXvP5HKsJB+m4TTC9mR4DkHofETH0SabVGLhBb2wH5x0zWQEI9lghETaC4A8+zC1wqa2U8PSE5vhxSi/fj6Mye68gd+DZtOmnvg6RcUJgCo0AKSoQyJQXBxugoGTva+uWMGPhr9QGGJT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/QIh2dd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/QIh2dd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C27C4CEF1;
	Fri,  5 Sep 2025 11:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757071164;
	bh=RHLqjtmoQ09sM+x+rrDllENxQeIkKdioDv+JW9P+Aos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A/QIh2ddmPQW9GbhkGscvwZJAOdlvRvh05eTseLWqDi0NqX5VoUz3c+rFGi5te6gs
	 FeVf6cxesM0g4NssvOVujDWyj9mrdK8LpKlTGDp/6FZss2dq4STW6zOMrER9uue5m7
	 gYM0YJqrGGelTJTg/Wae0ezZ+Ln5Z9a7rQdsrtvsC5aJMkzJDUejnZeo9niA5S9ZsO
	 rAiiZhiID4hhFyLR0EPR+sXVy1LHpEREWSJ9XWSwcd0WYCKy66BICmsJmvPOks/99s
	 KUtvAv0iw5WXUoAptM66b1336WnWvdA8iRqYrawyqjKazn3DqpgdPmx5ld20pIZHkT
	 94jShf4NQqhcQ==
Date: Fri, 5 Sep 2025 14:19:11 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Jann Horn <jannh@google.com>, Juergen Gross <jgross@suse.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Hocko <mhocko@suse.com>, Nicholas Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: Re: [PATCH 2/7] mm: introduce local state for lazy_mmu sections
Message-ID: <aLrHL-C_UXfUbCd9@kernel.org>
References: <20250904125736.3918646-1-kevin.brodsky@arm.com>
 <20250904125736.3918646-3-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904125736.3918646-3-kevin.brodsky@arm.com>

On Thu, Sep 04, 2025 at 01:57:31PM +0100, Kevin Brodsky wrote:
> arch_{enter,leave}_lazy_mmu_mode() currently have a stateless API
> (taking and returning no value). This is proving problematic in
> situations where leave() needs to restore some context back to its
> original state (before enter() was called). In particular, this
> makes it difficult to support the nesting of lazy_mmu sections -
> leave() does not know whether the matching enter() call occurred
> while lazy_mmu was already enabled, and whether to disable it or
> not.
> 
> This patch gives all architectures the chance to store local state
> while inside a lazy_mmu section by making enter() return some value,
> storing it in a local variable, and having leave() take that value.
> That value is typed lazy_mmu_state_t - each architecture defining
> __HAVE_ARCH_ENTER_LAZY_MMU_MODE is free to define it as it sees fit.
> For now we define it as int everywhere, which is sufficient to
> support nesting.
> 
> The diff is unfortunately rather large as all the API changes need
> to be done atomically. Main parts:
> 
> * Changing the prototypes of arch_{enter,leave}_lazy_mmu_mode()
>   in generic and arch code, and introducing lazy_mmu_state_t.
> 
> * Introducing LAZY_MMU_{DEFAULT,NESTED} for future support of
>   nesting. enter() always returns LAZY_MMU_DEFAULT for now.
>   (linux/mm_types.h is not the most natural location for defining
>   those constants, but there is no other obvious header that is
>   accessible where arch's implement the helpers.)
> 
> * Changing all lazy_mmu sections to introduce a lazy_mmu_state
>   local variable, having enter() set it and leave() take it. Most of
>   these changes were generated using the Coccinelle script below.
> 
> @@
> @@
> {
> + lazy_mmu_state_t lazy_mmu_state;
> ...
> - arch_enter_lazy_mmu_mode();
> + lazy_mmu_state = arch_enter_lazy_mmu_mode();
> ...
> - arch_leave_lazy_mmu_mode();
> + arch_leave_lazy_mmu_mode(lazy_mmu_state);
> ...
> }
> 
> Note: it is difficult to provide a default definition of
> lazy_mmu_state_t for architectures implementing lazy_mmu, because
> that definition would need to be available in
> arch/x86/include/asm/paravirt_types.h and adding a new generic
>  #include there is very tricky due to the existing header soup.
> 
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

-- 
Sincerely yours,
Mike.

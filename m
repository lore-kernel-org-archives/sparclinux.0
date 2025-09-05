Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D2D343D9B;
	Fri,  5 Sep 2025 11:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757070845; cv=none; b=HPHiMJl6IUmcSPGODxU3/fnmteSKxnKuvP2P5j2VH6ynyihZ/yXTMcKFFC2EuRG93X9aPy6xBx4kixQwn01+iXNZMxxGcdoi2ZhjhSwz4kQTYL8K5GwA6LVpw5mJYNlxp4F7OtqjVomTOFjszmcVjfT/rCFfMBlgI7YPPA+P4Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757070845; c=relaxed/simple;
	bh=kDpzhB/6Cz5cknkR7vg25nX23vQb619EzR6gJMWg0zE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L4d/XtVdZlsYBRiTJij9Y3pMwb3keIrr1EZ2+BFhWXp/RcXx7Gg/6+RxkSR6nadUViG7y+dxDwoAD/wuD78VbCFvGcBiC6QKMzDyxbqXpu2GGA6QHGj48GzZSgv1ZDJfl5hjCkr1OPWfUSOyK3srLhafuYEvf+6KUY4q8J34FYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihMD5Uip; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihMD5Uip"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93F34C4CEF1;
	Fri,  5 Sep 2025 11:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757070844;
	bh=kDpzhB/6Cz5cknkR7vg25nX23vQb619EzR6gJMWg0zE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ihMD5UipqP42+z3YN+MrXn99n6Ycd3YsueOx6CaMNo+hdxO5RgsqI0SQxPdExPL3V
	 BxsONFBqcXHbav7x1SkdqIDD48PmtLWsgPm58G0QlMiay/oaIVskT0KF8NuPaK9VFd
	 /7wzkSZr/Kf5WRucMN8/UCNMZojnjOtaAmAF95Bjf8RmpqIT1ej5HygOv9JaajJW8G
	 3sqfezMFb01ibM/+0hkAjFN8sRUuYHQxj5dBVnj+if/YJu29wWq859HwQBz6EYrcmA
	 3EU4AmTwTsfLSifdqQkLCIzFzeBG/3X8Ze/ePLiEQWW6Tfu9V10hDtY4xQjiB241cI
	 b5217/1pBB0Eg==
Date: Fri, 5 Sep 2025 14:13:50 +0300
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
Subject: Re: [PATCH 7/7] mm: update lazy_mmu documentation
Message-ID: <aLrF7qi85tmHfWRf@kernel.org>
References: <20250904125736.3918646-1-kevin.brodsky@arm.com>
 <20250904125736.3918646-8-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904125736.3918646-8-kevin.brodsky@arm.com>

On Thu, Sep 04, 2025 at 01:57:36PM +0100, Kevin Brodsky wrote:
> We now support nested lazy_mmu sections on all architectures
> implementing the API. Update the API comment accordingly.
> 
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  include/linux/pgtable.h | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 6932c8e344ab..be0f059beb4d 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -228,8 +228,18 @@ static inline int pmd_dirty(pmd_t pmd)
>   * of the lazy mode. So the implementation must assume preemption may be enabled
>   * and cpu migration is possible; it must take steps to be robust against this.
>   * (In practice, for user PTE updates, the appropriate page table lock(s) are
> - * held, but for kernel PTE updates, no lock is held). Nesting is not permitted
> - * and the mode cannot be used in interrupt context.
> + * held, but for kernel PTE updates, no lock is held). The mode cannot be used
> + * in interrupt context.
> + *
> + * Calls may be nested: an arch_{enter,leave}_lazy_mmu_mode() pair may be called
> + * while the lazy MMU mode has already been enabled. An implementation should
> + * handle this using the state returned by enter() and taken by the matching
> + * leave() call; the LAZY_MMU_{DEFAULT,NESTED} flags can be used to indicate
> + * whether this enter/leave pair is nested inside another or not. (It is up to
> + * the implementation to track whether the lazy MMU mode is enabled at any point
> + * in time.) The expectation is that leave() will flush any batched state
> + * unconditionally, but only leave the lazy MMU mode if the passed state is not
> + * LAZY_MMU_NESTED.
>   */
>  #ifndef __HAVE_ARCH_ENTER_LAZY_MMU_MODE
>  typedef int lazy_mmu_state_t;
> -- 
> 2.47.0
> 

-- 
Sincerely yours,
Mike.

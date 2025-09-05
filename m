Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3390633EB0D;
	Fri,  5 Sep 2025 11:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757070064; cv=none; b=Oek1ao9xeNtto30nbIleFgjW+LFAHYG80h8oBYAuVV2AEXOcqkbhu6VC5hfI6lt/I+gK0tzkkHibmPtEEJutqzDAocqLu4JJlF7HYJe1KIwGFmr9WXVsjy+qseBrDF9poiKb17xmw3rvsQm95WvIB7vbr1jq5tN+kz212zG7TOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757070064; c=relaxed/simple;
	bh=YZ1wTIYoB930tSA5MeqtdhO0LxdCLchTUQFtsum00QY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d9ddDMoaN8uVAr/WKDIwQtn/A+q+P2oYpg3z9SFsHjcKlMhh8Wvibg8pEgJgDvYffPycSJLREIGoDaab0dWo44l59+UTHrxHdhMBIqXInGksqbIfKOF0La61V83ZK5ucc6psDh6GSa7Mc1wDRv4zvjZ2cWyn7gcZ6mrC+ipV1Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U7+DnpZ0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U7+DnpZ0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2257C4CEF1;
	Fri,  5 Sep 2025 11:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757070063;
	bh=YZ1wTIYoB930tSA5MeqtdhO0LxdCLchTUQFtsum00QY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U7+DnpZ0s1JKbZszxSjLy0wzG4FuSPqezXeI+JVM+MWhXKMk7hbSMLMR/Ap70xViw
	 Grd6dhed7yIRR8Yu73fJN0N7pkSYFsDBBJo92L9gty0NMlP0j/ofYzR8Udwhhqz0oh
	 CUbTDNzSsrto9aiXPTcXZ/bGs5k+wjoB6qyCquH8g/JPTbP7OqDNsG+bte2OrVpi4n
	 zx6H4iTAqk8cmGshjWzK/jnlqFQq/hJysU/x9N1c9QnwDh2XIGq4oxaydCWq1cwWGV
	 2fRPyoqYacVZpZfy0SFEibM7KjqfNwOBpyIxsFAfubouuDw7Z5Ombt9MKgcN6WzQfQ
	 4CK8xb4S08BQg==
Date: Fri, 5 Sep 2025 14:00:50 +0300
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
Subject: Re: [PATCH 1/7] mm: remove arch_flush_lazy_mmu_mode()
Message-ID: <aLrC4reKPAz6YFn1@kernel.org>
References: <20250904125736.3918646-1-kevin.brodsky@arm.com>
 <20250904125736.3918646-2-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904125736.3918646-2-kevin.brodsky@arm.com>

On Thu, Sep 04, 2025 at 01:57:30PM +0100, Kevin Brodsky wrote:
> This function has only ever been used in arch/x86, so there is no
> need for other architectures to implement it. Remove it from
> linux/pgtable.h and all architectures besides x86.
> 
> The arm64 implementation is not empty but it is only called from
> arch_leave_lazy_mmu_mode(), so we can simply fold it there.
> 
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  arch/arm64/include/asm/pgtable.h                   | 9 +--------
>  arch/powerpc/include/asm/book3s/64/tlbflush-hash.h | 2 --
>  arch/sparc/include/asm/tlbflush_64.h               | 1 -
>  arch/x86/include/asm/pgtable.h                     | 3 ++-
>  include/linux/pgtable.h                            | 1 -
>  5 files changed, 3 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index abd2dee416b3..728d7b6ed20a 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -101,21 +101,14 @@ static inline void arch_enter_lazy_mmu_mode(void)
>  	set_thread_flag(TIF_LAZY_MMU);
>  }
>  
> -static inline void arch_flush_lazy_mmu_mode(void)
> +static inline void arch_leave_lazy_mmu_mode(void)
>  {
>  	if (in_interrupt())
>  		return;
>  
>  	if (test_and_clear_thread_flag(TIF_LAZY_MMU_PENDING))
>  		emit_pte_barriers();
> -}
> -
> -static inline void arch_leave_lazy_mmu_mode(void)
> -{
> -	if (in_interrupt())
> -		return;
>  
> -	arch_flush_lazy_mmu_mode();
>  	clear_thread_flag(TIF_LAZY_MMU);
>  }
>  
> diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h b/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
> index 146287d9580f..176d7fd79eeb 100644
> --- a/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
> +++ b/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
> @@ -55,8 +55,6 @@ static inline void arch_leave_lazy_mmu_mode(void)
>  	preempt_enable();
>  }
>  
> -#define arch_flush_lazy_mmu_mode()      do {} while (0)
> -
>  extern void hash__tlbiel_all(unsigned int action);
>  
>  extern void flush_hash_page(unsigned long vpn, real_pte_t pte, int psize,
> diff --git a/arch/sparc/include/asm/tlbflush_64.h b/arch/sparc/include/asm/tlbflush_64.h
> index 8b8cdaa69272..cd144eb31bdd 100644
> --- a/arch/sparc/include/asm/tlbflush_64.h
> +++ b/arch/sparc/include/asm/tlbflush_64.h
> @@ -44,7 +44,6 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end);
>  void flush_tlb_pending(void);
>  void arch_enter_lazy_mmu_mode(void);
>  void arch_leave_lazy_mmu_mode(void);
> -#define arch_flush_lazy_mmu_mode()      do {} while (0)
>  
>  /* Local cpu only.  */
>  void __flush_tlb_all(void);
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index e33df3da6980..14fd672bc9b2 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -117,7 +117,8 @@ extern pmdval_t early_pmd_flags;
>  #define pte_val(x)	native_pte_val(x)
>  #define __pte(x)	native_make_pte(x)
>  
> -#define arch_end_context_switch(prev)	do {} while(0)
> +#define arch_end_context_switch(prev)	do {} while (0)
> +#define arch_flush_lazy_mmu_mode()	do {} while (0)
>  #endif	/* CONFIG_PARAVIRT_XXL */
>  
>  static inline pmd_t pmd_set_flags(pmd_t pmd, pmdval_t set)
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 4c035637eeb7..8848e132a6be 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -234,7 +234,6 @@ static inline int pmd_dirty(pmd_t pmd)
>  #ifndef __HAVE_ARCH_ENTER_LAZY_MMU_MODE
>  #define arch_enter_lazy_mmu_mode()	do {} while (0)
>  #define arch_leave_lazy_mmu_mode()	do {} while (0)
> -#define arch_flush_lazy_mmu_mode()	do {} while (0)
>  #endif
>  
>  #ifndef pte_batch_hint
> -- 
> 2.47.0
> 

-- 
Sincerely yours,
Mike.

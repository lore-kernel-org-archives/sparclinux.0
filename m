Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6A832D0F0;
	Fri,  7 Nov 2025 15:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762530162; cv=none; b=cCP5UcKarqRG+idrLkI3oTWEv9dVAmRXgBQ67J8wk8QIxrgsjfpmmYZygwU4eFQGYawK0Gj5oFz+xuGx8xKbl+5AlzQOtvEHF2lKcVlBXKPpd31k2zm+V58Q+BQJx03MF4SPhcP3+0ipCKOUw63F40bMd5kA4BWhsAaEaAAg79Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762530162; c=relaxed/simple;
	bh=P6+i61snvOtkDvzDzz4lofU3nn9eAaoZvsWKvNTnOpQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pmmSvwIH52zgFRD9Iqc6IK22hThvopV9+1L8cS+kMaB/4/juiywLMyC5zfLnu70tHKB5WrAKJ7VnDGXxKI8B+4KaD7+ve/3utx5hgz759mCjo2ynYzUBpZegrt3h4W16mfFcf1zby/gBK3wtyEhReQRBc32FdnW/ZyhaPJhoRYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B6271515;
	Fri,  7 Nov 2025 07:42:32 -0800 (PST)
Received: from [10.57.86.134] (unknown [10.57.86.134])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F2A33F694;
	Fri,  7 Nov 2025 07:42:35 -0800 (PST)
Message-ID: <8a38db66-4d1a-4296-a2dc-e0276c6cdde8@arm.com>
Date: Fri, 7 Nov 2025 15:42:34 +0000
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/12] mm: bail out of lazy_mmu_mode_* in interrupt
 context
Content-Language: en-GB
To: Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org
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
 <20251029100909.3381140-13-kevin.brodsky@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20251029100909.3381140-13-kevin.brodsky@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/10/2025 10:09, Kevin Brodsky wrote:
> The lazy MMU mode cannot be used in interrupt context. This is
> documented in <linux/pgtable.h>, but isn't consistently handled
> across architectures.
> 
> arm64 ensures that calls to lazy_mmu_mode_* have no effect in
> interrupt context, because such calls do occur in certain
> configurations - see commit b81c688426a9 ("arm64/mm: Disable barrier
> batching in interrupt contexts"). Other architectures do not check
> this situation, most likely because it hasn't occurred so far.
> 
> Both arm64 and x86/Xen also ensure that any lazy MMU optimisation is
> disabled while in interrupt mode (see queue_pte_barriers() and
> xen_get_lazy_mode() respectively).
> 
> Let's handle this in the new generic lazy_mmu layer, in the same
> fashion as arm64: bail out of lazy_mmu_mode_* if in_interrupt(), and
> have in_lazy_mmu_mode() return false to disable any optimisation.
> Also remove the arm64 handling that is now redundant; x86/Xen has
> its own internal tracking so it is left unchanged.
> 
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
> ---
>  arch/arm64/include/asm/pgtable.h | 17 +----------------
>  include/linux/pgtable.h          | 16 ++++++++++++++--
>  include/linux/sched.h            |  3 +++
>  3 files changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 61ca88f94551..96987a49e83b 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -62,37 +62,22 @@ static inline void emit_pte_barriers(void)
>  
>  static inline void queue_pte_barriers(void)
>  {
> -	if (in_interrupt()) {
> -		emit_pte_barriers();
> -		return;
> -	}
> -
>  	if (in_lazy_mmu_mode())
>  		test_and_set_thread_flag(TIF_LAZY_MMU_PENDING);
>  	else
>  		emit_pte_barriers();
>  }
>  
> -static inline void arch_enter_lazy_mmu_mode(void)
> -{
> -	if (in_interrupt())
> -		return;
> -}
> +static inline void arch_enter_lazy_mmu_mode(void) {}
>  
>  static inline void arch_flush_lazy_mmu_mode(void)
>  {
> -	if (in_interrupt())
> -		return;
> -
>  	if (test_and_clear_thread_flag(TIF_LAZY_MMU_PENDING))
>  		emit_pte_barriers();
>  }
>  
>  static inline void arch_leave_lazy_mmu_mode(void)
>  {
> -	if (in_interrupt())
> -		return;
> -
>  	arch_flush_lazy_mmu_mode();
>  }

Ahh ok, by the time you get to the final state, I think a most of my
comments/concerns are solved. Certainly this now looks safe for the interrupt
case, whereas I think the intermediate state when you initially introduce
nesting is broken. So perhaps you want to look at how to rework it to prevent that.

Thanks,
Ryan


>  
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index e6064e00b22d..e6069ce4ec83 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -228,8 +228,8 @@ static inline int pmd_dirty(pmd_t pmd)
>   * of the lazy mode. So the implementation must assume preemption may be enabled
>   * and cpu migration is possible; it must take steps to be robust against this.
>   * (In practice, for user PTE updates, the appropriate page table lock(s) are
> - * held, but for kernel PTE updates, no lock is held). The mode cannot be used
> - * in interrupt context.
> + * held, but for kernel PTE updates, no lock is held). The mode is disabled
> + * in interrupt context and calls to the lazy_mmu API have no effect.
>   *
>   * The lazy MMU mode is enabled for a given block of code using:
>   *
> @@ -265,6 +265,9 @@ static inline void lazy_mmu_mode_enable(void)
>  {
>  	struct lazy_mmu_state *state = &current->lazy_mmu_state;
>  
> +	if (in_interrupt())
> +		return;
> +
>  	VM_WARN_ON_ONCE(state->nesting_level == U8_MAX);
>  	/* enable() must not be called while paused */
>  	VM_WARN_ON(state->nesting_level > 0 && !state->active);
> @@ -279,6 +282,9 @@ static inline void lazy_mmu_mode_disable(void)
>  {
>  	struct lazy_mmu_state *state = &current->lazy_mmu_state;
>  
> +	if (in_interrupt())
> +		return;
> +
>  	VM_WARN_ON_ONCE(state->nesting_level == 0);
>  	VM_WARN_ON(!state->active);
>  
> @@ -295,6 +301,9 @@ static inline void lazy_mmu_mode_pause(void)
>  {
>  	struct lazy_mmu_state *state = &current->lazy_mmu_state;
>  
> +	if (in_interrupt())
> +		return;
> +
>  	VM_WARN_ON(state->nesting_level == 0 || !state->active);
>  
>  	state->active = false;
> @@ -305,6 +314,9 @@ static inline void lazy_mmu_mode_resume(void)
>  {
>  	struct lazy_mmu_state *state = &current->lazy_mmu_state;
>  
> +	if (in_interrupt())
> +		return;
> +
>  	VM_WARN_ON(state->nesting_level == 0 || state->active);
>  
>  	state->active = true;
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 11566d973f42..bb873016ffcf 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1731,6 +1731,9 @@ static inline char task_state_to_char(struct task_struct *tsk)
>  #ifdef CONFIG_ARCH_HAS_LAZY_MMU_MODE
>  static inline bool in_lazy_mmu_mode(void)
>  {
> +	if (in_interrupt())
> +		return false;
> +
>  	return current->lazy_mmu_state.active;
>  }
>  #else


Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC132139579;
	Thu,  4 Dec 2025 06:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764831149; cv=none; b=CVM4MXQGeXhy/l2akH8b8xgWifRbTp2zMz5dz14bo9fOoBn1+whGYObRkOKmIPW59F0aPCDiV2IPLmuAxLS8OP9/5LnHygmRu4gDS/UPTmSAEU+V+zXkKMW+NBB4Pwf0Gjx8DB8yE2A98eb3E1Cb+wGYhh/hLBvzizVq7VSSQMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764831149; c=relaxed/simple;
	bh=1boTE1qEz5YMV/pmwTlfyi/FnQYDX9oWmoCf/6xq7QA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GouvbMY7ErvbZaWipQTnRqlf/42XreRJCduyOLXaZcV1ktAHVedhIzUwDQX/P+EqNalUArQKuFHFK1azvwiUL1XMWEHs9ZFQnsf3XjCeyKSMsxYAU98I7Z274/uOS+7Tvcutxr2iyXcLCpj8J7EvyYcakkHRVpovpD9pBRtMaz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AEABB339;
	Wed,  3 Dec 2025 22:52:18 -0800 (PST)
Received: from [10.164.18.78] (unknown [10.164.18.78])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C0333F59E;
	Wed,  3 Dec 2025 22:52:16 -0800 (PST)
Message-ID: <89ecddb7-83ee-427b-823b-984204939ecf@arm.com>
Date: Thu, 4 Dec 2025 12:22:13 +0530
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/12] arm64: mm: replace TIF_LAZY_MMU with
 in_lazy_mmu_mode()
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
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20251124132228.622678-10-kevin.brodsky@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/11/25 6:52 PM, Kevin Brodsky wrote:
> The generic lazy_mmu layer now tracks whether a task is in lazy MMU
> mode. As a result we no longer need a TIF flag for that purpose -
> let's use the new in_lazy_mmu_mode() helper instead.
> 
> The explicit check for in_interrupt() is no longer necessary either
> as in_lazy_mmu_mode() always returns false in interrupt context.
> 
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
> ---
>  arch/arm64/include/asm/pgtable.h     | 19 +++----------------
>  arch/arm64/include/asm/thread_info.h |  3 +--
>  2 files changed, 4 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index a7d99dee3dc4..dd7ed653a20d 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -62,28 +62,16 @@ static inline void emit_pte_barriers(void)
>  
>  static inline void queue_pte_barriers(void)
>  {
> -	unsigned long flags;
> -
> -	if (in_interrupt()) {
> -		emit_pte_barriers();
> -		return;
> -	}
> -
> -	flags = read_thread_flags();
> -
> -	if (flags & BIT(TIF_LAZY_MMU)) {
> +	if (in_lazy_mmu_mode()) {
>  		/* Avoid the atomic op if already set. */
> -		if (!(flags & BIT(TIF_LAZY_MMU_PENDING)))
> +		if (!test_thread_flag(TIF_LAZY_MMU_PENDING))

A small nit - will it be better not to use test_thread_flag() here and just
keep checking flags like earlier to avoid non-related changes. Although not
a problem TBH.

>  			set_thread_flag(TIF_LAZY_MMU_PENDING);
>  	} else {
>  		emit_pte_barriers();
>  	}
>  }
>  
> -static inline void arch_enter_lazy_mmu_mode(void)
> -{
> -	set_thread_flag(TIF_LAZY_MMU);
> -}
> +static inline void arch_enter_lazy_mmu_mode(void) {}
>  
>  static inline void arch_flush_lazy_mmu_mode(void)
>  {
> @@ -94,7 +82,6 @@ static inline void arch_flush_lazy_mmu_mode(void)
>  static inline void arch_leave_lazy_mmu_mode(void)
>  {
>  	arch_flush_lazy_mmu_mode();
> -	clear_thread_flag(TIF_LAZY_MMU);
>  }
>  
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
> index f241b8601ebd..4ff8da0767d9 100644
> --- a/arch/arm64/include/asm/thread_info.h
> +++ b/arch/arm64/include/asm/thread_info.h
> @@ -84,8 +84,7 @@ void arch_setup_new_exec(void);
>  #define TIF_SME_VL_INHERIT	28	/* Inherit SME vl_onexec across exec */
>  #define TIF_KERNEL_FPSTATE	29	/* Task is in a kernel mode FPSIMD section */
>  #define TIF_TSC_SIGSEGV		30	/* SIGSEGV on counter-timer access */
> -#define TIF_LAZY_MMU		31	/* Task in lazy mmu mode */
> -#define TIF_LAZY_MMU_PENDING	32	/* Ops pending for lazy mmu mode exit */
> +#define TIF_LAZY_MMU_PENDING	31	/* Ops pending for lazy mmu mode exit */
>  
>  #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
>  #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)

LGTM.

Hence with or without the 'flags' changes in queue_pte_barriers() above.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

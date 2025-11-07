Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3534E2E975A;
	Fri,  7 Nov 2025 15:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762529341; cv=none; b=a5oAo0iE/W5gHptWRu79exao1bTtLdRdifF/xQ/sdeb1vKmivziDGHnLZ2tl8rS9zYUMxjsxZxUbbBBWb9uEpInAecre3Zt78o408JR9YK/uhr4q4vNAFtqf7C5hR3cIkx/nU29lKcd3JzmrKc3h5Y7gEWwOyTaVuJQjLjB2iDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762529341; c=relaxed/simple;
	bh=YPj/fFqT4Y9MTbunxGx8FiEuIZdgXuLkfK4mfJQFp2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SUk8JNfciQErUtHugRJUoDJu4qnBO84qdnhwTalPKKU2FGqNn7WB+roYvRsaGYFWhM0rNbko/Z3poFNTijLg8jDvYA92lcYpW/U1/CYGmkJn+vV9nCDJ1ZrePJwHqm2FeOitK6CLgN7zx5OWfDELPTusn0cYBwkF0uyzX0sXoNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55F981515;
	Fri,  7 Nov 2025 07:28:51 -0800 (PST)
Received: from [10.57.86.134] (unknown [10.57.86.134])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C13D3F694;
	Fri,  7 Nov 2025 07:28:54 -0800 (PST)
Message-ID: <06026ad7-fb85-4a78-ba70-7fa1f5bca0cd@arm.com>
Date: Fri, 7 Nov 2025 15:28:53 +0000
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/12] arm64: mm: replace TIF_LAZY_MMU with
 in_lazy_mmu_mode()
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
 <20251029100909.3381140-9-kevin.brodsky@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20251029100909.3381140-9-kevin.brodsky@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/10/2025 10:09, Kevin Brodsky wrote:
> The generic lazy_mmu layer now tracks whether a task is in lazy MMU
> mode. As a result we no longer need a TIF flag for that purpose -
> let's use the new in_lazy_mmu_mode() helper instead.
> 
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
> ---
>  arch/arm64/include/asm/pgtable.h     | 16 +++-------------
>  arch/arm64/include/asm/thread_info.h |  3 +--
>  2 files changed, 4 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 535435248923..61ca88f94551 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -62,30 +62,21 @@ static inline void emit_pte_barriers(void)
>  
>  static inline void queue_pte_barriers(void)
>  {
> -	unsigned long flags;
> -
>  	if (in_interrupt()) {
>  		emit_pte_barriers();
>  		return;
>  	}
>  
> -	flags = read_thread_flags();
> -
> -	if (flags & BIT(TIF_LAZY_MMU)) {
> -		/* Avoid the atomic op if already set. */
> -		if (!(flags & BIT(TIF_LAZY_MMU_PENDING)))
> -			set_thread_flag(TIF_LAZY_MMU_PENDING);
> -	} else {
> +	if (in_lazy_mmu_mode())
> +		test_and_set_thread_flag(TIF_LAZY_MMU_PENDING);

This removes the optimization to only do the atomic set operation if the bit is
not already set. I think that should remain.

> +	else
>  		emit_pte_barriers();
> -	}
>  }
>  
>  static inline void arch_enter_lazy_mmu_mode(void)
>  {
>  	if (in_interrupt())
>  		return;

Why are you keeping this test? Surely it can go?

> -
> -	set_thread_flag(TIF_LAZY_MMU);
>  }
>  
>  static inline void arch_flush_lazy_mmu_mode(void)
> @@ -103,7 +94,6 @@ static inline void arch_leave_lazy_mmu_mode(void)
>  		return;
>  
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


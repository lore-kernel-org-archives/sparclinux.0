Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6CC11CBA;
	Mon,  3 Nov 2025 16:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762186529; cv=none; b=PvRTcHGk9dO0S2x1KSPktnhBJ/ry9Q0jlZxkA4g1GKEdggWnvx1XCR86QP1wNYtXW+k7BhNbGBV5HxiLYscGfESWOOM6/Jj1E32bHxvRArbNiZa9Uuo4kgjRQtfpTlMhuL0JFOp02yvIagBYcQ01A/L6dAgkuSCgz0i/+8lN4tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762186529; c=relaxed/simple;
	bh=S0YKJr0SoBmysmz8IMr3QugNjlhYpJzfR41WjPWBUB4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kIRs71AkCt5FUPjdQSr82rU9toT6PYHuxrwDA8rI/Tl+hXp0Io1SPJMYgo3wx0XJh6VhFRNABIPX1T3ADUWHH8ph7FiZCCIJp3s3iRrTj9ONH5WHDnSUE7wtZCXpIBV52m2z9p1gGhOSEaPC1hNUZKo3GJRJGUlwmcpJG/gCcNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pMmG9L/w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pMmG9L/w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22BE5C4CEE7;
	Mon,  3 Nov 2025 16:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762186529;
	bh=S0YKJr0SoBmysmz8IMr3QugNjlhYpJzfR41WjPWBUB4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pMmG9L/wSj8xOcK/DzcO7x+pUKpbN+kaGWRhPKGT/hFa2p/Ay8Nl1Mzz1ZWUyScDa
	 vucJ0XbF6T0spIoI3AD/0qxqWiVKMh+Mmks24qxQFDpKZf3Zexx64cDs61lCh6Efy6
	 od0TqupiK1VEnDg7glIHKRlBc357kZIMtV/jM6SD3qxje1H7u2r4taFzH3oyOWmxWM
	 hHnL2j3jQ8KEJexQD4wpbJBjPfYdQst+gwFFqah20VMhXD96dyPMbnm/scOYZnijeO
	 WcP/Ww9iS8dXs6EdOUxwooqxO/I0VbjvAaMNzv31ZZN/WtGdcK9zJR5blHKdrg4t/9
	 0WafEdG9rsGng==
Message-ID: <c7c8a233-2103-4b48-b65e-ec81666d20e4@kernel.org>
Date: Mon, 3 Nov 2025 17:15:18 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/12] x86/xen: use lazy_mmu_state when
 context-switching
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
 Peter Zijlstra <peterz@infradead.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner
 <tglx@linutronix.de>, Vlastimil Babka <vbabka@suse.cz>,
 Will Deacon <will@kernel.org>, Yeoreum Yun <yeoreum.yun@arm.com>,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org
References: <20251029100909.3381140-1-kevin.brodsky@arm.com>
 <20251029100909.3381140-12-kevin.brodsky@arm.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251029100909.3381140-12-kevin.brodsky@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.10.25 11:09, Kevin Brodsky wrote:
> We currently set a TIF flag when scheduling out a task that is in
> lazy MMU mode, in order to restore it when the task is scheduled
> again.
> 
> The generic lazy_mmu layer now tracks whether a task is in lazy MMU
> mode in task_struct::lazy_mmu_state. We can therefore check that
> state when switching to the new task, instead of using a separate
> TIF flag.
> 
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
> ---
>   arch/x86/include/asm/thread_info.h | 4 +---
>   arch/x86/xen/enlighten_pv.c        | 3 +--
>   2 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
> index e71e0e8362ed..0067684afb5b 100644
> --- a/arch/x86/include/asm/thread_info.h
> +++ b/arch/x86/include/asm/thread_info.h
> @@ -100,8 +100,7 @@ struct thread_info {
>   #define TIF_FORCED_TF		24	/* true if TF in eflags artificially */
>   #define TIF_SINGLESTEP		25	/* reenable singlestep on user return*/
>   #define TIF_BLOCKSTEP		26	/* set when we want DEBUGCTLMSR_BTF */
> -#define TIF_LAZY_MMU_UPDATES	27	/* task is updating the mmu lazily */
> -#define TIF_ADDR32		28	/* 32-bit address space on 64 bits */
> +#define TIF_ADDR32		27	/* 32-bit address space on 64 bits */
>   
>   #define _TIF_SSBD		BIT(TIF_SSBD)
>   #define _TIF_SPEC_IB		BIT(TIF_SPEC_IB)
> @@ -114,7 +113,6 @@ struct thread_info {
>   #define _TIF_FORCED_TF		BIT(TIF_FORCED_TF)
>   #define _TIF_BLOCKSTEP		BIT(TIF_BLOCKSTEP)
>   #define _TIF_SINGLESTEP		BIT(TIF_SINGLESTEP)
> -#define _TIF_LAZY_MMU_UPDATES	BIT(TIF_LAZY_MMU_UPDATES)
>   #define _TIF_ADDR32		BIT(TIF_ADDR32)
>   
>   /* flags to check in __switch_to() */
> diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
> index 4806cc28d7ca..f40f5999352e 100644
> --- a/arch/x86/xen/enlighten_pv.c
> +++ b/arch/x86/xen/enlighten_pv.c
> @@ -426,7 +426,6 @@ static void xen_start_context_switch(struct task_struct *prev)
>   
>   	if (this_cpu_read(xen_lazy_mode) == XEN_LAZY_MMU) {
>   		arch_leave_lazy_mmu_mode();
> -		set_ti_thread_flag(task_thread_info(prev), TIF_LAZY_MMU_UPDATES);
>   	}
>   	enter_lazy(XEN_LAZY_CPU);
>   }
> @@ -437,7 +436,7 @@ static void xen_end_context_switch(struct task_struct *next)
>   
>   	xen_mc_flush();
>   	leave_lazy(XEN_LAZY_CPU);
> -	if (test_and_clear_ti_thread_flag(task_thread_info(next), TIF_LAZY_MMU_UPDATES))
> +	if (next->lazy_mmu_state.active)

This is nasty. If in_lazy_mmu_mode() is not sufficient, we will want to 
have a separate helper that makes it clear what the difference between 
both variants is.


-- 
Cheers

David

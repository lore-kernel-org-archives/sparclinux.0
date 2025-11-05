Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394C82222CB
	for <sparclinux@vger.kernel.org>; Wed,  5 Nov 2025 02:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762311319; cv=none; b=Ek79oFg2b11UA33FYZlV+SlnpOHDE1f2+2mGSgOPF1ViBYYjZ9YxpRGPA0OdnN//JikqmHZuCoI+xsICizVRid9iXWH8x+0nwA0gWyAvUHbV5QB+5I/ei1yw25Gu4xS9cHZCbHh+Zuhm/EnDrqFo1/kp+/SPeEHeZZT3R4OS3H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762311319; c=relaxed/simple;
	bh=rkO2Yspx/oAGhWJycTuPZ1CZiQCqrc9YcX1q9+omYEA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=YJAo7ovG5vdw8KfTgcC3Qur+t+8B/Nv6iYCEzMJ/bWYF5oLvNA9ZqwVa/baEjxz5EtTUg1eWj1C6OqSvsnqye1fgimGbC5Mx11oAWqwZR3EdCiaG8s2W/LzJMr7bF+keA8IS+CMk6cHDBLm4Ms/wxYWzAC5z+7zGN6EG8iBMTxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ItAc5J/9; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ItAc5J/9"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-29570bcf220so44582875ad.3
        for <sparclinux@vger.kernel.org>; Tue, 04 Nov 2025 18:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762311317; x=1762916117; darn=vger.kernel.org;
        h=mime-version:references:message-id:date:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=RzRgxKaFFDli8ftuhQFfyH2ObKCMh7+2PDYIIzQvueg=;
        b=ItAc5J/9oOOo4X6ReVED7moF5N+INunHILgjV8ulSa68FrFis7qvkGzK6TDhJPtWOA
         8gcRVCo4bJR3m2EM2KeDYetxd72fdll5bDIozGuXjN1D3z0TaKw0Rc/ksaiIubQC00wV
         nNZAUontGG+nZ985AGDCyvyK/yaBKkNcSqFVczLy2k7UcATBoKyeH+kmAAwJomhIj59g
         BmKyTPI9EfGLoOEUPDOw9bPc6ThUtrpAviuAYZZ7ojVWCoYN6RAsk/iMpMHEwnw8afHK
         1GEST6KdK8mdpoDlfEVaYan75StU3PXGg1DhJpsRJ7c1cpr6rCotxtF/MD7T/7+ewCQf
         iemw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762311317; x=1762916117;
        h=mime-version:references:message-id:date:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RzRgxKaFFDli8ftuhQFfyH2ObKCMh7+2PDYIIzQvueg=;
        b=sPiz9onsL/74DOJeFoK/W7HxwfY9/gTgBLoB0k8BfY97LJo4lPrkUFgdlDA5xVa18r
         0vD91ZCgA1JaNJd04NuK+ROHW9Hc4PFyCRhaRyXs5Nzd+jd4dVZyw5Z7ex7V8/eXAwXj
         +8zxt+CgbYXlQ4xNm+duLcTlM0AKefrk72kkYxWX8M7lvhq8WCtbCLPq4zSinLC+ZCX4
         YRiFZSgILOqQr26XxvMYLs01gVjMkGyfBXv+c+r0z7TLRozC50xQHFmuQcxr454XDRA6
         8xmnjHywhrDZ+OSxMlHRj6hPnDIUMdfTYgbR/uXiqB1kuHV3FYWuftoYpwSGi8nU3n/T
         WgyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMB/G+QWeefDCIJQUl4ZpfGutM0L1cuWqdUhS/BYG4hdtAVK1CHdw7zXKeTWpqz2Sjsy3lw8VdeYG3@vger.kernel.org
X-Gm-Message-State: AOJu0YzF+rGCebGfpxd4aRDYPj9VSQOhJSd8HbmDd2iXtz822Nv5clXp
	3P3SXF40kLOX8di0kSf2gcuJtUdRwAInpAEKwZ/cT/9pZ0vMEgCMoHSB
X-Gm-Gg: ASbGnctv4qZ81K5Edcu+FK8bEWZ04HhWHXvTAZwg9xLNk09C+H6HqFb3PafYjhQkg82
	ix9k7WpIYr0GXJeb6FJ1TTpAFnCmJgwUzThimecOZonaLxUUs6x7xukCQ+zOiSmyAZPLPb0N8d1
	5oYMerNy4FSXYkX2NJpJ/E+GonNS4biiHg5lMXj64zsa/gsxcs5+88qARQv74w5AWQ6JqNZJLVO
	6HVSX/c94Goe4ENnBS0vBpgCZ6Q3g7I2hAxpApqj+42zXwoVGlhSHnaUlvMXU+NVPV5yDj9KetU
	/NDRhmPgV5vIEJoWcu1VzjWypTF0lgpCo9tGjwO4/E0D+j+llKny0PunFJ7McEf0QaHDJTzlwBG
	L7ujNZ6T7ISV+W3CsRjyqCt5rY2UDrsxVMVHwyXcsiAtGGN6x19KTSVLaL2vciX5yFK259Q==
X-Google-Smtp-Source: AGHT+IGwTm7URkxWPNS/uaQT82VrA80foZj+Jgsm9GWgCIbhw60EG5vfai2y+vo+uSLgfxHG3bwlGg==
X-Received: by 2002:a17:903:3c4b:b0:293:33b:a9b0 with SMTP id d9443c01a7336-2962ae10998mr22075795ad.32.1762311317247;
        Tue, 04 Nov 2025 18:55:17 -0800 (PST)
Received: from dw-tp ([171.76.85.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601b8f28esm43621645ad.5.2025.11.04.18.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 18:55:16 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Kevin Brodsky <kevin.brodsky@arm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Andreas Larsson <andreas@gaisler.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Dave Hansen <dave.hansen@linux.intel.com>, 
	David Hildenbrand <david@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	David Woodhouse <dwmw2@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, 
	Jann Horn <jannh@google.com>, Juergen Gross <jgross@suse.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>, 
	Mike Rapoport <rppt@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@linutronix.de>, Vlastimil Babka <vbabka@suse.cz>, 
	Will Deacon <will@kernel.org>, Yeoreum Yun <yeoreum.yun@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: Re: [PATCH v4 01/12] powerpc/64s: Do not re-activate batched TLB flush
In-Reply-To: <20251029100909.3381140-2-kevin.brodsky@arm.com>
Date: Wed, 05 Nov 2025 08:16:58 +0530
Message-ID: <87qzud42n1.ritesh.list@gmail.com>
References: <20251029100909.3381140-1-kevin.brodsky@arm.com> <20251029100909.3381140-2-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kevin Brodsky <kevin.brodsky@arm.com> writes:

> From: Alexander Gordeev <agordeev@linux.ibm.com>
>
> Since commit b9ef323ea168 ("powerpc/64s: Disable preemption in hash
> lazy mmu mode") a task can not be preempted while in lazy MMU mode.
> Therefore, the batch re-activation code is never called, so remove it.
>
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
> ---
>  arch/powerpc/include/asm/thread_info.h |  2 --
>  arch/powerpc/kernel/process.c          | 25 -------------------------
>  2 files changed, 27 deletions(-)
>

Since the commit referenced in above disables the preemption in
arch_enter_lazy_mmu(), so the expectation is that we will never be
context switched while in lazy_mmu, hence the code changes in
switch_to() around __flush_tlb_pending() should ideally never be called.

With this analysis - the patch looks good to me. I will give this entire
patch series a try on Power HW with Hash mmu too (which uses lazy mmu and
let you know the results of that)!

For this patch please feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


CC: Venkat who also runs CI on linux Power HW for upstream testing :)

-ritesh


> diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
> index b0f200aba2b3..97f35f9b1a96 100644
> --- a/arch/powerpc/include/asm/thread_info.h
> +++ b/arch/powerpc/include/asm/thread_info.h
> @@ -154,12 +154,10 @@ void arch_setup_new_exec(void);
>  /* Don't move TLF_NAPPING without adjusting the code in entry_32.S */
>  #define TLF_NAPPING		0	/* idle thread enabled NAP mode */
>  #define TLF_SLEEPING		1	/* suspend code enabled SLEEP mode */
> -#define TLF_LAZY_MMU		3	/* tlb_batch is active */
>  #define TLF_RUNLATCH		4	/* Is the runlatch enabled? */
>  
>  #define _TLF_NAPPING		(1 << TLF_NAPPING)
>  #define _TLF_SLEEPING		(1 << TLF_SLEEPING)
> -#define _TLF_LAZY_MMU		(1 << TLF_LAZY_MMU)
>  #define _TLF_RUNLATCH		(1 << TLF_RUNLATCH)
>  
>  #ifndef __ASSEMBLER__
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index eb23966ac0a9..9237dcbeee4a 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -1281,9 +1281,6 @@ struct task_struct *__switch_to(struct task_struct *prev,
>  {
>  	struct thread_struct *new_thread, *old_thread;
>  	struct task_struct *last;
> -#ifdef CONFIG_PPC_64S_HASH_MMU
> -	struct ppc64_tlb_batch *batch;
> -#endif
>  
>  	new_thread = &new->thread;
>  	old_thread = &current->thread;
> @@ -1291,14 +1288,6 @@ struct task_struct *__switch_to(struct task_struct *prev,
>  	WARN_ON(!irqs_disabled());
>  
>  #ifdef CONFIG_PPC_64S_HASH_MMU
> -	batch = this_cpu_ptr(&ppc64_tlb_batch);
> -	if (batch->active) {
> -		current_thread_info()->local_flags |= _TLF_LAZY_MMU;
> -		if (batch->index)
> -			__flush_tlb_pending(batch);
> -		batch->active = 0;
> -	}
> -
>  	/*
>  	 * On POWER9 the copy-paste buffer can only paste into
>  	 * foreign real addresses, so unprivileged processes can not
> @@ -1369,20 +1358,6 @@ struct task_struct *__switch_to(struct task_struct *prev,
>  	 */
>  
>  #ifdef CONFIG_PPC_BOOK3S_64
> -#ifdef CONFIG_PPC_64S_HASH_MMU
> -	/*
> -	 * This applies to a process that was context switched while inside
> -	 * arch_enter_lazy_mmu_mode(), to re-activate the batch that was
> -	 * deactivated above, before _switch(). This will never be the case
> -	 * for new tasks.
> -	 */
> -	if (current_thread_info()->local_flags & _TLF_LAZY_MMU) {
> -		current_thread_info()->local_flags &= ~_TLF_LAZY_MMU;
> -		batch = this_cpu_ptr(&ppc64_tlb_batch);
> -		batch->active = 1;
> -	}
> -#endif
> -
>  	/*
>  	 * Math facilities are masked out of the child MSR in copy_thread.
>  	 * A new task does not need to restore_math because it will
> -- 
> 2.47.0

From: Kirill Tkhai <tkhai@yandex.ru>
Date: Tue, 11 Feb 2014 21:13:39 +0000
Subject: Re: [PATCH 3/4] sparc64: convert spinlock_t to raw_spinlock_t in  mmu_context_t
Message-Id: <341392153219@web17g.yandex.ru>
List-Id: <sparclinux.vger.kernel.org>
References: <1388980510-10190-1-git-send-email-allen.pais@oracle.com> <1388980510-10190-4-git-send-email-allen.pais@oracle.com>
In-Reply-To: <1388980510-10190-4-git-send-email-allen.pais@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Allen Pais <allen.pais@oracle.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, "bigeasy@linutronix.de" <bigeasy@linutronix.de>



06.01.2014, 07:56, "Allen Pais" <allen.pais@oracle.com>:
> In the attempt of get PREEMPT_RT working on sparc64 using
> linux-stable-rt version 3.10.22-rt19+, the kernel crash
> with the following trace:
>
> [ 1487.027884] I7: <rt_mutex_setprio+0x3c/0x2c0>
> [ 1487.027885] Call Trace:
> [ 1487.027887] =9A[00000000004967dc] rt_mutex_setprio+0x3c/0x2c0
> [ 1487.027892] =9A[00000000004afe20] task_blocks_on_rt_mutex+0x180/0x200
> [ 1487.027895] =9A[0000000000819114] rt_spin_lock_slowlock+0x94/0x300
> [ 1487.027897] =9A[0000000000817ebc] __schedule+0x39c/0x53c
> [ 1487.027899] =9A[00000000008185fc] schedule+0x1c/0xc0
> [ 1487.027908] =9A[000000000048fff4] smpboot_thread_fn+0x154/0x2e0
> [ 1487.027913] =9A[000000000048753c] kthread+0x7c/0xa0
> [ 1487.027920] =9A[00000000004060c4] ret_from_syscall+0x1c/0x2c
> [ 1487.027922] =9A[0000000000000000] =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A(null)
>
> Thomas debugged this issue and pointed to switch_mm
>
> =9A=9A=9A=9A=9A=9A=9A=9Aspin_lock_irqsave(&mm->context.lock, flags);
>
> context.lock needs to be a raw_spinlock.
>
> Acked-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Allen Pais <allen.pais@oracle.com>
> ---
> =9Aarch/sparc/include/asm/mmu_64.h =9A=9A=9A=9A=9A=9A=9A=9A| =9A=9A=9A2 +-
> =9Aarch/sparc/include/asm/mmu_context_64.h | =9A=9A=9A8 ++++----
> =9Aarch/sparc/kernel/smp_64.c =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A| =
=9A=9A=9A4 ++--
> =9Aarch/sparc/mm/init_64.c =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=
=9A| =9A=9A=9A4 ++--
> =9Aarch/sparc/mm/tsb.c =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=
=9A=9A=9A=9A| =9A=9A16 ++++++++--------
> =9A5 files changed, 17 insertions(+), 17 deletions(-)
>
> diff --git a/arch/sparc/include/asm/mmu_64.h b/arch/sparc/include/asm/mmu=
_64.h
> index 76092c4..e945ddb 100644
> --- a/arch/sparc/include/asm/mmu_64.h
> +++ b/arch/sparc/include/asm/mmu_64.h
> @@ -90,7 +90,7 @@ struct tsb_config {
> =9A#endif
>
> =9Atypedef struct {
> - spinlock_t lock;
> + raw_spinlock_t lock;
> =9A=9A=9A=9A=9A=9A=9A=9A=9Aunsigned long sparc64_ctx_val;
> =9A=9A=9A=9A=9A=9A=9A=9A=9Aunsigned long huge_pte_count;
> =9A=9A=9A=9A=9A=9A=9A=9A=9Astruct page *pgtable_page;
> diff --git a/arch/sparc/include/asm/mmu_context_64.h b/arch/sparc/include=
/asm/mmu_context_64.h
> index 3d528f0..3a85624 100644
> --- a/arch/sparc/include/asm/mmu_context_64.h
> +++ b/arch/sparc/include/asm/mmu_context_64.h
> @@ -77,7 +77,7 @@ static inline void switch_mm(struct mm_struct *old_mm, =
struct mm_struct *mm, str
> =9A=9A=9A=9A=9A=9A=9A=9A=9Aif (unlikely(mm =3D &init_mm))
> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9Areturn;
>
> - spin_lock_irqsave(&mm->context.lock, flags);
> + raw_spin_lock_irqsave(&mm->context.lock, flags);
> =9A=9A=9A=9A=9A=9A=9A=9A=9Actx_valid =3D CTX_VALID(mm->context);
> =9A=9A=9A=9A=9A=9A=9A=9A=9Aif (!ctx_valid)
> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9Aget_new_mmu_context(mm=
);
> @@ -125,7 +125,7 @@ static inline void switch_mm(struct mm_struct *old_mm=
, struct mm_struct *mm, str
> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A__flush_tlb_mm(CTX_HWB=
ITS(mm->context),
> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=
=9A=9A=9A=9A=9A=9A=9A=9ASECONDARY_CONTEXT);
> =9A=9A=9A=9A=9A=9A=9A=9A=9A}
> - spin_unlock_irqrestore(&mm->context.lock, flags);
> + raw_spin_unlock_irqrestore(&mm->context.lock, flags);
> =9A}
>
> =9A#define deactivate_mm(tsk,mm) do { } while (0)
> @@ -136,7 +136,7 @@ static inline void activate_mm(struct mm_struct *acti=
ve_mm, struct mm_struct *mm
> =9A=9A=9A=9A=9A=9A=9A=9A=9Aunsigned long flags;
> =9A=9A=9A=9A=9A=9A=9A=9A=9Aint cpu;
>
> - spin_lock_irqsave(&mm->context.lock, flags);
> + raw_spin_lock_irqsave(&mm->context.lock, flags);
> =9A=9A=9A=9A=9A=9A=9A=9A=9Aif (!CTX_VALID(mm->context))
> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9Aget_new_mmu_context(mm=
);
> =9A=9A=9A=9A=9A=9A=9A=9A=9Acpu =3D smp_processor_id();
> @@ -146,7 +146,7 @@ static inline void activate_mm(struct mm_struct *acti=
ve_mm, struct mm_struct *mm
> =9A=9A=9A=9A=9A=9A=9A=9A=9Aload_secondary_context(mm);
> =9A=9A=9A=9A=9A=9A=9A=9A=9A__flush_tlb_mm(CTX_HWBITS(mm->context), SECOND=
ARY_CONTEXT);
> =9A=9A=9A=9A=9A=9A=9A=9A=9Atsb_context_switch(mm);
> - spin_unlock_irqrestore(&mm->context.lock, flags);
> + raw_spin_unlock_irqrestore(&mm->context.lock, flags);
> =9A}
>
> =9A#endif /* !(__ASSEMBLY__) */
> diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
> index 77539ed..f42e1a7 100644
> --- a/arch/sparc/kernel/smp_64.c
> +++ b/arch/sparc/kernel/smp_64.c
> @@ -975,12 +975,12 @@ void __irq_entry smp_new_mmu_context_version_client=
(int irq, struct pt_regs *reg
> =9A=9A=9A=9A=9A=9A=9A=9A=9Aif (unlikely(!mm || (mm =3D &init_mm)))
> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9Areturn;
>
> - spin_lock_irqsave(&mm->context.lock, flags);
> + raw_spin_lock_irqsave(&mm->context.lock, flags);
>
> =9A=9A=9A=9A=9A=9A=9A=9A=9Aif (unlikely(!CTX_VALID(mm->context)))
> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9Aget_new_mmu_context(mm=
);
>
> - spin_unlock_irqrestore(&mm->context.lock, flags);
> + raw_spin_unlock_irqrestore(&mm->context.lock, flags);
>
> =9A=9A=9A=9A=9A=9A=9A=9A=9Aload_secondary_context(mm);
> =9A=9A=9A=9A=9A=9A=9A=9A=9A__flush_tlb_mm(CTX_HWBITS(mm->context),
> diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
> index 04fd55a..bd5253d 100644
> --- a/arch/sparc/mm/init_64.c
> +++ b/arch/sparc/mm/init_64.c
> @@ -350,7 +350,7 @@ void update_mmu_cache(struct vm_area_struct *vma, uns=
igned long address, pte_t *
>
> =9A=9A=9A=9A=9A=9A=9A=9A=9Amm =3D vma->vm_mm;
>
> - spin_lock_irqsave(&mm->context.lock, flags);
> + raw_spin_lock_irqsave(&mm->context.lock, flags);
>
> =9A#if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAG=
E)
> =9A=9A=9A=9A=9A=9A=9A=9A=9Aif (mm->context.huge_pte_count && is_hugetlb_p=
te(pte))
> @@ -361,7 +361,7 @@ void update_mmu_cache(struct vm_area_struct *vma, uns=
igned long address, pte_t *
> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A__update_mmu_tsb_inser=
t(mm, MM_TSB_BASE, PAGE_SHIFT,
> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=
=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9Aaddress, pte_val(pte));
>
> - spin_unlock_irqrestore(&mm->context.lock, flags);
> + raw_spin_unlock_irqrestore(&mm->context.lock, flags);
> =9A}

We also should do the same in update_mmu_cache_pmd().

>
> =9Avoid flush_dcache_page(struct page *page)
> diff --git a/arch/sparc/mm/tsb.c b/arch/sparc/mm/tsb.c
> index 2cc3bce..d84d4ea 100644
> --- a/arch/sparc/mm/tsb.c
> +++ b/arch/sparc/mm/tsb.c
> @@ -73,7 +73,7 @@ void flush_tsb_user(struct tlb_batch *tb)
> =9A=9A=9A=9A=9A=9A=9A=9A=9Astruct mm_struct *mm =3D tb->mm;
> =9A=9A=9A=9A=9A=9A=9A=9A=9Aunsigned long nentries, base, flags;
>
> - spin_lock_irqsave(&mm->context.lock, flags);
> + raw_spin_lock_irqsave(&mm->context.lock, flags);
>
> =9A=9A=9A=9A=9A=9A=9A=9A=9Abase =3D (unsigned long) mm->context.tsb_block=
[MM_TSB_BASE].tsb;
> =9A=9A=9A=9A=9A=9A=9A=9A=9Anentries =3D mm->context.tsb_block[MM_TSB_BASE=
].tsb_nentries;
> @@ -90,14 +90,14 @@ void flush_tsb_user(struct tlb_batch *tb)
> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A__flush_tsb_one(tb, HP=
AGE_SHIFT, base, nentries);
> =9A=9A=9A=9A=9A=9A=9A=9A=9A}
> =9A#endif
> - spin_unlock_irqrestore(&mm->context.lock, flags);
> + raw_spin_unlock_irqrestore(&mm->context.lock, flags);
> =9A}
>
> =9Avoid flush_tsb_user_page(struct mm_struct *mm, unsigned long vaddr)
> =9A{
> =9A=9A=9A=9A=9A=9A=9A=9A=9Aunsigned long nentries, base, flags;
>
> - spin_lock_irqsave(&mm->context.lock, flags);
> + raw_spin_lock_irqsave(&mm->context.lock, flags);
>
> =9A=9A=9A=9A=9A=9A=9A=9A=9Abase =3D (unsigned long) mm->context.tsb_block=
[MM_TSB_BASE].tsb;
> =9A=9A=9A=9A=9A=9A=9A=9A=9Anentries =3D mm->context.tsb_block[MM_TSB_BASE=
].tsb_nentries;
> @@ -114,7 +114,7 @@ void flush_tsb_user_page(struct mm_struct *mm, unsign=
ed long vaddr)
> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A__flush_tsb_one_entry(=
base, vaddr, HPAGE_SHIFT, nentries);
> =9A=9A=9A=9A=9A=9A=9A=9A=9A}
> =9A#endif
> - spin_unlock_irqrestore(&mm->context.lock, flags);
> + raw_spin_unlock_irqrestore(&mm->context.lock, flags);
> =9A}
>
> =9A#define HV_PGSZ_IDX_BASE HV_PGSZ_IDX_8K
> @@ -392,7 +392,7 @@ retry_tsb_alloc:
> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A* the lock and ask all other cpus running t=
his address space
> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A* to run tsb_context_switch() to see the ne=
w TSB table.
> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A*/
> - spin_lock_irqsave(&mm->context.lock, flags);
> + raw_spin_lock_irqsave(&mm->context.lock, flags);
>
> =9A=9A=9A=9A=9A=9A=9A=9A=9Aold_tsb =3D mm->context.tsb_block[tsb_index].t=
sb;
> =9A=9A=9A=9A=9A=9A=9A=9A=9Aold_cache_index > @@ -407,7 +407,7 @@ retry_ts=
b_alloc:
> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A*/
> =9A=9A=9A=9A=9A=9A=9A=9A=9Aif (unlikely(old_tsb &&
> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A(rss < =
mm->context.tsb_block[tsb_index].tsb_rss_limit))) {
> - spin_unlock_irqrestore(&mm->context.lock, flags);
> + raw_spin_unlock_irqrestore(&mm->context.lock, flags);
>
> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9Akmem_cache_free(tsb_ca=
ches[new_cache_index], new_tsb);
> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9Areturn;
> @@ -433,7 +433,7 @@ retry_tsb_alloc:
> =9A=9A=9A=9A=9A=9A=9A=9A=9Amm->context.tsb_block[tsb_index].tsb =3D new_t=
sb;
> =9A=9A=9A=9A=9A=9A=9A=9A=9Asetup_tsb_params(mm, tsb_index, new_size);
>
> - spin_unlock_irqrestore(&mm->context.lock, flags);
> + raw_spin_unlock_irqrestore(&mm->context.lock, flags);
>
> =9A=9A=9A=9A=9A=9A=9A=9A=9A/* If old_tsb is NULL, we're being invoked for=
 the first time
> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A* from init_new_context().
> @@ -459,7 +459,7 @@ int init_new_context(struct task_struct *tsk, struct =
mm_struct *mm)
> =9A#endif
> =9A=9A=9A=9A=9A=9A=9A=9A=9Aunsigned int i;
>
> - spin_lock_init(&mm->context.lock);
> + raw_spin_lock_init(&mm->context.lock);
>
> =9A=9A=9A=9A=9A=9A=9A=9A=9Amm->context.sparc64_ctx_val =3D 0UL;
>
> --
> 1.7.10.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =9Ahttp://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =9Ahttp://www.tux.org/lkml/

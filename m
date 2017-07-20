From: jane.chu@oracle.com
Date: Thu, 20 Jul 2017 23:42:18 +0000
Subject: Re: [PATCH] arch/sparc: Measure receiver forward progress to avoid send mondo timeout
Message-Id: <2aadd99e-af2a-b5cc-7f37-e57310f32712@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1498683746-623218-1-git-send-email-jane.chu@oracle.com>
In-Reply-To: <1498683746-623218-1-git-send-email-jane.chu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On 07/19/2017 08:23 PM, David Miller wrote:

> From: David Miller <davem@davemloft.net>
> Date: Tue, 18 Jul 2017 11:39:43 -0700 (PDT)
>
>> From: jane.chu@oracle.com
>> Date: Mon, 17 Jul 2017 15:11:03 -0700
>>
>>> Thanks for digging in.  I will try your patch to  gather what I could
>>> share the data.
>> So, further inspection shows that we limit batches to 192 entries so
>> we will never see the full extent of an unmap in the statistics for
>> large operations.
> What follows is a rough attempt to mitigate the TLB flush overhead a
> little bit, I've kept the statistics gathering in there for now.
>
> The initial heuristic is that if we fill up an entire TLB batch, we
> switch to a full TLB context flush, which we will perform at the end
> of the high level unmap operation (several more batch fills can happen
> until then).
>
> Maybe the cut-off should be even lower, I don't know.
>
> One major aspect, which we've been discussing, is that this keeps us
> from doing multiple expensive mondo's to remote cpus during the unmap.
> We just do one cheap one, for the TLB context flush.  Therefore,
> qnother thing that comes to mind is that if the MM has only executed
> on the local cpu, we won't end up doing remote mondos, so maybe the
> cut-off can be a bit higher in that case.
>
> We still flush the TSB entries one-by-one, but that always only occurs
> on the local cpu.  It is possible to improve this as well, but we'd
> need to keep track of a range.
>
> If you look in the kernel TSB flushing, we have an optimization in the
> range flushing case.  If the range is too large, we don't probe,
> instead we scan the TSB from beginning to end, and do range
> comparisons on the virtual address in the TAG.
>
> So the idea is that we maintain a "lowest" and "highest" address in
> the TLB batch structure, and if the number of batch entries get large
> we go into a TSB scan mode.
>
> Integrating the TSB part into this is not easy.  The trouble is that
> the cut-off for going to TSB scan mode needs to be a lot larger than
> the one used for entering TLB context flush mode.  This is especially
> the case because of how we dynamically grow the TSB based roughly upon
> the thread's resident set size.
>
> Anyways, patch follows...

I applied the patch on top the v4.13-rc1-25, tried it on a M8 with 2K=20
cpus online.
After boot up,  cat /proc/cpuinfo shows

ncpus active    : 2048
D$ parity tl1   : 0
I$ parity tl1   : 0
TLB PENDING     : Total 738958 MM 6122 [551489 82738 34578 24007 22278=20
5895 5234 11163 6122]

1:              551489
2:              82738
4:              34578
8:              24007
16:            22278
32:            5895
64:            5234
128:          11163
256:          6122

While I get a map-unmap test ready to run,  I noticed  the "rcu_sched=20
kthread starved"
problem -

INFO: rcu_sched detected stalls on CPUs/tasks:
         0-...: (2382 GPs behind) idle=AB0/0/0 softirqf4/666 fqs=3D0
         1-...: (3003 GPs behind) idle=870/0/0 softirqV1/563 fqs=3D0
<repeat>
         2046-...: (3598 GPs behind) idle:4/0/0 softirq$/24 fqs=3D0
         2047-...: (3629 GPs behind) idle50/0/0 softirq!/23 fqs=3D0

         (detected by 512, t=15007 jiffies, g751, c750, q"9)
   CPU[  0]: TSTATE[0000000080001600] TPC[000000000042d83c]=20
TNPC[000000000042d840] TASK[swapper/0:0]
              TPC[arch_cpu_idle+0x7c/0xa0] O7[arch_cpu_idle+0x68/0xa0]=20
I7[default_idle_call+0x28/0x60] RPC[cpuidle_idle_call+0x24/0xa0]
<repeat>
   CPU[2047]: TSTATE[0000000080001606] TPC[000000000042d83c]=20
TNPC[000000000042d840] TASK[swapper/2047:0]
              TPC[arch_cpu_idle+0x7c/0xa0] O7[arch_cpu_idle+0x68/0xa0]=20
I7[default_idle_call+0x28/0x60] RPC[cpuidle_idle_call+0x24/0xa0]
rcu_sched kthread starved for 16726 jiffies! g3751 c3750 f0x0=20
RCU_GP_WAIT_FQS(3) ->state=3D0x1
rcu_sched       S    0     9      2 0x06000000
Call Trace:
  [0000000000aa8004] schedule+0x24/0xc0
  [0000000000aab864] schedule_timeout+0x1a4/0x320
  [00000000004d9a24] rcu_gp_kthread+0x284/0x460
  [00000000004908ec] kthread+0xec/0x140
  [0000000000406064] ret_from_fork+0x1c/0x2c
  [0000000000000000]           (null)

The "rcu_sched kthread starved" problem wasn't seen  in v4.12 when I=20
tested my
patch.  I'm not sure how your patch could have anything to do with it,=20
so I will try the
bare v4.13-rc1-25 kernel without your patch and see what happens.

I also plan to get hold of a large M6 that doesn't have the HW demap=20
features
and try it there.

thanks,
-jane
>
> diff --git a/arch/sparc/include/asm/tlb_64.h b/arch/sparc/include/asm/tlb=
_64.h
> index 4cb392f..8cf3f45 100644
> --- a/arch/sparc/include/asm/tlb_64.h
> +++ b/arch/sparc/include/asm/tlb_64.h
> @@ -7,6 +7,14 @@
>   #include <asm/tlbflush.h>
>   #include <asm/mmu_context.h>
>  =20
> +#define TLB_PENDING_STATS_SLOTS		9
> +struct tlb_pending_stats {
> +	unsigned long total;
> +	unsigned long num_force_mm_flush;
> +	unsigned long hist[TLB_PENDING_STATS_SLOTS];
> +};
> +extern struct tlb_pending_stats tpstats;
> +
>   #ifdef CONFIG_SMP
>   void smp_flush_tlb_pending(struct mm_struct *,
>   				  unsigned long, unsigned long *);
> diff --git a/arch/sparc/include/asm/tlbflush_64.h b/arch/sparc/include/as=
m/tlbflush_64.h
> index 54be88a..b29e170 100644
> --- a/arch/sparc/include/asm/tlbflush_64.h
> +++ b/arch/sparc/include/asm/tlbflush_64.h
> @@ -11,6 +11,7 @@ struct tlb_batch {
>   	unsigned int hugepage_shift;
>   	struct mm_struct *mm;
>   	unsigned long tlb_nr;
> +	unsigned long force_mm_flush;
>   	unsigned long active;
>   	unsigned long vaddrs[TLB_BATCH_NR];
>   };
> diff --git a/arch/sparc/kernel/cpu.c b/arch/sparc/kernel/cpu.c
> index 493e023..8ed7467 100644
> --- a/arch/sparc/kernel/cpu.c
> +++ b/arch/sparc/kernel/cpu.c
> @@ -20,6 +20,7 @@
>   #include <asm/psr.h>
>   #include <asm/mbus.h>
>   #include <asm/cpudata.h>
> +#include <asm/tlb.h>
>  =20
>   #include "kernel.h"
>   #include "entry.h"
> @@ -378,6 +379,7 @@ static int show_cpuinfo(struct seq_file *m, void *__u=
nused)
>   		   "ncpus active\t: %d\n"
>   		   "D$ parity tl1\t: %u\n"
>   		   "I$ parity tl1\t: %u\n"
> +		   "TLB PENDING\t: Total %lu MM %lu [%lu %lu %lu %lu %lu %lu %lu %lu %=
lu]\n"
>   #ifndef CONFIG_SMP
>   		   "Cpu0ClkTck\t: %016lx\n"
>   #endif
> @@ -392,7 +394,11 @@ static int show_cpuinfo(struct seq_file *m, void *__=
unused)
>   		   ncpus_probed,
>   		   num_online_cpus(),
>   		   dcache_parity_tl1_occurred,
> -		   icache_parity_tl1_occurred
> +		   icache_parity_tl1_occurred,
> +		   tpstats.total, tpstats.num_force_mm_flush,
> +		   tpstats.hist[0], tpstats.hist[1], tpstats.hist[2], tpstats.hist[3],
> +		   tpstats.hist[4], tpstats.hist[5], tpstats.hist[6], tpstats.hist[7],
> +		   tpstats.hist[8]
>   #ifndef CONFIG_SMP
>   		   , cpu_data(0).clock_tick
>   #endif
> diff --git a/arch/sparc/mm/tlb.c b/arch/sparc/mm/tlb.c
> index ee8066c..eaf61e3 100644
> --- a/arch/sparc/mm/tlb.c
> +++ b/arch/sparc/mm/tlb.c
> @@ -19,16 +19,30 @@
>   /* Heavily inspired by the ppc64 code.  */
>  =20
>   static DEFINE_PER_CPU(struct tlb_batch, tlb_batch);
> +struct tlb_pending_stats tpstats;
>  =20
>   void flush_tlb_pending(void)
>   {
>   	struct tlb_batch *tb =3D &get_cpu_var(tlb_batch);
>   	struct mm_struct *mm =3D tb->mm;
> +	u32 slot =3D tb->tlb_nr;
>  =20
>   	if (!tb->tlb_nr)
>   		goto out;
>  =20
> +	tpstats.total++;
> +	if (slot =3D TLB_BATCH_NR) {
> +		slot =3D 8;
> +	} else {
> +		slot =3D ilog2(slot);
> +		if (slot >=3D 8)
> +			slot =3D 8;
> +	}
> +	tpstats.hist[slot]++;
> +
>   	flush_tsb_user(tb);
> +	if (tb->force_mm_flush)
> +		goto out_nr;
>  =20
>   	if (CTX_VALID(mm->context)) {
>   		if (tb->tlb_nr =3D 1) {
> @@ -43,13 +57,24 @@ void flush_tlb_pending(void)
>   #endif
>   		}
>   	}
> -
> +out_nr:
>   	tb->tlb_nr =3D 0;
>  =20
>   out:
>   	put_cpu_var(tlb_batch);
>   }
>  =20
> +static void maybe_flush_mm_context(struct tlb_batch *tb)
> +{
> +	if (tb->force_mm_flush) {
> +		struct mm_struct *mm =3D tb->mm;
> +
> +		if (CTX_VALID(mm->context))
> +			do_flush_tlb_mm(mm);
> +		tb->force_mm_flush =3D 0;
> +	}
> +}
> +
>   void arch_enter_lazy_mmu_mode(void)
>   {
>   	struct tlb_batch *tb =3D this_cpu_ptr(&tlb_batch);
> @@ -63,6 +88,7 @@ void arch_leave_lazy_mmu_mode(void)
>  =20
>   	if (tb->tlb_nr)
>   		flush_tlb_pending();
> +	maybe_flush_mm_context(tb);
>   	tb->active =3D 0;
>   }
>  =20
> @@ -80,6 +106,7 @@ static void tlb_batch_add_one(struct mm_struct *mm, un=
signed long vaddr,
>  =20
>   	if (unlikely(nr !=3D 0 && mm !=3D tb->mm)) {
>   		flush_tlb_pending();
> +		maybe_flush_mm_context(tb);
>   		nr =3D 0;
>   	}
>  =20
> @@ -96,15 +123,18 @@ static void tlb_batch_add_one(struct mm_struct *mm, =
unsigned long vaddr,
>  =20
>   	if (tb->hugepage_shift !=3D hugepage_shift) {
>   		flush_tlb_pending();
> +		maybe_flush_mm_context(tb);
>   		tb->hugepage_shift =3D hugepage_shift;
>   		nr =3D 0;
>   	}
>  =20
>   	tb->vaddrs[nr] =3D vaddr;
>   	tb->tlb_nr =3D ++nr;
> -	if (nr >=3D TLB_BATCH_NR)
> +	if (nr >=3D TLB_BATCH_NR) {
> +		tpstats.num_force_mm_flush++;
> +		tb->force_mm_flush =3D 1;
>   		flush_tlb_pending();
> -
> +	}
>   out:
>   	put_cpu_var(tlb_batch);
>   }


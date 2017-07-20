From: David Miller <davem@davemloft.net>
Date: Thu, 20 Jul 2017 03:23:45 +0000
Subject: Re: [PATCH] arch/sparc: Measure receiver forward progress to avoid send mondo timeout
Message-Id: <20170719.202345.2005130770800688000.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1498683746-623218-1-git-send-email-jane.chu@oracle.com>
In-Reply-To: <1498683746-623218-1-git-send-email-jane.chu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Tue, 18 Jul 2017 11:39:43 -0700 (PDT)

> From: jane.chu@oracle.com
> Date: Mon, 17 Jul 2017 15:11:03 -0700
> 
>> Thanks for digging in.  I will try your patch to  gather what I could
>> share the data.
> 
> So, further inspection shows that we limit batches to 192 entries so
> we will never see the full extent of an unmap in the statistics for
> large operations.

What follows is a rough attempt to mitigate the TLB flush overhead a
little bit, I've kept the statistics gathering in there for now.

The initial heuristic is that if we fill up an entire TLB batch, we
switch to a full TLB context flush, which we will perform at the end
of the high level unmap operation (several more batch fills can happen
until then).

Maybe the cut-off should be even lower, I don't know.

One major aspect, which we've been discussing, is that this keeps us
from doing multiple expensive mondo's to remote cpus during the unmap.
We just do one cheap one, for the TLB context flush.  Therefore,
qnother thing that comes to mind is that if the MM has only executed
on the local cpu, we won't end up doing remote mondos, so maybe the
cut-off can be a bit higher in that case.

We still flush the TSB entries one-by-one, but that always only occurs
on the local cpu.  It is possible to improve this as well, but we'd
need to keep track of a range.

If you look in the kernel TSB flushing, we have an optimization in the
range flushing case.  If the range is too large, we don't probe,
instead we scan the TSB from beginning to end, and do range
comparisons on the virtual address in the TAG.

So the idea is that we maintain a "lowest" and "highest" address in
the TLB batch structure, and if the number of batch entries get large
we go into a TSB scan mode.

Integrating the TSB part into this is not easy.  The trouble is that
the cut-off for going to TSB scan mode needs to be a lot larger than
the one used for entering TLB context flush mode.  This is especially
the case because of how we dynamically grow the TSB based roughly upon
the thread's resident set size.

Anyways, patch follows...

diff --git a/arch/sparc/include/asm/tlb_64.h b/arch/sparc/include/asm/tlb_64.h
index 4cb392f..8cf3f45 100644
--- a/arch/sparc/include/asm/tlb_64.h
+++ b/arch/sparc/include/asm/tlb_64.h
@@ -7,6 +7,14 @@
 #include <asm/tlbflush.h>
 #include <asm/mmu_context.h>
 
+#define TLB_PENDING_STATS_SLOTS		9
+struct tlb_pending_stats {
+	unsigned long total;
+	unsigned long num_force_mm_flush;
+	unsigned long hist[TLB_PENDING_STATS_SLOTS];
+};
+extern struct tlb_pending_stats tpstats;
+
 #ifdef CONFIG_SMP
 void smp_flush_tlb_pending(struct mm_struct *,
 				  unsigned long, unsigned long *);
diff --git a/arch/sparc/include/asm/tlbflush_64.h b/arch/sparc/include/asm/tlbflush_64.h
index 54be88a..b29e170 100644
--- a/arch/sparc/include/asm/tlbflush_64.h
+++ b/arch/sparc/include/asm/tlbflush_64.h
@@ -11,6 +11,7 @@ struct tlb_batch {
 	unsigned int hugepage_shift;
 	struct mm_struct *mm;
 	unsigned long tlb_nr;
+	unsigned long force_mm_flush;
 	unsigned long active;
 	unsigned long vaddrs[TLB_BATCH_NR];
 };
diff --git a/arch/sparc/kernel/cpu.c b/arch/sparc/kernel/cpu.c
index 493e023..8ed7467 100644
--- a/arch/sparc/kernel/cpu.c
+++ b/arch/sparc/kernel/cpu.c
@@ -20,6 +20,7 @@
 #include <asm/psr.h>
 #include <asm/mbus.h>
 #include <asm/cpudata.h>
+#include <asm/tlb.h>
 
 #include "kernel.h"
 #include "entry.h"
@@ -378,6 +379,7 @@ static int show_cpuinfo(struct seq_file *m, void *__unused)
 		   "ncpus active\t: %d\n"
 		   "D$ parity tl1\t: %u\n"
 		   "I$ parity tl1\t: %u\n"
+		   "TLB PENDING\t: Total %lu MM %lu [%lu %lu %lu %lu %lu %lu %lu %lu %lu]\n"
 #ifndef CONFIG_SMP
 		   "Cpu0ClkTck\t: %016lx\n"
 #endif
@@ -392,7 +394,11 @@ static int show_cpuinfo(struct seq_file *m, void *__unused)
 		   ncpus_probed,
 		   num_online_cpus(),
 		   dcache_parity_tl1_occurred,
-		   icache_parity_tl1_occurred
+		   icache_parity_tl1_occurred,
+		   tpstats.total, tpstats.num_force_mm_flush,
+		   tpstats.hist[0], tpstats.hist[1], tpstats.hist[2], tpstats.hist[3],
+		   tpstats.hist[4], tpstats.hist[5], tpstats.hist[6], tpstats.hist[7],
+		   tpstats.hist[8]
 #ifndef CONFIG_SMP
 		   , cpu_data(0).clock_tick
 #endif
diff --git a/arch/sparc/mm/tlb.c b/arch/sparc/mm/tlb.c
index ee8066c..eaf61e3 100644
--- a/arch/sparc/mm/tlb.c
+++ b/arch/sparc/mm/tlb.c
@@ -19,16 +19,30 @@
 /* Heavily inspired by the ppc64 code.  */
 
 static DEFINE_PER_CPU(struct tlb_batch, tlb_batch);
+struct tlb_pending_stats tpstats;
 
 void flush_tlb_pending(void)
 {
 	struct tlb_batch *tb = &get_cpu_var(tlb_batch);
 	struct mm_struct *mm = tb->mm;
+	u32 slot = tb->tlb_nr;
 
 	if (!tb->tlb_nr)
 		goto out;
 
+	tpstats.total++;
+	if (slot = TLB_BATCH_NR) {
+		slot = 8;
+	} else {
+		slot = ilog2(slot);
+		if (slot >= 8)
+			slot = 8;
+	}
+	tpstats.hist[slot]++;
+
 	flush_tsb_user(tb);
+	if (tb->force_mm_flush)
+		goto out_nr;
 
 	if (CTX_VALID(mm->context)) {
 		if (tb->tlb_nr = 1) {
@@ -43,13 +57,24 @@ void flush_tlb_pending(void)
 #endif
 		}
 	}
-
+out_nr:
 	tb->tlb_nr = 0;
 
 out:
 	put_cpu_var(tlb_batch);
 }
 
+static void maybe_flush_mm_context(struct tlb_batch *tb)
+{
+	if (tb->force_mm_flush) {
+		struct mm_struct *mm = tb->mm;
+
+		if (CTX_VALID(mm->context))
+			do_flush_tlb_mm(mm);
+		tb->force_mm_flush = 0;
+	}
+}
+
 void arch_enter_lazy_mmu_mode(void)
 {
 	struct tlb_batch *tb = this_cpu_ptr(&tlb_batch);
@@ -63,6 +88,7 @@ void arch_leave_lazy_mmu_mode(void)
 
 	if (tb->tlb_nr)
 		flush_tlb_pending();
+	maybe_flush_mm_context(tb);
 	tb->active = 0;
 }
 
@@ -80,6 +106,7 @@ static void tlb_batch_add_one(struct mm_struct *mm, unsigned long vaddr,
 
 	if (unlikely(nr != 0 && mm != tb->mm)) {
 		flush_tlb_pending();
+		maybe_flush_mm_context(tb);
 		nr = 0;
 	}
 
@@ -96,15 +123,18 @@ static void tlb_batch_add_one(struct mm_struct *mm, unsigned long vaddr,
 
 	if (tb->hugepage_shift != hugepage_shift) {
 		flush_tlb_pending();
+		maybe_flush_mm_context(tb);
 		tb->hugepage_shift = hugepage_shift;
 		nr = 0;
 	}
 
 	tb->vaddrs[nr] = vaddr;
 	tb->tlb_nr = ++nr;
-	if (nr >= TLB_BATCH_NR)
+	if (nr >= TLB_BATCH_NR) {
+		tpstats.num_force_mm_flush++;
+		tb->force_mm_flush = 1;
 		flush_tlb_pending();
-
+	}
 out:
 	put_cpu_var(tlb_batch);
 }

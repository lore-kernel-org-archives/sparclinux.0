From: David Miller <davem@davemloft.net>
Date: Mon, 17 Jul 2017 21:43:44 +0000
Subject: Re: [PATCH] arch/sparc: Measure receiver forward progress to avoid send mondo timeout
Message-Id: <20170717.144344.608889061096564309.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1498683746-623218-1-git-send-email-jane.chu@oracle.com>
In-Reply-To: <1498683746-623218-1-git-send-email-jane.chu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Fri, 14 Jul 2017 11:17:36 -0700 (PDT)

> I'm still pretty sure that unmaps are taking an unreasonable amount of
> time to execute.  Our current range flush implementation is incredibly
> stupid, and could be improved by orders of magnitude.  It allocates an
> entire kernel stack frame, just so that it can call __flush_tlb_pending().
> 
> In fact, we can end up doing this full trap entry/exit just for
> purging 2 or 3 pages.

So I wanted to dig deeper into this, so I wrote a simple tracker for
flush_tlb_pending() which keeps of how often we do flushes of various
sizes.

The patch is below, the output from /proc/cpuinfo looks like:

TLB PENDING     : Total 2441449 Chart [1365735 435807 105896 134569 134121 89929 55970 123867 0 0 0 0 0 0 0]

First is the total number of flushes, then there is a histogram of counts by power
of 2.  So the first slot is number of 1 entry flushes, the second slot is the
number of 2 or 3 entry flushes, the third is the number of 4, 5, 6, or 7
entry flushes.  And so on.

I did three kernel builds after a fresh boot and ended up with this (annotated):

Total 2437888

1:		1363857
2:		435389
4:		105582
8:		134329
16:		133978
32:		89821
64:		55833
128:		123544
256:		0
512:		0
1024:		0
2048:		0
4096:		0
8192:		0
16384:		0

Can you run with this patch on the test case that triggered these mondo
timeouts and send the /proc/cpuinfo "TLB PENDING" line to this list?

Thanks!

diff --git a/arch/sparc/include/asm/tlb_64.h b/arch/sparc/include/asm/tlb_64.h
index 4cb392f..7a9473c 100644
--- a/arch/sparc/include/asm/tlb_64.h
+++ b/arch/sparc/include/asm/tlb_64.h
@@ -7,6 +7,13 @@
 #include <asm/tlbflush.h>
 #include <asm/mmu_context.h>
 
+#define TLB_PENDING_STATS_SLOTS	15
+struct tlb_pending_stats {
+	unsigned long total;
+	unsigned long num_flushes[TLB_PENDING_STATS_SLOTS];
+};
+extern struct tlb_pending_stats tpstats;
+
 #ifdef CONFIG_SMP
 void smp_flush_tlb_pending(struct mm_struct *,
 				  unsigned long, unsigned long *);
diff --git a/arch/sparc/kernel/cpu.c b/arch/sparc/kernel/cpu.c
index 493e023..706ffbf 100644
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
+		   "TLB PENDING\t: Total %lu Chart [%lu %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu]\n"
 #ifndef CONFIG_SMP
 		   "Cpu0ClkTck\t: %016lx\n"
 #endif
@@ -392,7 +394,12 @@ static int show_cpuinfo(struct seq_file *m, void *__unused)
 		   ncpus_probed,
 		   num_online_cpus(),
 		   dcache_parity_tl1_occurred,
-		   icache_parity_tl1_occurred
+		   icache_parity_tl1_occurred,
+		   tpstats.total,
+		   tpstats.num_flushes[0], tpstats.num_flushes[1], tpstats.num_flushes[2], tpstats.num_flushes[3],
+		   tpstats.num_flushes[4], tpstats.num_flushes[5], tpstats.num_flushes[6], tpstats.num_flushes[7],
+		   tpstats.num_flushes[8], tpstats.num_flushes[9], tpstats.num_flushes[10], tpstats.num_flushes[11],
+		   tpstats.num_flushes[12], tpstats.num_flushes[13], tpstats.num_flushes[14]
 #ifndef CONFIG_SMP
 		   , cpu_data(0).clock_tick
 #endif
diff --git a/arch/sparc/mm/tlb.c b/arch/sparc/mm/tlb.c
index ee8066c..8a8a2e2 100644
--- a/arch/sparc/mm/tlb.c
+++ b/arch/sparc/mm/tlb.c
@@ -20,6 +20,8 @@
 
 static DEFINE_PER_CPU(struct tlb_batch, tlb_batch);
 
+struct tlb_pending_stats tpstats;
+
 void flush_tlb_pending(void)
 {
 	struct tlb_batch *tb = &get_cpu_var(tlb_batch);
@@ -31,6 +33,14 @@ void flush_tlb_pending(void)
 	flush_tsb_user(tb);
 
 	if (CTX_VALID(mm->context)) {
+		u32 slot = tb->tlb_nr;
+
+		tpstats.total++;
+		slot = ilog2(slot);
+		if (slot > 14)
+			slot = 14;
+		tpstats.num_flushes[slot]++;
+
 		if (tb->tlb_nr = 1) {
 			global_flush_tlb_page(mm, tb->vaddrs[0]);
 		} else {

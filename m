From: Thomas Gleixner <tglx@linutronix.de>
Date: Sat, 19 Sep 2020 09:18:05 +0000
Subject: [patch RFC 14/15] sched: highmem: Store temporary kmaps in task struct
Message-Id: <20200919092617.279626264@linutronix.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20200919091751.011116649@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: Juri Lelli <juri.lelli@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, dri-devel <dri-devel@lists.freedesktop.org>, Ben Segall <bsegall@google.com>, Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>, sparclinux@vger.kernel.org, Vincent Chen <deanbo422@gmail.com>, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, linux-arch@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Herbert Xu <herbert@gondor.apana.org.au>, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, linux-csky@vger.kernel.org, David Airlie <airlied@linux.ie>, Mel Gorman <mgorman@suse.de>, linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org, Paul McKenney <paulmck@kernel.org>, intel-gfx <intel-gfx@lists.freedesktop.org>, linuxppc-dev@lists.ozlabs.org, Steven Rostedt <rostedt@goodmis.org>, Linus Torvalds <torvalds@linuxfoundation.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Chris Zankel <chris@zankel.net>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Nick Hu <nickhu@andestech.com>, Linux-MM <linux-mm@kvack.org>, Vineet Gupta <vgupta@synopsys.com>, linux-mips@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@linux-foundation.org>, Daniel Bristot de Oliveira <bristot@redhat.com>, "David S. Miller" <davem@davemloft.net>, Greentime Hu <green.hu@gmail.com>

Instead of storing the map per CPU provide and use per task storage. That
prepares for temporary kmaps which are preemptible.

The context switch code is preparatory and not yet in use because
kmap_atomic() runs with preemption disabled. Will be made usable in the
next step.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/highmem.h |    1 
 include/linux/sched.h   |    9 +++++++
 kernel/sched/core.c     |   10 ++++++++
 mm/highmem.c            |   59 ++++++++++++++++++++++++++++++++++++++++++------
 4 files changed, 72 insertions(+), 7 deletions(-)

--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -38,6 +38,7 @@ static inline void invalidate_kernel_vma
 void *kmap_atomic_pfn_prot(unsigned long pfn, pgprot_t prot);
 void *kmap_atomic_page_prot(struct page *page, pgprot_t prot);
 void kunmap_atomic_indexed(void *vaddr);
+void kmap_switch_temporary(struct task_struct *prev, struct task_struct *next);
 # ifndef ARCH_NEEDS_KMAP_HIGH_GET
 static inline void *arch_kmap_temporary_high_get(struct page *page)
 {
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -34,6 +34,7 @@
 #include <linux/rseq.h>
 #include <linux/seqlock.h>
 #include <linux/kcsan.h>
+#include <asm/kmap_types.h>
 
 /* task_struct member predeclarations (sorted alphabetically): */
 struct audit_context;
@@ -628,6 +629,13 @@ struct wake_q_node {
 	struct wake_q_node *next;
 };
 
+struct kmap_ctrl {
+#ifdef CONFIG_KMAP_ATOMIC_GENERIC
+	int				idx;
+	pte_t				pteval[KM_TYPE_NR];
+#endif
+};
+
 struct task_struct {
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 	/*
@@ -1280,6 +1288,7 @@ struct task_struct {
 	unsigned int			sequential_io;
 	unsigned int			sequential_io_avg;
 #endif
+	struct kmap_ctrl		kmap_ctrl;
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
 	unsigned long			task_state_change;
 #endif
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3529,6 +3529,15 @@ static inline void finish_lock_switch(st
 # define finish_arch_post_lock_switch()	do { } while (0)
 #endif
 
+static inline void kmap_temp_switch(struct task_struct *prev,
+				    struct task_struct *next)
+{
+#ifdef CONFIG_HIGHMEM
+	if (unlikely(prev->kmap_ctrl.idx || next->kmap_ctrl.idx))
+		kmap_switch_temporary(prev, next);
+#endif
+}
+
 /**
  * prepare_task_switch - prepare to switch tasks
  * @rq: the runqueue preparing to switch
@@ -3551,6 +3560,7 @@ prepare_task_switch(struct rq *rq, struc
 	perf_event_task_sched_out(prev, next);
 	rseq_preempt(prev);
 	fire_sched_out_preempt_notifiers(prev, next);
+	kmap_temp_switch(prev, next);
 	prepare_task(next);
 	prepare_arch_switch(next);
 }
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -370,6 +370,7 @@ void kunmap_high(struct page *page)
 	if (need_wakeup)
 		wake_up(pkmap_map_wait);
 }
+
 EXPORT_SYMBOL(kunmap_high);
 #else
 static inline void kmap_high_unmap_temporary(unsigned long vaddr) { }
@@ -377,11 +378,9 @@ static inline void kmap_high_unmap_tempo
 
 #ifdef CONFIG_KMAP_ATOMIC_GENERIC
 
-static DEFINE_PER_CPU(int, __kmap_atomic_idx);
-
 static inline int kmap_atomic_idx_push(void)
 {
-	int idx = __this_cpu_inc_return(__kmap_atomic_idx) - 1;
+	int idx = current->kmap_ctrl.idx++;
 
 	WARN_ON_ONCE(in_irq() && !irqs_disabled());
 	BUG_ON(idx >= KM_TYPE_NR);
@@ -390,14 +389,13 @@ static inline int kmap_atomic_idx_push(v
 
 static inline int kmap_atomic_idx(void)
 {
-	return __this_cpu_read(__kmap_atomic_idx) - 1;
+	return current->kmap_ctrl.idx - 1;
 }
 
 static inline void kmap_atomic_idx_pop(void)
 {
-	int idx = __this_cpu_dec_return(__kmap_atomic_idx);
-
-	BUG_ON(idx < 0);
+	current->kmap_ctrl.idx--;
+	BUG_ON(current->kmap_ctrl.idx < 0);
 }
 
 #ifndef arch_kmap_temp_post_map
@@ -447,6 +445,7 @@ static void *__kmap_atomic_pfn_prot(unsi
 	pteval = pfn_pte(pfn, prot);
 	set_pte(kmap_pte - idx, pteval);
 	arch_kmap_temp_post_map(vaddr, pteval);
+	current->kmap_ctrl.pteval[kmap_atomic_idx()] = pteval;
 	preempt_enable();
 
 	return (void *)vaddr;
@@ -499,11 +498,57 @@ void kunmap_atomic_indexed(void *vaddr)
 	arch_kmap_temp_pre_unmap(addr);
 	pte_clear(&init_mm, addr, kmap_pte - idx);
 	arch_kmap_temp_post_unmap(addr);
+	current->kmap_ctrl.pteval[kmap_atomic_idx()] = __pte(0);
 	kmap_atomic_idx_pop();
 	preempt_enable();
 	pagefault_enable();
 }
 EXPORT_SYMBOL(kunmap_atomic_indexed);
+
+void kmap_switch_temporary(struct task_struct *prev, struct task_struct *next)
+{
+	pte_t *kmap_pte = kmap_get_pte();
+	int i;
+
+	/* Clear @prev's kmaps */
+	for (i = 0; i < prev->kmap_ctrl.idx; i++) {
+		pte_t pteval = prev->kmap_ctrl.pteval[i];
+		unsigned long addr;
+		int idx;
+
+		if (WARN_ON_ONCE(pte_none(pteval)))
+			continue;
+
+		/*
+		 * This is a horrible hack for XTENSA to calculate the
+		 * coloured PTE index. Uses the PFN encoded into the pteval
+		 * and the map index calculation because the actual mapped
+		 * virtual address is not stored in task::kmap_ctrl.
+		 *
+		 * For any sane architecture that address calculation is
+		 * optimized out.
+		 */
+		idx = arch_kmap_temp_map_idx(i, pte_pfn(pteval));
+
+		arch_kmap_temp_pre_unmap(addr);
+		pte_clear(&init_mm, addr, kmap_pte - idx);
+		arch_kmap_temp_post_unmap(addr);
+	}
+
+	/* Restore @next's kmaps */
+	for (i = 0; i < next->kmap_ctrl.idx; i++) {
+		pte_t pteval = next->kmap_ctrl.pteval[i];
+		int idx;
+
+		if (WARN_ON_ONCE(pte_none(pteval)))
+			continue;
+
+		idx = arch_kmap_temp_map_idx(i, pte_pfn(pteval));
+		set_pte(kmap_pte - idx, pteval);
+		arch_kmap_temp_post_map(addr, pteval);
+	}
+}
+
 #endif
 
 #if defined(HASHED_PAGE_VIRTUAL)

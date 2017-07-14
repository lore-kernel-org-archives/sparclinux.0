From: Rob Gardner <rob.gardner@oracle.com>
Date: Fri, 14 Jul 2017 03:56:00 +0000
Subject: [PATCH] sparc64: Prevent perf from running during super critical sections
Message-Id: <1500004560-974885-1-git-send-email-rob.gardner@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This fixes another cause of random segfaults and bus errors that
may occur while running perf with the callgraph option.

Critical sections beginning with spin_lock_irqsave() raise the
interrupt level to PIL_NORMAL_MAX (14) and intentionally do not block
performance counter interrupts, which arrive at PIL_NMI (15).

But some sections of code are "super critical" with respect
to perf because the perf_callchain_user() path accesses user
space and may cause TLB activity as well as faults as it unwinds the
user stack.

One particular critical section occurs in switch_mm:

        spin_lock_irqsave(&mm->context.lock, flags);
        ...
        load_secondary_context(mm);
        tsb_context_switch(mm);
        ...
        spin_unlock_irqrestore(&mm->context.lock, flags);

If a perf interrupt arrives in between load_secondary_context() and
tsb_context_switch(), then perf_callchain_user() could execute with
the context ID of one process, but with an active TSB for a different
process. When the user stack is accessed, it is very likely to
incur a TLB miss, since the h/w context ID has been changed. The TLB
will then be reloaded with a translation from the TSB for one process,
but using a context ID for another process. This exposes memory from
one process to another, and since it is a mapping for stack memory,
this usually causes the new process to crash quickly.

This super critical section needs more protection than is provided
by spin_lock_irqsave() since perf interrupts must not be allowed in.

Fixed by raising %pil to PIL_NMI just before the the super critical
section in switch_mm(), and in restore_processor_state() which has the
identical logic. This change to %pil persists until the end of
the original critical section.

Orabug: 25577560

Signed-off-by: Dave Aldridge <david.j.aldridge@oracle.com>
Signed-off-by: Rob Gardner <rob.gardner@oracle.com>
---
 arch/sparc/include/asm/mmu_context_64.h |    1 +
 arch/sparc/power/hibernate.c            |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/include/asm/mmu_context_64.h b/arch/sparc/include/asm/mmu_context_64.h
index 2cddcda..b7e0373 100644
--- a/arch/sparc/include/asm/mmu_context_64.h
+++ b/arch/sparc/include/asm/mmu_context_64.h
@@ -112,6 +112,7 @@ static inline void switch_mm(struct mm_struct *old_mm, struct mm_struct *mm, str
 	 * cpu0 to update it's TSB because at that point the cpu_vm_mask
 	 * only had cpu1 set in it.
 	 */
+	__asm__ __volatile__("wrpr %0, %%pil;" : : "i" (PIL_NMI));
 	load_secondary_context(mm);
 	tsb_context_switch(mm);
 
diff --git a/arch/sparc/power/hibernate.c b/arch/sparc/power/hibernate.c
index 17bd2e1..3d53a5c 100644
--- a/arch/sparc/power/hibernate.c
+++ b/arch/sparc/power/hibernate.c
@@ -35,6 +35,7 @@ void restore_processor_state(void)
 {
 	struct mm_struct *mm = current->active_mm;
 
+	__asm__ __volatile__("wrpr %0, %%pil;" : : "i" (PIL_NMI));
 	load_secondary_context(mm);
 	tsb_context_switch(mm);
 }
-- 
1.7.1


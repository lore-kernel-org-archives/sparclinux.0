From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Wed, 31 May 2017 15:25:21 +0000
Subject: [v1 2/6] sparc64: combine activate_mm and switch_mm
Message-Id: <1496244325-180257-3-git-send-email-pasha.tatashin@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The only difference between these two functions is that in activate_mm we
unconditionally flush context. However, there is no need to keep this
difference after fixing a bug where cpumask was not reset on a wrap. So, in
this patch we combine these.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Reviewed-by: Bob Picco <bob.picco@oracle.com>
Reviewed-by: Steven Sistare <steven.sistare@oracle.com>
---
 arch/sparc/include/asm/mmu_context_64.h |   21 +--------------------
 1 files changed, 1 insertions(+), 20 deletions(-)

diff --git a/arch/sparc/include/asm/mmu_context_64.h b/arch/sparc/include/asm/mmu_context_64.h
index 22fede6..734a134 100644
--- a/arch/sparc/include/asm/mmu_context_64.h
+++ b/arch/sparc/include/asm/mmu_context_64.h
@@ -133,26 +133,7 @@ static inline void switch_mm(struct mm_struct *old_mm, struct mm_struct *mm, str
 }
 
 #define deactivate_mm(tsk,mm)	do { } while (0)
-
-/* Activate a new MM instance for the current task. */
-static inline void activate_mm(struct mm_struct *active_mm, struct mm_struct *mm)
-{
-	unsigned long flags;
-	int cpu;
-
-	spin_lock_irqsave(&mm->context.lock, flags);
-	if (!CTX_VALID(mm->context))
-		get_new_mmu_context(mm);
-	cpu = smp_processor_id();
-	if (!cpumask_test_cpu(cpu, mm_cpumask(mm)))
-		cpumask_set_cpu(cpu, mm_cpumask(mm));
-
-	load_secondary_context(mm);
-	__flush_tlb_mm(CTX_HWBITS(mm->context), SECONDARY_CONTEXT);
-	tsb_context_switch(mm);
-	spin_unlock_irqrestore(&mm->context.lock, flags);
-}
-
+#define activate_mm(active_mm, mm) switch_mm(active_mm, mm, NULL)
 #endif /* !(__ASSEMBLY__) */
 
 #endif /* !(__SPARC64_MMU_CONTEXT_H) */
-- 
1.7.1


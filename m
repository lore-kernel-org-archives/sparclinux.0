From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Wed, 31 May 2017 15:25:23 +0000
Subject: [v1 4/6] sparc64: add per-cpu mm of secondary contexts
Message-Id: <1496244325-180257-5-git-send-email-pasha.tatashin@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The new wrap is going to use information from this array to figure out
mm's that currently have valid secondary contexts setup.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Reviewed-by: Bob Picco <bob.picco@oracle.com>
Reviewed-by: Steven Sistare <steven.sistare@oracle.com>
---
 arch/sparc/include/asm/mmu_context_64.h |    5 +++--
 arch/sparc/mm/init_64.c                 |    1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/include/asm/mmu_context_64.h b/arch/sparc/include/asm/mmu_context_64.h
index 734a134..edb4524 100644
--- a/arch/sparc/include/asm/mmu_context_64.h
+++ b/arch/sparc/include/asm/mmu_context_64.h
@@ -19,6 +19,7 @@ static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 extern unsigned long tlb_context_cache;
 extern unsigned long mmu_context_bmap[];
 
+DECLARE_PER_CPU(struct mm_struct *, per_cpu_secondary_mm);
 void get_new_mmu_context(struct mm_struct *mm);
 #ifdef CONFIG_SMP
 void smp_new_mmu_context_version(void);
@@ -76,8 +77,9 @@ void tsb_grow(struct mm_struct *mm,
 static inline void switch_mm(struct mm_struct *old_mm, struct mm_struct *mm, struct task_struct *tsk)
 {
 	unsigned long ctx_valid, flags;
-	int cpu;
+	int cpu = smp_processor_id();
 
+	per_cpu(per_cpu_secondary_mm, cpu) = mm;
 	if (unlikely(mm = &init_mm))
 		return;
 
@@ -123,7 +125,6 @@ static inline void switch_mm(struct mm_struct *old_mm, struct mm_struct *mm, str
 	 * for the first time, we must flush that context out of the
 	 * local TLB.
 	 */
-	cpu = smp_processor_id();
 	if (!ctx_valid || !cpumask_test_cpu(cpu, mm_cpumask(mm))) {
 		cpumask_set_cpu(cpu, mm_cpumask(mm));
 		__flush_tlb_mm(CTX_HWBITS(mm->context),
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 18f958b..5b4f030 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -710,6 +710,7 @@ void __flush_dcache_range(unsigned long start, unsigned long end)
 #define MAX_CTX_NR	(1UL << CTX_NR_BITS)
 #define CTX_BMAP_SLOTS	BITS_TO_LONGS(MAX_CTX_NR)
 DECLARE_BITMAP(mmu_context_bmap, MAX_CTX_NR);
+DEFINE_PER_CPU(struct mm_struct *, per_cpu_secondary_mm) = {0};
 
 /* Caller does TLB context flushing on local CPU if necessary.
  * The caller also ensures that CTX_VALID(mm->context) is false.
-- 
1.7.1


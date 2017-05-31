From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Wed, 31 May 2017 15:25:25 +0000
Subject: [v1 6/6] sparc64: delete old wrap code
Message-Id: <1496244325-180257-7-git-send-email-pasha.tatashin@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The old method that is using xcall and softint to get new context id is
deleted, as it is replaced by a method of using per_cpu_secondary_mm
without xcall to perform the context wrap.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Reviewed-by: Bob Picco <bob.picco@oracle.com>
Reviewed-by: Steven Sistare <steven.sistare@oracle.com>
---
 arch/sparc/include/asm/mmu_context_64.h |    6 ------
 arch/sparc/include/asm/pil.h            |    1 -
 arch/sparc/kernel/kernel.h              |    1 -
 arch/sparc/kernel/smp_64.c              |   31 -------------------------------
 arch/sparc/kernel/ttable_64.S           |    2 +-
 arch/sparc/mm/ultra.S                   |    5 -----
 6 files changed, 1 insertions(+), 45 deletions(-)

diff --git a/arch/sparc/include/asm/mmu_context_64.h b/arch/sparc/include/asm/mmu_context_64.h
index edb4524..2cddcda 100644
--- a/arch/sparc/include/asm/mmu_context_64.h
+++ b/arch/sparc/include/asm/mmu_context_64.h
@@ -21,12 +21,6 @@ static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 
 DECLARE_PER_CPU(struct mm_struct *, per_cpu_secondary_mm);
 void get_new_mmu_context(struct mm_struct *mm);
-#ifdef CONFIG_SMP
-void smp_new_mmu_context_version(void);
-#else
-#define smp_new_mmu_context_version() do { } while (0)
-#endif
-
 int init_new_context(struct task_struct *tsk, struct mm_struct *mm);
 void destroy_context(struct mm_struct *mm);
 
diff --git a/arch/sparc/include/asm/pil.h b/arch/sparc/include/asm/pil.h
index 2669370..522b43d 100644
--- a/arch/sparc/include/asm/pil.h
+++ b/arch/sparc/include/asm/pil.h
@@ -20,7 +20,6 @@
 #define PIL_SMP_CALL_FUNC	1
 #define PIL_SMP_RECEIVE_SIGNAL	2
 #define PIL_SMP_CAPTURE		3
-#define PIL_SMP_CTX_NEW_VERSION	4
 #define PIL_DEVICE_IRQ		5
 #define PIL_SMP_CALL_FUNC_SNGL	6
 #define PIL_DEFERRED_PCR_WORK	7
diff --git a/arch/sparc/kernel/kernel.h b/arch/sparc/kernel/kernel.h
index c980455..6ae1e77 100644
--- a/arch/sparc/kernel/kernel.h
+++ b/arch/sparc/kernel/kernel.h
@@ -37,7 +37,6 @@ static inline unsigned long kimage_addr_to_ra(const void *p)
 /* smp_64.c */
 void __irq_entry smp_call_function_client(int irq, struct pt_regs *regs);
 void __irq_entry smp_call_function_single_client(int irq, struct pt_regs *regs);
-void __irq_entry smp_new_mmu_context_version_client(int irq, struct pt_regs *regs);
 void __irq_entry smp_penguin_jailcell(int irq, struct pt_regs *regs);
 void __irq_entry smp_receive_signal_client(int irq, struct pt_regs *regs);
 
diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index b3bc0ac..fdf3104 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -964,37 +964,6 @@ void flush_dcache_page_all(struct mm_struct *mm, struct page *page)
 	preempt_enable();
 }
 
-void __irq_entry smp_new_mmu_context_version_client(int irq, struct pt_regs *regs)
-{
-	struct mm_struct *mm;
-	unsigned long flags;
-
-	clear_softint(1 << irq);
-
-	/* See if we need to allocate a new TLB context because
-	 * the version of the one we are using is now out of date.
-	 */
-	mm = current->active_mm;
-	if (unlikely(!mm || (mm = &init_mm)))
-		return;
-
-	spin_lock_irqsave(&mm->context.lock, flags);
-
-	if (unlikely(!CTX_VALID(mm->context)))
-		get_new_mmu_context(mm);
-
-	spin_unlock_irqrestore(&mm->context.lock, flags);
-
-	load_secondary_context(mm);
-	__flush_tlb_mm(CTX_HWBITS(mm->context),
-		       SECONDARY_CONTEXT);
-}
-
-void smp_new_mmu_context_version(void)
-{
-	smp_cross_call(&xcall_new_mmu_context_version, 0, 0, 0);
-}
-
 #ifdef CONFIG_KGDB
 void kgdb_roundup_cpus(unsigned long flags)
 {
diff --git a/arch/sparc/kernel/ttable_64.S b/arch/sparc/kernel/ttable_64.S
index 7bd8f65..efe93ab 100644
--- a/arch/sparc/kernel/ttable_64.S
+++ b/arch/sparc/kernel/ttable_64.S
@@ -50,7 +50,7 @@ tl0_resv03e:	BTRAP(0x3e) BTRAP(0x3f) BTRAP(0x40)
 tl0_irq1:	TRAP_IRQ(smp_call_function_client, 1)
 tl0_irq2:	TRAP_IRQ(smp_receive_signal_client, 2)
 tl0_irq3:	TRAP_IRQ(smp_penguin_jailcell, 3)
-tl0_irq4:	TRAP_IRQ(smp_new_mmu_context_version_client, 4)
+tl0_irq4:       BTRAP(0x44)
 #else
 tl0_irq1:	BTRAP(0x41)
 tl0_irq2:	BTRAP(0x42)
diff --git a/arch/sparc/mm/ultra.S b/arch/sparc/mm/ultra.S
index 5d2fd6c..fcf4d27 100644
--- a/arch/sparc/mm/ultra.S
+++ b/arch/sparc/mm/ultra.S
@@ -971,11 +971,6 @@ xcall_capture:
 	wr		%g0, (1 << PIL_SMP_CAPTURE), %set_softint
 	retry
 
-	.globl		xcall_new_mmu_context_version
-xcall_new_mmu_context_version:
-	wr		%g0, (1 << PIL_SMP_CTX_NEW_VERSION), %set_softint
-	retry
-
 #ifdef CONFIG_KGDB
 	.globl		xcall_kgdb_capture
 xcall_kgdb_capture:
-- 
1.7.1


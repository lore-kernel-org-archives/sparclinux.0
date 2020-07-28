From: Nicholas Piggin <npiggin@gmail.com>
Date: Tue, 28 Jul 2020 03:34:01 +0000
Subject: [PATCH 20/24] sparc: use asm-generic/mmu_context.h for no-op implementations
Message-Id: <20200728033405.78469-21-npiggin@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200728033405.78469-1-npiggin@gmail.com>
In-Reply-To: <20200728033405.78469-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arch@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/sparc/include/asm/mmu_context_32.h | 10 ++++------
 arch/sparc/include/asm/mmu_context_64.h | 10 +++++-----
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/sparc/include/asm/mmu_context_32.h b/arch/sparc/include/asm/mmu_context_32.h
index 7ddcb8badf70..509043f81560 100644
--- a/arch/sparc/include/asm/mmu_context_32.h
+++ b/arch/sparc/include/asm/mmu_context_32.h
@@ -6,13 +6,10 @@
 
 #include <asm-generic/mm_hooks.h>
 
-static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
-{
-}
-
 /* Initialize a new mmu context.  This is invoked when a new
  * address space instance (unique or shared) is instantiated.
  */
+#define init_new_context init_new_context
 int init_new_context(struct task_struct *tsk, struct mm_struct *mm);
 
 /* Destroy a dead context.  This occurs when mmput drops the
@@ -20,17 +17,18 @@ int init_new_context(struct task_struct *tsk, struct mm_struct *mm);
  * all the page tables have been flushed.  Our job is to destroy
  * any remaining processor-specific state.
  */
+#define destroy_context destroy_context
 void destroy_context(struct mm_struct *mm);
 
 /* Switch the current MM context. */
 void switch_mm(struct mm_struct *old_mm, struct mm_struct *mm,
 	       struct task_struct *tsk);
 
-#define deactivate_mm(tsk,mm)	do { } while (0)
-
 /* Activate a new MM instance for the current task. */
 #define activate_mm(active_mm, mm) switch_mm((active_mm), (mm), NULL)
 
+#include <asm-generic/mmu_context.h>
+
 #endif /* !(__ASSEMBLY__) */
 
 #endif /* !(__SPARC_MMU_CONTEXT_H) */
diff --git a/arch/sparc/include/asm/mmu_context_64.h b/arch/sparc/include/asm/mmu_context_64.h
index 312fcee8df2b..7a8380c63aab 100644
--- a/arch/sparc/include/asm/mmu_context_64.h
+++ b/arch/sparc/include/asm/mmu_context_64.h
@@ -16,17 +16,16 @@
 #include <asm-generic/mm_hooks.h>
 #include <asm/percpu.h>
 
-static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
-{
-}
-
 extern spinlock_t ctx_alloc_lock;
 extern unsigned long tlb_context_cache;
 extern unsigned long mmu_context_bmap[];
 
 DECLARE_PER_CPU(struct mm_struct *, per_cpu_secondary_mm);
 void get_new_mmu_context(struct mm_struct *mm);
+
+#define init_new_context init_new_context
 int init_new_context(struct task_struct *tsk, struct mm_struct *mm);
+#define destroy_context destroy_context
 void destroy_context(struct mm_struct *mm);
 
 void __tsb_context_switch(unsigned long pgd_pa,
@@ -136,7 +135,6 @@ static inline void switch_mm(struct mm_struct *old_mm, struct mm_struct *mm, str
 	spin_unlock_irqrestore(&mm->context.lock, flags);
 }
 
-#define deactivate_mm(tsk,mm)	do { } while (0)
 #define activate_mm(active_mm, mm) switch_mm(active_mm, mm, NULL)
 
 #define  __HAVE_ARCH_START_CONTEXT_SWITCH
@@ -187,6 +185,8 @@ static inline void finish_arch_post_lock_switch(void)
 	}
 }
 
+#include <asm-generic/mmu_context.h>
+
 #endif /* !(__ASSEMBLY__) */
 
 #endif /* !(__SPARC64_MMU_CONTEXT_H) */
-- 
2.23.0

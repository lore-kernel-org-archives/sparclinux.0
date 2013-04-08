From: Kirill Tkhai <tkhai@yandex.ru>
Date: Mon, 08 Apr 2013 20:29:46 +0000
Subject: [PATCH] sparc64: Do not save/restore interrupts in get_new_mmu_context()
Message-Id: <523971365452986@web28h.yandex.ru>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

get_new_mmu_context() is always called with interrupts disabled.
So it's possible to do this micro optimization.

(Also fix the comment to switch_mm, which is called in both cases)

Signed-off-by: Kirill Tkhai <tkhai@yandex.ru>
CC: David Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/mmu_context_64.h |    2 +-
 arch/sparc/mm/init_64.c                 |    5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)
diff --git a/arch/sparc/include/asm/mmu_context_64.h b/arch/sparc/include/asm/mmu_context_64.h
index 9191ca6..3d528f0 100644
--- a/arch/sparc/include/asm/mmu_context_64.h
+++ b/arch/sparc/include/asm/mmu_context_64.h
@@ -68,7 +68,7 @@ extern void smp_tsb_sync(struct mm_struct *mm);
 
 extern void __flush_tlb_mm(unsigned long, unsigned long);
 
-/* Switch the current MM context.  Interrupts are disabled.  */
+/* Switch the current MM context. */
 static inline void switch_mm(struct mm_struct *old_mm, struct mm_struct *mm, struct task_struct *tsk)
 {
 	unsigned long ctx_valid, flags;
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 076068f..4ccaa1b 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -681,10 +681,9 @@ void get_new_mmu_context(struct mm_struct *mm)
 {
 	unsigned long ctx, new_ctx;
 	unsigned long orig_pgsz_bits;
-	unsigned long flags;
 	int new_version;
 
-	spin_lock_irqsave(&ctx_alloc_lock, flags);
+	spin_lock(&ctx_alloc_lock);
 	orig_pgsz_bits = (mm->context.sparc64_ctx_val & CTX_PGSZ_MASK);
 	ctx = (tlb_context_cache + 1) & CTX_NR_MASK;
 	new_ctx = find_next_zero_bit(mmu_context_bmap, 1 << CTX_NR_BITS, ctx);
@@ -720,7 +719,7 @@ void get_new_mmu_context(struct mm_struct *mm)
 out:
 	tlb_context_cache = new_ctx;
 	mm->context.sparc64_ctx_val = new_ctx | orig_pgsz_bits;
-	spin_unlock_irqrestore(&ctx_alloc_lock, flags);
+	spin_unlock(&ctx_alloc_lock);
 
 	if (unlikely(new_version))
 		smp_new_mmu_context_version();

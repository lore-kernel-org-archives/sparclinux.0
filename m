From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 13 May 2012 08:46:58 +0000
Subject: [PATCH 3/2] sparc32: drop btfixup in mmu_context_32.h
Message-Id: <20120513084658.GA25608@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From 38986a9c6e0dda4b494f046024805c9ba0469b2b Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 13 May 2012 10:30:54 +0200
Subject: [PATCH 3/2] sparc32: drop btfixup in mmu_context_32.h

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/mmu_context_32.h |    4 +---
 arch/sparc/mm/srmmu.c                   |    3 +--
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/sparc/include/asm/mmu_context_32.h b/arch/sparc/include/asm/mmu_context_32.h
index 0037931..623b598 100644
--- a/arch/sparc/include/asm/mmu_context_32.h
+++ b/arch/sparc/include/asm/mmu_context_32.h
@@ -23,9 +23,7 @@ static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
  * all the page tables have been flushed.  Our job is to destroy
  * any remaining processor-specific state.
  */
-BTFIXUPDEF_CALL(void, destroy_context, struct mm_struct *)
-
-#define destroy_context(mm) BTFIXUP_CALL(destroy_context)(mm)
+void destroy_context(struct mm_struct *mm);
 
 /* Switch the current MM context. */
 void switch_mm(struct mm_struct *old_mm, struct mm_struct *mm,
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 32cec26..0a47b82 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -1222,7 +1222,7 @@ static void srmmu_update_mmu_cache(struct vm_area_struct * vma, unsigned long ad
 {
 }
 
-static void srmmu_destroy_context(struct mm_struct *mm)
+void destroy_context(struct mm_struct *mm)
 {
 
 	if(mm->context != NO_CONTEXT) {
@@ -1988,7 +1988,6 @@ void __init load_mmu(void)
 #endif
 
 	BTFIXUPSET_CALL(update_mmu_cache, srmmu_update_mmu_cache, BTFIXUPCALL_NOP);
-	BTFIXUPSET_CALL(destroy_context, srmmu_destroy_context, BTFIXUPCALL_NORM);
 
 	get_srmmu_type();
 
-- 
1.6.0.6


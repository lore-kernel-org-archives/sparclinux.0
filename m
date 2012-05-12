From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 12 May 2012 18:04:11 +0000
Subject: [PATCH 3/5] sparc32: drop btfixup for switch_mm
Message-Id: <1336845853-30388-3-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This revealed that the implementation of switch_mm
had a bogus extra argument.
No harm as said argument was never used - but confusing.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/mmu_context_32.h |    5 ++---
 arch/sparc/mm/srmmu.c                   |    5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/sparc/include/asm/mmu_context_32.h b/arch/sparc/include/asm/mmu_context_32.h
index 671a997..0037931 100644
--- a/arch/sparc/include/asm/mmu_context_32.h
+++ b/arch/sparc/include/asm/mmu_context_32.h
@@ -28,9 +28,8 @@ BTFIXUPDEF_CALL(void, destroy_context, struct mm_struct *)
 #define destroy_context(mm) BTFIXUP_CALL(destroy_context)(mm)
 
 /* Switch the current MM context. */
-BTFIXUPDEF_CALL(void, switch_mm, struct mm_struct *, struct mm_struct *, struct task_struct *)
-
-#define switch_mm(old_mm, mm, tsk) BTFIXUP_CALL(switch_mm)(old_mm, mm, tsk)
+void switch_mm(struct mm_struct *old_mm, struct mm_struct *mm,
+	       struct task_struct *tsk);
 
 #define deactivate_mm(tsk,mm)	do { } while (0)
 
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 564269d..85d7f82 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -560,8 +560,8 @@ static inline void free_context(int context)
 }
 
 
-static void srmmu_switch_mm(struct mm_struct *old_mm, struct mm_struct *mm,
-    struct task_struct *tsk, int cpu)
+void switch_mm(struct mm_struct *old_mm, struct mm_struct *mm,
+	       struct task_struct *tsk)
 {
 	if(mm->context = NO_CONTEXT) {
 		spin_lock(&srmmu_context_spinlock);
@@ -2171,7 +2171,6 @@ void __init ld_mmu_srmmu(void)
 	BTFIXUPSET_CALL(do_check_pgt_cache, srmmu_check_pgt_cache, BTFIXUPCALL_NOP);
 
 	BTFIXUPSET_CALL(set_pte, srmmu_set_pte, BTFIXUPCALL_SWAPO0O1);
-	BTFIXUPSET_CALL(switch_mm, srmmu_switch_mm, BTFIXUPCALL_NORM);
 
 	BTFIXUPSET_CALL(pte_pfn, srmmu_pte_pfn, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(pmd_page, srmmu_pmd_page, BTFIXUPCALL_NORM);
-- 
1.6.0.6


From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 11 May 2012 21:35:16 +0000
Subject: [PATCH 13/14] sparc32: drop btfixup for alloc_thread_info_node/free_thread_info
Message-Id: <1336772117-1539-13-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/thread_info_32.h |    7 ++-----
 arch/sparc/mm/srmmu.c                   |    7 ++-----
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/sparc/include/asm/thread_info_32.h b/arch/sparc/include/asm/thread_info_32.h
index c2a1080..74316de 100644
--- a/arch/sparc/include/asm/thread_info_32.h
+++ b/arch/sparc/include/asm/thread_info_32.h
@@ -82,11 +82,8 @@ register struct thread_info *current_thread_info_reg asm("g6");
 
 #define __HAVE_ARCH_THREAD_INFO_ALLOCATOR
 
-BTFIXUPDEF_CALL(struct thread_info *, alloc_thread_info_node, int)
-#define alloc_thread_info_node(tsk, node) BTFIXUP_CALL(alloc_thread_info_node)(node)
-
-BTFIXUPDEF_CALL(void, free_thread_info, struct thread_info *)
-#define free_thread_info(ti) BTFIXUP_CALL(free_thread_info)(ti)
+struct thread_info * alloc_thread_info_node(struct task_struct *tsk, int node);
+void free_thread_info(struct thread_info *);
 
 #endif /* __ASSEMBLY__ */
 
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index a948ee5..2663b92 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -650,7 +650,7 @@ static void srmmu_unmapiorange(unsigned long virt_addr, unsigned int len)
  * mappings on the kernel stack without any special code as we did
  * need on the sun4c.
  */
-static struct thread_info *srmmu_alloc_thread_info_node(int node)
+struct thread_info *alloc_thread_info_node(struct task_struct *tsk, int node)
 {
 	struct thread_info *ret;
 
@@ -664,7 +664,7 @@ static struct thread_info *srmmu_alloc_thread_info_node(int node)
 	return ret;
 }
 
-static void srmmu_free_thread_info(struct thread_info *ti)
+void free_thread_info(struct thread_info *ti)
 {
 	free_pages((unsigned long)ti, THREAD_INFO_ORDER);
 }
@@ -2250,9 +2250,6 @@ void __init ld_mmu_srmmu(void)
 
 	BTFIXUPSET_CALL(mmu_info, srmmu_mmu_info, BTFIXUPCALL_NORM);
 
-	BTFIXUPSET_CALL(alloc_thread_info_node, srmmu_alloc_thread_info_node, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(free_thread_info, srmmu_free_thread_info, BTFIXUPCALL_NORM);
-
 	BTFIXUPSET_CALL(pte_to_pgoff, srmmu_pte_to_pgoff, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(pgoff_to_pte, srmmu_pgoff_to_pte, BTFIXUPCALL_NORM);
 
-- 
1.6.0.6


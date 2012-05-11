From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 11 May 2012 21:35:05 +0000
Subject: [PATCH 02/14] sparc32: remove calls to sun4c dummy mm inits functions
Message-Id: <1336772117-1539-2-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/mm/fault_32.c |    3 ---
 arch/sparc/mm/init_32.c  |    8 --------
 arch/sparc/mm/loadmmu.c  |    5 -----
 arch/sparc/mm/nosun4c.c  |   23 -----------------------
 4 files changed, 0 insertions(+), 39 deletions(-)

diff --git a/arch/sparc/mm/fault_32.c b/arch/sparc/mm/fault_32.c
index df3155a..f3e6921 100644
--- a/arch/sparc/mm/fault_32.c
+++ b/arch/sparc/mm/fault_32.c
@@ -60,14 +60,11 @@ unsigned long probe_memory(void)
 	return total;
 }
 
-extern void sun4c_complete_all_stores(void);
-
 /* Whee, a level 15 NMI interrupt memory error.  Let's have fun... */
 asmlinkage void sparc_lvl15_nmi(struct pt_regs *regs, unsigned long serr,
 				unsigned long svaddr, unsigned long aerr,
 				unsigned long avaddr)
 {
-	sun4c_complete_all_stores();
 	printk("FAULT: NMI received\n");
 	printk("SREGS: Synchronous Error %08lx\n", serr);
 	printk("       Synchronous Vaddr %08lx\n", svaddr);
diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
index c5f9021..15848e7 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -308,7 +308,6 @@ void check_pgt_cache(void)
  * init routine based upon the Sun model type on the Sparc.
  *
  */
-extern void sun4c_paging_init(void);
 extern void srmmu_paging_init(void);
 extern void device_scan(void);
 
@@ -318,13 +317,6 @@ EXPORT_SYMBOL(PAGE_SHARED);
 void __init paging_init(void)
 {
 	switch(sparc_cpu_model) {
-	case sun4c:
-	case sun4e:
-	case sun4:
-		sun4c_paging_init();
-		sparc_unmapped_base = 0xe0000000;
-		BTFIXUPSET_SETHI(sparc_unmapped_base, 0xe0000000);
-		break;
 	case sparc_leon:
 		leon_init();
 		/* fall through */
diff --git a/arch/sparc/mm/loadmmu.c b/arch/sparc/mm/loadmmu.c
index c5bf2a6..49c396d 100644
--- a/arch/sparc/mm/loadmmu.c
+++ b/arch/sparc/mm/loadmmu.c
@@ -20,16 +20,11 @@ struct ctx_list *ctx_list_pool;
 struct ctx_list ctx_free;
 struct ctx_list ctx_used;
 
-extern void ld_mmu_sun4c(void);
 extern void ld_mmu_srmmu(void);
 
 void __init load_mmu(void)
 {
 	switch(sparc_cpu_model) {
-	case sun4c:
-	case sun4:
-		ld_mmu_sun4c();
-		break;
 	case sun4m:
 	case sun4d:
 	case sparc_leon:
diff --git a/arch/sparc/mm/nosun4c.c b/arch/sparc/mm/nosun4c.c
index 4e62c27..0e0e8cf 100644
--- a/arch/sparc/mm/nosun4c.c
+++ b/arch/sparc/mm/nosun4c.c
@@ -29,29 +29,6 @@ static void __init should_not_happen(void)
 	prom_halt();
 }
 
-unsigned long __init sun4c_paging_init(unsigned long start_mem, unsigned long end_mem)
-{
-	should_not_happen();
-	return 0;
-}
-
-void __init ld_mmu_sun4c(void)
-{
-	should_not_happen();
-}
-
-void sun4c_mapioaddr(unsigned long physaddr, unsigned long virt_addr, int bus_type, int rdonly)
-{
-}
-
-void sun4c_unmapioaddr(unsigned long virt_addr)
-{
-}
-
-void sun4c_complete_all_stores(void)
-{
-}
-
 pte_t *sun4c_pte_offset(pmd_t * dir, unsigned long address)
 {
 	return NULL;
-- 
1.6.0.6


From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 26 Jul 2012 21:02:24 +0000
Subject: [PATCH 14/18] sparc32: centralize all mmu context handling in srmmu.c
Message-Id: <1343336548-3879-14-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/mmu_context_32.h |    8 +--
 arch/sparc/include/asm/pgtable_32.h     |   32 --------------
 arch/sparc/kernel/setup_32.c            |    1 -
 arch/sparc/mm/fault_32.c                |    6 ---
 arch/sparc/mm/init_32.c                 |   18 --------
 arch/sparc/mm/srmmu.c                   |   69 +++++++++++++++++++++++++++----
 6 files changed, 63 insertions(+), 71 deletions(-)

diff --git a/arch/sparc/include/asm/mmu_context_32.h b/arch/sparc/include/asm/mmu_context_32.h
index 01456c9..2df2a9b 100644
--- a/arch/sparc/include/asm/mmu_context_32.h
+++ b/arch/sparc/include/asm/mmu_context_32.h
@@ -9,14 +9,12 @@ static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 {
 }
 
-/*
- * Initialize a new mmu context.  This is invoked when a new
+/* Initialize a new mmu context.  This is invoked when a new
  * address space instance (unique or shared) is instantiated.
  */
-#define init_new_context(tsk, mm) (((mm)->context = NO_CONTEXT), 0)
+int init_new_context(struct task_struct *tsk, struct mm_struct *mm);
 
-/*
- * Destroy a dead context.  This occurs when mmput drops the
+/* Destroy a dead context.  This occurs when mmput drops the
  * mm_users count to zero, the mmaps have been released, and
  * all the page tables have been flushed.  Our job is to destroy
  * any remaining processor-specific state.
diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
index c704f94..97a4880 100644
--- a/arch/sparc/include/asm/pgtable_32.h
+++ b/arch/sparc/include/asm/pgtable_32.h
@@ -79,8 +79,6 @@ extern unsigned long ptr_in_current_pgd;
 #define __S110	PAGE_SHARED
 #define __S111	PAGE_SHARED
 
-extern int num_contexts;
-
 /* First physical page can be anywhere, the following is needed so that
  * va-->pa and vice versa conversions work properly without performance
  * hit for all __pa()/__va() operations.
@@ -399,36 +397,6 @@ static inline pte_t pgoff_to_pte(unsigned long pgoff)
  */
 #define PTE_FILE_MAX_BITS 24
 
-/*
- */
-struct ctx_list {
-	struct ctx_list *next;
-	struct ctx_list *prev;
-	unsigned int ctx_number;
-	struct mm_struct *ctx_mm;
-};
-
-extern struct ctx_list *ctx_list_pool;  /* Dynamically allocated */
-extern struct ctx_list ctx_free;        /* Head of free list */
-extern struct ctx_list ctx_used;        /* Head of used contexts list */
-
-#define NO_CONTEXT     -1
-
-static inline void remove_from_ctx_list(struct ctx_list *entry)
-{
-	entry->next->prev = entry->prev;
-	entry->prev->next = entry->next;
-}
-
-static inline void add_to_ctx_list(struct ctx_list *head, struct ctx_list *entry)
-{
-	entry->next = head;
-	(entry->prev = head->prev)->next = entry;
-	head->prev = entry;
-}
-#define add_to_free_ctxlist(entry) add_to_ctx_list(&ctx_free, entry)
-#define add_to_used_ctxlist(entry) add_to_ctx_list(&ctx_used, entry)
-
 static inline unsigned long
 __get_phys (unsigned long addr)
 {
diff --git a/arch/sparc/kernel/setup_32.c b/arch/sparc/kernel/setup_32.c
index efe3e64..38bf80a 100644
--- a/arch/sparc/kernel/setup_32.c
+++ b/arch/sparc/kernel/setup_32.c
@@ -371,7 +371,6 @@ void __init setup_arch(char **cmdline_p)
 		(*(linux_dbvec->teach_debugger))();
 	}
 
-	init_mm.context = (unsigned long) NO_CONTEXT;
 	init_task.thread.kregs = &fake_swapper_regs;
 
 	/* Run-time patch instructions to match the cpu model */
diff --git a/arch/sparc/mm/fault_32.c b/arch/sparc/mm/fault_32.c
index f46cf6b..e58f9ee 100644
--- a/arch/sparc/mm/fault_32.c
+++ b/arch/sparc/mm/fault_32.c
@@ -32,12 +32,6 @@
 
 int show_unhandled_signals = 1;
 
-/* At boot time we determine these two values necessary for setting
- * up the segment maps and page table entries (pte's).
- */
-
-int num_contexts;
-
 /* Return how much physical memory we have.  */
 unsigned long probe_memory(void)
 {
diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
index 6d44c2b..020d2af 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -82,24 +82,6 @@ void show_mem(unsigned int filter)
 #endif
 }
 
-void __init sparc_context_init(int numctx)
-{
-	int ctx;
-
-	ctx_list_pool = __alloc_bootmem(numctx * sizeof(struct ctx_list), SMP_CACHE_BYTES, 0UL);
-
-	for(ctx = 0; ctx < numctx; ctx++) {
-		struct ctx_list *clist;
-
-		clist = (ctx_list_pool + ctx);
-		clist->ctx_number = ctx;
-		clist->ctx_mm = NULL;
-	}
-	ctx_free.next = ctx_free.prev = &ctx_free;
-	ctx_used.next = ctx_used.prev = &ctx_used;
-	for(ctx = 0; ctx < numctx; ctx++)
-		add_to_free_ctxlist(ctx_list_pool + ctx);
-}
 
 extern unsigned long cmdline_memory_size;
 unsigned long last_valid_pfn;
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index ab62595..ad93d2e 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -55,10 +55,6 @@ static unsigned int hwbug_bitmask;
 int vac_cache_size;
 int vac_line_size;
 
-struct ctx_list *ctx_list_pool;
-struct ctx_list ctx_free;
-struct ctx_list ctx_used;
-
 extern struct resource sparc_iomap;
 
 extern unsigned long last_valid_pfn;
@@ -355,8 +351,39 @@ void pte_free(struct mm_struct *mm, pgtable_t pte)
 	srmmu_free_nocache(__nocache_va(p), PTE_SIZE);
 }
 
-/*
- */
+/* context handling - a dynamically sized pool is used */
+#define NO_CONTEXT	-1
+
+struct ctx_list {
+	struct ctx_list *next;
+	struct ctx_list *prev;
+	unsigned int ctx_number;
+	struct mm_struct *ctx_mm;
+};
+
+static struct ctx_list *ctx_list_pool;
+static struct ctx_list ctx_free;
+static struct ctx_list ctx_used;
+
+/* At boot time we determine the number of contexts */
+static int num_contexts;
+
+static inline void remove_from_ctx_list(struct ctx_list *entry)
+{
+	entry->next->prev = entry->prev;
+	entry->prev->next = entry->next;
+}
+
+static inline void add_to_ctx_list(struct ctx_list *head, struct ctx_list *entry)
+{
+	entry->next = head;
+	(entry->prev = head->prev)->next = entry;
+	head->prev = entry;
+}
+#define add_to_free_ctxlist(entry) add_to_ctx_list(&ctx_free, entry)
+#define add_to_used_ctxlist(entry) add_to_ctx_list(&ctx_used, entry)
+
+
 static inline void alloc_context(struct mm_struct *old_mm, struct mm_struct *mm)
 {
 	struct ctx_list *ctxp;
@@ -392,6 +419,26 @@ static inline void free_context(int context)
 	add_to_free_ctxlist(ctx_old);
 }
 
+static void __init sparc_context_init(int numctx)
+{
+	int ctx;
+	unsigned long size;
+
+	size = numctx * sizeof(struct ctx_list);
+	ctx_list_pool = __alloc_bootmem(size, SMP_CACHE_BYTES, 0UL);
+
+	for (ctx = 0; ctx < numctx; ctx++) {
+		struct ctx_list *clist;
+
+		clist = (ctx_list_pool + ctx);
+		clist->ctx_number = ctx;
+		clist->ctx_mm = NULL;
+	}
+	ctx_free.next = ctx_free.prev = &ctx_free;
+	ctx_used.next = ctx_used.prev = &ctx_used;
+	for (ctx = 0; ctx < numctx; ctx++)
+		add_to_free_ctxlist(ctx_list_pool + ctx);
+}
 
 void switch_mm(struct mm_struct *old_mm, struct mm_struct *mm,
 	       struct task_struct *tsk)
@@ -799,9 +846,6 @@ static void __init map_kernel(void)
 	}
 }
 
-/* Paging initialization on the Sparc Reference MMU. */
-extern void sparc_context_init(int);
-
 void (*poke_srmmu)(void) __cpuinitdata = NULL;
 
 extern unsigned long bootmem_init(unsigned long *pages_avail);
@@ -816,6 +860,7 @@ void __init srmmu_paging_init(void)
 	pte_t *pte;
 	unsigned long pages_avail;
 
+	init_mm.context = (unsigned long) NO_CONTEXT;
 	sparc_iomap.start = SUN4M_IOBASE_VADDR;	/* 16MB of IOSPACE on all sun4m's. */
 
 	if (sparc_cpu_model = sun4d)
@@ -918,6 +963,12 @@ void mmu_info(struct seq_file *m)
 		   srmmu_nocache_map.used << SRMMU_NOCACHE_BITMAP_SHIFT);
 }
 
+int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
+{
+	mm->context = NO_CONTEXT;
+	return 0;
+}
+
 void destroy_context(struct mm_struct *mm)
 {
 
-- 
1.6.0.6


From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Fri, 21 Jul 2017 01:51:00 +0000
Subject: [PATCH v1 3/4] sparc64: context domains
Message-Id: <1500601861-203232-4-git-send-email-pasha.tatashin@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This is full context domains with bitmap. Each context domain has a bitmap.
The mm_context_t member sparc64_ctx_val has been replaced with a pointer
to contexts. A context consists of the same parts as before context domain.

The topology is currently simple for sun4v. For sun4u we default to a
single context domain. By default we have one context domain per 16
strands.  For sun4v this represents 64 cpus.

As optimization, when mm is destroyed instead of freeing all valid context
IDs to every domain we simply take a hash lock as a barrier against a race
with wrap. The IDs are recovered when domain is wrapped.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Signed-off-by: Bob Picco <bob.picco@oracle.com>
---
 arch/sparc/include/asm/mmu_64.h         |   13 +-
 arch/sparc/include/asm/mmu_context_64.h |   52 +++++-
 arch/sparc/include/asm/tlb_64.h         |    3 +-
 arch/sparc/include/asm/tlbflush_64.h    |    2 +-
 arch/sparc/kernel/smp_64.c              |   16 +-
 arch/sparc/kernel/unaligned_64.c        |    4 +-
 arch/sparc/mm/fault_64.c                |    4 +-
 arch/sparc/mm/init_64.c                 |  319 +++++++++++++++++++++++++++----
 arch/sparc/mm/tlb.c                     |    4 +-
 arch/sparc/mm/tsb.c                     |   20 +--
 10 files changed, 358 insertions(+), 79 deletions(-)

diff --git a/arch/sparc/include/asm/mmu_64.h b/arch/sparc/include/asm/mmu_64.h
index 83b36a5..06864c1 100644
--- a/arch/sparc/include/asm/mmu_64.h
+++ b/arch/sparc/include/asm/mmu_64.h
@@ -53,10 +53,6 @@
 #define CTX_HW_MASK		(CTX_NR_MASK | CTX_PGSZ_MASK)
 
 #define CTX_FIRST_VERSION	BIT(CTX_VERSION_SHIFT)
-#define CTX_VALID(__ctx)	\
-	 (!(((__ctx.sparc64_ctx_val) ^ tlb_context_cache) & CTX_VERSION_MASK))
-#define CTX_HWBITS(__ctx)	((__ctx.sparc64_ctx_val) & CTX_HW_MASK)
-#define CTX_NRBITS(__ctx)	((__ctx.sparc64_ctx_val) & CTX_NR_MASK)
 
 #ifndef __ASSEMBLY__
 
@@ -89,9 +85,16 @@ struct tsb_config {
 #define MM_NUM_TSBS	1
 #endif
 
+int alloc_context_domain(int cpu);
+void cd_cpu_online(int cpu);
+void cd_cpu_offline(int cpu);
+void cd_cpu_offline(int cpu);
+int mm_cd_alloc(struct mm_struct *mm);
+void mm_cd_destroy(struct mm_struct *mm);
+
 typedef struct {
 	spinlock_t		lock;
-	unsigned long		sparc64_ctx_val;
+	unsigned long		*cds;
 	unsigned long		hugetlb_pte_count;
 	unsigned long		thp_pte_count;
 	struct tsb_config	tsb_block[MM_NUM_TSBS];
diff --git a/arch/sparc/include/asm/mmu_context_64.h b/arch/sparc/include/asm/mmu_context_64.h
index 2cddcda..de931e0 100644
--- a/arch/sparc/include/asm/mmu_context_64.h
+++ b/arch/sparc/include/asm/mmu_context_64.h
@@ -15,9 +15,41 @@ static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 {
 }
 
-extern spinlock_t ctx_alloc_lock;
-extern unsigned long tlb_context_cache;
-extern unsigned long mmu_context_bmap[];
+#define MAX_CTX_NR	BIT(CTX_NR_BITS)
+struct mmu_context_domain {
+	spinlock_t lock;	/* protects context domain */
+	unsigned long tlb_context_cache;
+	unsigned short context_domain_id;
+	DECLARE_BITMAP(bitmap, MAX_CTX_NR);
+	cpumask_t mask;
+};
+
+DECLARE_PER_CPU(struct mmu_context_domain *, mmu_context_domain);
+
+static inline bool mmu_context_valid(struct mm_struct *mm)
+{
+	struct mmu_context_domain *mcdp = __this_cpu_read(mmu_context_domain);
+	unsigned long ctx_val = mm->context.cds[mcdp->context_domain_id];
+	unsigned long ctx_cache = mcdp->tlb_context_cache;
+
+	return !((ctx_val ^ ctx_cache) & CTX_VERSION_MASK);
+}
+
+static inline unsigned long mmu_context_hwbits(struct mm_struct *mm)
+{
+	struct mmu_context_domain *mcdp = __this_cpu_read(mmu_context_domain);
+	unsigned long ctx_val = mm->context.cds[mcdp->context_domain_id];
+
+	return ctx_val & CTX_HW_MASK;
+}
+
+static inline unsigned long mmu_context_nrbits(struct mm_struct *mm)
+{
+	struct mmu_context_domain *mcdp = __this_cpu_read(mmu_context_domain);
+	unsigned long ctx_val = mm->context.cds[mcdp->context_domain_id];
+
+	return ctx_val & CTX_NR_MASK;
+}
 
 DECLARE_PER_CPU(struct mm_struct *, per_cpu_secondary_mm);
 void get_new_mmu_context(struct mm_struct *mm);
@@ -54,6 +86,8 @@ void tsb_grow(struct mm_struct *mm,
 
 /* Set MMU context in the actual hardware. */
 #define load_secondary_context(__mm) \
+{ \
+	unsigned long hwbits = mmu_context_hwbits(mm); \
 	__asm__ __volatile__( \
 	"\n661:	stxa		%0, [%1] %2\n" \
 	"	.section	.sun4v_1insn_patch, \"ax\"\n" \
@@ -62,23 +96,25 @@ void tsb_grow(struct mm_struct *mm,
 	"	.previous\n" \
 	"	flush		%%g6\n" \
 	: /* No outputs */ \
-	: "r" (CTX_HWBITS((__mm)->context)), \
-	  "r" (SECONDARY_CONTEXT), "i" (ASI_DMMU), "i" (ASI_MMU))
+	: "r" (hwbits), \
+	  "r" (SECONDARY_CONTEXT), "i" (ASI_DMMU), "i" (ASI_MMU)); \
+}
 
 void __flush_tlb_mm(unsigned long, unsigned long);
 
 /* Switch the current MM context. */
 static inline void switch_mm(struct mm_struct *old_mm, struct mm_struct *mm, struct task_struct *tsk)
 {
-	unsigned long ctx_valid, flags;
+	unsigned long flags;
 	int cpu = smp_processor_id();
+	bool ctx_valid;
 
 	per_cpu(per_cpu_secondary_mm, cpu) = mm;
 	if (unlikely(mm = &init_mm))
 		return;
 
 	spin_lock_irqsave(&mm->context.lock, flags);
-	ctx_valid = CTX_VALID(mm->context);
+	ctx_valid = mmu_context_valid(mm);
 	if (!ctx_valid)
 		get_new_mmu_context(mm);
 
@@ -121,7 +157,7 @@ static inline void switch_mm(struct mm_struct *old_mm, struct mm_struct *mm, str
 	 */
 	if (!ctx_valid || !cpumask_test_cpu(cpu, mm_cpumask(mm))) {
 		cpumask_set_cpu(cpu, mm_cpumask(mm));
-		__flush_tlb_mm(CTX_HWBITS(mm->context),
+		__flush_tlb_mm(mmu_context_hwbits(mm),
 			       SECONDARY_CONTEXT);
 	}
 	spin_unlock_irqrestore(&mm->context.lock, flags);
diff --git a/arch/sparc/include/asm/tlb_64.h b/arch/sparc/include/asm/tlb_64.h
index 4cb392f..2b5083a 100644
--- a/arch/sparc/include/asm/tlb_64.h
+++ b/arch/sparc/include/asm/tlb_64.h
@@ -16,7 +16,8 @@ void smp_flush_tlb_pending(struct mm_struct *,
 void smp_flush_tlb_mm(struct mm_struct *mm);
 #define do_flush_tlb_mm(mm) smp_flush_tlb_mm(mm)
 #else
-#define do_flush_tlb_mm(mm) __flush_tlb_mm(CTX_HWBITS(mm->context), SECONDARY_CONTEXT)
+#define do_flush_tlb_mm(mm)	\
+	__flush_tlb_mm(mmu_context_hwbits(mm), SECONDARY_CONTEXT)
 #endif
 
 void __flush_tlb_pending(unsigned long, unsigned long, unsigned long *);
diff --git a/arch/sparc/include/asm/tlbflush_64.h b/arch/sparc/include/asm/tlbflush_64.h
index 54be88a..4b41894 100644
--- a/arch/sparc/include/asm/tlbflush_64.h
+++ b/arch/sparc/include/asm/tlbflush_64.h
@@ -54,7 +54,7 @@ static inline void flush_tlb_range(struct vm_area_struct *vma,
 
 static inline void global_flush_tlb_page(struct mm_struct *mm, unsigned long vaddr)
 {
-	__flush_tlb_page(CTX_HWBITS(mm->context), vaddr);
+	__flush_tlb_page(mmu_context_hwbits(mm), vaddr);
 }
 
 #else /* CONFIG_SMP */
diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index 889b8f8..d55d658 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -137,6 +137,7 @@ void smp_callin(void)
 	/* idle thread is expected to have preempt disabled */
 	preempt_disable();
 
+	cd_cpu_online(cpuid);
 	local_irq_enable();
 
 	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
@@ -358,6 +359,9 @@ static int smp_boot_one_cpu(unsigned int cpu, struct task_struct *idle)
 	callin_flag = 0;
 	cpu_new_thread = task_thread_info(idle);
 
+	if (alloc_context_domain(cpu))
+		return -ENOMEM;
+
 	if (tlb_type = hypervisor) {
 #if defined(CONFIG_SUN_LDOMS) && defined(CONFIG_HOTPLUG_CPU)
 		if (ldom_domaining_enabled)
@@ -1069,7 +1073,7 @@ void smp_fetch_global_pmu(void)
 static void tlb_mm_flush_func(void *info)
 {
 	struct mm_struct *mm = (struct mm_struct *)info;
-	u32 ctx = CTX_HWBITS(mm->context);
+	u32 ctx = mmu_context_hwbits(mm);
 
 	__flush_tlb_mm(ctx, SECONDARY_CONTEXT);
 }
@@ -1080,7 +1084,7 @@ static void tlb_mm_flush_func(void *info)
  */
 void smp_flush_tlb_mm(struct mm_struct *mm)
 {
-	u32 ctx = CTX_HWBITS(mm->context);
+	u32 ctx = mmu_context_hwbits(mm);
 	int cpu = get_cpu();
 
 	if (atomic_read(&mm->mm_users) = 1) {
@@ -1106,14 +1110,14 @@ static void tlb_pending_func(void *info)
 {
 	struct tlb_pending_info *t = info;
 	struct mm_struct *mm = t->mm;
-	u32 ctx = CTX_HWBITS(mm->context);
+	u32 ctx = mmu_context_hwbits(mm);
 
 	__flush_tlb_pending(ctx, t->nr, t->vaddrs);
 }
 
 void smp_flush_tlb_pending(struct mm_struct *mm, unsigned long nr, unsigned long *vaddrs)
 {
-	u32 ctx = CTX_HWBITS(mm->context);
+	unsigned long ctx = mmu_context_hwbits(mm);
 	struct tlb_pending_info info;
 	int cpu = get_cpu();
 
@@ -1141,14 +1145,14 @@ static void flush_tlb_page_func(void *info)
 {
 	struct flush_tlb_page_info *t = info;
 	struct mm_struct *mm = t->mm;
-	u32 ctx = CTX_HWBITS(mm->context);
+	u32 ctx = mmu_context_hwbits(mm);
 
 	__flush_tlb_page(ctx, t->vaddr);
 }
 
 void smp_flush_tlb_page(struct mm_struct *mm, unsigned long vaddr)
 {
-	u32 context = CTX_HWBITS(mm->context);
+	u32 context = mmu_context_hwbits(mm);
 	struct flush_tlb_page_info info;
 	int cpu = get_cpu();
 
diff --git a/arch/sparc/kernel/unaligned_64.c b/arch/sparc/kernel/unaligned_64.c
index cda7fd3..1ded482 100644
--- a/arch/sparc/kernel/unaligned_64.c
+++ b/arch/sparc/kernel/unaligned_64.c
@@ -275,8 +275,8 @@ static void kernel_mna_trap_fault(int fixup_tstate_asi)
 			       "request in mna handler");
 	        printk(KERN_ALERT " at virtual address %016lx\n",address);
 		printk(KERN_ALERT "current->{active_,}mm->context = %016lx\n",
-			(current->mm ? CTX_HWBITS(current->mm->context) :
-			CTX_HWBITS(current->active_mm->context)));
+			(current->mm ? mmu_context_hwbits(current->mm) :
+			mmu_context_hwbits(current->active_mm)));
 		printk(KERN_ALERT "current->{active_,}mm->pgd = %016lx\n",
 			(current->mm ? (unsigned long) current->mm->pgd :
 			(unsigned long) current->active_mm->pgd));
diff --git a/arch/sparc/mm/fault_64.c b/arch/sparc/mm/fault_64.c
index b84c4dd..137b7d9 100644
--- a/arch/sparc/mm/fault_64.c
+++ b/arch/sparc/mm/fault_64.c
@@ -64,8 +64,8 @@ static void __kprobes unhandled_fault(unsigned long address,
 	}
 	printk(KERN_ALERT "tsk->{mm,active_mm}->context = %016lx\n",
 	       (tsk->mm ?
-		CTX_HWBITS(tsk->mm->context) :
-		CTX_HWBITS(tsk->active_mm->context)));
+		mmu_context_hwbits(tsk->mm) :
+		mmu_context_hwbits(tsk->active_mm)));
 	printk(KERN_ALERT "tsk->{mm,active_mm}->pgd = %016lx\n",
 	       (tsk->mm ? (unsigned long) tsk->mm->pgd :
 		          (unsigned long) tsk->active_mm->pgd));
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 3c40ebd..8c61fbc 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -27,6 +27,7 @@
 #include <linux/memblock.h>
 #include <linux/mmzone.h>
 #include <linux/gfp.h>
+#include <linux/smp.h>
 
 #include <asm/head.h>
 #include <asm/page.h>
@@ -706,29 +707,75 @@ void __flush_dcache_range(unsigned long start, unsigned long end)
 EXPORT_SYMBOL(__flush_dcache_range);
 
 /* get_new_mmu_context() uses "cache + 1".  */
-DEFINE_SPINLOCK(ctx_alloc_lock);
-unsigned long tlb_context_cache = CTX_FIRST_VERSION;
-#define MAX_CTX_NR	(1UL << CTX_NR_BITS)
-#define CTX_BMAP_SLOTS	BITS_TO_LONGS(MAX_CTX_NR)
-DECLARE_BITMAP(mmu_context_bmap, MAX_CTX_NR);
 DEFINE_PER_CPU(struct mm_struct *, per_cpu_secondary_mm) = {0};
 
-static void mmu_context_wrap(void)
+/* This mmu_wrap hash lock is to protect a use after free within
+ * mmu_context_wrap(). A mondo arrives after wrap loads an mm from
+ * per_cpu_secondary_mm. mmu_context_wrap() proceeds to update
+ * an mm about to be freed within mm_cd_destroy(). We establish a
+ * barrier to prevent use after free from occurring.
+ */
+#define	MMU_WRAP_HASH_SIZE	(16)
+#define	MMU_WRAP_HASH_MASK	(MMU_WRAP_HASH_SIZE - 1)
+#define	MMU_WRAP_MM_SHIFT	(ilog2(sizeof(struct mm_struct) - 1) + 1)
+static spinlock_t mmu_wrap_hlock[MMU_WRAP_HASH_SIZE];
+
+static __init void mmu_wrap_lock_init(void)
 {
-	unsigned long old_ver = tlb_context_cache & CTX_VERSION_MASK;
-	unsigned long new_ver, new_ctx, old_ctx;
+	int hindex;
+
+	for (hindex = 0; hindex < MMU_WRAP_HASH_SIZE; hindex++)
+		spin_lock_init(&mmu_wrap_hlock[hindex]);
+}
+
+static unsigned long mmu_wrap_hlock_enter(void)
+{
+	unsigned long flags;
+	int hindex;
+
+	local_irq_save(flags);
+	local_irq_disable();
+	for (hindex = 0; hindex < MMU_WRAP_HASH_SIZE; hindex++)
+		spin_lock(&mmu_wrap_hlock[hindex]);
+
+	return flags;
+}
+
+static void mmu_wrap_hlock_exit(unsigned long flags)
+{
+	int hindex;
+
+	for (hindex = 0; hindex < MMU_WRAP_HASH_SIZE; hindex++)
+		spin_unlock(&mmu_wrap_hlock[hindex]);
+	local_irq_restore(flags);
+}
+
+static spinlock_t *mmu_wrap_get_hlock(struct mm_struct *mm)
+{
+	unsigned long val = ((unsigned long)mm) >> MMU_WRAP_MM_SHIFT;
+	int hindex = (val ^ get_rand_tick()) & MMU_WRAP_HASH_MASK;
+
+	return &mmu_wrap_hlock[hindex];
+}
+
+static void mmu_context_wrap(struct mmu_context_domain *mcdp)
+{
+	unsigned long old_ver = mcdp->tlb_context_cache & CTX_VERSION_MASK;
+	unsigned long new_ver, new_ctx, old_ctx, flags;
+	unsigned short cd_id = mcdp->context_domain_id;
 	struct mm_struct *mm;
 	int cpu;
 
-	bitmap_zero(mmu_context_bmap, 1 << CTX_NR_BITS);
+	bitmap_zero(mcdp->bitmap, 1 << CTX_NR_BITS);
 
 	/* Reserve kernel context */
-	set_bit(0, mmu_context_bmap);
+	set_bit(0, mcdp->bitmap);
 
-	new_ver = (tlb_context_cache & CTX_VERSION_MASK) + CTX_FIRST_VERSION;
+	new_ver = (mcdp->tlb_context_cache & CTX_VERSION_MASK) +
+		   CTX_FIRST_VERSION;
 	if (unlikely(new_ver = 0))
 		new_ver = CTX_FIRST_VERSION;
-	tlb_context_cache = new_ver;
+	mcdp->tlb_context_cache = new_ver;
 
 	/*
 	 * Make sure that any new mm that are added into per_cpu_secondary_mm,
@@ -736,11 +783,13 @@ static void mmu_context_wrap(void)
 	 */
 	mb();
 
+	flags = mmu_wrap_hlock_enter();
+
 	/*
 	 * Updated versions to current on those CPUs that had valid secondary
-	 * contexts
+	 * contexts within this context domain.
 	 */
-	for_each_online_cpu(cpu) {
+	for_each_cpu(cpu, &mcdp->mask) {
 		/*
 		 * If a new mm is stored after we took this mm from the array,
 		 * it will go into get_new_mmu_context() path, because we
@@ -751,17 +800,18 @@ static void mmu_context_wrap(void)
 		if (unlikely(!mm || mm = &init_mm))
 			continue;
 
-		old_ctx = mm->context.sparc64_ctx_val;
+		old_ctx = mm->context.cds[cd_id];
 		if (likely((old_ctx & CTX_VERSION_MASK) = old_ver)) {
 			new_ctx = (old_ctx & ~CTX_VERSION_MASK) | new_ver;
-			set_bit(new_ctx & CTX_NR_MASK, mmu_context_bmap);
-			mm->context.sparc64_ctx_val = new_ctx;
+			set_bit(new_ctx & CTX_NR_MASK, mcdp->bitmap);
+			mm->context.cds[cd_id] = new_ctx;
 		}
 	}
+	mmu_wrap_hlock_exit(flags);
 }
 
 /* Caller does TLB context flushing on local CPU if necessary.
- * The caller also ensures that CTX_VALID(mm->context) is false.
+ * The caller also ensures that mmu_context_valid(mm) is false.
  *
  * We must be careful about boundary cases so that we never
  * let the user have CTX 0 (nucleus) or we ever use a CTX
@@ -772,32 +822,34 @@ static void mmu_context_wrap(void)
  */
 void get_new_mmu_context(struct mm_struct *mm)
 {
-	unsigned long ctx, new_ctx;
+	struct mmu_context_domain *mcdp = __this_cpu_read(mmu_context_domain);
+	unsigned short cd_id = mcdp->context_domain_id;
 	unsigned long orig_pgsz_bits;
+	unsigned long ctx, new_ctx;
 
-	spin_lock(&ctx_alloc_lock);
+	spin_lock(&mcdp->lock);
 retry:
 	/* wrap might have happened, test again if our context became valid */
-	if (unlikely(CTX_VALID(mm->context)))
+	if (unlikely(mmu_context_valid(mm)))
 		goto out;
-	orig_pgsz_bits = (mm->context.sparc64_ctx_val & CTX_PGSZ_MASK);
-	ctx = (tlb_context_cache + 1) & CTX_NR_MASK;
-	new_ctx = find_next_zero_bit(mmu_context_bmap, 1 << CTX_NR_BITS, ctx);
+	orig_pgsz_bits = (mm->context.cds[cd_id] & CTX_PGSZ_MASK);
+	ctx = (mcdp->tlb_context_cache + 1) & CTX_NR_MASK;
+	new_ctx = find_next_zero_bit(mcdp->bitmap, 1 << CTX_NR_BITS, ctx);
 	if (new_ctx >= (1 << CTX_NR_BITS)) {
-		new_ctx = find_next_zero_bit(mmu_context_bmap, ctx, 1);
+		new_ctx = find_next_zero_bit(mcdp->bitmap, ctx, 1);
 		if (new_ctx >= ctx) {
-			mmu_context_wrap();
+			mmu_context_wrap(mcdp);
 			goto retry;
 		}
 	}
-	if (mm->context.sparc64_ctx_val)
-		cpumask_clear(mm_cpumask(mm));
-	mmu_context_bmap[new_ctx>>6] |= (1UL << (new_ctx & 63));
-	new_ctx |= (tlb_context_cache & CTX_VERSION_MASK);
-	tlb_context_cache = new_ctx;
-	mm->context.sparc64_ctx_val = new_ctx | orig_pgsz_bits;
+	if (mm->context.cds[cd_id])
+		cpumask_andnot(mm_cpumask(mm), mm_cpumask(mm), &mcdp->mask);
+	set_bit(new_ctx, mcdp->bitmap);
+	new_ctx |= (mcdp->tlb_context_cache & CTX_VERSION_MASK);
+	mcdp->tlb_context_cache = new_ctx;
+	mm->context.cds[cd_id] = new_ctx | orig_pgsz_bits;
 out:
-	spin_unlock(&ctx_alloc_lock);
+	spin_unlock(&mcdp->lock);
 }
 
 static int numa_enabled = 1;
@@ -2237,6 +2289,192 @@ static void __init reduce_memory(phys_addr_t limit_ram)
 	}
 }
 
+DEFINE_PER_CPU(struct mmu_context_domain *, mmu_context_domain) = {NULL};
+struct mmu_context_domain **mcds __read_mostly;
+/* T3 has 16 cpu threads per core */
+static const unsigned short max_strands_to_core = 16;
+static unsigned short cores_to_context_domain = 1;
+static unsigned short strands_to_context_domain __read_mostly;
+static unsigned short nr_context_domains __read_mostly;
+
+static unsigned short cpu_to_context_domain_id(int cpu)
+{
+	return cpu / strands_to_context_domain;
+}
+
+static void __init context_domains_init(void)
+{
+	phys_addr_t cda_size;
+	unsigned long phys;
+
+	cda_size = nr_context_domains * sizeof(struct mmu_context_domain *);
+	cda_size = roundup(cda_size, PAGE_SIZE);
+
+	phys = memblock_alloc(cda_size, PAGE_SIZE);
+	if (!phys) {
+		prom_printf("Failed to allocate cd pointer array.\n");
+		prom_halt();
+	}
+	mcds = __va(phys);
+}
+
+static void alloc_context_domain_init(int cpu, struct mmu_context_domain *mcdp)
+{
+	unsigned short cd_id = cpu_to_context_domain_id(cpu);
+
+	mcds[cd_id] = mcdp;
+	mcdp->context_domain_id = cd_id;
+	spin_lock_init(&mcdp->lock);
+	mcdp->tlb_context_cache = CTX_FIRST_VERSION;
+	cpumask_clear(&mcdp->mask);
+	bitmap_clear(mcdp->bitmap, 0, MAX_CTX_NR);
+	set_bit(0, mcdp->bitmap);
+	pr_info("context domain %d allocated for cpu=%d.\n", cd_id, cpu);
+}
+
+static __init void _alloc_context_domain(int cpu)
+{
+	phys_addr_t cd_size = sizeof(struct mmu_context_domain);
+	struct mmu_context_domain *mcdp;
+	int nid = cpu_to_node(cpu);
+	unsigned long phys;
+
+	phys = memblock_alloc_nid(cd_size, PAGE_SIZE, nid);
+	if (!phys) {
+		prom_printf("Failed to allocate context domain.\n");
+		prom_halt();
+		/* not reached */
+	}
+	mcdp = __va(phys);
+	alloc_context_domain_init(cpu, mcdp);
+}
+
+int alloc_context_domain(int cpu)
+{
+	phys_addr_t cd_size = sizeof(struct mmu_context_domain);
+	unsigned short cd_id = cpu_to_context_domain_id(cpu);
+	struct mmu_context_domain *mcdp;
+	int nid = cpu_to_node(cpu);
+	struct page *page;
+
+	if (mcds[cd_id])
+		return 0;
+
+	page = __alloc_pages_node(nid, GFP_KERNEL, get_order(cd_size));
+	if (!page) {
+		pr_crit("%s: failed to allocate context domain.\n",
+			__func__);
+		return -ENOMEM;
+	}
+	mcdp = (void *)page_address(page);
+	alloc_context_domain_init(cpu, mcdp);
+
+	return 0;
+}
+
+void cd_cpu_offline(int cpu)
+{
+	struct mmu_context_domain *mcdp = per_cpu(mmu_context_domain, cpu);
+
+	per_cpu(mmu_context_domain, cpu) = NULL;
+	cpumask_clear_cpu(cpu, &mcdp->mask);
+}
+
+void cd_cpu_online(int cpu)
+{
+	unsigned short cd_id = cpu_to_context_domain_id(cpu);
+	struct mmu_context_domain *mcdp = mcds[cd_id];
+
+	BUG_ON(!mcdp);
+	__this_cpu_write(mmu_context_domain, mcdp);
+	cpumask_set_cpu(cpu, &mcdp->mask);
+}
+
+static void init_mm_cd_init(struct mm_struct *mm, unsigned long *cds)
+{
+	size_t cds_size = nr_context_domains * sizeof(unsigned long);
+
+	memset(cds, 0, cds_size);
+	mm->context.cds = cds;
+}
+
+static __init void _mm_cd_alloc(struct mm_struct *mm, int cpu)
+{
+	phys_addr_t cds_size = nr_context_domains * sizeof(unsigned long);
+	int nid = cpu_to_node(cpu);
+	unsigned long phys, *cds;
+
+	phys = memblock_alloc_nid(cds_size, PAGE_SIZE, nid);
+	if (!phys) {
+		prom_printf("Failed to allocate mm_context cds array.\n");
+		prom_halt();
+		/* not reached */
+	}
+	cds = __va(phys);
+	init_mm_cd_init(mm, cds);
+}
+
+int mm_cd_alloc(struct mm_struct *mm)
+{
+	unsigned long *cds;
+
+	cds = kmalloc_array(nr_context_domains,  sizeof(unsigned long),
+			    GFP_KERNEL);
+	if (!cds) {
+		pr_crit("%s: failed to allocate mm_context cds.\n", __func__);
+		return -ENOMEM;
+	}
+	init_mm_cd_init(mm, cds);
+	return 0;
+}
+
+/* You must consider the synchronization between mmu_context_wrap() and
+ * mm_cd_destroy() before modifying mm_cd_destroy(). mmu_context_wrap()
+ * examines each per_cpu_secondary_mm which is a member of this context
+ * domain.
+ * We do not release the context id-s during mm_cd_destroy(). wrap
+ * handles the context id release. We need to avoid a race with wrap
+ * during mm context destroy.
+ */
+void mm_cd_destroy(struct mm_struct *mm)
+{
+	spinlock_t *hl = mmu_wrap_get_hlock(mm);
+	unsigned long flags;
+
+	spin_lock_irqsave(hl, flags);
+	spin_unlock_irqrestore(hl, flags);
+	kfree(mm->context.cds);
+	mm->context.cds = NULL;
+}
+
+static __init void init_context_domains(void)
+{
+	int cpu = hard_smp_processor_id();
+
+	if (tlb_type != hypervisor || !IS_BUILTIN(CONFIG_SMP))
+		cores_to_context_domain = 0;
+
+	if (cores_to_context_domain = 0) {
+		strands_to_context_domain = num_possible_cpus();
+	} else {
+		strands_to_context_domain = cores_to_context_domain *
+			max_strands_to_core;
+	}
+
+	nr_context_domains = (num_possible_cpus() +
+			      strands_to_context_domain - 1) /
+			      strands_to_context_domain;
+
+	pr_info("%s: nr_context_domains=%u strands_to_context_domain=%u\n",
+		__func__, nr_context_domains, strands_to_context_domain);
+
+	mmu_wrap_lock_init();
+	context_domains_init();
+	_alloc_context_domain(cpu);
+	_mm_cd_alloc(&init_mm, cpu);
+	cd_cpu_online(cpu);
+}
+
 void __init paging_init(void)
 {
 	unsigned long end_pfn, shift, phys_base;
@@ -2341,8 +2579,6 @@ void __init paging_init(void)
 	memblock_allow_resize();
 	memblock_dump_all();
 
-	set_bit(0, mmu_context_bmap);
-
 	shift = kern_base + PAGE_OFFSET - ((unsigned long)KERNBASE);
 
 	real_end = (unsigned long)_end;
@@ -2421,6 +2657,7 @@ void __init paging_init(void)
 		free_area_init_nodes(max_zone_pfns);
 	}
 
+	init_context_domains();
 	printk("Booting Linux...\n");
 }
 
@@ -2970,15 +3207,17 @@ void hugetlb_setup(struct pt_regs *regs)
 	 */
 	if (tlb_type = cheetah_plus) {
 		bool need_context_reload = false;
+		struct mmu_context_domain *mcdp;
 		unsigned long ctx;
 
-		spin_lock_irq(&ctx_alloc_lock);
-		ctx = mm->context.sparc64_ctx_val;
+		mcdp  = __this_cpu_read(mmu_context_domain);
+		spin_lock_irq(&mcdp->lock);
+		ctx = mm->context.cds[mcdp->context_domain_id];
 		ctx &= ~CTX_PGSZ_MASK;
 		ctx |= CTX_PGSZ_BASE << CTX_PGSZ0_SHIFT;
 		ctx |= CTX_PGSZ_HUGE << CTX_PGSZ1_SHIFT;
 
-		if (ctx != mm->context.sparc64_ctx_val) {
+		if (ctx != mm->context.cds[mcdp->context_domain_id]) {
 			/* When changing the page size fields, we
 			 * must perform a context flush so that no
 			 * stale entries match.  This flush must
@@ -2990,10 +3229,10 @@ void hugetlb_setup(struct pt_regs *regs)
 			/* Reload the context register of all processors
 			 * also executing in this address space.
 			 */
-			mm->context.sparc64_ctx_val = ctx;
+			mm->context.cds[mcdp->context_domain_id] = ctx;
 			need_context_reload = true;
 		}
-		spin_unlock_irq(&ctx_alloc_lock);
+		spin_unlock_irq(&mcdp->lock);
 
 		if (need_context_reload)
 			on_each_cpu(context_reload, mm, 0);
diff --git a/arch/sparc/mm/tlb.c b/arch/sparc/mm/tlb.c
index ee8066c..f663c9d 100644
--- a/arch/sparc/mm/tlb.c
+++ b/arch/sparc/mm/tlb.c
@@ -30,7 +30,7 @@ void flush_tlb_pending(void)
 
 	flush_tsb_user(tb);
 
-	if (CTX_VALID(mm->context)) {
+	if (mmu_context_valid(mm)) {
 		if (tb->tlb_nr = 1) {
 			global_flush_tlb_page(mm, tb->vaddrs[0]);
 		} else {
@@ -38,7 +38,7 @@ void flush_tlb_pending(void)
 			smp_flush_tlb_pending(tb->mm, tb->tlb_nr,
 					      &tb->vaddrs[0]);
 #else
-			__flush_tlb_pending(CTX_HWBITS(tb->mm->context),
+			__flush_tlb_pending(mmu_context_hwbits(mm),
 					    tb->tlb_nr, &tb->vaddrs[0]);
 #endif
 		}
diff --git a/arch/sparc/mm/tsb.c b/arch/sparc/mm/tsb.c
index 0d4b998..20d34c6 100644
--- a/arch/sparc/mm/tsb.c
+++ b/arch/sparc/mm/tsb.c
@@ -543,8 +543,6 @@ int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 
 	spin_lock_init(&mm->context.lock);
 
-	mm->context.sparc64_ctx_val = 0UL;
-
 #if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)
 	/* We reset them to zero because the fork() page copying
 	 * will re-increment the counters as the parent PTEs are
@@ -565,6 +563,9 @@ int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 	for (i = 0; i < MM_NUM_TSBS; i++)
 		mm->context.tsb_block[i].tsb = NULL;
 
+	if (mm_cd_alloc(mm))
+		return -ENOMEM;
+
 	/* If this is fork, inherit the parent's TSB size.  We would
 	 * grow it to that size on the first page fault anyways.
 	 */
@@ -577,8 +578,10 @@ int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 			 REAL_HPAGE_PER_HPAGE);
 #endif
 
-	if (unlikely(!mm->context.tsb_block[MM_TSB_BASE].tsb))
+	if (unlikely(!mm->context.tsb_block[MM_TSB_BASE].tsb)) {
+		mm_cd_destroy(mm);
 		return -ENOMEM;
+	}
 
 	return 0;
 }
@@ -597,17 +600,10 @@ static void tsb_destroy_one(struct tsb_config *tp)
 
 void destroy_context(struct mm_struct *mm)
 {
-	unsigned long flags, i;
+	unsigned long i;
 
 	for (i = 0; i < MM_NUM_TSBS; i++)
 		tsb_destroy_one(&mm->context.tsb_block[i]);
 
-	spin_lock_irqsave(&ctx_alloc_lock, flags);
-
-	if (CTX_VALID(mm->context)) {
-		unsigned long nr = CTX_NRBITS(mm->context);
-		mmu_context_bmap[nr>>6] &= ~(1UL << (nr & 63));
-	}
-
-	spin_unlock_irqrestore(&ctx_alloc_lock, flags);
+	mm_cd_destroy(mm);
 }
-- 
1.7.1


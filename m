From: Bob Picco <bob.picco@oracle.com>
Date: Wed, 01 Feb 2017 12:38:22 +0000
Subject: [PATCH 2/3] sparc64: tsb size expansion
Message-Id: <20170201123823.6273-3-bob.picco@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: bob picco <bob.picco@oracle.com>

Some larger applications require a TSB size of magnitude not required by a
vast majority of processes. This commit enables the TSB to be expanded
to a size up to MAX_ORDER - 1, limited by TSB size order encoding and
finally limited by MMU hardware. The large TSB page order allocations are
not included in a kmem cache like current TSB sizes. The improvement is
done for tlb_type hypervisor and limited to recent sun4v. This patch should
not impact performance of other sparc64 core chip types.

Signed-off-by: Bob Picco <bob.picco@oracle.com>
---
 arch/sparc/include/asm/spitfire.h |   2 +-
 arch/sparc/mm/tsb.c               | 201 +++++++++++++++++++++++++++-----------
 2 files changed, 144 insertions(+), 59 deletions(-)

diff --git a/arch/sparc/include/asm/spitfire.h b/arch/sparc/include/asm/spitfire.h
index 1852a8618001..b6555ead57f1 100644
--- a/arch/sparc/include/asm/spitfire.h
+++ b/arch/sparc/include/asm/spitfire.h
@@ -39,7 +39,7 @@
 
 #define HV_TSB_SIZE_BASE	0x200	/* 512 TTE-s minimum.		*/
 #define	HV_TSB_SIZE_BASE_SHIFT	0x09	/* Shift of minimum tsb size.	*/
-#define	HV_TSB_SIZE_MASK	0x07	/* Size encoding of tsb.	*/
+#define	HV_TSB_SIZE_MASK	0x0f	/* Size encoding of tsb.	*/
 #define	HV_TSB_TTE_SIZE_SHIFT	0x04	/* Sixteen byte tte size.	*/
 
 #define L1DCACHE_SIZE		0x4000
diff --git a/arch/sparc/mm/tsb.c b/arch/sparc/mm/tsb.c
index e20fbbafb0b0..395ad425ea41 100644
--- a/arch/sparc/mm/tsb.c
+++ b/arch/sparc/mm/tsb.c
@@ -13,6 +13,7 @@
 #include <asm/tsb.h>
 #include <asm/tlb.h>
 #include <asm/oplib.h>
+#include <asm/mdesc.h>
 
 extern struct tsb swapper_tsb[KERNEL_TSB_NENTRIES];
 
@@ -145,9 +146,11 @@ void flush_tsb_user_page(struct mm_struct *mm, unsigned long vaddr, bool huge)
 #define HV_PGSZ_MASK_HUGE	HV_PGSZ_MASK_4MB
 #endif
 
-static void setup_tsb_params(struct mm_struct *mm, unsigned long tsb_idx, unsigned long tsb_bytes)
+static void setup_tsb_params(struct mm_struct *mm, unsigned long tsb_idx,
+			     unsigned long tsb_bytes)
 {
-	unsigned long tsb_reg, base, tsb_paddr;
+	unsigned long tsb_reg = get_order(tsb_bytes);
+	unsigned long base, tsb_paddr;
 	unsigned long page_sz, tte;
 
 	mm->context.tsb_block[tsb_idx].tsb_nentries @@ -173,50 +176,27 @@ static void setup_tsb_params(struct mm_struct *mm, unsigned long tsb_idx, unsign
 	/* Use the smallest page size that can map the whole TSB
 	 * in one TLB entry.
 	 */
-	switch (tsb_bytes) {
-	case 8192 << 0:
-		tsb_reg = 0x0UL;
+	switch (tsb_reg) {
+	case 0:
 #ifdef DCACHE_ALIASING_POSSIBLE
 		base += (tsb_paddr & 8192);
 #endif
 		page_sz = 8192;
 		break;
-
-	case 8192 << 1:
-		tsb_reg = 0x1UL;
-		page_sz = 64 * 1024;
-		break;
-
-	case 8192 << 2:
-		tsb_reg = 0x2UL;
+	case 1 ... 3:
 		page_sz = 64 * 1024;
 		break;
-
-	case 8192 << 3:
-		tsb_reg = 0x3UL;
-		page_sz = 64 * 1024;
-		break;
-
-	case 8192 << 4:
-		tsb_reg = 0x4UL;
-		page_sz = 512 * 1024;
-		break;
-
-	case 8192 << 5:
-		tsb_reg = 0x5UL;
-		page_sz = 512 * 1024;
-		break;
-
-	case 8192 << 6:
-		tsb_reg = 0x6UL;
+	case 4 ... 6:
 		page_sz = 512 * 1024;
 		break;
-
-	case 8192 << 7:
-		tsb_reg = 0x7UL;
+	case 7:
 		page_sz = 4 * 1024 * 1024;
 		break;
-
+	case 8 ... HV_TSB_SIZE_MASK:
+		/* This case should only be selected by supported sun4v. */
+		/* page_sz not used by sun4v but validly warned by gcc. */
+		page_sz = PAGE_MASK;
+		break;
 	default:
 		printk(KERN_ERR "TSB[%s:%d]: Impossible TSB size %lu, killing process.\n",
 		       current->comm, current->pid, tsb_bytes);
@@ -279,9 +259,9 @@ static void setup_tsb_params(struct mm_struct *mm, unsigned long tsb_idx, unsign
 
 struct kmem_cache *pgtable_cache __read_mostly;
 
-static struct kmem_cache *tsb_caches[8] __read_mostly;
-
-static const char *tsb_cache_names[8] = {
+#define	MAX_TSB_CACHES	(8)
+static struct kmem_cache *tsb_caches[MAX_TSB_CACHES] __read_mostly;
+static const char *tsb_cache_names[MAX_TSB_CACHES] = {
 	"tsb_8KB",
 	"tsb_16KB",
 	"tsb_32KB",
@@ -292,6 +272,85 @@ static const char *tsb_cache_names[8] = {
 	"tsb_1MB",
 };
 
+#define MAX_TSB_ORDER	(15)
+#define	TSB_ALLOC_ORDER	(((MAX_ORDER - 1) < MAX_TSB_ORDER) ?		\
+			   (MAX_ORDER - 1) : MAX_TSB_ORDER)
+static const unsigned long tsb_size_max __initconst = 1UL <<
+	(PAGE_SHIFT + TSB_ALLOC_ORDER);
+static const unsigned long tsb_cache_size_max __initconst = 1UL <<
+	(PAGE_SHIFT + MAX_TSB_CACHES - 1);
+static const unsigned long encoded_tsb_size_max __initconst = 1UL <<
+	(HV_TSB_SIZE_BASE_SHIFT + HV_TSB_TTE_SIZE_SHIFT + HV_TSB_SIZE_MASK);
+static unsigned long tsb_size_limit;
+
+static unsigned long __init mdesc_find_max_tsb(void)
+{
+	struct mdesc_handle *hp = mdesc_grab();
+	unsigned long max_tsb_size = 0UL;
+	u64 pn;
+
+	pn = mdesc_node_by_name(hp, MDESC_NODE_NULL, "cpu");
+
+	if (pn != MDESC_NODE_NULL) {
+		u64 *val = (u64 *) mdesc_get_property(hp, pn,
+						 "mmu-max-tsb-entries",
+						  NULL);
+		if (val) {
+			unsigned long tsb_entries = *val;
+
+			max_tsb_size = tsb_entries << HV_TSB_TTE_SIZE_SHIFT;
+		}
+	}
+
+	mdesc_release(hp);
+
+	return max_tsb_size;
+}
+
+static unsigned long __init chip_type_find_max_tsb(void)
+{
+	unsigned long max_size = tsb_cache_size_max;
+
+	switch (sun4v_chip_type) {
+	/* For any sun4v but those selected in case use kmem cache maximum. */
+	case SUN4V_CHIP_NIAGARA4 ... SUN4V_CHIP_SPARC_M7:
+		max_size = encoded_tsb_size_max;
+		break;
+	default:
+		break;
+	}
+
+	return max_size;
+}
+
+/* This all seems a little complicated but there are: sun4u (no machine
+ * description), sun4v (machine description but no property for tsb max entries)
+ * and sun4v with property. Plus MAX_ORDER constrained at our limit.
+ */
+static unsigned long __init establish_max_tsb_size(void)
+{
+	unsigned long size = tsb_cache_size_max;
+	unsigned long hv_size;
+
+	BUILD_BUG_ON(MAX_TSB_ORDER > HV_TSB_SIZE_MASK);
+
+	/* For not hypervisor keep the tsb within the kmem cache. */
+	if (tlb_type != hypervisor)
+		goto out;
+
+	hv_size = mdesc_find_max_tsb();
+
+	if (hv_size)
+		size = hv_size;
+	else
+		size = chip_type_find_max_tsb();
+
+	if (size > tsb_size_max)
+		size = tsb_size_max;
+out:
+	return size;
+}
+
 void __init pgtable_cache_init(void)
 {
 	unsigned long i;
@@ -317,6 +376,35 @@ void __init pgtable_cache_init(void)
 			prom_halt();
 		}
 	}
+
+	tsb_size_limit = establish_max_tsb_size();
+}
+
+static void *tsb_allocate(unsigned int tsb_order, gfp_t gfp)
+{
+	int nid = numa_node_id();
+	void *tsb = NULL;
+
+	if (tsb_order < MAX_TSB_CACHES)
+		tsb = kmem_cache_alloc_node(tsb_caches[tsb_order], gfp, nid);
+	else {
+		struct page *page;
+
+		page = __alloc_pages_node(nid, gfp, tsb_order);
+
+		if (page)
+			tsb = (void *) page_address(page);
+	}
+
+	return tsb;
+}
+
+static void tsb_free(void *tsb, unsigned int tsb_order)
+{
+	if (tsb_order < MAX_TSB_CACHES)
+		kmem_cache_free(tsb_caches[tsb_order], tsb);
+	else
+		free_pages((unsigned long) tsb, tsb_order);
 }
 
 int sysctl_tsb_ratio = -2;
@@ -338,10 +426,11 @@ static unsigned long tsb_size_to_rss_limit(unsigned long new_size)
  * tsb_rss_limit for that TSB so the grow checks in do_sparc64_fault()
  * will not trigger any longer.
  *
- * The TSB can be anywhere from 8K to 1MB in size, in increasing powers
- * of two.  The TSB must be aligned to it's size, so f.e. a 512K TSB
- * must be 512K aligned.  It also must be physically contiguous, so we
- * cannot use vmalloc().
+ * The TSB can be anywhere from 8K to (1ul << (PAGE_SHIFT + HV_TSB_SIZE_MASK)
+ * in size, in increasing powers of two.  The TSB must be aligned to it's
+ * size, so f.e. a 512K TSB must be 512K aligned. It also must be physically
+ * contiguous, so we cannot use vmalloc(). Older sparc64 are limited
+ * to kmem cache size of 1MB. A tsb larger than 1MB is not in kmem cache.
  *
  * The idea here is to grow the TSB when the RSS of the process approaches
  * the number of entries that the current TSB can hold at once.  Currently,
@@ -349,18 +438,15 @@ static unsigned long tsb_size_to_rss_limit(unsigned long new_size)
  */
 void tsb_grow(struct mm_struct *mm, unsigned long tsb_index, unsigned long rss)
 {
-	unsigned long max_tsb_size = 1 * 1024 * 1024;
+	unsigned long new_rss_limit = PAGE_SIZE / sizeof(struct tsb);
+	unsigned long new_cache_index, old_cache_index;
+	unsigned long max_tsb_size = tsb_size_limit;
 	unsigned long new_size, old_size, flags;
 	struct tsb *old_tsb, *new_tsb;
-	unsigned long new_cache_index, old_cache_index;
-	unsigned long new_rss_limit;
 	gfp_t gfp_flags;
 
-	if (max_tsb_size > (PAGE_SIZE << MAX_ORDER))
-		max_tsb_size = (PAGE_SIZE << MAX_ORDER);
-
 	new_cache_index = 0;
-	for (new_size = 8192; new_size < max_tsb_size; new_size <<= 1UL) {
+	for (new_size = PAGE_SIZE; new_size < max_tsb_size; new_size <<= 1UL) {
 		new_rss_limit = tsb_size_to_rss_limit(new_size);
 		if (new_rss_limit > rss)
 			break;
@@ -375,8 +461,7 @@ void tsb_grow(struct mm_struct *mm, unsigned long tsb_index, unsigned long rss)
 	if (new_size > (PAGE_SIZE * 2))
 		gfp_flags |= __GFP_NOWARN | __GFP_NORETRY;
 
-	new_tsb = kmem_cache_alloc_node(tsb_caches[new_cache_index],
-					gfp_flags, numa_node_id());
+	new_tsb = tsb_allocate(new_cache_index, gfp_flags);
 	if (unlikely(!new_tsb)) {
 		/* Not being able to fork due to a high-order TSB
 		 * allocation failure is very bad behavior.  Just back
@@ -427,8 +512,8 @@ void tsb_grow(struct mm_struct *mm, unsigned long tsb_index, unsigned long rss)
 	spin_lock_irqsave(&mm->context.lock, flags);
 
 	old_tsb = mm->context.tsb_block[tsb_index].tsb;
-	old_cache_index -		(mm->context.tsb_block[tsb_index].tsb_reg_val & 0x7UL);
+	old_cache_index = mm->context.tsb_block[tsb_index].tsb_reg_val &
+			  HV_TSB_SIZE_MASK;
 	old_size = (mm->context.tsb_block[tsb_index].tsb_nentries *
 		    sizeof(struct tsb));
 
@@ -441,7 +526,7 @@ void tsb_grow(struct mm_struct *mm, unsigned long tsb_index, unsigned long rss)
 		     (rss < mm->context.tsb_block[tsb_index].tsb_rss_limit))) {
 		spin_unlock_irqrestore(&mm->context.lock, flags);
 
-		kmem_cache_free(tsb_caches[new_cache_index], new_tsb);
+		tsb_free(new_tsb, new_cache_index);
 		return;
 	}
 
@@ -480,7 +565,7 @@ void tsb_grow(struct mm_struct *mm, unsigned long tsb_index, unsigned long rss)
 		preempt_enable();
 
 		/* Now it is safe to free the old tsb.  */
-		kmem_cache_free(tsb_caches[old_cache_index], old_tsb);
+		tsb_free(old_tsb, old_cache_index);
 	}
 }
 
@@ -537,12 +622,12 @@ int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 
 static void tsb_destroy_one(struct tsb_config *tp)
 {
-	unsigned long cache_index;
+	unsigned long tsb_order;
 
 	if (!tp->tsb)
 		return;
-	cache_index = tp->tsb_reg_val & 0x7UL;
-	kmem_cache_free(tsb_caches[cache_index], tp->tsb);
+	tsb_order = tp->tsb_reg_val & HV_TSB_SIZE_MASK;
+	tsb_free(tp->tsb, tsb_order);
 	tp->tsb = NULL;
 	tp->tsb_reg_val = 0UL;
 }
-- 
2.11.0


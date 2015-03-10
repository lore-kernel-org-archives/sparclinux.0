From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Tue, 10 Mar 2015 22:27:05 +0000
Subject: [PATCH v3 RFC 3/3] sparc: Make LDC use common iommu poll management functions
Message-Id: <5040ce5098cf36d4aaa199e1bb27c9d04eef7619.1426021520.git.sowmini.varadhan@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Note that this conversion is only being done to consolidate the
code and ensure that the common code provides the sufficient
abstraction. It is not expected to result in any noticeable
performance improvement, as there is typically one ldc_iommu
per vnet_port, and each one has 8k entries, with a typical
request for 1-4 pages.  Thus LDC uses npools = 1.

Signed-off-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>
---
v3: added this file to be a consumer of the common iommu library

 arch/sparc/kernel/ldc.c |  185 +++++++++++++++++++++++++----------------------
 1 files changed, 97 insertions(+), 88 deletions(-)

diff --git a/arch/sparc/kernel/ldc.c b/arch/sparc/kernel/ldc.c
index 274a9f5..d485697 100644
--- a/arch/sparc/kernel/ldc.c
+++ b/arch/sparc/kernel/ldc.c
@@ -15,6 +15,8 @@
 #include <linux/list.h>
 #include <linux/init.h>
 #include <linux/bitmap.h>
+#include <linux/hash.h>
+#include <linux/iommu-common.h>
 
 #include <asm/hypervisor.h>
 #include <asm/iommu.h>
@@ -27,6 +29,11 @@
 #define DRV_MODULE_VERSION	"1.1"
 #define DRV_MODULE_RELDATE	"July 22, 2008"
 
+#define COOKIE_PGSZ_CODE	0xf000000000000000ULL
+#define COOKIE_PGSZ_CODE_SHIFT	60ULL
+
+static DEFINE_PER_CPU(unsigned int, ldc_pool_hash);
+
 static char version[]  	DRV_MODULE_NAME ".c:v" DRV_MODULE_VERSION " (" DRV_MODULE_RELDATE ")\n";
 #define LDC_PACKET_SIZE		64
@@ -98,10 +105,10 @@ static const struct ldc_mode_ops stream_ops;
 int ldom_domaining_enabled;
 
 struct ldc_iommu {
-	/* Protects arena alloc/free.  */
+	/* Protects ldc_unmap.  */
 	spinlock_t			lock;
-	struct iommu_arena		arena;
 	struct ldc_mtable_entry		*page_table;
+	struct iommu_table		iommu_table;
 };
 
 struct ldc_channel {
@@ -998,31 +1005,85 @@ static void free_queue(unsigned long num_entries, struct ldc_packet *q)
 	free_pages((unsigned long)q, order);
 }
 
+static unsigned long ldc_cookie_to_index(u64 cookie, void *arg)
+{
+	u64 szcode = cookie >> COOKIE_PGSZ_CODE_SHIFT;
+	/* struct ldc_iommu *ldc_iommu = (struct ldc_iommu *)arg; */
+
+	cookie &= ~COOKIE_PGSZ_CODE;
+
+	return (cookie >> (13ULL + (szcode * 3ULL)));
+}
+
+struct ldc_demap_arg {
+	struct ldc_iommu *ldc_iommu;
+	u64 cookie;
+	unsigned long id;
+};
+
+static void ldc_demap(void *arg, unsigned long entry, unsigned long npages)
+{
+	struct ldc_demap_arg *ldc_demap_arg = arg;
+	struct ldc_iommu *iommu = ldc_demap_arg->ldc_iommu;
+	unsigned long id = ldc_demap_arg->id;
+	u64 cookie = ldc_demap_arg->cookie;
+	struct ldc_mtable_entry *base;
+	unsigned long i, shift;
+
+	shift = (cookie >> COOKIE_PGSZ_CODE_SHIFT) * 3;
+	base = iommu->page_table + entry;
+	for (i = 0; i < npages; i++) {
+		if (base->cookie)
+			sun4v_ldc_revoke(id, cookie + (i << shift),
+					 base->cookie);
+		base->mte = 0;
+	}
+}
+
 /* XXX Make this configurable... XXX */
 #define LDC_IOTABLE_SIZE	(8 * 1024)
 
-static int ldc_iommu_init(struct ldc_channel *lp)
+struct iommu_tbl_ops ldc_iommu_ops = {
+	.cookie_to_index = ldc_cookie_to_index,
+	.demap = ldc_demap,
+};
+
+static void setup_ldc_pool_hash(void)
+{
+	unsigned int i;
+	static bool do_once;
+
+	if (do_once)
+		return;
+	do_once = true;
+	for_each_possible_cpu(i)
+		per_cpu(ldc_pool_hash, i) = hash_32(i, IOMMU_POOL_HASHBITS);
+}
+
+
+static int ldc_iommu_init(const char *name, struct ldc_channel *lp)
 {
 	unsigned long sz, num_tsb_entries, tsbsize, order;
-	struct ldc_iommu *iommu = &lp->iommu;
+	struct ldc_iommu *ldc_iommu = &lp->iommu;
+	struct iommu_table *iommu = &ldc_iommu->iommu_table;
 	struct ldc_mtable_entry *table;
 	unsigned long hv_err;
 	int err;
 
 	num_tsb_entries = LDC_IOTABLE_SIZE;
 	tsbsize = num_tsb_entries * sizeof(struct ldc_mtable_entry);
-
-	spin_lock_init(&iommu->lock);
+	setup_ldc_pool_hash();
+	spin_lock_init(&ldc_iommu->lock);
 
 	sz = num_tsb_entries / 8;
 	sz = (sz + 7UL) & ~7UL;
-	iommu->arena.map = kzalloc(sz, GFP_KERNEL);
-	if (!iommu->arena.map) {
+	iommu->map = kzalloc(sz, GFP_KERNEL);
+	if (!iommu->map) {
 		printk(KERN_ERR PFX "Alloc of arena map failed, sz=%lu\n", sz);
 		return -ENOMEM;
 	}
-
-	iommu->arena.limit = num_tsb_entries;
+	iommu_tbl_pool_init(iommu, num_tsb_entries, PAGE_SHIFT,
+			    &ldc_iommu_ops, false, 1);
 
 	order = get_order(tsbsize);
 
@@ -1037,7 +1098,7 @@ static int ldc_iommu_init(struct ldc_channel *lp)
 
 	memset(table, 0, PAGE_SIZE << order);
 
-	iommu->page_table = table;
+	ldc_iommu->page_table = table;
 
 	hv_err = sun4v_ldc_set_map_table(lp->id, __pa(table),
 					 num_tsb_entries);
@@ -1049,31 +1110,32 @@ static int ldc_iommu_init(struct ldc_channel *lp)
 
 out_free_table:
 	free_pages((unsigned long) table, order);
-	iommu->page_table = NULL;
+	ldc_iommu->page_table = NULL;
 
 out_free_map:
-	kfree(iommu->arena.map);
-	iommu->arena.map = NULL;
+	kfree(iommu->map);
+	iommu->map = NULL;
 
 	return err;
 }
 
 static void ldc_iommu_release(struct ldc_channel *lp)
 {
-	struct ldc_iommu *iommu = &lp->iommu;
+	struct ldc_iommu *ldc_iommu = &lp->iommu;
+	struct iommu_table *iommu = &ldc_iommu->iommu_table;
 	unsigned long num_tsb_entries, tsbsize, order;
 
 	(void) sun4v_ldc_set_map_table(lp->id, 0, 0);
 
-	num_tsb_entries = iommu->arena.limit;
+	num_tsb_entries = iommu->poolsize * iommu->nr_pools;
 	tsbsize = num_tsb_entries * sizeof(struct ldc_mtable_entry);
 	order = get_order(tsbsize);
 
-	free_pages((unsigned long) iommu->page_table, order);
-	iommu->page_table = NULL;
+	free_pages((unsigned long) ldc_iommu->page_table, order);
+	ldc_iommu->page_table = NULL;
 
-	kfree(iommu->arena.map);
-	iommu->arena.map = NULL;
+	kfree(iommu->map);
+	iommu->map = NULL;
 }
 
 struct ldc_channel *ldc_alloc(unsigned long id,
@@ -1140,7 +1202,7 @@ struct ldc_channel *ldc_alloc(unsigned long id,
 
 	lp->id = id;
 
-	err = ldc_iommu_init(lp);
+	err = ldc_iommu_init(name, lp);
 	if (err)
 		goto out_free_ldc;
 
@@ -1885,40 +1947,6 @@ int ldc_read(struct ldc_channel *lp, void *buf, unsigned int size)
 }
 EXPORT_SYMBOL(ldc_read);
 
-static long arena_alloc(struct ldc_iommu *iommu, unsigned long npages)
-{
-	struct iommu_arena *arena = &iommu->arena;
-	unsigned long n, start, end, limit;
-	int pass;
-
-	limit = arena->limit;
-	start = arena->hint;
-	pass = 0;
-
-again:
-	n = bitmap_find_next_zero_area(arena->map, limit, start, npages, 0);
-	end = n + npages;
-	if (unlikely(end >= limit)) {
-		if (likely(pass < 1)) {
-			limit = start;
-			start = 0;
-			pass++;
-			goto again;
-		} else {
-			/* Scanned the whole thing, give up. */
-			return -1;
-		}
-	}
-	bitmap_set(arena->map, n, npages);
-
-	arena->hint = end;
-
-	return n;
-}
-
-#define COOKIE_PGSZ_CODE	0xf000000000000000ULL
-#define COOKIE_PGSZ_CODE_SHIFT	60ULL
-
 static u64 pagesize_code(void)
 {
 	switch (PAGE_SIZE) {
@@ -1945,23 +1973,14 @@ static u64 make_cookie(u64 index, u64 pgsz_code, u64 page_offset)
 		page_offset);
 }
 
-static u64 cookie_to_index(u64 cookie, unsigned long *shift)
-{
-	u64 szcode = cookie >> COOKIE_PGSZ_CODE_SHIFT;
-
-	cookie &= ~COOKIE_PGSZ_CODE;
-
-	*shift = szcode * 3;
-
-	return (cookie >> (13ULL + (szcode * 3ULL)));
-}
 
 static struct ldc_mtable_entry *alloc_npages(struct ldc_iommu *iommu,
 					     unsigned long npages)
 {
 	long entry;
 
-	entry = arena_alloc(iommu, npages);
+	entry = iommu_tbl_range_alloc(NULL, &iommu->iommu_table, npages,
+				     NULL, __this_cpu_read(ldc_pool_hash));
 	if (unlikely(entry < 0))
 		return NULL;
 
@@ -2090,7 +2109,7 @@ int ldc_map_sg(struct ldc_channel *lp,
 	       struct ldc_trans_cookie *cookies, int ncookies,
 	       unsigned int map_perm)
 {
-	unsigned long i, npages, flags;
+	unsigned long i, npages;
 	struct ldc_mtable_entry *base;
 	struct cookie_state state;
 	struct ldc_iommu *iommu;
@@ -2109,9 +2128,7 @@ int ldc_map_sg(struct ldc_channel *lp,
 
 	iommu = &lp->iommu;
 
-	spin_lock_irqsave(&iommu->lock, flags);
 	base = alloc_npages(iommu, npages);
-	spin_unlock_irqrestore(&iommu->lock, flags);
 
 	if (!base)
 		return -ENOMEM;
@@ -2136,7 +2153,7 @@ int ldc_map_single(struct ldc_channel *lp,
 		   struct ldc_trans_cookie *cookies, int ncookies,
 		   unsigned int map_perm)
 {
-	unsigned long npages, pa, flags;
+	unsigned long npages, pa;
 	struct ldc_mtable_entry *base;
 	struct cookie_state state;
 	struct ldc_iommu *iommu;
@@ -2152,9 +2169,7 @@ int ldc_map_single(struct ldc_channel *lp,
 
 	iommu = &lp->iommu;
 
-	spin_lock_irqsave(&iommu->lock, flags);
 	base = alloc_npages(iommu, npages);
-	spin_unlock_irqrestore(&iommu->lock, flags);
 
 	if (!base)
 		return -ENOMEM;
@@ -2172,35 +2187,29 @@ int ldc_map_single(struct ldc_channel *lp,
 }
 EXPORT_SYMBOL(ldc_map_single);
 
+
 static void free_npages(unsigned long id, struct ldc_iommu *iommu,
 			u64 cookie, u64 size)
 {
-	struct iommu_arena *arena = &iommu->arena;
-	unsigned long i, shift, index, npages;
-	struct ldc_mtable_entry *base;
+	unsigned long npages;
+	struct ldc_demap_arg demap_arg;
 
-	npages = PAGE_ALIGN(((cookie & ~PAGE_MASK) + size)) >> PAGE_SHIFT;
-	index = cookie_to_index(cookie, &shift);
-	base = iommu->page_table + index;
+	demap_arg.ldc_iommu = iommu;
+	demap_arg.cookie = cookie;
+	demap_arg.id = id;
 
-	BUG_ON(index > arena->limit ||
-	       (index + npages) > arena->limit);
+	npages = PAGE_ALIGN(((cookie & ~PAGE_MASK) + size)) >> PAGE_SHIFT;
+	iommu_tbl_range_free(&iommu->iommu_table, cookie, npages, true,
+			     &demap_arg);
 
-	for (i = 0; i < npages; i++) {
-		if (base->cookie)
-			sun4v_ldc_revoke(id, cookie + (i << shift),
-					 base->cookie);
-		base->mte = 0;
-		__clear_bit(index + i, arena->map);
-	}
 }
 
 void ldc_unmap(struct ldc_channel *lp, struct ldc_trans_cookie *cookies,
 	       int ncookies)
 {
 	struct ldc_iommu *iommu = &lp->iommu;
-	unsigned long flags;
 	int i;
+	unsigned long flags;
 
 	spin_lock_irqsave(&iommu->lock, flags);
 	for (i = 0; i < ncookies; i++) {
-- 
1.7.1


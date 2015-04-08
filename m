From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Wed, 08 Apr 2015 13:25:32 +0000
Subject: [PATCH v9 3/3] sparc: Make LDC use common iommu poll management functions
Message-Id: <0a7f858c359eaa050584119c20ebe18f8c6067e3.1428181553.git.sowmini.varadhan@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1428181553.git.sowmini.varadhan@oracle.com>
In-Reply-To: <cover.1428181553.git.sowmini.varadhan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org
Cc: aik@au1.ibm.com, anton@au1.ibm.com, paulus@samba.org, sowmini.varadhan@oracle.com, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net

Note that this conversion is only being done to consolidate the
code and ensure that the common code provides the sufficient
abstraction. It is not expected to result in any noticeable
performance improvement, as there is typically one ldc_iommu
per vnet_port, and each one has 8k entries, with a typical
request for 1-4 pages.  Thus LDC uses npools = 1.

Signed-off-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
v3: added this file to be a consumer of the common iommu library
v4: removed ->cookie_to_index and ->demap from iommu_tbl_ops and instead
    inline these calls into ldc before calling into iommu-common
v6: remove iommu_tbl_ops
v7: move pool_hash initialization to iommu_tbl_pool_init
v8: BenH comments
v9: More BenH comments
 arch/sparc/kernel/ldc.c |  153 ++++++++++++++++++++---------------------------
 1 files changed, 65 insertions(+), 88 deletions(-)

diff --git a/arch/sparc/kernel/ldc.c b/arch/sparc/kernel/ldc.c
index 274a9f5..d2ae0f7 100644
--- a/arch/sparc/kernel/ldc.c
+++ b/arch/sparc/kernel/ldc.c
@@ -15,6 +15,7 @@
 #include <linux/list.h>
 #include <linux/init.h>
 #include <linux/bitmap.h>
+#include <linux/iommu-common.h>
 
 #include <asm/hypervisor.h>
 #include <asm/iommu.h>
@@ -27,6 +28,10 @@
 #define DRV_MODULE_VERSION	"1.1"
 #define DRV_MODULE_RELDATE	"July 22, 2008"
 
+#define COOKIE_PGSZ_CODE	0xf000000000000000ULL
+#define COOKIE_PGSZ_CODE_SHIFT	60ULL
+
+
 static char version[]  	DRV_MODULE_NAME ".c:v" DRV_MODULE_VERSION " (" DRV_MODULE_RELDATE ")\n";
 #define LDC_PACKET_SIZE		64
@@ -98,10 +103,10 @@ static const struct ldc_mode_ops stream_ops;
 int ldom_domaining_enabled;
 
 struct ldc_iommu {
-	/* Protects arena alloc/free.  */
+	/* Protects ldc_unmap.  */
 	spinlock_t			lock;
-	struct iommu_arena		arena;
 	struct ldc_mtable_entry		*page_table;
+	struct iommu_map_table		iommu_map_table;
 };
 
 struct ldc_channel {
@@ -998,31 +1003,59 @@ static void free_queue(unsigned long num_entries, struct ldc_packet *q)
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
+static void ldc_demap(struct ldc_iommu *iommu, unsigned long id, u64 cookie,
+		      unsigned long entry, unsigned long npages)
+{
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
+static int ldc_iommu_init(const char *name, struct ldc_channel *lp)
 {
 	unsigned long sz, num_tsb_entries, tsbsize, order;
-	struct ldc_iommu *iommu = &lp->iommu;
+	struct ldc_iommu *ldc_iommu = &lp->iommu;
+	struct iommu_map_table *iommu = &ldc_iommu->iommu_map_table;
 	struct ldc_mtable_entry *table;
 	unsigned long hv_err;
 	int err;
 
 	num_tsb_entries = LDC_IOTABLE_SIZE;
 	tsbsize = num_tsb_entries * sizeof(struct ldc_mtable_entry);
-
-	spin_lock_init(&iommu->lock);
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
+			    NULL, false /* no large pool */,
+			    1 /* npools */,
+			    true /* skip span boundary check */);
 
 	order = get_order(tsbsize);
 
@@ -1037,7 +1070,7 @@ static int ldc_iommu_init(struct ldc_channel *lp)
 
 	memset(table, 0, PAGE_SIZE << order);
 
-	iommu->page_table = table;
+	ldc_iommu->page_table = table;
 
 	hv_err = sun4v_ldc_set_map_table(lp->id, __pa(table),
 					 num_tsb_entries);
@@ -1049,31 +1082,32 @@ static int ldc_iommu_init(struct ldc_channel *lp)
 
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
+	struct iommu_map_table *iommu = &ldc_iommu->iommu_map_table;
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
@@ -1140,7 +1174,7 @@ struct ldc_channel *ldc_alloc(unsigned long id,
 
 	lp->id = id;
 
-	err = ldc_iommu_init(lp);
+	err = ldc_iommu_init(name, lp);
 	if (err)
 		goto out_free_ldc;
 
@@ -1885,40 +1919,6 @@ int ldc_read(struct ldc_channel *lp, void *buf, unsigned int size)
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
@@ -1945,23 +1945,14 @@ static u64 make_cookie(u64 index, u64 pgsz_code, u64 page_offset)
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
+	entry = iommu_tbl_range_alloc(NULL, &iommu->iommu_map_table,
+				      npages, NULL, (unsigned long)-1, 0);
 	if (unlikely(entry < 0))
 		return NULL;
 
@@ -2090,7 +2081,7 @@ int ldc_map_sg(struct ldc_channel *lp,
 	       struct ldc_trans_cookie *cookies, int ncookies,
 	       unsigned int map_perm)
 {
-	unsigned long i, npages, flags;
+	unsigned long i, npages;
 	struct ldc_mtable_entry *base;
 	struct cookie_state state;
 	struct ldc_iommu *iommu;
@@ -2109,9 +2100,7 @@ int ldc_map_sg(struct ldc_channel *lp,
 
 	iommu = &lp->iommu;
 
-	spin_lock_irqsave(&iommu->lock, flags);
 	base = alloc_npages(iommu, npages);
-	spin_unlock_irqrestore(&iommu->lock, flags);
 
 	if (!base)
 		return -ENOMEM;
@@ -2136,7 +2125,7 @@ int ldc_map_single(struct ldc_channel *lp,
 		   struct ldc_trans_cookie *cookies, int ncookies,
 		   unsigned int map_perm)
 {
-	unsigned long npages, pa, flags;
+	unsigned long npages, pa;
 	struct ldc_mtable_entry *base;
 	struct cookie_state state;
 	struct ldc_iommu *iommu;
@@ -2152,9 +2141,7 @@ int ldc_map_single(struct ldc_channel *lp,
 
 	iommu = &lp->iommu;
 
-	spin_lock_irqsave(&iommu->lock, flags);
 	base = alloc_npages(iommu, npages);
-	spin_unlock_irqrestore(&iommu->lock, flags);
 
 	if (!base)
 		return -ENOMEM;
@@ -2172,35 +2159,25 @@ int ldc_map_single(struct ldc_channel *lp,
 }
 EXPORT_SYMBOL(ldc_map_single);
 
+
 static void free_npages(unsigned long id, struct ldc_iommu *iommu,
 			u64 cookie, u64 size)
 {
-	struct iommu_arena *arena = &iommu->arena;
-	unsigned long i, shift, index, npages;
-	struct ldc_mtable_entry *base;
+	unsigned long npages, entry;
 
 	npages = PAGE_ALIGN(((cookie & ~PAGE_MASK) + size)) >> PAGE_SHIFT;
-	index = cookie_to_index(cookie, &shift);
-	base = iommu->page_table + index;
 
-	BUG_ON(index > arena->limit ||
-	       (index + npages) > arena->limit);
-
-	for (i = 0; i < npages; i++) {
-		if (base->cookie)
-			sun4v_ldc_revoke(id, cookie + (i << shift),
-					 base->cookie);
-		base->mte = 0;
-		__clear_bit(index + i, arena->map);
-	}
+	entry = ldc_cookie_to_index(cookie, iommu);
+	ldc_demap(iommu, id, cookie, entry, npages);
+	iommu_tbl_range_free(&iommu->iommu_map_table, cookie, npages, entry);
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


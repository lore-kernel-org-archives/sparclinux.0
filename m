From: David Dillow <dave@thedillows.org>
Date: Fri, 09 Jul 2004 02:44:05 +0000
Subject: [RFC PATCH] Allow larger than 1MB mappings on sparc64 sbus
Message-Id: <1089341045.3100.38.camel@ori.thedillows.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I've been working on a driver for the lpvi interface of the Sun
SPARCprinter (again, finally!). This device does not seem to support
scatter-gather DMA, so I have to rely on the IOMMU to make the streaming
allocation look like one contiguous address space.

Unfortunately, we only support streaming mappings of up to 1MB in size,
while printing on letter paper requires up to 1.75MB, and B4 paper
requires 2.75MB. Worse, if someone asks for more than 1MB, we could
potentially corrupt memory above the IOMMU page tables.

I've modified the allocator to allow mappings up to 127MB (or
thereabouts). It will allocate a contiguous run of clusters to allow the
mapping of the request, and return NULL if it is unable to do so. This
also modifies the deallocator to return those ioptes to the pool.

Plus, it will never try to write above the IOMMU page table.

This boots, and I can print pages. Does this look sane?

Dave




=== arch/sparc64/kernel/sbus.c 1.14 vs edited ==--- 1.14/arch/sparc64/kernel/sbus.c	Tue Apr 22 02:09:31 2003
+++ edited/arch/sparc64/kernel/sbus.c	Tue Jun 29 22:16:01 2004
@@ -28,10 +28,10 @@
  *
  * On SYSIO, using an 8K page size we have 1GB of SBUS
  * DMA space mapped.  We divide this space into equally
- * sized clusters.  Currently we allow clusters up to a
- * size of 1MB.  If anything begins to generate DMA
- * mapping requests larger than this we will need to
- * increase things a bit.
+ * sized clusters. We allocate a DMA mapping from the
+ * cluster that matches the order of the allocation, or
+ * if the order is greater than the number of clusters,
+ * we try to allocate from the last cluster.
  */
 
 #define NCLUSTERS	8UL
@@ -134,12 +134,17 @@
 
 static iopte_t *alloc_streaming_cluster(struct sbus_iommu *iommu, unsigned long npages)
 {
-	iopte_t *iopte, *limit, *first;
-	unsigned long cnum, ent, flush_point;
+	iopte_t *iopte, *limit, *first, *cluster;
+	unsigned long cnum, ent, nent, flush_point, found;
 
 	cnum = 0;
+	nent = 1;
 	while ((1UL << cnum) < npages)
 		cnum++;
+	if(cnum >= NCLUSTERS) {
+		nent = 1UL << (cnum - NCLUSTERS);
+		cnum = NCLUSTERS - 1;
+	}
 	iopte  = iommu->page_table + (cnum * CLUSTER_NPAGES);
 
 	if (cnum = 0)
@@ -152,22 +157,31 @@
 	flush_point = iommu->alloc_info[cnum].flush;
 
 	first = iopte;
+	cluster = NULL;
+	found = 0;
 	for (;;) {
 		if (iopte_val(*iopte) = 0UL) {
-			if ((iopte + (1 << cnum)) >= limit)
-				ent = 0;
-			else
-				ent = ent + 1;
-			iommu->alloc_info[cnum].next = ent;
-			if (ent = flush_point)
-				__iommu_flushall(iommu);
-			break;
+			found++;
+			if (!cluster)
+				cluster = iopte;
+		} else {
+			/* Used cluster in the way */
+			cluster = NULL;
+			found = 0;
 		}
+
+		if (found = nent)
+			break;
+
 		iopte += (1 << cnum);
 		ent++;
 		if (iopte >= limit) {
 			iopte = (iommu->page_table + (cnum * CLUSTER_NPAGES));
 			ent = 0;
+
+			/* Multiple cluster allocations must not wrap */
+			cluster = NULL;
+			found = 0;
 		}
 		if (ent = flush_point)
 			__iommu_flushall(iommu);
@@ -175,8 +189,19 @@
 			goto bad;
 	}
 
+	/* ent/iopte points to the last cluster entry we're going to use,
+	 * so save our place for the next allocation.
+	 */
+	if ((iopte + (1 << cnum)) >= limit)
+		ent = 0;
+	else
+		ent = ent + 1;
+	iommu->alloc_info[cnum].next = ent;
+	if (ent = flush_point)
+		__iommu_flushall(iommu);
+
 	/* I've got your streaming cluster right here buddy boy... */
-	return iopte;
+	return cluster;
 
 bad:
 	printk(KERN_EMERG "sbus: alloc_streaming_cluster of npages(%ld) failed!\n",
@@ -186,15 +211,23 @@
 
 static void free_streaming_cluster(struct sbus_iommu *iommu, u32 base, unsigned long npages)
 {
-	unsigned long cnum, ent;
+	unsigned long cnum, ent, nent;
 	iopte_t *iopte;
 
 	cnum = 0;
+	nent = 1;
 	while ((1UL << cnum) < npages)
 		cnum++;
+	if(cnum >= NCLUSTERS) {
+		nent = 1UL << (cnum - NCLUSTERS);
+		cnum = NCLUSTERS - 1;
+	}
 	ent = (base & CLUSTER_MASK) >> (IO_PAGE_SHIFT + cnum);
 	iopte = iommu->page_table + ((base - MAP_BASE) >> IO_PAGE_SHIFT);
-	iopte_val(*iopte) = 0UL;
+	do {
+		iopte_val(*iopte) = 0UL;
+		iopte += 1 << cnum;
+	} while(--nent);
 
 	/* If the global flush might not have caught this entry,
 	 * adjust the flush point such that we will flush before



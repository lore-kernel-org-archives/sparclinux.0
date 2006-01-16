From: Eric Sesterhenn / snakebyte <snakebyte@gmx.de>
Date: Mon, 16 Jan 2006 21:07:06 +0000
Subject: [Patch] change if() BUG(); to BUG_ON in iommu.c
Message-Id: <1137445626.2675.2.camel@localhost>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

hi,

this patch changes if() BUG(); constructs
in iommu.c to BUG_ON(); so it gets save
to define BUG() and BUG_ON() to nullstatements.

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.15-git11/arch/sparc/mm/iommu.c.orig	2006-01-16 22:02:41.000000000 +0100
+++ linux-2.6.15-git11/arch/sparc/mm/iommu.c	2006-01-16 22:03:39.000000000 +0100
@@ -295,8 +295,7 @@ static void iommu_release_one(u32 busa, 
 	int ioptex;
 	int i;
 
-	if (busa < iommu->start)
-		BUG();
+	BUG_ON(busa < iommu->start);
 	ioptex = (busa - iommu->start) >> PAGE_SHIFT;
 	for (i = 0; i < npages; i++) {
 		iopte_val(iommu->page_table[ioptex + i]) = 0;
@@ -340,9 +339,9 @@ static int iommu_map_dma_area(dma_addr_t
 	iopte_t *first;
 	int ioptex;
 
-	if ((va & ~PAGE_MASK) != 0) BUG();
-	if ((addr & ~PAGE_MASK) != 0) BUG();
-	if ((len & ~PAGE_MASK) != 0) BUG();
+	BUG_ON((va & ~PAGE_MASK) != 0);
+	BUG_ON((addr & ~PAGE_MASK) != 0);
+	BUG_ON((len & ~PAGE_MASK) != 0);
 
 	/* page color = physical address */
 	ioptex = bit_map_string_get(&iommu->usemap, len >> PAGE_SHIFT,
@@ -405,8 +404,8 @@ static void iommu_unmap_dma_area(unsigne
 	unsigned long end;
 	int ioptex = (busa - iommu->start) >> PAGE_SHIFT;
 
-	if ((busa & ~PAGE_MASK) != 0) BUG();
-	if ((len & ~PAGE_MASK) != 0) BUG();
+	BUG_ON((busa & ~PAGE_MASK) != 0);
+	BUG_ON((len & ~PAGE_MASK) != 0);
 
 	iopte += ioptex;
 	end = busa + len;



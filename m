From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Fri, 09 Oct 2009 08:29:19 +0000
Subject: [PATCH 6/8] sparc: Use bitmap_find_next_zero_area
Message-Id: <1255076961-21325-6-git-send-email-akinobu.mita@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <>
 <1255076961-21325-1-git-send-email-akinobu.mita@gmail.com>
 <1255076961-21325-2-git-send-email-akinobu.mita@gmail.com>
 <1255076961-21325-3-git-send-email-akinobu.mita@gmail.com>
 <1255076961-21325-4-git-send-email-akinobu.mita@gmail.com>
 <1255076961-21325-5-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1255076961-21325-5-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 arch/sparc/kernel/ldc.c |   16 ++++------------
 arch/sparc/mm/sun4c.c   |   17 +++++------------
 2 files changed, 9 insertions(+), 24 deletions(-)

diff --git a/arch/sparc/kernel/ldc.c b/arch/sparc/kernel/ldc.c
index adf5f27..aa27d26 100644
--- a/arch/sparc/kernel/ldc.c
+++ b/arch/sparc/kernel/ldc.c
@@ -14,6 +14,7 @@
 #include <linux/interrupt.h>
 #include <linux/list.h>
 #include <linux/init.h>
+#include <linux/bitmap.h>
 
 #include <asm/hypervisor.h>
 #include <asm/iommu.h>
@@ -1875,7 +1876,7 @@ EXPORT_SYMBOL(ldc_read);
 static long arena_alloc(struct ldc_iommu *iommu, unsigned long npages)
 {
 	struct iommu_arena *arena = &iommu->arena;
-	unsigned long n, i, start, end, limit;
+	unsigned long n, start, end, limit;
 	int pass;
 
 	limit = arena->limit;
@@ -1883,7 +1884,7 @@ static long arena_alloc(struct ldc_iommu *iommu, unsigned long npages)
 	pass = 0;
 
 again:
-	n = find_next_zero_bit(arena->map, limit, start);
+	n = bitmap_find_next_zero_area(arena->map, limit, start, npages, 0);
 	end = n + npages;
 	if (unlikely(end >= limit)) {
 		if (likely(pass < 1)) {
@@ -1896,16 +1897,7 @@ again:
 			return -1;
 		}
 	}
-
-	for (i = n; i < end; i++) {
-		if (test_bit(i, arena->map)) {
-			start = i + 1;
-			goto again;
-		}
-	}
-
-	for (i = n; i < end; i++)
-		__set_bit(i, arena->map);
+	bitmap_set(arena->map, n, npages);
 
 	arena->hint = end;
 
diff --git a/arch/sparc/mm/sun4c.c b/arch/sparc/mm/sun4c.c
index 2ffacd6..a89baf0 100644
--- a/arch/sparc/mm/sun4c.c
+++ b/arch/sparc/mm/sun4c.c
@@ -17,6 +17,7 @@
 #include <linux/fs.h>
 #include <linux/seq_file.h>
 #include <linux/scatterlist.h>
+#include <linux/bitmap.h>
 
 #include <asm/sections.h>
 #include <asm/page.h>
@@ -1021,20 +1022,12 @@ static char *sun4c_lockarea(char *vaddr, unsigned long size)
 	npages = (((unsigned long)vaddr & ~PAGE_MASK) +
 		  size + (PAGE_SIZE-1)) >> PAGE_SHIFT;
 
-	scan = 0;
 	local_irq_save(flags);
-	for (;;) {
-		scan = find_next_zero_bit(sun4c_iobuffer_map,
-					  iobuffer_map_size, scan);
-		if ((base = scan) + npages > iobuffer_map_size) goto abend;
-		for (;;) {
-			if (scan >= base + npages) goto found;
-			if (test_bit(scan, sun4c_iobuffer_map)) break;
-			scan++;
-		}
-	}
+	base = bitmap_find_next_zero_area(sun4c_iobuffer_map, iobuffer_map_size,
+						0, npages, 0);
+	if (base >= iobuffer_map_size)
+		goto abend;
 
-found:
 	high = ((base + npages) << PAGE_SHIFT) + sun4c_iobuffer_start;
 	high = SUN4C_REAL_PGDIR_ALIGN(high);
 	while (high > sun4c_iobuffer_high) {
-- 
1.5.4.3


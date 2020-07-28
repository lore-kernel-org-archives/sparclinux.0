From: Mike Rapoport <rppt@kernel.org>
Date: Tue, 28 Jul 2020 05:11:41 +0000
Subject: [PATCH 03/15] arm, xtensa: simplify initialization of high memory pages
Message-Id: <20200728051153.1590-4-rppt@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20200728051153.1590-1-rppt@kernel.org>
In-Reply-To: <20200728051153.1590-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Dave Hansen <dave.hansen@linux.intel.com>, linux-mips@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, Will Deacon <will@kernel.org>, Stafford Horne <shorne@gmail.com>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, Mike Rapoport <rppt@linux.ibm.com>, clang-built-linux@googlegroups.com, Ingo Molnar <mingo@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, uclinux-h8-devel@lists.sourceforge.jp, linux-xtensa@linux-xtensa.org, openrisc@lists.librecores.org, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Michal Simek <monstr@monstr.eu>, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Palmer Dabbelt <palmer@dabbelt.com>, Christoph Hellwig <hch@lst.de>, Mike Rapoport <rppt@kernel.org>

From: Mike Rapoport <rppt@linux.ibm.com>

The function free_highpages() in both arm and xtensa essentially open-code
for_each_free_mem_range() loop to detect high memory pages that were not
reserved and that should be initialized and passed to the buddy allocator.

Replace open-coded implementation of for_each_free_mem_range() with usage
of memblock API to simplify the code.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/arm/mm/init.c    | 48 +++++++------------------------------
 arch/xtensa/mm/init.c | 55 ++++++++-----------------------------------
 2 files changed, 18 insertions(+), 85 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 01e18e43b174..626af348eb8f 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -352,61 +352,29 @@ static void __init free_unused_memmap(void)
 #endif
 }
 
-#ifdef CONFIG_HIGHMEM
-static inline void free_area_high(unsigned long pfn, unsigned long end)
-{
-	for (; pfn < end; pfn++)
-		free_highmem_page(pfn_to_page(pfn));
-}
-#endif
-
 static void __init free_highpages(void)
 {
 #ifdef CONFIG_HIGHMEM
 	unsigned long max_low = max_low_pfn;
-	struct memblock_region *mem, *res;
+	phys_addr_t range_start, range_end;
+	u64 i;
 
 	/* set highmem page free */
-	for_each_memblock(memory, mem) {
-		unsigned long start = memblock_region_memory_base_pfn(mem);
-		unsigned long end = memblock_region_memory_end_pfn(mem);
+	for_each_free_mem_range(i, NUMA_NO_NODE, MEMBLOCK_NONE,
+				&range_start, &range_end, NULL) {
+		unsigned long start = PHYS_PFN(range_start);
+		unsigned long end = PHYS_PFN(range_end);
 
 		/* Ignore complete lowmem entries */
 		if (end <= max_low)
 			continue;
 
-		if (memblock_is_nomap(mem))
-			continue;
-
 		/* Truncate partial highmem entries */
 		if (start < max_low)
 			start = max_low;
 
-		/* Find and exclude any reserved regions */
-		for_each_memblock(reserved, res) {
-			unsigned long res_start, res_end;
-
-			res_start = memblock_region_reserved_base_pfn(res);
-			res_end = memblock_region_reserved_end_pfn(res);
-
-			if (res_end < start)
-				continue;
-			if (res_start < start)
-				res_start = start;
-			if (res_start > end)
-				res_start = end;
-			if (res_end > end)
-				res_end = end;
-			if (res_start != start)
-				free_area_high(start, res_start);
-			start = res_end;
-			if (start = end)
-				break;
-		}
-
-		/* And now free anything which remains */
-		if (start < end)
-			free_area_high(start, end);
+		for (; start < end; start++)
+			free_highmem_page(pfn_to_page(start));
 	}
 #endif
 }
diff --git a/arch/xtensa/mm/init.c b/arch/xtensa/mm/init.c
index a05b306cf371..ad9d59d93f39 100644
--- a/arch/xtensa/mm/init.c
+++ b/arch/xtensa/mm/init.c
@@ -79,67 +79,32 @@ void __init zones_init(void)
 	free_area_init(max_zone_pfn);
 }
 
-#ifdef CONFIG_HIGHMEM
-static void __init free_area_high(unsigned long pfn, unsigned long end)
-{
-	for (; pfn < end; pfn++)
-		free_highmem_page(pfn_to_page(pfn));
-}
-
 static void __init free_highpages(void)
 {
+#ifdef CONFIG_HIGHMEM
 	unsigned long max_low = max_low_pfn;
-	struct memblock_region *mem, *res;
+	phys_addr_t range_start, range_end;
+	u64 i;
 
-	reset_all_zones_managed_pages();
 	/* set highmem page free */
-	for_each_memblock(memory, mem) {
-		unsigned long start = memblock_region_memory_base_pfn(mem);
-		unsigned long end = memblock_region_memory_end_pfn(mem);
+	for_each_free_mem_range(i, NUMA_NO_NODE, MEMBLOCK_NONE,
+				&range_start, &range_end, NULL) {
+		unsigned long start = PHYS_PFN(range_start);
+		unsigned long end = PHYS_PFN(range_end);
 
 		/* Ignore complete lowmem entries */
 		if (end <= max_low)
 			continue;
 
-		if (memblock_is_nomap(mem))
-			continue;
-
 		/* Truncate partial highmem entries */
 		if (start < max_low)
 			start = max_low;
 
-		/* Find and exclude any reserved regions */
-		for_each_memblock(reserved, res) {
-			unsigned long res_start, res_end;
-
-			res_start = memblock_region_reserved_base_pfn(res);
-			res_end = memblock_region_reserved_end_pfn(res);
-
-			if (res_end < start)
-				continue;
-			if (res_start < start)
-				res_start = start;
-			if (res_start > end)
-				res_start = end;
-			if (res_end > end)
-				res_end = end;
-			if (res_start != start)
-				free_area_high(start, res_start);
-			start = res_end;
-			if (start = end)
-				break;
-		}
-
-		/* And now free anything which remains */
-		if (start < end)
-			free_area_high(start, end);
+		for (; start < end; start++)
+			free_highmem_page(pfn_to_page(start));
 	}
-}
-#else
-static void __init free_highpages(void)
-{
-}
 #endif
+}
 
 /*
  * Initialize memory pages.
-- 
2.26.2

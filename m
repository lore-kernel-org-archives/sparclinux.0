From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Thu, 05 Oct 2017 21:11:21 +0000
Subject: [PATCH v10 07/10] x86/kasan: use kasan_map_populate()
Message-Id: <20171005211124.26524-8-pasha.tatashin@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20171005211124.26524-1-pasha.tatashin@oracle.com>
In-Reply-To: <20171005211124.26524-1-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

To optimize the performance of struct page initialization,
vmemmap_populate() will no longer zero memory.

Therefore, we must use a new interface to allocate and map kasan shadow
memory, that also zeroes memory for us.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/x86/mm/kasan_init_64.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
index bc84b73684b7..2db95efd208e 100644
--- a/arch/x86/mm/kasan_init_64.c
+++ b/arch/x86/mm/kasan_init_64.c
@@ -23,7 +23,7 @@ static int __init map_range(struct range *range)
 	start = (unsigned long)kasan_mem_to_shadow(pfn_to_kaddr(range->start));
 	end = (unsigned long)kasan_mem_to_shadow(pfn_to_kaddr(range->end));
 
-	return vmemmap_populate(start, end, NUMA_NO_NODE);
+	return kasan_map_populate(start, end, NUMA_NO_NODE);
 }
 
 static void __init clear_pgds(unsigned long start,
@@ -136,9 +136,9 @@ void __init kasan_init(void)
 		kasan_mem_to_shadow((void *)PAGE_OFFSET + MAXMEM),
 		kasan_mem_to_shadow((void *)__START_KERNEL_map));
 
-	vmemmap_populate((unsigned long)kasan_mem_to_shadow(_stext),
-			(unsigned long)kasan_mem_to_shadow(_end),
-			NUMA_NO_NODE);
+	kasan_map_populate((unsigned long)kasan_mem_to_shadow(_stext),
+			   (unsigned long)kasan_mem_to_shadow(_end),
+			   NUMA_NO_NODE);
 
 	kasan_populate_zero_shadow(kasan_mem_to_shadow((void *)MODULES_END),
 			(void *)KASAN_SHADOW_END);
-- 
2.14.2


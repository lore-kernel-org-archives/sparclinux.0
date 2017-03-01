From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Wed, 01 Mar 2017 00:14:42 +0000
Subject: [PATCH v2 2/3] mm: Zeroing hash tables in allocator
Message-Id: <1488327283-177710-3-git-send-email-pasha.tatashin@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1488327283-177710-1-git-send-email-pasha.tatashin@oracle.com>
In-Reply-To: <1488327283-177710-1-git-send-email-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mm@kvack.org, sparclinux@vger.kernel.org

Add a new flag HASH_ZERO which when provided grantees that the hash table
that is returned by alloc_large_system_hash() is zeroed.  In most cases
that is what is needed by the caller. Use page level allocator's __GFP_ZERO
flags to zero the memory. It is using memset() which is efficient method to
zero memory and is optimized for most platforms.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Reviewed-by: Babu Moger <babu.moger@oracle.com>
---
 include/linux/bootmem.h |    1 +
 mm/page_alloc.c         |   12 +++++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/linux/bootmem.h b/include/linux/bootmem.h
index 962164d..e223d91 100644
--- a/include/linux/bootmem.h
+++ b/include/linux/bootmem.h
@@ -358,6 +358,7 @@ static inline void __init memblock_free_late(
 #define HASH_EARLY	0x00000001	/* Allocating during early boot? */
 #define HASH_SMALL	0x00000002	/* sub-page allocation allowed, min
 					 * shift passed via *_hash_shift */
+#define HASH_ZERO	0x00000004	/* Zero allocated hash table */
 
 /* Only NUMA needs hash distribution. 64bit NUMA architectures have
  * sufficient vmalloc space.
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a7a6aac..1b0f7a4 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7142,6 +7142,7 @@ static unsigned long __init arch_reserved_kernel_pages(void)
 	unsigned long long max = high_limit;
 	unsigned long log2qty, size;
 	void *table = NULL;
+	gfp_t gfp_flags;
 
 	/* allow the kernel cmdline to have a say */
 	if (!numentries) {
@@ -7186,12 +7187,17 @@ static unsigned long __init arch_reserved_kernel_pages(void)
 
 	log2qty = ilog2(numentries);
 
+	/*
+	 * memblock allocator returns zeroed memory already, so HASH_ZERO is
+	 * currently not used when HASH_EARLY is specified.
+	 */
+	gfp_flags = (flags & HASH_ZERO) ? GFP_ATOMIC | __GFP_ZERO : GFP_ATOMIC;
 	do {
 		size = bucketsize << log2qty;
 		if (flags & HASH_EARLY)
 			table = memblock_virt_alloc_nopanic(size, 0);
 		else if (hashdist)
-			table = __vmalloc(size, GFP_ATOMIC, PAGE_KERNEL);
+			table = __vmalloc(size, gfp_flags, PAGE_KERNEL);
 		else {
 			/*
 			 * If bucketsize is not a power-of-two, we may free
@@ -7199,8 +7205,8 @@ static unsigned long __init arch_reserved_kernel_pages(void)
 			 * alloc_pages_exact() automatically does
 			 */
 			if (get_order(size) < MAX_ORDER) {
-				table = alloc_pages_exact(size, GFP_ATOMIC);
-				kmemleak_alloc(table, size, 1, GFP_ATOMIC);
+				table = alloc_pages_exact(size, gfp_flags);
+				kmemleak_alloc(table, size, 1, gfp_flags);
 			}
 		}
 	} while (!table && size > PAGE_SIZE && --log2qty);
-- 
1.7.1


From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Thu, 03 Aug 2017 21:23:52 +0000
Subject: [v5 14/15] mm: optimize early system hash allocations
Message-Id: <1501795433-982645-15-git-send-email-pasha.tatashin@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1501795433-982645-1-git-send-email-pasha.tatashin@oracle.com>
In-Reply-To: <1501795433-982645-1-git-send-email-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Clients can call alloc_large_system_hash() with flag: HASH_ZERO to specify
that memory that was allocated for system hash needs to be zeroed,
otherwise the memory does not need to be zeroed, and client will initialize
it.

If memory does not need to be zero'd, call the new
memblock_virt_alloc_raw() interface, and thus improve the boot performance.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Reviewed-by: Steven Sistare <steven.sistare@oracle.com>
Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Reviewed-by: Bob Picco <bob.picco@oracle.com>
---
 mm/page_alloc.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index cbcdd53ad9f8..53d16590dc01 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7352,18 +7352,17 @@ void *__init alloc_large_system_hash(const char *tablename,
 
 	log2qty = ilog2(numentries);
 
-	/*
-	 * memblock allocator returns zeroed memory already, so HASH_ZERO is
-	 * currently not used when HASH_EARLY is specified.
-	 */
 	gfp_flags = (flags & HASH_ZERO) ? GFP_ATOMIC | __GFP_ZERO : GFP_ATOMIC;
 	do {
 		size = bucketsize << log2qty;
-		if (flags & HASH_EARLY)
-			table = memblock_virt_alloc_nopanic(size, 0);
-		else if (hashdist)
+		if (flags & HASH_EARLY) {
+			if (flags & HASH_ZERO)
+				table = memblock_virt_alloc_nopanic(size, 0);
+			else
+				table = memblock_virt_alloc_raw(size, 0);
+		} else if (hashdist) {
 			table = __vmalloc(size, gfp_flags, PAGE_KERNEL);
-		else {
+		} else {
 			/*
 			 * If bucketsize is not a power-of-two, we may free
 			 * some pages at the end of hash table which
-- 
2.13.4


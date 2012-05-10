From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Thu, 10 May 2012 00:44:29 +0000
Subject: [PATCH] sparc: fix build fail in mm/init_64.c when NEED_MULTIPLE_NODES is off
Message-Id: <1336610669-31449-1-git-send-email-paul.gortmaker@windriver.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Commit 625d693e9784f988371e69c2b41a2172c0be6c11 (linux-next)

    "sparc64: Convert over to NO_BOOTMEM."

causes the following compile failure for sparc64 allnoconfig:

  arch/sparc/mm/init_64.c:822:16: error: unused variable 'paddr'
  arch/sparc/mm/init_64.c:1759:7: error: unused variable 'node'
  arch/sparc/mm/init_64.c:809:12: error: 'memblock_nid_range' defined but not used

The paddr decl can easily be shuffled within the ifdef.  The
memblock_nid_range is just a stub function for when NEED_MULTIPLE_NODES
is off, but the only caller is within a NEED_MULTIPLE_NODES enabled
section, so we can simply delete it.

The unused "node" is slightly more interesting.  In the case of
"# CONFIG_NEED_MULTIPLE_NODES is not set" we no longer get the
definition of:

 #define NODE_DATA(nid)          (node_data[nid])

from arch/sparc/include/asm/mmzone.h - but instead we get:

 #define NODE_DATA(nid)          (&contig_page_data)

from include/linux/mmzone.h -- and since the arg is ignored,
the thing really is unused.  Rather than put in a confusing
looking __maybe_unused, simply splitting the declaration
from the assignment seemed to me to be the least offensive.

Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: "David S. Miller" <davem@davemloft.net>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 067a677..6026fdd 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -805,12 +805,6 @@ static u64 memblock_nid_range(u64 start, u64 end, int *nid)
 
 	return start;
 }
-#else
-static u64 memblock_nid_range(u64 start, u64 end, int *nid)
-{
-	*nid = 0;
-	return end;
-}
 #endif
 
 /* This must be invoked after performing all of the necessary
@@ -819,10 +813,11 @@ static u64 memblock_nid_range(u64 start, u64 end, int *nid)
  */
 static void __init allocate_node_data(int nid)
 {
-	unsigned long paddr, start_pfn, end_pfn;
 	struct pglist_data *p;
-
+	unsigned long start_pfn, end_pfn;
 #ifdef CONFIG_NEED_MULTIPLE_NODES
+	unsigned long paddr;
+
 	paddr = memblock_alloc_try_nid(sizeof(struct pglist_data), SMP_CACHE_BYTES, nid);
 	if (!paddr) {
 		prom_printf("Cannot allocate pglist_data for nid[%d]\n", nid);
@@ -1623,6 +1618,7 @@ void __init paging_init(void)
 {
 	unsigned long end_pfn, shift, phys_base;
 	unsigned long real_end, i;
+	int node;
 
 	/* These build time checkes make sure that the dcache_dirty_cpu()
 	 * page->flags usage will work.
@@ -1756,7 +1752,7 @@ void __init paging_init(void)
 	 * IRQ stacks.
 	 */
 	for_each_possible_cpu(i) {
-		int node = cpu_to_node(i);
+		node = cpu_to_node(i);
 
 		softirq_stack[i] = __alloc_bootmem_node(NODE_DATA(node),
 							THREAD_SIZE,
-- 
1.7.9.1


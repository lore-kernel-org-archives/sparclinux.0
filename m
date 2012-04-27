From: David Miller <davem@davemloft.net>
Date: Fri, 27 Apr 2012 03:55:07 +0000
Subject: [PATCH] sparc64: Use node local allocations for IRQ stacks.
Message-Id: <20120426.235507.1967848292117984225.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Signed-off-by: David S. Miller <davem@davemloft.net>
---

Committed to sparc-next

 arch/sparc/mm/init_64.c |   23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 5b84559..def9223 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -1748,22 +1748,27 @@ void __init paging_init(void)
 #endif
 	}
 
+	/* Setup bootmem... */
+	last_valid_pfn = end_pfn = bootmem_init(phys_base);
+
+#ifndef CONFIG_NEED_MULTIPLE_NODES
+	max_mapnr = last_valid_pfn;
+#endif
 	/* Once the OF device tree and MDESC have been setup, we know
 	 * the list of possible cpus.  Therefore we can allocate the
 	 * IRQ stacks.
 	 */
 	for_each_possible_cpu(i) {
-		/* XXX Use node local allocations... XXX */
-		softirq_stack[i] = __va(memblock_alloc(THREAD_SIZE, THREAD_SIZE));
-		hardirq_stack[i] = __va(memblock_alloc(THREAD_SIZE, THREAD_SIZE));
-	}
+		int node = cpu_to_node(i);
 
-	/* Setup bootmem... */
-	last_valid_pfn = end_pfn = bootmem_init(phys_base);
+		softirq_stack[i] = __alloc_bootmem_node(NODE_DATA(node),
+							THREAD_SIZE,
+							THREAD_SIZE, 0);
+		hardirq_stack[i] = __alloc_bootmem_node(NODE_DATA(node),
+							THREAD_SIZE,
+							THREAD_SIZE, 0);
+	}
 
-#ifndef CONFIG_NEED_MULTIPLE_NODES
-	max_mapnr = last_valid_pfn;
-#endif
 	kernel_physical_mapping_init();
 
 	{
-- 
1.7.9.5


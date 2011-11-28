From: Tejun Heo <tj@kernel.org>
Date: Mon, 28 Nov 2011 19:31:18 +0000
Subject: [PATCH 16/23] sparc: Use HAVE_MEMBLOCK_NODE_MAP
Message-Id: <1322508685-32532-17-git-send-email-tj@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1322508685-32532-1-git-send-email-tj@kernel.org>
In-Reply-To: <1322508685-32532-1-git-send-email-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: benh@kernel.crashing.org, yinghai@kernel.org, hpa@zytor.com, tony.luck@intel.com, ralf@linux-mips.org, schwidefsky@de.ibm.com, liqin.chen@sunplusct.com, lethal@linux-sh.org, davem@davemloft.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@redhat.com, jonas@southpole.se, lennox.wu@gmail.com
Cc: Tejun Heo <tj@kernel.org>, Sam Ravnborg <sam@ravnborg.org>, sparclinux@vger.kernel.org

sparc doesn't access early_node_map[] directly and enabling
HAVE_MEMBLOCK_NODE_MAP is trivial - replacing add_active_range() calls
with memblock_set_node() and selecting HAVE_MEMBLOCK_NODE_MAP is
enough.

-v2: Use select in Kconfig instead as suggested by Sam Ravnborg.

Signed-off-by: Tejun Heo <tj@kernel.org>
Acked-by: "David S. Miller" <davem@davemloft.net>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: sparclinux@vger.kernel.org
---
 arch/sparc/Kconfig      |    1 +
 arch/sparc/mm/init_64.c |   24 ++++--------------------
 2 files changed, 5 insertions(+), 20 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index f92602e..91a6d1e 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -43,6 +43,7 @@ config SPARC64
 	select HAVE_KPROBES
 	select HAVE_RCU_TABLE_FREE if SMP
 	select HAVE_MEMBLOCK
+	select HAVE_MEMBLOCK_NODE_MAP
 	select HAVE_SYSCALL_WRAPPERS
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_FTRACE_MCOUNT_RECORD
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 29723a2..b3f5e7d 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -816,7 +816,7 @@ static u64 memblock_nid_range(u64 start, u64 end, int *nid)
 #endif
 
 /* This must be invoked after performing all of the necessary
- * add_active_range() calls for 'nid'.  We need to be able to get
+ * memblock_set_node() calls for 'nid'.  We need to be able to get
  * correct data from get_pfn_range_for_nid().
  */
 static void __init allocate_node_data(int nid)
@@ -987,14 +987,11 @@ static void __init add_node_ranges(void)
 
 			this_end = memblock_nid_range(start, end, &nid);
 
-			numadbg("Adding active range nid[%d] "
+			numadbg("Setting memblock NUMA node nid[%d] "
 				"start[%lx] end[%lx]\n",
 				nid, start, this_end);
 
-			add_active_range(nid,
-					 start >> PAGE_SHIFT,
-					 this_end >> PAGE_SHIFT);
-
+			memblock_set_node(start, this_end - start, nid);
 			start = this_end;
 		}
 	}
@@ -1282,7 +1279,6 @@ static void __init bootmem_init_nonnuma(void)
 {
 	unsigned long top_of_ram = memblock_end_of_DRAM();
 	unsigned long total_ram = memblock_phys_mem_size();
-	struct memblock_region *reg;
 
 	numadbg("bootmem_init_nonnuma()\n");
 
@@ -1292,20 +1288,8 @@ static void __init bootmem_init_nonnuma(void)
 	       (top_of_ram - total_ram) >> 20);
 
 	init_node_masks_nonnuma();
-
-	for_each_memblock(memory, reg) {
-		unsigned long start_pfn, end_pfn;
-
-		if (!reg->size)
-			continue;
-
-		start_pfn = memblock_region_memory_base_pfn(reg);
-		end_pfn = memblock_region_memory_end_pfn(reg);
-		add_active_range(0, start_pfn, end_pfn);
-	}
-
+	memblock_set_node(0, (phys_addr_t)ULLONG_MAX, 0);
 	allocate_node_data(0);
-
 	node_set_online(0);
 }
 
-- 
1.7.3.1


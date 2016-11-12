From: Thomas Tai <thomas.tai@oracle.com>
Date: Sat, 12 Nov 2016 00:41:00 +0000
Subject: [PATCH] sparc64: fix compile warning section mismatch in find_node()
Message-Id: <1478911260-108261-1-git-send-email-thomas.tai@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

A compile warning is introduced by a commit to fix the find_node().
This patch fix the compile warning by moving find_node() into __init
section. Because find_node() is only used by memblock_nid_range() which
is only used by a __init add_node_ranges(). find_node() and
memblock_nid_range() should also be inside __init section.

Signed-off-by: Thomas Tai <thomas.tai@oracle.com>
---
 arch/sparc/mm/init_64.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 068eb3d..37aa537 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -805,7 +805,7 @@ static int num_mblocks;
 static int find_numa_node_for_addr(unsigned long pa,
 				   struct node_mem_mask *pnode_mask);
 
-static unsigned long ra_to_pa(unsigned long addr)
+static unsigned long __init ra_to_pa(unsigned long addr)
 {
 	int i;
 
@@ -821,7 +821,7 @@ static unsigned long ra_to_pa(unsigned long addr)
 	return addr;
 }
 
-static int find_node(unsigned long addr)
+static int __init find_node(unsigned long addr)
 {
 	static bool search_mdesc = true;
 	static struct node_mem_mask last_mem_mask = { ~0UL, ~0UL };
@@ -858,7 +858,7 @@ static int find_node(unsigned long addr)
 	return last_index;
 }
 
-static u64 memblock_nid_range(u64 start, u64 end, int *nid)
+static u64 __init memblock_nid_range(u64 start, u64 end, int *nid)
 {
 	*nid = find_node(start);
 	start += PAGE_SIZE;
-- 
2.9.3


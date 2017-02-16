From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Thu, 16 Feb 2017 20:13:54 +0000
Subject: [PATCH] sparc64: memblock resizes are not handled properly
Message-Id: <1487276034-154065-2-git-send-email-pasha.tatashin@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1487276034-154065-1-git-send-email-pasha.tatashin@oracle.com>
In-Reply-To: <1487276034-154065-1-git-send-email-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

In add_node_ranges() when memblock resize happens, the iterator keeps using
the previous freed array. This bug cause hangs on machine where there are
over 128 memory blocks during boot. For example, on machines where memory
interleaving is small.
The problem is seen on T4-4 because it cant have 2T of memory, and memory
is  interleaved at 8G. So we have 2T/8G = 256 regions to set node IDs. The
starting size of regions array is 128. Thus, we have to double at least one
time (actually we have to double twice because some memory is already
reserved and thus we need more than 256 regions). We start using an
incorrect pointer to the array after the first doubling.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Signed-off-by: Babu Moger <babu.moger@oracle.com>
Reviewed-by: Babu Moger <babu.moger@oracle.com>
---
 arch/sparc/mm/init_64.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 5d2f915..3e934f2 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -1029,6 +1029,10 @@ int of_node_to_nid(struct device_node *dp)
 static void __init add_node_ranges(void)
 {
 	struct memblock_region *reg;
+	unsigned long prev_max;
+
+memblock_resized:
+	prev_max = memblock.memory.max;
 
 	for_each_memblock(memory, reg) {
 		unsigned long size = reg->size;
@@ -1048,6 +1052,8 @@ static void __init add_node_ranges(void)
 
 			memblock_set_node(start, this_end - start,
 					  &memblock.memory, nid);
+			if (memblock.memory.max != prev_max)
+				goto memblock_resized;
 			start = this_end;
 		}
 	}
-- 
1.7.1


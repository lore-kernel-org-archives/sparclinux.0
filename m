From: Tejun Heo <tj@kernel.org>
Date: Tue, 28 Feb 2012 20:56:21 +0000
Subject: [PATCH v3.3-rc5] memblock: Fix size aligning of memblock_alloc_base_nid()
Message-Id: <20120228205621.GC3252@dhcp-172-17-108-109.mtv.corp.google.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, Meelis Roos <mroos@linux.ee>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, sparclinux@vger.kernel.org, sam@ravnborg.org

memblock allocator aligns @size to @align to reduce the amount of
fragmentation.  7bd0b0f0da "memblock: Reimplement memblock allocation
using reverse free area iterator" broke it by incorrectly relocating
@size aligning to memblock_find_in_range_node().  As the aligned size
is not propagated back to memblock_alloc_base_nid(), the actually
reserved size isn't aligned.

While this increases memory use for memblock reserved array, this
shouldn't cause any critical failure; however, it seems that the size
aligning was hiding a use-beyond-allocation bug in sparc64 and losing
the aligning causes boot failure.

The underlying problem is currently being debugged but this is a
proper fix in itself, it's already pretty late in -rc cycle for boot
failures and reverting the change for debugging isn't difficult.
Restore the size aligning moving it to memblock_alloc_base_nid().

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Meelis Roos <mroos@linux.ee>
Reported-by: Sam Ravnborg <sam@ravnborg.org>
LKML-Reference: <alpine.SOC.1.00.1202130942030.1488@math.ut.ee>
---
 mm/memblock.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
diff --git a/mm/memblock.c b/mm/memblock.c
index 77b5f22..99f2855 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -99,9 +99,6 @@ phys_addr_t __init_memblock memblock_find_in_range_node(phys_addr_t start,
 	phys_addr_t this_start, this_end, cand;
 	u64 i;
 
-	/* align @size to avoid excessive fragmentation on reserved array */
-	size = round_up(size, align);
-
 	/* pump up @end */
 	if (end = MEMBLOCK_ALLOC_ACCESSIBLE)
 		end = memblock.current_limit;
@@ -731,6 +728,9 @@ static phys_addr_t __init memblock_alloc_base_nid(phys_addr_t size,
 {
 	phys_addr_t found;
 
+	/* align @size to avoid excessive fragmentation on reserved array */
+	size = round_up(size, align);
+
 	found = memblock_find_in_range_node(0, max_addr, size, align, nid);
 	if (found && !memblock_reserve(found, size))
 		return found;

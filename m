From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Fri, 05 May 2017 17:03:11 +0000
Subject: [v3 4/9] mm: do not zero vmemmap_buf
Message-Id: <1494003796-748672-5-git-send-email-pasha.tatashin@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1494003796-748672-1-git-send-email-pasha.tatashin@oracle.com>
In-Reply-To: <1494003796-748672-1-git-send-email-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com, heiko.carstens@de.ibm.com, davem@davemloft.net

alloc_block_buf() can either use external allocator by calling
vmemmap_alloc_block() or when available use pre-allocated vmemmap_buf
to do allocation. In either case, alloc_block_buf() knows when to zero
memory based on the "zero" argument.  This is why it is not needed to
zero vmemmap_buf beforehand. Let clients of alloc_block_buf() to
decide whether that is needed.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 mm/sparse-vmemmap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 5d255b0..1e9508b 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -305,7 +305,7 @@ void __init sparse_mem_maps_populate_node(struct page **map_map,
 
 	size = ALIGN(size, PMD_SIZE);
 	vmemmap_buf_start = __earlyonly_bootmem_alloc(nodeid, size
-			* map_count, PMD_SIZE, __pa(MAX_DMA_ADDRESS), true);
+			* map_count, PMD_SIZE, __pa(MAX_DMA_ADDRESS), false);
 
 	if (vmemmap_buf_start) {
 		vmemmap_buf = vmemmap_buf_start;
-- 
1.7.1


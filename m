From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Wed, 02 Aug 2017 20:38:24 +0000
Subject: [v4 15/15] mm: debug for raw alloctor
Message-Id: <1501706304-869240-16-git-send-email-pasha.tatashin@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1501706304-869240-1-git-send-email-pasha.tatashin@oracle.com>
In-Reply-To: <1501706304-869240-1-git-send-email-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

When CONFIG_DEBUG_VM is enabled, this patch sets all the memory that is
returned by memblock_virt_alloc_try_nid_raw() to ones to ensure that no
places excpect zeroed memory.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Reviewed-by: Steven Sistare <steven.sistare@oracle.com>
Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Reviewed-by: Bob Picco <bob.picco@oracle.com>
---
 mm/memblock.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index bdf31f207fa4..b6f90e75946c 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1363,12 +1363,19 @@ void * __init memblock_virt_alloc_try_nid_raw(
 			phys_addr_t min_addr, phys_addr_t max_addr,
 			int nid)
 {
+	void *ptr;
+
 	memblock_dbg("%s: %llu bytes align=0x%llx nid=%d from=0x%llx max_addr=0x%llx %pF\n",
 		     __func__, (u64)size, (u64)align, nid, (u64)min_addr,
 		     (u64)max_addr, (void *)_RET_IP_);
 
-	return memblock_virt_alloc_internal(size, align,
-					    min_addr, max_addr, nid);
+	ptr = memblock_virt_alloc_internal(size, align,
+					   min_addr, max_addr, nid);
+#ifdef CONFIG_DEBUG_VM
+	if (ptr && size > 0)
+		memset(ptr, 0xff, size);
+#endif
+	return ptr;
 }
 
 /**
-- 
2.13.3


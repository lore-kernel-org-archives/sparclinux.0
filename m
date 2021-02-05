From: Andreas Larsson <andreas@gaisler.com>
Date: Fri, 05 Feb 2021 13:20:31 +0000
Subject: [PATCH v2] sparc32: Limit memblock allocation to low memory
Message-Id: <20210205132031.25407-1-andreas@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org
Cc: Mike Rapoport <rppt@linux.ibm.com>, Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org, software@gaisler.com

Commit cca079ef8ac29a7c02192d2bad2ffe4c0c5ffdd0 changed sparc32 to use
memblocks instead of bootmem, but also made high memory available via
memblock allocation which does not work together with e.g. phys_to_virt
and can lead to kernel panic.

This changes back to only low memory being allocatable in the early
stages, now using memblock allocation.

Signed-off-by: Andreas Larsson <andreas@gaisler.com>
Acked-by: Mike Rapoport <rppt@linux.ibm.com>
---
Changes, in commit message, since v1:
- Added a missing "not" in "does not work"
- Clarified crash to kernel panic.
- Added Acked-by

arch/sparc/mm/init_32.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
index eb2946b1df8a..6139c5700ccc 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -197,6 +197,9 @@ unsigned long __init bootmem_init(unsigned long *pages_avail)
 	size = memblock_phys_mem_size() - memblock_reserved_size();
 	*pages_avail = (size >> PAGE_SHIFT) - high_pages;
 
+	/* Only allow low memory to be allocated via memblock allocation */
+	memblock_set_current_limit(max_low_pfn << PAGE_SHIFT);
+
 	return max_pfn;
 }
 
-- 
2.17.1

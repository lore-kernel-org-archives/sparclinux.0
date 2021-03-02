From: Sasha Levin <sashal@kernel.org>
Date: Tue, 02 Mar 2021 11:56:22 +0000
Subject: [PATCH AUTOSEL 5.10 23/47] sparc32: Limit memblock allocation to low memory
Message-Id: <20210302115646.62291-23-sashal@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20210302115646.62291-1-sashal@kernel.org>
In-Reply-To: <20210302115646.62291-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Andreas Larsson <andreas@gaisler.com>, Mike Rapoport <rppt@linux.ibm.com>, "David S . Miller" <davem@davemloft.net>, Sasha Levin <sashal@kernel.org>, sparclinux@vger.kernel.org

From: Andreas Larsson <andreas@gaisler.com>

[ Upstream commit bda166930c37604ffa93f2425426af6921ec575a ]

Commit cca079ef8ac29a7c02192d2bad2ffe4c0c5ffdd0 changed sparc32 to use
memblocks instead of bootmem, but also made high memory available via
memblock allocation which does not work together with e.g. phys_to_virt
and can lead to kernel panic.

This changes back to only low memory being allocatable in the early
stages, now using memblock allocation.

Signed-off-by: Andreas Larsson <andreas@gaisler.com>
Acked-by: Mike Rapoport <rppt@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
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
2.30.1

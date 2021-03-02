From: Sasha Levin <sashal@kernel.org>
Date: Tue, 02 Mar 2021 11:59:16 +0000
Subject: [PATCH AUTOSEL 4.9 05/10] sparc32: Limit memblock allocation to low memory
Message-Id: <20210302115921.63636-5-sashal@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20210302115921.63636-1-sashal@kernel.org>
In-Reply-To: <20210302115921.63636-1-sashal@kernel.org>
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
index 3b7092d9ea8f..4abe4bf08377 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -240,6 +240,9 @@ unsigned long __init bootmem_init(unsigned long *pages_avail)
 	reserve_bootmem((bootmap_pfn << PAGE_SHIFT), size, BOOTMEM_DEFAULT);
 	*pages_avail -= PAGE_ALIGN(size) >> PAGE_SHIFT;
 
+	/* Only allow low memory to be allocated via memblock allocation */
+	memblock_set_current_limit(max_low_pfn << PAGE_SHIFT);
+
 	return max_pfn;
 }
 
-- 
2.30.1

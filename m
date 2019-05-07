From: Sasha Levin <sashal@kernel.org>
Date: Tue, 07 May 2019 05:37:24 +0000
Subject: [PATCH AUTOSEL 4.14 35/95] sparc64: Export __node_distance.
Message-Id: <20190507053826.31622-35-sashal@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20190507053826.31622-1-sashal@kernel.org>
In-Reply-To: <20190507053826.31622-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Sasha Levin <alexander.levin@microsoft.com>, sparclinux@vger.kernel.org

From: "David S. Miller" <davem@davemloft.net>

[ Upstream commit 2b4792eaa9f553764047d157365ed8b7787751a3 ]

Some drivers reference it via node_distance(), for example the
NVME host driver core.

ERROR: "__node_distance" [drivers/nvme/host/nvme-core.ko] undefined!
make[1]: *** [scripts/Makefile.modpost:92: __modpost] Error 1

Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/sparc/mm/init_64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 984e9d65ea0d..76977296dc9c 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -1383,6 +1383,7 @@ int __node_distance(int from, int to)
 	}
 	return numa_latency[from][to];
 }
+EXPORT_SYMBOL(__node_distance);
 
 static int __init find_best_numa_node_for_mlgroup(struct mdesc_mlgroup *grp)
 {
-- 
2.20.1

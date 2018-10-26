From: David Miller <davem@davemloft.net>
Date: Fri, 26 Oct 2018 22:12:22 +0000
Subject: [PATCH] sparc64: Export __node_distance.
Message-Id: <20181026.151222.2282138700742476645.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Some drivers reference it via node_distance(), for example the
NVME host driver core.

ERROR: "__node_distance" [drivers/nvme/host/nvme-core.ko] undefined!
make[1]: *** [scripts/Makefile.modpost:92: __modpost] Error 1

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/mm/init_64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index f396048..39822f6 100644
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
2.1.2.532.g19b5d50

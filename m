From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Date: Wed, 26 Jul 2017 13:34:33 +0000
Subject: [PATCH 08/11] sparc64/topology: Remove the unused parent_node() macro
Message-Id: <1501076076-1974-9-git-send-email-douly.fnst@cn.fujitsu.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1501076076-1974-1-git-send-email-douly.fnst@cn.fujitsu.com>
In-Reply-To: <1501076076-1974-1-git-send-email-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: mpe@ellerman.id.au, Dou Liyang <douly.fnst@cn.fujitsu.com>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

Commit a7be6e5a7f8d ("mm: drop useless local parameters of
__register_one_node()") removes the last user of parent_node().

The parent_node() macro in SPARC64 platform is unnecessary.

Remove it for cleanup.

Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
---
 arch/sparc/include/asm/topology_64.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/sparc/include/asm/topology_64.h b/arch/sparc/include/asm/topology_64.h
index ad5293f..0fcc9a0 100644
--- a/arch/sparc/include/asm/topology_64.h
+++ b/arch/sparc/include/asm/topology_64.h
@@ -10,8 +10,6 @@ static inline int cpu_to_node(int cpu)
 	return numa_cpu_lookup_table[cpu];
 }
 
-#define parent_node(node)	(node)
-
 #define cpumask_of_node(node) ((node) = -1 ?				\
 			       cpu_all_mask :				\
 			       &numa_cpumask_lookup_table[node])
-- 
2.5.5




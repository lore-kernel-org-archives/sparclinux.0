From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Date: Fri, 01 Sep 2017 02:56:37 +0000
Subject: [PATCH v2 5/7] sparc64/topology: Remove the unused parent_node() macro
Message-Id: <1504234599-29533-6-git-send-email-douly.fnst@cn.fujitsu.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1504234599-29533-1-git-send-email-douly.fnst@cn.fujitsu.com>
In-Reply-To: <1504234599-29533-1-git-send-email-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

Commit a7be6e5a7f8d ("mm: drop useless local parameters of
__register_one_node()") removes the last user of parent_node().

The parent_node() macro in SPARC64 platform is unnecessary.

Remove it for cleanup.

Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
Acked-by: David S. Miller <davem@davemloft.net>
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




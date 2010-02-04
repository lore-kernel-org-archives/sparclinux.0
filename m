From: Chris Torek <chris.torek@windriver.com>
Date: Thu, 04 Feb 2010 11:25:58 +0000
Subject: [PATCH 4/8] net: sparc64 netdev_map_to_cpu()
Message-Id: <73c852f8f8035f5a432fba64e58b39737e2adde5.1265231569.git.chris.torek@windriver.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Hong H. Pham <hong.pham@windriver.com>

Override default netdev_map_to_cpu() implementation with SPARC64
optimized version.

If your (per port) number of receive helpers is at least half the
number of online CPUs, the flow hashing would have a good chance of
evenly distributing the work to strands (cpus) on separate cores.
The sparc optimized cpu distribution for netdev receive helpers would
have little or no effect.

If your number of netdev receive helpers is less than half the number
of online CPUs, the sparc optimized cpu placement with rx flow hashing
has a better chance to distribute work across more cores.

Worst case is if you have 8 rx helpers and all of them are assigned
to the same strand on a single core.  This can happen with the
"generic" linear assignment.  This can't happen with the sparc
optimized netdev_map_to_cpu().

Signed-off-by: Hong H. Pham <hong.pham@windriver.com>
---
 arch/sparc/kernel/cpumap.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/kernel/cpumap.c b/arch/sparc/kernel/cpumap.c
index 7430ed0..8aa308f 100644
--- a/arch/sparc/kernel/cpumap.c
+++ b/arch/sparc/kernel/cpumap.c
@@ -421,6 +421,12 @@ int map_to_cpu(unsigned int index)
 }
 EXPORT_SYMBOL(map_to_cpu);
 
+/* Override default implementation in net/core/dev.c */
+int netdev_map_to_cpu(unsigned int index)
+{
+	return map_to_cpu(index);
+}
+
 void cpu_map_rebuild(void)
 {
 	unsigned long flag;
-- 
1.6.0.4.766.g6fc4a


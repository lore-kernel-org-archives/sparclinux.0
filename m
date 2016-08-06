From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Sat, 06 Aug 2016 04:31:48 +0000
Subject: [PATCH] sparc64: fix section mismatch in find_numa_latencies_for_group
Message-Id: <20160806043148.11674-1-paul.gortmaker@windriver.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

To fix:

  WARNING: vmlinux.o(.text.unlikely+0x580): Section mismatch in
  reference from the function find_numa_latencies_for_group() to the
  function .init.text:find_mlgroup()

  The function find_numa_latencies_for_group() references the
  function __init find_mlgroup().  This is often because
  find_numa_latencies_for_group lacks a __init annotation or the
  annotation of find_mlgroup is wrong.

It turns out find_numa_latencies_for_group is only called from:
    static int __init numa_parse_mdesc(void)
and hence we can tag find_numa_latencies_for_group with __init.

In doing so we see that find_best_numa_node_for_mlgroup is only
called from within __init and hence can also be marked with __init.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Nitin Gupta <nitin.m.gupta@oracle.com>
Cc: Chris Hyser <chris.hyser@oracle.com>
Cc: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Cc: sparclinux@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/sparc/mm/init_64.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 904cf7d1a744..ddb71fd4d09a 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -1160,7 +1160,7 @@ int __node_distance(int from, int to)
 	return numa_latency[from][to];
 }
 
-static int find_best_numa_node_for_mlgroup(struct mdesc_mlgroup *grp)
+static int __init find_best_numa_node_for_mlgroup(struct mdesc_mlgroup *grp)
 {
 	int i;
 
@@ -1173,8 +1173,8 @@ static int find_best_numa_node_for_mlgroup(struct mdesc_mlgroup *grp)
 	return i;
 }
 
-static void find_numa_latencies_for_group(struct mdesc_handle *md, u64 grp,
-					  int index)
+static void __init find_numa_latencies_for_group(struct mdesc_handle *md,
+						 u64 grp, int index)
 {
 	u64 arc;
 
-- 
2.8.4


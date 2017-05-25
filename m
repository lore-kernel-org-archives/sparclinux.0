From: Jane Chu <jane.chu@oracle.com>
Date: Thu, 25 May 2017 19:51:20 +0000
Subject: [PATCH] arch/sparc: increase CONFIG_NODES_SHIFT on SPARC64 to 5
Message-Id: <1495741880-893167-1-git-send-email-jane.chu@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, jane.chu@oracle.com

SPARC M6-32 platform has (2^5) NUMA nodes, so need to bump up the
CONFIG_NODES_SHIFT to 5.

Orabug: 25577754

Signed-off-by: Jane Chu <jane.chu@oracle.com>

Reviewed-by: Bob Picco <bob.picco@oracle.com>
Reviewed-by: Atish Patra <atish.patra@oracle.com>
---
 arch/sparc/Kconfig |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 58243b0..e544ac1 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -295,9 +295,13 @@ config NUMA
 	depends on SPARC64 && SMP
 
 config NODES_SHIFT
-	int
-	default "4"
+	int "Maximum NUMA Nodes (as a power of 2)"
+	range 4 5 if SPARC64
+	default "5"
 	depends on NEED_MULTIPLE_NODES
+	help
+	  Specify the maximum number of NUMA Nodes available on the target
+	  system.  Increases memory reserved to accommodate various tables.
 
 # Some NUMA nodes have memory ranges that span
 # other nodes.  Even though a pfn is valid and
-- 
1.7.1


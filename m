From: Allen Pais <allen.pais@oracle.com>
Date: Mon, 08 Sep 2014 06:30:54 +0000
Subject: [PATCH v2 2/3] sparc64: support M6 and M7 for building CPU distribution map
Message-Id: <1410157135-20393-2-git-send-email-allen.pais@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Add M6 and M7 chip type in cpumap.c to correctly build CPU distribution map that spans all online CPUs.

Signed-off-by: Allen Pais <allen.pais@oracle.com>
---
 arch/sparc/kernel/cpumap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/sparc/kernel/cpumap.c b/arch/sparc/kernel/cpumap.c
index de1c844..e69ec0e 100644
--- a/arch/sparc/kernel/cpumap.c
+++ b/arch/sparc/kernel/cpumap.c
@@ -326,6 +326,8 @@ static int iterate_cpu(struct cpuinfo_tree *t, unsigned int root_index)
 	case SUN4V_CHIP_NIAGARA3:
 	case SUN4V_CHIP_NIAGARA4:
 	case SUN4V_CHIP_NIAGARA5:
+	case SUN4V_CHIP_SPARC_M6:
+	case SUN4V_CHIP_SPARC_M7:
 	case SUN4V_CHIP_SPARC64X:
 		rover_inc_table = niagara_iterate_method;
 		break;
-- 
1.8.4.2


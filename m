From: Allen Pais <allen.pais@oracle.com>
Date: Tue, 23 Jul 2013 11:33:05 +0000
Subject: [PATCH 2/2] [sparc64] support sparc64x chip type in cpumap.c
Message-Id: <1374578465-2899-1-git-send-email-allen.pais@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Add SPARC64X chip type in cpumap.c to correctly
build CPU distribution map that spans all CPUs.

Signed-off-by: Allen Pais <allen.pais@oracle.com>
---
 arch/sparc/kernel/cpumap.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sparc/kernel/cpumap.c b/arch/sparc/kernel/cpumap.c
index e4de74c..cb5d272 100644
--- a/arch/sparc/kernel/cpumap.c
+++ b/arch/sparc/kernel/cpumap.c
@@ -327,6 +327,7 @@ static int iterate_cpu(struct cpuinfo_tree *t, unsigned int root_index)
 	case SUN4V_CHIP_NIAGARA3:
 	case SUN4V_CHIP_NIAGARA4:
 	case SUN4V_CHIP_NIAGARA5:
+	case SUN4V_CHIP_SPARC64X:
 		rover_inc_table = niagara_iterate_method;
 		break;
 	default:
-- 
1.7.10.4


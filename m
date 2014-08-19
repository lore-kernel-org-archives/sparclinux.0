From: Allen Pais <allen.pais@oracle.com>
Date: Tue, 19 Aug 2014 05:12:07 +0000
Subject: [PATCH 2/3] sparc64: support M7 for building CPU distribution map
Message-Id: <1408424408-20449-1-git-send-email-allen.pais@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Add M7 chip type in cpumap.c to correctly build CPU distribution map that spans all online CPUs.

Signed-off-by: Allen Pais <allen.pais@oracle.com>
---
 arch/sparc/kernel/cpumap.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/kernel/cpumap.c b/arch/sparc/kernel/cpumap.c
index de1c844..0ece0ec 100644
--- a/arch/sparc/kernel/cpumap.c
+++ b/arch/sparc/kernel/cpumap.c
@@ -326,6 +326,7 @@ static int iterate_cpu(struct cpuinfo_tree *t, unsigned int root_index)
 	case SUN4V_CHIP_NIAGARA3:
 	case SUN4V_CHIP_NIAGARA4:
 	case SUN4V_CHIP_NIAGARA5:
+	case SUN4V_CHIP_SPARC_M7:
 	case SUN4V_CHIP_SPARC64X:
 		rover_inc_table = niagara_iterate_method;
 		break;
-- 
1.7.1


From: Joe Moriarty <joe.moriarty@oracle.com>
Date: Tue, 24 May 2016 15:16:12 +0000
Subject: [PATCH V2 2/2] arch/sparc:  SPARC-S7 epsc group support
Message-Id: <1464102972-676961-3-git-send-email-joe.moriarty@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Merge: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux

Needed for SPARC-S7 IB software support

Orabug: 23055865
Signed-off-by: Joe Moriarty <joe.moriarty@oracle.com>
Acked-by: Babu Moger <babu.moger@oracle.com>
---
 arch/sparc/include/asm/hypervisor.h |    1 +
 arch/sparc/kernel/hvapi.c           |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/include/asm/hypervisor.h b/arch/sparc/include/asm/hypervisor.h
index f5b6537..aa25da4 100644
--- a/arch/sparc/include/asm/hypervisor.h
+++ b/arch/sparc/include/asm/hypervisor.h
@@ -3001,6 +3001,7 @@ unsigned long sun4v_m7_set_perfreg(unsigned long reg_num,
 #define HV_GRP_KT_CPU			0x0209
 #define HV_GRP_VT_CPU			0x020c
 #define HV_GRP_T5_CPU			0x0211
+#define HV_GRP_EPSC			0x0241
 #define HV_GRP_DIAG			0x0300
 
 #ifndef __ASSEMBLY__
diff --git a/arch/sparc/kernel/hvapi.c b/arch/sparc/kernel/hvapi.c
index 662500f..9bc39a3 100644
--- a/arch/sparc/kernel/hvapi.c
+++ b/arch/sparc/kernel/hvapi.c
@@ -47,6 +47,7 @@ static struct api_info api_table[] = {
 	{ .group = HV_GRP_KT_CPU,				},
 	{ .group = HV_GRP_VT_CPU,				},
 	{ .group = HV_GRP_T5_CPU,				},
+	{ .group = HV_GRP_EPSC,					},
 	{ .group = HV_GRP_DIAG,		.flags = FLAG_PRE_API	},
 	{ .group = HV_GRP_M7_PERF,				},
 };
-- 
1.7.1


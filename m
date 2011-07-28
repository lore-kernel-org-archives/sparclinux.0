From: David Miller <davem@davemloft.net>
Date: Thu, 28 Jul 2011 08:44:03 +0000
Subject: [PATCH 2/6] sparc: Add T3 sun4v cpu type and hypervisor group
Message-Id: <20110728.014403.2119385801094743981.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/hypervisor.h |    1 +
 arch/sparc/include/asm/spitfire.h   |    1 +
 arch/sparc/kernel/hvapi.c           |    1 +
 3 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/include/asm/hypervisor.h b/arch/sparc/include/asm/hypervisor.h
index 7568640..7a5f80d 100644
--- a/arch/sparc/include/asm/hypervisor.h
+++ b/arch/sparc/include/asm/hypervisor.h
@@ -2950,6 +2950,7 @@ extern unsigned long sun4v_ncs_request(unsigned long request,
 #define HV_GRP_N2_CPU			0x0202
 #define HV_GRP_NIU			0x0204
 #define HV_GRP_VF_CPU			0x0205
+#define HV_GRP_KT_CPU			0x0209
 #define HV_GRP_DIAG			0x0300
 
 #ifndef __ASSEMBLY__
diff --git a/arch/sparc/include/asm/spitfire.h b/arch/sparc/include/asm/spitfire.h
index f0d0c40..55a17c6 100644
--- a/arch/sparc/include/asm/spitfire.h
+++ b/arch/sparc/include/asm/spitfire.h
@@ -42,6 +42,7 @@
 #define SUN4V_CHIP_INVALID	0x00
 #define SUN4V_CHIP_NIAGARA1	0x01
 #define SUN4V_CHIP_NIAGARA2	0x02
+#define SUN4V_CHIP_NIAGARA3	0x03
 #define SUN4V_CHIP_UNKNOWN	0xff
 
 #ifndef __ASSEMBLY__
diff --git a/arch/sparc/kernel/hvapi.c b/arch/sparc/kernel/hvapi.c
index 7c60afb..d306e64 100644
--- a/arch/sparc/kernel/hvapi.c
+++ b/arch/sparc/kernel/hvapi.c
@@ -38,6 +38,7 @@ static struct api_info api_table[] = {
 	{ .group = HV_GRP_N2_CPU,				},
 	{ .group = HV_GRP_NIU,					},
 	{ .group = HV_GRP_VF_CPU,				},
+	{ .group = HV_GRP_KT_CPU,				},
 	{ .group = HV_GRP_DIAG,		.flags = FLAG_PRE_API	},
 };
 
-- 
1.7.2.5


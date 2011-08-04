From: David Miller <davem@davemloft.net>
Date: Thu, 04 Aug 2011 09:03:10 +0000
Subject: [PATCH 5/7] sparc: Add some missing hypervisor API groups.
Message-Id: <20110804.020310.220389268209346861.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/hypervisor.h |    6 ++++++
 arch/sparc/kernel/hvapi.c           |    6 ++++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/include/asm/hypervisor.h b/arch/sparc/include/asm/hypervisor.h
index 7a5f80d..2b7da27 100644
--- a/arch/sparc/include/asm/hypervisor.h
+++ b/arch/sparc/include/asm/hypervisor.h
@@ -2940,11 +2940,17 @@ extern unsigned long sun4v_ncs_request(unsigned long request,
 #define HV_GRP_CORE			0x0001
 #define HV_GRP_INTR			0x0002
 #define HV_GRP_SOFT_STATE		0x0003
+#define HV_GRP_TM			0x0080
 #define HV_GRP_PCI			0x0100
 #define HV_GRP_LDOM			0x0101
 #define HV_GRP_SVC_CHAN			0x0102
 #define HV_GRP_NCS			0x0103
 #define HV_GRP_RNG			0x0104
+#define HV_GRP_PBOOT			0x0105
+#define HV_GRP_TPM			0x0107
+#define HV_GRP_SDIO			0x0108
+#define HV_GRP_SDIO_ERR			0x0109
+#define HV_GRP_REBOOT_DATA		0x0110
 #define HV_GRP_NIAG_PERF		0x0200
 #define HV_GRP_FIRE_PERF		0x0201
 #define HV_GRP_N2_CPU			0x0202
diff --git a/arch/sparc/kernel/hvapi.c b/arch/sparc/kernel/hvapi.c
index d306e64..c2d055d 100644
--- a/arch/sparc/kernel/hvapi.c
+++ b/arch/sparc/kernel/hvapi.c
@@ -28,11 +28,17 @@ static struct api_info api_table[] = {
 	{ .group = HV_GRP_CORE,		.flags = FLAG_PRE_API	},
 	{ .group = HV_GRP_INTR,					},
 	{ .group = HV_GRP_SOFT_STATE,				},
+	{ .group = HV_GRP_TM,					},
 	{ .group = HV_GRP_PCI,		.flags = FLAG_PRE_API	},
 	{ .group = HV_GRP_LDOM,					},
 	{ .group = HV_GRP_SVC_CHAN,	.flags = FLAG_PRE_API	},
 	{ .group = HV_GRP_NCS,		.flags = FLAG_PRE_API	},
 	{ .group = HV_GRP_RNG,					},
+	{ .group = HV_GRP_PBOOT,				},
+	{ .group = HV_GRP_TPM,					},
+	{ .group = HV_GRP_SDIO,					},
+	{ .group = HV_GRP_SDIO_ERR,				},
+	{ .group = HV_GRP_REBOOT_DATA,				},
 	{ .group = HV_GRP_NIAG_PERF,	.flags = FLAG_PRE_API	},
 	{ .group = HV_GRP_FIRE_PERF,				},
 	{ .group = HV_GRP_N2_CPU,				},
-- 
1.7.5.4


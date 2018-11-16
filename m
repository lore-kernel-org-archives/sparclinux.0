From: Rob Herring <robh@kernel.org>
Date: Fri, 16 Nov 2018 21:07:00 +0000
Subject: [PATCH v2 09/10] sparc: Remove unused leon_trans_init
Message-Id: <20181116210701.22968-10-robh@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The function leon_trans_init is unused. Remove it and save us from
figuring out what to do with a '<NULL>' node name.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/sparc/include/asm/leon.h   |  1 -
 arch/sparc/kernel/leon_kernel.c | 14 --------------
 2 files changed, 15 deletions(-)

diff --git a/arch/sparc/include/asm/leon.h b/arch/sparc/include/asm/leon.h
index c68bb5b76e3d..8c01f0f6b1ed 100644
--- a/arch/sparc/include/asm/leon.h
+++ b/arch/sparc/include/asm/leon.h
@@ -225,7 +225,6 @@ void leon_update_virq_handling(unsigned int virq,
 			       irq_flow_handler_t flow_handler,
 			       const char *name, int do_ack);
 void leon_init_timers(void);
-void leon_trans_init(struct device_node *dp);
 void leon_node_init(struct device_node *dp, struct device_node ***nextp);
 void init_leon(void);
 void poke_leonsparc(void);
diff --git a/arch/sparc/kernel/leon_kernel.c b/arch/sparc/kernel/leon_kernel.c
index 84b233752f28..39229940d725 100644
--- a/arch/sparc/kernel/leon_kernel.c
+++ b/arch/sparc/kernel/leon_kernel.c
@@ -484,20 +484,6 @@ static void leon_load_profile_irq(int cpu, unsigned int limit)
 {
 }
 
-void __init leon_trans_init(struct device_node *dp)
-{
-	if (strcmp(dp->type, "cpu") = 0 && strcmp(dp->name, "<NULL>") = 0) {
-		struct property *p;
-		p = of_find_property(dp, "mid", (void *)0);
-		if (p) {
-			int mid;
-			dp->name = prom_early_alloc(5 + 1);
-			memcpy(&mid, p->value, p->length);
-			sprintf((char *)dp->name, "cpu%.2d", mid);
-		}
-	}
-}
-
 #ifdef CONFIG_SMP
 void leon_clear_profile_irq(int cpu)
 {
-- 
2.19.1

From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 26 Jul 2012 21:02:20 +0000
Subject: [PATCH 10/18] sparc32,leon: drop leon_init()
Message-Id: <1343336548-3879-10-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This function was only used to set of_pdt_build_more to leon_node_init().
But the leon_node_init() was a nop as prom_amba_init was never assigned.

Cc: Daniel Hellstrom <daniel@gaisler.com>
Cc: Konrad Eisele <konrad@gaisler.com>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/leon.h   |    1 -
 arch/sparc/kernel/leon_kernel.c |   16 ----------------
 arch/sparc/mm/init_32.c         |    2 --
 3 files changed, 0 insertions(+), 19 deletions(-)

diff --git a/arch/sparc/include/asm/leon.h b/arch/sparc/include/asm/leon.h
index 3375c62..15a7169 100644
--- a/arch/sparc/include/asm/leon.h
+++ b/arch/sparc/include/asm/leon.h
@@ -82,7 +82,6 @@ static inline unsigned long leon_load_reg(unsigned long paddr)
 #define LEON_BYPASS_LOAD_PA(x)      leon_load_reg((unsigned long)(x))
 #define LEON_BYPASS_STORE_PA(x, v)  leon_store_reg((unsigned long)(x), (unsigned long)(v))
 
-extern void leon_init(void);
 extern void leon_switch_mm(void);
 extern void leon_init_IRQ(void);
 
diff --git a/arch/sparc/kernel/leon_kernel.c b/arch/sparc/kernel/leon_kernel.c
index e34e2c4..f8b6eee 100644
--- a/arch/sparc/kernel/leon_kernel.c
+++ b/arch/sparc/kernel/leon_kernel.c
@@ -486,17 +486,6 @@ void __init leon_trans_init(struct device_node *dp)
 	}
 }
 
-void __initdata (*prom_amba_init)(struct device_node *dp, struct device_node ***nextp) = 0;
-
-void __init leon_node_init(struct device_node *dp, struct device_node ***nextp)
-{
-	if (prom_amba_init &&
-	    strcmp(dp->type, "ambapp") = 0 &&
-	    strcmp(dp->name, "ambapp0") = 0) {
-		prom_amba_init(dp, nextp);
-	}
-}
-
 #ifdef CONFIG_SMP
 void leon_clear_profile_irq(int cpu)
 {
@@ -522,8 +511,3 @@ void __init leon_init_IRQ(void)
 	sparc_config.clear_clock_irq  = leon_clear_clock_irq;
 	sparc_config.load_profile_irq = leon_load_profile_irq;
 }
-
-void __init leon_init(void)
-{
-	of_pdt_build_more = &leon_node_init;
-}
diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
index ef5c779..e8ea360 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -294,8 +294,6 @@ void __init paging_init(void)
 {
 	switch(sparc_cpu_model) {
 	case sparc_leon:
-		leon_init();
-		/* fall through */
 	case sun4m:
 	case sun4d:
 		srmmu_paging_init();
-- 
1.6.0.6


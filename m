From: David Miller <davem@davemloft.net>
Date: Thu, 28 Aug 2008 04:25:04 +0000
Subject: [PATCH 42/49]: sparc: Kill sbus_arch_preinit().
Message-Id: <20080827.212504.151768491.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc: Kill sbus_arch_preinit().

32-bit sparc just needed it to register the ioport procfs bits, do this
via an arch_initcall() instead.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/ioport.c |   12 +++---------
 arch/sparc64/kernel/sbus.c |    5 -----
 drivers/sbus/sbus.c        |    3 ---
 3 files changed, 3 insertions(+), 17 deletions(-)

diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
index e6177dd..24645f9 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -393,21 +393,15 @@ void __init sbus_setup_iommu(struct sbus_bus *sbus, struct device_node *dp)
 #endif
 }
 
-int __init sbus_arch_preinit(void)
+static int __init sparc_register_ioport(void)
 {
 	register_proc_sparc_ioport();
 
-#ifdef CONFIG_SUN4
-	{
-		extern void sun4_dvma_init(void);
-		sun4_dvma_init();
-	}
-	return 1;
-#else
 	return 0;
-#endif
 }
 
+arch_initcall(sparc_register_ioport);
+
 void __init sbus_arch_postinit(void)
 {
 	if (sparc_cpu_model = sun4d) {
diff --git a/arch/sparc64/kernel/sbus.c b/arch/sparc64/kernel/sbus.c
index 0193e38..0b3e7bc 100644
--- a/arch/sparc64/kernel/sbus.c
+++ b/arch/sparc64/kernel/sbus.c
@@ -655,11 +655,6 @@ void __init sbus_setup_iommu(struct sbus_bus *sbus, struct device_node *dp)
 	sbus_iommu_init(dp->node, sbus);
 }
 
-int __init sbus_arch_preinit(void)
-{
-	return 0;
-}
-
 void __init sbus_arch_postinit(void)
 {
 	extern void firetruck_init(void);
diff --git a/drivers/sbus/sbus.c b/drivers/sbus/sbus.c
index 64c3e45..399567b 100644
--- a/drivers/sbus/sbus.c
+++ b/drivers/sbus/sbus.c
@@ -153,9 +153,6 @@ static int __init sbus_init(void)
 	const char *sbus_name = "sbus";
 	int num_sbus = 0;
 
-	if (sbus_arch_preinit())
-		return 0;
-
 	if (sparc_cpu_model = sun4d)
 		sbus_name = "sbi";
 
-- 
1.5.6.5.GIT


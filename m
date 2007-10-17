From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 17 Oct 2007 03:43:34 +0000
Subject: [PATCH 2/2] [POWERPC] Use of_register_driver to implement
Message-Id: <20071017134334.cad2363e.sfr@canb.auug.org.au>
List-Id: <sparclinux.vger.kernel.org>
References: <20071017134123.cfe10b79.sfr@canb.auug.org.au>
In-Reply-To: <20071017134123.cfe10b79.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: paulus@samba.org
Cc: sparclinux@vger.kernel.org, ppc-dev <linuxppc-dev@ozlabs.org>, "David S. Miller" <davem@davemloft.net>, wli@holomorphy.com

Also of_unregister{,_platform}_driver.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/of_platform.c |   20 --------------------
 include/asm-powerpc/of_platform.h |   10 ++++++++--
 2 files changed, 8 insertions(+), 22 deletions(-)

This depends on the Sparc part (patch 1/2) being in the tree first.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/kernel/of_platform.c b/arch/powerpc/kernel/of_platform.c
index eca8ccc..9b01602 100644
--- a/arch/powerpc/kernel/of_platform.c
+++ b/arch/powerpc/kernel/of_platform.c
@@ -67,26 +67,6 @@ static int __init of_bus_driver_init(void)
 
 postcore_initcall(of_bus_driver_init);
 
-int of_register_platform_driver(struct of_platform_driver *drv)
-{
-	/* initialize common driver fields */
-	if (!drv->driver.name)
-		drv->driver.name = drv->name;
-	if (!drv->driver.owner)
-		drv->driver.owner = drv->owner;
-	drv->driver.bus = &of_platform_bus_type;
-
-	/* register with core */
-	return driver_register(&drv->driver);
-}
-EXPORT_SYMBOL(of_register_platform_driver);
-
-void of_unregister_platform_driver(struct of_platform_driver *drv)
-{
-	driver_unregister(&drv->driver);
-}
-EXPORT_SYMBOL(of_unregister_platform_driver);
-
 static void of_platform_make_bus_id(struct of_device *dev)
 {
 	struct device_node *node = dev->node;
diff --git a/include/asm-powerpc/of_platform.h b/include/asm-powerpc/of_platform.h
index 80e6fad..d20a4cd 100644
--- a/include/asm-powerpc/of_platform.h
+++ b/include/asm-powerpc/of_platform.h
@@ -15,8 +15,14 @@
 #include <linux/of_platform.h>
 
 /* Platform drivers register/unregister */
-extern int of_register_platform_driver(struct of_platform_driver *drv);
-extern void of_unregister_platform_driver(struct of_platform_driver *drv);
+static inline int of_register_platform_driver(struct of_platform_driver *drv)
+{
+	return of_register_driver(drv, &of_platform_bus_type);
+}
+static inline void of_unregister_platform_driver(struct of_platform_driver *drv)
+{
+	of_unregister_driver(drv);
+}
 
 /* Platform devices and busses creation */
 extern struct of_device *of_platform_device_create(struct device_node *np,
-- 
1.5.3.4


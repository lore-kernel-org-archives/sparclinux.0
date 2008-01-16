From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 16 Jan 2008 05:54:19 +0000
Subject: [PATCH] [SPARC/64] remove of_platform_device_create
Message-Id: <20080116165419.57e49246.sfr@canb.auug.org.au>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

There are no callers of this on the Sparc platforms.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/sparc/kernel/of_device.c     |   27 ---------------------------
 arch/sparc64/kernel/of_device.c   |   26 --------------------------
 include/asm-sparc/of_platform.h   |    5 -----
 include/asm-sparc64/of_platform.h |    5 -----
 4 files changed, 0 insertions(+), 63 deletions(-)

Resent because the sparc-linux list did not like the addressing on the
previous email.

diff --git a/arch/sparc/kernel/of_device.c b/arch/sparc/kernel/of_device.c
index 3ea000d..cc4c235 100644
--- a/arch/sparc/kernel/of_device.c
+++ b/arch/sparc/kernel/of_device.c
@@ -584,30 +584,3 @@ static int __init of_debug(char *str)
 }
 
 __setup("of_debug=", of_debug);
-
-struct of_device* of_platform_device_create(struct device_node *np,
-					    const char *bus_id,
-					    struct device *parent,
-					    struct bus_type *bus)
-{
-	struct of_device *dev;
-
-	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
-	if (!dev)
-		return NULL;
-
-	dev->dev.parent = parent;
-	dev->dev.bus = bus;
-	dev->dev.release = of_release_dev;
-
-	strlcpy(dev->dev.bus_id, bus_id, BUS_ID_SIZE);
-
-	if (of_device_register(dev) != 0) {
-		kfree(dev);
-		return NULL;
-	}
-
-	return dev;
-}
-
-EXPORT_SYMBOL(of_platform_device_create);
diff --git a/arch/sparc64/kernel/of_device.c b/arch/sparc64/kernel/of_device.c
index fc5c0cc..0fd9db9 100644
--- a/arch/sparc64/kernel/of_device.c
+++ b/arch/sparc64/kernel/of_device.c
@@ -868,29 +868,3 @@ static int __init of_debug(char *str)
 }
 
 __setup("of_debug=", of_debug);
-
-struct of_device* of_platform_device_create(struct device_node *np,
-					    const char *bus_id,
-					    struct device *parent,
-					    struct bus_type *bus)
-{
-	struct of_device *dev;
-
-	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
-	if (!dev)
-		return NULL;
-
-	dev->dev.parent = parent;
-	dev->dev.bus = bus;
-	dev->dev.release = of_release_dev;
-
-	strlcpy(dev->dev.bus_id, bus_id, BUS_ID_SIZE);
-
-	if (of_device_register(dev) != 0) {
-		kfree(dev);
-		return NULL;
-	}
-
-	return dev;
-}
-EXPORT_SYMBOL(of_platform_device_create);
diff --git a/include/asm-sparc/of_platform.h b/include/asm-sparc/of_platform.h
index d638737..3833435 100644
--- a/include/asm-sparc/of_platform.h
+++ b/include/asm-sparc/of_platform.h
@@ -21,9 +21,4 @@ extern struct bus_type sbus_bus_type;
 
 #define of_bus_type	of_platform_bus_type	/* for compatibility */
 
-extern struct of_device *of_platform_device_create(struct device_node *np,
-						   const char *bus_id,
-						   struct device *parent,
-						   struct bus_type *bus);
-
 #endif	/* _ASM_SPARC_OF_PLATFORM_H */
diff --git a/include/asm-sparc64/of_platform.h b/include/asm-sparc64/of_platform.h
index f15cfa7..78aa032 100644
--- a/include/asm-sparc64/of_platform.h
+++ b/include/asm-sparc64/of_platform.h
@@ -22,9 +22,4 @@ extern struct bus_type sbus_bus_type;
 
 #define of_bus_type	of_platform_bus_type	/* for compatibility */
 
-extern struct of_device *of_platform_device_create(struct device_node *np,
-						   const char *bus_id,
-						   struct device *parent,
-						   struct bus_type *bus);
-
 #endif	/* _ASM_SPARC64_OF_PLATFORM_H */
-- 
1.5.3.8

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

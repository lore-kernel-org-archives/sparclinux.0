From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 21 Sep 2007 08:10:41 +0000
Subject: [PATCH] [SPARC/64] Prepare to remove of_platform_driver name
Message-Id: <20070921181041.79c998a2.sfr@canb.auug.org.au>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The name field of of_platform_driver is just copied into the
included device_driver.  By not overriding an already initialised
device_driver name, we can convert the drivers over time to stop using
the of_platform_driver name.

Also we were not copying the owner field from of_platform_driver, so do
the same with it.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 Documentation/sparc/sbus_drivers.txt |    4 +++-
 arch/sparc/kernel/of_device.c        |    5 ++++-
 arch/sparc64/kernel/of_device.c      |    5 ++++-
 3 files changed, 11 insertions(+), 3 deletions(-)

Do you guys want these split SPARC/SPARC64?
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/Documentation/sparc/sbus_drivers.txt b/Documentation/sparc/sbus_drivers.txt
index 8418d35..eb1e28a 100644
--- a/Documentation/sparc/sbus_drivers.txt
+++ b/Documentation/sparc/sbus_drivers.txt
@@ -67,10 +67,12 @@ probe in an SBUS driver under Linux:
 	MODULE_DEVICE_TABLE(of, mydevice_match);
 
 	static struct of_platform_driver mydevice_driver = {
-		.name		= "mydevice",
 		.match_table	= mydevice_match,
 		.probe		= mydevice_probe,
 		.remove		= __devexit_p(mydevice_remove),
+		.driver		= {
+			.name		= "mydevice",
+		},
 	};
 
 	static int __init mydevice_init(void)
diff --git a/arch/sparc/kernel/of_device.c b/arch/sparc/kernel/of_device.c
index 36383f7..fb2caef 100644
--- a/arch/sparc/kernel/of_device.c
+++ b/arch/sparc/kernel/of_device.c
@@ -588,7 +588,10 @@ __setup("of_debug=", of_debug);
 int of_register_driver(struct of_platform_driver *drv, struct bus_type *bus)
 {
 	/* initialize common driver fields */
-	drv->driver.name = drv->name;
+	if (!drv->driver.name)
+		drv->driver.name = drv->name;
+	if (!drv->driver.owner)
+		drv->driver.owner = drv->owner;
 	drv->driver.bus = bus;
 
 	/* register with core */
diff --git a/arch/sparc64/kernel/of_device.c b/arch/sparc64/kernel/of_device.c
index 4cc7748..42d7798 100644
--- a/arch/sparc64/kernel/of_device.c
+++ b/arch/sparc64/kernel/of_device.c
@@ -872,7 +872,10 @@ __setup("of_debug=", of_debug);
 int of_register_driver(struct of_platform_driver *drv, struct bus_type *bus)
 {
 	/* initialize common driver fields */
-	drv->driver.name = drv->name;
+	if (!drv->driver.name)
+		drv->driver.name = drv->name;
+	if (!drv->driver.owner)
+		drv->driver.owner = drv->owner;
 	drv->driver.bus = bus;
 
 	/* register with core */
-- 
1.5.3.2


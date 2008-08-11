From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 11 Aug 2008 06:07:37 +0000
Subject: [PATCH] sparc/drivers: use linux/of_device.h instead of
Message-Id: <20080811160737.34363e80.sfr@canb.auug.org.au>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/input/serio/i8042-sparcio.h |    3 ++-
 drivers/sbus/sbus.c                 |    2 +-
 drivers/serial/sunhv.c              |    2 +-
 drivers/serial/sunsab.c             |    2 +-
 drivers/serial/sunsu.c              |    2 +-
 drivers/serial/sunzilog.c           |    2 +-
 6 files changed, 7 insertions(+), 6 deletions(-)

These files are all Sparc specific (as far as I can tell) and this patch
fixes the last of these includes for Sparc.  Build tested for sparc32
defconfig and sparc64 allmodconfig.

diff --git a/drivers/input/serio/i8042-sparcio.h b/drivers/input/serio/i8042-sparcio.h
index 66bafe3..692a79e 100644
--- a/drivers/input/serio/i8042-sparcio.h
+++ b/drivers/input/serio/i8042-sparcio.h
@@ -1,10 +1,11 @@
 #ifndef _I8042_SPARCIO_H
 #define _I8042_SPARCIO_H
 
+#include <linux/of_device.h>
+
 #include <asm/io.h>
 #include <asm/oplib.h>
 #include <asm/prom.h>
-#include <asm/of_device.h>
 
 static int i8042_kbd_irq = -1;
 static int i8042_aux_irq = -1;
diff --git a/drivers/sbus/sbus.c b/drivers/sbus/sbus.c
index 73a86d0..9c12924 100644
--- a/drivers/sbus/sbus.c
+++ b/drivers/sbus/sbus.c
@@ -7,13 +7,13 @@
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/device.h>
+#include <linux/of_device.h>
 
 #include <asm/system.h>
 #include <asm/sbus.h>
 #include <asm/dma.h>
 #include <asm/oplib.h>
 #include <asm/prom.h>
-#include <asm/of_device.h>
 #include <asm/bpp.h>
 #include <asm/irq.h>
 
diff --git a/drivers/serial/sunhv.c b/drivers/serial/sunhv.c
index aeeec55..e41766d 100644
--- a/drivers/serial/sunhv.c
+++ b/drivers/serial/sunhv.c
@@ -17,11 +17,11 @@
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/init.h>
+#include <linux/of_device.h>
 
 #include <asm/hypervisor.h>
 #include <asm/spitfire.h>
 #include <asm/prom.h>
-#include <asm/of_device.h>
 #include <asm/irq.h>
 
 #if defined(CONFIG_MAGIC_SYSRQ)
diff --git a/drivers/serial/sunsab.c b/drivers/serial/sunsab.c
index 15ee497..29b4458 100644
--- a/drivers/serial/sunsab.c
+++ b/drivers/serial/sunsab.c
@@ -32,11 +32,11 @@
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/init.h>
+#include <linux/of_device.h>
 
 #include <asm/io.h>
 #include <asm/irq.h>
 #include <asm/prom.h>
-#include <asm/of_device.h>
 
 #if defined(CONFIG_SERIAL_SUNSAB_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
 #define SUPPORT_SYSRQ
diff --git a/drivers/serial/sunsu.c b/drivers/serial/sunsu.c
index e24e682..a378464 100644
--- a/drivers/serial/sunsu.c
+++ b/drivers/serial/sunsu.c
@@ -35,11 +35,11 @@
 #include <linux/serial_reg.h>
 #include <linux/init.h>
 #include <linux/delay.h>
+#include <linux/of_device.h>
 
 #include <asm/io.h>
 #include <asm/irq.h>
 #include <asm/prom.h>
-#include <asm/of_device.h>
 
 #if defined(CONFIG_SERIAL_SUNSU_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
 #define SUPPORT_SYSRQ
diff --git a/drivers/serial/sunzilog.c b/drivers/serial/sunzilog.c
index 0f3d69b..3cb4c8a 100644
--- a/drivers/serial/sunzilog.c
+++ b/drivers/serial/sunzilog.c
@@ -32,11 +32,11 @@
 #include <linux/serio.h>
 #endif
 #include <linux/init.h>
+#include <linux/of_device.h>
 
 #include <asm/io.h>
 #include <asm/irq.h>
 #include <asm/prom.h>
-#include <asm/of_device.h>
 
 #if defined(CONFIG_SERIAL_SUNZILOG_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
 #define SUPPORT_SYSRQ
-- 
1.5.6.3

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

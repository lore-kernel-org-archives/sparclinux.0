From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 07 Aug 2008 03:44:17 +0000
Subject: [PATCH] sparc: don't use asm/of_device.h
Message-Id: <20080807134417.6a1bc76d.sfr@canb.auug.org.au>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Use linux/of_device.h instead.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/sparc/include/asm/ebus_32.h |    2 +-
 arch/sparc/include/asm/ebus_64.h |    3 ++-
 arch/sparc/include/asm/parport.h |    3 ++-
 arch/sparc/include/asm/sbus_32.h |    2 +-
 arch/sparc/include/asm/sbus_64.h |    2 +-
 arch/sparc/kernel/ioport.c       |    2 +-
 arch/sparc/kernel/time.c         |    2 +-
 arch/sparc64/kernel/auxio.c      |    2 +-
 arch/sparc64/kernel/ebus.c       |    2 +-
 arch/sparc64/kernel/pci_common.c |    2 +-
 arch/sparc64/kernel/pci_psycho.c |    2 +-
 arch/sparc64/kernel/pci_sabre.c  |    2 +-
 arch/sparc64/kernel/pci_schizo.c |    2 +-
 arch/sparc64/kernel/power.c      |    2 +-
 arch/sparc64/kernel/prom.c       |    2 +-
 arch/sparc64/kernel/time.c       |    2 +-
 16 files changed, 18 insertions(+), 16 deletions(-)

This has been built for sparc64 allmodconfig and sparc allyesconfig
(because allmodconfig is broken for other reasons).

diff --git a/arch/sparc/include/asm/ebus_32.h b/arch/sparc/include/asm/ebus_32.h
index 29cb7df..f91f0b2 100644
--- a/arch/sparc/include/asm/ebus_32.h
+++ b/arch/sparc/include/asm/ebus_32.h
@@ -12,9 +12,9 @@
 #ifndef _LINUX_IOPORT_H
 #include <linux/ioport.h>
 #endif
+#include <linux/of_device.h>
 #include <asm/oplib.h>
 #include <asm/prom.h>
-#include <asm/of_device.h>
 
 struct linux_ebus_child {
 	struct linux_ebus_child		*next;
diff --git a/arch/sparc/include/asm/ebus_64.h b/arch/sparc/include/asm/ebus_64.h
index fcc62b9..14c6a11 100644
--- a/arch/sparc/include/asm/ebus_64.h
+++ b/arch/sparc/include/asm/ebus_64.h
@@ -8,9 +8,10 @@
 #ifndef __SPARC64_EBUS_H
 #define __SPARC64_EBUS_H
 
+#include <linux/of_device.h>
+
 #include <asm/oplib.h>
 #include <asm/prom.h>
-#include <asm/of_device.h>
 
 struct linux_ebus_child {
 	struct linux_ebus_child		*next;
diff --git a/arch/sparc/include/asm/parport.h b/arch/sparc/include/asm/parport.h
index 7818b25..d983062 100644
--- a/arch/sparc/include/asm/parport.h
+++ b/arch/sparc/include/asm/parport.h
@@ -6,9 +6,10 @@
 #ifndef _ASM_SPARC64_PARPORT_H
 #define _ASM_SPARC64_PARPORT_H 1
 
+#include <linux/of_device.h>
+
 #include <asm/ebus.h>
 #include <asm/ns87303.h>
-#include <asm/of_device.h>
 #include <asm/prom.h>
 
 #define PARPORT_PC_MAX_PORTS	PARPORT_MAX
diff --git a/arch/sparc/include/asm/sbus_32.h b/arch/sparc/include/asm/sbus_32.h
index 77b5d3a..a7b4fa2 100644
--- a/arch/sparc/include/asm/sbus_32.h
+++ b/arch/sparc/include/asm/sbus_32.h
@@ -9,10 +9,10 @@
 
 #include <linux/dma-mapping.h>
 #include <linux/ioport.h>
+#include <linux/of_device.h>
 
 #include <asm/oplib.h>
 #include <asm/prom.h>
-#include <asm/of_device.h>
 #include <asm/scatterlist.h>
 
 /* We scan which devices are on the SBus using the PROM node device
diff --git a/arch/sparc/include/asm/sbus_64.h b/arch/sparc/include/asm/sbus_64.h
index 0e16b6d..b606c14 100644
--- a/arch/sparc/include/asm/sbus_64.h
+++ b/arch/sparc/include/asm/sbus_64.h
@@ -8,10 +8,10 @@
 
 #include <linux/dma-mapping.h>
 #include <linux/ioport.h>
+#include <linux/of_device.h>
 
 #include <asm/oplib.h>
 #include <asm/prom.h>
-#include <asm/of_device.h>
 #include <asm/iommu.h>
 #include <asm/scatterlist.h>
 
diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
index 4879609..2a8a847 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -36,12 +36,12 @@
 #include <linux/pci.h>		/* struct pci_dev */
 #include <linux/proc_fs.h>
 #include <linux/scatterlist.h>
+#include <linux/of_device.h>
 
 #include <asm/io.h>
 #include <asm/vaddrs.h>
 #include <asm/oplib.h>
 #include <asm/prom.h>
-#include <asm/of_device.h>
 #include <asm/sbus.h>
 #include <asm/page.h>
 #include <asm/pgalloc.h>
diff --git a/arch/sparc/kernel/time.c b/arch/sparc/kernel/time.c
index ab3dd0b..0762f5d 100644
--- a/arch/sparc/kernel/time.c
+++ b/arch/sparc/kernel/time.c
@@ -28,6 +28,7 @@
 #include <linux/pci.h>
 #include <linux/ioport.h>
 #include <linux/profile.h>
+#include <linux/of_device.h>
 
 #include <asm/oplib.h>
 #include <asm/timer.h>
@@ -40,7 +41,6 @@
 #include <asm/sun4paddr.h>
 #include <asm/page.h>
 #include <asm/pcic.h>
-#include <asm/of_device.h>
 #include <asm/irq_regs.h>
 
 #include "irq.h"
diff --git a/arch/sparc64/kernel/auxio.c b/arch/sparc64/kernel/auxio.c
index c55f029..dd5c7bf 100644
--- a/arch/sparc64/kernel/auxio.c
+++ b/arch/sparc64/kernel/auxio.c
@@ -9,9 +9,9 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/ioport.h>
+#include <linux/of_device.h>
 
 #include <asm/prom.h>
-#include <asm/of_device.h>
 #include <asm/io.h>
 #include <asm/auxio.h>
 
diff --git a/arch/sparc64/kernel/ebus.c b/arch/sparc64/kernel/ebus.c
index 4d58d7c..60d36d1 100644
--- a/arch/sparc64/kernel/ebus.c
+++ b/arch/sparc64/kernel/ebus.c
@@ -14,13 +14,13 @@
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/pci.h>
+#include <linux/of_device.h>
 
 #include <asm/system.h>
 #include <asm/page.h>
 #include <asm/ebus.h>
 #include <asm/oplib.h>
 #include <asm/prom.h>
-#include <asm/of_device.h>
 #include <asm/bpp.h>
 #include <asm/irq.h>
 #include <asm/io.h>
diff --git a/arch/sparc64/kernel/pci_common.c b/arch/sparc64/kernel/pci_common.c
index 19fa621..09a5ec2 100644
--- a/arch/sparc64/kernel/pci_common.c
+++ b/arch/sparc64/kernel/pci_common.c
@@ -8,9 +8,9 @@
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/device.h>
+#include <linux/of_device.h>
 
 #include <asm/prom.h>
-#include <asm/of_device.h>
 #include <asm/oplib.h>
 
 #include "pci_impl.h"
diff --git a/arch/sparc64/kernel/pci_psycho.c b/arch/sparc64/kernel/pci_psycho.c
index b236142..1dc604b 100644
--- a/arch/sparc64/kernel/pci_psycho.c
+++ b/arch/sparc64/kernel/pci_psycho.c
@@ -12,12 +12,12 @@
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 
 #include <asm/iommu.h>
 #include <asm/irq.h>
 #include <asm/starfire.h>
 #include <asm/prom.h>
-#include <asm/of_device.h>
 #include <asm/oplib.h>
 
 #include "pci_impl.h"
diff --git a/arch/sparc64/kernel/pci_sabre.c b/arch/sparc64/kernel/pci_sabre.c
index 4c34195..ade5184 100644
--- a/arch/sparc64/kernel/pci_sabre.c
+++ b/arch/sparc64/kernel/pci_sabre.c
@@ -11,6 +11,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
+#include <linux/of_device.h>
 
 #include <asm/apb.h>
 #include <asm/iommu.h>
@@ -18,7 +19,6 @@
 #include <asm/smp.h>
 #include <asm/oplib.h>
 #include <asm/prom.h>
-#include <asm/of_device.h>
 
 #include "pci_impl.h"
 #include "iommu_common.h"
diff --git a/arch/sparc64/kernel/pci_schizo.c b/arch/sparc64/kernel/pci_schizo.c
index 982a711..04e038a 100644
--- a/arch/sparc64/kernel/pci_schizo.c
+++ b/arch/sparc64/kernel/pci_schizo.c
@@ -10,13 +10,13 @@
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 
 #include <asm/iommu.h>
 #include <asm/irq.h>
 #include <asm/upa.h>
 #include <asm/pstate.h>
 #include <asm/prom.h>
-#include <asm/of_device.h>
 #include <asm/oplib.h>
 
 #include "pci_impl.h"
diff --git a/arch/sparc64/kernel/power.c b/arch/sparc64/kernel/power.c
index eae8ca2..3bb987a 100644
--- a/arch/sparc64/kernel/power.c
+++ b/arch/sparc64/kernel/power.c
@@ -13,11 +13,11 @@
 #include <linux/pm.h>
 #include <linux/syscalls.h>
 #include <linux/reboot.h>
+#include <linux/of_device.h>
 
 #include <asm/system.h>
 #include <asm/auxio.h>
 #include <asm/prom.h>
-#include <asm/of_device.h>
 #include <asm/io.h>
 #include <asm/sstate.h>
 #include <asm/reboot.h>
diff --git a/arch/sparc64/kernel/prom.c b/arch/sparc64/kernel/prom.c
index 04c34f6..c040b7d 100644
--- a/arch/sparc64/kernel/prom.c
+++ b/arch/sparc64/kernel/prom.c
@@ -22,9 +22,9 @@
 #include <linux/module.h>
 #include <linux/lmb.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 
 #include <asm/prom.h>
-#include <asm/of_device.h>
 #include <asm/oplib.h>
 #include <asm/irq.h>
 #include <asm/asi.h>
diff --git a/arch/sparc64/kernel/time.c b/arch/sparc64/kernel/time.c
index a0c6a97..cc16fdc 100644
--- a/arch/sparc64/kernel/time.c
+++ b/arch/sparc64/kernel/time.c
@@ -33,6 +33,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/clockchips.h>
 #include <linux/clocksource.h>
+#include <linux/of_device.h>
 
 #include <asm/oplib.h>
 #include <asm/mostek.h>
@@ -40,7 +41,6 @@
 #include <asm/irq.h>
 #include <asm/io.h>
 #include <asm/prom.h>
-#include <asm/of_device.h>
 #include <asm/starfire.h>
 #include <asm/smp.h>
 #include <asm/sections.h>
-- 
1.5.6.3

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

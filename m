From: David Miller <davem@davemloft.net>
Date: Thu, 28 Aug 2008 04:25:17 +0000
Subject: [PATCH 47/49]: sparc: Kill now spurious includes of sbus.h
Message-Id: <20080827.212517.31159029.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc: Kill now spurious includes of sbus.h

In order to make this week I also had to add an include
of linux/dma-mapping.h to asm/pci_32.h because drivers/pci/pci.c
really depends upon getting this header somehow.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/dma.h        |    2 --
 arch/sparc/include/asm/pci_32.h     |    2 ++
 arch/sparc/kernel/ioport.c          |    1 -
 arch/sparc/kernel/pcic.c            |    1 -
 arch/sparc/kernel/sparc_ksyms.c     |    1 -
 arch/sparc/kernel/sun4d_smp.c       |    1 -
 arch/sparc/mm/io-unit.c             |    3 ++-
 arch/sparc/mm/iommu.c               |    3 ++-
 arch/sparc/mm/nosrmmu.c             |    1 -
 arch/sparc/mm/srmmu.c               |    1 -
 arch/sparc/prom/ranges.c            |    1 -
 arch/sparc64/kernel/irq.c           |    1 -
 arch/sparc64/kernel/sbus.c          |    4 +++-
 arch/sparc64/kernel/sparc64_ksyms.c |    1 -
 14 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/arch/sparc/include/asm/dma.h b/arch/sparc/include/asm/dma.h
index d1ae56b..b554927 100644
--- a/arch/sparc/include/asm/dma.h
+++ b/arch/sparc/include/asm/dma.h
@@ -91,8 +91,6 @@ extern int isa_dma_bridge_buggy;
 
 #ifdef CONFIG_SPARC32
 
-#include <asm/sbus.h>
-
 /* Routines for data transfer buffers. */
 BTFIXUPDEF_CALL(char *, mmu_lockarea, char *, unsigned long)
 BTFIXUPDEF_CALL(void,   mmu_unlockarea, char *, unsigned long)
diff --git a/arch/sparc/include/asm/pci_32.h b/arch/sparc/include/asm/pci_32.h
index 0ee949d..b41c4c1 100644
--- a/arch/sparc/include/asm/pci_32.h
+++ b/arch/sparc/include/asm/pci_32.h
@@ -3,6 +3,8 @@
 
 #ifdef __KERNEL__
 
+#include <linux/dma-mapping.h>
+
 /* Can be used to override the logic in pci_scan_bus for skipping
  * already-configured bus numbers - to be used for buggy BIOSes
  * or architectures with incomplete PCI setup by the loader.
diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
index bca2d6f..4f025b3 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -42,7 +42,6 @@
 #include <asm/vaddrs.h>
 #include <asm/oplib.h>
 #include <asm/prom.h>
-#include <asm/sbus.h>
 #include <asm/page.h>
 #include <asm/pgalloc.h>
 #include <asm/dma.h>
diff --git a/arch/sparc/kernel/pcic.c b/arch/sparc/kernel/pcic.c
index a6a6f98..9a0aa4e 100644
--- a/arch/sparc/kernel/pcic.c
+++ b/arch/sparc/kernel/pcic.c
@@ -18,7 +18,6 @@
 #include <linux/jiffies.h>
 
 #include <asm/ebus.h>
-#include <asm/sbus.h> /* for sanity check... */
 #include <asm/swift.h> /* for cache flushing. */
 #include <asm/io.h>
 
diff --git a/arch/sparc/kernel/sparc_ksyms.c b/arch/sparc/kernel/sparc_ksyms.c
index a9478db..50ec48d 100644
--- a/arch/sparc/kernel/sparc_ksyms.c
+++ b/arch/sparc/kernel/sparc_ksyms.c
@@ -43,7 +43,6 @@
 #include <asm/uaccess.h>
 #include <asm/checksum.h>
 #ifdef CONFIG_SBUS
-#include <asm/sbus.h>
 #include <asm/dma.h>
 #endif
 #ifdef CONFIG_PCI
diff --git a/arch/sparc/kernel/sun4d_smp.c b/arch/sparc/kernel/sun4d_smp.c
index dfde77f..bf7147a 100644
--- a/arch/sparc/kernel/sun4d_smp.c
+++ b/arch/sparc/kernel/sun4d_smp.c
@@ -30,7 +30,6 @@
 #include <asm/pgalloc.h>
 #include <asm/pgtable.h>
 #include <asm/oplib.h>
-#include <asm/sbus.h>
 #include <asm/sbi.h>
 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>
diff --git a/arch/sparc/mm/io-unit.c b/arch/sparc/mm/io-unit.c
index 5390023..daadf5f 100644
--- a/arch/sparc/mm/io-unit.c
+++ b/arch/sparc/mm/io-unit.c
@@ -12,10 +12,11 @@
 #include <linux/highmem.h>	/* pte_offset_map => kmap_atomic */
 #include <linux/bitops.h>
 #include <linux/scatterlist.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 
 #include <asm/pgalloc.h>
 #include <asm/pgtable.h>
-#include <asm/sbus.h>
 #include <asm/io.h>
 #include <asm/io-unit.h>
 #include <asm/mxcc.h>
diff --git a/arch/sparc/mm/iommu.c b/arch/sparc/mm/iommu.c
index 7c55450..e7a499e 100644
--- a/arch/sparc/mm/iommu.c
+++ b/arch/sparc/mm/iommu.c
@@ -13,10 +13,11 @@
 #include <linux/slab.h>
 #include <linux/highmem.h>	/* pte_offset_map => kmap_atomic */
 #include <linux/scatterlist.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 
 #include <asm/pgalloc.h>
 #include <asm/pgtable.h>
-#include <asm/sbus.h>
 #include <asm/io.h>
 #include <asm/mxcc.h>
 #include <asm/mbus.h>
diff --git a/arch/sparc/mm/nosrmmu.c b/arch/sparc/mm/nosrmmu.c
index 3701f70..4f061bb 100644
--- a/arch/sparc/mm/nosrmmu.c
+++ b/arch/sparc/mm/nosrmmu.c
@@ -9,7 +9,6 @@
 #include <linux/mm.h>
 #include <linux/init.h>
 #include <asm/mbus.h>
-#include <asm/sbus.h>
 
 static char shouldnothappen[] __initdata = "SUN4 kernel can only run on SUN4\n";
 
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index ee30462..6a5d7ca 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -31,7 +31,6 @@
 #include <asm/mbus.h>
 #include <asm/cache.h>
 #include <asm/oplib.h>
-#include <asm/sbus.h>
 #include <asm/asi.h>
 #include <asm/msi.h>
 #include <asm/mmu_context.h>
diff --git a/arch/sparc/prom/ranges.c b/arch/sparc/prom/ranges.c
index f9b7def..64579a3 100644
--- a/arch/sparc/prom/ranges.c
+++ b/arch/sparc/prom/ranges.c
@@ -9,7 +9,6 @@
 #include <asm/openprom.h>
 #include <asm/oplib.h>
 #include <asm/types.h>
-#include <asm/sbus.h>
 #include <asm/system.h>
 
 struct linux_prom_ranges promlib_obio_ranges[PROMREG_MAX];
diff --git a/arch/sparc64/kernel/irq.c b/arch/sparc64/kernel/irq.c
index 9b6689d..2817a27 100644
--- a/arch/sparc64/kernel/irq.c
+++ b/arch/sparc64/kernel/irq.c
@@ -28,7 +28,6 @@
 #include <asm/system.h>
 #include <asm/irq.h>
 #include <asm/io.h>
-#include <asm/sbus.h>
 #include <asm/iommu.h>
 #include <asm/upa.h>
 #include <asm/oplib.h>
diff --git a/arch/sparc64/kernel/sbus.c b/arch/sparc64/kernel/sbus.c
index 60605ea..9d7dfb8 100644
--- a/arch/sparc64/kernel/sbus.c
+++ b/arch/sparc64/kernel/sbus.c
@@ -11,15 +11,17 @@
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 
 #include <asm/page.h>
-#include <asm/sbus.h>
 #include <asm/io.h>
 #include <asm/upa.h>
 #include <asm/cache.h>
 #include <asm/dma.h>
 #include <asm/irq.h>
 #include <asm/prom.h>
+#include <asm/oplib.h>
 #include <asm/starfire.h>
 
 #include "iommu_common.h"
diff --git a/arch/sparc64/kernel/sparc64_ksyms.c b/arch/sparc64/kernel/sparc64_ksyms.c
index 08c58a8..142c169 100644
--- a/arch/sparc64/kernel/sparc64_ksyms.c
+++ b/arch/sparc64/kernel/sparc64_ksyms.c
@@ -44,7 +44,6 @@
 #include <asm/pgalloc.h>
 #include <asm/cacheflush.h>
 #ifdef CONFIG_SBUS
-#include <asm/sbus.h>
 #include <asm/dma.h>
 #endif
 #ifdef CONFIG_PCI
-- 
1.5.6.5.GIT


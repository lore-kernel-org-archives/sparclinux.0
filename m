From: David Miller <davem@davemloft.net>
Date: Thu, 28 Aug 2008 04:24:57 +0000
Subject: [PATCH 39/49]: sparc: Kill sbus_devaddr() and sbus_dev_slot().
Message-Id: <20080827.212457.169426987.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc: Kill sbus_devaddr() and sbus_dev_slot().

Unused.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/sbus_32.h |   18 ------------------
 arch/sparc/include/asm/sbus_64.h |   18 ------------------
 2 files changed, 0 insertions(+), 36 deletions(-)

diff --git a/arch/sparc/include/asm/sbus_32.h b/arch/sparc/include/asm/sbus_32.h
index 9f35ae8..fdaf1a7 100644
--- a/arch/sparc/include/asm/sbus_32.h
+++ b/arch/sparc/include/asm/sbus_32.h
@@ -21,24 +21,6 @@
  * you can get a SBus 'slot' number and an offset within that slot.
  */
 
-/* The base address at which to calculate device OBIO addresses. */
-#define SUN_SBUS_BVADDR        0xf8000000
-#define SBUS_OFF_MASK          0x01ffffff
-
-/* These routines are used to calculate device address from slot
- * numbers + offsets, and vice versa.
- */
-
-static inline unsigned long sbus_devaddr(int slotnum, unsigned long offset)
-{
-  return (unsigned long) (SUN_SBUS_BVADDR+((slotnum)<<25)+(offset));
-}
-
-static inline int sbus_dev_slot(unsigned long dev_addr)
-{
-  return (int) (((dev_addr)-SUN_SBUS_BVADDR)>>25);
-}
-
 struct sbus_bus;
 
 /* Linux SBUS device tables */
diff --git a/arch/sparc/include/asm/sbus_64.h b/arch/sparc/include/asm/sbus_64.h
index ec3509a..6b3b055 100644
--- a/arch/sparc/include/asm/sbus_64.h
+++ b/arch/sparc/include/asm/sbus_64.h
@@ -21,24 +21,6 @@
  * you can get a SBus 'slot' number and an offset within that slot.
  */
 
-/* The base address at which to calculate device OBIO addresses. */
-#define SUN_SBUS_BVADDR        0x00000000
-#define SBUS_OFF_MASK          0x0fffffff
-
-/* These routines are used to calculate device address from slot
- * numbers + offsets, and vice versa.
- */
-
-static inline unsigned long sbus_devaddr(int slotnum, unsigned long offset)
-{
-  return (unsigned long) (SUN_SBUS_BVADDR+((slotnum)<<28)+(offset));
-}
-
-static inline int sbus_dev_slot(unsigned long dev_addr)
-{
-  return (int) (((dev_addr)-SUN_SBUS_BVADDR)>>28);
-}
-
 struct sbus_bus;
 
 /* Linux SBUS device tables */
-- 
1.5.6.5.GIT


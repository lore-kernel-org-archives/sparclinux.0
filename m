From: David Miller <davem@davemloft.net>
Date: Sat, 12 May 2012 04:12:07 +0000
Subject: [PATCH] sparc32: Kill asm/vac-ops.h
Message-Id: <20120512.001207.1174515841668389615.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


All sun4/sun4c stuff and unused.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/pgtable_32.h |    1 -
 arch/sparc/include/asm/uaccess_32.h |    1 -
 arch/sparc/include/asm/vac-ops.h    |  127 -----------------------------------
 arch/sparc/mm/init_32.c             |    1 -
 4 files changed, 130 deletions(-)
 delete mode 100644 arch/sparc/include/asm/vac-ops.h

diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
index f451d43..9f3ab0a 100644
--- a/arch/sparc/include/asm/pgtable_32.h
+++ b/arch/sparc/include/asm/pgtable_32.h
@@ -17,7 +17,6 @@
 #include <linux/swap.h>
 #include <asm/types.h>
 #include <asm/pgtsrmmu.h>
-#include <asm/vac-ops.h>
 #include <asm/oplib.h>
 #include <asm/btfixup.h>
 #include <asm/cpu_type.h>
diff --git a/arch/sparc/include/asm/uaccess_32.h b/arch/sparc/include/asm/uaccess_32.h
index 8303ac4..d50c310 100644
--- a/arch/sparc/include/asm/uaccess_32.h
+++ b/arch/sparc/include/asm/uaccess_32.h
@@ -12,7 +12,6 @@
 #include <linux/sched.h>
 #include <linux/string.h>
 #include <linux/errno.h>
-#include <asm/vac-ops.h>
 #endif
 
 #ifndef __ASSEMBLY__
diff --git a/arch/sparc/include/asm/vac-ops.h b/arch/sparc/include/asm/vac-ops.h
deleted file mode 100644
index a63e88e..0000000
--- a/arch/sparc/include/asm/vac-ops.h
+++ /dev/null
@@ -1,127 +0,0 @@
-#ifndef _SPARC_VAC_OPS_H
-#define _SPARC_VAC_OPS_H
-
-/* vac-ops.h: Inline assembly routines to do operations on the Sparc
- *            VAC (virtual address cache) for the sun4c.
- *
- * Copyright (C) 1994, David S. Miller (davem@caip.rutgers.edu)
- */
-
-#include <asm/sysen.h>
-#include <asm/contregs.h>
-#include <asm/asi.h>
-
-/* The SUN4C models have a virtually addressed write-through
- * cache.
- *
- * The cache tags are directly accessible through an ASI and
- * each have the form:
- *
- * ------------------------------------------------------------
- * | MBZ | CONTEXT | WRITE | PRIV | VALID | MBZ | TagID | MBZ |
- * ------------------------------------------------------------
- *  31 25  24   22     21     20     19    18 16  15   2  1  0
- *
- * MBZ: These bits are either unused and/or reserved and should
- *      be written as zeroes.
- *
- * CONTEXT: Records the context to which this cache line belongs.
- *
- * WRITE: A copy of the writable bit from the mmu pte access bits.
- *
- * PRIV: A copy of the privileged bit from the pte access bits.
- *
- * VALID: If set, this line is valid, else invalid.
- *
- * TagID: Fourteen bits of tag ID.
- *
- * Every virtual address is seen by the cache like this:
- *
- * ----------------------------------------
- * |  RESV  | TagID | LINE | BYTE-in-LINE |
- * ----------------------------------------
- *  31    30 29   16 15   4 3            0
- *
- * RESV: Unused/reserved.
- *
- * TagID: Used to match the Tag-ID in that vac tags.
- *
- * LINE: Which line within the cache
- *
- * BYTE-in-LINE: Which byte within the cache line.
- */
-
-/* Sun4c VAC Tags */
-#define S4CVACTAG_CID      0x01c00000
-#define S4CVACTAG_W        0x00200000
-#define S4CVACTAG_P        0x00100000
-#define S4CVACTAG_V        0x00080000
-#define S4CVACTAG_TID      0x0000fffc
-
-/* Sun4c VAC Virtual Address */
-/* These aren't used, why bother? (Anton) */
-#if 0
-#define S4CVACVA_TID       0x3fff0000
-#define S4CVACVA_LINE      0x0000fff0
-#define S4CVACVA_BIL       0x0000000f
-#endif
-
-/* The indexing of cache lines creates a problem.  Because the line
- * field of a virtual address extends past the page offset within
- * the virtual address it is possible to have what are called
- * 'bad aliases' which will create inconsistencies.  So we must make
- * sure that within a context that if a physical page is mapped
- * more than once, that 'extra' line bits are the same.  If this is
- * not the case, and thus is a 'bad alias' we must turn off the
- * cacheable bit in the pte's of all such pages.
- */
-
-#define S4CVAC_BADBITS    0x0000f000
-
-/* The following is true if vaddr1 and vaddr2 would cause
- * a 'bad alias'.
- */
-#define S4CVAC_BADALIAS(vaddr1, vaddr2) \
-        ((((unsigned long) (vaddr1)) ^ ((unsigned long) (vaddr2))) & \
-	 (S4CVAC_BADBITS))
-
-/* The following structure describes the characteristics of a sun4c
- * VAC as probed from the prom during boot time.
- */
-struct sun4c_vac_props {
-	unsigned int num_bytes;     /* Size of the cache */
-	unsigned int do_hwflushes;  /* Hardware flushing available? */
-	unsigned int linesize;      /* Size of each line in bytes */
-	unsigned int log2lsize;     /* log2(linesize) */
-	unsigned int on;            /* VAC is enabled */
-};
-
-extern struct sun4c_vac_props sun4c_vacinfo;
-
-/* sun4c_enable_vac() enables the sun4c virtual address cache. */
-static inline void sun4c_enable_vac(void)
-{
-	__asm__ __volatile__("lduba [%0] %1, %%g1\n\t"
-			     "or    %%g1, %2, %%g1\n\t"
-			     "stba  %%g1, [%0] %1\n\t"
-			     : /* no outputs */
-			     : "r" ((unsigned int) AC_SENABLE),
-			     "i" (ASI_CONTROL), "i" (SENABLE_CACHE)
-			     : "g1", "memory");
-	sun4c_vacinfo.on = 1;
-}
-
-/* sun4c_disable_vac() disables the virtual address cache. */
-static inline void sun4c_disable_vac(void)
-{
-	__asm__ __volatile__("lduba [%0] %1, %%g1\n\t"
-			     "andn  %%g1, %2, %%g1\n\t"
-			     "stba  %%g1, [%0] %1\n\t"
-			     : /* no outputs */
-			     : "r" ((unsigned int) AC_SENABLE),
-			     "i" (ASI_CONTROL), "i" (SENABLE_CACHE)
-			     : "g1", "memory");
-	sun4c_vacinfo.on = 0;
-}
-
-#endif /* !(_SPARC_VAC_OPS_H) */
diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
index 15848e7..21342db 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -27,7 +27,6 @@
 #include <linux/gfp.h>
 
 #include <asm/sections.h>
-#include <asm/vac-ops.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include <asm/vaddrs.h>
-- 
1.7.10


From: David Miller <davem@davemloft.net>
Date: Sat, 12 May 2012 04:48:20 +0000
Subject: [PATCH] sparc32: Kill unused defines from asm/head_32.h
Message-Id: <20120512.004820.1528126781453720575.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/head_32.h |    7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/sparc/include/asm/head_32.h b/arch/sparc/include/asm/head_32.h
index 2546039..a768748 100644
--- a/arch/sparc/include/asm/head_32.h
+++ b/arch/sparc/include/asm/head_32.h
@@ -2,15 +2,8 @@
 #define __SPARC_HEAD_H
 
 #define KERNBASE        0xf0000000  /* First address the kernel will eventually be */
-#define LOAD_ADDR       0x4000      /* prom jumps to us here unless this is elf /boot */
-#define SUN4C_SEGSZ     (1 << 18)
-#define SRMMU_L1_KBASE_OFFSET ((KERNBASE>>24)<<2)  /* Used in boot remapping. */
-#define INTS_ENAB        0x01           /* entry.S uses this. */
-
-#define SUN4_PROM_VECTOR 0xFFE81000     /* SUN4 PROM needs to be hardwired */
 
 #define WRITE_PAUSE      nop; nop; nop; /* Have to do this after %wim/%psr chg */
-#define NOP_INSN         0x01000000     /* Used to patch sparc_save_state */
 
 /* Here are some trap goodies */
 
-- 
1.7.10


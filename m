From: David Miller <davem@davemloft.net>
Date: Sat, 12 May 2012 04:34:10 +0000
Subject: [PATCH] sparc32: Remove sun4{,c} control reg definitions from contregs.h.
Message-Id: <20120512.003410.1062688378999871426.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


No longer used.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/contregs.h |   22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/arch/sparc/include/asm/contregs.h b/arch/sparc/include/asm/contregs.h
index 48fa8a4..b8abdfc 100644
--- a/arch/sparc/include/asm/contregs.h
+++ b/arch/sparc/include/asm/contregs.h
@@ -7,28 +7,6 @@
  * Copyright (C) 1995 David S. Miller (davem@caip.rutgers.edu)
  */
 
-/* 3=sun3
-   4=sun4 (as in sun4 sysmaint student book)
-   c=sun4c (according to davem) */
-
-#define AC_IDPROM     0x00000000    /* 34  ID PROM, R/O, byte, 32 bytes      */
-#define AC_PAGEMAP    0x10000000    /* 3   Pagemap R/W, long                 */
-#define AC_SEGMAP     0x20000000    /* 3   Segment map, byte                 */
-#define AC_CONTEXT    0x30000000    /* 34c current mmu-context               */
-#define AC_SENABLE    0x40000000    /* 34c system dvma/cache/reset enable reg*/
-#define AC_UDVMA_ENB  0x50000000    /* 34  Not used on Sun boards, byte      */
-#define AC_BUS_ERROR  0x60000000    /* 34  Not cleared on read, byte.        */
-#define AC_SYNC_ERR   0x60000000    /*  c fault type                         */
-#define AC_SYNC_VA    0x60000004    /*  c fault virtual address              */
-#define AC_ASYNC_ERR  0x60000008    /*  c asynchronous fault type            */
-#define AC_ASYNC_VA   0x6000000c    /*  c async fault virtual address        */
-#define AC_LEDS       0x70000000    /* 34  Zero turns on LEDs, byte          */
-#define AC_CACHETAGS  0x80000000    /* 34c direct access to the VAC tags     */
-#define AC_CACHEDDATA 0x90000000    /* 3 c direct access to the VAC data     */
-#define AC_UDVMA_MAP  0xD0000000    /* 4  Not used on Sun boards, byte       */
-#define AC_VME_VECTOR 0xE0000000    /* 4  For non-Autovector VME, byte       */
-#define AC_BOOT_SCC   0xF0000000    /* 34  bypass to access Zilog 8530. byte.*/
-
 /* s=Swift, h=Ross_HyperSPARC, v=TI_Viking, t=Tsunami, r=Ross_Cypress        */
 #define AC_M_PCR      0x0000        /* shv Processor Control Reg             */
 #define AC_M_CTPR     0x0100        /* shv Context Table Pointer Reg         */
-- 
1.7.10


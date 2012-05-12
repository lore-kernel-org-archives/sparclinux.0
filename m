From: David Miller <davem@davemloft.net>
Date: Sat, 12 May 2012 03:56:12 +0000
Subject: [PATCH] sparc32: Kill SUN4C_LOCK_{VADDR,END} and associated comment.
Message-Id: <20120511.235612.169681595028156441.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


No longer used.

Signed-off-by: David S. Miller <davem@davemloft.net>
---

Move along, nothing to see here.

 arch/sparc/include/asm/vaddrs.h |   16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/arch/sparc/include/asm/vaddrs.h b/arch/sparc/include/asm/vaddrs.h
index 541e137..da6535d 100644
--- a/arch/sparc/include/asm/vaddrs.h
+++ b/arch/sparc/include/asm/vaddrs.h
@@ -34,22 +34,6 @@
 #define IOBASE_VADDR		0xfe000000
 #define IOBASE_END		0xfe600000
 
-/*
- * On the sun4/4c we need a place
- * to reliably map locked down kernel data.  This includes the
- * task_struct and kernel stack pages of each process plus the
- * scsi buffers during dvma IO transfers, also the floppy buffers
- * during pseudo dma which runs with traps off (no faults allowed).
- * Some quick calculations yield:
- *       NR_TASKS <512> * (3 * PAGE_SIZE) = 0x600000
- * Subtract this from 0xc00000 and you get 0x927C0 of vm left
- * over to map SCSI dvma + floppy pseudo-dma buffers.  So be
- * careful if you change NR_TASKS or else there won't be enough
- * room for it all.
- */
-#define SUN4C_LOCK_VADDR	0xff000000
-#define SUN4C_LOCK_END		0xffc00000
-
 #define KADB_DEBUGGER_BEGVM	0xffc00000 /* Where kern debugger is in virt-mem */
 #define KADB_DEBUGGER_ENDVM	0xffd00000
 #define DEBUG_FIRSTVADDR	KADB_DEBUGGER_BEGVM
-- 
1.7.10


From: Peter Collingbourne <pcc@google.com>
Date: Tue, 18 Aug 2020 03:17:45 +0000
Subject: [PATCH] sparc: remove SA_STATIC_ALLOC macro definition
Message-Id: <20200818031745.393056-1-pcc@google.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This macro is not exposed to uapi and is unreferenced in the
kernel. The last reference to it was removed in commit 4c6773c3954c
("sparc32,leon: add support for extended interrupt controller"),
so remove the definition.

Signed-off-by: Peter Collingbourne <pcc@google.com>
---
View this change in Gerrit: https://linux-review.googlesource.com/q/I1db1466b27cf37f84e27379f595029d9eda59374

 arch/sparc/include/asm/signal.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/sparc/include/asm/signal.h b/arch/sparc/include/asm/signal.h
index 827b73a97f8a..28f81081e37d 100644
--- a/arch/sparc/include/asm/signal.h
+++ b/arch/sparc/include/asm/signal.h
@@ -9,18 +9,6 @@
 #include <uapi/asm/signal.h>
 
 #ifndef __ASSEMBLY__
-/*
- * DJHR
- * SA_STATIC_ALLOC is used for the sparc32 system to indicate that this
- * interrupt handler's irq structure should be statically allocated
- * by the request_irq routine.
- * The alternative is that arch/sparc/kernel/irq.c has carnal knowledge
- * of interrupt usage and that sucks. Also without a flag like this
- * it may be possible for the free_irq routine to attempt to free
- * statically allocated data.. which is NOT GOOD.
- *
- */
-#define SA_STATIC_ALLOC         0x8000
 
 #define __ARCH_HAS_KA_RESTORER
 #define __ARCH_HAS_SA_RESTORER
-- 
2.28.0.220.ged08abb693-goog

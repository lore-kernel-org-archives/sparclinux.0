From: Jaswinder Singh Rajput <jaswinder@kernel.org>
Date: Thu, 13 Aug 2009 08:50:36 +0000
Subject: [RFC][PATCH] SPARC: fix duplicate declaration
Message-Id: <1250153387.6116.20.camel@ht.satnam>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Only difference for 32 and 64 bit version is dma64_addr_t and rest is same.

Also fixed the following 'make includecheck' warning:

  arch/sparc/include/asm/types.h: asm-generic/int-ll64.h is included more than once.

Signed-off-by: Jaswinder Singh Rajput <jaswinderrajput@gmail.com>
---
 arch/sparc/include/asm/types.h |   27 +++++++--------------------
 1 files changed, 7 insertions(+), 20 deletions(-)

diff --git a/arch/sparc/include/asm/types.h b/arch/sparc/include/asm/types.h
index de671d7..09c79a9 100644
--- a/arch/sparc/include/asm/types.h
+++ b/arch/sparc/include/asm/types.h
@@ -8,9 +8,8 @@
  * need to be careful to avoid a name clashes.
  */
 
-#if defined(__sparc__) && defined(__arch64__)
+#if defined(__sparc__)
 
-/*** SPARC 64 bit ***/
 #include <asm-generic/int-ll64.h>
 
 #ifndef __ASSEMBLY__
@@ -26,33 +25,21 @@ typedef unsigned short umode_t;
 /* Dma addresses come in generic and 64-bit flavours.  */
 
 typedef u32 dma_addr_t;
-typedef u64 dma64_addr_t;
 
-#endif /* __ASSEMBLY__ */
+#if defined(__arch64__)
 
-#endif /* __KERNEL__ */
+/*** SPARC 64 bit ***/
+typedef u64 dma64_addr_t;
 #else
-
 /*** SPARC 32 bit ***/
-#include <asm-generic/int-ll64.h>
-
-#ifndef __ASSEMBLY__
-
-typedef unsigned short umode_t;
-
-#endif /* __ASSEMBLY__ */
-
-#ifdef __KERNEL__
-
-#ifndef __ASSEMBLY__
-
-typedef u32 dma_addr_t;
 typedef u32 dma64_addr_t;
 
+#endif /* defined(__arch64__) */
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __KERNEL__ */
 
-#endif /* defined(__sparc__) && defined(__arch64__) */
+#endif /* defined(__sparc__) */
 
 #endif /* defined(_SPARC_TYPES_H) */
-- 
1.6.0.6




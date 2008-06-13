From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 13 Jun 2008 19:57:20 +0000
Subject: [PATCH] sparc: Merge asm-sparc{,64}/types.h
Message-Id: <1213387042-9711-19-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Copy content of sparc64 file to sparc file.
There is only minimal possibilities for further unification.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 include/asm-sparc/types.h   |   32 +++++++++++++++++++++++++++++++-
 include/asm-sparc64/types.h |   35 +----------------------------------
 2 files changed, 32 insertions(+), 35 deletions(-)

diff --git a/include/asm-sparc/types.h b/include/asm-sparc/types.h
index 07734f9..8c28fde 100644
--- a/include/asm-sparc/types.h
+++ b/include/asm-sparc/types.h
@@ -1,6 +1,5 @@
 #ifndef _SPARC_TYPES_H
 #define _SPARC_TYPES_H
-
 /*
  * This file is never included by application software unless
  * explicitly requested (e.g., via linux/types.h) in which case the
@@ -8,6 +7,35 @@
  * not a major issue.  However, for interoperability, libraries still
  * need to be careful to avoid a name clashes.
  */
+
+#if defined(__sparc__) && defined(__arch64__)
+
+/*** SPARC 64 bit ***/
+#include <asm-generic/int-l64.h>
+
+#ifndef __ASSEMBLY__
+
+typedef unsigned short umode_t;
+
+#endif /* __ASSEMBLY__ */
+
+#ifdef __KERNEL__
+
+#define BITS_PER_LONG 64
+
+#ifndef __ASSEMBLY__
+
+/* Dma addresses come in generic and 64-bit flavours.  */
+
+typedef u32 dma_addr_t;
+typedef u64 dma64_addr_t;
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* __KERNEL__ */
+#else
+
+/*** SPARC 32 bit ***/
 #include <asm-generic/int-ll64.h>
 
 #ifndef __ASSEMBLY__
@@ -29,4 +57,6 @@ typedef u32 dma64_addr_t;
 
 #endif /* __KERNEL__ */
 
+#endif /* defined(__sparc__) && defined(__arch64__) */
+
 #endif /* defined(_SPARC_TYPES_H) */
diff --git a/include/asm-sparc64/types.h b/include/asm-sparc64/types.h
index b27ccc8..cfbfad5 100644
--- a/include/asm-sparc64/types.h
+++ b/include/asm-sparc64/types.h
@@ -1,34 +1 @@
-#ifndef _SPARC64_TYPES_H
-#define _SPARC64_TYPES_H
-
-/*
- * This file is never included by application software unless
- * explicitly requested (e.g., via linux/types.h) in which case the
- * application is Linux specific so (user-) name space pollution is
- * not a major issue.  However, for interoperability, libraries still
- * need to be careful to avoid a name clashes.
- */
-#include <asm-generic/int-l64.h>
-
-#ifndef __ASSEMBLY__
-
-typedef unsigned short umode_t;
-
-#endif /* __ASSEMBLY__ */
-
-#ifdef __KERNEL__
-
-#define BITS_PER_LONG 64
-
-#ifndef __ASSEMBLY__
-
-/* Dma addresses come in generic and 64-bit flavours.  */
-
-typedef u32 dma_addr_t;
-typedef u64 dma64_addr_t;
-
-#endif /* __ASSEMBLY__ */
-
-#endif /* __KERNEL__ */
-
-#endif /* defined(_SPARC64_TYPES_H) */
+#include <asm-sparc/types.h>
-- 
1.5.4.1.143.ge7e51


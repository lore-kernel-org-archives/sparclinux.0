From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 06 Jun 2008 21:00:27 +0000
Subject: [PATCH 15/21] sparc: Merge asm-sparc{,64}/resource.h
Message-Id: <1212786033-4227-15-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

RLIM_INFINITY differ from 32 and 64 bit.
The rest is equal.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 include/asm-sparc/resource.h   |    4 ++++
 include/asm-sparc64/resource.h |   20 +-------------------
 2 files changed, 5 insertions(+), 19 deletions(-)

diff --git a/include/asm-sparc/resource.h b/include/asm-sparc/resource.h
index 985948a..97fbac7 100644
--- a/include/asm-sparc/resource.h
+++ b/include/asm-sparc/resource.h
@@ -14,12 +14,16 @@
 #define RLIMIT_NOFILE		6	/* max number of open files */
 #define RLIMIT_NPROC		7	/* max number of processes */
 
+#if defined(__sparc__) && defined(__arch64__)
+/* Use generic version */
+#else
 /*
  * SuS says limits have to be unsigned.
  * We make this unsigned, but keep the
  * old value for compatibility:
  */
 #define RLIM_INFINITY		0x7fffffff
+#endif
 
 #include <asm-generic/resource.h>
 
diff --git a/include/asm-sparc64/resource.h b/include/asm-sparc64/resource.h
index 4f08fb5..46e3bc0 100644
--- a/include/asm-sparc64/resource.h
+++ b/include/asm-sparc64/resource.h
@@ -1,19 +1 @@
-/*
- * resource.h: Resource definitions.
- *
- * Copyright (C) 1996 David S. Miller (davem@caip.rutgers.edu)
- */
-
-#ifndef _SPARC64_RESOURCE_H
-#define _SPARC64_RESOURCE_H
-
-/*
- * These two resource limit IDs have a Sparc/Linux-specific ordering,
- * the rest comes from the generic header:
- */
-#define RLIMIT_NOFILE		6	/* max number of open files */
-#define RLIMIT_NPROC		7	/* max number of processes */
-
-#include <asm-generic/resource.h>
-
-#endif /* !(_SPARC64_RESOURCE_H) */
+#include <asm-sparc/resource.h>
-- 
1.5.4.1.143.ge7e51


From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 28 Jun 2008 22:04:48 +0000
Subject: [PATCH 16/25] sparc: Merge asm-sparc{,64}/setup.h
Message-Id: <1214690697-4631-16-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

COMMAND_LINE_SIZE differ for 32 and 64 bit.
256 versus 2048

:$ diff -u include/asm-sparc/setup.h include/asm-sparc64/setup.h
:-- include/asm-sparc/setup.h	2008-06-13 06:42:07.000000000 +0200
:++ include/asm-sparc64/setup.h	2008-06-13 06:42:07.000000000 +0200
:@@ -2,9 +2,9 @@
:  *	Just a place holder.
:  */
:
:-#ifndef _SPARC_SETUP_H
:-#define _SPARC_SETUP_H
:+#ifndef _SPARC64_SETUP_H
:+#define _SPARC64_SETUP_H
:
:-#define COMMAND_LINE_SIZE	256
:+#define COMMAND_LINE_SIZE	2048
:
:-#endif /* _SPARC_SETUP_H */
:+#endif /* _SPARC64_SETUP_H */

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 include/asm-sparc/setup.h   |    6 +++++-
 include/asm-sparc64/setup.h |   11 +----------
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/include/asm-sparc/setup.h b/include/asm-sparc/setup.h
index b3af958..2643c62 100644
--- a/include/asm-sparc/setup.h
+++ b/include/asm-sparc/setup.h
@@ -5,6 +5,10 @@
 #ifndef _SPARC_SETUP_H
 #define _SPARC_SETUP_H
 
-#define COMMAND_LINE_SIZE	256
+#if defined(__sparc__) && defined(__arch64__)
+# define COMMAND_LINE_SIZE 2048
+#else
+# define COMMAND_LINE_SIZE 256
+#endif
 
 #endif /* _SPARC_SETUP_H */
diff --git a/include/asm-sparc64/setup.h b/include/asm-sparc64/setup.h
index 5053df3..7143d06 100644
--- a/include/asm-sparc64/setup.h
+++ b/include/asm-sparc64/setup.h
@@ -1,10 +1 @@
-/*
- *	Just a place holder. 
- */
-
-#ifndef _SPARC64_SETUP_H
-#define _SPARC64_SETUP_H
-
-#define COMMAND_LINE_SIZE	2048
-
-#endif /* _SPARC64_SETUP_H */
+#include <asm-sparc/setup.h>
-- 
1.5.4.1.143.ge7e51


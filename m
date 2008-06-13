From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 13 Jun 2008 19:57:05 +0000
Subject: [PATCH] sparc: Merge asm-sparc{,64}/param.h
Message-Id: <1213387042-9711-4-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

$ diff -u include/asm-sparc/param.h include/asm-sparc64/param.h
-- include/asm-sparc/param.h	2008-06-13 06:46:39.000000000 +0200
++ include/asm-sparc64/param.h	2008-06-13 06:42:07.000000000 +0200
@@ -1,5 +1,6 @@
-#ifndef _ASMSPARC_PARAM_H
-#define _ASMSPARC_PARAM_H
+#ifndef _ASMSPARC64_PARAM_H
+#define _ASMSPARC64_PARAM_H
+

 #ifdef __KERNEL__
 # define HZ		CONFIG_HZ	/* Internal kernel timer frequency */
@@ -19,4 +20,4 @@

 #define MAXHOSTNAMELEN	64	/* max length of hostname */

-#endif
+#endif /* _ASMSPARC64_PARAM_H */

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 include/asm-sparc64/param.h |   24 +-----------------------
 1 files changed, 1 insertions(+), 23 deletions(-)

diff --git a/include/asm-sparc64/param.h b/include/asm-sparc64/param.h
index f0125cf..40c6dc1 100644
--- a/include/asm-sparc64/param.h
+++ b/include/asm-sparc64/param.h
@@ -1,23 +1 @@
-#ifndef _ASMSPARC64_PARAM_H
-#define _ASMSPARC64_PARAM_H
-
-
-#ifdef __KERNEL__
-# define HZ		CONFIG_HZ	/* Internal kernel timer frequency */
-# define USER_HZ	100	/* .. some user interfaces are in "ticks" */
-# define CLOCKS_PER_SEC (USER_HZ)
-#endif
-
-#ifndef HZ
-#define HZ 100
-#endif
-
-#define EXEC_PAGESIZE	8192    /* Thanks for sun4's we carry baggage... */
-
-#ifndef NOGROUP
-#define NOGROUP		(-1)
-#endif
-
-#define MAXHOSTNAMELEN	64	/* max length of hostname */
-
-#endif /* _ASMSPARC64_PARAM_H */
+#include <asm-sparc/param.h>
-- 
1.5.4.1.143.ge7e51


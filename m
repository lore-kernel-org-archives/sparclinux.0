From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 13 Jun 2008 19:57:08 +0000
Subject: [PATCH] sparc: Merge asm-sparc{,64}/sockios.h
Message-Id: <1213387042-9711-7-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1213387042-9711-6-git-send-email-sam@ravnborg.org>
In-Reply-To: <1213387042-9711-6-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

$ diff -u include/asm-sparc/sockios.h include/asm-sparc64/sockios.h
-- include/asm-sparc/sockios.h	2008-06-13 06:42:07.000000000 +0200
++ include/asm-sparc64/sockios.h	2008-06-13 06:42:07.000000000 +0200
@@ -1,5 +1,5 @@
-#ifndef _ASM_SPARC_SOCKIOS_H
-#define _ASM_SPARC_SOCKIOS_H
+#ifndef _ASM_SPARC64_SOCKIOS_H
+#define _ASM_SPARC64_SOCKIOS_H

 /* Socket-level I/O control calls. */
 #define FIOSETOWN 	0x8901
@@ -10,5 +10,5 @@
 #define SIOCGSTAMP	0x8906		/* Get stamp (timeval) */
 #define SIOCGSTAMPNS	0x8907		/* Get stamp (timespec) */

-#endif /* !(_ASM_SPARC_SOCKIOS_H) */
+#endif /* !(_ASM_SPARC64_SOCKIOS_H) */

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 include/asm-sparc64/sockios.h |   15 +--------------
 1 files changed, 1 insertions(+), 14 deletions(-)

diff --git a/include/asm-sparc64/sockios.h b/include/asm-sparc64/sockios.h
index c7d9900..2cb4b64 100644
--- a/include/asm-sparc64/sockios.h
+++ b/include/asm-sparc64/sockios.h
@@ -1,14 +1 @@
-#ifndef _ASM_SPARC64_SOCKIOS_H
-#define _ASM_SPARC64_SOCKIOS_H
-
-/* Socket-level I/O control calls. */
-#define FIOSETOWN 	0x8901
-#define SIOCSPGRP	0x8902
-#define FIOGETOWN	0x8903
-#define SIOCGPGRP	0x8904
-#define SIOCATMARK	0x8905
-#define SIOCGSTAMP	0x8906		/* Get stamp (timeval) */
-#define SIOCGSTAMPNS	0x8907		/* Get stamp (timespec) */
-
-#endif /* !(_ASM_SPARC64_SOCKIOS_H) */
-
+#include <asm-sparc/sockios.h>
-- 
1.5.4.1.143.ge7e51


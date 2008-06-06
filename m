From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 06 Jun 2008 21:00:19 +0000
Subject: [PATCH 07/21] sparc: Merge asm-sparc{,64}/sockios.h
Message-Id: <1212786033-4227-7-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

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


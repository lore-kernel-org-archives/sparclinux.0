From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 31 Mar 2013 17:01:47 +0000
Subject: [PATCH v2] sparc: use asm-generic version of types.h
Message-Id: <20130331170147.GA5049@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v2] sparc: use asm-generic version of types.h

In sparc headers we use the following pattern:

    #if defined(__sparc__) && defined(__arch64__)

    sparc64 specific stuff

    #else

    sparc32 specific stuff

    #endif

In types.h this pattern was not followed and here
we only checked for __sparc__ for no good reason.
It was a left-over from long time ago.

I checked other architectures - and most of them
do not have any such checks. And all the recently
merged versions uses the asm-generic version.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---

v2: Updated changelog.
- Dropped note that this fixes buid issue in samples/
  as this is really un-related.
- Added description why we can use the generic version

	Sam

 arch/sparc/include/asm/Kbuild       |    1 +
 arch/sparc/include/uapi/asm/Kbuild  |    1 -
 arch/sparc/include/uapi/asm/types.h |   17 -----------------
 3 files changed, 1 insertions(+), 18 deletions(-)
 delete mode 100644 arch/sparc/include/uapi/asm/types.h

diff --git a/arch/sparc/include/asm/Kbuild b/arch/sparc/include/asm/Kbuild
index f73884b..ff18e3c 100644
--- a/arch/sparc/include/asm/Kbuild
+++ b/arch/sparc/include/asm/Kbuild
@@ -13,4 +13,5 @@ generic-y += local.h
 generic-y += module.h
 generic-y += serial.h
 generic-y += trace_clock.h
+generic-y += types.h
 generic-y += word-at-a-time.h
diff --git a/arch/sparc/include/uapi/asm/Kbuild b/arch/sparc/include/uapi/asm/Kbuild
index ce175af..b5843ee 100644
--- a/arch/sparc/include/uapi/asm/Kbuild
+++ b/arch/sparc/include/uapi/asm/Kbuild
@@ -44,7 +44,6 @@ header-y += swab.h
 header-y += termbits.h
 header-y += termios.h
 header-y += traps.h
-header-y += types.h
 header-y += uctx.h
 header-y += unistd.h
 header-y += utrap.h
diff --git a/arch/sparc/include/uapi/asm/types.h b/arch/sparc/include/uapi/asm/types.h
deleted file mode 100644
index 383d156..0000000
--- a/arch/sparc/include/uapi/asm/types.h
+++ /dev/null
@@ -1,17 +0,0 @@
-#ifndef _SPARC_TYPES_H
-#define _SPARC_TYPES_H
-/*
- * This file is never included by application software unless
- * explicitly requested (e.g., via linux/types.h) in which case the
- * application is Linux specific so (user-) name space pollution is
- * not a major issue.  However, for interoperability, libraries still
- * need to be careful to avoid a name clashes.
- */
-
-#if defined(__sparc__)
-
-#include <asm-generic/int-ll64.h>
-
-#endif /* defined(__sparc__) */
-
-#endif /* defined(_SPARC_TYPES_H) */
-- 
1.6.0.6


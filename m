From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 29 Dec 2011 14:16:12 +0000
Subject: [PATCH 2/2] sparc32: fix PAGE_SIZE definition
Message-Id: <20111229141612.GB3146@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From 1076481b278bd14617a544cc20520cfd73f9b12c Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 29 Dec 2011 15:04:38 +0100
Subject: [PATCH 2/2] sparc32: fix PAGE_SIZE definition

Use _AC() in definition of PAGE_SIZE so the same definition
can be used in C and assembler.
Also use PAGE_SIZE in definition of THREAD_SIZE.

This commit kill the following comment:

    "I have my suspicions... -DaveM"

I did not find any clue what this referred to anyway.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/page_32.h        |   10 +++-------
 arch/sparc/include/asm/thread_info_32.h |    2 +-
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/sparc/include/asm/page_32.h b/arch/sparc/include/asm/page_32.h
index 156707b..bb5c2ac 100644
--- a/arch/sparc/include/asm/page_32.h
+++ b/arch/sparc/include/asm/page_32.h
@@ -8,14 +8,10 @@
 #ifndef _SPARC_PAGE_H
 #define _SPARC_PAGE_H
 
-#define PAGE_SHIFT   12
+#include <linux/const.h>
 
-#ifndef __ASSEMBLY__
-/* I have my suspicions... -DaveM */
-#define PAGE_SIZE    (1UL << PAGE_SHIFT)
-#else
-#define PAGE_SIZE    (1 << PAGE_SHIFT)
-#endif
+#define PAGE_SHIFT   12
+#define PAGE_SIZE    (_AC(1, UL) << PAGE_SHIFT)
 #define PAGE_MASK    (~(PAGE_SIZE-1))
 
 #include <asm/btfixup.h>
diff --git a/arch/sparc/include/asm/thread_info_32.h b/arch/sparc/include/asm/thread_info_32.h
index fa57532..e418690 100644
--- a/arch/sparc/include/asm/thread_info_32.h
+++ b/arch/sparc/include/asm/thread_info_32.h
@@ -95,7 +95,7 @@ BTFIXUPDEF_CALL(void, free_thread_info, struct thread_info *)
  * Observe the order of get_free_pages() in alloc_thread_info_node().
  * The sun4 has 8K stack too, because it's short on memory, and 16K is a waste.
  */
-#define THREAD_SIZE		8192
+#define THREAD_SIZE		(2 * PAGE_SIZE)
 
 /*
  * Offsets in thread_info structure, used in assembly code
-- 
1.6.0.6


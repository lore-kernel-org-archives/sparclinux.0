From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 21 Apr 2014 19:39:16 +0000
Subject: [PATCH 01/29] sparc32: rename mm/srmmu.h to mm/mm_32.h
Message-Id: <1398109184-3283-1-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This file will be used for more than just srmmu stuff, so the old name was misleading.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/mm/leon_mm.c | 2 +-
 arch/sparc/mm/mm_32.h   | 4 ++++
 arch/sparc/mm/srmmu.c   | 2 +-
 arch/sparc/mm/srmmu.h   | 4 ----
 4 files changed, 6 insertions(+), 6 deletions(-)
 create mode 100644 arch/sparc/mm/mm_32.h
 delete mode 100644 arch/sparc/mm/srmmu.h

diff --git a/arch/sparc/mm/leon_mm.c b/arch/sparc/mm/leon_mm.c
index 5bed085..649cad6 100644
--- a/arch/sparc/mm/leon_mm.c
+++ b/arch/sparc/mm/leon_mm.c
@@ -15,7 +15,7 @@
 #include <asm/leon.h>
 #include <asm/tlbflush.h>
 
-#include "srmmu.h"
+#include "mm_32.h"
 
 int leon_flush_during_switch = 1;
 int srmmu_swprobe_trace;
diff --git a/arch/sparc/mm/mm_32.h b/arch/sparc/mm/mm_32.h
new file mode 100644
index 0000000..5703274
--- /dev/null
+++ b/arch/sparc/mm/mm_32.h
@@ -0,0 +1,4 @@
+/* srmmu.c */
+extern char *srmmu_name;
+
+extern void (*poke_srmmu)(void);
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index cfbe53c..ed0b0b6a 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -49,7 +49,7 @@
 #include <asm/mxcc.h>
 #include <asm/ross.h>
 
-#include "srmmu.h"
+#include "mm_32.h"
 
 enum mbus_module srmmu_modtype;
 static unsigned int hwbug_bitmask;
diff --git a/arch/sparc/mm/srmmu.h b/arch/sparc/mm/srmmu.h
deleted file mode 100644
index 5703274..0000000
--- a/arch/sparc/mm/srmmu.h
+++ /dev/null
@@ -1,4 +0,0 @@
-/* srmmu.c */
-extern char *srmmu_name;
-
-extern void (*poke_srmmu)(void);
-- 
1.8.3.1


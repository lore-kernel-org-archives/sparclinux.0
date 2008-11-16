From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 16 Nov 2008 20:18:21 +0000
Subject: [PATCH 5/8] sparc64: unify math-emu
Message-Id: <1226866704-6485-5-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Move relavent files to sparc/math-emu and
adjust path/include accordingly.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 .../math-emu/math.c => sparc/math-emu/math_64.c}   |    2 +-
 .../sfp-util.h => sparc/math-emu/sfp-util_64.h}    |    0
 arch/sparc64/Makefile                              |    2 +-
 arch/sparc64/math-emu/Makefile                     |    7 -------
 4 files changed, 2 insertions(+), 9 deletions(-)
 rename arch/{sparc64/math-emu/math.c => sparc/math-emu/math_64.c} (99%)
 rename arch/{sparc64/math-emu/sfp-util.h => sparc/math-emu/sfp-util_64.h} (100%)
 delete mode 100644 arch/sparc64/math-emu/Makefile

diff --git a/arch/sparc64/math-emu/math.c b/arch/sparc/math-emu/math_64.c
similarity index 99%
rename from arch/sparc64/math-emu/math.c
rename to arch/sparc/math-emu/math_64.c
index add053e..6863c9b 100644
--- a/arch/sparc64/math-emu/math.c
+++ b/arch/sparc/math-emu/math_64.c
@@ -16,7 +16,7 @@
 #include <asm/ptrace.h>
 #include <asm/uaccess.h>
 
-#include "sfp-util.h"
+#include "sfp-util_64.h"
 #include <math-emu/soft-fp.h>
 #include <math-emu/single.h>
 #include <math-emu/double.h>
diff --git a/arch/sparc64/math-emu/sfp-util.h b/arch/sparc/math-emu/sfp-util_64.h
similarity index 100%
rename from arch/sparc64/math-emu/sfp-util.h
rename to arch/sparc/math-emu/sfp-util_64.h
diff --git a/arch/sparc64/Makefile b/arch/sparc64/Makefile
index 51bc33a..e9f98ec 100644
--- a/arch/sparc64/Makefile
+++ b/arch/sparc64/Makefile
@@ -28,7 +28,7 @@ endif
 head-y := arch/sparc64/kernel/head.o arch/sparc64/kernel/init_task.o
 
 core-y				+= arch/sparc64/kernel/ arch/sparc64/mm/
-core-y				+= arch/sparc64/math-emu/
+core-y				+= arch/sparc/math-emu/
 libs-y				+= arch/sparc64/prom/ arch/sparc64/lib/
 drivers-$(CONFIG_OPROFILE)	+= arch/sparc64/oprofile/
 
diff --git a/arch/sparc64/math-emu/Makefile b/arch/sparc64/math-emu/Makefile
deleted file mode 100644
index cc5cb9b..0000000
--- a/arch/sparc64/math-emu/Makefile
+++ /dev/null
@@ -1,7 +0,0 @@
-#
-# Makefile for the FPU instruction emulation.
-#
-
-obj-y    := math.o
-
-EXTRA_CFLAGS = -Iinclude/math-emu -w
-- 
1.5.6.GIT


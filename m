From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 16 Nov 2008 20:18:20 +0000
Subject: [PATCH 4/8] sparc: prepare math-emu for unification
Message-Id: <1226866704-6485-4-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Add _32 to filenames to make them 32 bit unique

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/math-emu/Makefile                      |    2 +-
 arch/sparc/math-emu/{math.c => math_32.c}         |    2 +-
 arch/sparc/math-emu/{sfp-util.h => sfp-util_32.h} |    0
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename arch/sparc/math-emu/{math.c => math_32.c} (99%)
 rename arch/sparc/math-emu/{sfp-util.h => sfp-util_32.h} (100%)

diff --git a/arch/sparc/math-emu/Makefile b/arch/sparc/math-emu/Makefile
index 86995d6..b9085ec 100644
--- a/arch/sparc/math-emu/Makefile
+++ b/arch/sparc/math-emu/Makefile
@@ -5,4 +5,4 @@
 # supress all warnings - as math.c produces a lot!
 ccflags-y := -w
 
-obj-y    := math.o
+obj-y    := math_$(BITS).o
diff --git a/arch/sparc/math-emu/math.c b/arch/sparc/math-emu/math_32.c
similarity index 99%
rename from arch/sparc/math-emu/math.c
rename to arch/sparc/math-emu/math_32.c
index 8613b3e..e13f65d 100644
--- a/arch/sparc/math-emu/math.c
+++ b/arch/sparc/math-emu/math_32.c
@@ -69,7 +69,7 @@
 #include <linux/mm.h>
 #include <asm/uaccess.h>
 
-#include "sfp-util.h"
+#include "sfp-util_32.h"
 #include <math-emu/soft-fp.h>
 #include <math-emu/single.h>
 #include <math-emu/double.h>
diff --git a/arch/sparc/math-emu/sfp-util.h b/arch/sparc/math-emu/sfp-util_32.h
similarity index 100%
rename from arch/sparc/math-emu/sfp-util.h
rename to arch/sparc/math-emu/sfp-util_32.h
-- 
1.5.6.GIT


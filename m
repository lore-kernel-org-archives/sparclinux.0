From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 16 Nov 2008 20:18:22 +0000
Subject: [PATCH 6/8] sparc64: unify arch/sparc64/oprofile/
Message-Id: <1226866704-6485-6-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

A simple:

   diff arch/sparc64/oprofile/init.c arch/sparc/oprofile/init.c
   diff arch/sparc64/oprofile/Makefile arch/sparc/oprofile/Makefile

revealed that the directories were equal.
So let sparc64 point to the sparc version and drop the sparc64 oprofile dir

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc64/Makefile          |    2 +-
 arch/sparc64/oprofile/Makefile |    9 ---------
 arch/sparc64/oprofile/init.c   |   23 -----------------------
 3 files changed, 1 insertions(+), 33 deletions(-)
 delete mode 100644 arch/sparc64/oprofile/Makefile
 delete mode 100644 arch/sparc64/oprofile/init.c

diff --git a/arch/sparc64/Makefile b/arch/sparc64/Makefile
index e9f98ec..3dbda40 100644
--- a/arch/sparc64/Makefile
+++ b/arch/sparc64/Makefile
@@ -30,7 +30,7 @@ head-y := arch/sparc64/kernel/head.o arch/sparc64/kernel/init_task.o
 core-y				+= arch/sparc64/kernel/ arch/sparc64/mm/
 core-y				+= arch/sparc/math-emu/
 libs-y				+= arch/sparc64/prom/ arch/sparc64/lib/
-drivers-$(CONFIG_OPROFILE)	+= arch/sparc64/oprofile/
+drivers-$(CONFIG_OPROFILE)	+= arch/sparc/oprofile/
 
 boot := arch/sparc64/boot
 
diff --git a/arch/sparc64/oprofile/Makefile b/arch/sparc64/oprofile/Makefile
deleted file mode 100644
index e9feca1..0000000
--- a/arch/sparc64/oprofile/Makefile
+++ /dev/null
@@ -1,9 +0,0 @@
-obj-$(CONFIG_OPROFILE) += oprofile.o
-
-DRIVER_OBJS = $(addprefix ../../../drivers/oprofile/, \
-		oprof.o cpu_buffer.o buffer_sync.o \
-		event_buffer.o oprofile_files.o \
-		oprofilefs.o oprofile_stats.o \
-		timer_int.o )
-
-oprofile-y				:= $(DRIVER_OBJS) init.o
diff --git a/arch/sparc64/oprofile/init.c b/arch/sparc64/oprofile/init.c
deleted file mode 100644
index 17bb603..0000000
--- a/arch/sparc64/oprofile/init.c
+++ /dev/null
@@ -1,23 +0,0 @@
-/**
- * @file init.c
- *
- * @remark Copyright 2002 OProfile authors
- * @remark Read the file COPYING
- *
- * @author John Levon <levon@movementarian.org>
- */
-
-#include <linux/kernel.h>
-#include <linux/oprofile.h>
-#include <linux/errno.h>
-#include <linux/init.h>
- 
-int __init oprofile_arch_init(struct oprofile_operations *ops)
-{
-	return -ENODEV;
-}
-
-
-void oprofile_arch_exit(void)
-{
-}
-- 
1.5.6.GIT


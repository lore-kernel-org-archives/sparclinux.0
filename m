From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 17 Nov 2008 22:06:01 +0000
Subject: [PATCH 2/6] sparc,sparc64: unify prom/
Message-Id: <1226959565-14796-2-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

- all files with identical names copied and renamed to *_64.c
- the remaning files copied as is
- added sparc64 specific files to sparc/prom/Makefile
- teach sparc64 Makefile to look into sparc/prom/
- delete unused Makefile from sparc64/prom/

linking order was not kept for sparc64 with this change.
It was not possible to keep linking order for both sparc and sparc64
and as sparc64 see more testing than sparc it was natural to
break linking order on sparc64. Should it have any effect it
would be detected sooner this way.

printf_32.c and printf_64.c are obvious candidates to be merged
but they are not 100% equal so that was left for later

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/prom/Makefile                           |    4 ++++
 .../prom/bootstr.c => sparc/prom/bootstr_64.c}     |    0
 arch/{sparc64 => sparc}/prom/cif.S                 |    0
 .../prom/console.c => sparc/prom/console_64.c}     |    0
 .../prom/devops.c => sparc/prom/devops_64.c}       |    0
 arch/{sparc64/prom/init.c => sparc/prom/init_64.c} |    0
 arch/{sparc64/prom/misc.c => sparc/prom/misc_64.c} |    0
 arch/{sparc64 => sparc}/prom/p1275.c               |    0
 .../prom/printf.c => sparc/prom/printf_64.c}       |    0
 arch/{sparc64/prom/tree.c => sparc/prom/tree_64.c} |    0
 arch/sparc64/Makefile                              |    2 +-
 arch/sparc64/prom/Makefile                         |    9 ---------
 12 files changed, 5 insertions(+), 10 deletions(-)
 rename arch/{sparc64/prom/bootstr.c => sparc/prom/bootstr_64.c} (100%)
 rename arch/{sparc64 => sparc}/prom/cif.S (100%)
 rename arch/{sparc64/prom/console.c => sparc/prom/console_64.c} (100%)
 rename arch/{sparc64/prom/devops.c => sparc/prom/devops_64.c} (100%)
 rename arch/{sparc64/prom/init.c => sparc/prom/init_64.c} (100%)
 rename arch/{sparc64/prom/misc.c => sparc/prom/misc_64.c} (100%)
 rename arch/{sparc64 => sparc}/prom/p1275.c (100%)
 rename arch/{sparc64/prom/printf.c => sparc/prom/printf_64.c} (100%)
 rename arch/{sparc64/prom/tree.c => sparc/prom/tree_64.c} (100%)
 delete mode 100644 arch/sparc64/prom/Makefile

diff --git a/arch/sparc/prom/Makefile b/arch/sparc/prom/Makefile
index 74ca9cc..f8e0278 100644
--- a/arch/sparc/prom/Makefile
+++ b/arch/sparc/prom/Makefile
@@ -1,6 +1,8 @@
 # Makefile for the Sun Boot PROM interface library under
 # Linux.
 #
+asflags := -ansi
+ccflags := -Werror
 
 lib-y                 := bootstr_$(BITS).o
 lib-$(CONFIG_SPARC32) += devmap.o
@@ -15,3 +17,5 @@ lib-$(CONFIG_SPARC32) += segment.o
 lib-y                 += console_$(BITS).o
 lib-y                 += printf_$(BITS).o
 lib-y                 += tree_$(BITS).o
+lib-$(CONFIG_SPARC64) += p1275.o
+lib-$(CONFIG_SPARC64) += cif.o
diff --git a/arch/sparc64/prom/bootstr.c b/arch/sparc/prom/bootstr_64.c
similarity index 100%
rename from arch/sparc64/prom/bootstr.c
rename to arch/sparc/prom/bootstr_64.c
diff --git a/arch/sparc64/prom/cif.S b/arch/sparc/prom/cif.S
similarity index 100%
rename from arch/sparc64/prom/cif.S
rename to arch/sparc/prom/cif.S
diff --git a/arch/sparc64/prom/console.c b/arch/sparc/prom/console_64.c
similarity index 100%
rename from arch/sparc64/prom/console.c
rename to arch/sparc/prom/console_64.c
diff --git a/arch/sparc64/prom/devops.c b/arch/sparc/prom/devops_64.c
similarity index 100%
rename from arch/sparc64/prom/devops.c
rename to arch/sparc/prom/devops_64.c
diff --git a/arch/sparc64/prom/init.c b/arch/sparc/prom/init_64.c
similarity index 100%
rename from arch/sparc64/prom/init.c
rename to arch/sparc/prom/init_64.c
diff --git a/arch/sparc64/prom/misc.c b/arch/sparc/prom/misc_64.c
similarity index 100%
rename from arch/sparc64/prom/misc.c
rename to arch/sparc/prom/misc_64.c
diff --git a/arch/sparc64/prom/p1275.c b/arch/sparc/prom/p1275.c
similarity index 100%
rename from arch/sparc64/prom/p1275.c
rename to arch/sparc/prom/p1275.c
diff --git a/arch/sparc64/prom/printf.c b/arch/sparc/prom/printf_64.c
similarity index 100%
rename from arch/sparc64/prom/printf.c
rename to arch/sparc/prom/printf_64.c
diff --git a/arch/sparc64/prom/tree.c b/arch/sparc/prom/tree_64.c
similarity index 100%
rename from arch/sparc64/prom/tree.c
rename to arch/sparc/prom/tree_64.c
diff --git a/arch/sparc64/Makefile b/arch/sparc64/Makefile
index bfe0868..33d7302 100644
--- a/arch/sparc64/Makefile
+++ b/arch/sparc64/Makefile
@@ -29,7 +29,7 @@ head-y := arch/sparc64/kernel/head.o arch/sparc64/kernel/init_task.o
 
 core-y				+= arch/sparc64/kernel/ arch/sparc/mm/
 core-y				+= arch/sparc/math-emu/
-libs-y				+= arch/sparc64/prom/ arch/sparc64/lib/
+libs-y				+= arch/sparc/prom/ arch/sparc64/lib/
 drivers-$(CONFIG_OPROFILE)	+= arch/sparc/oprofile/
 
 boot := arch/sparc64/boot
diff --git a/arch/sparc64/prom/Makefile b/arch/sparc64/prom/Makefile
deleted file mode 100644
index 8c94483..0000000
--- a/arch/sparc64/prom/Makefile
+++ /dev/null
@@ -1,9 +0,0 @@
-# Makefile for the Sun Boot PROM interface library under
-# Linux.
-#
-
-EXTRA_AFLAGS := -ansi
-EXTRA_CFLAGS := -Werror
-
-lib-y   := bootstr.o devops.o init.o misc.o \
-	   tree.o console.o printf.o p1275.o cif.o
-- 
1.5.6.GIT


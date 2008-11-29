From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 29 Nov 2008 22:05:53 +0000
Subject: [PATCH 09/10] sparc: prepare prom/ for unification
Message-Id: <1227996354-11478-9-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

- rename files where sparc64 uses identical names to *_32.c
- refactor Makefile (but keep linking order)

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/prom/Makefile                    |   23 +++++++++++++++++------
 arch/sparc/prom/{bootstr.c => bootstr_32.c} |    0
 arch/sparc/prom/{console.c => console_32.c} |    0
 arch/sparc/prom/{devops.c => devops_32.c}   |    0
 arch/sparc/prom/{init.c => init_32.c}       |    0
 arch/sparc/prom/{misc.c => misc_32.c}       |    0
 arch/sparc/prom/{printf.c => printf_32.c}   |    0
 arch/sparc/prom/{tree.c => tree_32.c}       |    0
 8 files changed, 17 insertions(+), 6 deletions(-)
 rewrite arch/sparc/prom/Makefile (64%)
 rename arch/sparc/prom/{bootstr.c => bootstr_32.c} (100%)
 rename arch/sparc/prom/{console.c => console_32.c} (100%)
 rename arch/sparc/prom/{devops.c => devops_32.c} (100%)
 rename arch/sparc/prom/{init.c => init_32.c} (100%)
 rename arch/sparc/prom/{misc.c => misc_32.c} (100%)
 rename arch/sparc/prom/{printf.c => printf_32.c} (100%)
 rename arch/sparc/prom/{tree.c => tree_32.c} (100%)

diff --git a/arch/sparc/prom/Makefile b/arch/sparc/prom/Makefile
dissimilarity index 64%
index 8f7e185..74ca9cc 100644
--- a/arch/sparc/prom/Makefile
+++ b/arch/sparc/prom/Makefile
@@ -1,6 +1,17 @@
-# Makefile for the Sun Boot PROM interface library under
-# Linux.
-#
-
-lib-y := bootstr.o devmap.o devops.o init.o memory.o misc.o mp.o \
-	 palloc.o ranges.o segment.o console.o printf.o tree.o
+# Makefile for the Sun Boot PROM interface library under
+# Linux.
+#
+
+lib-y                 := bootstr_$(BITS).o
+lib-$(CONFIG_SPARC32) += devmap.o
+lib-y                 += devops_$(BITS).o
+lib-y                 += init_$(BITS).o
+lib-$(CONFIG_SPARC32) += memory.o
+lib-y                 += misc_$(BITS).o
+lib-$(CONFIG_SPARC32) += mp.o
+lib-$(CONFIG_SPARC32) += palloc.o
+lib-$(CONFIG_SPARC32) += ranges.o
+lib-$(CONFIG_SPARC32) += segment.o
+lib-y                 += console_$(BITS).o
+lib-y                 += printf_$(BITS).o
+lib-y                 += tree_$(BITS).o
diff --git a/arch/sparc/prom/bootstr.c b/arch/sparc/prom/bootstr_32.c
similarity index 100%
rename from arch/sparc/prom/bootstr.c
rename to arch/sparc/prom/bootstr_32.c
diff --git a/arch/sparc/prom/console.c b/arch/sparc/prom/console_32.c
similarity index 100%
rename from arch/sparc/prom/console.c
rename to arch/sparc/prom/console_32.c
diff --git a/arch/sparc/prom/devops.c b/arch/sparc/prom/devops_32.c
similarity index 100%
rename from arch/sparc/prom/devops.c
rename to arch/sparc/prom/devops_32.c
diff --git a/arch/sparc/prom/init.c b/arch/sparc/prom/init_32.c
similarity index 100%
rename from arch/sparc/prom/init.c
rename to arch/sparc/prom/init_32.c
diff --git a/arch/sparc/prom/misc.c b/arch/sparc/prom/misc_32.c
similarity index 100%
rename from arch/sparc/prom/misc.c
rename to arch/sparc/prom/misc_32.c
diff --git a/arch/sparc/prom/printf.c b/arch/sparc/prom/printf_32.c
similarity index 100%
rename from arch/sparc/prom/printf.c
rename to arch/sparc/prom/printf_32.c
diff --git a/arch/sparc/prom/tree.c b/arch/sparc/prom/tree_32.c
similarity index 100%
rename from arch/sparc/prom/tree.c
rename to arch/sparc/prom/tree_32.c
-- 
1.5.6.GIT


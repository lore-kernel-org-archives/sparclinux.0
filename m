From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 16 Nov 2008 20:18:23 +0000
Subject: [PATCH 7/8] sparc: prepare mm/ for unification
Message-Id: <1226866704-6485-7-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

- rename files where sparc64 has similar files to _32.c
- Restructure Makefile
- Sneak in -Werror as we have for sparc64

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/mm/Makefile                    |   38 ++++++++++++++++-------------
 arch/sparc/mm/{fault.c => fault_32.c}     |    0
 arch/sparc/mm/{generic.c => generic_32.c} |    0
 arch/sparc/mm/{init.c => init_32.c}       |    0
 4 files changed, 21 insertions(+), 17 deletions(-)
 rewrite arch/sparc/mm/Makefile (70%)
 rename arch/sparc/mm/{fault.c => fault_32.c} (100%)
 rename arch/sparc/mm/{generic.c => generic_32.c} (100%)
 rename arch/sparc/mm/{init.c => init_32.c} (100%)

diff --git a/arch/sparc/mm/Makefile b/arch/sparc/mm/Makefile
dissimilarity index 70%
index ea88955..3ad1b1f 100644
--- a/arch/sparc/mm/Makefile
+++ b/arch/sparc/mm/Makefile
@@ -1,17 +1,21 @@
-# Makefile for the linux Sparc-specific parts of the memory manager.
-#
-
-EXTRA_AFLAGS := -ansi
-
-obj-y	:= fault.o init.o loadmmu.o generic.o extable.o btfixup.o \
-	    srmmu.o iommu.o io-unit.o hypersparc.o viking.o tsunami.o swift.o
-
-ifdef CONFIG_HIGHMEM
-obj-y	+= highmem.o
-endif
-
-ifdef CONFIG_SMP
-obj-y   += nosun4c.o
-else
-obj-y   += sun4c.o
-endif
+# Makefile for the linux Sparc-specific parts of the memory manager.
+#
+
+asflags-y := -ansi
+ccflags-y := -Werror
+
+obj-y                   := fault_$(BITS).o
+obj-y                   += init_$(BITS).o
+obj-$(CONFIG_SPARC32)   += loadmmu.o
+obj-y                   += generic_$(BITS).o
+obj-$(CONFIG_SPARC32)   += extable.o btfixup.o srmmu.o iommu.o io-unit.o
+obj-$(CONFIG_SPARC32)   += hypersparc.o viking.o tsunami.o swift.o
+
+# Only used by sparc32
+obj-$(CONFIG_HIGHMEM)   += highmem.o
+
+ifdef CONFIG_SMP
+obj-$(CONFIG_SPARC32) += nosun4c.o
+else
+obj-$(CONFIG_SPARC32) += sun4c.o
+endif
diff --git a/arch/sparc/mm/fault.c b/arch/sparc/mm/fault_32.c
similarity index 100%
rename from arch/sparc/mm/fault.c
rename to arch/sparc/mm/fault_32.c
diff --git a/arch/sparc/mm/generic.c b/arch/sparc/mm/generic_32.c
similarity index 100%
rename from arch/sparc/mm/generic.c
rename to arch/sparc/mm/generic_32.c
diff --git a/arch/sparc/mm/init.c b/arch/sparc/mm/init_32.c
similarity index 100%
rename from arch/sparc/mm/init.c
rename to arch/sparc/mm/init_32.c
-- 
1.5.6.GIT


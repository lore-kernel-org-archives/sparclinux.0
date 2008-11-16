From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 16 Nov 2008 20:18:24 +0000
Subject: [PATCH 8/8] sparc,sparc64: unify mm/
Message-Id: <1226866704-6485-8-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

- move all sparc64/mm/ files to arch/sparc/mm/
- commonly named files are named _64.c
- add files to sparc/mm/Makefile preserving link order
- delete now unused sparc64/mm/Makefile
- sparc64 now finds mm/ in sparc

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/mm/Makefile                             |    6 +++++-
 arch/{sparc64/mm/fault.c => sparc/mm/fault_64.c}   |    0
 .../mm/generic.c => sparc/mm/generic_64.c}         |    0
 arch/{sparc64 => sparc}/mm/hugetlbpage.c           |    0
 arch/{sparc64/mm/init.c => sparc/mm/init_64.c}     |    2 +-
 arch/{sparc64/mm/init.h => sparc/mm/init_64.h}     |    0
 arch/{sparc64 => sparc}/mm/tlb.c                   |    0
 arch/{sparc64 => sparc}/mm/tsb.c                   |    0
 arch/{sparc64 => sparc}/mm/ultra.S                 |    0
 arch/sparc64/Makefile                              |    2 +-
 arch/sparc64/mm/Makefile                           |    9 ---------
 11 files changed, 7 insertions(+), 12 deletions(-)
 rename arch/{sparc64/mm/fault.c => sparc/mm/fault_64.c} (100%)
 rename arch/{sparc64/mm/generic.c => sparc/mm/generic_64.c} (100%)
 rename arch/{sparc64 => sparc}/mm/hugetlbpage.c (100%)
 rename arch/{sparc64/mm/init.c => sparc/mm/init_64.c} (99%)
 rename arch/{sparc64/mm/init.h => sparc/mm/init_64.h} (100%)
 rename arch/{sparc64 => sparc}/mm/tlb.c (100%)
 rename arch/{sparc64 => sparc}/mm/tsb.c (100%)
 rename arch/{sparc64 => sparc}/mm/ultra.S (100%)
 delete mode 100644 arch/sparc64/mm/Makefile

diff --git a/arch/sparc/mm/Makefile b/arch/sparc/mm/Makefile
index 3ad1b1f..681abe0 100644
--- a/arch/sparc/mm/Makefile
+++ b/arch/sparc/mm/Makefile
@@ -4,13 +4,17 @@
 asflags-y := -ansi
 ccflags-y := -Werror
 
-obj-y                   := fault_$(BITS).o
+obj-$(CONFIG_SPARC64)   += ultra.o tlb.o tsb.o
+obj-y                   += fault_$(BITS).o
 obj-y                   += init_$(BITS).o
 obj-$(CONFIG_SPARC32)   += loadmmu.o
 obj-y                   += generic_$(BITS).o
 obj-$(CONFIG_SPARC32)   += extable.o btfixup.o srmmu.o iommu.o io-unit.o
 obj-$(CONFIG_SPARC32)   += hypersparc.o viking.o tsunami.o swift.o
 
+# Only used by sparc64
+obj-$(CONFIG_HUGETLB_PAGE) += hugetlbpage.o
+
 # Only used by sparc32
 obj-$(CONFIG_HIGHMEM)   += highmem.o
 
diff --git a/arch/sparc64/mm/fault.c b/arch/sparc/mm/fault_64.c
similarity index 100%
rename from arch/sparc64/mm/fault.c
rename to arch/sparc/mm/fault_64.c
diff --git a/arch/sparc64/mm/generic.c b/arch/sparc/mm/generic_64.c
similarity index 100%
rename from arch/sparc64/mm/generic.c
rename to arch/sparc/mm/generic_64.c
diff --git a/arch/sparc64/mm/hugetlbpage.c b/arch/sparc/mm/hugetlbpage.c
similarity index 100%
rename from arch/sparc64/mm/hugetlbpage.c
rename to arch/sparc/mm/hugetlbpage.c
diff --git a/arch/sparc64/mm/init.c b/arch/sparc/mm/init_64.c
similarity index 99%
rename from arch/sparc64/mm/init.c
rename to arch/sparc/mm/init_64.c
index 3c10daf..6d84555 100644
--- a/arch/sparc64/mm/init.c
+++ b/arch/sparc/mm/init_64.c
@@ -50,7 +50,7 @@
 #include <asm/cpudata.h>
 #include <asm/irq.h>
 
-#include "init.h"
+#include "init_64.h"
 
 unsigned long kern_linear_pte_xor[2] __read_mostly;
 
diff --git a/arch/sparc64/mm/init.h b/arch/sparc/mm/init_64.h
similarity index 100%
rename from arch/sparc64/mm/init.h
rename to arch/sparc/mm/init_64.h
diff --git a/arch/sparc64/mm/tlb.c b/arch/sparc/mm/tlb.c
similarity index 100%
rename from arch/sparc64/mm/tlb.c
rename to arch/sparc/mm/tlb.c
diff --git a/arch/sparc64/mm/tsb.c b/arch/sparc/mm/tsb.c
similarity index 100%
rename from arch/sparc64/mm/tsb.c
rename to arch/sparc/mm/tsb.c
diff --git a/arch/sparc64/mm/ultra.S b/arch/sparc/mm/ultra.S
similarity index 100%
rename from arch/sparc64/mm/ultra.S
rename to arch/sparc/mm/ultra.S
diff --git a/arch/sparc64/Makefile b/arch/sparc64/Makefile
index 3dbda40..bfe0868 100644
--- a/arch/sparc64/Makefile
+++ b/arch/sparc64/Makefile
@@ -27,7 +27,7 @@ endif
 
 head-y := arch/sparc64/kernel/head.o arch/sparc64/kernel/init_task.o
 
-core-y				+= arch/sparc64/kernel/ arch/sparc64/mm/
+core-y				+= arch/sparc64/kernel/ arch/sparc/mm/
 core-y				+= arch/sparc/math-emu/
 libs-y				+= arch/sparc64/prom/ arch/sparc64/lib/
 drivers-$(CONFIG_OPROFILE)	+= arch/sparc/oprofile/
diff --git a/arch/sparc64/mm/Makefile b/arch/sparc64/mm/Makefile
deleted file mode 100644
index 68d04c0..0000000
--- a/arch/sparc64/mm/Makefile
+++ /dev/null
@@ -1,9 +0,0 @@
-# Makefile for the linux Sparc64-specific parts of the memory manager.
-#
-
-EXTRA_AFLAGS := -ansi
-EXTRA_CFLAGS := -Werror
-
-obj-y    := ultra.o tlb.o tsb.o fault.o init.o generic.o
-
-obj-$(CONFIG_HUGETLB_PAGE) += hugetlbpage.o
-- 
1.5.6.GIT


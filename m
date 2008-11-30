From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 30 Nov 2008 20:15:29 +0000
Subject: [PATCH 2/5] sparc,sparc64: unify lib/
Message-Id: <1228076132-18036-2-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

o Renamed files in sparc64 to <name>_64.S when identical
  to sparc32 files.
o iomap.c were equal for sparc32 and sparc64
o adjusted sparc/Makefile now we have only one lib/

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/Makefile                                |    3 +-
 arch/{sparc64 => sparc}/lib/GENbzero.S             |    0
 arch/{sparc64 => sparc}/lib/GENcopy_from_user.S    |    0
 arch/{sparc64 => sparc}/lib/GENcopy_to_user.S      |    0
 arch/{sparc64 => sparc}/lib/GENmemcpy.S            |    0
 arch/{sparc64 => sparc}/lib/GENpage.S              |    0
 arch/{sparc64 => sparc}/lib/GENpatch.S             |    0
 arch/sparc/lib/Makefile                            |   22 +++++++++
 arch/{sparc64 => sparc}/lib/NG2copy_from_user.S    |    0
 arch/{sparc64 => sparc}/lib/NG2copy_to_user.S      |    0
 arch/{sparc64 => sparc}/lib/NG2memcpy.S            |    0
 arch/{sparc64 => sparc}/lib/NG2page.S              |    0
 arch/{sparc64 => sparc}/lib/NG2patch.S             |    0
 arch/{sparc64 => sparc}/lib/NGbzero.S              |    0
 arch/{sparc64 => sparc}/lib/NGcopy_from_user.S     |    0
 arch/{sparc64 => sparc}/lib/NGcopy_to_user.S       |    0
 arch/{sparc64 => sparc}/lib/NGmemcpy.S             |    0
 arch/{sparc64 => sparc}/lib/NGpage.S               |    0
 arch/{sparc64 => sparc}/lib/NGpatch.S              |    0
 arch/{sparc64 => sparc}/lib/PeeCeeI.c              |    0
 arch/{sparc64 => sparc}/lib/U1copy_from_user.S     |    0
 arch/{sparc64 => sparc}/lib/U1copy_to_user.S       |    0
 arch/{sparc64 => sparc}/lib/U1memcpy.S             |    0
 arch/{sparc64 => sparc}/lib/U3copy_from_user.S     |    0
 arch/{sparc64 => sparc}/lib/U3copy_to_user.S       |    0
 arch/{sparc64 => sparc}/lib/U3memcpy.S             |    0
 arch/{sparc64 => sparc}/lib/U3patch.S              |    0
 arch/{sparc64 => sparc}/lib/VISsave.S              |    0
 .../lib/atomic.S => sparc/lib/atomic_64.S}         |    0
 arch/{sparc64 => sparc}/lib/bitops.S               |    0
 arch/{sparc64 => sparc}/lib/bzero.S                |    0
 .../lib/checksum.S => sparc/lib/checksum_64.S}     |    0
 arch/{sparc64 => sparc}/lib/clear_page.S           |    0
 arch/{sparc64 => sparc}/lib/copy_in_user.S         |    0
 arch/{sparc64 => sparc}/lib/copy_page.S            |    0
 arch/{sparc64 => sparc}/lib/csum_copy.S            |    0
 arch/{sparc64 => sparc}/lib/csum_copy_from_user.S  |    0
 arch/{sparc64 => sparc}/lib/csum_copy_to_user.S    |    0
 arch/{sparc64 => sparc}/lib/ipcsum.S               |    0
 arch/{sparc64 => sparc}/lib/mcount.S               |    0
 .../lib/memcmp.S => sparc/lib/memcmp_64.S}         |    0
 arch/{sparc64 => sparc}/lib/memmove.S              |    0
 .../lib/memscan.S => sparc/lib/memscan_64.S}       |    0
 arch/{sparc64/lib/rwsem.S => sparc/lib/rwsem_64.S} |    0
 .../lib/strlen.S => sparc/lib/strlen_64.S}         |    0
 .../strlen_user.S => sparc/lib/strlen_user_64.S}   |    0
 .../lib/strncmp.S => sparc/lib/strncmp_64.S}       |    0
 .../lib/strncpy_from_user_64.S}                    |    0
 arch/{sparc64 => sparc}/lib/user_fixup.c           |    0
 arch/{sparc64 => sparc}/lib/xor.S                  |    0
 arch/sparc64/lib/Makefile                          |   23 ---------
 arch/sparc64/lib/iomap.c                           |   48 --------------------
 52 files changed, 23 insertions(+), 73 deletions(-)
 rename arch/{sparc64 => sparc}/lib/GENbzero.S (100%)
 rename arch/{sparc64 => sparc}/lib/GENcopy_from_user.S (100%)
 rename arch/{sparc64 => sparc}/lib/GENcopy_to_user.S (100%)
 rename arch/{sparc64 => sparc}/lib/GENmemcpy.S (100%)
 rename arch/{sparc64 => sparc}/lib/GENpage.S (100%)
 rename arch/{sparc64 => sparc}/lib/GENpatch.S (100%)
 rename arch/{sparc64 => sparc}/lib/NG2copy_from_user.S (100%)
 rename arch/{sparc64 => sparc}/lib/NG2copy_to_user.S (100%)
 rename arch/{sparc64 => sparc}/lib/NG2memcpy.S (100%)
 rename arch/{sparc64 => sparc}/lib/NG2page.S (100%)
 rename arch/{sparc64 => sparc}/lib/NG2patch.S (100%)
 rename arch/{sparc64 => sparc}/lib/NGbzero.S (100%)
 rename arch/{sparc64 => sparc}/lib/NGcopy_from_user.S (100%)
 rename arch/{sparc64 => sparc}/lib/NGcopy_to_user.S (100%)
 rename arch/{sparc64 => sparc}/lib/NGmemcpy.S (100%)
 rename arch/{sparc64 => sparc}/lib/NGpage.S (100%)
 rename arch/{sparc64 => sparc}/lib/NGpatch.S (100%)
 rename arch/{sparc64 => sparc}/lib/PeeCeeI.c (100%)
 rename arch/{sparc64 => sparc}/lib/U1copy_from_user.S (100%)
 rename arch/{sparc64 => sparc}/lib/U1copy_to_user.S (100%)
 rename arch/{sparc64 => sparc}/lib/U1memcpy.S (100%)
 rename arch/{sparc64 => sparc}/lib/U3copy_from_user.S (100%)
 rename arch/{sparc64 => sparc}/lib/U3copy_to_user.S (100%)
 rename arch/{sparc64 => sparc}/lib/U3memcpy.S (100%)
 rename arch/{sparc64 => sparc}/lib/U3patch.S (100%)
 rename arch/{sparc64 => sparc}/lib/VISsave.S (100%)
 rename arch/{sparc64/lib/atomic.S => sparc/lib/atomic_64.S} (100%)
 rename arch/{sparc64 => sparc}/lib/bitops.S (100%)
 rename arch/{sparc64 => sparc}/lib/bzero.S (100%)
 rename arch/{sparc64/lib/checksum.S => sparc/lib/checksum_64.S} (100%)
 rename arch/{sparc64 => sparc}/lib/clear_page.S (100%)
 rename arch/{sparc64 => sparc}/lib/copy_in_user.S (100%)
 rename arch/{sparc64 => sparc}/lib/copy_page.S (100%)
 rename arch/{sparc64 => sparc}/lib/csum_copy.S (100%)
 rename arch/{sparc64 => sparc}/lib/csum_copy_from_user.S (100%)
 rename arch/{sparc64 => sparc}/lib/csum_copy_to_user.S (100%)
 rename arch/{sparc64 => sparc}/lib/ipcsum.S (100%)
 rename arch/{sparc64 => sparc}/lib/mcount.S (100%)
 rename arch/{sparc64/lib/memcmp.S => sparc/lib/memcmp_64.S} (100%)
 rename arch/{sparc64 => sparc}/lib/memmove.S (100%)
 rename arch/{sparc64/lib/memscan.S => sparc/lib/memscan_64.S} (100%)
 rename arch/{sparc64/lib/rwsem.S => sparc/lib/rwsem_64.S} (100%)
 rename arch/{sparc64/lib/strlen.S => sparc/lib/strlen_64.S} (100%)
 rename arch/{sparc64/lib/strlen_user.S => sparc/lib/strlen_user_64.S} (100%)
 rename arch/{sparc64/lib/strncmp.S => sparc/lib/strncmp_64.S} (100%)
 rename arch/{sparc64/lib/strncpy_from_user.S => sparc/lib/strncpy_from_user_64.S} (100%)
 rename arch/{sparc64 => sparc}/lib/user_fixup.c (100%)
 rename arch/{sparc64 => sparc}/lib/xor.S (100%)
 delete mode 100644 arch/sparc64/lib/Makefile
 delete mode 100644 arch/sparc64/lib/iomap.c

diff --git a/arch/sparc/Makefile b/arch/sparc/Makefile
index 6df8eb5..4e12a1e 100644
--- a/arch/sparc/Makefile
+++ b/arch/sparc/Makefile
@@ -77,8 +77,7 @@ core-$(CONFIG_SPARC64) += arch/sparc64/kernel/
 core-y                 += arch/sparc/mm/ arch/sparc/math-emu/
 
 libs-y                 += arch/sparc/prom/
-libs-$(CONFIG_SPARC32) += arch/sparc/lib/
-libs-$(CONFIG_SPARC64) += arch/sparc64/lib/
+libs-y                 += arch/sparc/lib/
 
 drivers-$(CONFIG_OPROFILE)	+= arch/sparc/oprofile/
 
diff --git a/arch/sparc64/lib/GENbzero.S b/arch/sparc/lib/GENbzero.S
similarity index 100%
rename from arch/sparc64/lib/GENbzero.S
rename to arch/sparc/lib/GENbzero.S
diff --git a/arch/sparc64/lib/GENcopy_from_user.S b/arch/sparc/lib/GENcopy_from_user.S
similarity index 100%
rename from arch/sparc64/lib/GENcopy_from_user.S
rename to arch/sparc/lib/GENcopy_from_user.S
diff --git a/arch/sparc64/lib/GENcopy_to_user.S b/arch/sparc/lib/GENcopy_to_user.S
similarity index 100%
rename from arch/sparc64/lib/GENcopy_to_user.S
rename to arch/sparc/lib/GENcopy_to_user.S
diff --git a/arch/sparc64/lib/GENmemcpy.S b/arch/sparc/lib/GENmemcpy.S
similarity index 100%
rename from arch/sparc64/lib/GENmemcpy.S
rename to arch/sparc/lib/GENmemcpy.S
diff --git a/arch/sparc64/lib/GENpage.S b/arch/sparc/lib/GENpage.S
similarity index 100%
rename from arch/sparc64/lib/GENpage.S
rename to arch/sparc/lib/GENpage.S
diff --git a/arch/sparc64/lib/GENpatch.S b/arch/sparc/lib/GENpatch.S
similarity index 100%
rename from arch/sparc64/lib/GENpatch.S
rename to arch/sparc/lib/GENpatch.S
diff --git a/arch/sparc/lib/Makefile b/arch/sparc/lib/Makefile
index f265054..05ae5c9 100644
--- a/arch/sparc/lib/Makefile
+++ b/arch/sparc/lib/Makefile
@@ -18,5 +18,27 @@ lib-$(CONFIG_SPARC32) += lshrdi3.o ashldi3.o
 lib-y                 += rwsem_$(BITS).o
 lib-$(CONFIG_SPARC32) += muldi3.o bitext.o cmpdi2.o
 
+lib-$(CONFIG_SPARC64) += PeeCeeI.o copy_page.o clear_page.o bzero.o
+lib-$(CONFIG_SPARC64) += csum_copy.o csum_copy_from_user.o csum_copy_to_user.o
+lib-$(CONFIG_SPARC64) += VISsave.o
+lib-$(CONFIG_SPARC64) += bitops.o
+
+lib-$(CONFIG_SPARC64) += U1memcpy.o U1copy_from_user.o U1copy_to_user.o
+
+lib-$(CONFIG_SPARC64) += U3memcpy.o U3copy_from_user.o U3copy_to_user.o
+lib-$(CONFIG_SPARC64) += U3patch.o
+
+lib-$(CONFIG_SPARC64) += NGmemcpy.o NGcopy_from_user.o NGcopy_to_user.o
+lib-$(CONFIG_SPARC64) += NGpatch.o NGpage.o NGbzero.o
+
+lib-$(CONFIG_SPARC64) += NG2memcpy.o NG2copy_from_user.o NG2copy_to_user.o
+lib-$(CONFIG_SPARC64) +=  NG2patch.o NG2page.o
+
+lib-$(CONFIG_SPARC64) += GENmemcpy.o GENcopy_from_user.o GENcopy_to_user.o
+lib-$(CONFIG_SPARC64) += GENpatch.o GENpage.o GENbzero.o
+
+lib-$(CONFIG_SPARC64) += copy_in_user.o user_fixup.o memmove.o
+lib-$(CONFIG_SPARC64) += mcount.o ipcsum.o xor.o
+
 obj-y                 += iomap.o
 obj-$(CONFIG_SPARC32) += atomic32.o
diff --git a/arch/sparc64/lib/NG2copy_from_user.S b/arch/sparc/lib/NG2copy_from_user.S
similarity index 100%
rename from arch/sparc64/lib/NG2copy_from_user.S
rename to arch/sparc/lib/NG2copy_from_user.S
diff --git a/arch/sparc64/lib/NG2copy_to_user.S b/arch/sparc/lib/NG2copy_to_user.S
similarity index 100%
rename from arch/sparc64/lib/NG2copy_to_user.S
rename to arch/sparc/lib/NG2copy_to_user.S
diff --git a/arch/sparc64/lib/NG2memcpy.S b/arch/sparc/lib/NG2memcpy.S
similarity index 100%
rename from arch/sparc64/lib/NG2memcpy.S
rename to arch/sparc/lib/NG2memcpy.S
diff --git a/arch/sparc64/lib/NG2page.S b/arch/sparc/lib/NG2page.S
similarity index 100%
rename from arch/sparc64/lib/NG2page.S
rename to arch/sparc/lib/NG2page.S
diff --git a/arch/sparc64/lib/NG2patch.S b/arch/sparc/lib/NG2patch.S
similarity index 100%
rename from arch/sparc64/lib/NG2patch.S
rename to arch/sparc/lib/NG2patch.S
diff --git a/arch/sparc64/lib/NGbzero.S b/arch/sparc/lib/NGbzero.S
similarity index 100%
rename from arch/sparc64/lib/NGbzero.S
rename to arch/sparc/lib/NGbzero.S
diff --git a/arch/sparc64/lib/NGcopy_from_user.S b/arch/sparc/lib/NGcopy_from_user.S
similarity index 100%
rename from arch/sparc64/lib/NGcopy_from_user.S
rename to arch/sparc/lib/NGcopy_from_user.S
diff --git a/arch/sparc64/lib/NGcopy_to_user.S b/arch/sparc/lib/NGcopy_to_user.S
similarity index 100%
rename from arch/sparc64/lib/NGcopy_to_user.S
rename to arch/sparc/lib/NGcopy_to_user.S
diff --git a/arch/sparc64/lib/NGmemcpy.S b/arch/sparc/lib/NGmemcpy.S
similarity index 100%
rename from arch/sparc64/lib/NGmemcpy.S
rename to arch/sparc/lib/NGmemcpy.S
diff --git a/arch/sparc64/lib/NGpage.S b/arch/sparc/lib/NGpage.S
similarity index 100%
rename from arch/sparc64/lib/NGpage.S
rename to arch/sparc/lib/NGpage.S
diff --git a/arch/sparc64/lib/NGpatch.S b/arch/sparc/lib/NGpatch.S
similarity index 100%
rename from arch/sparc64/lib/NGpatch.S
rename to arch/sparc/lib/NGpatch.S
diff --git a/arch/sparc64/lib/PeeCeeI.c b/arch/sparc/lib/PeeCeeI.c
similarity index 100%
rename from arch/sparc64/lib/PeeCeeI.c
rename to arch/sparc/lib/PeeCeeI.c
diff --git a/arch/sparc64/lib/U1copy_from_user.S b/arch/sparc/lib/U1copy_from_user.S
similarity index 100%
rename from arch/sparc64/lib/U1copy_from_user.S
rename to arch/sparc/lib/U1copy_from_user.S
diff --git a/arch/sparc64/lib/U1copy_to_user.S b/arch/sparc/lib/U1copy_to_user.S
similarity index 100%
rename from arch/sparc64/lib/U1copy_to_user.S
rename to arch/sparc/lib/U1copy_to_user.S
diff --git a/arch/sparc64/lib/U1memcpy.S b/arch/sparc/lib/U1memcpy.S
similarity index 100%
rename from arch/sparc64/lib/U1memcpy.S
rename to arch/sparc/lib/U1memcpy.S
diff --git a/arch/sparc64/lib/U3copy_from_user.S b/arch/sparc/lib/U3copy_from_user.S
similarity index 100%
rename from arch/sparc64/lib/U3copy_from_user.S
rename to arch/sparc/lib/U3copy_from_user.S
diff --git a/arch/sparc64/lib/U3copy_to_user.S b/arch/sparc/lib/U3copy_to_user.S
similarity index 100%
rename from arch/sparc64/lib/U3copy_to_user.S
rename to arch/sparc/lib/U3copy_to_user.S
diff --git a/arch/sparc64/lib/U3memcpy.S b/arch/sparc/lib/U3memcpy.S
similarity index 100%
rename from arch/sparc64/lib/U3memcpy.S
rename to arch/sparc/lib/U3memcpy.S
diff --git a/arch/sparc64/lib/U3patch.S b/arch/sparc/lib/U3patch.S
similarity index 100%
rename from arch/sparc64/lib/U3patch.S
rename to arch/sparc/lib/U3patch.S
diff --git a/arch/sparc64/lib/VISsave.S b/arch/sparc/lib/VISsave.S
similarity index 100%
rename from arch/sparc64/lib/VISsave.S
rename to arch/sparc/lib/VISsave.S
diff --git a/arch/sparc64/lib/atomic.S b/arch/sparc/lib/atomic_64.S
similarity index 100%
rename from arch/sparc64/lib/atomic.S
rename to arch/sparc/lib/atomic_64.S
diff --git a/arch/sparc64/lib/bitops.S b/arch/sparc/lib/bitops.S
similarity index 100%
rename from arch/sparc64/lib/bitops.S
rename to arch/sparc/lib/bitops.S
diff --git a/arch/sparc64/lib/bzero.S b/arch/sparc/lib/bzero.S
similarity index 100%
rename from arch/sparc64/lib/bzero.S
rename to arch/sparc/lib/bzero.S
diff --git a/arch/sparc64/lib/checksum.S b/arch/sparc/lib/checksum_64.S
similarity index 100%
rename from arch/sparc64/lib/checksum.S
rename to arch/sparc/lib/checksum_64.S
diff --git a/arch/sparc64/lib/clear_page.S b/arch/sparc/lib/clear_page.S
similarity index 100%
rename from arch/sparc64/lib/clear_page.S
rename to arch/sparc/lib/clear_page.S
diff --git a/arch/sparc64/lib/copy_in_user.S b/arch/sparc/lib/copy_in_user.S
similarity index 100%
rename from arch/sparc64/lib/copy_in_user.S
rename to arch/sparc/lib/copy_in_user.S
diff --git a/arch/sparc64/lib/copy_page.S b/arch/sparc/lib/copy_page.S
similarity index 100%
rename from arch/sparc64/lib/copy_page.S
rename to arch/sparc/lib/copy_page.S
diff --git a/arch/sparc64/lib/csum_copy.S b/arch/sparc/lib/csum_copy.S
similarity index 100%
rename from arch/sparc64/lib/csum_copy.S
rename to arch/sparc/lib/csum_copy.S
diff --git a/arch/sparc64/lib/csum_copy_from_user.S b/arch/sparc/lib/csum_copy_from_user.S
similarity index 100%
rename from arch/sparc64/lib/csum_copy_from_user.S
rename to arch/sparc/lib/csum_copy_from_user.S
diff --git a/arch/sparc64/lib/csum_copy_to_user.S b/arch/sparc/lib/csum_copy_to_user.S
similarity index 100%
rename from arch/sparc64/lib/csum_copy_to_user.S
rename to arch/sparc/lib/csum_copy_to_user.S
diff --git a/arch/sparc64/lib/ipcsum.S b/arch/sparc/lib/ipcsum.S
similarity index 100%
rename from arch/sparc64/lib/ipcsum.S
rename to arch/sparc/lib/ipcsum.S
diff --git a/arch/sparc64/lib/mcount.S b/arch/sparc/lib/mcount.S
similarity index 100%
rename from arch/sparc64/lib/mcount.S
rename to arch/sparc/lib/mcount.S
diff --git a/arch/sparc64/lib/memcmp.S b/arch/sparc/lib/memcmp_64.S
similarity index 100%
rename from arch/sparc64/lib/memcmp.S
rename to arch/sparc/lib/memcmp_64.S
diff --git a/arch/sparc64/lib/memmove.S b/arch/sparc/lib/memmove.S
similarity index 100%
rename from arch/sparc64/lib/memmove.S
rename to arch/sparc/lib/memmove.S
diff --git a/arch/sparc64/lib/memscan.S b/arch/sparc/lib/memscan_64.S
similarity index 100%
rename from arch/sparc64/lib/memscan.S
rename to arch/sparc/lib/memscan_64.S
diff --git a/arch/sparc64/lib/rwsem.S b/arch/sparc/lib/rwsem_64.S
similarity index 100%
rename from arch/sparc64/lib/rwsem.S
rename to arch/sparc/lib/rwsem_64.S
diff --git a/arch/sparc64/lib/strlen.S b/arch/sparc/lib/strlen_64.S
similarity index 100%
rename from arch/sparc64/lib/strlen.S
rename to arch/sparc/lib/strlen_64.S
diff --git a/arch/sparc64/lib/strlen_user.S b/arch/sparc/lib/strlen_user_64.S
similarity index 100%
rename from arch/sparc64/lib/strlen_user.S
rename to arch/sparc/lib/strlen_user_64.S
diff --git a/arch/sparc64/lib/strncmp.S b/arch/sparc/lib/strncmp_64.S
similarity index 100%
rename from arch/sparc64/lib/strncmp.S
rename to arch/sparc/lib/strncmp_64.S
diff --git a/arch/sparc64/lib/strncpy_from_user.S b/arch/sparc/lib/strncpy_from_user_64.S
similarity index 100%
rename from arch/sparc64/lib/strncpy_from_user.S
rename to arch/sparc/lib/strncpy_from_user_64.S
diff --git a/arch/sparc64/lib/user_fixup.c b/arch/sparc/lib/user_fixup.c
similarity index 100%
rename from arch/sparc64/lib/user_fixup.c
rename to arch/sparc/lib/user_fixup.c
diff --git a/arch/sparc64/lib/xor.S b/arch/sparc/lib/xor.S
similarity index 100%
rename from arch/sparc64/lib/xor.S
rename to arch/sparc/lib/xor.S
diff --git a/arch/sparc64/lib/Makefile b/arch/sparc64/lib/Makefile
deleted file mode 100644
index f095e13..0000000
--- a/arch/sparc64/lib/Makefile
+++ /dev/null
@@ -1,23 +0,0 @@
-#
-# Makefile for Sparc64 library files..
-#
-
-EXTRA_AFLAGS := -ansi
-EXTRA_CFLAGS := -Werror
-
-lib-y := PeeCeeI.o copy_page.o clear_page.o strlen.o strncmp.o \
-	 memscan.o strncpy_from_user.o strlen_user.o memcmp.o checksum.o \
-	 bzero.o csum_copy.o csum_copy_from_user.o csum_copy_to_user.o \
-	 VISsave.o atomic.o bitops.o \
-	 U1memcpy.o U1copy_from_user.o U1copy_to_user.o \
-	 U3memcpy.o U3copy_from_user.o U3copy_to_user.o U3patch.o \
-	 NGmemcpy.o NGcopy_from_user.o NGcopy_to_user.o NGpatch.o \
-	 NGpage.o NGbzero.o \
-	 NG2memcpy.o NG2copy_from_user.o NG2copy_to_user.o NG2patch.o \
-	 NG2page.o \
-	 GENmemcpy.o GENcopy_from_user.o GENcopy_to_user.o GENpatch.o \
-	 GENpage.o GENbzero.o \
-	 copy_in_user.o user_fixup.o memmove.o \
-	 mcount.o ipcsum.o rwsem.o xor.o
-
-obj-y += iomap.o
diff --git a/arch/sparc64/lib/iomap.c b/arch/sparc64/lib/iomap.c
deleted file mode 100644
index 7120ebb..0000000
--- a/arch/sparc64/lib/iomap.c
+++ /dev/null
@@ -1,48 +0,0 @@
-/*
- * Implement the sparc64 iomap interfaces
- */
-#include <linux/pci.h>
-#include <linux/module.h>
-#include <asm/io.h>
-
-/* Create a virtual mapping cookie for an IO port range */
-void __iomem *ioport_map(unsigned long port, unsigned int nr)
-{
-	return (void __iomem *) (unsigned long) port;
-}
-
-void ioport_unmap(void __iomem *addr)
-{
-	/* Nothing to do */
-}
-EXPORT_SYMBOL(ioport_map);
-EXPORT_SYMBOL(ioport_unmap);
-
-/* Create a virtual mapping cookie for a PCI BAR (memory or IO) */
-void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long maxlen)
-{
-	resource_size_t start = pci_resource_start(dev, bar);
-	resource_size_t len = pci_resource_len(dev, bar);
-	unsigned long flags = pci_resource_flags(dev, bar);
-
-	if (!len || !start)
-		return NULL;
-	if (maxlen && len > maxlen)
-		len = maxlen;
-	if (flags & IORESOURCE_IO)
-		return ioport_map(start, len);
-	if (flags & IORESOURCE_MEM) {
-		if (flags & IORESOURCE_CACHEABLE)
-			return ioremap(start, len);
-		return ioremap_nocache(start, len);
-	}
-	/* What? */
-	return NULL;
-}
-
-void pci_iounmap(struct pci_dev *dev, void __iomem * addr)
-{
-	/* nothing to do */
-}
-EXPORT_SYMBOL(pci_iomap);
-EXPORT_SYMBOL(pci_iounmap);
-- 
1.5.6.GIT


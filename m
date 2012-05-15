From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 15 May 2012 19:34:47 +0000
Subject: [PATCH 2/3] sparc: clean up Makefile
Message-Id: <20120515193447.GB17309@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From 13403760d271b5b667d7bb6b530296da405c7356 Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 15 May 2012 21:21:55 +0200
Subject: [PATCH 2/3] sparc: clean up Makefile

- delete unused variables
- align assignments
- drop stale comments
- kill use of "\" for line continuation

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/Makefile |   31 ++++++++++---------------------
 1 files changed, 10 insertions(+), 21 deletions(-)

diff --git a/arch/sparc/Makefile b/arch/sparc/Makefile
index 23f17d1..a492815 100644
--- a/arch/sparc/Makefile
+++ b/arch/sparc/Makefile
@@ -19,34 +19,27 @@ ifeq ($(CONFIG_SPARC32),y)
 # sparc32
 #
 
-#
-# Uncomment the first KBUILD_CFLAGS if you are doing kgdb source level
-# debugging of the kernel to get the proper debugging information.
-
-AS             := $(AS) -32
-LDFLAGS        := -m elf32_sparc
 CHECKFLAGS     += -D__sparc__
+LDFLAGS        := -m elf32_sparc
 export BITS    := 32
 UTS_MACHINE    := sparc
 
-#KBUILD_CFLAGS += -g -pipe -fcall-used-g5 -fcall-used-g7
-KBUILD_CFLAGS += -m32 -mcpu=v8 -pipe -mno-fpu -fcall-used-g5 -fcall-used-g7
-KBUILD_AFLAGS += -m32 -Wa,-Av8
+KBUILD_CFLAGS  += -m32 -mcpu=v8 -pipe -mno-fpu -fcall-used-g5 -fcall-used-g7
+KBUILD_AFLAGS  += -m32 -Wa,-Av8
 
 else
 #####
 # sparc64
 #
 
-CHECKFLAGS      += -D__sparc__ -D__sparc_v9__ -D__arch64__ -m64
+CHECKFLAGS    += -D__sparc__ -D__sparc_v9__ -D__arch64__ -m64
+LDFLAGS       := -m elf64_sparc
+export BITS   := 64
+UTS_MACHINE   := sparc64
 
-LDFLAGS              := -m elf64_sparc
-export BITS          := 64
-UTS_MACHINE          := sparc64
-
-KBUILD_CFLAGS += -m64 -pipe -mno-fpu -mcpu=ultrasparc -mcmodel=medlow   \
-                 -ffixed-g4 -ffixed-g5 -fcall-used-g7 -Wno-sign-compare \
-                 -Wa,--undeclared-regs
+KBUILD_CFLAGS += -m64 -pipe -mno-fpu -mcpu=ultrasparc -mcmodel=medlow
+KBUILD_CFLAGS += -ffixed-g4 -ffixed-g5 -fcall-used-g7 -Wno-sign-compare
+KBUILD_CFLAGS += -Wa,--undeclared-regs
 KBUILD_CFLAGS += $(call cc-option,-mtune=ultrasparc3)
 KBUILD_AFLAGS += -m64 -mcpu=ultrasparc -Wa,--undeclared-regs
 
@@ -67,10 +60,6 @@ libs-y                 += arch/sparc/lib/
 
 drivers-$(CONFIG_OPROFILE)	+= arch/sparc/oprofile/
 
-ifdef CONFIG_KALLSYMS
-export kallsyms.o := .tmp_kallsyms2.o
-endif
-
 boot := arch/sparc/boot
 
 # Default target
-- 
1.6.0.6


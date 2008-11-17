From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 17 Nov 2008 22:06:03 +0000
Subject: [PATCH 4/6] sparc,sparc64: unify arch Makefile
Message-Id: <1226959565-14796-4-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Unifying arch Makefile is a preparation for the unification
of kernel/ as asm-offset.c lives here.
The unification required a small update of the top-level
Makefile where sparc support got simpler.

With this update the sparc64 Kconfig file are no longer
used and is deleted.
And the asm-offset.c file from sparc/kernel is now used so
the sparc64 version is deleted.
The defconfig files were both copied to sparc/configs
and logic was added to seelct the right one.

The content of the sparc64/Makefile is more or less
verbatim copied to the sparc/Makefile. Further unification
is possible after finalizing the other unification work.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 Makefile                                           |    9 ++--
 arch/sparc/Kconfig                                 |    5 ++
 arch/sparc/Makefile                                |   52 +++++++++++++++++++-
 .../sparc/{defconfig => configs/sparc32_defconfig} |    0
 .../defconfig => sparc/configs/sparc64_defconfig}  |    0
 arch/sparc/kernel/asm-offsets.c                    |    6 ++
 arch/sparc64/Kconfig                               |    1 -
 arch/sparc64/Makefile                              |   48 ------------------
 arch/sparc64/kernel/asm-offsets.c                  |    1 -
 9 files changed, 67 insertions(+), 55 deletions(-)
 rename arch/sparc/{defconfig => configs/sparc32_defconfig} (100%)
 rename arch/{sparc64/defconfig => sparc/configs/sparc64_defconfig} (100%)
 delete mode 100644 arch/sparc64/Kconfig
 delete mode 100644 arch/sparc64/Makefile
 delete mode 100644 arch/sparc64/kernel/asm-offsets.c

diff --git a/Makefile b/Makefile
index d500817..6f659bb 100644
--- a/Makefile
+++ b/Makefile
@@ -205,13 +205,14 @@ ifeq ($(ARCH),x86_64)
         SRCARCH := x86
 endif
 
-# Where to locate arch specific headers
+# Additional ARCH settings for sparc
 ifeq ($(ARCH),sparc64)
-       hdr-arch  := sparc
-else
-       hdr-arch  := $(SRCARCH)
+       SRCARCH := sparc
 endif
 
+# Where to locate arch specific headers
+hdr-arch  := $(SRCARCH)
+
 KCONFIG_CONFIG	?= .config
 
 # SHELL used by kbuild
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 7cf98a7..3e77d05 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -41,6 +41,11 @@ config SPARC64
 	select RTC_DRV_SUN4V
 	select RTC_DRV_STARFIRE
 
+config ARCH_DEFCONFIG
+        string
+        default "arch/sparc/configs/sparc32_defconfig" if SPARC32
+        default "arch/sparc/configs/sparc64_defconfig" if SPARC64
+
 config 64BIT
 	def_bool y if SPARC64
 
diff --git a/arch/sparc/Makefile b/arch/sparc/Makefile
index c5f3d6f..c47f274 100644
--- a/arch/sparc/Makefile
+++ b/arch/sparc/Makefile
@@ -7,6 +7,18 @@
 # Copyright (C) 1994 David S. Miller (davem@caip.rutgers.edu)
 #
 
+# We are not yet configured - so test on arch
+ifeq ($(ARCH),sparc)
+        KBUILD_DEFCONFIG := sparc32_defconfig
+else
+        KBUILD_DEFCONFIG := sparc64_defconfig
+endif
+
+ifeq ($(CONFIG_SPARC32),y)
+#####
+# sparc32
+#
+
 #
 # Uncomment the first KBUILD_CFLAGS if you are doing kgdb source level
 # debugging of the kernel to get the proper debugging information.
@@ -57,7 +69,40 @@ all: zImage
 
 boot := arch/sparc/boot
 
-image zImage tftpboot.img: vmlinux
+else
+#####
+# sparc64
+#
+
+CHECKFLAGS      += -D__sparc__ -D__sparc_v9__ -D__arch64__ -m64
+
+# Undefine sparc when processing vmlinux.lds - it is used
+# And teach CPP we are doing 64 bit builds (for this case)
+CPPFLAGS_vmlinux.lds += -m64 -Usparc
+LDFLAGS              := -m elf64_sparc
+export BITS          := 64
+
+KBUILD_CFLAGS += -m64 -pipe -mno-fpu -mcpu=ultrasparc -mcmodel=medlow \
+        -ffixed-g4 -ffixed-g5 -fcall-used-g7 -Wno-sign-compare \
+        -Wa,--undeclared-regs
+KBUILD_CFLAGS += $(call cc-option,-mtune=ultrasparc3)
+KBUILD_AFLAGS += -m64 -mcpu=ultrasparc -Wa,--undeclared-regs
+
+ifeq ($(CONFIG_MCOUNT),y)
+  KBUILD_CFLAGS += -pg
+endif
+
+head-y := arch/sparc64/kernel/head.o arch/sparc64/kernel/init_task.o
+
+core-y                          += arch/sparc64/kernel/ arch/sparc/mm/
+core-y                          += arch/sparc/math-emu/
+libs-y                          += arch/sparc/prom/ arch/sparc64/lib/
+drivers-$(CONFIG_OPROFILE)      += arch/sparc/oprofile/
+
+boot := arch/sparc64/boot
+endif
+
+image zImage tftpboot.img vmlinux.aout: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
 
 archclean:
@@ -70,7 +115,12 @@ CLEAN_FILES += arch/$(ARCH)/boot/System.map
 
 # Don't use tabs in echo arguments.
 define archhelp
+ifeq ($(CONFIG_SPARC32),y)
   echo  '* image        - kernel image ($(boot)/image)'
   echo  '* zImage       - stripped kernel image ($(boot)/zImage)'
+else
+  echo  '* vmlinux       - Standard sparc64 kernel'
+  echo  '  vmlinux.aout  - a.out kernel for sparc64'
+endif
   echo  '  tftpboot.img - image prepared for tftp'
 endef
diff --git a/arch/sparc/defconfig b/arch/sparc/configs/sparc32_defconfig
similarity index 100%
rename from arch/sparc/defconfig
rename to arch/sparc/configs/sparc32_defconfig
diff --git a/arch/sparc64/defconfig b/arch/sparc/configs/sparc64_defconfig
similarity index 100%
rename from arch/sparc64/defconfig
rename to arch/sparc/configs/sparc64_defconfig
diff --git a/arch/sparc/kernel/asm-offsets.c b/arch/sparc/kernel/asm-offsets.c
index b5bb99e..bdede71 100644
--- a/arch/sparc/kernel/asm-offsets.c
+++ b/arch/sparc/kernel/asm-offsets.c
@@ -14,6 +14,8 @@
 // #include <linux/mm.h>
 #include <linux/kbuild.h>
 
+#ifdef CONFIG_SPARC32
+
 int foo(void)
 {
 	DEFINE(AOFF_task_thread, offsetof(struct task_struct, thread));
@@ -26,3 +28,7 @@ int foo(void)
 	/* DEFINE(NUM_USER_SEGMENTS, TASK_SIZE>>28); */
 	return 0;
 }
+
+#else
+/* Nothing for sparc64 (yet) */
+#endif
diff --git a/arch/sparc64/Kconfig b/arch/sparc64/Kconfig
deleted file mode 100644
index caa9421..0000000
--- a/arch/sparc64/Kconfig
+++ /dev/null
@@ -1 +0,0 @@
-source arch/sparc/Kconfig
diff --git a/arch/sparc64/Makefile b/arch/sparc64/Makefile
deleted file mode 100644
index 33d7302..0000000
--- a/arch/sparc64/Makefile
+++ /dev/null
@@ -1,48 +0,0 @@
-# sparc64/Makefile
-#
-# Makefile for the architecture dependent flags and dependencies on the
-# 64-bit Sparc.
-#
-# Copyright (C) 1996,1998 David S. Miller (davem@caip.rutgers.edu)
-# Copyright (C) 1998 Jakub Jelinek (jj@ultra.linux.cz)
-#
-
-CHECKFLAGS	+= -D__sparc__ -D__sparc_v9__ -D__arch64__ -m64
-
-# Undefine sparc when processing vmlinux.lds - it is used
-# And teach CPP we are doing 64 bit builds (for this case)
-CPPFLAGS_vmlinux.lds += -m64 -Usparc
-LDFLAGS              := -m elf64_sparc
-export BITS          := 64
-
-KBUILD_CFLAGS += -m64 -pipe -mno-fpu -mcpu=ultrasparc -mcmodel=medlow \
-	-ffixed-g4 -ffixed-g5 -fcall-used-g7 -Wno-sign-compare \
-	-Wa,--undeclared-regs
-KBUILD_CFLAGS += $(call cc-option,-mtune=ultrasparc3)
-KBUILD_AFLAGS += -m64 -mcpu=ultrasparc -Wa,--undeclared-regs
-
-ifeq ($(CONFIG_MCOUNT),y)
-  KBUILD_CFLAGS += -pg
-endif
-
-head-y := arch/sparc64/kernel/head.o arch/sparc64/kernel/init_task.o
-
-core-y				+= arch/sparc64/kernel/ arch/sparc/mm/
-core-y				+= arch/sparc/math-emu/
-libs-y				+= arch/sparc/prom/ arch/sparc64/lib/
-drivers-$(CONFIG_OPROFILE)	+= arch/sparc/oprofile/
-
-boot := arch/sparc64/boot
-
-image tftpboot.img vmlinux.aout: vmlinux
-	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
-
-archclean:
-	$(Q)$(MAKE) $(clean)=$(boot)
-
-define archhelp
-  echo  '* vmlinux       - Standard sparc64 kernel'
-  echo  '  vmlinux.aout  - a.out kernel for sparc64'
-  echo  '  tftpboot.img  - Image prepared for tftp'
-endef
-
diff --git a/arch/sparc64/kernel/asm-offsets.c b/arch/sparc64/kernel/asm-offsets.c
deleted file mode 100644
index 9e26311..0000000
--- a/arch/sparc64/kernel/asm-offsets.c
+++ /dev/null
@@ -1 +0,0 @@
-/* Dummy asm-offsets.c file. Required by kbuild and ready to be used - hint! */
-- 
1.5.6.GIT


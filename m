From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 29 Nov 2008 22:05:52 +0000
Subject: [PATCH 08/10] sparc,sparc64: unify Makefile
Message-Id: <1227996354-11478-8-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

To unify Makefile for sparc and sparc64 a few other steps was needed:
1) separate defconfig files for sparc and sparc64 is required,
   so locate these in arch/sparc/configs
2) removoval of hack in toplevel Makefile to deal with that
   headers was in a separate directory compared to the rest

The unification of the Makefile required usage of several

    foo-$(CONFIG_SPARCnn) +
due to a few directories pending unification.
This will be cleaned up when we unify the remaining directories.

Included in this patch are the deletion of a few files in
sparc64 as they are no longer needed: Makefile + Kconfig.
arach/sparc64/ will after this patch is applied only
have four directories (prom, lib, kernel, boot)

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 Makefile                                           |    9 +-
 arch/sparc/Kconfig                                 |    7 ++
 arch/sparc/Makefile                                |   82 ++++++++++++++++---
 .../sparc/{defconfig => configs/sparc32_defconfig} |    0
 .../defconfig => sparc/configs/sparc64_defconfig}  |    0
 arch/sparc64/Kconfig                               |    1 -
 arch/sparc64/Makefile                              |   48 ------------
 7 files changed, 80 insertions(+), 67 deletions(-)
 rename arch/sparc/{defconfig => configs/sparc32_defconfig} (100%)
 rename arch/{sparc64/defconfig => sparc/configs/sparc64_defconfig} (100%)
 delete mode 100644 arch/sparc64/Kconfig
 delete mode 100644 arch/sparc64/Makefile

diff --git a/Makefile b/Makefile
index 7b1f238..0043224 100644
--- a/Makefile
+++ b/Makefile
@@ -205,12 +205,11 @@ ifeq ($(ARCH),x86_64)
         SRCARCH := x86
 endif
 
+# Additional ARCH settings for sparc
+       SRCARCH := sparc
+
 # Where to locate arch specific headers
-ifeq ($(ARCH),sparc64)
-       hdr-arch  := sparc
-else
-       hdr-arch  := $(SRCARCH)
-endif
+hdr-arch  := $(SRCARCH)
 
 KCONFIG_CONFIG	?= .config
 
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index e162535..26ddeed 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -41,6 +41,13 @@ config SPARC64
 	select RTC_DRV_SUN4V
 	select RTC_DRV_STARFIRE
 
+config ARCH_DEFCONFIG
+	string
+	default "arch/sparc/configs/sparc32_defconfig" if SPARC32
+	default "arch/sparc/configs/sparc64_defconfig" if SPARC64
+
+
+
 config 64BIT
 	def_bool y if SPARC64
 
diff --git a/arch/sparc/Makefile b/arch/sparc/Makefile
index e83ec16..dae2342 100644
--- a/arch/sparc/Makefile
+++ b/arch/sparc/Makefile
@@ -2,9 +2,21 @@
 # sparc/Makefile
 #
 # Makefile for the architecture dependent flags and dependencies on the
-# Sparc.
+# Sparc and sparc64.
 #
-# Copyright (C) 1994 David S. Miller (davem@caip.rutgers.edu)
+# Copyright (C) 1994,1996,1998 David S. Miller (davem@caip.rutgers.edu)
+# Copyright (C) 1998 Jakub Jelinek (jj@ultra.linux.cz)
+
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
 #
 
 #
@@ -26,10 +38,48 @@ CPPFLAGS_vmlinux.lds += -m32
 #  Actual linking is done with "make image".
 LDFLAGS_vmlinux = -r
 
-head-y := arch/sparc/kernel/head.o arch/sparc/kernel/init_task.o
+# Default target
+all: zImage
+
+
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
+KBUILD_CFLAGS += -m64 -pipe -mno-fpu -mcpu=ultrasparc -mcmodel=medlow   \
+                 -ffixed-g4 -ffixed-g5 -fcall-used-g7 -Wno-sign-compare \
+                 -Wa,--undeclared-regs
+KBUILD_CFLAGS += $(call cc-option,-mtune=ultrasparc3)
+KBUILD_AFLAGS += -m64 -mcpu=ultrasparc -Wa,--undeclared-regs
 
-core-y += arch/sparc/kernel/ arch/sparc/mm/ arch/sparc/math-emu/
-libs-y += arch/sparc/prom/ arch/sparc/lib/
+ifeq ($(CONFIG_MCOUNT),y)
+  KBUILD_CFLAGS += -pg
+endif
+
+endif
+
+head-$(CONFIG_SPARC32) := arch/sparc/kernel/head.o
+head-$(CONFIG_SPARC32) += arch/sparc/kernel/init_task.o
+head-$(CONFIG_SPARC64) := arch/sparc64/kernel/head.o
+head-$(CONFIG_SPARC64) += arch/sparc64/kernel/init_task.o
+
+core-$(CONFIG_SPARC32) += arch/sparc/kernel/
+core-$(CONFIG_SPARC64) += arch/sparc64/kernel/
+core-y                 += arch/sparc/mm/ arch/sparc/math-emu/
+
+libs-$(CONFIG_SPARC32) += arch/sparc/prom/
+libs-$(CONFIG_SPARC32) += arch/sparc/lib/
+libs-$(CONFIG_SPARC64) += arch/sparc64/prom/
+libs-$(CONFIG_SPARC64) += arch/sparc64/lib/
 
 drivers-$(CONFIG_OPROFILE)	+= arch/sparc/oprofile/
 
@@ -40,23 +90,29 @@ VMLINUX_MAIN := $(core-y) kernel/ mm/ fs/ ipc/ security/ crypto/ block/
 VMLINUX_MAIN += $(patsubst %/, %/lib.a, $(libs-y)) $(libs-y)
 VMLINUX_MAIN += $(drivers-y) $(net-y)
 
-# Default target
-all: zImage
-
-boot := arch/sparc/boot
+boot-y                 := arch/sparc/boot
+boot-$(CONFIG_SPARC64) := arch/sparc64/boot
 
-image zImage tftpboot.img: vmlinux
-	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
+image zImage tftpboot.img vmlinux.aout: vmlinux
+	$(Q)$(MAKE) $(build)=$(boot-y) $(boot-y)/$@
 
 archclean:
-	$(Q)$(MAKE) $(clean)=$(boot)
+	$(Q)$(MAKE) $(clean)=$(boot-y)
 
 # This is the image used for packaging
-KBUILD_IMAGE := $(boot)/zImage
+KBUILD_IMAGE := $(boot-y)/zImage
 
 # Don't use tabs in echo arguments.
+ifeq ($(ARCH),sparc)
 define archhelp
   echo  '* image        - kernel image ($(boot)/image)'
   echo  '* zImage       - stripped kernel image ($(boot)/zImage)'
   echo  '  tftpboot.img - image prepared for tftp'
 endef
+else
+define archhelp
+  echo  '* vmlinux       - Standard sparc64 kernel'
+  echo  '  vmlinux.aout  - a.out kernel for sparc64'
+  echo  '  tftpboot.img - image prepared for tftp'
+endef
+endif
diff --git a/arch/sparc/defconfig b/arch/sparc/configs/sparc32_defconfig
similarity index 100%
rename from arch/sparc/defconfig
rename to arch/sparc/configs/sparc32_defconfig
diff --git a/arch/sparc64/defconfig b/arch/sparc/configs/sparc64_defconfig
similarity index 100%
rename from arch/sparc64/defconfig
rename to arch/sparc/configs/sparc64_defconfig
diff --git a/arch/sparc64/Kconfig b/arch/sparc64/Kconfig
deleted file mode 100644
index caa9421..0000000
--- a/arch/sparc64/Kconfig
+++ /dev/null
@@ -1 +0,0 @@
-source arch/sparc/Kconfig
diff --git a/arch/sparc64/Makefile b/arch/sparc64/Makefile
deleted file mode 100644
index bfe0868..0000000
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
-libs-y				+= arch/sparc64/prom/ arch/sparc64/lib/
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
-- 
1.5.6.GIT


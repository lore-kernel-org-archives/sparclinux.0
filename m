From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 30 Nov 2008 20:15:32 +0000
Subject: [PATCH 5/5] sparc,sparc64: unify boot/
Message-Id: <1228076132-18036-5-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Simple unification:
o renamed piggyback to *_32.c/*_64.c
o copied content of Makefile from sparc64 to sparc and guard it
o updated sparc/boot/.gitignore
o deleted remaining files in sparc64/boot

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/Makefile                                |    9 ++---
 arch/sparc/boot/.gitignore                         |    3 ++
 arch/sparc/boot/Makefile                           |   33 ++++++++++++++++++--
 arch/sparc/boot/{piggyback.c => piggyback_32.c}    |    0
 .../boot/piggyback.c => sparc/boot/piggyback_64.c} |    0
 arch/sparc64/boot/.gitignore                       |    4 --
 arch/sparc64/boot/Makefile                         |   33 --------------------
 7 files changed, 37 insertions(+), 45 deletions(-)
 rename arch/sparc/boot/{piggyback.c => piggyback_32.c} (100%)
 rename arch/{sparc64/boot/piggyback.c => sparc/boot/piggyback_64.c} (100%)
 delete mode 100644 arch/sparc64/boot/.gitignore
 delete mode 100644 arch/sparc64/boot/Makefile

diff --git a/arch/sparc/Makefile b/arch/sparc/Makefile
index ee38f76..29161b8 100644
--- a/arch/sparc/Makefile
+++ b/arch/sparc/Makefile
@@ -85,17 +85,16 @@ VMLINUX_MAIN := $(core-y) kernel/ mm/ fs/ ipc/ security/ crypto/ block/
 VMLINUX_MAIN += $(patsubst %/, %/lib.a, $(libs-y)) $(libs-y)
 VMLINUX_MAIN += $(drivers-y) $(net-y)
 
-boot-y                 := arch/sparc/boot
-boot-$(CONFIG_SPARC64) := arch/sparc64/boot
+boot := arch/sparc/boot
 
 image zImage tftpboot.img vmlinux.aout: vmlinux
-	$(Q)$(MAKE) $(build)=$(boot-y) $(boot-y)/$@
+	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
 
 archclean:
-	$(Q)$(MAKE) $(clean)=$(boot-y)
+	$(Q)$(MAKE) $(clean)=$(boot)
 
 # This is the image used for packaging
-KBUILD_IMAGE := $(boot-y)/zImage
+KBUILD_IMAGE := $(boot)/zImage
 
 # Don't use tabs in echo arguments.
 ifeq ($(ARCH),sparc)
diff --git a/arch/sparc/boot/.gitignore b/arch/sparc/boot/.gitignore
index 8ffba57..fc6f398 100644
--- a/arch/sparc/boot/.gitignore
+++ b/arch/sparc/boot/.gitignore
@@ -2,4 +2,7 @@ btfix.S
 btfixupprep
 image
 zImage
+tftpboot.img
+vmlinux.aout
+piggyback
 
diff --git a/arch/sparc/boot/Makefile b/arch/sparc/boot/Makefile
index 74ba65b..07f1936 100644
--- a/arch/sparc/boot/Makefile
+++ b/arch/sparc/boot/Makefile
@@ -6,14 +6,16 @@
 ROOT_IMG	:= /usr/src/root.img
 ELFTOAOUT	:= elftoaout
 
-hostprogs-y	:= piggyback btfixupprep
-targets		:= tftpboot.img btfix.o btfix.S image zImage
+hostprogs-y	:= piggyback_32 piggyback_64 btfixupprep
+targets		:= tftpboot.img btfix.o btfix.S image zImage vmlinux.aout
 clean-files	:= System.map
 
 quiet_cmd_elftoaout	= ELFTOAOUT $@
       cmd_elftoaout	= $(ELFTOAOUT) $(obj)/image -o $@
+
+ifeq ($(CONFIG_SPARC32),y)
 quiet_cmd_piggy		= PIGGY   $@
-      cmd_piggy		= $(obj)/piggyback $@ $(obj)/System.map $(ROOT_IMG)
+      cmd_piggy		= $(obj)/piggyback_32 $@ $(obj)/System.map $(ROOT_IMG)
 quiet_cmd_btfix		= BTFIX   $@
       cmd_btfix		= $(OBJDUMP) -x vmlinux | $(obj)/btfixupprep > $@
 quiet_cmd_sysmap        = SYSMAP  $(obj)/System.map
@@ -62,3 +64,28 @@ $(obj)/tftpboot.img: $(obj)/piggyback $(obj)/System.map $(obj)/image FORCE
 
 $(obj)/btfix.S: $(obj)/btfixupprep vmlinux FORCE
 	$(call if_changed,btfix)
+
+endif
+
+ifeq ($(CONFIG_SPARC64),y)
+quiet_cmd_piggy     = PIGGY   $@
+      cmd_piggy     = $(obj)/piggyback_64 $@ System.map $(ROOT_IMG)
+quiet_cmd_strip     = STRIP   $@
+      cmd_strip     = $(STRIP) -R .comment -R .note -K sun4u_init -K _end -K _start vmlinux -o $@
+
+
+# Actual linking
+$(obj)/image: vmlinux FORCE
+        $(call if_changed,strip)
+        @echo '  kernel: $@ is ready'
+
+$(obj)/tftpboot.img: vmlinux $(obj)/piggyback_64 System.map $(ROOT_IMG) FORCE
+        $(call if_changed,elftoaout)
+        $(call if_changed,piggy)
+        @echo '  kernel: $@ is ready'
+
+$(obj)/vmlinux.aout: vmlinux FORCE
+        $(call if_changed,elftoaout)
+        @echo '  kernel: $@ is ready'
+endif
+
diff --git a/arch/sparc/boot/piggyback.c b/arch/sparc/boot/piggyback_32.c
similarity index 100%
rename from arch/sparc/boot/piggyback.c
rename to arch/sparc/boot/piggyback_32.c
diff --git a/arch/sparc64/boot/piggyback.c b/arch/sparc/boot/piggyback_64.c
similarity index 100%
rename from arch/sparc64/boot/piggyback.c
rename to arch/sparc/boot/piggyback_64.c
diff --git a/arch/sparc64/boot/.gitignore b/arch/sparc64/boot/.gitignore
deleted file mode 100644
index 36356f9..0000000
--- a/arch/sparc64/boot/.gitignore
+++ /dev/null
@@ -1,4 +0,0 @@
-image
-tftpboot.img
-vmlinux.aout
-piggyback
diff --git a/arch/sparc64/boot/Makefile b/arch/sparc64/boot/Makefile
deleted file mode 100644
index 0458b52..0000000
--- a/arch/sparc64/boot/Makefile
+++ /dev/null
@@ -1,33 +0,0 @@
-# Makefile for the Sparc64 boot stuff.
-#
-# Copyright (C) 1995 David S. Miller (davem@caip.rutgers.edu)
-# Copyright (C) 1997 Jakub Jelinek (jj@sunsite.mff.cuni.cz)
-
-ROOT_IMG	:= /usr/src/root.img
-ELFTOAOUT	:= elftoaout
-
-hostprogs-y	:= piggyback
-targets		:= image tftpboot.img vmlinux.aout
-
-quiet_cmd_elftoaout = ELF2AOUT $@
-      cmd_elftoaout = $(ELFTOAOUT) vmlinux -o $@
-quiet_cmd_piggy     = PIGGY   $@
-      cmd_piggy     = $(obj)/piggyback $@ System.map $(ROOT_IMG)
-quiet_cmd_strip     = STRIP   $@
-      cmd_strip     = $(STRIP) -R .comment -R .note -K sun4u_init -K _end -K _start vmlinux -o $@
-
-
-# Actual linking
-$(obj)/image: vmlinux FORCE
-	$(call if_changed,strip)
-	@echo '  kernel: $@ is ready'
-
-$(obj)/tftpboot.img: vmlinux $(obj)/piggyback System.map $(ROOT_IMG) FORCE
-	$(call if_changed,elftoaout)
-	$(call if_changed,piggy)
-	@echo '  kernel: $@ is ready'
-
-$(obj)/vmlinux.aout: vmlinux FORCE
-	$(call if_changed,elftoaout)
-	@echo '  kernel: $@ is ready'
-
-- 
1.5.6.GIT


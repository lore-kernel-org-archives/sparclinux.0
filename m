From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Thu, 07 Aug 2008 21:54:20 +0000
Subject: [PATCH] sparc: Add target for a stripped kernel
Message-Id: <20080807215420.GA18752@palantir8>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Add a target for a stripped kernel. This is used for the various
packaging targets (*-pkg).

Martin

	Signed-off-by: Martin Habets <errandir_news@mph.eclipse.co.uk>

Index: 2.6/arch/sparc/Makefile
=================================--- 2.6.orig/arch/sparc/Makefile	2008-08-07 00:05:00.000000000 +0100
+++ 2.6/arch/sparc/Makefile	2008-08-07 01:24:55.000000000 +0100
@@ -51,20 +51,24 @@
 export INIT_Y CORE_Y DRIVERS_Y NET_Y LIBS_Y HEAD_Y kallsyms.o
 
 # Default target
-all: image
+all: zImage
 
 boot := arch/sparc/boot
 
-image tftpboot.img: vmlinux
+image zImage tftpboot.img: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
 
 archclean:
 	$(Q)$(MAKE) $(clean)=$(boot)
 
+# This is the image used for packaging
+KBUILD_IMAGE := $(boot)/zImage
+
 CLEAN_FILES += arch/$(ARCH)/boot/System.map
 
 # Don't use tabs in echo arguments.
 define archhelp
   echo  '* image        - kernel image ($(boot)/image)'
+  echo  '* zImage       - stripped kernel image ($(boot)/zImage)'
   echo  '  tftpboot.img - image prepared for tftp'
 endef
Index: 2.6/arch/sparc/boot/Makefile
=================================--- 2.6.orig/arch/sparc/boot/Makefile	2008-08-07 00:00:44.000000000 +0100
+++ 2.6/arch/sparc/boot/Makefile	2008-08-07 01:32:21.000000000 +0100
@@ -19,6 +19,9 @@
       cmd_sysmap        = $(CONFIG_SHELL) $(srctree)/scripts/mksysmap
 quiet_cmd_image = LD      $@
       cmd_image = $(LD) $(LDFLAGS) $(EXTRA_LDFLAGS) $(LDFLAGS_$(@F)) -o $@
+quiet_cmd_strip = STRIP   $@
+      cmd_strip = $(STRIP) -R .comment -R .note -K sun4u_init -K _end -K _start $(obj)/image -o $@
+
 
 define rule_image
 	$(if $($(quiet)cmd_image),               \
@@ -49,6 +52,9 @@
 $(obj)/image: $(obj)/btfix.o FORCE
 	$(call if_changed_rule,image)
 
+$(obj)/zImage: $(obj)/image
+	$(call if_changed,strip)
+
 $(obj)/tftpboot.img: $(obj)/piggyback $(obj)/System.map $(obj)/image FORCE
 	$(call if_changed,elftoaout)
 	$(call if_changed,piggy)

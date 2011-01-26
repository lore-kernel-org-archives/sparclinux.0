From: Daniel Hellstrom <daniel@gaisler.com>
Date: Wed, 26 Jan 2011 16:36:35 +0000
Subject: [PATCH v3] SPARC: added U-Boot build target: uImage
Message-Id: <1296059795-22807-1-git-send-email-daniel@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This is only for LEON as u-boot for SPARC only supports LEON.

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
---
 arch/sparc/Kconfig       |   33 +++++++++++++++++++++++++++++++++
 arch/sparc/Makefile      |    3 ++-
 arch/sparc/boot/Makefile |   31 +++++++++++++++++++++++++++++++
 3 files changed, 66 insertions(+), 1 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 13d2b67..e48f471 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -461,6 +461,39 @@ config SPARC_LEON
 	  from www.gaisler.com. You can download a sparc-linux cross-compilation
 	  toolchain at www.gaisler.com.
 
+if SPARC_LEON
+menu "U-Boot options"
+
+config UBOOT_LOAD_ADDR
+	hex "uImage Load Address"
+	default 0x40004000
+	---help---
+	 U-Boot kernel load address, the address in physical address space
+	 where u-boot will place the Linux kernel before booting it.
+	 This address is normally the base address of main memory + 0x4000.
+
+config UBOOT_FLASH_ADDR
+	hex "uImage.o Load Address"
+	default 0x00080000
+	---help---
+	 Optional setting only affecting the uImage.o ELF-image used to
+	 download the uImage file to the target using a ELF-loader other than
+	 U-Boot. It may for example be used to download an uImage to FLASH with
+	 the GRMON utility before even starting u-boot.
+
+config UBOOT_ENTRY_ADDR
+	hex "uImage Entry Address"
+	default 0xf0004000
+	---help---
+	 Do not change this unless you know what you're doing. This is
+	 hardcoded by the SPARC32 and LEON port.
+
+	 This is the virtual address u-boot jumps to when booting the Linux
+	 Kernel.
+
+endmenu
+endif
+
 endmenu
 
 menu "Bus options (PCI etc.)"
diff --git a/arch/sparc/Makefile b/arch/sparc/Makefile
index 113225b..ad1fb5d 100644
--- a/arch/sparc/Makefile
+++ b/arch/sparc/Makefile
@@ -88,7 +88,7 @@ boot := arch/sparc/boot
 # Default target
 all: zImage
 
-image zImage tftpboot.img vmlinux.aout: vmlinux
+image zImage uImage tftpboot.img vmlinux.aout: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
 
 archclean:
@@ -102,6 +102,7 @@ ifeq ($(ARCH),sparc)
 define archhelp
   echo  '* image        - kernel image ($(boot)/image)'
   echo  '* zImage       - stripped kernel image ($(boot)/zImage)'
+  echo  '  uImage       - U-Boot SPARC32 Image (only for LEON)'
   echo  '  tftpboot.img - image prepared for tftp'
 endef
 else
diff --git a/arch/sparc/boot/Makefile b/arch/sparc/boot/Makefile
index a2c5898..9205416 100644
--- a/arch/sparc/boot/Makefile
+++ b/arch/sparc/boot/Makefile
@@ -5,6 +5,7 @@
 
 ROOT_IMG	:= /usr/src/root.img
 ELFTOAOUT	:= elftoaout
+MKIMAGE 	:= $(srctree)/scripts/mkuboot.sh
 
 hostprogs-y	:= piggyback btfixupprep
 targets		:= tftpboot.img btfix.o btfix.S image zImage vmlinux.aout
@@ -77,6 +78,36 @@ $(obj)/zImage: $(obj)/image
 $(obj)/vmlinux.aout: vmlinux FORCE
 	$(call if_changed,elftoaout)
 	@echo '  kernel: $@ is ready'
+else
+
+# The following lines make a readable image for U-Boot.
+#  uImage   - Binary file read by U-boot
+#  uImage.o - object file of uImage for loading with a
+#             flash programmer understanding ELF.
+
+OBJCOPYFLAGS_image.bin := -S -O binary -R .note -R .comment
+$(obj)/image.bin: $(obj)/image FORCE
+	$(call if_changed,objcopy)
+
+$(obj)/image.gz: $(obj)/image.bin
+	$(call if_changed,gzip)
+
+quiet_cmd_uimage = UIMAGE  $@
+      cmd_uimage = $(CONFIG_SHELL) $(MKIMAGE) -A sparc -O linux -T kernel \
+               -C gzip -a $(CONFIG_UBOOT_LOAD_ADDR) \
+	       -e $(CONFIG_UBOOT_ENTRY_ADDR) -n 'Linux-$(KERNELRELEASE)' \
+               -d $< $@
+
+quiet_cmd_uimage.o = UIMAGE.O $@
+      cmd_uimage.o = $(LD) -Tdata $(CONFIG_UBOOT_FLASH_ADDR) \
+                     -r -b binary $@ -o $@.o
+
+targets += uImage
+$(obj)/uImage: $(obj)/image.gz
+	$(call if_changed,uimage)
+	$(call if_changed,uimage.o)
+	@echo '  Image $@ is ready'
+
 endif
 
 $(obj)/tftpboot.img: $(obj)/image $(obj)/piggyback System.map $(ROOT_IMG) FORCE
-- 
1.5.4


From: David L Stevens <david.stevens@oracle.com>
Date: Fri, 25 Jul 2014 17:41:51 +0000
Subject: [PATCH] sparc: Add "install" target
Message-Id: <1406310111.20183.2.camel@phoenix>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org



This patches adds an "install" target to install kernel builds for SPARC,
modeled after the i386 script.

Signed-off-by: David L Stevens <david.stevens@oracle.com>
---
 arch/sparc/Makefile        |    3 ++
 arch/sparc/boot/Makefile   |    4 +++
 arch/sparc/boot/install.sh |   51 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+), 0 deletions(-)
 create mode 100644 arch/sparc/boot/install.sh

diff --git a/arch/sparc/Makefile b/arch/sparc/Makefile
index 9ff4236..eaee146 100644
--- a/arch/sparc/Makefile
+++ b/arch/sparc/Makefile
@@ -68,6 +68,9 @@ all: zImage
 image zImage uImage tftpboot.img vmlinux.aout: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
 
+install:
+	$(Q)$(MAKE) $(build)=$(boot) $@
+
 archclean:
 	$(Q)$(MAKE) $(clean)=$(boot)
 
diff --git a/arch/sparc/boot/Makefile b/arch/sparc/boot/Makefile
index 6e63afb..6a4ceae 100644
--- a/arch/sparc/boot/Makefile
+++ b/arch/sparc/boot/Makefile
@@ -69,3 +69,7 @@ $(obj)/image: vmlinux FORCE
 $(obj)/tftpboot.img: $(obj)/image $(obj)/piggyback System.map $(ROOT_IMG) FORCE
 	$(call if_changed,elftoaout)
 	$(call if_changed,piggy)
+
+install:
+	sh $(srctree)/$(src)/install.sh $(KERNELRELEASE) $(obj)/zImage \
+		System.map "$(INSTALL_PATH)"
diff --git a/arch/sparc/boot/install.sh b/arch/sparc/boot/install.sh
new file mode 100644
index 0000000..098d518
--- /dev/null
+++ b/arch/sparc/boot/install.sh
@@ -0,0 +1,51 @@
+#!/bin/sh
+#
+# This file is subject to the terms and conditions of the GNU General Public
+# License.  See the file "COPYING" in the main directory of this archive
+# for more details.
+#
+# Copyright (C) 1995 by Linus Torvalds
+#
+# Adapted from code in arch/i386/boot/Makefile by H. Peter Anvin
+#
+# "make install" script for SPARC architecture
+#
+# Arguments:
+#   $1 - kernel version
+#   $2 - kernel image file
+#   $3 - kernel map file
+#   $4 - default install path (blank if root directory)
+#
+
+verify () {
+	if [ ! -f "$1" ]; then
+		echo ""                                                   1>&2
+		echo " *** Missing file: $1"                              1>&2
+		echo ' *** You need to run "make" before "make install".' 1>&2
+		echo ""                                                   1>&2
+		exit 1
+ 	fi
+}
+
+# Make sure the files actually exist
+verify "$2"
+verify "$3"
+
+# User may have a custom install script
+
+if [ -x ~/bin/${INSTALLKERNEL} ]; then exec ~/bin/${INSTALLKERNEL} "$@"; fi
+if [ -x /sbin/${INSTALLKERNEL} ]; then exec /sbin/${INSTALLKERNEL} "$@"; fi
+
+# Default install - same as make zlilo
+
+if [ -f $4/vmlinuz ]; then
+	mv $4/vmlinuz $4/vmlinuz.old
+fi
+
+if [ -f $4/System.map ]; then
+	mv $4/System.map $4/System.old
+fi
+
+cat $2 > $4/vmlinuz
+cp $3 $4/System.map
+
-- 
1.7.1




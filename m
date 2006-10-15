From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Sun, 15 Oct 2006 21:25:46 +0000
Subject: [PATCH] Add sparc profiling support
Message-Id: <20061015212546.GA4960@palantir8>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This patch adds profiling support to the sparc architecture. It is a copy of the
sparc64 implementation.

Martin

	 Signed-off-by: Martin Habets <errandir_news@mph.eclipse.co.uk>
---
--- /dev/null	2005-04-11 20:54:07.000000000 +0100
+++ 2.6.19-rc1-oprof/arch/sparc/oprofile/Kconfig	2006-10-06 00:36:47.000000000 +0100
@@ -0,0 +1,17 @@
+config PROFILING
+	bool "Profiling support (EXPERIMENTAL)"
+	help
+	  Say Y here to enable the extended profiling support mechanisms used
+	  by profilers such as OProfile.
+	  
+
+config OPROFILE
+	tristate "OProfile system profiling (EXPERIMENTAL)"
+	depends on PROFILING
+	help
+	  OProfile is a profiling system capable of profiling the
+	  whole system, include the kernel, kernel modules, libraries,
+	  and applications.
+
+	  If unsure, say N.
+
--- /dev/null	2005-04-11 20:54:07.000000000 +0100
+++ 2.6.19-rc1-oprof/arch/sparc/oprofile/Makefile	2006-10-06 00:36:47.000000000 +0100
@@ -0,0 +1,9 @@
+obj-$(CONFIG_OPROFILE) += oprofile.o
+
+DRIVER_OBJS = $(addprefix ../../../drivers/oprofile/, \
+		oprof.o cpu_buffer.o buffer_sync.o \
+		event_buffer.o oprofile_files.o \
+		oprofilefs.o oprofile_stats.o \
+		timer_int.o )
+
+oprofile-y				:= $(DRIVER_OBJS) init.o
--- /dev/null	2005-04-11 20:54:07.000000000 +0100
+++ 2.6.19-rc1-oprof/arch/sparc/oprofile/init.c	2006-10-06 00:36:47.000000000 +0100
@@ -0,0 +1,23 @@
+/**
+ * @file init.c
+ *
+ * @remark Copyright 2002 OProfile authors
+ * @remark Read the file COPYING
+ *
+ * @author John Levon <levon@movementarian.org>
+ */
+
+#include <linux/kernel.h>
+#include <linux/oprofile.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+ 
+int __init oprofile_arch_init(struct oprofile_operations * ops)
+{
+	return -ENODEV;
+}
+
+
+void oprofile_arch_exit(void)
+{
+}
--- 2.6.19-rc1-oprof/arch/sparc/Kconfig.orig	2006-10-06 00:41:17.000000000 +0100
+++ 2.6.19-rc1-oprof/arch/sparc/Kconfig	2006-10-06 00:42:21.000000000 +0100
@@ -289,6 +289,13 @@
 
 source "fs/Kconfig"
 
+menu "Instrumentation Support"
+	depends on EXPERIMENTAL
+
+source "arch/sparc/oprofile/Kconfig"
+
+endmenu
+
 source "arch/sparc/Kconfig.debug"
 
 source "security/Kconfig"
--- 2.6.19-rc1-oprof/arch/sparc/Makefile.orig	2006-10-06 00:44:02.000000000 +0100
+++ 2.6.19-rc1-oprof/arch/sparc/Makefile	2006-10-06 00:45:25.000000000 +0100
@@ -30,6 +30,8 @@
 core-y += arch/sparc/kernel/ arch/sparc/mm/ arch/sparc/math-emu/
 libs-y += arch/sparc/prom/ arch/sparc/lib/
 
+drivers-$(CONFIG_OPROFILE)	+= arch/sparc/oprofile/
+
 # Export what is needed by arch/sparc/boot/Makefile
 # Renaming is done to avoid confusing pattern matching rules in 2.5.45 (multy-)
 INIT_Y		:= $(patsubst %/, %/built-in.o, $(init-y))
--- 2.6.19-rc1-oprof/arch/sparc/kernel/time.c.orig	2006-10-06 02:53:06.000000000 +0100
+++ 2.6.19-rc1-oprof/arch/sparc/kernel/time.c	2006-10-06 20:53:19.000000000 +0100
@@ -94,6 +94,8 @@
 	return pc;
 }
 
+EXPORT_SYMBOL(profile_pc);
+
 __volatile__ unsigned int *master_l10_counter;
 __volatile__ unsigned int *master_l10_limit;
 

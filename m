From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 15 Nov 2008 21:34:28 +0000
Subject: [PATCH 1/8] sparc: unify Kconfig.debug
Message-Id: <1226784875-8829-1-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Let sparc and sparc64 use the same Kconfig.debug

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/Kconfig.debug   |   26 ++++++++++++++++++++++++++
 arch/sparc64/Kconfig       |    2 +-
 arch/sparc64/Kconfig.debug |   44 --------------------------------------------
 3 files changed, 27 insertions(+), 45 deletions(-)
 delete mode 100644 arch/sparc64/Kconfig.debug

diff --git a/arch/sparc/Kconfig.debug b/arch/sparc/Kconfig.debug
index 87dd496..b8a15e2 100644
--- a/arch/sparc/Kconfig.debug
+++ b/arch/sparc/Kconfig.debug
@@ -15,4 +15,30 @@ config DEBUG_STACK_USAGE
 
 	  This option will slow down process creation somewhat.
 
+config DEBUG_DCFLUSH
+	bool "D-cache flush debugging"
+	depends on SPARC64 && DEBUG_KERNEL
+
+config STACK_DEBUG
+	bool "Stack Overflow Detection Support"
+
+config DEBUG_PAGEALLOC
+	bool "Debug page memory allocations"
+	depends on SPARC64 && DEBUG_KERNEL && !HIBERNATION
+	help
+	  Unmap pages from the kernel linear mapping after free_pages().
+	  This results in a large slowdown, but helps to find certain types
+	  of memory corruptions.
+
+config MCOUNT
+	bool
+	depends on SPARC64
+	depends on STACK_DEBUG || FUNCTION_TRACER
+	default y
+
+config FRAME_POINTER
+	bool
+	depends on MCOUNT
+	default y
+
 endmenu
diff --git a/arch/sparc64/Kconfig b/arch/sparc64/Kconfig
index 3b96e70..422c2b1 100644
--- a/arch/sparc64/Kconfig
+++ b/arch/sparc64/Kconfig
@@ -424,7 +424,7 @@ source "drivers/sbus/char/Kconfig"
 
 source "fs/Kconfig"
 
-source "arch/sparc64/Kconfig.debug"
+source "arch/sparc/Kconfig.debug"
 
 source "security/Kconfig"
 
diff --git a/arch/sparc64/Kconfig.debug b/arch/sparc64/Kconfig.debug
deleted file mode 100644
index c40515c..0000000
--- a/arch/sparc64/Kconfig.debug
+++ /dev/null
@@ -1,44 +0,0 @@
-menu "Kernel hacking"
-
-config TRACE_IRQFLAGS_SUPPORT
-	bool
-	default y
-
-source "lib/Kconfig.debug"
-
-config DEBUG_STACK_USAGE
-	bool "Enable stack utilization instrumentation"
-	depends on DEBUG_KERNEL
-	help
-	  Enables the display of the minimum amount of free stack which each
-	  task has ever had available in the sysrq-T and sysrq-P debug output.
-
-	  This option will slow down process creation somewhat.
-
-config DEBUG_DCFLUSH
-	bool "D-cache flush debugging"
-	depends on DEBUG_KERNEL
-
-config STACK_DEBUG
-	depends on DEBUG_KERNEL
-	bool "Stack Overflow Detection Support"
-
-config DEBUG_PAGEALLOC
-	bool "Debug page memory allocations"
-	depends on DEBUG_KERNEL && !HIBERNATION
-	help
-	  Unmap pages from the kernel linear mapping after free_pages().
-	  This results in a large slowdown, but helps to find certain types
-	  of memory corruptions.
-
-config MCOUNT
-	bool
-	depends on STACK_DEBUG || FUNCTION_TRACER
-	default y
-
-config FRAME_POINTER
-	bool
-	depends on MCOUNT
-	default y
-
-endmenu
-- 
1.5.6.GIT


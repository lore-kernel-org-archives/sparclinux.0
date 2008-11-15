From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 15 Nov 2008 21:34:30 +0000
Subject: [PATCH 3/8] sparc64: added more config options to the menus
Message-Id: <1226784875-8829-3-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

moved a few config entries inside a menu so we
do not clutter the first screen up with a lot of detailed
config options.
The structure now remotely resemble the structure for i386

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc64/Kconfig |   80 ++++++++++++++++++++++++++-----------------------
 1 files changed, 42 insertions(+), 38 deletions(-)

diff --git a/arch/sparc64/Kconfig b/arch/sparc64/Kconfig
index 422c2b1..4263e5e 100644
--- a/arch/sparc64/Kconfig
+++ b/arch/sparc64/Kconfig
@@ -250,8 +250,6 @@ config HUGETLB_PAGE_SIZE_64K
 
 endchoice
 
-endmenu
-
 config NUMA
 	bool "NUMA support"
 	depends on SMP
@@ -285,6 +283,46 @@ config ARCH_SPARSEMEM_DEFAULT
 
 source "mm/Kconfig"
 
+config SCHED_SMT
+	bool "SMT (Hyperthreading) scheduler support"
+	depends on SMP
+	default y
+	help
+	  SMT scheduler support improves the CPU scheduler's decision making
+	  when dealing with SPARC cpus at a cost of slightly increased overhead
+	  in some places. If unsure say N here.
+
+config SCHED_MC
+	bool "Multi-core scheduler support"
+	depends on SMP
+	default y
+	help
+	  Multi-core scheduler support improves the CPU scheduler's decision
+	  making when dealing with multi-core CPU chips at a cost of slightly
+	  increased overhead in some places. If unsure say N here.
+
+source "kernel/Kconfig.preempt"
+
+config CMDLINE_BOOL
+	bool "Default bootloader kernel arguments"
+
+config CMDLINE
+	string "Initial kernel command string"
+	depends on CMDLINE_BOOL
+	default "console=ttyS0,9600 root=/dev/sda1"
+	help
+	  Say Y here if you want to be able to pass default arguments to
+	  the kernel. This will be overridden by the bootloader, if you
+	  use one (such as SILO). This is most useful if you want to boot
+	  a kernel from TFTP, and want default options to be available
+	  with having them passed on the command line.
+
+	  NOTE: This option WILL override the PROM bootargs setting!
+
+endmenu
+
+menu "Bus options (PCI etc.)"
+
 config ISA
 	bool
 
@@ -364,6 +402,8 @@ config SUN_OPENPROMFS
 	  To compile the /proc/openprom support as a module, choose M here: the
 	  module will be called openpromfs.  If unsure, choose M.
 
+endmenu
+
 menu "Executable file formats"
 
 source "fs/Kconfig.binfmt"
@@ -380,42 +420,6 @@ config SYSVIPC_COMPAT
 
 endmenu
 
-config SCHED_SMT
-	bool "SMT (Hyperthreading) scheduler support"
-	depends on SMP
-	default y
-	help
-	  SMT scheduler support improves the CPU scheduler's decision making
-	  when dealing with SPARC cpus at a cost of slightly increased overhead
-	  in some places. If unsure say N here.
-
-config SCHED_MC
-	bool "Multi-core scheduler support"
-	depends on SMP
-	default y
-	help
-	  Multi-core scheduler support improves the CPU scheduler's decision
-	  making when dealing with multi-core CPU chips at a cost of slightly
-	  increased overhead in some places. If unsure say N here.
-
-source "kernel/Kconfig.preempt"
-
-config CMDLINE_BOOL
-	bool "Default bootloader kernel arguments"
-
-config CMDLINE
-	string "Initial kernel command string"
-	depends on CMDLINE_BOOL
-	default "console=ttyS0,9600 root=/dev/sda1"
-	help
-	  Say Y here if you want to be able to pass default arguments to
-	  the kernel. This will be overridden by the bootloader, if you
-	  use one (such as SILO). This is most useful if you want to boot
-	  a kernel from TFTP, and want default options to be available
-	  with having them passed on the command line.
-
-	  NOTE: This option WILL override the PROM bootargs setting!
-
 source "net/Kconfig"
 
 source "drivers/Kconfig"
-- 
1.5.6.GIT


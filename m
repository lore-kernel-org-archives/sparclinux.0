From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 30 Mar 2013 21:44:26 +0000
Subject: [PATCH 5/5] sparc: sort select lines in Kconfig
Message-Id: <1364679866-29982-5-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Sorting the lines is better than the random order used today.
And it may result in a less merge confilct (in theory).

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/Kconfig |   78 ++++++++++++++++++++++++++--------------------------
 1 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 3d361f2..8a803de 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -12,72 +12,72 @@ config 64BIT
 config SPARC
 	bool
 	default y
-	select OF
-	select OF_PROMTREE
-	select HAVE_IDE
-	select HAVE_OPROFILE
-	select HAVE_ARCH_KGDB if !SMP || SPARC64
-	select HAVE_ARCH_TRACEHOOK
-	select SYSCTL_EXCEPTION_TRACE
-	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
-	select RTC_CLASS
-	select RTC_DRV_M48T59
-	select HAVE_DMA_ATTRS
-	select HAVE_DMA_API_DEBUG
-	select HAVE_ARCH_JUMP_LABEL
-	select HAVE_GENERIC_HARDIRQS
-	select GENERIC_IRQ_SHOW
 	select ARCH_WANT_IPC_PARSE_VERSION
-	select USE_GENERIC_SMP_HELPERS if SMP
+	select ARCH_WANT_OPTIONAL_GPIOLIB
+	select GENERIC_CLOCKEVENTS
+	select GENERIC_CMOS_UPDATE
+	select GENERIC_IRQ_SHOW
 	select GENERIC_PCI_IOMAP
-	select HAVE_NMI_WATCHDOG if SPARC64
-	select HAVE_BPF_JIT
-	select HAVE_DEBUG_BUGVERBOSE
 	select GENERIC_SMP_IDLE_THREAD
-	select GENERIC_CMOS_UPDATE
-	select GENERIC_CLOCKEVENTS
 	select GENERIC_STRNCPY_FROM_USER
 	select GENERIC_STRNLEN_USER
+	select HAVE_ARCH_JUMP_LABEL
+	select HAVE_ARCH_KGDB if !SMP || SPARC64
+	select HAVE_ARCH_TRACEHOOK
+	select HAVE_BPF_JIT
+	select HAVE_DEBUG_BUGVERBOSE
+	select HAVE_DMA_API_DEBUG
+	select HAVE_DMA_ATTRS
+	select HAVE_GENERIC_HARDIRQS
+	select HAVE_IDE
+	select HAVE_NMI_WATCHDOG if SPARC64
+	select HAVE_OPROFILE
 	select MODULES_USE_ELF_RELA
 	select ODD_RT_SIGACTION
+	select OF
+	select OF_PROMTREE
 	select OLD_SIGSUSPEND
+	select RTC_CLASS
+	select RTC_DRV_M48T59
+	select SYSCTL_EXCEPTION_TRACE
+	select USE_GENERIC_SMP_HELPERS if SMP
 
 config SPARC32
 	def_bool !64BIT
-	select GENERIC_ATOMIC64
 	select CLZ_TAB
+	select GENERIC_ATOMIC64
 	select HAVE_UID16
 	select OLD_SIGACTION
 
 config SPARC64
 	def_bool 64BIT
+	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select ARCH_SUPPORTS_MSI
-	select HAVE_FUNCTION_TRACER
-	select HAVE_FUNCTION_GRAPH_TRACER
+	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
+	select HAVE_C_RECORDMCOUNT
+	select HAVE_DEBUG_KMEMLEAK
+	select HAVE_DYNAMIC_FTRACE
+	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_GRAPH_FP_TEST
+	select HAVE_FUNCTION_GRAPH_TRACER
+	select HAVE_FUNCTION_TRACER
 	select HAVE_FUNCTION_TRACE_MCOUNT_TEST
-	select HAVE_KRETPROBES
 	select HAVE_KPROBES
-	select HAVE_RCU_TABLE_FREE if SMP
+	select HAVE_KRETPROBES
 	select HAVE_MEMBLOCK
 	select HAVE_MEMBLOCK_NODE_MAP
-	select HAVE_SYSCALL_WRAPPERS
-	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
-	select HAVE_DYNAMIC_FTRACE
-	select HAVE_FTRACE_MCOUNT_RECORD
-	select HAVE_SYSCALL_TRACEPOINTS
-	select HAVE_DEBUG_KMEMLEAK
-	select RTC_DRV_CMOS
-	select RTC_DRV_BQ4802
-	select RTC_DRV_SUN4V
-	select RTC_DRV_STARFIRE
 	select HAVE_PERF_EVENTS
-	select PERF_USE_VMALLOC
+	select HAVE_RCU_TABLE_FREE if SMP
+	select HAVE_SYSCALL_TRACEPOINTS
+	select HAVE_SYSCALL_WRAPPERS
 	select IRQ_PREFLOW_FASTEOI
-	select ARCH_HAVE_NMI_SAFE_CMPXCHG
-	select HAVE_C_RECORDMCOUNT
 	select NO_BOOTMEM
+	select PERF_USE_VMALLOC
+	select RTC_DRV_BQ4802
+	select RTC_DRV_CMOS
+	select RTC_DRV_STARFIRE
+	select RTC_DRV_SUN4V
 
 config ARCH_DEFCONFIG
 	string
-- 
1.6.0.6


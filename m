From: Christoph Hellwig <hch@lst.de>
Date: Fri, 27 Apr 2018 15:53:42 +0000
Subject: [PATCH 4/3] dma-debug: remove CONFIG_HAVE_DMA_API_DEBUG
Message-Id: <20180427155342.GA9232@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20180424140235.9125-1-hch@lst.de>
In-Reply-To: <20180424140235.9125-1-hch-jcswGhMUV9g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org, Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>, linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-c6x-dev-jPsnJVOj+W6hPH1hqNUYSQ@public.gmane.org, linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hexagon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-m68k-cunTk1MwBs8S/qaLPR03pWD2FQJk+8+b@public.gmane.org, openrisc-cunTk1MwBs9a3B2Vnqf2dGD2FQJk+8+b@public.gmane.org, Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-alpha-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nios2-dev-g9ZBwUv/Ih/yUk5EbOjzuce+I+R0W71w@public.gmane.org, Vincent Chen <deanbo422-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org

There is no arch specific code required for dma-debug, so there is no
need to opt into the support either.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 .../io/dma-api-debug/arch-support.txt         | 31 -------------------
 arch/Kconfig                                  |  3 --
 arch/arm/Kconfig                              |  1 -
 arch/arm64/Kconfig                            |  1 -
 arch/c6x/Kconfig                              |  1 -
 arch/ia64/Kconfig                             |  1 -
 arch/microblaze/Kconfig                       |  1 -
 arch/mips/Kconfig                             |  1 -
 arch/powerpc/Kconfig                          |  1 -
 arch/riscv/Kconfig                            |  1 -
 arch/s390/Kconfig                             |  1 -
 arch/sh/Kconfig                               |  1 -
 arch/sparc/Kconfig                            |  1 -
 arch/x86/Kconfig                              |  1 -
 arch/xtensa/Kconfig                           |  1 -
 lib/Kconfig.debug                             |  1 -
 16 files changed, 48 deletions(-)
 delete mode 100644 Documentation/features/io/dma-api-debug/arch-support.txt

diff --git a/Documentation/features/io/dma-api-debug/arch-support.txt b/Documentation/features/io/dma-api-debug/arch-support.txt
deleted file mode 100644
index e438ed675623..000000000000
--- a/Documentation/features/io/dma-api-debug/arch-support.txt
+++ /dev/null
@@ -1,31 +0,0 @@
-#
-# Feature name:          dma-api-debug
-#         Kconfig:       HAVE_DMA_API_DEBUG
-#         description:   arch supports DMA debug facilities
-#
-    -----------------------
-    |         arch |status|
-    -----------------------
-    |       alpha: | TODO |
-    |         arc: | TODO |
-    |         arm: |  ok  |
-    |       arm64: |  ok  |
-    |         c6x: |  ok  |
-    |       h8300: | TODO |
-    |     hexagon: | TODO |
-    |        ia64: |  ok  |
-    |        m68k: | TODO |
-    |  microblaze: |  ok  |
-    |        mips: |  ok  |
-    |       nios2: | TODO |
-    |    openrisc: | TODO |
-    |      parisc: | TODO |
-    |     powerpc: |  ok  |
-    |        s390: |  ok  |
-    |          sh: |  ok  |
-    |       sparc: |  ok  |
-    |          um: | TODO |
-    |   unicore32: | TODO |
-    |         x86: |  ok  |
-    |      xtensa: |  ok  |
-    -----------------------
diff --git a/arch/Kconfig b/arch/Kconfig
index 8e0d665c8d53..f07a1a99e5db 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -278,9 +278,6 @@ config HAVE_CLK
 	  The <linux/clk.h> calls support software clock gating and
 	  thus are a key power management tool on many systems.
 
-config HAVE_DMA_API_DEBUG
-	bool
-
 config HAVE_HW_BREAKPOINT
 	bool
 	depends on PERF_EVENTS
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 676977bdfe33..c43f5bb55ac8 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -60,7 +60,6 @@ config ARM
 	select HAVE_CONTEXT_TRACKING
 	select HAVE_C_RECORDMCOUNT
 	select HAVE_DEBUG_KMEMLEAK
-	select HAVE_DMA_API_DEBUG
 	select HAVE_DMA_CONTIGUOUS if MMU
 	select HAVE_DYNAMIC_FTRACE if (!XIP_KERNEL) && !CPU_ENDIAN_BE32 && MMU
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index db51b6445744..b25ed7834f6c 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -105,7 +105,6 @@ config ARM64
 	select HAVE_CONTEXT_TRACKING
 	select HAVE_DEBUG_BUGVERBOSE
 	select HAVE_DEBUG_KMEMLEAK
-	select HAVE_DMA_API_DEBUG
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
diff --git a/arch/c6x/Kconfig b/arch/c6x/Kconfig
index c6b4dd1418b4..8c088b96e372 100644
--- a/arch/c6x/Kconfig
+++ b/arch/c6x/Kconfig
@@ -10,7 +10,6 @@ config C6X
 	select GENERIC_ATOMIC64
 	select GENERIC_IRQ_SHOW
 	select HAVE_ARCH_TRACEHOOK
-	select HAVE_DMA_API_DEBUG
 	select HAVE_MEMBLOCK
 	select SPARSE_IRQ
 	select IRQ_DOMAIN
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 9485b5490eca..2067289fad4a 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -29,7 +29,6 @@ config IA64
 	select HAVE_FUNCTION_TRACER
 	select TTY
 	select HAVE_ARCH_TRACEHOOK
-	select HAVE_DMA_API_DEBUG
 	select HAVE_MEMBLOCK
 	select HAVE_MEMBLOCK_NODE_MAP
 	select HAVE_VIRT_CPU_ACCOUNTING
diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index 3817a3e2146c..d14782100088 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -19,7 +19,6 @@ config MICROBLAZE
 	select HAVE_ARCH_HASH
 	select HAVE_ARCH_KGDB
 	select HAVE_DEBUG_KMEMLEAK
-	select HAVE_DMA_API_DEBUG
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_GRAPH_TRACER
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 0f619b8c0e9e..2dcdc13cd65d 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -42,7 +42,6 @@ config MIPS
 	select HAVE_C_RECORDMCOUNT
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DEBUG_STACKOVERFLOW
-	select HAVE_DMA_API_DEBUG
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_EXIT_THREAD
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 1887f8f86a77..268fd46fc3c7 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -181,7 +181,6 @@ config PPC
 	select HAVE_CONTEXT_TRACKING		if PPC64
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DEBUG_STACKOVERFLOW
-	select HAVE_DMA_API_DEBUG
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS	if MPROFILE_KERNEL
 	select HAVE_EBPF_JIT			if PPC64
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 17212ba54ee3..95e2da34aaad 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -23,7 +23,6 @@ config RISCV
 	select GENERIC_ATOMIC64 if !64BIT || !RISCV_ISA_A
 	select HAVE_MEMBLOCK
 	select HAVE_MEMBLOCK_NODE_MAP
-	select HAVE_DMA_API_DEBUG
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_GENERIC_DMA_COHERENT
 	select IRQ_DOMAIN
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index b794a2ab6d15..6a64287ec1da 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -130,7 +130,6 @@ config S390
 	select HAVE_CMPXCHG_LOCAL
 	select HAVE_COPY_THREAD_TLS
 	select HAVE_DEBUG_KMEMLEAK
-	select HAVE_DMA_API_DEBUG
 	select HAVE_DMA_CONTIGUOUS
 	select DMA_DIRECT_OPS
 	select HAVE_DYNAMIC_FTRACE
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 9417f70e008e..7d521926041e 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -13,7 +13,6 @@ config SUPERH
 	select HAVE_OPROFILE
 	select HAVE_GENERIC_DMA_COHERENT
 	select HAVE_ARCH_TRACEHOOK
-	select HAVE_DMA_API_DEBUG
 	select HAVE_PERF_EVENTS
 	select HAVE_DEBUG_BUGVERBOSE
 	select ARCH_HAVE_CUSTOM_GPIO_H
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index c1cfc17eb504..435dbc033afe 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -25,7 +25,6 @@ config SPARC
 	select RTC_CLASS
 	select RTC_DRV_M48T59
 	select RTC_SYSTOHC
-	select HAVE_DMA_API_DEBUG
 	select HAVE_ARCH_JUMP_LABEL if SPARC64
 	select GENERIC_IRQ_SHOW
 	select ARCH_WANT_IPC_PARSE_VERSION
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index aad35c568681..3eeca48a146b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -135,7 +135,6 @@ config X86
 	select HAVE_C_RECORDMCOUNT
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DEBUG_STACKOVERFLOW
-	select HAVE_DMA_API_DEBUG
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index c921e8bccdc8..17df332269b2 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -19,7 +19,6 @@ config XTENSA
 	select HAVE_ARCH_KASAN if MMU
 	select HAVE_CC_STACKPROTECTOR
 	select HAVE_DEBUG_KMEMLEAK
-	select HAVE_DMA_API_DEBUG
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_EXIT_THREAD
 	select HAVE_FUNCTION_TRACER
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 685ed2dd4384..d5175eb7b917 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1634,7 +1634,6 @@ config PROVIDE_OHCI1394_DMA_INIT
 
 config DMA_API_DEBUG
 	bool "Enable debugging of DMA-API usage"
-	depends on HAVE_DMA_API_DEBUG
 	select NEED_DMA_MAP_STATE
 	help
 	  Enable this option to debug the use of the DMA API by device drivers.
-- 
2.17.0


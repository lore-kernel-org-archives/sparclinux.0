From: Palmer Dabbelt <palmer@dabbelt.com>
Date: Mon, 26 Jun 2017 20:27:56 +0000
Subject: [PATCH] pci:  Add and use PCI_GENERIC_SETUP Kconfig entry
Message-Id: <20170626202756.22220-2-palmer@dabbelt.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CAMuHMdXSrfbSX2de2q35Hj6vQwi+sr23M1LEg82JL+FyLq4OJw@mail.gmail.com>
 <20170626202756.22220-1-palmer@dabbelt.com>
In-Reply-To: <20170626202756.22220-1-palmer@dabbelt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: rth@twiddle.net
Cc: Palmer Dabbelt <palmer@dabbelt.com>

We wanted to add RISC-V to the list of architectures that used the
generic PCI setup-irq.o inside the Makefile and it was suggested that
instead we define a Kconfig entry and use that.

I've done very minimal testing on this: I just checked to see that
an aarch64 defconfig still build setup-irq.o with the patch applied.
The intention is that this patch doesn't change the behavior of any
build.

Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
Reviewed-by: James Hogan <james.hogan@imgtec.com>
Acked-by: Russell King <rmk+kernel@armlinux.org.uk>
Acked-by: Richard Henderson <rth@twiddle.net>
Acked-by: Vineet Gupta <vgupta@synopsys.com>   [arch/arc]
---
 arch/alpha/Kconfig     |  1 +
 arch/arc/Kconfig       |  1 +
 arch/arm/Kconfig       |  1 +
 arch/arm64/Kconfig     |  1 +
 arch/m68k/Kconfig.bus  |  1 +
 arch/mips/Kconfig      |  1 +
 arch/sh/Kconfig        |  1 +
 arch/sparc/Kconfig     |  1 +
 arch/tile/Kconfig      |  1 +
 arch/unicore32/Kconfig |  1 +
 drivers/pci/Kconfig    |  3 +++
 drivers/pci/Makefile   | 11 +----------
 12 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index 0e49d39ea74a..30f4e711f681 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -26,6 +26,7 @@ config ALPHA
 	select ODD_RT_SIGACTION
 	select OLD_SIGSUSPEND
 	select CPU_NO_EFFICIENT_FFS if !ALPHA_EV67
+	select PCI_GENERIC_SETUP
 	help
 	  The Alpha is a 64-bit general-purpose processor designed and
 	  marketed by the Digital Equipment Corporation of blessed memory,
diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index a5459698f0ee..dd1f64858118 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -44,6 +44,7 @@ config ARC
 	select HAVE_GENERIC_DMA_COHERENT
 	select HAVE_KERNEL_GZIP
 	select HAVE_KERNEL_LZMA
+	select PCI_GENERIC_SETUP
 
 config MIGHT_HAVE_PCI
 	bool
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 4c1a35f15838..4f910c4c37b2 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -93,6 +93,7 @@ config ARM
 	select OF_RESERVED_MEM if OF
 	select OLD_SIGACTION
 	select OLD_SIGSUSPEND3
+	select PCI_GENERIC_SETUP
 	select PERF_USE_VMALLOC
 	select RTC_LIB
 	select SYS_SUPPORTS_APM_EMULATION
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b2024db225a9..02d4676cb00e 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -110,6 +110,7 @@ config ARM64
 	select OF_EARLY_FLATTREE
 	select OF_RESERVED_MEM
 	select PCI_ECAM if ACPI
+	select PCI_GENERIC_SETUP
 	select POWER_RESET
 	select POWER_SUPPLY
 	select SPARSE_IRQ
diff --git a/arch/m68k/Kconfig.bus b/arch/m68k/Kconfig.bus
index 675b087198f6..bcab783f0487 100644
--- a/arch/m68k/Kconfig.bus
+++ b/arch/m68k/Kconfig.bus
@@ -61,6 +61,7 @@ config GENERIC_ISA_DMA
 config PCI
 	bool "PCI support"
 	depends on M54xx
+	select PCI_GENERIC_SETUP
 	help
 	  Enable the PCI bus. Support for the PCI bus hardware built into the
 	  ColdFire 547x and 548x processors.
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 2828ecde133d..474a7c710686 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -70,6 +70,7 @@ config MIPS
 	select HAVE_EXIT_THREAD
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_COPY_THREAD_TLS
+	select PCI_GENERIC_SETUP
 
 menu "Machine selection"
 
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index ee086958b2b2..90a98ac526fb 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -48,6 +48,7 @@ config SUPERH
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_FUTEX_CMPXCHG if FUTEX
 	select HAVE_NMI
+	select PCI_GENERIC_SETUP
 	help
 	  The SuperH is a RISC processor targeted for use in embedded systems
 	  and consumer electronics; it was also used in the Sega Dreamcast
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 5639c9fe5b55..24cea64104bd 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -424,6 +424,7 @@ config SPARC_LEON
 	depends on SPARC32
 	select USB_EHCI_BIG_ENDIAN_MMIO
 	select USB_EHCI_BIG_ENDIAN_DESC
+	select PCI_GENERIC_SETUP
 	---help---
 	  If you say Y here if you are running on a SPARC-LEON processor.
 	  The LEON processor is a synthesizable VHDL model of the
diff --git a/arch/tile/Kconfig b/arch/tile/Kconfig
index 4583c0320059..451000db8c62 100644
--- a/arch/tile/Kconfig
+++ b/arch/tile/Kconfig
@@ -28,6 +28,7 @@ config TILE
 	select HAVE_PERF_EVENTS
 	select HAVE_SYSCALL_TRACEPOINTS
 	select MODULES_USE_ELF_RELA
+	select PCI_GENERIC_SETUP
 	select SYSCTL_EXCEPTION_TRACE
 	select SYS_HYPERVISOR
 	select USER_STACKTRACE_SUPPORT
diff --git a/arch/unicore32/Kconfig b/arch/unicore32/Kconfig
index 0769066929c6..162a7d3def0c 100644
--- a/arch/unicore32/Kconfig
+++ b/arch/unicore32/Kconfig
@@ -18,6 +18,7 @@ config UNICORE32
 	select ARCH_WANT_FRAME_POINTERS
 	select GENERIC_IOMAP
 	select MODULES_USE_ELF_REL
+	select PCI_GENERIC_SETUP
 	help
 	  UniCore-32 is 32-bit Instruction Set Architecture,
 	  including a series of low-power-consumption RISC chip
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index e0cacb7b8563..72a1c4c65926 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -131,6 +131,9 @@ config PCI_HYPERV
           The PCI device frontend driver allows the kernel to import arbitrary
           PCI devices from a PCI backend to support PCI driver domains.
 
+config PCI_GENERIC_SETUP
+	bool
+
 source "drivers/pci/hotplug/Kconfig"
 source "drivers/pci/dwc/Kconfig"
 source "drivers/pci/host/Kconfig"
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 462c1f5f5546..26f4710c88ec 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -31,16 +31,7 @@ obj-$(CONFIG_PCI_IOV) += iov.o
 #
 # Some architectures use the generic PCI setup functions
 #
-obj-$(CONFIG_ALPHA) += setup-irq.o
-obj-$(CONFIG_ARC) += setup-irq.o
-obj-$(CONFIG_ARM) += setup-irq.o
-obj-$(CONFIG_ARM64) += setup-irq.o
-obj-$(CONFIG_UNICORE32) += setup-irq.o
-obj-$(CONFIG_SUPERH) += setup-irq.o
-obj-$(CONFIG_MIPS) += setup-irq.o
-obj-$(CONFIG_TILE) += setup-irq.o
-obj-$(CONFIG_SPARC_LEON) += setup-irq.o
-obj-$(CONFIG_M68K) += setup-irq.o
+obj-$(CONFIG_PCI_GENERIC_SETUP) += setup-irq.o
 
 #
 # ACPI Related PCI FW Functions
-- 
2.13.0


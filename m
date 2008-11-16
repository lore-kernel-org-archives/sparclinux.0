From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 16 Nov 2008 08:56:57 +0000
Subject: [PATCH] sparc,sparc64: unify Kconfig
Message-Id: <1226825821-10125-1-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Merge the two Kconfig files manually.
The resulting configuration structure has been compared with the
original structure and it was checked that no options are missing
or added for both sparc and sparc64.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/Kconfig   |  351 +++++++++++++++++++++++++++++++++++-----
 arch/sparc64/Kconfig |  438 +-------------------------------------------------
 2 files changed, 309 insertions(+), 480 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 61a3a0c..33e0b15 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -9,7 +9,7 @@ config SPARC
 	default y
 	select HAVE_IDE
 	select HAVE_OPROFILE
-	select HAVE_ARCH_KGDB if !SMP
+	select HAVE_ARCH_KGDB if !SMP || SPARC64
 	select HAVE_ARCH_TRACEHOOK
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select RTC_CLASS
@@ -18,7 +18,7 @@ config SPARC
 # Identify this as a Sparc32 build
 config SPARC32
 	bool
-	default y
+	default y if ARCH = "sparc"
 	help
 	  SPARC is a family of RISC microprocessors designed and marketed by
 	  Sun Microsystems, incorporated.  They are very widely found in Sun
@@ -28,21 +28,76 @@ config SPARC32
 	  maintains both the SPARC32 and SPARC64 ports; its web page is
 	  available at <http://www.ultralinux.org/>.
 
+config SPARC64
+	bool
+	default y if ARCH = "sparc64"
+	select HAVE_FUNCTION_TRACER
+	select HAVE_KRETPROBES
+	select HAVE_KPROBES
+	select HAVE_LMB
+	select USE_GENERIC_SMP_HELPERS if SMP
+	select RTC_DRV_CMOS
+	select RTC_DRV_BQ4802
+	select RTC_DRV_SUN4V
+	select RTC_DRV_STARFIRE
+
+config 64BIT
+	def_bool y if SPARC64
+
+config GENERIC_TIME
+	bool
+	default y if SPARC64
+
+config GENERIC_CMOS_UPDATE
+	bool
+	default y if SPARC64
+
+config GENERIC_CLOCKEVENTS
+	bool
+	default y if SPARC64
+
+config IOMMU_HELPER
+	bool
+	default y if SPARC64
+
+config QUICKLIST
+	bool
+	default y if SPARC64
+
+config STACKTRACE_SUPPORT
+	bool
+	default y if SPARC64
+
+config LOCKDEP_SUPPORT
+	bool
+	default y if SPARC64
+
+config AUDIT_ARCH
+	bool
+	default y if SPARC64
+
+config HAVE_SETUP_PER_CPU_AREA
+	def_bool y if SPARC64
+
+config GENERIC_HARDIRQS_NO__DO_IRQ
+	bool
+	def_bool y if SPARC64
+
 config MMU
 	bool
 	default y
 
 config HIGHMEM
 	bool
-	default y
+	default y if SPARC32
 
 config ZONE_DMA
 	bool
-	default y
+	default y if SPARC32
 
 config GENERIC_ISA_DMA
 	bool
-	default y
+	default y if SPARC32
 
 config GENERIC_GPIO
 	bool
@@ -59,7 +114,7 @@ source "init/Kconfig"
 
 source "kernel/Kconfig.freezer"
 
-menu "General machine setup"
+menu "Processor type and features"
 
 config SMP
 	bool "Symmetric multi-processing support (does not work on sun4/sun4c)"
@@ -84,40 +139,18 @@ config SMP
 	  If you don't know what to do here, say N.
 
 config NR_CPUS
-	int "Maximum number of CPUs (2-32)"
-	range 2 32
+	int "Maximum number of CPUs"
+	range 2 32 if SPARC32
+	range 2 1024 if SPARC64
 	depends on SMP
-	default "32"
-
-source "kernel/Kconfig.hz"
-
-# Global things across all Sun machines.
-config SERIAL_CONSOLE
-	bool
-	default y
-	---help---
-	  If you say Y here, it will be possible to use a serial port as the
-	  system console (the system console is the device which receives all
-	  kernel messages and warnings and which allows logins in single user
-	  mode). This could be useful if some terminal or printer is connected
-	  to that serial port.
-
-	  Even if you say Y here, the currently visible virtual console
-	  (/dev/tty0) will still be used as the system console by default, but
-	  you can alter that using a kernel command line option such as
-	  "console=ttyS1". (Try "man bootparam" or see the documentation of
-	  your boot loader (silo) about how to pass options to the kernel at
-	  boot time.)
+	default "2" if SPARC32
+	default "64" if SPARC64
 
-	  If you don't have a graphics card installed and you say Y here, the
-	  kernel will automatically use the first serial line, /dev/ttyS0, as
-	  system console.
-
-	  If unsure, say N.
+source kernel/Kconfig.hz
 
 config RWSEM_GENERIC_SPINLOCK
 	bool
-	default y
+	default y if SPARC32
 
 config RWSEM_XCHGADD_ALGORITHM
 	bool
@@ -128,11 +161,7 @@ config GENERIC_FIND_NEXT_BIT
 
 config GENERIC_HWEIGHT
 	bool
-	default y
-
-config GENERIC_CALIBRATE_DELAY
-	bool
-	default y
+	default y if !ULTRA_HAS_POPULATION_COUNT
 
 config ARCH_MAY_HAVE_PC_FDC
 	bool
@@ -148,27 +177,237 @@ config ARCH_HAS_ILOG2_U64
 
 config EMULATED_CMPXCHG
 	bool
-	default y
+	default y if SPARC32
 	help
 	  Sparc32 does not have a CAS instruction like sparc64. cmpxchg()
 	  is emulated, and therefore it is not completely atomic.
+choice
+	prompt "Kernel page size" if SPARC64
+	default SPARC64_PAGE_SIZE_8KB
 
-config SUN_PM
+config SPARC64_PAGE_SIZE_8KB
+	bool "8KB"
+	help
+	  This lets you select the page size of the kernel.
+
+	  8KB and 64KB work quite well, since SPARC ELF sections
+	  provide for up to 64KB alignment.
+
+	  If you don't know what to do, choose 8KB.
+
+config SPARC64_PAGE_SIZE_64KB
+	bool "64KB"
+
+endchoice
+
+config SECCOMP
+	bool "Enable seccomp to safely compute untrusted bytecode"
+	depends on SPARC64 && PROC_FS
+	default y
+	help
+	  This kernel feature is useful for number crunching applications
+	  that may need to compute untrusted bytecode during their
+	  execution. By using pipes or other transports made available to
+	  the process as file descriptors supporting the read/write
+	  syscalls, it's possible to isolate those applications in
+	  their own address space using seccomp. Once seccomp is
+	  enabled via /proc/<pid>/seccomp, it cannot be disabled
+	  and the task is only allowed to execute a few safe syscalls
+	  defined by each seccomp mode.
+
+	  If unsure, say Y. Only embedded should say N here.
+
+config HOTPLUG_CPU
+	bool "Support for hot-pluggable CPUs"
+	depends on SPARC64 && SMP
+	select HOTPLUG
+	help
+	  Say Y here to experiment with turning CPUs off and on.  CPUs
+	  can be controlled through /sys/devices/system/cpu/cpu#.
+	  Say N if you want to disable CPU hotplug.
+
+config GENERIC_HARDIRQS
 	bool
+	default y if SPARC64
+
+source "kernel/time/Kconfig"
+
+if SPARC64
+source "drivers/cpufreq/Kconfig"
+
+config US3_FREQ
+	tristate "UltraSPARC-III CPU Frequency driver"
+	depends on CPU_FREQ
+	select CPU_FREQ_TABLE
+	help
+	  This adds the CPUFreq driver for UltraSPARC-III processors.
+
+	  For details, take a look at <file:Documentation/cpu-freq>.
+
+	  If in doubt, say N.
+
+config US2E_FREQ
+	tristate "UltraSPARC-IIe CPU Frequency driver"
+	depends on CPU_FREQ
+	select CPU_FREQ_TABLE
+	help
+	  This adds the CPUFreq driver for UltraSPARC-IIe processors.
+
+	  For details, take a look at <file:Documentation/cpu-freq>.
+
+	  If in doubt, say N.
+
+endif
+
+config US3_MC
+	tristate "UltraSPARC-III Memory Controller driver"
+	depends on SPARC64
 	default y
 	help
+	  This adds a driver for the UltraSPARC-III memory controller.
+	  Loading this driver allows exact mnemonic strings to be
+	  printed in the event of a memory error, so that the faulty DIMM
+	  on the motherboard can be matched to the error.
+
+	  If in doubt, say Y, as this information can be very useful.
+
+# Global things across all Sun machines.
+config GENERIC_LOCKBREAK
+	bool
+	default y
+	depends on SPARC64 && SMP && PREEMPT
+
+config GENERIC_CALIBRATE_DELAY
+	bool
+	default y
+
+choice
+	prompt "SPARC64 Huge TLB Page Size"
+	depends on SPARC64 && HUGETLB_PAGE
+	default HUGETLB_PAGE_SIZE_4MB
+
+config HUGETLB_PAGE_SIZE_4MB
+	bool "4MB"
+
+config HUGETLB_PAGE_SIZE_512K
+	bool "512K"
+
+config HUGETLB_PAGE_SIZE_64K
+	depends on !SPARC64_PAGE_SIZE_64KB
+	bool "64K"
+
+endchoice
+
+config NUMA
+	bool "NUMA support"
+	depends on SPARC64 && SMP
+
+config NODES_SHIFT
+	int
+	default "4"
+	depends on NEED_MULTIPLE_NODES
+
+# Some NUMA nodes have memory ranges that span
+# other nodes.  Even though a pfn is valid and
+# between a node's start and end pfns, it may not
+# reside on that node.  See memmap_init_zone()
+# for details.
+config NODES_SPAN_OTHER_NODES
+	def_bool y
+	depends on NEED_MULTIPLE_NODES
+
+config ARCH_POPULATES_NODE_MAP
+	def_bool y if SPARC64
+
+config ARCH_SELECT_MEMORY_MODEL
+	def_bool y if SPARC64
+
+config ARCH_SPARSEMEM_ENABLE
+	def_bool y if SPARC64
+	select SPARSEMEM_VMEMMAP_ENABLE
+
+config ARCH_SPARSEMEM_DEFAULT
+	def_bool y if PSARC64
+
+source "mm/Kconfig"
+
+config SCHED_SMT
+	bool "SMT (Hyperthreading) scheduler support"
+	depends on SPARC64 && SMP
+	default y
+	help
+	  SMT scheduler support improves the CPU scheduler's decision making
+	  when dealing with SPARC cpus at a cost of slightly increased overhead
+	  in some places. If unsure say N here.
+
+config SCHED_MC
+	bool "Multi-core scheduler support"
+	depends on SPARC64 && SMP
+	default y
+	help
+	  Multi-core scheduler support improves the CPU scheduler's decision
+	  making when dealing with multi-core CPU chips at a cost of slightly
+	  increased overhead in some places. If unsure say N here.
+
+if SPARC64
+source "kernel/Kconfig.preempt"
+endif
+
+config CMDLINE_BOOL
+	bool "Default bootloader kernel arguments"
+	depends on SPARC64
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
+config SUN_PM
+	bool
+	default y if SPARC32
+	help
 	  Enable power management and CPU standby features on supported
 	  SPARC platforms.
 
 config SPARC_LED
 	tristate "Sun4m LED driver"
+	depends on SPARC32
 	help
 	  This driver toggles the front-panel LED on sun4m systems
 	  in a user-specifiable manner.  Its state can be probed
 	  by reading /proc/led and its blinking mode can be changed
 	  via writes to /proc/led
 
-source "mm/Kconfig"
+config SERIAL_CONSOLE
+	bool
+	default y
+	---help---
+	  If you say Y here, it will be possible to use a serial port as the
+	  system console (the system console is the device which receives all
+	  kernel messages and warnings and which allows logins in single user
+	  mode). This could be useful if some terminal or printer is connected
+	  to that serial port.
+
+	  Even if you say Y here, the currently visible virtual console
+	  (/dev/tty0) will still be used as the system console by default, but
+	  you can alter that using a kernel command line option such as
+	  "console=ttyS1". (Try "man bootparam" or see the documentation of
+	  your boot loader (silo) about how to pass options to the kernel at
+	  boot time.)
+
+	  If you don't have a graphics card installed and you say Y here, the
+	  kernel will automatically use the first serial line, /dev/ttyS0, as
+	  system console.
+
+	  If unsure, say N.
 
 endmenu
 
@@ -227,13 +466,28 @@ config SUN_IO
 	bool
 	default y
 
+config SUN_LDOMS
+	bool "Sun Logical Domains support"
+	help
+	  Say Y here is you want to support virtual devices via
+	  Logical Domains.
+
 config PCI
 	bool "Support for PCI and PS/2 keyboard/mouse"
+	select ARCH_SUPPORTS_MSI if SPARC64
 	help
+	  Find out whether your system includes a PCI bus. PCI is the name of
+	  a bus system, i.e. the way the CPU talks to the other stuff inside
+	  your box.  If you say Y here, the kernel will include drivers and
+	  infrastructure code to support PCI bus devices.
+
 	  CONFIG_PCI is needed for all JavaStation's (including MrCoffee),
 	  CP-1200, JavaEngine-1, Corona, Red October, and Serengeti SGSC.
 	  All of these platforms are extremely obscure, so say N if unsure.
 
+config PCI_DOMAINS
+	def_bool PCI if SPARC64
+
 config PCI_SYSCALL
 	def_bool PCI
 
@@ -259,6 +513,17 @@ menu "Executable file formats"
 
 source "fs/Kconfig.binfmt"
 
+config COMPAT
+	bool
+	depends on SPARC64
+	default y
+	select COMPAT_BINFMT_ELF
+
+config SYSVIPC_COMPAT
+	bool
+	depends on COMPAT && SYSVIPC
+	default y
+
 endmenu
 
 source "net/Kconfig"
diff --git a/arch/sparc64/Kconfig b/arch/sparc64/Kconfig
index 4263e5e..caa9421 100644
--- a/arch/sparc64/Kconfig
+++ b/arch/sparc64/Kconfig
@@ -1,437 +1 @@
-# sparc64 configuration
-mainmenu "Linux Kernel Configuration for 64-bit SPARC"
-
-config SPARC
-	bool
-	default y
-	select HAVE_OPROFILE
-	select HAVE_KPROBES
-	select HAVE_KRETPROBES
-
-config SPARC64
-	bool
-	default y
-	select HAVE_FUNCTION_TRACER
-	select HAVE_IDE
-	select HAVE_LMB
-	select HAVE_ARCH_KGDB
-	select USE_GENERIC_SMP_HELPERS if SMP
-	select HAVE_ARCH_TRACEHOOK
-	select ARCH_WANT_OPTIONAL_GPIOLIB
-	select RTC_CLASS
-	select RTC_DRV_M48T59
-	select RTC_DRV_CMOS
-	select RTC_DRV_BQ4802
-	select RTC_DRV_SUN4V
-	select RTC_DRV_STARFIRE
-
-config GENERIC_TIME
-	bool
-	default y
-
-config GENERIC_CMOS_UPDATE
-	bool
-	default y
-
-config GENERIC_CLOCKEVENTS
-	bool
-	default y
-
-config GENERIC_GPIO
-	bool
-	help
-	  Generic GPIO API support
-
-config 64BIT
-	def_bool y
-
-config MMU
-	bool
-	default y
-
-config IOMMU_HELPER
-	bool
-	default y
-
-config QUICKLIST
-	bool
-	default y
-
-config STACKTRACE_SUPPORT
-	bool
-	default y
-
-config LOCKDEP_SUPPORT
-	bool
-	default y
-
-config ARCH_MAY_HAVE_PC_FDC
-	bool
-	default y
-
-config ARCH_HAS_ILOG2_U32
-	bool
-	default n
-
-config ARCH_HAS_ILOG2_U64
-	bool
-	default n
-
-config AUDIT_ARCH
-	bool
-	default y
-
-config HAVE_SETUP_PER_CPU_AREA
-	def_bool y
-
-config ARCH_NO_VIRT_TO_BUS
-	def_bool y
-
-config OF
-	def_bool y
-
-config GENERIC_HARDIRQS_NO__DO_IRQ
-	bool
-	def_bool y
-
-source "init/Kconfig"
-source "kernel/Kconfig.freezer"
-
-menu "Processor type and features"
-
-choice
-	prompt "Kernel page size"
-	default SPARC64_PAGE_SIZE_8KB
-
-config SPARC64_PAGE_SIZE_8KB
-	bool "8KB"
-	help
-	  This lets you select the page size of the kernel.
-
-	  8KB and 64KB work quite well, since SPARC ELF sections
-	  provide for up to 64KB alignment.
-
-	  If you don't know what to do, choose 8KB.
-
-config SPARC64_PAGE_SIZE_64KB
-	bool "64KB"
-
-endchoice
-
-config SECCOMP
-	bool "Enable seccomp to safely compute untrusted bytecode"
-	depends on PROC_FS
-	default y
-	help
-	  This kernel feature is useful for number crunching applications
-	  that may need to compute untrusted bytecode during their
-	  execution. By using pipes or other transports made available to
-	  the process as file descriptors supporting the read/write
-	  syscalls, it's possible to isolate those applications in
-	  their own address space using seccomp. Once seccomp is
-	  enabled via /proc/<pid>/seccomp, it cannot be disabled
-	  and the task is only allowed to execute a few safe syscalls
-	  defined by each seccomp mode.
-
-	  If unsure, say Y. Only embedded should say N here.
-
-source kernel/Kconfig.hz
-
-config HOTPLUG_CPU
-	bool "Support for hot-pluggable CPUs"
-	depends on SMP
-	select HOTPLUG
-	help
-	  Say Y here to experiment with turning CPUs off and on.  CPUs
-	  can be controlled through /sys/devices/system/cpu/cpu#.
-	  Say N if you want to disable CPU hotplug.
-
-config GENERIC_HARDIRQS
-	bool
-	default y
-
-source "kernel/time/Kconfig"
-
-config SMP
-	bool "Symmetric multi-processing support"
-	help
-	  This enables support for systems with more than one CPU. If you have
-	  a system with only one CPU, say N. If you have a system with more than
-	  one CPU, say Y.
-
-	  If you say N here, the kernel will run on single and multiprocessor
-	  machines, but will use only one CPU of a multiprocessor machine. If
-	  you say Y here, the kernel will run on single-processor machines.
-	  On a single-processor machine, the kernel will run faster if you say
-	  N here.
-
-	  If you don't know what to do here, say N.
-
-config NR_CPUS
-	int "Maximum number of CPUs (2-1024)"
-	range 2 1024
-	depends on SMP
-	default "64"
-
-source "drivers/cpufreq/Kconfig"
-
-config US3_FREQ
-	tristate "UltraSPARC-III CPU Frequency driver"
-	depends on CPU_FREQ
-	select CPU_FREQ_TABLE
-	help
-	  This adds the CPUFreq driver for UltraSPARC-III processors.
-
-	  For details, take a look at <file:Documentation/cpu-freq>.
-
-	  If in doubt, say N.
-
-config US2E_FREQ
-	tristate "UltraSPARC-IIe CPU Frequency driver"
-	depends on CPU_FREQ
-	select CPU_FREQ_TABLE
-	help
-	  This adds the CPUFreq driver for UltraSPARC-IIe processors.
-
-	  For details, take a look at <file:Documentation/cpu-freq>.
-
-	  If in doubt, say N.
-
-config US3_MC
-	tristate "UltraSPARC-III Memory Controller driver"
-	default y
-	help
-	  This adds a driver for the UltraSPARC-III memory controller.
-	  Loading this driver allows exact mnemonic strings to be
-	  printed in the event of a memory error, so that the faulty DIMM
-	  on the motherboard can be matched to the error.
-
-	  If in doubt, say Y, as this information can be very useful.
-
-# Global things across all Sun machines.
-config GENERIC_LOCKBREAK
-	bool
-	default y
-	depends on SMP && PREEMPT
-
-config RWSEM_GENERIC_SPINLOCK
-	bool
-
-config RWSEM_XCHGADD_ALGORITHM
-	bool
-	default y
-
-config GENERIC_FIND_NEXT_BIT
-	bool
-	default y
-
-config GENERIC_HWEIGHT
-	bool
-	default y if !ULTRA_HAS_POPULATION_COUNT
-
-config GENERIC_CALIBRATE_DELAY
-	bool
-	default y
-
-choice
-	prompt "SPARC64 Huge TLB Page Size"
-	depends on HUGETLB_PAGE
-	default HUGETLB_PAGE_SIZE_4MB
-
-config HUGETLB_PAGE_SIZE_4MB
-	bool "4MB"
-
-config HUGETLB_PAGE_SIZE_512K
-	bool "512K"
-
-config HUGETLB_PAGE_SIZE_64K
-	depends on !SPARC64_PAGE_SIZE_64KB
-	bool "64K"
-
-endchoice
-
-config NUMA
-	bool "NUMA support"
-	depends on SMP
-
-config NODES_SHIFT
-	int
-	default "4"
-	depends on NEED_MULTIPLE_NODES
-
-# Some NUMA nodes have memory ranges that span
-# other nodes.  Even though a pfn is valid and
-# between a node's start and end pfns, it may not
-# reside on that node.  See memmap_init_zone()
-# for details.
-config NODES_SPAN_OTHER_NODES
-	def_bool y
-	depends on NEED_MULTIPLE_NODES
-
-config ARCH_POPULATES_NODE_MAP
-	def_bool y
-
-config ARCH_SELECT_MEMORY_MODEL
-	def_bool y
-
-config ARCH_SPARSEMEM_ENABLE
-	def_bool y
-	select SPARSEMEM_VMEMMAP_ENABLE
-
-config ARCH_SPARSEMEM_DEFAULT
-	def_bool y
-
-source "mm/Kconfig"
-
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
-endmenu
-
-menu "Bus options (PCI etc.)"
-
-config ISA
-	bool
-
-config ISAPNP
-	bool
-
-config EISA
-	bool
-
-config MCA
-	bool
-
-config PCMCIA
-	tristate
-	help
-	  Say Y here if you want to attach PCMCIA- or PC-cards to your Linux
-	  computer.  These are credit-card size devices such as network cards,
-	  modems or hard drives often used with laptops computers.  There are
-	  actually two varieties of these cards: the older 16 bit PCMCIA cards
-	  and the newer 32 bit CardBus cards.  If you want to use CardBus
-	  cards, you need to say Y here and also to "CardBus support" below.
-
-	  To use your PC-cards, you will need supporting software from David
-	  Hinds' pcmcia-cs package (see the file <file:Documentation/Changes>
-	  for location).  Please also read the PCMCIA-HOWTO, available from
-	  <http://www.tldp.org/docs.html#howto>.
-
-	  To compile this driver as modules, choose M here: the
-	  modules will be called pcmcia_core and ds.
-
-config SBUS
-	bool
-	default y
-
-config SBUSCHAR
-	bool
-	default y
-
-config SUN_AUXIO
-	bool
-	default y
-
-config SUN_IO
-	bool
-	default y
-
-config SUN_LDOMS
-	bool "Sun Logical Domains support"
-	help
-	  Say Y here is you want to support virtual devices via
-	  Logical Domains.
-
-config PCI
-	bool "PCI support"
-	select ARCH_SUPPORTS_MSI
-	help
-	  Find out whether your system includes a PCI bus. PCI is the name of
-	  a bus system, i.e. the way the CPU talks to the other stuff inside
-	  your box.  If you say Y here, the kernel will include drivers and
-	  infrastructure code to support PCI bus devices.
-
-config PCI_DOMAINS
-	def_bool PCI
-
-config PCI_SYSCALL
-	def_bool PCI
-
-source "drivers/pci/Kconfig"
-
-config SUN_OPENPROMFS
-	tristate "Openprom tree appears in /proc/openprom"
-	help
-	  If you say Y, the OpenPROM device tree will be available as a
-	  virtual file system, which you can mount to /proc/openprom by "mount
-	  -t openpromfs none /proc/openprom".
-
-	  To compile the /proc/openprom support as a module, choose M here: the
-	  module will be called openpromfs.  If unsure, choose M.
-
-endmenu
-
-menu "Executable file formats"
-
-source "fs/Kconfig.binfmt"
-
-config COMPAT
-	bool
-	default y
-	select COMPAT_BINFMT_ELF
-
-config SYSVIPC_COMPAT
-	bool
-	depends on COMPAT && SYSVIPC
-	default y
-
-endmenu
-
-source "net/Kconfig"
-
-source "drivers/Kconfig"
-
-source "drivers/sbus/char/Kconfig"
-
-source "fs/Kconfig"
-
-source "arch/sparc/Kconfig.debug"
-
-source "security/Kconfig"
-
-source "crypto/Kconfig"
-
-source "lib/Kconfig"
+source arch/sparc/Kconfig
-- 
1.5.6.GIT


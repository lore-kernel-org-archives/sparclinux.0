From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 30 Nov 2008 20:15:30 +0000
Subject: [PATCH 3/5] sparc: prepare kernel/ for unification
Message-Id: <1228076132-18036-3-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

o sparc32 files with identical names to sparc64 renamed to <name>_32.S
o introduced a few Kconfig helpers to simplify Makefile logic
o refactored Makefile to prepare for unification
  - use obj-$(CONFIG_SPARC32) for sparc32 specific files
  - use <name>_$(BITS) for files where sparc64 has a _64 variant
  - sparc64 directly include a few files where sparc32 builds them,
    refer to these files directly (no BITS)
  - sneaked in -Werror as used by sparc64
o modified sparc/Makefile to use the new names for head/init_task

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/Kconfig                                 |   21 +++++
 arch/sparc/Makefile                                |    4 +-
 arch/sparc/kernel/Makefile                         |   84 ++++++++++++++------
 arch/sparc/kernel/{auxio.c => auxio_32.c}          |    0
 arch/sparc/kernel/{cpu.c => cpu_32.c}              |    0
 arch/sparc/kernel/{etrap.S => etrap_32.S}          |    0
 arch/sparc/kernel/{head.S => head_32.S}            |    0
 arch/sparc/kernel/{idprom.c => idprom_32.c}        |    0
 arch/sparc/kernel/{init_task.c => init_task_32.c}  |    0
 arch/sparc/kernel/{irq.c => irq_32.c}              |    0
 arch/sparc/kernel/{kgdb.c => kgdb_32.c}            |    0
 arch/sparc/kernel/{module.c => module_32.c}        |    0
 arch/sparc/kernel/{of_device.c => of_device_32.c}  |    0
 arch/sparc/kernel/{process.c => process_32.c}      |    0
 arch/sparc/kernel/{prom.c => prom_32.c}            |    0
 arch/sparc/kernel/{ptrace.c => ptrace_32.c}        |    0
 arch/sparc/kernel/{rtrap.S => rtrap_32.S}          |    0
 arch/sparc/kernel/{setup.c => setup_32.c}          |    0
 arch/sparc/kernel/{signal.c => signal_32.c}        |    0
 arch/sparc/kernel/{smp.c => smp_32.c}              |    0
 .../kernel/{sparc_ksyms.c => sparc_ksyms_32.c}     |    0
 arch/sparc/kernel/{sys_sparc.c => sys_sparc_32.c}  |    0
 arch/sparc/kernel/{systbls.S => systbls_32.S}      |    0
 arch/sparc/kernel/{time.c => time_32.c}            |    0
 .../sparc/kernel/{trampoline.S => trampoline_32.S} |    0
 arch/sparc/kernel/{traps.c => traps_32.c}          |    0
 arch/sparc/kernel/{una_asm.S => una_asm_32.S}      |    0
 arch/sparc/kernel/{unaligned.c => unaligned_32.c}  |    0
 28 files changed, 81 insertions(+), 28 deletions(-)
 rewrite arch/sparc/kernel/Makefile (94%)
 rename arch/sparc/kernel/{auxio.c => auxio_32.c} (100%)
 rename arch/sparc/kernel/{cpu.c => cpu_32.c} (100%)
 rename arch/sparc/kernel/{etrap.S => etrap_32.S} (100%)
 rename arch/sparc/kernel/{head.S => head_32.S} (100%)
 rename arch/sparc/kernel/{idprom.c => idprom_32.c} (100%)
 rename arch/sparc/kernel/{init_task.c => init_task_32.c} (100%)
 rename arch/sparc/kernel/{irq.c => irq_32.c} (100%)
 rename arch/sparc/kernel/{kgdb.c => kgdb_32.c} (100%)
 rename arch/sparc/kernel/{module.c => module_32.c} (100%)
 rename arch/sparc/kernel/{of_device.c => of_device_32.c} (100%)
 rename arch/sparc/kernel/{process.c => process_32.c} (100%)
 rename arch/sparc/kernel/{prom.c => prom_32.c} (100%)
 rename arch/sparc/kernel/{ptrace.c => ptrace_32.c} (100%)
 rename arch/sparc/kernel/{rtrap.S => rtrap_32.S} (100%)
 rename arch/sparc/kernel/{setup.c => setup_32.c} (100%)
 rename arch/sparc/kernel/{signal.c => signal_32.c} (100%)
 rename arch/sparc/kernel/{smp.c => smp_32.c} (100%)
 rename arch/sparc/kernel/{sparc_ksyms.c => sparc_ksyms_32.c} (100%)
 rename arch/sparc/kernel/{sys_sparc.c => sys_sparc_32.c} (100%)
 rename arch/sparc/kernel/{systbls.S => systbls_32.S} (100%)
 rename arch/sparc/kernel/{time.c => time_32.c} (100%)
 rename arch/sparc/kernel/{trampoline.S => trampoline_32.S} (100%)
 rename arch/sparc/kernel/{traps.c => traps_32.c} (100%)
 rename arch/sparc/kernel/{una_asm.S => una_asm_32.S} (100%)
 rename arch/sparc/kernel/{unaligned.c => unaligned_32.c} (100%)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 26ddeed..7cfe557 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -198,6 +198,17 @@ config EMULATED_CMPXCHG
 	  Sparc32 does not have a CAS instruction like sparc64. cmpxchg()
 	  is emulated, and therefore it is not completely atomic.
 
+# Makefile helpers
+config SPARC32_SMP
+	bool
+	default y
+	depends on SPARC32 && SMP
+
+config SPARC64_SMP
+	bool
+	default y
+	depends on SPARC64 && SMP
+
 choice
 	prompt "Kernel page size" if SPARC64
 	default SPARC64_PAGE_SIZE_8KB
@@ -505,6 +516,16 @@ config SUN_OPENPROMFS
 	  Only choose N if you know in advance that you will not need to modify
 	  OpenPROM settings on the running system.
 
+# Makefile helpers
+config SPARC32_PCI
+	bool
+	default y
+	depends on SPARC32 && PCI
+
+config SPARC64_PCI
+	bool
+	default y
+	depends on SPARC64 && PCI
 
 endmenu
 
diff --git a/arch/sparc/Makefile b/arch/sparc/Makefile
index 4e12a1e..4e083b6 100644
--- a/arch/sparc/Makefile
+++ b/arch/sparc/Makefile
@@ -67,8 +67,8 @@ endif
 
 endif
 
-head-$(CONFIG_SPARC32) := arch/sparc/kernel/head.o
-head-$(CONFIG_SPARC32) += arch/sparc/kernel/init_task.o
+head-$(CONFIG_SPARC32) := arch/sparc/kernel/head_$(BITS).o
+head-$(CONFIG_SPARC32) += arch/sparc/kernel/init_task_$(BITS).o
 head-$(CONFIG_SPARC64) := arch/sparc64/kernel/head.o
 head-$(CONFIG_SPARC64) += arch/sparc64/kernel/init_task.o
 
diff --git a/arch/sparc/kernel/Makefile b/arch/sparc/kernel/Makefile
dissimilarity index 94%
index 2d65820..6558eea 100644
--- a/arch/sparc/kernel/Makefile
+++ b/arch/sparc/kernel/Makefile
@@ -1,26 +1,58 @@
-#
-# Makefile for the linux kernel.
-#
-
-extra-y		:= head.o init_task.o vmlinux.lds
-
-EXTRA_AFLAGS	:= -ansi
-
-IRQ_OBJS := irq.o sun4m_irq.o sun4c_irq.o sun4d_irq.o
-obj-y    := entry.o wof.o wuf.o etrap.o rtrap.o traps.o $(IRQ_OBJS) \
-	    process.o signal.o ioport.o setup.o idprom.o \
-	    sys_sparc.o systbls.o \
-	    time.o windows.o cpu.o devices.o \
-	    tadpole.o tick14.o ptrace.o \
-	    unaligned.o una_asm.o muldiv.o \
-	    prom.o of_device.o devres.o dma.o
-
-devres-y = ../../../kernel/irq/devres.o
-
-obj-$(CONFIG_PCI) += pcic.o
-obj-$(CONFIG_SMP) += trampoline.o smp.o sun4m_smp.o sun4d_smp.o
-obj-$(CONFIG_SUN_AUXIO) += auxio.o
-obj-$(CONFIG_SUN_PM) += apc.o pmc.o
-obj-$(CONFIG_MODULES) += module.o sparc_ksyms.o
-obj-$(CONFIG_SPARC_LED) += led.o
-obj-$(CONFIG_KGDB) += kgdb.o
+#
+# Makefile for the linux kernel.
+#
+
+asflags-y := -ansi
+ccflags-y := -Werror
+
+extra-y     := head_$(BITS).o
+extra-y     += init_task_$(BITS).o
+extra-y     += vmlinux.lds
+
+obj-$(CONFIG_SPARC32)   += entry.o wof.o wuf.o
+obj-$(CONFIG_SPARC32)   += etrap_32.o
+obj-$(CONFIG_SPARC32)   += rtrap_32.o
+obj-y                   += traps_$(BITS).o
+
+# IRQ
+obj-y                   += irq_$(BITS).o
+obj-$(CONFIG_SPARC32)   += sun4m_irq.o sun4c_irq.o sun4d_irq.o
+
+obj-y                   += process_$(BITS).o
+obj-y                   += signal_$(BITS).o
+obj-$(CONFIG_SPARC32)   += ioport.o
+obj-y                   += setup_$(BITS).o
+obj-y                   += idprom_$(BITS).o
+obj-y                   += sys_sparc_$(BITS).o
+obj-$(CONFIG_SPARC32)   += systbls_32.o
+obj-y                   += time_$(BITS).o
+obj-$(CONFIG_SPARC32)   += windows.o
+obj-y                   += cpu_$(BITS).o
+obj-$(CONFIG_SPARC32)   += devices.o
+obj-$(CONFIG_SPARC32)   += tadpole.o
+obj-$(CONFIG_SPARC32)   += tick14.o
+obj-y                   += ptrace_$(BITS).o
+obj-y                   += unaligned_$(BITS).o
+obj-y                   += una_asm_$(BITS).o
+obj-$(CONFIG_SPARC32)   += muldiv.o
+obj-y                   += prom_$(BITS).o
+obj-y                   += of_device_$(BITS).o
+
+# sparc32 do not use GENERIC_HARDIRQS but uses the generic devres implementation
+obj-$(CONFIG_SPARC32)     += devres.o
+devres-y                  := ../../../kernel/irq/devres.o
+
+obj-$(CONFIG_SPARC32)     += dma.o
+
+obj-$(CONFIG_SPARC32_PCI) += pcic.o
+
+obj-$(CONFIG_SMP)         += trampoline_$(BITS).o smp_$(BITS).o
+obj-$(CONFIG_SPARC32_SMP) += sun4m_smp.o sun4d_smp.o
+
+obj-y                     += auxio_$(BITS).o
+obj-$(CONFIG_SUN_PM)      += apc.o pmc.o
+
+obj-$(CONFIG_MODULES)     += module_$(BITS).o
+obj-$(CONFIG_MODULES)     += sparc_ksyms_$(BITS).o
+obj-$(CONFIG_SPARC_LED)   += led.o
+obj-$(CONFIG_KGDB)        += kgdb_$(BITS).o
diff --git a/arch/sparc/kernel/auxio.c b/arch/sparc/kernel/auxio_32.c
similarity index 100%
rename from arch/sparc/kernel/auxio.c
rename to arch/sparc/kernel/auxio_32.c
diff --git a/arch/sparc/kernel/cpu.c b/arch/sparc/kernel/cpu_32.c
similarity index 100%
rename from arch/sparc/kernel/cpu.c
rename to arch/sparc/kernel/cpu_32.c
diff --git a/arch/sparc/kernel/etrap.S b/arch/sparc/kernel/etrap_32.S
similarity index 100%
rename from arch/sparc/kernel/etrap.S
rename to arch/sparc/kernel/etrap_32.S
diff --git a/arch/sparc/kernel/head.S b/arch/sparc/kernel/head_32.S
similarity index 100%
rename from arch/sparc/kernel/head.S
rename to arch/sparc/kernel/head_32.S
diff --git a/arch/sparc/kernel/idprom.c b/arch/sparc/kernel/idprom_32.c
similarity index 100%
rename from arch/sparc/kernel/idprom.c
rename to arch/sparc/kernel/idprom_32.c
diff --git a/arch/sparc/kernel/init_task.c b/arch/sparc/kernel/init_task_32.c
similarity index 100%
rename from arch/sparc/kernel/init_task.c
rename to arch/sparc/kernel/init_task_32.c
diff --git a/arch/sparc/kernel/irq.c b/arch/sparc/kernel/irq_32.c
similarity index 100%
rename from arch/sparc/kernel/irq.c
rename to arch/sparc/kernel/irq_32.c
diff --git a/arch/sparc/kernel/kgdb.c b/arch/sparc/kernel/kgdb_32.c
similarity index 100%
rename from arch/sparc/kernel/kgdb.c
rename to arch/sparc/kernel/kgdb_32.c
diff --git a/arch/sparc/kernel/module.c b/arch/sparc/kernel/module_32.c
similarity index 100%
rename from arch/sparc/kernel/module.c
rename to arch/sparc/kernel/module_32.c
diff --git a/arch/sparc/kernel/of_device.c b/arch/sparc/kernel/of_device_32.c
similarity index 100%
rename from arch/sparc/kernel/of_device.c
rename to arch/sparc/kernel/of_device_32.c
diff --git a/arch/sparc/kernel/process.c b/arch/sparc/kernel/process_32.c
similarity index 100%
rename from arch/sparc/kernel/process.c
rename to arch/sparc/kernel/process_32.c
diff --git a/arch/sparc/kernel/prom.c b/arch/sparc/kernel/prom_32.c
similarity index 100%
rename from arch/sparc/kernel/prom.c
rename to arch/sparc/kernel/prom_32.c
diff --git a/arch/sparc/kernel/ptrace.c b/arch/sparc/kernel/ptrace_32.c
similarity index 100%
rename from arch/sparc/kernel/ptrace.c
rename to arch/sparc/kernel/ptrace_32.c
diff --git a/arch/sparc/kernel/rtrap.S b/arch/sparc/kernel/rtrap_32.S
similarity index 100%
rename from arch/sparc/kernel/rtrap.S
rename to arch/sparc/kernel/rtrap_32.S
diff --git a/arch/sparc/kernel/setup.c b/arch/sparc/kernel/setup_32.c
similarity index 100%
rename from arch/sparc/kernel/setup.c
rename to arch/sparc/kernel/setup_32.c
diff --git a/arch/sparc/kernel/signal.c b/arch/sparc/kernel/signal_32.c
similarity index 100%
rename from arch/sparc/kernel/signal.c
rename to arch/sparc/kernel/signal_32.c
diff --git a/arch/sparc/kernel/smp.c b/arch/sparc/kernel/smp_32.c
similarity index 100%
rename from arch/sparc/kernel/smp.c
rename to arch/sparc/kernel/smp_32.c
diff --git a/arch/sparc/kernel/sparc_ksyms.c b/arch/sparc/kernel/sparc_ksyms_32.c
similarity index 100%
rename from arch/sparc/kernel/sparc_ksyms.c
rename to arch/sparc/kernel/sparc_ksyms_32.c
diff --git a/arch/sparc/kernel/sys_sparc.c b/arch/sparc/kernel/sys_sparc_32.c
similarity index 100%
rename from arch/sparc/kernel/sys_sparc.c
rename to arch/sparc/kernel/sys_sparc_32.c
diff --git a/arch/sparc/kernel/systbls.S b/arch/sparc/kernel/systbls_32.S
similarity index 100%
rename from arch/sparc/kernel/systbls.S
rename to arch/sparc/kernel/systbls_32.S
diff --git a/arch/sparc/kernel/time.c b/arch/sparc/kernel/time_32.c
similarity index 100%
rename from arch/sparc/kernel/time.c
rename to arch/sparc/kernel/time_32.c
diff --git a/arch/sparc/kernel/trampoline.S b/arch/sparc/kernel/trampoline_32.S
similarity index 100%
rename from arch/sparc/kernel/trampoline.S
rename to arch/sparc/kernel/trampoline_32.S
diff --git a/arch/sparc/kernel/traps.c b/arch/sparc/kernel/traps_32.c
similarity index 100%
rename from arch/sparc/kernel/traps.c
rename to arch/sparc/kernel/traps_32.c
diff --git a/arch/sparc/kernel/una_asm.S b/arch/sparc/kernel/una_asm_32.S
similarity index 100%
rename from arch/sparc/kernel/una_asm.S
rename to arch/sparc/kernel/una_asm_32.S
diff --git a/arch/sparc/kernel/unaligned.c b/arch/sparc/kernel/unaligned_32.c
similarity index 100%
rename from arch/sparc/kernel/unaligned.c
rename to arch/sparc/kernel/unaligned_32.c
-- 
1.5.6.GIT


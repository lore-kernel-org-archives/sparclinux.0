From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 17 Nov 2008 22:06:04 +0000
Subject: [PATCH 5/6] sparc,sparc64: unify kernel/
Message-Id: <1226959565-14796-5-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Move all files from sparc64/kernel to sparc/kernel
- The equal named was renamed to *_64.c/S

Adapt vmlinux.lds.S so it includes the correct .lds.S file
Adjust path in sparc/Makfile to point to the new directory for sparc64
Deleted now unused Makefile in saprc64/kernel/

The linking order in kernel/ has NOT been preserved for sparc64.
Preserving linking order would have resulted in a less
readable Makefile.
For sparc32 the linking order has been kept.

Some .S files are build as separate files for sparc32
but for sparc64 they are included in head_64.S.
Drop using $(BITS) in Makefile to say that this is
sparc32 specific files.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/Makefile                                |    6 +-
 arch/sparc/kernel/Makefile                         |   45 +++++++-
 arch/{sparc64 => sparc}/kernel/audit.c             |    0
 .../kernel/auxio.c => sparc/kernel/auxio_64.c}     |    0
 arch/{sparc64 => sparc}/kernel/central.c           |    0
 arch/{sparc64 => sparc}/kernel/cherrs.S            |    0
 arch/{sparc64 => sparc}/kernel/chmc.c              |    0
 arch/{sparc64 => sparc}/kernel/compat_audit.c      |    0
 .../kernel/cpu.c => sparc/kernel/cpu_64.c}         |    0
 arch/{sparc64 => sparc}/kernel/ds.c                |    0
 arch/{sparc64 => sparc}/kernel/dtlb_miss.S         |    0
 arch/{sparc64 => sparc}/kernel/dtlb_prot.S         |    0
 arch/{sparc64 => sparc}/kernel/ebus.c              |    0
 arch/{sparc64 => sparc}/kernel/entry.h             |    0
 .../kernel/etrap.S => sparc/kernel/etrap_64.S}     |    0
 arch/{sparc64 => sparc}/kernel/fpu_traps.S         |    0
 arch/{sparc64 => sparc}/kernel/ftrace.c            |    0
 arch/{sparc64 => sparc}/kernel/getsetcc.S          |    0
 .../kernel/head.S => sparc/kernel/head_64.S}       |    6 +-
 arch/{sparc64 => sparc}/kernel/helpers.S           |    0
 arch/{sparc64 => sparc}/kernel/hvapi.c             |    0
 arch/{sparc64 => sparc}/kernel/hvcalls.S           |    0
 arch/{sparc64 => sparc}/kernel/hvtramp.S           |    0
 .../kernel/idprom.c => sparc/kernel/idprom_64.c}   |    0
 .../init_task.c => sparc/kernel/init_task_64.c}    |    0
 arch/{sparc64 => sparc}/kernel/iommu.c             |    0
 arch/{sparc64 => sparc}/kernel/iommu_common.h      |    0
 .../kernel/irq.c => sparc/kernel/irq_64.c}         |    0
 arch/{sparc64 => sparc}/kernel/itlb_miss.S         |    0
 arch/{sparc64 => sparc}/kernel/ivec.S              |    0
 .../kernel/kgdb.c => sparc/kernel/kgdb_64.c}       |    0
 arch/{sparc64 => sparc}/kernel/kprobes.c           |    0
 arch/{sparc64 => sparc}/kernel/kstack.h            |    0
 arch/{sparc64 => sparc}/kernel/ktlb.S              |    0
 arch/{sparc64 => sparc}/kernel/ldc.c               |    0
 arch/{sparc64 => sparc}/kernel/mdesc.c             |    0
 arch/{sparc64 => sparc}/kernel/misctrap.S          |    0
 .../kernel/module.c => sparc/kernel/module_64.c}   |    0
 .../of_device.c => sparc/kernel/of_device_64.c}    |    0
 arch/{sparc64 => sparc}/kernel/pci.c               |    0
 arch/{sparc64 => sparc}/kernel/pci_common.c        |    0
 arch/{sparc64 => sparc}/kernel/pci_fire.c          |    0
 arch/{sparc64 => sparc}/kernel/pci_impl.h          |    0
 arch/{sparc64 => sparc}/kernel/pci_msi.c           |    0
 arch/{sparc64 => sparc}/kernel/pci_psycho.c        |    0
 arch/{sparc64 => sparc}/kernel/pci_sabre.c         |    0
 arch/{sparc64 => sparc}/kernel/pci_schizo.c        |    0
 arch/{sparc64 => sparc}/kernel/pci_sun4v.c         |    0
 arch/{sparc64 => sparc}/kernel/pci_sun4v.h         |    0
 arch/{sparc64 => sparc}/kernel/pci_sun4v_asm.S     |    0
 arch/{sparc64 => sparc}/kernel/power.c             |    0
 .../kernel/process.c => sparc/kernel/process_64.c} |    0
 .../kernel/prom.c => sparc/kernel/prom_64.c}       |    0
 arch/{sparc64 => sparc}/kernel/psycho_common.c     |    0
 arch/{sparc64 => sparc}/kernel/psycho_common.h     |    0
 .../kernel/ptrace.c => sparc/kernel/ptrace_64.c}   |    0
 arch/{sparc64 => sparc}/kernel/reboot.c            |    0
 .../kernel/rtrap.S => sparc/kernel/rtrap_64.S}     |    0
 arch/{sparc64 => sparc}/kernel/sbus.c              |    0
 .../kernel/setup.c => sparc/kernel/setup_64.c}     |    0
 arch/{sparc64 => sparc}/kernel/signal32.c          |    0
 .../kernel/signal.c => sparc/kernel/signal_64.c}   |    0
 .../kernel/smp.c => sparc/kernel/smp_64.c}         |    0
 .../kernel/sparc_ksyms_64.c}                       |    0
 arch/{sparc64 => sparc}/kernel/spiterrs.S          |    0
 arch/{sparc64 => sparc}/kernel/sstate.c            |    0
 arch/{sparc64 => sparc}/kernel/stacktrace.c        |    0
 arch/{sparc64 => sparc}/kernel/starfire.c          |    0
 arch/{sparc64 => sparc}/kernel/sun4v_ivec.S        |    0
 arch/{sparc64 => sparc}/kernel/sun4v_tlb_miss.S    |    0
 arch/{sparc64 => sparc}/kernel/sys32.S             |    0
 arch/{sparc64 => sparc}/kernel/sys_sparc32.c       |    0
 .../sys_sparc.c => sparc/kernel/sys_sparc_64.c}    |    0
 arch/{sparc64 => sparc}/kernel/syscalls.S          |    0
 arch/{sparc64 => sparc}/kernel/sysfs.c             |    0
 arch/{sparc64 => sparc}/kernel/systbls.h           |    0
 .../kernel/systbls.S => sparc/kernel/systbls_64.S} |    0
 .../kernel/time.c => sparc/kernel/time_64.c}       |    0
 .../trampoline.S => sparc/kernel/trampoline_64.S}  |    0
 .../kernel/traps.c => sparc/kernel/traps_64.c}     |    0
 arch/{sparc64 => sparc}/kernel/tsb.S               |    0
 arch/{sparc64 => sparc}/kernel/ttable.S            |    0
 .../kernel/una_asm.S => sparc/kernel/una_asm_64.S} |    0
 .../unaligned.c => sparc/kernel/unaligned_64.c}    |    0
 arch/{sparc64 => sparc}/kernel/us2e_cpufreq.c      |    0
 arch/{sparc64 => sparc}/kernel/us3_cpufreq.c       |    0
 arch/{sparc64 => sparc}/kernel/utrap.S             |    0
 arch/{sparc64 => sparc}/kernel/vio.c               |    0
 arch/{sparc64 => sparc}/kernel/viohs.c             |    0
 arch/{sparc64 => sparc}/kernel/visemul.c           |    0
 arch/sparc/kernel/vmlinux.lds.S                    |  121 +-------------------
 .../kernel/{vmlinux.lds.S => vmlinux_32.lds.S}     |    0
 .../kernel/vmlinux_64.lds.S}                       |    0
 arch/{sparc64 => sparc}/kernel/winfixup.S          |    0
 arch/sparc64/kernel/Makefile                       |   36 ------
 95 files changed, 53 insertions(+), 161 deletions(-)
 rename arch/{sparc64 => sparc}/kernel/audit.c (100%)
 rename arch/{sparc64/kernel/auxio.c => sparc/kernel/auxio_64.c} (100%)
 rename arch/{sparc64 => sparc}/kernel/central.c (100%)
 rename arch/{sparc64 => sparc}/kernel/cherrs.S (100%)
 rename arch/{sparc64 => sparc}/kernel/chmc.c (100%)
 rename arch/{sparc64 => sparc}/kernel/compat_audit.c (100%)
 rename arch/{sparc64/kernel/cpu.c => sparc/kernel/cpu_64.c} (100%)
 rename arch/{sparc64 => sparc}/kernel/ds.c (100%)
 rename arch/{sparc64 => sparc}/kernel/dtlb_miss.S (100%)
 rename arch/{sparc64 => sparc}/kernel/dtlb_prot.S (100%)
 rename arch/{sparc64 => sparc}/kernel/ebus.c (100%)
 rename arch/{sparc64 => sparc}/kernel/entry.h (100%)
 rename arch/{sparc64/kernel/etrap.S => sparc/kernel/etrap_64.S} (100%)
 rename arch/{sparc64 => sparc}/kernel/fpu_traps.S (100%)
 rename arch/{sparc64 => sparc}/kernel/ftrace.c (100%)
 rename arch/{sparc64 => sparc}/kernel/getsetcc.S (100%)
 rename arch/{sparc64/kernel/head.S => sparc/kernel/head_64.S} (99%)
 rename arch/{sparc64 => sparc}/kernel/helpers.S (100%)
 rename arch/{sparc64 => sparc}/kernel/hvapi.c (100%)
 rename arch/{sparc64 => sparc}/kernel/hvcalls.S (100%)
 rename arch/{sparc64 => sparc}/kernel/hvtramp.S (100%)
 rename arch/{sparc64/kernel/idprom.c => sparc/kernel/idprom_64.c} (100%)
 rename arch/{sparc64/kernel/init_task.c => sparc/kernel/init_task_64.c} (100%)
 rename arch/{sparc64 => sparc}/kernel/iommu.c (100%)
 rename arch/{sparc64 => sparc}/kernel/iommu_common.h (100%)
 rename arch/{sparc64/kernel/irq.c => sparc/kernel/irq_64.c} (100%)
 rename arch/{sparc64 => sparc}/kernel/itlb_miss.S (100%)
 rename arch/{sparc64 => sparc}/kernel/ivec.S (100%)
 rename arch/{sparc64/kernel/kgdb.c => sparc/kernel/kgdb_64.c} (100%)
 rename arch/{sparc64 => sparc}/kernel/kprobes.c (100%)
 rename arch/{sparc64 => sparc}/kernel/kstack.h (100%)
 rename arch/{sparc64 => sparc}/kernel/ktlb.S (100%)
 rename arch/{sparc64 => sparc}/kernel/ldc.c (100%)
 rename arch/{sparc64 => sparc}/kernel/mdesc.c (100%)
 rename arch/{sparc64 => sparc}/kernel/misctrap.S (100%)
 rename arch/{sparc64/kernel/module.c => sparc/kernel/module_64.c} (100%)
 rename arch/{sparc64/kernel/of_device.c => sparc/kernel/of_device_64.c} (100%)
 rename arch/{sparc64 => sparc}/kernel/pci.c (100%)
 rename arch/{sparc64 => sparc}/kernel/pci_common.c (100%)
 rename arch/{sparc64 => sparc}/kernel/pci_fire.c (100%)
 rename arch/{sparc64 => sparc}/kernel/pci_impl.h (100%)
 rename arch/{sparc64 => sparc}/kernel/pci_msi.c (100%)
 rename arch/{sparc64 => sparc}/kernel/pci_psycho.c (100%)
 rename arch/{sparc64 => sparc}/kernel/pci_sabre.c (100%)
 rename arch/{sparc64 => sparc}/kernel/pci_schizo.c (100%)
 rename arch/{sparc64 => sparc}/kernel/pci_sun4v.c (100%)
 rename arch/{sparc64 => sparc}/kernel/pci_sun4v.h (100%)
 rename arch/{sparc64 => sparc}/kernel/pci_sun4v_asm.S (100%)
 rename arch/{sparc64 => sparc}/kernel/power.c (100%)
 rename arch/{sparc64/kernel/process.c => sparc/kernel/process_64.c} (100%)
 rename arch/{sparc64/kernel/prom.c => sparc/kernel/prom_64.c} (100%)
 rename arch/{sparc64 => sparc}/kernel/psycho_common.c (100%)
 rename arch/{sparc64 => sparc}/kernel/psycho_common.h (100%)
 rename arch/{sparc64/kernel/ptrace.c => sparc/kernel/ptrace_64.c} (100%)
 rename arch/{sparc64 => sparc}/kernel/reboot.c (100%)
 rename arch/{sparc64/kernel/rtrap.S => sparc/kernel/rtrap_64.S} (100%)
 rename arch/{sparc64 => sparc}/kernel/sbus.c (100%)
 rename arch/{sparc64/kernel/setup.c => sparc/kernel/setup_64.c} (100%)
 rename arch/{sparc64 => sparc}/kernel/signal32.c (100%)
 rename arch/{sparc64/kernel/signal.c => sparc/kernel/signal_64.c} (100%)
 rename arch/{sparc64/kernel/smp.c => sparc/kernel/smp_64.c} (100%)
 rename arch/{sparc64/kernel/sparc64_ksyms.c => sparc/kernel/sparc_ksyms_64.c} (100%)
 rename arch/{sparc64 => sparc}/kernel/spiterrs.S (100%)
 rename arch/{sparc64 => sparc}/kernel/sstate.c (100%)
 rename arch/{sparc64 => sparc}/kernel/stacktrace.c (100%)
 rename arch/{sparc64 => sparc}/kernel/starfire.c (100%)
 rename arch/{sparc64 => sparc}/kernel/sun4v_ivec.S (100%)
 rename arch/{sparc64 => sparc}/kernel/sun4v_tlb_miss.S (100%)
 rename arch/{sparc64 => sparc}/kernel/sys32.S (100%)
 rename arch/{sparc64 => sparc}/kernel/sys_sparc32.c (100%)
 rename arch/{sparc64/kernel/sys_sparc.c => sparc/kernel/sys_sparc_64.c} (100%)
 rename arch/{sparc64 => sparc}/kernel/syscalls.S (100%)
 rename arch/{sparc64 => sparc}/kernel/sysfs.c (100%)
 rename arch/{sparc64 => sparc}/kernel/systbls.h (100%)
 rename arch/{sparc64/kernel/systbls.S => sparc/kernel/systbls_64.S} (100%)
 rename arch/{sparc64/kernel/time.c => sparc/kernel/time_64.c} (100%)
 rename arch/{sparc64/kernel/trampoline.S => sparc/kernel/trampoline_64.S} (100%)
 rename arch/{sparc64/kernel/traps.c => sparc/kernel/traps_64.c} (100%)
 rename arch/{sparc64 => sparc}/kernel/tsb.S (100%)
 rename arch/{sparc64 => sparc}/kernel/ttable.S (100%)
 rename arch/{sparc64/kernel/una_asm.S => sparc/kernel/una_asm_64.S} (100%)
 rename arch/{sparc64/kernel/unaligned.c => sparc/kernel/unaligned_64.c} (100%)
 rename arch/{sparc64 => sparc}/kernel/us2e_cpufreq.c (100%)
 rename arch/{sparc64 => sparc}/kernel/us3_cpufreq.c (100%)
 rename arch/{sparc64 => sparc}/kernel/utrap.S (100%)
 rename arch/{sparc64 => sparc}/kernel/vio.c (100%)
 rename arch/{sparc64 => sparc}/kernel/viohs.c (100%)
 rename arch/{sparc64 => sparc}/kernel/visemul.c (100%)
 rewrite arch/sparc/kernel/vmlinux.lds.S (99%)
 rename arch/sparc/kernel/{vmlinux.lds.S => vmlinux_32.lds.S} (100%)
 rename arch/{sparc64/kernel/vmlinux.lds.S => sparc/kernel/vmlinux_64.lds.S} (100%)
 rename arch/{sparc64 => sparc}/kernel/winfixup.S (100%)
 delete mode 100644 arch/sparc64/kernel/Makefile

diff --git a/arch/sparc/Makefile b/arch/sparc/Makefile
index c47f274..283f339 100644
--- a/arch/sparc/Makefile
+++ b/arch/sparc/Makefile
@@ -38,7 +38,7 @@ CPPFLAGS_vmlinux.lds += -m32
 #  Actual linking is done with "make image".
 LDFLAGS_vmlinux = -r
 
-head-y := arch/sparc/kernel/head.o arch/sparc/kernel/init_task.o
+head-y := arch/sparc/kernel/head_32.o arch/sparc/kernel/init_task_32.o
 HEAD_Y := $(head-y)
 
 core-y += arch/sparc/kernel/ arch/sparc/mm/ arch/sparc/math-emu/
@@ -92,9 +92,9 @@ ifeq ($(CONFIG_MCOUNT),y)
   KBUILD_CFLAGS += -pg
 endif
 
-head-y := arch/sparc64/kernel/head.o arch/sparc64/kernel/init_task.o
+head-y := arch/sparc/kernel/head_64.o arch/sparc/kernel/init_task_64.o
 
-core-y                          += arch/sparc64/kernel/ arch/sparc/mm/
+core-y                          += arch/sparc/kernel/ arch/sparc/mm/
 core-y                          += arch/sparc/math-emu/
 libs-y                          += arch/sparc/prom/ arch/sparc64/lib/
 drivers-$(CONFIG_OPROFILE)      += arch/sparc/oprofile/
diff --git a/arch/sparc/kernel/Makefile b/arch/sparc/kernel/Makefile
index df6cc9a..a04fca5 100644
--- a/arch/sparc/kernel/Makefile
+++ b/arch/sparc/kernel/Makefile
@@ -10,8 +10,8 @@ extra-y     += init_task_$(BITS).o
 extra-y     += vmlinux.lds
 
 obj-$(CONFIG_SPARC32)   += entry.o wof.o wuf.o
-obj-y                   += etrap_$(BITS).o
-obj-y                   += rtrap_$(BITS).o
+obj-$(CONFIG_SPARC32)   += etrap_32.o
+obj-$(CONFIG_SPARC32)   += rtrap_32.o
 obj-y                   += traps_$(BITS).o
 
 # IRQ
@@ -24,7 +24,7 @@ obj-$(CONFIG_SPARC32)   += ioport.o
 obj-y                   += setup_$(BITS).o
 obj-y                   += idprom_$(BITS).o
 obj-y                   += sys_sparc_$(BITS).o
-obj-y                   += systbls_$(BITS).o
+obj-$(CONFIG_SPARC32)   += systbls_32.o
 obj-y                   += time_$(BITS).o
 obj-$(CONFIG_SPARC32)   += windows.o
 obj-y                   += cpu_$(BITS).o
@@ -38,6 +38,19 @@ obj-$(CONFIG_SPARC32)   += muldiv.o
 obj-y                   += prom_$(BITS).o
 obj-y                   += of_device_$(BITS).o
 
+obj-$(CONFIG_SPARC64)  += reboot.o
+obj-$(CONFIG_SPARC64)  += sysfs.o
+obj-$(CONFIG_SPARC64)  += iommu.o
+obj-$(CONFIG_SPARC64)  += central.o
+obj-$(CONFIG_SPARC64)  += starfire.o
+obj-$(CONFIG_SPARC64)  += power.o
+obj-$(CONFIG_SPARC64)  += sbus.o
+obj-$(CONFIG_SPARC64)  += ebus.o
+obj-$(CONFIG_SPARC64)  += visemul.o
+obj-$(CONFIG_SPARC64)  += hvapi.o
+obj-$(CONFIG_SPARC64)  += sstate.o
+obj-$(CONFIG_SPARC64)  += mdesc.o
+
 # sparc32 do not use GENERIC_HARDIRQS but uses the generic devres implmentation
 obj-$(CONFIG_SPARC32)     += devres.o
 devres-y                  := ../../../kernel/irq/devres.o
@@ -48,6 +61,7 @@ obj-$(CONFIG_SPARC32_PCI) += pcic.o
 
 obj-$(CONFIG_SMP)         += trampoline_$(BITS).o smp_$(BITS).o
 obj-$(CONFIG_SPARC32_SMP) += sun4m_smp.o sun4d_smp.o
+obj-$(CONFIG_SPARC64_SMP) += hvtramp.o
 
 obj-y                     += auxio_$(BITS).o
 obj-$(CONFIG_SUN_PM)      += apc.o pmc.o
@@ -56,3 +70,28 @@ obj-$(CONFIG_MODULES)     += module_$(BITS).o
 obj-$(CONFIG_MODULES)     += sparc_ksyms_$(BITS).o
 obj-$(CONFIG_SPARC_LED)   += led.o
 obj-$(CONFIG_KGDB)        += kgdb_$(BITS).o
+
+
+obj-$(CONFIG_DYNAMIC_FTRACE) += ftrace.o
+CFLAGS_REMOVE_ftrace.o := -pg
+
+obj-$(CONFIG_STACKTRACE)     += stacktrace.o
+# sparc64 PCI
+obj-$(CONFIG_SPARC64_PCI)    += pci.o pci_common.o psycho_common.o
+obj-$(CONFIG_SPARC64_PCI)    += pci_psycho.o pci_sabre.o pci_schizo.o
+obj-$(CONFIG_SPARC64_PCI)    += pci_sun4v.o pci_sun4v_asm.o pci_fire.o
+obj-$(CONFIG_PCI_MSI)        += pci_msi.o
+
+obj-$(CONFIG_COMPAT)         += sys32.o sys_sparc32.o signal32.o
+
+# sparc64 cpufreq
+obj-$(CONFIG_US3_FREQ)  += us3_cpufreq.o
+obj-$(CONFIG_US2E_FREQ) += us2e_cpufreq.o
+obj-$(CONFIG_US3_MC)    += chmc.o
+
+obj-$(CONFIG_KPROBES)   += kprobes.o
+obj-$(CONFIG_SUN_LDOMS) += ldc.o vio.o viohs.o ds.o
+
+obj-$(CONFIG_AUDIT)     += audit.o
+audit--$(CONFIG_AUDIT)  := compat_audit.o
+obj-$(CONFIG_COMPAT)    += $(audit--y)
diff --git a/arch/sparc64/kernel/audit.c b/arch/sparc/kernel/audit.c
similarity index 100%
rename from arch/sparc64/kernel/audit.c
rename to arch/sparc/kernel/audit.c
diff --git a/arch/sparc64/kernel/auxio.c b/arch/sparc/kernel/auxio_64.c
similarity index 100%
rename from arch/sparc64/kernel/auxio.c
rename to arch/sparc/kernel/auxio_64.c
diff --git a/arch/sparc64/kernel/central.c b/arch/sparc/kernel/central.c
similarity index 100%
rename from arch/sparc64/kernel/central.c
rename to arch/sparc/kernel/central.c
diff --git a/arch/sparc64/kernel/cherrs.S b/arch/sparc/kernel/cherrs.S
similarity index 100%
rename from arch/sparc64/kernel/cherrs.S
rename to arch/sparc/kernel/cherrs.S
diff --git a/arch/sparc64/kernel/chmc.c b/arch/sparc/kernel/chmc.c
similarity index 100%
rename from arch/sparc64/kernel/chmc.c
rename to arch/sparc/kernel/chmc.c
diff --git a/arch/sparc64/kernel/compat_audit.c b/arch/sparc/kernel/compat_audit.c
similarity index 100%
rename from arch/sparc64/kernel/compat_audit.c
rename to arch/sparc/kernel/compat_audit.c
diff --git a/arch/sparc64/kernel/cpu.c b/arch/sparc/kernel/cpu_64.c
similarity index 100%
rename from arch/sparc64/kernel/cpu.c
rename to arch/sparc/kernel/cpu_64.c
diff --git a/arch/sparc64/kernel/ds.c b/arch/sparc/kernel/ds.c
similarity index 100%
rename from arch/sparc64/kernel/ds.c
rename to arch/sparc/kernel/ds.c
diff --git a/arch/sparc64/kernel/dtlb_miss.S b/arch/sparc/kernel/dtlb_miss.S
similarity index 100%
rename from arch/sparc64/kernel/dtlb_miss.S
rename to arch/sparc/kernel/dtlb_miss.S
diff --git a/arch/sparc64/kernel/dtlb_prot.S b/arch/sparc/kernel/dtlb_prot.S
similarity index 100%
rename from arch/sparc64/kernel/dtlb_prot.S
rename to arch/sparc/kernel/dtlb_prot.S
diff --git a/arch/sparc64/kernel/ebus.c b/arch/sparc/kernel/ebus.c
similarity index 100%
rename from arch/sparc64/kernel/ebus.c
rename to arch/sparc/kernel/ebus.c
diff --git a/arch/sparc64/kernel/entry.h b/arch/sparc/kernel/entry.h
similarity index 100%
rename from arch/sparc64/kernel/entry.h
rename to arch/sparc/kernel/entry.h
diff --git a/arch/sparc64/kernel/etrap.S b/arch/sparc/kernel/etrap_64.S
similarity index 100%
rename from arch/sparc64/kernel/etrap.S
rename to arch/sparc/kernel/etrap_64.S
diff --git a/arch/sparc64/kernel/fpu_traps.S b/arch/sparc/kernel/fpu_traps.S
similarity index 100%
rename from arch/sparc64/kernel/fpu_traps.S
rename to arch/sparc/kernel/fpu_traps.S
diff --git a/arch/sparc64/kernel/ftrace.c b/arch/sparc/kernel/ftrace.c
similarity index 100%
rename from arch/sparc64/kernel/ftrace.c
rename to arch/sparc/kernel/ftrace.c
diff --git a/arch/sparc64/kernel/getsetcc.S b/arch/sparc/kernel/getsetcc.S
similarity index 100%
rename from arch/sparc64/kernel/getsetcc.S
rename to arch/sparc/kernel/getsetcc.S
diff --git a/arch/sparc64/kernel/head.S b/arch/sparc/kernel/head_64.S
similarity index 99%
rename from arch/sparc64/kernel/head.S
rename to arch/sparc/kernel/head_64.S
index 353226f..313e4a4 100644
--- a/arch/sparc64/kernel/head.S
+++ b/arch/sparc/kernel/head_64.S
@@ -825,8 +825,8 @@ setup_tba:
 	 restore
 sparc64_boot_end:
 
-#include "etrap.S"
-#include "rtrap.S"
+#include "etrap_64.S"
+#include "rtrap_64.S"
 #include "winfixup.S"
 #include "fpu_traps.S"
 #include "ivec.S"
@@ -882,7 +882,7 @@ swapper_4m_tsb:
 
 ! 0x0000000000428000
 
-#include "systbls.S"
+#include "systbls_64.S"
 
 	.data
 	.align	8
diff --git a/arch/sparc64/kernel/helpers.S b/arch/sparc/kernel/helpers.S
similarity index 100%
rename from arch/sparc64/kernel/helpers.S
rename to arch/sparc/kernel/helpers.S
diff --git a/arch/sparc64/kernel/hvapi.c b/arch/sparc/kernel/hvapi.c
similarity index 100%
rename from arch/sparc64/kernel/hvapi.c
rename to arch/sparc/kernel/hvapi.c
diff --git a/arch/sparc64/kernel/hvcalls.S b/arch/sparc/kernel/hvcalls.S
similarity index 100%
rename from arch/sparc64/kernel/hvcalls.S
rename to arch/sparc/kernel/hvcalls.S
diff --git a/arch/sparc64/kernel/hvtramp.S b/arch/sparc/kernel/hvtramp.S
similarity index 100%
rename from arch/sparc64/kernel/hvtramp.S
rename to arch/sparc/kernel/hvtramp.S
diff --git a/arch/sparc64/kernel/idprom.c b/arch/sparc/kernel/idprom_64.c
similarity index 100%
rename from arch/sparc64/kernel/idprom.c
rename to arch/sparc/kernel/idprom_64.c
diff --git a/arch/sparc64/kernel/init_task.c b/arch/sparc/kernel/init_task_64.c
similarity index 100%
rename from arch/sparc64/kernel/init_task.c
rename to arch/sparc/kernel/init_task_64.c
diff --git a/arch/sparc64/kernel/iommu.c b/arch/sparc/kernel/iommu.c
similarity index 100%
rename from arch/sparc64/kernel/iommu.c
rename to arch/sparc/kernel/iommu.c
diff --git a/arch/sparc64/kernel/iommu_common.h b/arch/sparc/kernel/iommu_common.h
similarity index 100%
rename from arch/sparc64/kernel/iommu_common.h
rename to arch/sparc/kernel/iommu_common.h
diff --git a/arch/sparc64/kernel/irq.c b/arch/sparc/kernel/irq_64.c
similarity index 100%
rename from arch/sparc64/kernel/irq.c
rename to arch/sparc/kernel/irq_64.c
diff --git a/arch/sparc64/kernel/itlb_miss.S b/arch/sparc/kernel/itlb_miss.S
similarity index 100%
rename from arch/sparc64/kernel/itlb_miss.S
rename to arch/sparc/kernel/itlb_miss.S
diff --git a/arch/sparc64/kernel/ivec.S b/arch/sparc/kernel/ivec.S
similarity index 100%
rename from arch/sparc64/kernel/ivec.S
rename to arch/sparc/kernel/ivec.S
diff --git a/arch/sparc64/kernel/kgdb.c b/arch/sparc/kernel/kgdb_64.c
similarity index 100%
rename from arch/sparc64/kernel/kgdb.c
rename to arch/sparc/kernel/kgdb_64.c
diff --git a/arch/sparc64/kernel/kprobes.c b/arch/sparc/kernel/kprobes.c
similarity index 100%
rename from arch/sparc64/kernel/kprobes.c
rename to arch/sparc/kernel/kprobes.c
diff --git a/arch/sparc64/kernel/kstack.h b/arch/sparc/kernel/kstack.h
similarity index 100%
rename from arch/sparc64/kernel/kstack.h
rename to arch/sparc/kernel/kstack.h
diff --git a/arch/sparc64/kernel/ktlb.S b/arch/sparc/kernel/ktlb.S
similarity index 100%
rename from arch/sparc64/kernel/ktlb.S
rename to arch/sparc/kernel/ktlb.S
diff --git a/arch/sparc64/kernel/ldc.c b/arch/sparc/kernel/ldc.c
similarity index 100%
rename from arch/sparc64/kernel/ldc.c
rename to arch/sparc/kernel/ldc.c
diff --git a/arch/sparc64/kernel/mdesc.c b/arch/sparc/kernel/mdesc.c
similarity index 100%
rename from arch/sparc64/kernel/mdesc.c
rename to arch/sparc/kernel/mdesc.c
diff --git a/arch/sparc64/kernel/misctrap.S b/arch/sparc/kernel/misctrap.S
similarity index 100%
rename from arch/sparc64/kernel/misctrap.S
rename to arch/sparc/kernel/misctrap.S
diff --git a/arch/sparc64/kernel/module.c b/arch/sparc/kernel/module_64.c
similarity index 100%
rename from arch/sparc64/kernel/module.c
rename to arch/sparc/kernel/module_64.c
diff --git a/arch/sparc64/kernel/of_device.c b/arch/sparc/kernel/of_device_64.c
similarity index 100%
rename from arch/sparc64/kernel/of_device.c
rename to arch/sparc/kernel/of_device_64.c
diff --git a/arch/sparc64/kernel/pci.c b/arch/sparc/kernel/pci.c
similarity index 100%
rename from arch/sparc64/kernel/pci.c
rename to arch/sparc/kernel/pci.c
diff --git a/arch/sparc64/kernel/pci_common.c b/arch/sparc/kernel/pci_common.c
similarity index 100%
rename from arch/sparc64/kernel/pci_common.c
rename to arch/sparc/kernel/pci_common.c
diff --git a/arch/sparc64/kernel/pci_fire.c b/arch/sparc/kernel/pci_fire.c
similarity index 100%
rename from arch/sparc64/kernel/pci_fire.c
rename to arch/sparc/kernel/pci_fire.c
diff --git a/arch/sparc64/kernel/pci_impl.h b/arch/sparc/kernel/pci_impl.h
similarity index 100%
rename from arch/sparc64/kernel/pci_impl.h
rename to arch/sparc/kernel/pci_impl.h
diff --git a/arch/sparc64/kernel/pci_msi.c b/arch/sparc/kernel/pci_msi.c
similarity index 100%
rename from arch/sparc64/kernel/pci_msi.c
rename to arch/sparc/kernel/pci_msi.c
diff --git a/arch/sparc64/kernel/pci_psycho.c b/arch/sparc/kernel/pci_psycho.c
similarity index 100%
rename from arch/sparc64/kernel/pci_psycho.c
rename to arch/sparc/kernel/pci_psycho.c
diff --git a/arch/sparc64/kernel/pci_sabre.c b/arch/sparc/kernel/pci_sabre.c
similarity index 100%
rename from arch/sparc64/kernel/pci_sabre.c
rename to arch/sparc/kernel/pci_sabre.c
diff --git a/arch/sparc64/kernel/pci_schizo.c b/arch/sparc/kernel/pci_schizo.c
similarity index 100%
rename from arch/sparc64/kernel/pci_schizo.c
rename to arch/sparc/kernel/pci_schizo.c
diff --git a/arch/sparc64/kernel/pci_sun4v.c b/arch/sparc/kernel/pci_sun4v.c
similarity index 100%
rename from arch/sparc64/kernel/pci_sun4v.c
rename to arch/sparc/kernel/pci_sun4v.c
diff --git a/arch/sparc64/kernel/pci_sun4v.h b/arch/sparc/kernel/pci_sun4v.h
similarity index 100%
rename from arch/sparc64/kernel/pci_sun4v.h
rename to arch/sparc/kernel/pci_sun4v.h
diff --git a/arch/sparc64/kernel/pci_sun4v_asm.S b/arch/sparc/kernel/pci_sun4v_asm.S
similarity index 100%
rename from arch/sparc64/kernel/pci_sun4v_asm.S
rename to arch/sparc/kernel/pci_sun4v_asm.S
diff --git a/arch/sparc64/kernel/power.c b/arch/sparc/kernel/power.c
similarity index 100%
rename from arch/sparc64/kernel/power.c
rename to arch/sparc/kernel/power.c
diff --git a/arch/sparc64/kernel/process.c b/arch/sparc/kernel/process_64.c
similarity index 100%
rename from arch/sparc64/kernel/process.c
rename to arch/sparc/kernel/process_64.c
diff --git a/arch/sparc64/kernel/prom.c b/arch/sparc/kernel/prom_64.c
similarity index 100%
rename from arch/sparc64/kernel/prom.c
rename to arch/sparc/kernel/prom_64.c
diff --git a/arch/sparc64/kernel/psycho_common.c b/arch/sparc/kernel/psycho_common.c
similarity index 100%
rename from arch/sparc64/kernel/psycho_common.c
rename to arch/sparc/kernel/psycho_common.c
diff --git a/arch/sparc64/kernel/psycho_common.h b/arch/sparc/kernel/psycho_common.h
similarity index 100%
rename from arch/sparc64/kernel/psycho_common.h
rename to arch/sparc/kernel/psycho_common.h
diff --git a/arch/sparc64/kernel/ptrace.c b/arch/sparc/kernel/ptrace_64.c
similarity index 100%
rename from arch/sparc64/kernel/ptrace.c
rename to arch/sparc/kernel/ptrace_64.c
diff --git a/arch/sparc64/kernel/reboot.c b/arch/sparc/kernel/reboot.c
similarity index 100%
rename from arch/sparc64/kernel/reboot.c
rename to arch/sparc/kernel/reboot.c
diff --git a/arch/sparc64/kernel/rtrap.S b/arch/sparc/kernel/rtrap_64.S
similarity index 100%
rename from arch/sparc64/kernel/rtrap.S
rename to arch/sparc/kernel/rtrap_64.S
diff --git a/arch/sparc64/kernel/sbus.c b/arch/sparc/kernel/sbus.c
similarity index 100%
rename from arch/sparc64/kernel/sbus.c
rename to arch/sparc/kernel/sbus.c
diff --git a/arch/sparc64/kernel/setup.c b/arch/sparc/kernel/setup_64.c
similarity index 100%
rename from arch/sparc64/kernel/setup.c
rename to arch/sparc/kernel/setup_64.c
diff --git a/arch/sparc64/kernel/signal32.c b/arch/sparc/kernel/signal32.c
similarity index 100%
rename from arch/sparc64/kernel/signal32.c
rename to arch/sparc/kernel/signal32.c
diff --git a/arch/sparc64/kernel/signal.c b/arch/sparc/kernel/signal_64.c
similarity index 100%
rename from arch/sparc64/kernel/signal.c
rename to arch/sparc/kernel/signal_64.c
diff --git a/arch/sparc64/kernel/smp.c b/arch/sparc/kernel/smp_64.c
similarity index 100%
rename from arch/sparc64/kernel/smp.c
rename to arch/sparc/kernel/smp_64.c
diff --git a/arch/sparc64/kernel/sparc64_ksyms.c b/arch/sparc/kernel/sparc_ksyms_64.c
similarity index 100%
rename from arch/sparc64/kernel/sparc64_ksyms.c
rename to arch/sparc/kernel/sparc_ksyms_64.c
diff --git a/arch/sparc64/kernel/spiterrs.S b/arch/sparc/kernel/spiterrs.S
similarity index 100%
rename from arch/sparc64/kernel/spiterrs.S
rename to arch/sparc/kernel/spiterrs.S
diff --git a/arch/sparc64/kernel/sstate.c b/arch/sparc/kernel/sstate.c
similarity index 100%
rename from arch/sparc64/kernel/sstate.c
rename to arch/sparc/kernel/sstate.c
diff --git a/arch/sparc64/kernel/stacktrace.c b/arch/sparc/kernel/stacktrace.c
similarity index 100%
rename from arch/sparc64/kernel/stacktrace.c
rename to arch/sparc/kernel/stacktrace.c
diff --git a/arch/sparc64/kernel/starfire.c b/arch/sparc/kernel/starfire.c
similarity index 100%
rename from arch/sparc64/kernel/starfire.c
rename to arch/sparc/kernel/starfire.c
diff --git a/arch/sparc64/kernel/sun4v_ivec.S b/arch/sparc/kernel/sun4v_ivec.S
similarity index 100%
rename from arch/sparc64/kernel/sun4v_ivec.S
rename to arch/sparc/kernel/sun4v_ivec.S
diff --git a/arch/sparc64/kernel/sun4v_tlb_miss.S b/arch/sparc/kernel/sun4v_tlb_miss.S
similarity index 100%
rename from arch/sparc64/kernel/sun4v_tlb_miss.S
rename to arch/sparc/kernel/sun4v_tlb_miss.S
diff --git a/arch/sparc64/kernel/sys32.S b/arch/sparc/kernel/sys32.S
similarity index 100%
rename from arch/sparc64/kernel/sys32.S
rename to arch/sparc/kernel/sys32.S
diff --git a/arch/sparc64/kernel/sys_sparc32.c b/arch/sparc/kernel/sys_sparc32.c
similarity index 100%
rename from arch/sparc64/kernel/sys_sparc32.c
rename to arch/sparc/kernel/sys_sparc32.c
diff --git a/arch/sparc64/kernel/sys_sparc.c b/arch/sparc/kernel/sys_sparc_64.c
similarity index 100%
rename from arch/sparc64/kernel/sys_sparc.c
rename to arch/sparc/kernel/sys_sparc_64.c
diff --git a/arch/sparc64/kernel/syscalls.S b/arch/sparc/kernel/syscalls.S
similarity index 100%
rename from arch/sparc64/kernel/syscalls.S
rename to arch/sparc/kernel/syscalls.S
diff --git a/arch/sparc64/kernel/sysfs.c b/arch/sparc/kernel/sysfs.c
similarity index 100%
rename from arch/sparc64/kernel/sysfs.c
rename to arch/sparc/kernel/sysfs.c
diff --git a/arch/sparc64/kernel/systbls.h b/arch/sparc/kernel/systbls.h
similarity index 100%
rename from arch/sparc64/kernel/systbls.h
rename to arch/sparc/kernel/systbls.h
diff --git a/arch/sparc64/kernel/systbls.S b/arch/sparc/kernel/systbls_64.S
similarity index 100%
rename from arch/sparc64/kernel/systbls.S
rename to arch/sparc/kernel/systbls_64.S
diff --git a/arch/sparc64/kernel/time.c b/arch/sparc/kernel/time_64.c
similarity index 100%
rename from arch/sparc64/kernel/time.c
rename to arch/sparc/kernel/time_64.c
diff --git a/arch/sparc64/kernel/trampoline.S b/arch/sparc/kernel/trampoline_64.S
similarity index 100%
rename from arch/sparc64/kernel/trampoline.S
rename to arch/sparc/kernel/trampoline_64.S
diff --git a/arch/sparc64/kernel/traps.c b/arch/sparc/kernel/traps_64.c
similarity index 100%
rename from arch/sparc64/kernel/traps.c
rename to arch/sparc/kernel/traps_64.c
diff --git a/arch/sparc64/kernel/tsb.S b/arch/sparc/kernel/tsb.S
similarity index 100%
rename from arch/sparc64/kernel/tsb.S
rename to arch/sparc/kernel/tsb.S
diff --git a/arch/sparc64/kernel/ttable.S b/arch/sparc/kernel/ttable.S
similarity index 100%
rename from arch/sparc64/kernel/ttable.S
rename to arch/sparc/kernel/ttable.S
diff --git a/arch/sparc64/kernel/una_asm.S b/arch/sparc/kernel/una_asm_64.S
similarity index 100%
rename from arch/sparc64/kernel/una_asm.S
rename to arch/sparc/kernel/una_asm_64.S
diff --git a/arch/sparc64/kernel/unaligned.c b/arch/sparc/kernel/unaligned_64.c
similarity index 100%
rename from arch/sparc64/kernel/unaligned.c
rename to arch/sparc/kernel/unaligned_64.c
diff --git a/arch/sparc64/kernel/us2e_cpufreq.c b/arch/sparc/kernel/us2e_cpufreq.c
similarity index 100%
rename from arch/sparc64/kernel/us2e_cpufreq.c
rename to arch/sparc/kernel/us2e_cpufreq.c
diff --git a/arch/sparc64/kernel/us3_cpufreq.c b/arch/sparc/kernel/us3_cpufreq.c
similarity index 100%
rename from arch/sparc64/kernel/us3_cpufreq.c
rename to arch/sparc/kernel/us3_cpufreq.c
diff --git a/arch/sparc64/kernel/utrap.S b/arch/sparc/kernel/utrap.S
similarity index 100%
rename from arch/sparc64/kernel/utrap.S
rename to arch/sparc/kernel/utrap.S
diff --git a/arch/sparc64/kernel/vio.c b/arch/sparc/kernel/vio.c
similarity index 100%
rename from arch/sparc64/kernel/vio.c
rename to arch/sparc/kernel/vio.c
diff --git a/arch/sparc64/kernel/viohs.c b/arch/sparc/kernel/viohs.c
similarity index 100%
rename from arch/sparc64/kernel/viohs.c
rename to arch/sparc/kernel/viohs.c
diff --git a/arch/sparc64/kernel/visemul.c b/arch/sparc/kernel/visemul.c
similarity index 100%
rename from arch/sparc64/kernel/visemul.c
rename to arch/sparc/kernel/visemul.c
diff --git a/arch/sparc/kernel/vmlinux.lds.S b/arch/sparc/kernel/vmlinux.lds.S
dissimilarity index 99%
index b1002c6..ef6cfe8 100644
--- a/arch/sparc/kernel/vmlinux.lds.S
+++ b/arch/sparc/kernel/vmlinux.lds.S
@@ -1,116 +1,5 @@
-/* ld script to make SparcLinux kernel */
-
-#include <asm-generic/vmlinux.lds.h>
-#include <asm/page.h>
-
-OUTPUT_FORMAT("elf32-sparc", "elf32-sparc", "elf32-sparc")
-OUTPUT_ARCH(sparc)
-ENTRY(_start)
-jiffies = jiffies_64 + 4;
-SECTIONS
-{
-	. = 0x10000 + SIZEOF_HEADERS;
-	.text 0xf0004000 :
-	{
-		_text = .;
-		TEXT_TEXT
-		SCHED_TEXT
-		LOCK_TEXT
-		*(.gnu.warning)
-	} = 0
-	_etext = .;
-	PROVIDE (etext = .);
-	RODATA
-	.data :	{
-		DATA_DATA
-		CONSTRUCTORS
-	}
-	.data1 : {
-		*(.data1)
-	}
-	_edata = .;
-	PROVIDE (edata = .);
-
-	.fixup : {
-		__start___fixup = .;
-		*(.fixup)
-		__stop___fixup = .;
-	}
-	__ex_table : {
-		__start___ex_table = .;
-		*(__ex_table)
-		__stop___ex_table = .;
-	}
-
-	NOTES
-
-	. = ALIGN(PAGE_SIZE);
-	__init_begin = .;
-	.init.text : {
-		_sinittext = .;
-		INIT_TEXT
-		_einittext = .;
-	}
-	__init_text_end = .;
-	.init.data : {
-		INIT_DATA
-	}
-	. = ALIGN(16);
-	.init.setup : {
-		__setup_start = .;
-		*(.init.setup)
-		__setup_end = .;
-	}
-	.initcall.init : {
-		__initcall_start = .;
-		INITCALLS
-	__initcall_end = .;
-	}
-	.con_initcall.init : {
-		__con_initcall_start = .;
-		*(.con_initcall.init)
-		__con_initcall_end = .;
-	}
-	SECURITY_INIT
-
-#ifdef CONFIG_BLK_DEV_INITRD
-	. = ALIGN(PAGE_SIZE);
-	.init.ramfs : {
-	__initramfs_start = .;
-		*(.init.ramfs)
-	__initramfs_end = .;
-	}
-#endif
-
-	PERCPU(PAGE_SIZE)
-	. = ALIGN(PAGE_SIZE);
-	__init_end = .;
-	. = ALIGN(32);
-	.data.cacheline_aligned : {
-		*(.data.cacheline_aligned)
-	}
-	. = ALIGN(32);
-	.data.read_mostly : {
-		*(.data.read_mostly)
-	}
-
-	__bss_start = .;
-	.sbss : {
-		*(.sbss)
-		*(.scommon) }
-	.bss : {
-		*(.dynbss)
-		*(.bss)
-		*(COMMON)
-	}
-	_end = . ;
-	PROVIDE (end = .);
-	/DISCARD/ : {
-		EXIT_TEXT
-		EXIT_DATA
-		*(.exitcall.exit)
-	}
-
-	STABS_DEBUG
-	DWARF_DEBUG
-}
+#ifdef CONFIG_SPARC32
+# include "vmlinux_32.lds.S"
+#else
+# include "vmlinux_64.lds.S"
+#endif
diff --git a/arch/sparc/kernel/vmlinux.lds.S b/arch/sparc/kernel/vmlinux_32.lds.S
similarity index 100%
rename from arch/sparc/kernel/vmlinux.lds.S
rename to arch/sparc/kernel/vmlinux_32.lds.S
diff --git a/arch/sparc64/kernel/vmlinux.lds.S b/arch/sparc/kernel/vmlinux_64.lds.S
similarity index 100%
rename from arch/sparc64/kernel/vmlinux.lds.S
rename to arch/sparc/kernel/vmlinux_64.lds.S
diff --git a/arch/sparc64/kernel/winfixup.S b/arch/sparc/kernel/winfixup.S
similarity index 100%
rename from arch/sparc64/kernel/winfixup.S
rename to arch/sparc/kernel/winfixup.S
diff --git a/arch/sparc64/kernel/Makefile b/arch/sparc64/kernel/Makefile
deleted file mode 100644
index b3e0b98..0000000
--- a/arch/sparc64/kernel/Makefile
+++ /dev/null
@@ -1,36 +0,0 @@
-#
-# Makefile for the linux kernel.
-#
-
-EXTRA_AFLAGS := -ansi
-EXTRA_CFLAGS := -Werror
-
-CFLAGS_REMOVE_ftrace.o = -pg
-
-extra-y		:= head.o init_task.o vmlinux.lds
-
-obj-y		:= process.o setup.o cpu.o idprom.o reboot.o \
-		   traps.o auxio.o una_asm.o sysfs.o iommu.o \
-		   irq.o ptrace.o time.o sys_sparc.o signal.o \
-		   unaligned.o central.o starfire.o \
-		   power.o sbus.o sparc64_ksyms.o ebus.o \
-		   visemul.o prom.o of_device.o hvapi.o sstate.o mdesc.o
-
-obj-$(CONFIG_DYNAMIC_FTRACE) += ftrace.o
-obj-$(CONFIG_STACKTRACE) += stacktrace.o
-obj-$(CONFIG_PCI)	 += pci.o pci_common.o psycho_common.o \
-			    pci_psycho.o pci_sabre.o pci_schizo.o \
-			    pci_sun4v.o pci_sun4v_asm.o pci_fire.o
-obj-$(CONFIG_PCI_MSI)	+= pci_msi.o
-obj-$(CONFIG_SMP)	 += smp.o trampoline.o hvtramp.o
-obj-$(CONFIG_COMPAT) += sys32.o sys_sparc32.o signal32.o
-obj-$(CONFIG_MODULES) += module.o
-obj-$(CONFIG_US3_FREQ) += us3_cpufreq.o
-obj-$(CONFIG_US2E_FREQ) += us2e_cpufreq.o
-obj-$(CONFIG_US3_MC) += chmc.o
-obj-$(CONFIG_KPROBES) += kprobes.o
-obj-$(CONFIG_SUN_LDOMS) += ldc.o vio.o viohs.o ds.o
-obj-$(CONFIG_AUDIT) += audit.o
-obj-$(CONFIG_AUDIT)$(CONFIG_COMPAT) += compat_audit.o
-obj-y += $(obj-yy)
-obj-$(CONFIG_KGDB) += kgdb.o
-- 
1.5.6.GIT


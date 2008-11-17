From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 17 Nov 2008 22:02:00 +0000
Subject: sparc unification step 3
Message-Id: <20081117220200.GA14667@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This is the thrid step in the unification.
This time it includes:

 - unification of sparc{,64}/prom/
 - unification of arch Makefiles
 - unification of sparc{,64}/kernel

The unification of the arch Makefiles includes moving
the defconifg files and a small update of the top-level Makefile.

I have tried to be carefull and there should be no
suprises this time.
Thanks for cacthing my NR_CPUS mistake at last round.

The real changes are small as can be seen here:
 147 files changed, 212 insertions(+), 252 deletions(-)

Patches follows in "git format-patch -n -M -B" format
so they are review able.

I have build relevant directories between each step.
But my box is sloow so I only did a few total builds.

	Sam


Sam Ravnborg (6):
      sparc: prepare prom/ for unification
      sparc,sparc64: unify prom/
      sparc: prepare kernel/ for unification
      sparc,sparc64: unify arch Makefile
      sparc,sparc64: unify kernel/
      sparc: ignore vmlinux.lds

git diff --stat -M -B:

 Makefile                                           |    9 +-
 arch/sparc/Kconfig                                 |   22 ++++
 arch/sparc/Makefile                                |   54 ++++++++-
 .../sparc/{defconfig => configs/sparc32_defconfig} |    0
 .../defconfig => sparc/configs/sparc64_defconfig}  |    0
 arch/sparc/kernel/.gitignore                       |    1 +
 arch/sparc/kernel/Makefile                         |  123 +++++++++++++++----
 arch/sparc/kernel/asm-offsets.c                    |    6 +
 arch/{sparc64 => sparc}/kernel/audit.c             |    0
 arch/sparc/kernel/{auxio.c => auxio_32.c}          |    0
 .../kernel/auxio.c => sparc/kernel/auxio_64.c}     |    0
 arch/{sparc64 => sparc}/kernel/central.c           |    0
 arch/{sparc64 => sparc}/kernel/cherrs.S            |    0
 arch/{sparc64 => sparc}/kernel/chmc.c              |    0
 arch/{sparc64 => sparc}/kernel/compat_audit.c      |    0
 arch/sparc/kernel/{cpu.c => cpu_32.c}              |    0
 .../kernel/cpu.c => sparc/kernel/cpu_64.c}         |    0
 arch/{sparc64 => sparc}/kernel/ds.c                |    0
 arch/{sparc64 => sparc}/kernel/dtlb_miss.S         |    0
 arch/{sparc64 => sparc}/kernel/dtlb_prot.S         |    0
 arch/{sparc64 => sparc}/kernel/ebus.c              |    0
 arch/{sparc64 => sparc}/kernel/entry.h             |    0
 arch/sparc/kernel/{etrap.S => etrap_32.S}          |    0
 .../kernel/etrap.S => sparc/kernel/etrap_64.S}     |    0
 arch/{sparc64 => sparc}/kernel/fpu_traps.S         |    0
 arch/{sparc64 => sparc}/kernel/ftrace.c            |    0
 arch/{sparc64 => sparc}/kernel/getsetcc.S          |    0
 arch/sparc/kernel/{head.S => head_32.S}            |    0
 .../kernel/head.S => sparc/kernel/head_64.S}       |    6 +-
 arch/{sparc64 => sparc}/kernel/helpers.S           |    0
 arch/{sparc64 => sparc}/kernel/hvapi.c             |    0
 arch/{sparc64 => sparc}/kernel/hvcalls.S           |    0
 arch/{sparc64 => sparc}/kernel/hvtramp.S           |    0
 arch/sparc/kernel/{idprom.c => idprom_32.c}        |    0
 .../kernel/idprom.c => sparc/kernel/idprom_64.c}   |    0
 arch/sparc/kernel/{init_task.c => init_task_32.c}  |    0
 .../init_task.c => sparc/kernel/init_task_64.c}    |    0
 arch/{sparc64 => sparc}/kernel/iommu.c             |    0
 arch/{sparc64 => sparc}/kernel/iommu_common.h      |    0
 arch/sparc/kernel/{irq.c => irq_32.c}              |    0
 .../kernel/irq.c => sparc/kernel/irq_64.c}         |    0
 arch/{sparc64 => sparc}/kernel/itlb_miss.S         |    0
 arch/{sparc64 => sparc}/kernel/ivec.S              |    0
 arch/sparc/kernel/{kgdb.c => kgdb_32.c}            |    0
 .../kernel/kgdb.c => sparc/kernel/kgdb_64.c}       |    0
 arch/{sparc64 => sparc}/kernel/kprobes.c           |    0
 arch/{sparc64 => sparc}/kernel/kstack.h            |    0
 arch/{sparc64 => sparc}/kernel/ktlb.S              |    0
 arch/{sparc64 => sparc}/kernel/ldc.c               |    0
 arch/{sparc64 => sparc}/kernel/mdesc.c             |    0
 arch/{sparc64 => sparc}/kernel/misctrap.S          |    0
 arch/sparc/kernel/{module.c => module_32.c}        |    0
 .../kernel/module.c => sparc/kernel/module_64.c}   |    0
 arch/sparc/kernel/{of_device.c => of_device_32.c}  |    0
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
 arch/sparc/kernel/{process.c => process_32.c}      |    0
 .../kernel/process.c => sparc/kernel/process_64.c} |    0
 arch/sparc/kernel/{prom.c => prom_32.c}            |    0
 .../kernel/prom.c => sparc/kernel/prom_64.c}       |    0
 arch/{sparc64 => sparc}/kernel/psycho_common.c     |    0
 arch/{sparc64 => sparc}/kernel/psycho_common.h     |    0
 arch/sparc/kernel/{ptrace.c => ptrace_32.c}        |    0
 .../kernel/ptrace.c => sparc/kernel/ptrace_64.c}   |    0
 arch/{sparc64 => sparc}/kernel/reboot.c            |    0
 arch/sparc/kernel/{rtrap.S => rtrap_32.S}          |    0
 .../kernel/rtrap.S => sparc/kernel/rtrap_64.S}     |    0
 arch/{sparc64 => sparc}/kernel/sbus.c              |    0
 arch/sparc/kernel/{setup.c => setup_32.c}          |    0
 .../kernel/setup.c => sparc/kernel/setup_64.c}     |    0
 arch/{sparc64 => sparc}/kernel/signal32.c          |    0
 arch/sparc/kernel/{signal.c => signal_32.c}        |    0
 .../kernel/signal.c => sparc/kernel/signal_64.c}   |    0
 arch/sparc/kernel/{smp.c => smp_32.c}              |    0
 .../kernel/smp.c => sparc/kernel/smp_64.c}         |    0
 .../kernel/{sparc_ksyms.c => sparc_ksyms_32.c}     |    0
 .../kernel/sparc_ksyms_64.c}                       |    0
 arch/{sparc64 => sparc}/kernel/spiterrs.S          |    0
 arch/{sparc64 => sparc}/kernel/sstate.c            |    0
 arch/{sparc64 => sparc}/kernel/stacktrace.c        |    0
 arch/{sparc64 => sparc}/kernel/starfire.c          |    0
 arch/{sparc64 => sparc}/kernel/sun4v_ivec.S        |    0
 arch/{sparc64 => sparc}/kernel/sun4v_tlb_miss.S    |    0
 arch/{sparc64 => sparc}/kernel/sys32.S             |    0
 arch/{sparc64 => sparc}/kernel/sys_sparc32.c       |    0
 arch/sparc/kernel/{sys_sparc.c => sys_sparc_32.c}  |    0
 .../sys_sparc.c => sparc/kernel/sys_sparc_64.c}    |    0
 arch/{sparc64 => sparc}/kernel/syscalls.S          |    0
 arch/{sparc64 => sparc}/kernel/sysfs.c             |    0
 arch/{sparc64 => sparc}/kernel/systbls.h           |    0
 arch/sparc/kernel/{systbls.S => systbls_32.S}      |    0
 .../kernel/systbls.S => sparc/kernel/systbls_64.S} |    0
 arch/sparc/kernel/{time.c => time_32.c}            |    0
 .../kernel/time.c => sparc/kernel/time_64.c}       |    0
 .../sparc/kernel/{trampoline.S => trampoline_32.S} |    0
 .../trampoline.S => sparc/kernel/trampoline_64.S}  |    0
 arch/sparc/kernel/{traps.c => traps_32.c}          |    0
 .../kernel/traps.c => sparc/kernel/traps_64.c}     |    0
 arch/{sparc64 => sparc}/kernel/tsb.S               |    0
 arch/{sparc64 => sparc}/kernel/ttable.S            |    0
 arch/sparc/kernel/{una_asm.S => una_asm_32.S}      |    0
 .../kernel/una_asm.S => sparc/kernel/una_asm_64.S} |    0
 arch/sparc/kernel/{unaligned.c => unaligned_32.c}  |    0
 .../unaligned.c => sparc/kernel/unaligned_64.c}    |    0
 arch/{sparc64 => sparc}/kernel/us2e_cpufreq.c      |    0
 arch/{sparc64 => sparc}/kernel/us3_cpufreq.c       |    0
 arch/{sparc64 => sparc}/kernel/utrap.S             |    0
 arch/{sparc64 => sparc}/kernel/vio.c               |    0
 arch/{sparc64 => sparc}/kernel/viohs.c             |    0
 arch/{sparc64 => sparc}/kernel/visemul.c           |    0
 arch/sparc/kernel/vmlinux.lds.S                    |  121 +------------------
 .../kernel/{vmlinux.lds.S => vmlinux_32.lds.S}     |    0
 .../kernel/vmlinux_64.lds.S}                       |    0
 arch/{sparc64 => sparc}/kernel/winfixup.S          |    0
 arch/sparc/prom/Makefile                           |   27 ++++-
 arch/sparc/prom/{bootstr.c => bootstr_32.c}        |    0
 .../prom/bootstr.c => sparc/prom/bootstr_64.c}     |    0
 arch/{sparc64 => sparc}/prom/cif.S                 |    0
 arch/sparc/prom/{console.c => console_32.c}        |    0
 .../prom/console.c => sparc/prom/console_64.c}     |    0
 arch/sparc/prom/{devops.c => devops_32.c}          |    0
 .../prom/devops.c => sparc/prom/devops_64.c}       |    0
 arch/sparc/prom/{init.c => init_32.c}              |    0
 arch/{sparc64/prom/init.c => sparc/prom/init_64.c} |    0
 arch/sparc/prom/{misc.c => misc_32.c}              |    0
 arch/{sparc64/prom/misc.c => sparc/prom/misc_64.c} |    0
 arch/{sparc64 => sparc}/prom/p1275.c               |    0
 arch/sparc/prom/{printf.c => printf_32.c}          |    0
 .../prom/printf.c => sparc/prom/printf_64.c}       |    0
 arch/sparc/prom/{tree.c => tree_32.c}              |    0
 arch/{sparc64/prom/tree.c => sparc/prom/tree_64.c} |    0
 arch/sparc64/Kconfig                               |    1 -
 arch/sparc64/Makefile                              |   48 --------
 arch/sparc64/kernel/Makefile                       |   36 ------
 arch/sparc64/kernel/asm-offsets.c                  |    1 -
 arch/sparc64/prom/Makefile                         |    9 --
 147 files changed, 212 insertions(+), 252 deletions(-)

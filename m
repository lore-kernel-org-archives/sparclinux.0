From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 30 Nov 2008 20:07:45 +0000
Subject: final unification of sparc,sparc64
Message-Id: <20081130200745.GA17845@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Dave et al.

This is the final step in the unification of sparc,sparc64.
Final in the sense that arch/sparc64 is no more and
I have not planned additional sparc unification activities
in this round...

IMPORTANT NOTE!
  This patchset introduces significant changes in link
  order in arch/sparc/kernel for sparc64 and I have
  only build tested this.
  Runtime test is needed.

Other than that the remaining steps was almost trivial.
For the unification of kernel/ a few helpers in
Kconfig was introduced to keep Makefile logic
simple.

The unification bring -Werror to sparc so this may
trigger build issues in some configurations but I
did not see it in my limited testing.

I have checked that I could build a defconfig kernel after
each step (or allnoconfig in a few cases).
This triggered a bug in Kconfig compared to first
submission so the test was worth it.

Patches will follow.

	Sam


Sam Ravnborg (5):
      sparc: prepare lib/ for unification
      sparc,sparc64: unify lib/
      sparc: prepare kernel/ for unification
      sparc,sparc64: unify kernel/
      sparc,sparc64: unify boot/

 arch/sparc/Kconfig                                 |   21 ++++
 arch/sparc/Makefile                                |   21 ++--
 arch/sparc/boot/.gitignore                         |    3 +
 arch/sparc/boot/Makefile                           |   33 +++++-
 arch/sparc/boot/{piggyback.c => piggyback_32.c}    |    0
 .../boot/piggyback.c => sparc/boot/piggyback_64.c} |    0
 arch/sparc/kernel/Makefile                         |  123 +++++++++++++++----
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
 arch/{sparc64 => sparc}/kernel/winfixup.S          |    0
 arch/{sparc64 => sparc}/lib/GENbzero.S             |    0
 arch/{sparc64 => sparc}/lib/GENcopy_from_user.S    |    0
 arch/{sparc64 => sparc}/lib/GENcopy_to_user.S      |    0
 arch/{sparc64 => sparc}/lib/GENmemcpy.S            |    0
 arch/{sparc64 => sparc}/lib/GENpage.S              |    0
 arch/{sparc64 => sparc}/lib/GENpatch.S             |    0
 arch/sparc/lib/Makefile                            |   57 +++++++--
 arch/{sparc64 => sparc}/lib/NG2copy_from_user.S    |    0
 arch/{sparc64 => sparc}/lib/NG2copy_to_user.S      |    0
 arch/{sparc64 => sparc}/lib/NG2memcpy.S            |    0
 arch/{sparc64 => sparc}/lib/NG2page.S              |    0
 arch/{sparc64 => sparc}/lib/NG2patch.S             |    0
 arch/{sparc64 => sparc}/lib/NGbzero.S              |    0
 arch/{sparc64 => sparc}/lib/NGcopy_from_user.S     |    0
 arch/{sparc64 => sparc}/lib/NGcopy_to_user.S       |    0
 arch/{sparc64 => sparc}/lib/NGmemcpy.S             |    0
 arch/{sparc64 => sparc}/lib/NGpage.S               |    0
 arch/{sparc64 => sparc}/lib/NGpatch.S              |    0
 arch/{sparc64 => sparc}/lib/PeeCeeI.c              |    0
 arch/{sparc64 => sparc}/lib/U1copy_from_user.S     |    0
 arch/{sparc64 => sparc}/lib/U1copy_to_user.S       |    0
 arch/{sparc64 => sparc}/lib/U1memcpy.S             |    0
 arch/{sparc64 => sparc}/lib/U3copy_from_user.S     |    0
 arch/{sparc64 => sparc}/lib/U3copy_to_user.S       |    0
 arch/{sparc64 => sparc}/lib/U3memcpy.S             |    0
 arch/{sparc64 => sparc}/lib/U3patch.S              |    0
 arch/{sparc64 => sparc}/lib/VISsave.S              |    0
 arch/sparc/lib/{atomic.S => atomic_32.S}           |    0
 .../lib/atomic.S => sparc/lib/atomic_64.S}         |    0
 arch/{sparc64 => sparc}/lib/bitops.S               |    0
 arch/{sparc64 => sparc}/lib/bzero.S                |    0
 arch/sparc/lib/{checksum.S => checksum_32.S}       |    0
 .../lib/checksum.S => sparc/lib/checksum_64.S}     |    0
 arch/{sparc64 => sparc}/lib/clear_page.S           |    0
 arch/{sparc64 => sparc}/lib/copy_in_user.S         |    0
 arch/{sparc64 => sparc}/lib/copy_page.S            |    0
 arch/{sparc64 => sparc}/lib/csum_copy.S            |    0
 arch/{sparc64 => sparc}/lib/csum_copy_from_user.S  |    0
 arch/{sparc64 => sparc}/lib/csum_copy_to_user.S    |    0
 arch/{sparc64 => sparc}/lib/ipcsum.S               |    0
 arch/{sparc64 => sparc}/lib/mcount.S               |    0
 arch/sparc/lib/{memcmp.S => memcmp_32.S}           |    0
 .../lib/memcmp.S => sparc/lib/memcmp_64.S}         |    0
 arch/{sparc64 => sparc}/lib/memmove.S              |    0
 arch/sparc/lib/{memscan.S => memscan_32.S}         |    0
 .../lib/memscan.S => sparc/lib/memscan_64.S}       |    0
 arch/sparc/lib/{rwsem.S => rwsem_32.S}             |    0
 arch/{sparc64/lib/rwsem.S => sparc/lib/rwsem_64.S} |    0
 arch/sparc/lib/{strlen.S => strlen_32.S}           |    0
 .../lib/strlen.S => sparc/lib/strlen_64.S}         |    0
 arch/sparc/lib/{strlen_user.S => strlen_user_32.S} |    0
 .../strlen_user.S => sparc/lib/strlen_user_64.S}   |    0
 arch/sparc/lib/{strncmp.S => strncmp_32.S}         |    0
 .../lib/strncmp.S => sparc/lib/strncmp_64.S}       |    0
 ...{strncpy_from_user.S => strncpy_from_user_32.S} |    0
 .../lib/strncpy_from_user_64.S}                    |    0
 arch/{sparc64 => sparc}/lib/user_fixup.c           |    0
 arch/{sparc64 => sparc}/lib/xor.S                  |    0
 arch/sparc64/boot/.gitignore                       |    4 -
 arch/sparc64/boot/Makefile                         |   33 -----
 arch/sparc64/kernel/Makefile                       |   36 ------
 arch/sparc64/kernel/asm-offsets.c                  |    1 -
 arch/sparc64/kernel/vmlinux.lds.S                  |    1 -
 arch/sparc64/lib/Makefile                          |   23 ----
 arch/sparc64/lib/iomap.c                           |   48 --------
 186 files changed, 206 insertions(+), 204 deletions(-)


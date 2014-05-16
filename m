From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 16 May 2014 21:22:59 +0000
Subject: [PATCH v2 00/34] sparc sparse fixes + diverse cleanup
Message-Id: <20140516212259.GA17389@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

v1 => v2
- audit of all patches. I deliberately waited a while
  before doing so - in order to look at them with fresh eyes.
- Fix bogus sbus() use found by davem in iommu.c
- Split patch touching iommu.c and io-unit.c in two
- Fix bogus sbus use in time_32 (sbus_readw => sbus_readl)
- Dropped patch that touches signal_64.c
  __put_user() does many magic things and I could not convince
  myself that dropping a cast of a pointer to (u64) was correct.
- Updated a few changelogs to be more precise/descriptive
- In systbls.h rearrange include and move include to the common part
- Updated cover letter (this mail)


Fix build breakage of sparc32 in certain configurations

Fix sparse warnings in sparc32.
  What is remaining:
  - "shift too big" warnings in the soft floating point code.
    This is too complex - so I dropped trying to fix these

Fix sparse warnings in sparc64.
  What is remaining:
  - "shift too big" warnings in the soft floating point code (like sparc32)
  - pcr.c defines arch_irq_work_raise() which is also defined as __weak in common code.
    As I recall there are some issues with weak functions with prototypes
    so it is left as-is
  - signal32.c issue a lot of "cast removes address space of expression"
    This actually deserve an extra look - as I think this may be
    some code that mixes two sizes to __put_user()
  - viohs.c uses a variable length array
  - init_64.c reference vmemmap_free which is properly declared in common code
    but seems to be guarded by wrong ifdefs
  - signal_64.c mix with __user pointers and wrong casts

None of the remaining sparse warnings looks simple to fix - and any
hints how to proceed are appreciated.

A lot of the sparse warnings are fixed by addding or moving function
prototypes to common files. Many prototypes are for functions
solely called from assembler so they are added only to shut up sparse.
But there is also a lot of prototypes that had local declarations
which are now visible both in the file where the function
is defined and in the file where the function is used.

Change all prototypes in sparc .h files so they do not use extern.
This change touches a lot of files.

Fix so we no longer assumes _NIG_WORDS can have more than one value,
and add a build time check to catch if the value changes anyway.

**The following patches require extra careful review:**

[PATCH 07/34] sparc32: fix sparse warnings in sys_sparc_32.c
  The return type of a few syscalls has been changed for sparc32,
  to align with sparc64.
  I assume this is safe to do.

[PATCH 08/34] sparc32: remove cast from output constraints in math asm statements
[PATCH 09/34] sparc64: remove cast from output constraints in math asm statements
  I have not much experience with gcc inline
  assembler - so please check that this looks OK.
  A cast in the output section of the inline
  assembler is dropped - which should be OK.

[PATCH 23/34] sparc64: clean up compat_sigset_t.seta handling
  This drops code that assumed _NSIG_WORDS could change.
  But as _NIG_WORDS are always constant drop this code.

[PATCH 34/34] sparc64: fix sparse warnings in int_64.c
  Introduces some ugly ifdef in the code.
  Was not sure if there was a smarter way to do this.
  It looked like some code was executed in the
  !CONFIG_NEED_MULTIPLE_NODES case which is not required.
  For now the simple solution with ifdef was used.


**The following patches touches files outside arch/sparc:**

[PATCH 24/34] sparc64: fix sparse warning in tsb.c
  Touches kernel/sysctl.c - removes a few sparc64 specific lines

[PATCH 27/34] sparc: fix sparse warnings in smp_32.c + smp_64.c
  Adds prototype for setup_profiling_timer to include/linux/profile.h.
  I could not find any obvious candidates to cc: on this patch

Sam Ravnborg (34):
      sparc32: fix build breakage
      sparc32: fix sparse warning in iommu.c
      sparc32: fix sparse warning in io-unit.c
      sparc32: fix sparse warnings in pcic.c
      sparc32: fix sparse warning in auxio_32.c
      sparc32: fix sparse warnings in time_32.c
      sparc32: fix sparse warnings in sys_sparc_32.c
      sparc32: remove cast from output constraints in math asm statements
      sparc64: remove cast from output constraints in math asm statements
      sparc: fix sparse warning in math_{32,64}
      sparc32: drop tadpole specific code
      sparc: drop use of extern for prototypes in arch/sparc/include/asm
      sparc: drop use of extern for prototypes in arch/sparc/*
      sparc64: fix sparse warning in traps_64.c
      sparc64: fix sparse warning in process_64.c
      sparc64: fix sparse warnings in sys_sparc_64.c + unaligned_64.c
      sparc64: fix sparse warning in btext.c
      sparc64: fix sparse warning in prom_64.c
      sparc64: fix sparse warnings in smp_64.c
      sparc64: fix sparse warning in pci.c
      sparc64: fix sparse warnings in sys_sparc32.c
      sparc64: fix sparse "Should it be static?" warnings in signal32.c
      sparc64: clean up compat_sigset_t.seta handling
      sparc64: fix sparse warning in tsb.c
      sparc64: fix sparse warnings in kprobes.c
      sparc64: fix sparse warnings in perf_event.c
      sparc: fix sparse warnings in smp_32.c + smp_64.c
      sparc64: fix sparse warnings in aes_glue.c
      sparc64: fix sparse warnings in init_64.c
      sparc64: fix sparse warnings in compat_audit.c
      sparc64: fix sparse warning in kgdb_64.c
      sparc64: fix sparse warning in kprobes.c
      sparc64: fix sparse warning in ftrace.c
      sparc64: fix sparse warnings in int_64.c

 arch/sparc/crypto/aes_glue.c            |   6 +-
 arch/sparc/include/asm/atomic_32.h      |   8 +-
 arch/sparc/include/asm/atomic_64.h      |  18 +-
 arch/sparc/include/asm/auxio_32.h       |   6 +-
 arch/sparc/include/asm/auxio_64.h       |   4 +-
 arch/sparc/include/asm/bitext.h         |   6 +-
 arch/sparc/include/asm/bitops_32.h      |   6 +-
 arch/sparc/include/asm/bitops_64.h      |  24 +--
 arch/sparc/include/asm/btext.h          |   2 +-
 arch/sparc/include/asm/bug.h            |   2 +-
 arch/sparc/include/asm/cacheflush_32.h  |   8 +-
 arch/sparc/include/asm/cacheflush_64.h  |  24 +--
 arch/sparc/include/asm/checksum_32.h    |   4 +-
 arch/sparc/include/asm/checksum_64.h    |  32 ++--
 arch/sparc/include/asm/cmpxchg_32.h     |   6 +-
 arch/sparc/include/asm/cmpxchg_64.h     |   4 +-
 arch/sparc/include/asm/delay_32.h       |   4 +-
 arch/sparc/include/asm/delay_64.h       |   4 +-
 arch/sparc/include/asm/device.h         |   2 +-
 arch/sparc/include/asm/dma-mapping.h    |   2 +-
 arch/sparc/include/asm/ebus_dma.h       |  16 +-
 arch/sparc/include/asm/floppy_32.h      |   3 +-
 arch/sparc/include/asm/floppy_64.h      |   2 +-
 arch/sparc/include/asm/ftrace.h         |   6 +-
 arch/sparc/include/asm/highmem.h        |  10 +-
 arch/sparc/include/asm/hvtramp.h        |   2 +-
 arch/sparc/include/asm/hypervisor.h     | 325 ++++++++++++++++----------------
 arch/sparc/include/asm/idprom.h         |   2 +-
 arch/sparc/include/asm/io-unit.h        |   2 +-
 arch/sparc/include/asm/io_32.h          |  12 +-
 arch/sparc/include/asm/io_64.h          |  20 +-
 arch/sparc/include/asm/iommu_32.h       |  10 +-
 arch/sparc/include/asm/iommu_64.h       |   6 +-
 arch/sparc/include/asm/irq_32.h         |   2 +-
 arch/sparc/include/asm/irq_64.h         |  44 ++---
 arch/sparc/include/asm/irqflags_32.h    |   6 +-
 arch/sparc/include/asm/kdebug_64.h      |   2 +-
 arch/sparc/include/asm/kgdb.h           |   5 +-
 arch/sparc/include/asm/kprobes.h        |   8 +-
 arch/sparc/include/asm/ldc.h            |  66 +++----
 arch/sparc/include/asm/leon.h           |  54 +++---
 arch/sparc/include/asm/leon_pci.h       |   4 +-
 arch/sparc/include/asm/mc146818rtc.h    |   5 +
 arch/sparc/include/asm/mdesc.h          |  32 ++--
 arch/sparc/include/asm/mmu_64.h         |   6 +-
 arch/sparc/include/asm/mmu_context_64.h |  24 +--
 arch/sparc/include/asm/nmi.h            |  10 +-
 arch/sparc/include/asm/oplib_32.h       |  68 +++----
 arch/sparc/include/asm/oplib_64.h       | 112 +++++------
 arch/sparc/include/asm/page_64.h        |   8 +-
 arch/sparc/include/asm/pci_64.h         |  14 +-
 arch/sparc/include/asm/pcic.h           |   8 +-
 arch/sparc/include/asm/pcr.h            |   6 +-
 arch/sparc/include/asm/pgalloc_64.h     |  16 +-
 arch/sparc/include/asm/pgtable_32.h     |  10 +-
 arch/sparc/include/asm/pgtable_64.h     |  58 +++---
 arch/sparc/include/asm/processor_32.h   |   5 +-
 arch/sparc/include/asm/processor_64.h   |   6 +-
 arch/sparc/include/asm/prom.h           |  24 +--
 arch/sparc/include/asm/ptrace.h         |   2 +-
 arch/sparc/include/asm/setup.h          |  14 +-
 arch/sparc/include/asm/sfp-machine_32.h |  28 +--
 arch/sparc/include/asm/smp_32.h         |   6 +-
 arch/sparc/include/asm/smp_64.h         |  24 ++-
 arch/sparc/include/asm/spitfire.h       |   2 +-
 arch/sparc/include/asm/stacktrace.h     |   2 +-
 arch/sparc/include/asm/starfire.h       |   8 +-
 arch/sparc/include/asm/string_32.h      |  12 +-
 arch/sparc/include/asm/string_64.h      |  12 +-
 arch/sparc/include/asm/switch_to_32.h   |   6 +-
 arch/sparc/include/asm/switch_to_64.h   |   4 +-
 arch/sparc/include/asm/syscalls.h       |   8 +-
 arch/sparc/include/asm/timer_32.h       |   6 +-
 arch/sparc/include/asm/timer_64.h       |   6 +-
 arch/sparc/include/asm/tlb_64.h         |   8 +-
 arch/sparc/include/asm/tlbflush_64.h    |  22 +--
 arch/sparc/include/asm/topology_64.h    |   2 +-
 arch/sparc/include/asm/trap_block.h     |   6 +-
 arch/sparc/include/asm/uaccess.h        |   2 +-
 arch/sparc/include/asm/uaccess_32.h     |  14 +-
 arch/sparc/include/asm/uaccess_64.h     |  50 ++---
 arch/sparc/include/asm/vio.h            |  36 ++--
 arch/sparc/include/asm/visasm.h         |   3 +-
 arch/sparc/include/asm/xor_64.h         |  28 +--
 arch/sparc/kernel/Makefile              |   1 -
 arch/sparc/kernel/audit.c               |   8 +-
 arch/sparc/kernel/auxio_32.c            |   6 +-
 arch/sparc/kernel/btext.c               |   2 +-
 arch/sparc/kernel/compat_audit.c        |   1 +
 arch/sparc/kernel/cpumap.h              |   4 +-
 arch/sparc/kernel/devices.c             |   1 -
 arch/sparc/kernel/entry.h               | 259 +++++++++++++------------
 arch/sparc/kernel/iommu.c               |   3 +-
 arch/sparc/kernel/iommu_common.h        |  14 +-
 arch/sparc/kernel/irq.h                 |   2 +-
 arch/sparc/kernel/kernel.h              |  86 ++++++---
 arch/sparc/kernel/kgdb_64.c             |   2 +
 arch/sparc/kernel/kprobes.c             |   5 +-
 arch/sparc/kernel/leon_kernel.c         |   5 +-
 arch/sparc/kernel/pci.c                 |   1 +
 arch/sparc/kernel/pci_impl.h            |  30 +--
 arch/sparc/kernel/pci_sun4v.h           | 156 +++++++--------
 arch/sparc/kernel/pcic.c                |  36 +---
 arch/sparc/kernel/perf_event.c          |  23 ++-
 arch/sparc/kernel/process_32.c          |   8 +-
 arch/sparc/kernel/process_64.c          |   2 +-
 arch/sparc/kernel/prom.h                |   2 +-
 arch/sparc/kernel/prom_64.c             |   5 +-
 arch/sparc/kernel/psycho_common.h       |  22 +--
 arch/sparc/kernel/signal32.c            |  56 ++----
 arch/sparc/kernel/signal_64.c           |   6 +-
 arch/sparc/kernel/smp_32.c              |   1 +
 arch/sparc/kernel/smp_64.c              |  16 +-
 arch/sparc/kernel/sys_sparc32.c         |   2 +
 arch/sparc/kernel/sys_sparc_32.c        |  10 +-
 arch/sparc/kernel/sys_sparc_64.c        |   1 +
 arch/sparc/kernel/systbls.h             | 124 +++++++++---
 arch/sparc/kernel/tadpole.c             | 130 -------------
 arch/sparc/kernel/time_32.c             |   8 +-
 arch/sparc/kernel/traps_32.c            |   2 -
 arch/sparc/kernel/traps_64.c            |  11 +-
 arch/sparc/kernel/unaligned_64.c        |   2 +
 arch/sparc/math-emu/sfp-util_32.h       |  20 +-
 arch/sparc/math-emu/sfp-util_64.h       |  12 +-
 arch/sparc/mm/fault_64.c                |   4 +-
 arch/sparc/mm/init_64.c                 |   9 +-
 arch/sparc/mm/init_64.h                 |   4 +-
 arch/sparc/mm/io-unit.c                 |  21 ++-
 arch/sparc/mm/iommu.c                   |  20 +-
 arch/sparc/mm/tsb.c                     |   1 +
 arch/sparc/prom/misc_64.c               |   5 -
 include/linux/profile.h                 |   1 +
 kernel/sysctl.c                         |   4 -
 133 files changed, 1314 insertions(+), 1342 deletions(-)

From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 02 May 2014 14:59:00 +0000
Subject: [PATCH 0/12] sparc: diverse cleanup patches
Message-Id: <20140502145859.GA5042@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

After the introduction of the generic io.h for sparc32 there was
some cleanup left to do to trim io_32.h further.
sparc64 cannot use the generic version because there are
so many dedicated functions for little/big endian.

The quest to get rid of sparse warnings for sparc32 continues,
and what is left is a bunch of "shift too big" in the
soft floating point code that I do not plan to address.
With sparc32 mostly clean start to fix the sparc64 sparse warnings.

Two patches touches the inline asm statements. They need extra review
as I do not know what I am doing here..

tadpole.c got dropped - the code in this file had not been in use for
more than 5 years.

The biggest change in terms of lines changed are the patches that drops
the use of extern for prototypes in all the sparc specific header files.

	Sam


Sam Ravnborg (12):
      sparc32: clean up io_32.h
      sparc32: fix remaining sparse warnings in iommu.c + io-unit.c
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
 arch/sparc/include/asm/ftrace.h         |   2 +-
 arch/sparc/include/asm/highmem.h        |  10 +-
 arch/sparc/include/asm/hvtramp.h        |   2 +-
 arch/sparc/include/asm/hypervisor.h     | 325 ++++++++++++++++----------------
 arch/sparc/include/asm/idprom.h         |   2 +-
 arch/sparc/include/asm/io-unit.h        |   2 +-
 arch/sparc/include/asm/io_32.h          |  55 ++----
 arch/sparc/include/asm/io_64.h          |  20 +-
 arch/sparc/include/asm/iommu_32.h       |  10 +-
 arch/sparc/include/asm/iommu_64.h       |   6 +-
 arch/sparc/include/asm/irq_32.h         |   2 +-
 arch/sparc/include/asm/irq_64.h         |  44 ++---
 arch/sparc/include/asm/irqflags_32.h    |   6 +-
 arch/sparc/include/asm/kdebug_64.h      |   2 +-
 arch/sparc/include/asm/kgdb.h           |   2 +-
 arch/sparc/include/asm/kprobes.h        |   6 +-
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
 arch/sparc/include/asm/setup.h          |   2 +-
 arch/sparc/include/asm/sfp-machine_32.h |  28 +--
 arch/sparc/include/asm/smp_32.h         |   6 +-
 arch/sparc/include/asm/smp_64.h         |  18 +-
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
 arch/sparc/kernel/auxio_32.c            |   6 +-
 arch/sparc/kernel/cpumap.h              |   4 +-
 arch/sparc/kernel/devices.c             |   1 -
 arch/sparc/kernel/entry.h               | 259 +++++++++++++------------
 arch/sparc/kernel/iommu_common.h        |  14 +-
 arch/sparc/kernel/irq.h                 |   2 +-
 arch/sparc/kernel/kernel.h              |  46 ++---
 arch/sparc/kernel/leon_kernel.c         |   5 +-
 arch/sparc/kernel/pci_impl.h            |  30 +--
 arch/sparc/kernel/pci_sun4v.h           | 156 +++++++--------
 arch/sparc/kernel/pcic.c                |  36 +---
 arch/sparc/kernel/process_32.c          |   8 +-
 arch/sparc/kernel/prom.h                |   2 +-
 arch/sparc/kernel/psycho_common.h       |  22 +--
 arch/sparc/kernel/sys_sparc_32.c        |  10 +-
 arch/sparc/kernel/systbls.h             |  71 ++++---
 arch/sparc/kernel/tadpole.c             | 130 -------------
 arch/sparc/kernel/time_32.c             |   8 +-
 arch/sparc/kernel/traps_32.c            |   2 -
 arch/sparc/kernel/traps_64.c            |   2 -
 arch/sparc/math-emu/sfp-util_32.h       |  20 +-
 arch/sparc/math-emu/sfp-util_64.h       |  12 +-
 arch/sparc/mm/init_64.h                 |   4 +-
 arch/sparc/mm/io-unit.c                 |  21 ++-
 arch/sparc/mm/iommu.c                   |  20 +-
 109 files changed, 1136 insertions(+), 1268 deletions(-)

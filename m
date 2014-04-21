From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 21 Apr 2014 19:37:44 +0000
Subject: [PATCH 00/29] sparse warning fixes in arch/sparc/
Message-Id: <20140421193744.GA3245@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The following patch-set address a lot of sparse warnings
in the sparc32 specific parts of arch/sparc/.
A few sparc64 bits are touched too when code are shared.

Within arch/sparc/mm/ only two warnings remains.
These are related to the return value of of_ioremap() which is __iomem.

Within arch/sparc/kernel/ only three files now produces sparse warnings:
    sys_sparc_32.c
    time_32.c
    auxio_32.c

The fixes was not obvious so the warnings was left for now.

When looking at tadpole.c I was left with the impression that most
of the code was actually unused - but for now I added a "TODO".

This is made on top of 3.15-rc2.

This set replaces the two sets sent the last days.
V2:
- Do not add extern in front of prototypes.
- Tidy up a few changelongs


There are still sparse warnings left that are easy to address.
But this fixes the majority.

        Sam


Sam Ravnborg (29):
      sparc32: rename mm/srmmu.h to mm/mm_32.h
      sparc32: fix sparse warning in fault_32.c
      sparc32: fix sparse warning in init_32.c
      sparc32: fix sparse warnings in srmmu.c
      sparc32: fix sparse "Should it be static?" in mm/
      sparc32: fix sparse warning in traps_32.c
      sparc32: fix sparse warnings in sun4m_irq.c and sun4d_irq.c
      sparc32: fix sparse warnings in sun4d_irq.c
      sparc32: fix sparse warnings in irq_32.c
      sparc32: fix sparse warnings in process_32.h
      sparc32: fix sparse warnings in signal_32.c
      sparc32: fix sparse warnings in ioport.c
      sparc32: fix sparse warnings in setup_32.c
      sparc32: fix sparse warnings in windows.c
      sparc: fix sparse warnings in cpu.c
      sparc32: fix sparse warning in devices.c
      sparc32: fix sparse warnings in tadpole.c
      sparc32: fix sparse warnings in leon_pci_grpci1.c
      sparc32: fix sparse warnings in leon_pci_grpci2.c
      sparc32: fix sparse warnings in auxio_32.c
      sparc32: fix sparse warnings in smp_32.c
      sparc32: fix sparse warning in ptrace_32.c
      sparc32: fix sparse warnings in unaligned_32.c
      sparc: fix sparse warnings in of_device_common.c
      sparc32: fix sparse warnings in leon_kernel.c
      sparc32: fix sparse warnings in leon_pmc.c
      sparc32: fix sparse warnings in sun4m_smp.c
      sparc32: fix sparse warnings in sun4d_smp.c
      sparc32: fix sparse warnings in leon_smp.c

 arch/sparc/include/asm/auxio.h       |  7 ++++++
 arch/sparc/include/asm/auxio_64.h    |  2 --
 arch/sparc/include/asm/bug.h         |  2 +-
 arch/sparc/include/asm/cpudata.h     | 10 ++++++++
 arch/sparc/include/asm/cpudata_64.h  |  5 ----
 arch/sparc/include/asm/floppy_32.h   | 11 ++-------
 arch/sparc/include/asm/irq_32.h      |  1 +
 arch/sparc/include/asm/pgalloc_32.h  |  2 ++
 arch/sparc/include/asm/pgtable_32.h  |  1 +
 arch/sparc/include/asm/setup.h       | 25 +++++++++++++++++++-
 arch/sparc/include/asm/timer_32.h    |  2 +-
 arch/sparc/kernel/auxio_32.c         |  3 +++
 arch/sparc/kernel/cpu.c              |  1 +
 arch/sparc/kernel/devices.c          | 11 ++++-----
 arch/sparc/kernel/ioport.c           |  6 ++---
 arch/sparc/kernel/irq.h              |  9 ++++++++
 arch/sparc/kernel/irq_32.c           |  1 +
 arch/sparc/kernel/kernel.h           | 44 ++++++++++++++++++++++++++++++++++++
 arch/sparc/kernel/leon_kernel.c      | 11 +++++----
 arch/sparc/kernel/leon_pci_grpci1.c  | 12 +++++-----
 arch/sparc/kernel/leon_pci_grpci2.c  | 18 +++++++--------
 arch/sparc/kernel/leon_pmc.c         |  8 +++----
 arch/sparc/kernel/leon_smp.c         | 13 +----------
 arch/sparc/kernel/of_device_common.c |  4 +++-
 arch/sparc/kernel/process_32.c       |  4 ++++
 arch/sparc/kernel/ptrace_32.c        |  2 ++
 arch/sparc/kernel/setup_32.c         |  4 ++--
 arch/sparc/kernel/signal_32.c        | 11 +++++----
 arch/sparc/kernel/smp_32.c           | 12 +++-------
 arch/sparc/kernel/sun4d_irq.c        | 17 +++++++-------
 arch/sparc/kernel/tadpole.c          |  6 ++++-
 arch/sparc/kernel/time_32.c          |  2 +-
 arch/sparc/kernel/traps_32.c         |  2 +-
 arch/sparc/kernel/unaligned_32.c     |  4 ++++
 arch/sparc/kernel/windows.c          |  3 +++
 arch/sparc/mm/fault_32.c             |  9 +++-----
 arch/sparc/mm/init_32.c              |  7 +++---
 arch/sparc/mm/iommu.c                |  5 ++--
 arch/sparc/mm/leon_mm.c              |  4 ++--
 arch/sparc/mm/mm_32.h                | 25 ++++++++++++++++++++
 arch/sparc/mm/srmmu.c                | 13 ++++-------
 arch/sparc/mm/srmmu.h                |  4 ----
 42 files changed, 222 insertions(+), 121 deletions(-)

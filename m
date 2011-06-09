From: David Miller <davem@davemloft.net>
Date: Thu, 09 Jun 2011 23:14:57 +0000
Subject: [GIT] Sparc
Message-Id: <20110609.161457.1118202817700762427.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


1) Fix sun4d regressions added by genirq conversion, from
   Kjetil Oftedal.

2) In the fix for sparc32 IPIs, the traphandler tests interrupt
   numbers with an off-by-one errors.  From Daniel Hellstrom.

3) Reinstate LEON irq intialization, mistekenly removed during
   genirc conversion.  From Daniel Hellstrom.

4) Add PCI support for LEON.  Also from Daniel Hellstrom.

Please pull, thanks a lot!

The following changes since commit dfb863a714b81848504d3b73ca0ecae90b91cbc0:

  Merge branch 'merge' of git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc (2011-06-09 13:50:25 -0700)

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

Daniel Hellstrom (5):
      sparc32: added CONFIG_PCIC_PCI Kconfig setting
      sparc32,leon: added LEON-common low-level PCI routines
      sparc32,leon: add GRPCI2 PCI Host driver
      sparc32, sun4m: bugfix in SMP IPI traphandler
      sparc32, leon: bugfix in LEON SMP interrupt init

David S. Miller (1):
      sparc: PCIC_PCI needs SPARC32 dependency

Geert Uytterhoeven (1):
      sparc: Do not select GENERIC_HARDIRQS_NO_DEPRECATED

Joe Perches (1):
      sparc: Remove unnecessary semicolons

oftedal (3):
      Restructure sun4d_build_device_irq so that timer interrupts can be allocated
      Do not skip interrupt sources in sun4d interrupt handler and acknowledge interrupts correctly
      Add support for allocating irqs for bootbus devices

 arch/sparc/Kconfig                  |   18 +-
 arch/sparc/include/asm/floppy_32.h  |    8 +-
 arch/sparc/include/asm/floppy_64.h  |    4 +-
 arch/sparc/include/asm/leon.h       |    3 +
 arch/sparc/include/asm/leon_pci.h   |   21 +
 arch/sparc/include/asm/pci_32.h     |   24 +
 arch/sparc/include/asm/pcic.h       |    2 +-
 arch/sparc/include/asm/system_32.h  |    2 +-
 arch/sparc/include/asm/system_64.h  |    2 +-
 arch/sparc/kernel/Makefile          |    4 +-
 arch/sparc/kernel/apc.c             |    2 +-
 arch/sparc/kernel/auxio_32.c        |    2 +-
 arch/sparc/kernel/chmc.c            |    2 +-
 arch/sparc/kernel/entry.S           |    8 +-
 arch/sparc/kernel/leon_kernel.c     |   31 ++
 arch/sparc/kernel/leon_pci.c        |  253 ++++++++++
 arch/sparc/kernel/leon_pci_grpci2.c |  897 +++++++++++++++++++++++++++++++++++
 arch/sparc/kernel/module.c          |    2 +-
 arch/sparc/kernel/pci_common.c      |    4 +-
 arch/sparc/kernel/pci_schizo.c      |    6 +-
 arch/sparc/kernel/prom_irqtrans.c   |    2 +-
 arch/sparc/kernel/psycho_common.c   |    2 +-
 arch/sparc/kernel/sbus.c            |    4 +-
 arch/sparc/kernel/setup_32.c        |    2 +-
 arch/sparc/kernel/setup_64.c        |    2 +-
 arch/sparc/kernel/smp_32.c          |    6 +-
 arch/sparc/kernel/sun4d_irq.c       |  126 ++++--
 arch/sparc/kernel/sys_sparc32.c     |    2 +-
 arch/sparc/kernel/sys_sparc_64.c    |    6 +-
 arch/sparc/kernel/time_64.c         |    2 +-
 arch/sparc/kernel/traps_64.c        |    2 +-
 arch/sparc/kernel/unaligned_64.c    |    6 +-
 arch/sparc/kernel/us2e_cpufreq.c    |    6 +-
 arch/sparc/kernel/us3_cpufreq.c     |    4 +-
 arch/sparc/kernel/viohs.c           |    2 +-
 arch/sparc/kernel/visemul.c         |   14 +-
 arch/sparc/mm/fault_32.c            |    2 +-
 arch/sparc/mm/init_32.c             |    2 +-
 arch/sparc/mm/init_64.c             |    6 +-
 arch/sparc/mm/srmmu.c               |    4 +-
 arch/sparc/mm/sun4c.c               |    8 +-
 arch/sparc/mm/tsb.c                 |    6 +-
 arch/sparc/prom/console_32.c        |    2 +-
 arch/sparc/prom/init_32.c           |    2 +-
 arch/sparc/prom/mp.c                |    2 +-
 drivers/pci/Makefile                |    1 +
 46 files changed, 1401 insertions(+), 117 deletions(-)
 create mode 100644 arch/sparc/include/asm/leon_pci.h
 create mode 100644 arch/sparc/kernel/leon_pci.c
 create mode 100644 arch/sparc/kernel/leon_pci_grpci2.c

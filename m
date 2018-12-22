From: David Miller <davem@davemloft.net>
Date: Sat, 22 Dec 2018 23:46:26 +0000
Subject: [GIT] Sparc
Message-Id: <20181222.154626.2057028219500846030.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Here is an early pull request for the next merge window:

1) Automatic system call table generation, from Firoz Khan.

2) Clean up accesses to the OF device names by using
   full_name instead of path_component_name.

Please pull, thanks a lot!

The following changes since commit 25e19c1fe421280a47f37c3571aa379e6e67966c:

  Merge tag 'libnvdimm-fixes-4.20-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm (2018-11-18 12:21:09 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc-next.git 

for you to fetch changes up to c23b8e7acea3dc034edeb902f0c843856e215938:

  ALSA: sparc: Use of_node_name_eq for node name comparisons (2018-12-05 21:00:02 -0800)

----------------------------------------------------------------
David S. Miller (2):
      Merge branch 'sparc-OF-name-and-device_type-rework'
      Merge branch 'sparc-syscall-gen'

Firoz Khan (4):
      sparc: move __IGNORE* entries to non uapi header
      sparc: add __NR_syscalls along with NR_syscalls
      sparc: add system call table generation support
      sparc: generate uapi header and system call table files

Rob Herring (12):
      fs/openpromfs: use full_name instead of path_component_name
      fs/openpromfs: Use of_node_name_eq for node name comparisons
      sparc: Convert to using %pOF instead of full_name
      of: Drop full path from full_name for PDT systems
      sparc: prom: use property "name" directly to construct node names
      sparc: Convert to using %pOFn instead of device_node.name
      sparc: Use of_node_name_eq for node name comparisons
      sparc: Use device_type helpers to access the node type
      sparc: Remove unused leon_trans_init
      sparc: Use DT node full_name instead of name for resources
      sbus: Use of_node_name_eq for node name comparisons
      ALSA: sparc: Use of_node_name_eq for node name comparisons

 arch/sparc/Makefile                      |   3 +
 arch/sparc/include/asm/Kbuild            |   4 +-
 arch/sparc/include/asm/floppy_64.h       |   8 +-
 arch/sparc/include/asm/leon.h            |   1 -
 arch/sparc/include/asm/parport.h         |   2 +-
 arch/sparc/include/asm/unistd.h          |  18 +++++
 arch/sparc/include/uapi/asm/Kbuild       |   2 +
 arch/sparc/include/uapi/asm/unistd.h     | 426 +----------------------------------------------------------------------------------------------------------
 arch/sparc/kernel/auxio_64.c             |  11 ++-
 arch/sparc/kernel/central.c              |   2 +-
 arch/sparc/kernel/chmc.c                 |   8 +-
 arch/sparc/kernel/ioport.c               |   2 +-
 arch/sparc/kernel/irq_64.c               |   2 +-
 arch/sparc/kernel/leon_kernel.c          |  14 ----
 arch/sparc/kernel/of_device_32.c         |  21 +++---
 arch/sparc/kernel/of_device_64.c         |  58 +++++++--------
 arch/sparc/kernel/of_device_common.c     |   4 +-
 arch/sparc/kernel/pci.c                  |  44 +++++------
 arch/sparc/kernel/pci_sabre.c            |   2 +-
 arch/sparc/kernel/power.c                |   4 +-
 arch/sparc/kernel/process_32.c           |   2 +-
 arch/sparc/kernel/prom_32.c              |  44 +++++------
 arch/sparc/kernel/prom_64.c              |  75 ++++++++++---------
 arch/sparc/kernel/prom_irqtrans.c        |  20 ++---
 arch/sparc/kernel/reboot.c               |   3 +-
 arch/sparc/kernel/sbus.c                 |   4 +-
 arch/sparc/kernel/sun4d_irq.c            |  14 ++--
 arch/sparc/kernel/syscalls/Makefile      |  55 ++++++++++++++
 arch/sparc/kernel/syscalls/syscall.tbl   | 409 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/sparc/kernel/syscalls/syscallhdr.sh |  36 +++++++++
 arch/sparc/kernel/syscalls/syscalltbl.sh |  36 +++++++++
 arch/sparc/kernel/systbls_32.S           |  81 +--------------------
 arch/sparc/kernel/systbls_64.S           | 157 +---------------------------------------
 arch/sparc/kernel/time_64.c              |  16 ++--
 arch/sparc/kernel/vio.c                  |   9 +--
 drivers/of/pdt.c                         |  50 ++++---------
 drivers/sbus/char/bbc_envctrl.c          |   4 +-
 drivers/sbus/char/envctrl.c              |   6 +-
 drivers/sbus/char/flash.c                |   6 +-
 fs/openpromfs/inode.c                    |  11 +--
 include/linux/of.h                       |   1 -
 sound/sparc/cs4231.c                     |   6 +-
 42 files changed, 777 insertions(+), 904 deletions(-)
 create mode 100644 arch/sparc/kernel/syscalls/Makefile
 create mode 100644 arch/sparc/kernel/syscalls/syscall.tbl
 create mode 100644 arch/sparc/kernel/syscalls/syscallhdr.sh
 create mode 100644 arch/sparc/kernel/syscalls/syscalltbl.sh

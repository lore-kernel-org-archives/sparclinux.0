From: David Miller <davem@davemloft.net>
Date: Sun, 10 Sep 2017 03:24:00 +0000
Subject: [GIT] Sparc
Message-Id: <20170909.202400.1185213376564357639.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


1) Use register window state adjustment instructions when available,
   from Anthony Yznaga.

2) Add VCC console concentrator driver, from Jag Raman.

3) Add 16GB hugepage support, from Nitin Gupta.

4) Support cpu 'poke' hypercall, from Vijay Kumar.

5) Add M7/M8 optimized memcpy/memset/copy_{to,from}_user, from Babu Moger.

Please pull, thanks a lot.

The following changes since commit 26273939ace935dd7553b31d279eab30b40f7b9a:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net (2017-08-10 10:30:29 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc-next.git 

for you to fetch changes up to b6fe1089667a7afcc2cf92cdaec590c7b8381715:

  sparc64: Handle additional cases of no fault loads (2017-09-09 20:20:11 -0700)

----------------------------------------------------------------
Anthony Yznaga (1):
      sparc64: speed up etrap/rtrap on NG2 and later processors

Arvind Yadav (2):
      sparc: leon: grpci2: constify of_device_id
      sparc: leon: grpci1: constify of_device_id

Babu Moger (4):
      arch/sparc: Separate the exception handlers from NG4memcpy
      arch/sparc: Rename exception handlers
      arch/sparc: Optimized memcpy, memset, copy_to_user, copy_from_user for M7/M8
      arch/sparc: Add accurate exception reporting in M7memcpy

Bhumika Goyal (1):
      sparc64: vcc: make ktermios const

Dan Carpenter (1):
      sparc64: vcc: Check for IS_ERR() instead of NULL

David S. Miller (7):
      Merge branch 'sparc64-Add-16GB-hugepage-support'
      Merge branch 'sparc64-Use-low-latency-path-to-resume-idle-cpu'
      sparc64: Revert 16GB huge page support.
      Merge git://git.kernel.org/.../davem/sparc
      Merge branch 'sparc64-M7-memcpy'
      Merge branch 'sparc64-vcc'
      Merge branch 'sparc64-16gb-hugepages'

Jag Raman (13):
      sparc64: vcc: Enable VCC module in linux
      sparc64: vcc: Add VCC debug message macros
      sparc64: vcc: TTY driver initialization and cleanup
      sparc64: vcc: Enable VCC port probe and removal
      sparc64: vcc: Create sysfs attribute group
      sparc64: vcc: Add RX & TX timer for delayed LDC operation
      sparc64: vcc: Enable LDC event processing engine
      sparc64: vcc: Add open & close TTY operations
      sparc64: vcc: Add hangup TTY operation
      sparc64: vcc: Add write & write_room TTY operations
      sparc64: vcc: Add chars_in_buffer TTY operation
      sparc64: vcc: Add break_ctl TTY operation
      sparc64: vcc: Add install & cleanup TTY operations

Nitin Gupta (6):
      sparc64: Support huge PUD case in get_user_pages
      sparc64: Add 16GB hugepage support
      sparc64: Cleanup hugepage table walk functions
      sparc64: Support huge PUD case in get_user_pages
      sparc64: Add 16GB hugepage support
      sparc64: Cleanup hugepage table walk functions

Rob Gardner (1):
      sparc64: Handle additional cases of no fault loads

Sam Ravnborg (1):
      sparc64: update comments in U3memcpy

Vijay Kumar (2):
      sparc64: Add a new hypercall CPU_POKE
      sparc64: Use CPU_POKE to resume idle cpu

 MAINTAINERS                          |    1 +
 arch/sparc/configs/sparc64_defconfig |    1 +
 arch/sparc/include/asm/hugetlb.h     |    7 +
 arch/sparc/include/asm/hypervisor.h  |   18 ++
 arch/sparc/include/asm/page_64.h     |    3 +-
 arch/sparc/include/asm/pgtable_64.h  |   20 +-
 arch/sparc/include/asm/smp_64.h      |    5 +
 arch/sparc/include/asm/trap_block.h  |    2 +
 arch/sparc/include/asm/tsb.h         |   36 ++++
 arch/sparc/include/asm/vio.h         |    9 +
 arch/sparc/kernel/etrap_64.S         |   26 ++-
 arch/sparc/kernel/head_64.S          |   18 +-
 arch/sparc/kernel/hvapi.c            |    2 +-
 arch/sparc/kernel/hvcalls.S          |   11 ++
 arch/sparc/kernel/ldc.c              |    2 +
 arch/sparc/kernel/leon_pci_grpci1.c  |    2 +-
 arch/sparc/kernel/leon_pci_grpci2.c  |    2 +-
 arch/sparc/kernel/process_64.c       |    7 +-
 arch/sparc/kernel/rtrap_64.S         |   13 +-
 arch/sparc/kernel/setup_64.c         |    6 +
 arch/sparc/kernel/smp_64.c           |   80 +++++++-
 arch/sparc/kernel/traps_64.c         |   51 ++++++
 arch/sparc/kernel/tsb.S              |    2 +-
 arch/sparc/kernel/vio.c              |    1 +
 arch/sparc/kernel/viohs.c            |   12 +-
 arch/sparc/kernel/vmlinux.lds.S      |   10 +
 arch/sparc/lib/M7copy_from_user.S    |   40 ++++
 arch/sparc/lib/M7copy_to_user.S      |   51 ++++++
 arch/sparc/lib/M7memcpy.S            |  923 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/sparc/lib/M7memset.S            |  352 ++++++++++++++++++++++++++++++++++++
 arch/sparc/lib/M7patch.S             |   51 ++++++
 arch/sparc/lib/Makefile              |    5 +
 arch/sparc/lib/Memcpy_utils.S        |  345 +++++++++++++++++++++++++++++++++++
 arch/sparc/lib/NG4memcpy.S           |  277 +++++++---------------------
 arch/sparc/lib/U3memcpy.S            |   32 ++--
 arch/sparc/mm/gup.c                  |   45 ++++-
 arch/sparc/mm/hugetlbpage.c          |  102 ++++++-----
 arch/sparc/mm/init_64.c              |   54 +++++-
 drivers/tty/Kconfig                  |    5 +
 drivers/tty/Makefile                 |    1 +
 drivers/tty/vcc.c                    | 1155 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 41 files changed, 3488 insertions(+), 297 deletions(-)
 create mode 100644 arch/sparc/lib/M7copy_from_user.S
 create mode 100644 arch/sparc/lib/M7copy_to_user.S
 create mode 100644 arch/sparc/lib/M7memcpy.S
 create mode 100644 arch/sparc/lib/M7memset.S
 create mode 100644 arch/sparc/lib/M7patch.S
 create mode 100644 arch/sparc/lib/Memcpy_utils.S
 create mode 100644 drivers/tty/vcc.c

From: David Miller <davem@davemloft.net>
Date: Fri, 24 Feb 2017 16:34:32 +0000
Subject: [GIT] Sparc
Message-Id: <20170224.113432.1599447765573133490.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


1) Support multiple huge page sizes, from Nitin Gupta.

2) Improve boot time on large memory configurations, from Pavel
   Tatashin.

3) Make BRK handling more consistent and documented, from Vijay Kumar.

Please pull, thanks a lot!

The following changes since commit bc49a7831b1137ce1c2dda1c57e3631655f5d2ae:

  Merge branch 'akpm' (patches from Andrew) (2017-02-22 19:29:24 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git 

for you to fetch changes up to ac65e2828d03ddf84e9fe1fb6d110d8de933dc22:

  sparc64: Fix build error in flush_tsb_user_page (2017-02-24 08:26:21 -0800)

----------------------------------------------------------------
Ben Hutchings (1):
      sparc: topology_64.h: Fix condition for including cpudata.h

Bhumika Goyal (1):
      sparc32: mm: srmmu: add __ro_after_init to sparc32_cachetlb_ops structures

David S. Miller (1):
      Merge branch 'sparc64-jump-to-boot-prom'

Eric Saint Etienne (1):
      sparc64: fix for user probes in high memory

Liam R. Howlett (1):
      sunvdc: Add support for setting physical sector size

Nitin Gupta (3):
      sparc64: Multi-page size support
      sparc64: Add 64K page size support
      sparc64: Fix build error in flush_tsb_user_page

Pavel Tatashin (2):
      sparc64: use latency groups to improve add_node_ranges speed
      sparc64: memblock resizes are not handled properly

Vijay Kumar (4):
      sparc64: Set cpu state to offline when stopped
      sparc64: Migrate hvcons irq to panicked cpu
      sparc64: Send break twice from console to return to boot prom
      Documentation/sparc: Steps for sending break on sunhv console

 Documentation/sparc/console.txt      |   9 +++++
 arch/sparc/include/asm/page_64.h     |   4 +-
 arch/sparc/include/asm/pgtable_64.h  |  23 ++++++++----
 arch/sparc/include/asm/setup.h       |   5 ++-
 arch/sparc/include/asm/tlbflush_64.h |   5 ++-
 arch/sparc/include/asm/topology_64.h |   4 +-
 arch/sparc/include/asm/uprobes.h     |   4 +-
 arch/sparc/kernel/smp_64.c           |   9 ++++-
 arch/sparc/kernel/tsb.S              |  21 ++---------
 arch/sparc/mm/hugetlbpage.c          | 201 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------
 arch/sparc/mm/init_64.c              | 260 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------------------------------------------
 arch/sparc/mm/srmmu.c                |   6 +--
 arch/sparc/mm/tlb.c                  |  17 ++++-----
 arch/sparc/mm/tsb.c                  |  61 ++++++++++++++++++++++++++-----
 drivers/block/sunvdc.c               |  18 ++++++++-
 drivers/tty/serial/sunhv.c           |  12 +++++-
 kernel/panic.c                       |   3 +-
 17 files changed, 488 insertions(+), 174 deletions(-)
 create mode 100644 Documentation/sparc/console.txt

From: David Miller <davem@davemloft.net>
Date: Mon, 12 Dec 2016 15:10:47 +0000
Subject: [GIT] Sparc
Message-Id: <20161212.101047.1706933771742570452.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Just a bunch of small cleanups and fixes here, and support for user
probes from Allen Pais.

Please pull, thanks a lot!

The following changes since commit 69973b830859bc6529a7a0468ba0d80ee5117826:

  Linux 4.9 (2016-12-11 11:17:54 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git 

for you to fetch changes up to 541cc39433a81d581f2738f59f7bd310ff1d512a:

  sparc: fix a building error reported by kbuild (2016-12-11 18:25:20 -0800)

----------------------------------------------------------------
Allen Pais (1):
      sparc64:Support User Probes for sparc

Dan Carpenter (4):
      sparc64: move dereference after check for NULL
      sparc64: make string buffers large enough
      sparc: leon: Fix a retry loop in leon_init_timers()
      sparc64: restore irq in error paths in iommu

Geliang Tang (1):
      sparc: kernel: use builtin_platform_driver

Gonglei \(Arei\) (1):
      sparc: fix a building error reported by kbuild

Kirill A. Shutemov (1):
      sparc64: fix typo in pgd_clear()

 arch/Kconfig                            |   1 +
 arch/sparc/Kconfig                      |   3 +
 arch/sparc/configs/sparc64_defconfig    |   1 +
 arch/sparc/include/asm/kdebug_64.h      |   2 +
 arch/sparc/include/asm/pgtable_64.h     |   2 +-
 arch/sparc/include/asm/ptrace.h         |  35 ++++++++-
 arch/sparc/include/asm/thread_info_64.h |   6 +-
 arch/sparc/include/asm/topology_64.h    |   1 +
 arch/sparc/include/asm/ttable.h         |   6 ++
 arch/sparc/include/asm/uprobes.h        |  59 +++++++++++++++
 arch/sparc/kernel/Makefile              |   1 +
 arch/sparc/kernel/leon_kernel.c         |  56 +++++++-------
 arch/sparc/kernel/pci_sun4v.c           |   7 +-
 arch/sparc/kernel/power.c               |   7 +-
 arch/sparc/kernel/ptrace_64.c           |  54 ++++++++++++++
 arch/sparc/kernel/signal_64.c           |   2 +
 arch/sparc/kernel/traps_64.c            |   4 +-
 arch/sparc/kernel/ttable_64.S           |   2 +-
 arch/sparc/kernel/uprobes.c             | 331 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/uprobes.h                 |   1 +
 20 files changed, 537 insertions(+), 44 deletions(-)
 create mode 100644 arch/sparc/include/asm/uprobes.h
 create mode 100644 arch/sparc/kernel/uprobes.c

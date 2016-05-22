From: David Miller <davem@davemloft.net>
Date: Sun, 22 May 2016 06:03:18 +0000
Subject: [GIT] Sparc
Message-Id: <20160521.230318.866656461308263687.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org


Some 32-bit kgdb cleanups from Sam Ravnborg, and a hugepage TLB flush
overhead fix on 64-bit from Nitin Gupta.

Please pull, thanks a lot!

The following changes since commit 33656a1f2ee5346c742d63ddd0e0970c95a56b70:

  Merge branch 'for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs (2016-05-02 09:59:57 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc 

for you to fetch changes up to 24e49ee3d76b70853a96520e46b8837e5eae65b2:

  sparc64: Reduce TLB flushes during hugepte changes (2016-05-20 18:44:27 -0700)

----------------------------------------------------------------
David S. Miller (1):
      Merge branch 'sparc32-cosmetic-changes'

Nitin Gupta (1):
      sparc64: Reduce TLB flushes during hugepte changes

Sam Ravnborg (7):
      sparc32: drop hardcoding trap_level in kgdb_trap
      sparc32: drop local prototype in kgdb_32
      sparc32: use proper prototype for trapbase
      sparc32: fix build with STRICT_MM_TYPECHECKS
      sparc32: drop superfluous cast in calls to __nocache_pa()
      openprom: fix warning
      aeroflex/greth: fix warning about unused variable

 arch/sparc/include/asm/head_32.h      |  8 ++++----
 arch/sparc/include/asm/kgdb.h         |  2 +-
 arch/sparc/include/asm/page_32.h      |  2 --
 arch/sparc/include/asm/pgalloc_32.h   |  4 ++--
 arch/sparc/include/asm/pgtable_32.h   |  2 +-
 arch/sparc/include/asm/pgtable_64.h   | 43 ++++++++++++++++++++++++++++++++-----------
 arch/sparc/include/asm/tlbflush_64.h  |  3 ++-
 arch/sparc/kernel/entry.S             | 10 ++++------
 arch/sparc/kernel/kernel.h            |  1 +
 arch/sparc/kernel/kgdb_32.c           | 11 +++++------
 arch/sparc/kernel/setup_32.c          |  4 +---
 arch/sparc/mm/hugetlbpage.c           | 33 ++++++++++++++++++++++++++++-----
 arch/sparc/mm/init_64.c               | 12 ------------
 arch/sparc/mm/io-unit.c               |  4 ++--
 arch/sparc/mm/srmmu.c                 | 19 ++++++++++++-------
 arch/sparc/mm/tlb.c                   | 25 ++++++++++++++++++-------
 arch/sparc/mm/tsb.c                   | 32 +++++++++++++++++---------------
 drivers/net/ethernet/aeroflex/greth.c |  2 +-
 drivers/sbus/char/openprom.c          | 40 ++++++++++++++++------------------------
 19 files changed, 147 insertions(+), 110 deletions(-)

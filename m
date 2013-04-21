From: David Miller <davem@davemloft.net>
Date: Sun, 21 Apr 2013 01:16:36 +0000
Subject: [GIT] Sparc
Message-Id: <20130420.211636.2154136493632584075.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


1) Fix race in sparc64 TLB shootdowns, we have to synchronize with the
   sibling cpus completing if we are passing them a reference via
   pointer to a data structure.

2) Fix cleaning of bitmaps in sparc32, from Akinobu Mita.

3) Fix various sparc header mistakes, some of which resulted in
   userland build breakage.  From Sam Ravnborg.

4) Kill ghost declarations and defines missed when several bits of
   code got deleted recently.

Please pull, thanks!

The following changes since commit 07961ac7c0ee8b546658717034fe692fd12eefa9:

  Linux 3.9-rc5 (2013-03-31 15:12:43 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git master

for you to fetch changes up to f36391d2790d04993f48da6a45810033a2cdf847:

  sparc64: Fix race in TLB batch processing. (2013-04-19 17:26:26 -0400)

----------------------------------------------------------------
Akinobu Mita (2):
      sparc/srmmu: clear trailing edge of bitmap properly
      sparc/iommu: fix typo s/265KB/256KB/

David S. Miller (1):
      sparc64: Fix race in TLB batch processing.

Kefeng Wang (2):
      sparc:remove unused declaration smp_boot_cpus()
      sparc:cleanup unused code in smp_32.h

Sam Ravnborg (3):
      sparc: use generic headers
      bbc_i2c: fix section mismatch warning
      sparc: use asm-generic version of types.h

 arch/sparc/include/asm/Kbuild              |   5 +++
 arch/sparc/include/asm/cputime.h           |   6 ----
 arch/sparc/include/asm/emergency-restart.h |   6 ----
 arch/sparc/include/asm/mutex.h             |   9 ------
 arch/sparc/include/asm/pgtable_64.h        |   1 +
 arch/sparc/include/asm/serial.h            |   6 ----
 arch/sparc/include/asm/smp_32.h            |   5 ---
 arch/sparc/include/asm/switch_to_64.h      |   3 +-
 arch/sparc/include/asm/tlbflush_64.h       |  37 ++++++++++++++++++----
 arch/sparc/include/uapi/asm/Kbuild         |   1 -
 arch/sparc/include/uapi/asm/types.h        |  17 ----------
 arch/sparc/kernel/smp_64.c                 |  41 +++++++++++++++++++++---
 arch/sparc/lib/bitext.c                    |   6 +---
 arch/sparc/mm/iommu.c                      |   2 +-
 arch/sparc/mm/srmmu.c                      |   4 ++-
 arch/sparc/mm/tlb.c                        |  38 ++++++++++++++++++++---
 arch/sparc/mm/tsb.c                        |  57 +++++++++++++++++++++++++---------
 arch/sparc/mm/ultra.S                      | 119 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------
 drivers/sbus/char/bbc_i2c.c                |   4 +--
 19 files changed, 253 insertions(+), 114 deletions(-)
 delete mode 100644 arch/sparc/include/asm/cputime.h
 delete mode 100644 arch/sparc/include/asm/emergency-restart.h
 delete mode 100644 arch/sparc/include/asm/mutex.h
 delete mode 100644 arch/sparc/include/asm/serial.h
 delete mode 100644 arch/sparc/include/uapi/asm/types.h

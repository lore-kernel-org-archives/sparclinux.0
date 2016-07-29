From: David Miller <davem@davemloft.net>
Date: Fri, 29 Jul 2016 18:15:41 +0000
Subject: [GIT] Sparc
Message-Id: <20160729.111541.2158815579866144874.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


1) Double spin lock bug in sunhv serial driver, from Dan Carpenter.

2) Use correct RSS estimate when determining whether to grow the
   huge TSB or not, from Mike Kravetz.

3) Don't use full three level page tables for hugepages, PMD level is
   sufficient.  From Nitin Gupta.

4) Mask out extraneous bits from TSB_TAG_ACCESS register, we only want
   the address bits.

Please pull, thanks a lot.

The following changes since commit 8448cefe499a45222430ebbcabcd9e26369895c3:

  Merge tag 'hsi-for-4.8' of git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-hsi (2016-07-27 15:18:53 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc 

for you to fetch changes up to 7bc3777ca19cf9ecc5533980210f29c51df7fe5e:

  sparc64: Trim page tables for 8M hugepages (2016-07-29 10:49:16 -0700)

----------------------------------------------------------------
Dan Carpenter (2):
      sparc32: off by ones in BUG_ON()
      sparc: serial: sunhv: fix a double lock bug

David S. Miller (1):
      sparc: Don't leak context bits into thread->fault_address

Mike Kravetz (1):
      sparc64 mm: Fix base TSB sizing when hugetlb pages are used

Nitin Gupta (1):
      sparc64: Trim page tables for 8M hugepages

 arch/sparc/include/asm/hugetlb.h    |  12 +++----
 arch/sparc/include/asm/mmu_64.h     |   3 +-
 arch/sparc/include/asm/pgtable_64.h |   7 +++-
 arch/sparc/include/asm/tsb.h        |   2 +-
 arch/sparc/kernel/dtlb_prot.S       |   4 +--
 arch/sparc/kernel/irq_32.c          |   4 +--
 arch/sparc/kernel/ktlb.S            |  12 +++++++
 arch/sparc/kernel/tsb.S             |  12 +++++--
 arch/sparc/mm/fault_64.c            |  10 +++---
 arch/sparc/mm/hugetlbpage.c         | 170 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------------------------
 arch/sparc/mm/init_64.c             |   7 ++--
 arch/sparc/mm/tlb.c                 |   4 +--
 arch/sparc/mm/tsb.c                 |  14 ++++----
 drivers/tty/serial/sunhv.c          |   6 ----
 14 files changed, 173 insertions(+), 94 deletions(-)

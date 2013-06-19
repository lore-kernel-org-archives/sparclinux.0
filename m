From: David Miller <davem@davemloft.net>
Date: Wed, 19 Jun 2013 09:28:47 +0000
Subject: [GIT] Sparc
Message-Id: <20130619.022847.965827775364729887.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Various sparc bug fixes, in particular:

1) TSB hashes have to be flushed before TLB on sparc64, from
   Dave Kleikamp.

2) LEON timer interrupts can get stuck, from Andreas Larsson.

3) Sparc64 needs to handle lack of address-congruence devicetree
   property, from Bob Picco.

Please pull, thanks a lot!

The following changes since commit 17858ca65eef148d335ffd4cfc09228a1c1cbfb5:

  Merge tag 'please-pull-fixia64' of git://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux (2013-06-18 06:29:19 -1000)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git master

for you to fetch changes up to 23a01138efe216f8084cfaa74b0b90dd4b097441:

  sparc: tsb must be flushed before tlb (2013-06-19 02:10:30 -0700)

----------------------------------------------------------------
Andreas Larsson (2):
      sparc32, leon: Remove separate "ticker" timer for SMP
      sparc32, leon: Enable interrupts before going idle to avoid getting stuck

Chen Gang (1):
      arch: sparc: prom: looping issue, need additional length check in the outside looping

Dave Kleikamp (1):
      sparc: tsb must be flushed before tlb

Denis Efremov (1):
      sparc: remove inline marking of EXPORT_SYMBOL functions

Geert Uytterhoeven (1):
      sparc: Switch to asm-generic/linkage.h

Tushar Behera (1):
      sparc,leon: Convert to use devm_ioremap_resource

Zhao Hongjiang (1):
      sparc: kernel: using strlcpy() instead of strcpy()

bob picco (1):
      sparc64 address-congruence property

 arch/sparc/include/asm/Kbuild       |  1 +
 arch/sparc/include/asm/leon.h       |  2 +-
 arch/sparc/include/asm/leon_amba.h  |  1 +
 arch/sparc/include/asm/linkage.h    |  6 ------
 arch/sparc/kernel/ds.c              |  3 ++-
 arch/sparc/kernel/leon_kernel.c     | 54 +++++++++++++++++-------------------------------------
 arch/sparc/kernel/leon_pci_grpci1.c |  8 +++-----
 arch/sparc/kernel/leon_pmc.c        |  7 +++++++
 arch/sparc/kernel/setup_32.c        |  2 +-
 arch/sparc/kernel/setup_64.c        |  2 +-
 arch/sparc/mm/init_64.c             |  9 ++++++++-
 arch/sparc/mm/tlb.c                 |  2 +-
 arch/sparc/prom/bootstr_32.c        | 12 +++++++-----
 arch/sparc/prom/tree_64.c           | 16 ++++++++--------
 14 files changed, 58 insertions(+), 67 deletions(-)
 delete mode 100644 arch/sparc/include/asm/linkage.h

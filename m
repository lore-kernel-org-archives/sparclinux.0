From: David Miller <davem@davemloft.net>
Date: Wed, 10 Jul 2013 21:00:47 +0000
Subject: [GIT] Sparc
Message-Id: <20130710.140047.2169280084001618173.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Four bug fixes:

1) Enable snoop tags properly on Sparc32/LEON, from Andreas Larsson

2) strcpy() length check fix from Chen Gang.

3) Forgotten unregister_netdev() in sunvnet driver, from Dave Kleikamp.

4) Fix broken assembler offsets used in vm_area_struct accesses on
   sparc32, from Olivier DANET.

Please pull, thanks a lot!

The following changes since commit bfffbea1aaeeb1eb6500c83ff9653416daa5b490:

  Merge tag 'mmc-updates-for-3.11-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc (2013-07-10 11:16:00 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git master

for you to fetch changes up to 961246b4ed8da3bcf4ee1eb9147f341013553e3c:

  [PATCH] sparc32: vm_area_struct access for old Sun SPARCs. (2013-07-10 13:56:10 -0700)

----------------------------------------------------------------
Andreas Larsson (1):
      sparc32, leon: Require separate snoop tags set to regard snooping to be enabled

Chen Gang (1):
      arch: sparc: kernel: check the memory length before use strcpy().

Dave Kleikamp (1):
      sunvnet: vnet_port_remove must call unregister_netdev

Olivier DANET (1):
      sparc32: vm_area_struct access for old Sun SPARCs.

 arch/sparc/include/asm/leon.h      |  2 +-
 arch/sparc/kernel/asm-offsets.c    |  2 ++
 arch/sparc/kernel/ds.c             | 10 ++++++++++
 arch/sparc/mm/hypersparc.S         |  8 ++++----
 arch/sparc/mm/swift.S              |  8 ++++----
 arch/sparc/mm/tsunami.S            |  6 +++---
 arch/sparc/mm/viking.S             | 10 +++++-----
 drivers/net/ethernet/sun/sunvnet.c |  2 ++
 8 files changed, 31 insertions(+), 17 deletions(-)

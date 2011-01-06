From: David Miller <davem@davemloft.net>
Date: Thu, 06 Jan 2011 22:48:32 +0000
Subject: [GIT] Sparc
Message-Id: <20110106.144832.189697659.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Not a whole lot here, mainly:

1) sparc 32-bit LEON updates from Daniel Hellstrom.

2) PROM cleanups and consolidation of the 32-bit and 64-bit
   piggyback programs into one unified code base, from Sam
   Ravnborg.

3) An atyfb on sparc bootup regression fix, which will be sent
   to -stable.

Please pull, thanks a lot.

The following changes since commit cb600d2f83c854ec3d6660063e4466431999489b:

  Merge branch 'x86-mm-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/linux-2.6-tip (2011-01-06 11:12:17 -0800)

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-next-2.6.git master

Daniel Hellstrom (7):
      SPARC/LEON: find IRQCTRL and Timer via OF-Tree, instead of hardcoded.
      SPARC/LEON: added support for IRQAMP IRQ Controller
      LEON: added raw AMBA vendor/device number to find TIMER, IRQCTRL
      SPARC/LEON: added support for selecting Timer Core and Timer within core
      SPARC/LEON: avoid AMBAPP name duplicates in openprom fs when REG is missing
      APBUART: added raw AMBA vendor/device number to match against.
      Added support for ampopts in APBUART driver. Used in AMP systems.

David S. Miller (3):
      Merge master.kernel.org:/.../davem/sparc-2.6
      sparc: Eliminate prom_stdin.
      atyfb: Fix bootup hangs on sparc64.

Julian Calaby (1):
      sparc: prom: Sanitize return value from prom_nbputchar()

Sam Ravnborg (15):
      sparc: drop prom/devmap.c
      sparc: drop prom/palloc.c
      sparc: remove unused prom cpu functions
      sparc: remove unused prom tree functions
      sparc: fix sparse warnings in arch/sparc/prom for 32 bit build
      sparc: refactor piggy_32.c
      sparc: use trapbase in setup_arch
      sparc: use _start for the start entry (like 64 bit does)
      sparc: additional comments to piggyback_32.c
      sparc: remove obsolete ELF support in piggyback_32.c
      sparc: add $BITS to piggyback arguments
      sparc: fix tftpboot.img for sparc64 on little-endian host
      sparc: rename piggyback_32 to piggyback
      sparc: unify strip command in boot/Makefile
      sparc: update copyright in piggyback.c

 arch/sparc/boot/Makefile           |   28 ++---
 arch/sparc/boot/piggyback.c        |  272 ++++++++++++++++++++++++++++++++++++
 arch/sparc/boot/piggyback_32.c     |  137 ------------------
 arch/sparc/boot/piggyback_64.c     |  110 ---------------
 arch/sparc/include/asm/leon.h      |   12 ++
 arch/sparc/include/asm/leon_amba.h |    6 +-
 arch/sparc/include/asm/openprom.h  |    2 +-
 arch/sparc/include/asm/oplib_32.h  |   83 +----------
 arch/sparc/include/asm/oplib_64.h  |   50 +------
 arch/sparc/kernel/head_32.S        |    3 +-
 arch/sparc/kernel/leon_kernel.c    |  114 +++++++++++++---
 arch/sparc/kernel/prom_32.c        |   27 +++-
 arch/sparc/kernel/setup_32.c       |    3 +-
 arch/sparc/mm/sun4c.c              |    8 +-
 arch/sparc/prom/Makefile           |    3 -
 arch/sparc/prom/bootstr_32.c       |    3 +-
 arch/sparc/prom/console_32.c       |   68 ++-------
 arch/sparc/prom/console_64.c       |   83 ++---------
 arch/sparc/prom/devmap.c           |   53 -------
 arch/sparc/prom/devops_32.c        |   87 ------------
 arch/sparc/prom/devops_64.c        |   67 ---------
 arch/sparc/prom/init_64.c          |    3 +-
 arch/sparc/prom/misc_32.c          |    2 +-
 arch/sparc/prom/misc_64.c          |   16 +--
 arch/sparc/prom/mp.c               |   78 ----------
 arch/sparc/prom/palloc.c           |   43 ------
 arch/sparc/prom/printf.c           |   35 ++++-
 arch/sparc/prom/ranges.c           |    6 +-
 arch/sparc/prom/tree_32.c          |   66 +--------
 arch/sparc/prom/tree_64.c          |   18 ---
 drivers/serial/apbuart.c           |    8 +-
 drivers/video/aty/atyfb_base.c     |   27 +---
 32 files changed, 514 insertions(+), 1007 deletions(-)
 create mode 100644 arch/sparc/boot/piggyback.c
 delete mode 100644 arch/sparc/boot/piggyback_32.c
 delete mode 100644 arch/sparc/boot/piggyback_64.c
 delete mode 100644 arch/sparc/prom/devmap.c
 delete mode 100644 arch/sparc/prom/devops_32.c
 delete mode 100644 arch/sparc/prom/devops_64.c
 delete mode 100644 arch/sparc/prom/palloc.c

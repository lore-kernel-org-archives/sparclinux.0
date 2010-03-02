From: David Miller <davem@davemloft.net>
Date: Tue, 02 Mar 2010 12:41:31 +0000
Subject: [GIT]: Sparc
Message-Id: <20100302.044131.192091161.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080421.153231.108090227.davem@davemloft.net>
In-Reply-To: <20080421.153231.108090227.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Nothing really exciting for sparc this time around.

Several cleanups, a new PCI ID for a frambuffer driver, creation
of PCI slot objects when possible, and some debugging enhancements
by supporting exception-table sysctl like powerpc and x86 do.

Please pull, thanks a lot!

The following changes since commit baac35c4155a8aa826c70acee6553368ca5243a2:
  Xiaotian Feng (1):
        security: fix error return path in ima_inode_alloc

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-next-2.6.git master

Akinobu Mita (1):
      sparc: use __ratelimit

Ben Hutchings (1):
      sunxvr500: Additional PCI id for sunxvr500 driver

David S. Miller (3):
      Merge branch 'master' of master.kernel.org:/.../davem/sparc-2.6
      sparc64: If 'slot-names' property exist, create sysfs PCI slot information.
      sparc: Support show_unhandled_signals.

FUJITA Tomonori (1):
      sparc: use asm-generic/scatterlist.h

Frans Pop (1):
      sparc: remove trailing space in messages

Jan Engelhardt (1):
      sparc: remove redundant return statements

 arch/sparc/include/asm/scatterlist.h |   21 +------
 arch/sparc/kernel/devices.c          |    2 -
 arch/sparc/kernel/leon_kernel.c      |    2 +-
 arch/sparc/kernel/leon_smp.c         |    4 +-
 arch/sparc/kernel/pci.c              |   75 ++++++++++++++++++++++++
 arch/sparc/kernel/pcic.c             |    2 -
 arch/sparc/kernel/setup_32.c         |    2 -
 arch/sparc/kernel/sun4d_smp.c        |    2 +-
 arch/sparc/kernel/unaligned_64.c     |   11 +---
 arch/sparc/mm/fault_32.c             |  106 +++++++++++++++++++---------------
 arch/sparc/mm/fault_64.c             |   34 ++++++++++-
 arch/sparc/prom/console_32.c         |    1 -
 arch/sparc/prom/console_64.c         |    1 -
 arch/sparc/prom/devmap.c             |    1 -
 arch/sparc/prom/devops_32.c          |    2 -
 arch/sparc/prom/init_32.c            |    1 -
 arch/sparc/prom/palloc.c             |    1 -
 arch/sparc/prom/ranges.c             |    2 -
 arch/sparc/prom/segment.c            |    1 -
 arch/sparc/prom/tree_32.c            |    1 -
 arch/sparc/prom/tree_64.c            |    1 -
 drivers/video/sunxvr500.c            |    1 +
 kernel/sysctl.c                      |    2 +-
 23 files changed, 176 insertions(+), 100 deletions(-)

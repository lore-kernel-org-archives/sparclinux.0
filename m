From: David Miller <davem@davemloft.net>
Date: Thu, 08 Jan 2009 01:19:07 +0000
Subject: [GIT]: Sparc
Message-Id: <20090107.171907.12026879.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080421.153231.108090227.davem@davemloft.net>
In-Reply-To: <20080421.153231.108090227.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


The most noteworthy thing in here is the conversion
of sparc64 to use "unsigned long long" for it's u64
type.

Other than that we have a few cleanups that try to
prevent spurious warnings on sparc64 when the branch
tracer is enabled with gcc-3.4.x

Please pull, thanks!

The following changes since commit 238c6d54830c624f34ac9cf123ac04aebfca5013:
  Linus Torvalds (1):
        Merge git://git.kernel.org/.../agk/linux-2.6-dm

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

David S. Miller (1):
      sparc64: Work around branch tracer warning.

Sam Ravnborg (5):
      sparc64: refactor code in viohs.c
      sparc64: refactor code in init_64.c
      sparc: refactor code in fault_32.c
      sparc64: Use unsigned long long for u64.
      sparc64: Fix unsigned long long warnings in drivers.

Steven Rostedt (1):
      sparc: make proces_ver_nack a bit more readable

 arch/sparc/include/asm/timer_64.h |    2 +-
 arch/sparc/include/asm/types.h    |    2 +-
 arch/sparc/kernel/ds.c            |   34 +++++++++++++-------------
 arch/sparc/kernel/iommu.c         |    2 +-
 arch/sparc/kernel/ldc.c           |   23 +++++++++--------
 arch/sparc/kernel/mdesc.c         |   14 +++++-----
 arch/sparc/kernel/of_device_64.c  |    2 +-
 arch/sparc/kernel/pci.c           |    2 +-
 arch/sparc/kernel/pci_common.c    |    2 +-
 arch/sparc/kernel/pci_msi.c       |    4 +-
 arch/sparc/kernel/pci_schizo.c    |    2 +-
 arch/sparc/kernel/pci_sun4v.c     |    2 +-
 arch/sparc/kernel/power.c         |    2 +-
 arch/sparc/kernel/prom_irqtrans.c |    2 +-
 arch/sparc/kernel/psycho_common.c |   14 +++++-----
 arch/sparc/kernel/smp_64.c        |    4 +-
 arch/sparc/kernel/time_64.c       |   12 ++++----
 arch/sparc/kernel/traps_64.c      |   20 +++++++-------
 arch/sparc/kernel/unaligned_64.c  |    8 ++++-
 arch/sparc/kernel/vio.c           |    4 +-
 arch/sparc/kernel/viohs.c         |    6 +++-
 arch/sparc/mm/fault_32.c          |    3 +-
 arch/sparc/mm/init_64.c           |   48 ++++++++++++++++++++++--------------
 drivers/block/sunvdc.c            |    8 +++---
 drivers/char/hw_random/n2-drv.c   |    2 +-
 drivers/net/sunvnet.c             |    8 +++---
 drivers/sbus/char/display7seg.c   |    2 +-
 sound/sparc/cs4231.c              |    2 +-
 28 files changed, 127 insertions(+), 109 deletions(-)


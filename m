From: David Miller <davem@davemloft.net>
Date: Sat, 12 Jan 2013 23:56:53 +0000
Subject: [GIT] Sparc
Message-Id: <20130112.155653.29239994621684430.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


1) Add finit_module syscall entry.

2) Remove stray __dev{init,exit} references, from Sam Ravnborg.

Please pull, thanks a lot!

The following changes since commit c4271c6e37c32105492cbbed35f45330cb327b94:

  NFS: Kill fscache warnings when mounting without -ofsc (2012-12-21 08:32:09 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc master

for you to fetch changes up to b7c13f76fda994284521f6ef996119c25282bdeb:

  sparc: remove __devinit, __devexit annotations (2013-01-12 15:28:45 -0800)

----------------------------------------------------------------
David S. Miller (1):
      sparc: Hook up finit_module syscall.

Sam Ravnborg (1):
      sparc: remove __devinit, __devexit annotations

 arch/sparc/include/asm/parport.h     |  6 +++---
 arch/sparc/include/asm/timer_64.h    |  2 +-
 arch/sparc/include/uapi/asm/unistd.h |  3 ++-
 arch/sparc/kernel/apc.c              |  4 ++--
 arch/sparc/kernel/auxio_64.c         |  2 +-
 arch/sparc/kernel/central.c          |  6 +++---
 arch/sparc/kernel/chmc.c             | 34 +++++++++++++++++-----------------
 arch/sparc/kernel/ds.c               |  5 ++---
 arch/sparc/kernel/ldc.c              |  2 +-
 arch/sparc/kernel/leon_pci.c         |  2 +-
 arch/sparc/kernel/leon_pci_grpci2.c  |  2 +-
 arch/sparc/kernel/pci.c              | 37 ++++++++++++++++++-------------------
 arch/sparc/kernel/pci_fire.c         |  6 +++---
 arch/sparc/kernel/pci_psycho.c       | 12 ++++++------
 arch/sparc/kernel/pci_sabre.c        |  9 ++++-----
 arch/sparc/kernel/pci_schizo.c       | 16 +++++++---------
 arch/sparc/kernel/pci_sun4v.c        | 15 +++++++--------
 arch/sparc/kernel/pcic.c             |  5 ++---
 arch/sparc/kernel/pmc.c              |  2 +-
 arch/sparc/kernel/power.c            |  4 ++--
 arch/sparc/kernel/smp_64.c           |  4 ++--
 arch/sparc/kernel/systbls_32.S       |  2 +-
 arch/sparc/kernel/systbls_64.S       |  4 ++--
 arch/sparc/kernel/time_32.c          |  2 +-
 arch/sparc/kernel/time_64.c          | 10 +++++-----
 arch/sparc/mm/init_64.c              |  6 +++---
 26 files changed, 98 insertions(+), 104 deletions(-)

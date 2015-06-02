From: David Miller <davem@davemloft.net>
Date: Tue, 02 Jun 2015 00:17:18 +0000
Subject: [GIT] Sparc
Message-Id: <20150601.171718.1226234480003413221.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


1) Setup the core/threads/sockets bitmaps correctly so that 'lscpus' and friends
   operate properly.  Frtom Chris Hyser.

2) The bit that normally means "Cached Virtually" on sun4v systems,
   actually changes meaning in M7 and later chips.  Fix from Khalid
   Aziz.

3) One some PCI-E systems we need to probe different OF properties
   to fill in the PCI slot information properly, from Eric Snowberg.

4) Kill an extraneous memset after kzalloc(), from Christophe Jaillet.

Please pull, thanks a lot!

The following changes since commit a62d016cece2fce1d5e4eedf36b17f03a7a5c78e:

  Merge tag 'for-linus-20150422' of git://git.infradead.org/linux-mtd (2015-04-22 12:00:44 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc 

for you to fetch changes up to 494e5b6faeda1d1e830a13e10b3c7bc323f35d97:

  sparc: Resolve conflict between sparc v9 and M7 on usage of bit 9 of TTE (2015-05-31 22:15:01 -0700)

----------------------------------------------------------------
Christophe Jaillet (1):
      sparc: kernel: GRPCI2: Remove a useless memset

Eric Snowberg (1):
      sparc64: pci slots information is not populated in sysfs

Khalid Aziz (1):
      sparc: Resolve conflict between sparc v9 and M7 on usage of bit 9 of TTE

chris hyser (1):
      sparc64: Setup sysfs to mark LDOM sockets, cores and threads correctly

 arch/sparc/include/asm/cpudata_64.h  |   3 +-
 arch/sparc/include/asm/pgtable_64.h  |  22 +++++-
 arch/sparc/include/asm/topology_64.h |   3 +-
 arch/sparc/include/asm/trap_block.h  |   2 +
 arch/sparc/kernel/entry.h            |   2 +
 arch/sparc/kernel/leon_pci_grpci2.c  |   1 -
 arch/sparc/kernel/mdesc.c            | 136 ++++++++++++++++++++++++++++-------
 arch/sparc/kernel/pci.c              |  59 ++++++++++++---
 arch/sparc/kernel/setup_64.c         |  21 ++++++
 arch/sparc/kernel/smp_64.c           |  13 ++++
 arch/sparc/kernel/vmlinux.lds.S      |   5 ++
 arch/sparc/mm/init_64.c              |  74 +++++++++++++------
 12 files changed, 282 insertions(+), 59 deletions(-)

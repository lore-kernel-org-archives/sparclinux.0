From: David Miller <davem@davemloft.net>
Date: Thu, 06 Oct 2016 07:57:58 +0000
Subject: [GIT] Sparc
Message-Id: <20161006.035758.1766823520509065815.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Besides some cleanups the major thing here is supporting relaxed
ordering PCIe transactions on newer sparc64 machines, from Chris
Hyser.

Please pull, thanks a lot!

The following changes since commit c8d2bc9bc39ebea8437fd974fdbc21847bb897a3:

  Linux 4.8 (2016-10-02 16:24:33 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git 

for you to fetch changes up to 98e98eb6a8a179a444a30d903714fab356726155:

  sparc: fixing ident and beautifying code (2016-10-06 01:46:40 -0400)

----------------------------------------------------------------
David S. Miller (1):
      Merge branch 'sparc-pcie-perf'

Paul Gortmaker (1):
      sparc: migrate exception table users off module.h and onto extable.h

chris hyser (2):
      sparc64: Enable PCI IOMMU version 2 API
      sparc64: Enable setting "relaxed ordering" in IOMMU mappings

netmonk@netmonk.org (1):
      sparc: fixing ident and beautifying code

 arch/sparc/include/asm/hypervisor.h |  1 +
 arch/sparc/kernel/kprobes.c         |  2 +-
 arch/sparc/kernel/pci_sun4v.c       | 52 +++++++++++++++++++++++++++++++++++++++++-----------
 arch/sparc/kernel/traps_64.c        |  2 +-
 arch/sparc/kernel/unaligned_64.c    |  2 +-
 arch/sparc/mm/fault_64.c            |  2 +-
 arch/sparc/mm/init_64.c             |  2 +-
 arch/sparc/prom/ranges.c            | 52 ++++++++++++++++++++++++----------------------------
 8 files changed, 71 insertions(+), 44 deletions(-)

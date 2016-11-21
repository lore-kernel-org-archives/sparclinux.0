From: David Miller <davem@davemloft.net>
Date: Mon, 21 Nov 2016 18:41:31 +0000
Subject: [GIT] Sparc
Message-Id: <20161121.134131.1958084384811695201.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


1) With modern networking cards we can run out of 32-bit DMA space, so
   support 64-bit DMA addressing when possible on sparc64.  From Dave
   Tushar.

2) Some signal frame validation checks are inverted on sparc32, fix from
   Andreas Larsson.

3) Lockdep tables can get too large in some circumstances on sparc64,
   add a way to adjust the size a bit.  From Babu Moger.

4) Fix NUMA node probing on some sun4v systems, from Thomas Tai.

Please pull, thanks a lot!

The following changes since commit 27bcd37e0240bbe33f0efe244b5aad52104115b3:

  Merge tag 'sound-4.9-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound (2016-11-09 11:39:02 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git 

for you to fetch changes up to 9dd35d6882a10629b95f2bc41a541740ef24c226:

  sparc: drop duplicate header scatterlist.h (2016-11-19 10:43:07 -0500)

----------------------------------------------------------------
Andreas Larsson (1):
      sparc32: Fix inverted invalid_frame_pointer checks on sigreturns

Babu Moger (2):
      config: Adding the new config parameter CONFIG_PROVE_LOCKING_SMALL for sparc
      lockdep: Limit static allocations if PROVE_LOCKING_SMALL is defined

Dave Kleikamp (1):
      sparc64: Add FORCE_MAX_ZONEORDER and default to 13

David S. Miller (2):
      Merge branch 'sun4v-64bit-DMA'
      Merge branch 'sparc-lockdep-small'

Geliang Tang (1):
      sparc: drop duplicate header scatterlist.h

Thomas Tai (2):
      sparc64: Fix find_node warning if numa node cannot be found
      sparc64: fix compile warning section mismatch in find_node()

Tushar Dave (7):
      sparc64: Add ATU (new IOMMU) support
      sparc64: Initialize iommu_map_table and iommu_pool
      sparc64: Bind PCIe devices to use IOMMU v2 service
      sparc64: Enable sun4v dma ops to use IOMMU v2 APIs
      sparc64: Enable 64-bit DMA
      sunqe: Fix compiler warnings
      sunbmac: Fix compiler warning

 arch/sparc/Kconfig                  |  23 +++++++++
 arch/sparc/include/asm/hypervisor.h | 343 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/sparc/include/asm/iommu_64.h   |  28 ++++++++++
 arch/sparc/kernel/hvapi.c           |   1 +
 arch/sparc/kernel/iommu.c           |   8 ++-
 arch/sparc/kernel/iommu_common.h    |   1 -
 arch/sparc/kernel/pci_sun4v.c       | 418 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------
 arch/sparc/kernel/pci_sun4v.h       |  21 ++++++++
 arch/sparc/kernel/pci_sun4v_asm.S   |  68 ++++++++++++++++++++++++
 arch/sparc/kernel/signal_32.c       |   4 +-
 arch/sparc/mm/init_64.c             |  71 ++++++++++++++++++++++---
 drivers/net/ethernet/sun/sunbmac.c  |   5 +-
 drivers/net/ethernet/sun/sunbmac.h  |   2 +-
 drivers/net/ethernet/sun/sunqe.c    |  11 ++--
 drivers/net/ethernet/sun/sunqe.h    |   4 +-
 kernel/locking/lockdep_internals.h  |  20 ++++++--
 lib/Kconfig.debug                   |   3 ++
 17 files changed, 948 insertions(+), 83 deletions(-)

From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Date: Fri, 23 Oct 2015 20:54:20 +0000
Subject: [PATCH 0/5 v3] Fix NVMe driver support on Power with 32-bit DMA
Message-Id: <20151023205420.GA10197@linux.vnet.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

We received a bug report recently when DDW (64-bit direct DMA on Power)
is not enabled for NVMe devices. In that case, we fall back to 32-bit
DMA via the IOMMU, which is always done via 4K TCEs (Translation Control
Entries).

The NVMe device driver, though, assumes that the DMA alignment for the
PRP entries will match the device's page size, and that the DMA aligment
matches the kernel's page aligment. On Power, the the IOMMU page size,
as mentioned above, can be 4K, while the device can have a page size of
8K, while the kernel has a page size of 64K. This eventually trips the
BUG_ON in nvme_setup_prps(), as we have a 'dma_len' that is a multiple
of 4K but not 8K (e.g., 0xF000).

In this particular case, and generally, we want to use the IOMMU's page
size for the default device page size, rather than the kernel's page
size.

This series consists of five patches:

1) add a generic dma_get_page_shift implementation that just returns
PAGE_SHIFT
2) override the generic implementation on Power to use the IOMMU table's
page shift if available
3) allow further specific overriding on power with machdep platform
overrides
4) use the machdep override on pseries, as the DDW code puts the TCE
shift in a special property and there is no IOMMU table available
5) move some sparc code around to make IOMMU_PAGE_SHIFT available in
include/asm
6) override the generic implementation on sparce to use IOMMU_PAGE_SHIFT
7) leverage the new API in the NVMe driver

With these patches, a NVMe device survives our internal hardware
exerciser; the kernel BUGs within a few seconds without the patch.

 arch/powerpc/include/asm/dma-mapping.h |  3 +++
 arch/powerpc/include/asm/machdep.h     |  3 ++-
 arch/powerpc/kernel/dma.c              | 11 +++++++++++
 arch/powerpc/platforms/pseries/iommu.c | 36 ++++++++++++++++++++++++++++++++++++
 arch/sparc/include/asm/dma-mapping.h   |  8 ++++++++
 arch/sparc/include/asm/iommu_common.h  | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/sparc/kernel/iommu.c              |  2 +-
 arch/sparc/kernel/iommu_common.h       | 51 ---------------------------------------------------
 arch/sparc/kernel/pci_psycho.c         |  2 +-
 arch/sparc/kernel/pci_sabre.c          |  2 +-
 arch/sparc/kernel/pci_schizo.c         |  2 +-
 arch/sparc/kernel/pci_sun4v.c          |  2 +-
 arch/sparc/kernel/psycho_common.c      |  2 +-
 arch/sparc/kernel/sbus.c               |  3 +--
 drivers/block/nvme-core.c              |  3 ++-
 include/linux/dma-mapping.h            |  7 +++++++
 16 files changed, 127 insertions(+), 61 deletions(-)

v1 -> v2:
  Based upon feedback from Christoph Hellwig, rather than using an
  arch-specific hack, expose the DMA page shift via a generic DMA API and
  override it on Power as needed.
v2 -> v3:
  Based upon feedback from Christoph Hellwig, put the generic
  implementation in include/linux/dma-mapping.h, since not all archs use
  include/asm-generic/dma-mapping-common.h.
  Add sparc implementation, as that arch seems to have a different IOMMU
  page size.


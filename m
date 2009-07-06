From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Date: Mon, 06 Jul 2009 06:13:35 +0000
Subject: [PATCH 0/5] sparc: use asm-generic/dma-mapping-common.h and pci-dma-compat.h
Message-Id: <1246860820-20629-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, reif@earthlink.net

This patchset converts SPARC to use asm-generic/dma-mapping-common.h
and pci-dma-compat.h.

1/5, 2/5, and 3/5 converts SPARC to use
asm-generic/dma-mapping-common.h. All the preparation for this was
already merged in 2.6.31-rc1 so the chages are pretty trivial.

4/5 and 5/5 converts SPARC to use asm-generic/pci-dma-compat.h instead of 
the homegrown mechnism to handle dma_* and pci_* API.

SPARC32 has two dma_map_ops structures for pci and sbus (removing
arch/sparc/kernel/dma.c, PCI and SBUS DMA accessor). The global
'dma_ops' is set to sbus_dma_ops and get_dma_ops() returns
pci32_dma_ops for pci devices so we can use the appropriate dma
mapping operations.

The patchset is only compile-tested (sorry about it).

 arch/sparc/Kconfig                   |    1 +
 arch/sparc/include/asm/dma-mapping.h |  138 +++-------------------------
 arch/sparc/include/asm/pci.h         |    3 +
 arch/sparc/include/asm/pci_32.h      |  105 ----------------------
 arch/sparc/include/asm/pci_64.h      |   88 ------------------
 arch/sparc/kernel/dma.c              |  152 ++------------------------------
 arch/sparc/kernel/dma.h              |   14 ---
 arch/sparc/kernel/iommu.c            |   20 +++--
 arch/sparc/kernel/ioport.c           |  163 ++++++++++++++++------------------
 arch/sparc/kernel/pci.c              |    2 +-
 arch/sparc/kernel/pci_sun4v.c        |   30 ++-----
 11 files changed, 127 insertions(+), 589 deletions(-)




From: Kristoffer Glembo <kristoffer@gaisler.com>
Date: Tue, 18 Jan 2011 14:10:23 +0000
Subject: [PATCH 0/6 V3] ioport.c patch series
Message-Id: <1295359829-27308-1-git-send-email-kristoffer@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Version three.

* LEON dma_ops = pci32_dma_ops.

* mmu_inval_dma_area takes void * instead of unsigned long to avoid casts.

* Fixed an error in the error handling of sbus_alloc_coherent.

Thanks for reviewing.

Kristoffer Glembo (6):
  sparc: Replace open coded page alignment with PAGE_ALIGN macro.
  sparc: Add pci32_unmap_page.
  sparc/leon: Add LEON dma_ops.
  sparc/leon: Make mmu_inval_dma_area flush dcache for LEONs without
    snooping enabled.
  sparc: Make mmu_inval_dma_area take void * instead of unsigned long
    to minimize casts.
  sparc: Fix sbus_alloc_coherent error handling.

 arch/sparc/kernel/ioport.c |  108 +++++++++++++++++++++++++------------------
 1 files changed, 63 insertions(+), 45 deletions(-)


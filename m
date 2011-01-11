From: Kristoffer Glembo <kristoffer@gaisler.com>
Date: Tue, 11 Jan 2011 10:49:02 +0000
Subject: [PATCH 0/4] ioport.c patch series
Message-Id: <1294742946-1040-1-git-send-email-kristoffer@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


I have split up the old patch into more logical pieces. Hopefully this can be
accepted and then we can further clean this up. 


Kristoffer Glembo (4):
  sparc: Replace open coded page alignment with PAGE_ALIGN macro.
  sparc/leon: Make mmu_inval_dma_area flush dcache for LEONs without
    snooping enabled.
  sparc: Add pci32_unmap_page.
  sparc/leon: Add LEON dma_ops.

 arch/sparc/kernel/ioport.c |  116 +++++++++++++++++++++++++++++++++-----------
 1 files changed, 88 insertions(+), 28 deletions(-)


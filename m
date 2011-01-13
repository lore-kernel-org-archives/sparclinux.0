From: Kristoffer Glembo <kristoffer@gaisler.com>
Date: Thu, 13 Jan 2011 09:05:31 +0000
Subject: [PATCH 0/4 V2] ioport.c patch series
Message-Id: <1294909535-6290-1-git-send-email-kristoffer@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I have split up the old patch into more logical pieces. Hopefully this can be
accepted and then we can further clean this up.

V2: Coding style changes.


Kristoffer Glembo (4):
  sparc: Replace open coded page alignment with PAGE_ALIGN macro.
  sparc: Add pci32_unmap_page.
  sparc/leon: Make mmu_inval_dma_area flush dcache for LEONs without
    snooping enabled.
  sparc/leon: Add LEON dma_ops.

 arch/sparc/kernel/ioport.c |  112 +++++++++++++++++++++++++++++++++-----------
 1 files changed, 84 insertions(+), 28 deletions(-)


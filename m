From: Christoph Hellwig <hch@lst.de>
Date: Fri, 20 Apr 2018 08:02:51 +0000
Subject: 
Message-Id: <20180420080313.18796-1-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-arch@vger.kernel.org, linux-xtensa@linux-xtensa.org, Michal Simek <monstr@monstr.eu>, Vincent Chen <deanbo422@gmail.com>, linux-c6x-dev@linux-c6x.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org, Greentime Hu <green.hu@gmail.com>, linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org, nios2-dev@lists.rocketboards.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org

To: iommu@lists.linux-foundation.org
Cc: linux-arch@vger.kernel.org
Cc: Michal Simek <monstr@monstr.eu>
Cc: Greentime Hu <green.hu@gmail.com>
Cc: Vincent Chen <deanbo422@gmail.com>
Cc: linux-alpha@vger.kernel.org
Cc: linux-snps-arc@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-c6x-dev@linux-c6x.org
Cc: linux-hexagon@vger.kernel.org
Cc: linux-m68k@lists.linux-m68k.org
Cc: nios2-dev@lists.rocketboards.org
Cc: openrisc@lists.librecores.org
Cc: linux-parisc@vger.kernel.org
Cc: linux-sh@vger.kernel.org
Cc: sparclinux@vger.kernel.org
Cc: linux-xtensa@linux-xtensa.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC] common non-cache coherent direct dma mapping ops

Hi all,

this series continues consolidating the dma-mapping code, with a focus
on architectures that do not (always) provide cache coherence for DMA.
Three architectures (arm, mips and powerpc) are still left to be
converted later due to complexity of their dma ops selection.

The dma-noncoherent ops calls the dma-direct ops for the actual
translation of streaming mappins and allow the architecture to provide
any cache flushing required for cpu to device and/or device to cpu
ownership transfers.  The dma coherent allocator is for now still left
entirely to architecture supplied implementations due the amount of
variations.  Hopefully we can do some consolidation for them later on
as well.

A lot of architectures are currently doing very questionable things
in their dma mapping routines, which are documented in the changelogs
for each patch.  Please review them very careful and correct me on
incorrect assumptions.

Because this series sits on top of two previously submitted series
a git tree might be useful to actually test it.  It is provided here:

    git://git.infradead.org/users/hch/misc.git generic-dma-noncoherent

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/generic-dma-noncoherent

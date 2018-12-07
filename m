From: Christoph Hellwig <hch@lst.de>
Date: Fri, 07 Dec 2018 14:14:03 +0000
Subject: remove the sparc32_dma_ops indirection
Message-Id: <20181207141407.3154-1-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Dave,

can you look at this series?  It removes the sparc32_dma_ops
structure and variable, which just double indirects the DMA
mapping calls on sparc32.

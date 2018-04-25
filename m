From: Christoph Hellwig <hch@lst.de>
Date: Wed, 25 Apr 2018 05:15:26 +0000
Subject: centralize SWIOTLB config symbol and misc other cleanups V3
Message-Id: <20180425051539.1989-1-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20180415145947.1248-1-hch@lst.de>
In-Reply-To: <20180415145947.1248-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi all,

this seris aims for a single defintion of the Kconfig symbol.  To get
there various cleanups, mostly about config symbols are included as well.

Changes since V2:
 - swiotlb doesn't need the dma_length field by itself, so don't select it
 - don't offer a user visible SWIOTLB choice

Chages since V1:
 - fixed a incorrect Reviewed-by that should be a Signed-off-by.

From: Christoph Hellwig <hch@lst.de>
Date: Mon, 23 Apr 2018 17:04:07 +0000
Subject: centralize SWIOTLB config symbol and misc other cleanups V2
Message-Id: <20180423170419.20330-1-hch@lst.de>
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

Chances since V2 are a fixed s/Reviewed/Signed-Off/ for me, and a few
reviewed-by tags.  I'd like to start merging this into the dma-mapping
tree rather sooner than later given that quite a bit of material for
this series depends on it.

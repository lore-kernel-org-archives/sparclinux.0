From: Christoph Hellwig <hch@lst.de>
Date: Sun, 15 Apr 2018 14:59:35 +0000
Subject: centralize SWIOTLB config symbol and misc other cleanups
Message-Id: <20180415145947.1248-1-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi all,

this seris aims for a single defintion of the Kconfig symbol.  To get
there various cleanups, mostly about config symbols are included as well.

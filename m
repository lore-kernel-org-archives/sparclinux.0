From: Christoph Hellwig <hch@lst.de>
Date: Fri, 14 Dec 2018 08:25:13 +0000
Subject: ensure dma_alloc_coherent always returns zeroed memory
Message-Id: <20181214082515.14835-1-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu@lists.linux-foundation.org
Cc: linux-s390@vger.kernel.org, Michal Simek <monstr@monstr.eu>, linux-c6x-dev@linux-c6x.org, linux-parisc@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org, Ashutosh Dixit <ashutosh.dixit@intel.com>, linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org, linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org, linux-snps-arc@lists.infradead.org

For security reasons we already returned zeroed memory from
dma_alloc_coherent on most common platforms, but some implementation
missed out.  Make sure we provide a consistent behavior.

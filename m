From: "hch@lst.de" <hch@lst.de>
Date: Thu, 20 Dec 2018 17:37:17 +0000
Subject: Re: ensure dma_alloc_coherent always returns zeroed memory
Message-Id: <20181220173717.GA20939@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20181214082515.14835-1-hch@lst.de> <20181219165939.GA26087@lst.de> <1545316369.14089.20.camel@synopsys.com> <20181220143415.GA17726@lst.de> <1545316759.14089.22.camel@synopsys.com> <20181220144604.GA18034@lst.de>
In-Reply-To: <20181220144604.GA18034@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
Cc: "hch@lst.de" <hch@lst.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>, "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>, "vineet.gupta1@synopsys.com" <vineet.gupta1@synopsys.com>, "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>, "ashutosh.dixit@intel.com" <ashutosh.dixit@intel.com>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>

Btw, can you try wit the very latests dma-mapping-for-next tree
which has a new fix from Thierry Reding that might be related.

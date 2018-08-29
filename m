From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 29 Aug 2018 22:38:21 +0000
Subject: Re: various dma_mask fixups
Message-Id: <20180829223821.GA29499@roeck-us.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20180829062401.8701-1-hch@lst.de>
In-Reply-To: <20180829062401.8701-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>, Meelis Roos <mroos@linux.ee>, Linus Walleij <linus.walleij@linaro.org>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 08:23:58AM +0200, Christoph Hellwig wrote:
> Fix warnings and regressions from requiring a dma mask.

With this series applied, I see the following in my sh4 boot tests.

sb 1-1: new full-speed USB device number 2 using sm501-usb
sm501-usb sm501-usb: OHCI Unrecoverable Error, disabled
sm501-usb sm501-usb: HC died; cleaning up

This is a persistent problem. Reverting upstream commit 2f606da7823
("mfd: sm501: Set coherent_dma_mask when creating subdevices") does not
make a difference.

The problem is gone if I do not apply 'driver core: initialize a default
DMA mask for platform device'.

On the plus side, the sparc warnings are gone.

Guenter

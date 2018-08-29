From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 29 Aug 2018 06:59:48 +0000
Subject: Re: various dma_mask fixups
Message-Id: <CACRpkdaHfNE7aPc5G6u7aGaXjq9ccpvtmnRyFg2n+g52eqY22w@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20180829062401.8701-1-hch@lst.de>
In-Reply-To: <20180829062401.8701-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>, mroos@linux.ee, Guenter Roeck <linux@roeck-us.net>, sparclinux@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, Aug 29, 2018 at 8:24 AM Christoph Hellwig <hch@lst.de> wrote:

> Fix warnings and regressions from requiring a dma mask.

Applied all three patches and took a few ARM systems for a test ride:
Tested-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

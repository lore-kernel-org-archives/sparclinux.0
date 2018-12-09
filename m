From: David Miller <davem@davemloft.net>
Date: Sun, 09 Dec 2018 04:57:26 +0000
Subject: Re: [PATCH 2/2] sparc: merge 32-bit and 64-bit version of pci.h
Message-Id: <20181208.205726.1874057501835310734.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20181208174033.16168-2-hch@lst.de>
In-Reply-To: <20181208174033.16168-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>
Date: Sat,  8 Dec 2018 09:40:33 -0800

> There are enough common defintions that a single header seems nicer.
> 
> Also drop the pointless <linux/dma-mapping.h> include.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Sam Ravnborg <sam@ravnborg.org>

Acked-by: David S. Miller <davem@davemloft.net>

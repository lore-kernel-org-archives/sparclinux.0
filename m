From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 16 Apr 2019 19:35:38 +0000
Subject: Re: fix SG list handling in the sparc32 iommu driver
Message-Id: <20190416193538.GA8093@roeck-us.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20190416182347.18441-1-hch@lst.de>
In-Reply-To: <20190416182347.18441-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 08:23:38PM +0200, Christoph Hellwig wrote:
> Hi Dave,
> 
> this series fixes some long standing bugs in the sparc32 iommu driver,
> mostly the lack of handling of large sglist offsets in the map_sg
> method, but also a few other smaller bits.  These now show up all the
> time do some block layer changes in linux-next.

For the series on top of next-20190416:

Tested-by: Guenter Roeck <linux@roeck-us.net>

... meaning the sparc boot tests no longer crash with the series applied.

Guenter

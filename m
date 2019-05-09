From: David Miller <davem@davemloft.net>
Date: Thu, 09 May 2019 00:12:09 +0000
Subject: Re: fix SG list handling in the sparc32 iommu driver
Message-Id: <20190508.171209.2240089477300123652.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20190416182347.18441-1-hch@lst.de>
In-Reply-To: <20190416182347.18441-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: hch@lst.de
Cc: linux@roeck-us.net, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>
Date: Tue, 16 Apr 2019 20:23:38 +0200

> this series fixes some long standing bugs in the sparc32 iommu driver,
> mostly the lack of handling of large sglist offsets in the map_sg
> method, but also a few other smaller bits.  These now show up all the
> time do some block layer changes in linux-next.

Series applied, thanks.

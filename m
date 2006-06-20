From: David Miller <davem@davemloft.net>
Date: Tue, 20 Jun 2006 07:41:03 +0000
Subject: Re: [PATCH] sparc32: fix iommu_flush_iotlb end address
Message-Id: <20060620.004103.83621466.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <449774DB.6090201@mc.net>
In-Reply-To: <449774DB.6090201@mc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bob Breuer <breuerr@mc.net>
Date: Mon, 19 Jun 2006 23:08:59 -0500

> Fix the calculation of the end address when flushing iotlb entries to
> ram.  This bug has been a cause of esp dma errors, and it affects
> HyperSPARC systems much worse than SuperSPARC systems.
> 
> Signed-off-by: Bob Breuer <breuerr@mc.net>

Good catch, that bug would explain a lot.

Applied, and I'll toss this to -stable too.

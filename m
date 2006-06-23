From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Fri, 23 Jun 2006 10:41:57 +0000
Subject: Re: [PATCH] sparc32: fix iommu_flush_iotlb end address
Message-Id: <20060623104157.GA13880@palantir8>
List-Id: <sparclinux.vger.kernel.org>
References: <449774DB.6090201@mc.net>
In-Reply-To: <449774DB.6090201@mc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Bob,

On Mon, Jun 19, 2006 at 11:08:59PM -0500, Bob Breuer wrote:
> Fix the calculation of the end address when flushing iotlb entries to
> ram.  This bug has been a cause of esp dma errors, and it affects
> HyperSPARC systems much worse than SuperSPARC systems.

Thanks for this patch! I was going cross-eyed trying to figure this
out. I have updated kernel bug 6344 with this info. Can no longer reproduce
any esp dma errors.

Thanks,
-- 
Martin

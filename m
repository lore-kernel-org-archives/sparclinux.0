From: David Miller <davem@davemloft.net>
Date: Wed, 09 Feb 2011 06:53:19 +0000
Subject: Re: [PATCH] sparc: fix size argument to find_next_zero_bit()
Message-Id: <20110208.225319.71128103.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1297177190-1423-2-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1297177190-1423-2-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Tue,  8 Feb 2011 23:59:50 +0900

> iommu_alloc_ctx() finds a zero bit in iommu->ctx_bitmap.  It starts
> searching from iommu->ctx_lowest_free to the end of the bitmap.
> But the size argument to find_next_zero_bit() in iommu_alloc_ctx()
> is wrong.  It should be the bitmap size, not the maximum size to
> search from the offset argument.
> 
> Fortunately iommu->ctx_lowest_free is almost unused and it will not
> be more than 1. So the bug wasted only 1-bit at the end of
> iommu->ctx_bitmap.
> 
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

Thank you for fixing this bug, applied!

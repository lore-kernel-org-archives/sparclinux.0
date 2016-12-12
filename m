From: David Miller <davem@davemloft.net>
Date: Mon, 12 Dec 2016 02:18:24 +0000
Subject: Re: [patch] sparc64: move dereference after check for NULL
Message-Id: <20161211.211824.143836509582059585.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 25 Nov 2016 14:01:32 +0300

> We shouldn't dereference "iommu" until after we have checked that it is
> non-NULL.
> 
> Fixes: f08978b0fdbf ("sparc64: Enable sun4v dma ops to use IOMMU v2 APIs")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied.

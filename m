From: David Miller <davem@davemloft.net>
Date: Mon, 12 Dec 2016 02:19:05 +0000
Subject: Re: [patch] sparc64: restore irq in error paths in iommu
Message-Id: <20161211.211905.982846821674091118.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Sat, 26 Nov 2016 00:15:37 +0300

> There are some error paths where we should restore IRQs but we don't.
> 
> Fixes: bb620c3d3925 ("sparc: Make sparc64 use scalable lib/iommu-common.c functions")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied.

From: David Miller <davem@davemloft.net>
Date: Thu, 06 Apr 2017 19:07:04 +0000
Subject: Re: [PATCH] sparc32: Export vac_cache_size to fix build error
Message-Id: <20170406.120704.908865833968811759.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1491079664-12615-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1491079664-12615-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux@roeck-us.net
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, jgunthorpe@obsidianresearch.com, dledford@redhat.com

From: Guenter Roeck <linux@roeck-us.net>
Date: Sat,  1 Apr 2017 13:47:44 -0700

> sparc32:allmodconfig fails to build with the following error.
> 
> ERROR: "vac_cache_size" [drivers/infiniband/sw/rxe/rdma_rxe.ko] undefined!
> 
> Fixes: cb8864559631 ("infiniband: Fix alignment of mmap cookies ...")
> Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> Cc: Doug Ledford <dledford@redhat.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Applied.

From: "David S. Miller" <davem@davemloft.net>
Date: Mon, 07 Nov 2005 21:54:19 +0000
Subject: Re: [PATCH] openprom: implement ->compat_ioctl
Message-Id: <20051107.135419.122077203.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20051107194123.GC32019@lst.de>
In-Reply-To: <20051107194123.GC32019@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>
Date: Mon, 7 Nov 2005 20:41:24 +0100

> implement a compat_ioctl handle in the driver instead of having table
> entries in sparc64 ioctl32.c (I plan to get rid of the arch ioctl32.c
> file eventually)
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Applied, thanks.

From: "David S. Miller" <davem@davemloft.net>
Date: Mon, 07 Nov 2005 21:52:10 +0000
Subject: Re: [PATCH] envctrl: implement ->unlocked_ioctl and ->compat_ioctl
Message-Id: <20051107.135210.07451897.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20051107193956.GB32019@lst.de>
In-Reply-To: <20051107193956.GB32019@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>
Date: Mon, 7 Nov 2005 20:39:56 +0100

> all the ioctls in the driver are 32bit compat clean and don't need BKL,
> so we can switch it to ->unlocked_ioctl and ->compat_ioctl trivially.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Applied, thanks.

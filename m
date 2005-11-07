From: "David S. Miller" <davem@davemloft.net>
Date: Mon, 07 Nov 2005 21:56:02 +0000
Subject: Re: [PATCH] display7seg: implement ->unlocked_ioctl and
Message-Id: <20051107.135602.64086341.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20051107194232.GD32019@lst.de>
In-Reply-To: <20051107194232.GD32019@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>
Date: Mon, 7 Nov 2005 20:42:32 +0100

> all ioctls are 32bit compat clean, so the driver can use ->compat_ioctl
> and ->unlocked_ioctl easily.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Applied, thanks.

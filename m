From: "David S. Miller" <davem@davemloft.net>
Date: Mon, 07 Nov 2005 22:00:18 +0000
Subject: Re: [PATCH] sparc64: remove drm compat ioctl handling
Message-Id: <20051107.140018.27137229.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20051107193835.GA32019@lst.de>
In-Reply-To: <20051107193835.GA32019@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>
Date: Mon, 7 Nov 2005 20:38:35 +0100

> drivers/drm/ now implements proper ->compat_ioctl methods, so this isn't
> needed anymore.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Applied, thanks.

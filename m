From: "David S. Miller" <davem@davemloft.net>
Date: Tue, 17 Jan 2006 23:34:12 +0000
Subject: Re: [PATCH] fix up sbuslib for new fb_comapt_ioctl prototype
Message-Id: <20060117.153412.103308167.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20060115205554.GA19609@lst.de>
In-Reply-To: <20060115205554.GA19609@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>
Date: Sun, 15 Jan 2006 21:55:54 +0100

> After ages my fb ioctl prototype cleanup finally got in.  Unfortunately
> the patch are so old that the sbus compat_ioctl helper didn't exist back
> then, so it's not covered.  This patch should fix that issue.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Please seek some way to get your sparc patches build tested in the
future.  This patch went into Linus's tree, which is extremely
unfortunate because it is totally untested.  And all it does is trade
one build failure for another.

You updated the fb_ioctl() prototypes but not the ones of the
functions that are called from them.

I was going to get to reviewing and fixing up this patch today.

drivers/video/sbuslib.c: In function 'sbusfb_compat_ioctl':
drivers/video/sbuslib.c:282: warning: passing argument 1 of 'fbiogetputcmap' from incompatible pointer type
drivers/video/sbuslib.c:282: warning: passing argument 2 of 'fbiogetputcmap' makes pointer from integer without a cast
drivers/video/sbuslib.c:282: error: too few arguments to function 'fbiogetputcmap'
drivers/video/sbuslib.c:284: warning: passing argument 1 of 'fbiogetputcmap' from incompatible pointer type
drivers/video/sbuslib.c:284: warning: passing argument 2 of 'fbiogetputcmap' makes pointer from integer without a cast
drivers/video/sbuslib.c:284: error: too few arguments to function 'fbiogetputcmap'
drivers/video/sbuslib.c:286: warning: passing argument 1 of 'fbiogscursor' from incompatible pointer type
drivers/video/sbuslib.c:286: warning: passing argument 2 of 'fbiogscursor' makes pointer from integer without a cast
drivers/video/sbuslib.c:286: error: too few arguments to function 'fbiogscursor'

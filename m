From: Andrew Morton <akpm@osdl.org>
Date: Tue, 17 Jan 2006 23:58:43 +0000
Subject: Re: [PATCH] fix up sbuslib for new fb_comapt_ioctl prototype
Message-Id: <20060117155843.1b44871e.akpm@osdl.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20060115205554.GA19609@lst.de>
In-Reply-To: <20060115205554.GA19609@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

"David S. Miller" <davem@davemloft.net> wrote:
>
> From: Christoph Hellwig <hch@lst.de>
> Date: Sun, 15 Jan 2006 21:55:54 +0100
> 
> > After ages my fb ioctl prototype cleanup finally got in.  Unfortunately
> > the patch are so old that the sbus compat_ioctl helper didn't exist back
> > then, so it's not covered.  This patch should fix that issue.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Please seek some way to get your sparc patches build tested in the
> future.

fyi, I'm build testing for both sparc64 and sparc32 now, so some more such
stuff will be caught early.

It would be soooooo much better if we had a warning-free build.

> drivers/video/sbuslib.c: In function 'sbusfb_compat_ioctl':
> drivers/video/sbuslib.c:282: warning: passing argument 1 of 'fbiogetputcmap' from incompatible pointer type
> drivers/video/sbuslib.c:282: warning: passing argument 2 of 'fbiogetputcmap' makes pointer from integer without a cast
> drivers/video/sbuslib.c:282: error: too few arguments to function 'fbiogetputcmap'
> drivers/video/sbuslib.c:284: warning: passing argument 1 of 'fbiogetputcmap' from incompatible pointer type
> drivers/video/sbuslib.c:284: warning: passing argument 2 of 'fbiogetputcmap' makes pointer from integer without a cast
> drivers/video/sbuslib.c:284: error: too few arguments to function 'fbiogetputcmap'
> drivers/video/sbuslib.c:286: warning: passing argument 1 of 'fbiogscursor' from incompatible pointer type
> drivers/video/sbuslib.c:286: warning: passing argument 2 of 'fbiogscursor' makes pointer from integer without a cast
> drivers/video/sbuslib.c:286: error: too few arguments to function 'fbiogscursor'

If the bug had produced only warnings and not an error, it might have snuck
further through.

We should all take a pledge to fix one warning per day ;)

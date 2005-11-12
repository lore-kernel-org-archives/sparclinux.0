From: "David S. Miller" <davem@davemloft.net>
Date: Sat, 12 Nov 2005 19:36:05 +0000
Subject: Re: [PATCH, RFC] sbusfb: implement ->compat_ioctl
Message-Id: <20051112.113605.111794628.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20051112092921.GA15605@lst.de>
In-Reply-To: <20051112092921.GA15605@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>
Date: Sat, 12 Nov 2005 10:29:21 +0100

> This patch adds a new function, sbusfb_compat_ioctl() to
> drivers/video/sbuslib.c and uses it as compat_ioctl in all sbus fb
> drivers, aswell as in aytfb under #ifdef sparc as a special case.
> 
> This remove the last per-arch compat ioctl bits in
> arch/sparc64/kernel/ioctl32.c so it would be nice if people could test
> if this actually copiles and works and if yes apply it :)
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

The atyfb bit isn't necessary, I'll just remove that part
when I apply this patch.  Thanks Christoph.

arch/sparc64/kernel/ioctl32.c is basically empty now :-)
which I imagine was your goal from the beginning...


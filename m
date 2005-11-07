From: "David S. Miller" <davem@davemloft.net>
Date: Mon, 07 Nov 2005 19:36:53 +0000
Subject: Re: [PATCH] remove kbio.h
Message-Id: <20051107.113653.123698145.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20051107040657.GC16485@lst.de>
In-Reply-To: <20051107040657.GC16485@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>
Date: Mon, 7 Nov 2005 20:30:20 +0100

> On Mon, Nov 07, 2005 at 10:44:19AM -0800, David S. Miller wrote:
> > From: Christoph Hellwig <hch@lst.de>
> > Date: Mon, 7 Nov 2005 05:06:57 +0100
> > 
> > > The old keyboard driver is gone in 2.6, so the only user left are the
> > > compat ioctls.
> > 
> > Applied, thanks.
> > 
> > There are some references in include/asm-m68k/kbio.h and
> > via Documentation/ioctl-number.txt, you might want to kill
> > those off too :-)
> 
> And references in the sunos_ioctl.c files that I missed, so this patch
> broke compiling with those enabled.  Would you mind applying the
> following patch that kills those two + the m68k and Documentation/
> references?

I will, thanks a lot.

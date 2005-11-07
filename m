From: "David S. Miller" <davem@davemloft.net>
Date: Mon, 07 Nov 2005 18:44:19 +0000
Subject: Re: [PATCH] remove kbio.h
Message-Id: <20051107.104419.65717679.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20051107040657.GC16485@lst.de>
In-Reply-To: <20051107040657.GC16485@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>
Date: Mon, 7 Nov 2005 05:06:57 +0100

> The old keyboard driver is gone in 2.6, so the only user left are the
> compat ioctls.

Applied, thanks.

There are some references in include/asm-m68k/kbio.h and
via Documentation/ioctl-number.txt, you might want to kill
those off too :-)

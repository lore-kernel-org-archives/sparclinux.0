From: "David S. Miller" <davem@davemloft.net>
Date: Tue, 09 Aug 2005 19:33:09 +0000
Subject: Re: [PATCH] use kthread infrastructure in envctrl
Message-Id: <20050809.123309.93235739.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20050809135128.GA22257@lst.de>
In-Reply-To: <20050809135128.GA22257@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>
Date: Tue, 9 Aug 2005 15:51:28 +0200

> envctrl currently uses very odd ways to stop a thread, using various
> things that should be exposed to drivers at all.
> 
> This patch (which is untested as I don't have sparc hardware) switches
> it to use the proper kthread infrastructure.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good, applied.

Same exact kind of gross code (written by me of course) exists
in bbc_envctrl.c as well.  Would you mind sending me a patch
to fix up that driver as well?

Thanks Christoph.

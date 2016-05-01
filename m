From: David Miller <davem@davemloft.net>
Date: Sun, 01 May 2016 23:41:44 +0000
Subject: Re: Bisected: RED State Exception in 4.5 on E420R
Message-Id: <20160501.194144.2062954600401356177.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1604061729350.16827@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1604061729350.16827@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Julian Calaby <julian.calaby@gmail.com>
Date: Fri, 29 Apr 2016 10:16:29 +1000

> Why not move all the "optional" code after swapper_tsb?

As Rob imagined, it's to keep this area from being wasted space in the
kernel image.  We pack as much code into this area as possible.  It's
also beneficial to group all of this trap processing code into the same
set of cache lines too.

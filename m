From: David Miller <davem@davemloft.net>
Date: Sun, 01 May 2016 23:36:26 +0000
Subject: Re: Bisected: RED State Exception in 4.5 on E420R
Message-Id: <20160501.193626.1809188980792209492.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1604061729350.16827@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1604061729350.16827@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Rob Gardner <rob.gardner@oracle.com>
Date: Thu, 28 Apr 2016 16:54:29 -0600

> It's good to free up a few bytes here and there, but I think we're
> going to need to go further than this in the near future since code in
> this tiny region between 404000 and 0x408000 is going to grow.

We should simply monitor the situation and just make sure to minimize
the wastage in this region, moving code out of the area as needed.

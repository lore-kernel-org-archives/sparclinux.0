From: David Miller <davem@davemloft.net>
Date: Tue, 25 Oct 2016 17:06:12 +0000
Subject: Re: NMI watchdog: BUG: soft lockup
Message-Id: <20161025.130612.1887036473310407376.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <60822DF7-477D-433C-85AA-FE04D1D4B7B0@jrtc27.com>
In-Reply-To: <60822DF7-477D-433C-85AA-FE04D1D4B7B0@jrtc27.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: James Clarke <jrtc27@jrtc27.com>
Date: Tue, 25 Oct 2016 16:59:04 +0100

> Can we do a similar thing for the TLB by iterating over all its entries? Surely
> one of the ASIs lets you do that?

Yes, you can di it using diagnostic accesses.

But in my opinion for UltraSPARC-III/IV we should do an "all flush"
and for sun4v do a context 0 flush when the range is huge.

It's so much simpler, easier to audit and validate, and is probably
cheaper in the end.

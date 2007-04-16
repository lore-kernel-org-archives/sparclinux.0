From: David Miller <davem@davemloft.net>
Date: Mon, 16 Apr 2007 05:03:27 +0000
Subject: Re: [TESTERS NEEDED]: Rewritten ESP driver
Message-Id: <20070415.220327.59470306.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070412.233350.41640545.davem@davemloft.net>
In-Reply-To: <20070412.233350.41640545.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Adam Kropelin" <akropel1@rochester.rr.com>
Date: Sun, 15 Apr 2007 20:55:09 -0400

> Adam Kropelin wrote:
> > Adam Kropelin wrote:
> >> David Miller wrote:
> >>> Thanks in advance for testing.
> >>
> >> I've given the new driver a run on my U1. A bit of history before the
> >> results: 2.6.13 (aurora 2.0) esp driver works well on this machine.
> >> However, 2.6.20 stock does not: it dies with DMA errors after
> >> (correctly) identifying the disks. (I can get the exact errors, if
> >> they're useful.)
> >
> > I attempted to bisect the stock esp driver failure between 2.6.13 and
> > 2.6.20...and discovered that stock 2.6.13 doesn't work, either. The
> > aurora 2.6.13-1.1603sp13 kernel works perfectly every time. I'll try
> > 2.6.12 and also review the patches in aurora's 2.6.13.
> 
> 2.6.12 also fails, so apparently Spot waved a magic wand over the aurora 
> 2.6.13 kernel. I'll go look for esp-eye-of-newt.patch in the SRPM.

I would instead check for any interesting config or compiler options
given to the kernel build in the SRPM.

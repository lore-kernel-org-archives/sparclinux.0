From: David Miller <davem@davemloft.net>
Date: Tue, 27 Feb 2007 20:00:02 +0000
Subject: Re: Unaligned accesses in ip_rcv and ip_fast_csum
Message-Id: <20070227.120002.98863618.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070225200702.GA4451@droopy.oc.cox.net>
In-Reply-To: <20070225200702.GA4451@droopy.oc.cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Doug Nazar" <nazard@dragoninc.ca>
Date: Tue, 27 Feb 2007 14:43:23 -0500

> > We have a report (Debian bug #409313 [0]) of the following unaligned
> > accesses, occuring every 5-6 seconds on Netra X1 and SunFire v100 with
> > kernel 2.6.18 and newer:
> 
> A quick grep shows this issue is also in de2104x module in case somebody is
> using that.

I've forwarded both of your patches to the netdev lists and
Jeff Garzik, the network drivers maintainer.

Thanks.

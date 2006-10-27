From: David Miller <davem@davemloft.net>
Date: Fri, 27 Oct 2006 21:30:51 +0000
Subject: Re: Another 2.6.18 regression? (SunBlade1000)
Message-Id: <20061027.143051.45515738.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20061024031642.GA4403@droopy.oc.cox.net>
In-Reply-To: <20061024031642.GA4403@droopy.oc.cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Roland Stigge <stigge@antcom.de>
Date: Fri, 27 Oct 2006 22:20:34 +0200

> David Miller wrote:
> >> Roland later reported that the last working kernel for his box is 
> >> 2.6.16, and that the latest SunBlade 100/150 patch did not help with 
> >> his problem in any way.
> > 
> > See if disabling the floppy driver fixes the problem.
> 
> After removing the floppy driver, the result looks a bit different: The
> bootup proceeds a bit further, but the error message is similar.
> 
> See http://people.debian.org/~stigge/sun4u-nofd.jpg

What does 0x4268e8 match up to in your System.map?

From: Keith M Wesolowski <wesolows@foobazco.org>
Date: Wed, 14 Jul 2004 22:23:45 +0000
Subject: Re: sun4c driver/dma problems
Message-Id: <20040714222345.GA12558@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
References: <200406020818.13705.luckas@musoft.de>
In-Reply-To: <200406020818.13705.luckas@musoft.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Jul 13, 2004 at 11:39:00PM +0200, Uli Luckas wrote:

> > > So what can I do to help, getting this fixed? Who works on this code?
> > > I already know, it's not only the version detection. Defining a new
> > > version 70000000 "Revision 1 broken" and initialising it just as a
> > > "Revision 1" works around the above message, but all the device drivers
> > > report all kind of DMA related problems later on and of course don't
> > > work.

> As I have read, you are retiering from sparc32 kernel development. Is there 
> any hint that could get me going on fixing the above problems myself? Do you 
> have asumptions on where the problem can be found?

I do not know the cause of this problem.  However, it's entirely
possible it's just a detection issue.  You might consider grepping for
these messages in the source, then diffing between a working and
non-working kernel to see what's changed.  If it's not simple
detection, it may be related to the hypersparc DMA issue I've noted,
which has not been diagnosed.

-- 
Keith M Wesolowski

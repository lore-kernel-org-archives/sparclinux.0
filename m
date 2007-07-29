From: David Miller <davem@davemloft.net>
Date: Sun, 29 Jul 2007 09:09:07 +0000
Subject: Re: [PATCH] v2.6.23-rc1 Sparc32 Serial Port Selection error
Message-Id: <20070729.020907.36925670.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0707290259060.28781@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.61.0707290259060.28781@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Sun, 29 Jul 2007 09:42:00 +0100 (BST)

> 
> 
> On Sun, 29 Jul 2007, David Miller wrote:
> 
> > From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
> > Date: Sun, 29 Jul 2007 08:55:25 +0100 (BST)
> >
> >> Yes but then you do a !skip-- so 0 -> -1 and 1 -> 0
> >
> > Indeed.  This is coded in a very non-intuitive manner.  The code
> > selecting the string wants to use the original value of "skip", not
> > the one modified by the node traversal loop.
> >
> > Perhaps the following version of the fix is a little clearer.
> > What do you think?
> >
> 
> This also has the advantage that if any sparc32 systems have more than the 
> usual two serial console ports, they can be added in relativly easilly. I 
> think SBUS serial card I currently have in my SS1 can provide another four 
> serial ports for use as console ports, if I put it in the SS2 and write a 
> linux driver for it (I have the NetBSD driver source but have not got 
> around to porting it yet). The SS1 Prom has an issue with the FCode so the 
> extar ports are not available.

Great, I'll put this version of the patch in then.

I also remember seeing several problems with older OBP implementations
in the older sun4c's.  For example, they couldn't handle qe network
cards because they couldn't handle device hierarchies of SBUS devices
sitting underneath a SBUS device.

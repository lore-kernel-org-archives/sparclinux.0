From: christian@j-son.org
Date: Tue, 13 Jan 2004 20:52:47 +0000
Subject: Re: Status of Ross hyperSPARC on linux-2.4.x and linux-2.6.x?
Message-Id: <20040113215247.A1007@sparky.j-son.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040113204206.A988@sparky.j-son.org>
In-Reply-To: <20040113204206.A988@sparky.j-son.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Jan 13, 2004 at 09:06:41PM +0100, christian@j-son.org wrote:
> On Tue, Jan 13, 2004 at 08:42:06PM +0100, christian@j-son.org wrote:
> > Just a little ping for me (and anyone else).. what's the status of the
> > linux kernels 2.4 and 2.6 for running Ross' hyperSPARC processors?
> > 
> > This is what I have (running up to date Aurora SPARC Linux 1.0)
> > 
> > cpu		: ROSS HyperSparc RT625 or RT626
> > fpu		: ROSS HyperSparc combined IU/FPU
> > promlib		: Version 3 Revision 2
> > prom		: 2.25
> > type		: sun4m
> > ncpus probed	: 4
> > ncpus active	: 4
> > Cpu0Bogo	: 124.92
> > Cpu1Bogo	: 125.33
> > Cpu2Bogo	: 125.33
> > Cpu3Bogo	: 125.33
> > MMU type	: ROSS HyperSparc
> > contexts	: 4096
> > nocache total	: 5242880
> > nocache used	: 159232
> > CPU0		: online
> > CPU1		: online
> > CPU2		: online
> > CPU3		: online

and I got spin locks...

spin_lock (f0269000) CPU#3 stuck at f0020a34, owner PC(f007124c): CPU(0)
spin_lock (f01f83d0) CPU#2 stuck at f0024b7c, owner PC(f0024b7c): CPU(1)

if anyone care for additional info, pls let me know. this was on
Aurora SPARC Linux running spot's kernel-2.4.23-0.1sparc.src.rpm built
on my own SS20 system.

Cheers,

/ChJ

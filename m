From: David Miller <davem@davemloft.net>
Date: Tue, 20 Jan 2009 06:25:14 +0000
Subject: Re: Sunfire V880 and 480R 2.6.27.x startup hangs
Message-Id: <20090119.222514.261424510.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20081219085622.GA20721@lemon.iwr.uni-heidelberg.de>
In-Reply-To: <20081219085622.GA20721@lemon.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
Date: Fri, 19 Dec 2008 09:56:22 +0100

> On Wed, Dec 17, 2008 at 07:46:46PM -0800, David Miller wrote:
> > > tried 2.6.27.2 today, but this hangs already at loading the kernel.
> > > Output is attached. Please tell me what else I can provide.
> > 
> > Unfortunately, "-p" doesn't do anything any more and the kernel
> > is stopping or crashing during the part of the boot between
> > when the early prom console is disabled and the real console is
> > setup.
> > 
> > The way to debug this is to manually get rid of the CON_BOOT flag
> > in the early prom console structure, like the following patch.
> 
> Applied your patch to the 2.6.27.9 vanilla source and booted,
> console output up to the hang is below. Just to remember:
> 2.6.26.5 did not hang.
 ...
> [   50.390759] CPU 0: synchronized TICK with master CPU (last diff 0 cycles, maxerr 11 cycles)
> [   50.390776] Brought up 2 CPUs
> [   50.391634] net_namespace: 1552 bytes
> [   50.568542] NET: Registered protocol family 16
> 

The next thing that probably should run is the PCI controller
probe.  But I can't say that for certain, so we need more
info.

Please reboot this test kernel with the following added boot
command line options: initcall_debug=1 ignore_loglevel

Let us see the console log output that generates.

Thanks!

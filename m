From: David Miller <davem@davemloft.net>
Date: Mon, 07 May 2007 23:20:42 +0000
Subject: Re: [TESTING NEEDED] drivers/serial/sunzilog: Interrupt enable
Message-Id: <20070507.162042.38710851.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0704281529090.8157@mtfhpc.demon.co.uk>
	<20070428.210147.111207684.davem@davemloft.net>
	<Pine.LNX.4.61.0704292250290.1747@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.61.0704292250290.1747@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mark@mtfhpc.demon.co.uk
Cc: wli@holomorphy.com, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linux-serial@vger.kernel.org

From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Sun, 29 Apr 2007 23:00:29 +0100 (BST)

> I have altered the patch as advised and I have attached it to prevent my 
> email client from making a mess of it.
> 
> The attached patch changes the interrupt enable sequence for the sunzilog 
> driver so that interrupts are not enabled untill after the interrupt 
> handler has been installed. If this is not done, some SS1 and SS2 sun4c 
> systems panic on un-handled interrupt before the handler gets installed 
> preventing boot.
> 
> It also adds in support for the ESCC version of the zilog chips. The ESCC 
> detection works but the FIFO enable may cause issues with modem and 
> receive character status. My interpretation of the SCC manual and the code 
> is that it sould be OK.

Your patch looks good, thanks for working on this.  As other's
have mentioned you should provide a proper "Signed-off-by: "
line with your patch changelog as describe in
linux/Documentation/SubmittingPatches.

I wonder if there is a way to get rid of all of that MIE twiddling
logic during the probe.

The chicken-and-egg problem in this driver is that we need to get
all the chips mostly functional before we let the IRQ handler get
at the chips in the sunzilog_irq_chain.  That list is setup very
early, so it isn't a datastructure problem.

One thing we could do is check in the IRQ handler is skip chips
which don't have their registers mapped yet.

But that'd put silly logic in the fast path of this driver, whereas
your solution does all of this out-of-line.  So your patch is
probably the best.

Please resubmit with the proper "Signed-off-by: " line and I will
apply your patch, thanks!


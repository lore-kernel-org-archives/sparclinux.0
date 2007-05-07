From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Mon, 07 May 2007 19:27:11 +0000
Subject: Re: [TESTING NEEDED] drivers/serial/sunzilog: Interrupt enable before ISR handler installed
Message-Id: <20070507192711.GA27915@palantir8>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0704281529090.8157@mtfhpc.demon.co.uk> <20070428.210147.111207684.davem@davemloft.net> <Pine.LNX.4.61.0704292250290.1747@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.61.0704292250290.1747@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Cc: wli@holomorphy.com, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linux-serial@vger.kernel.org

Mark,

Gave this a spin on my SS20 today, have the console on the
serial port. No problems seen. You will need to provide a
signed-off-by line to get it accepted upstream, see 
Documentation/SubmittingPatches.

ffd60050: ttyS0 at MMIO 0xf1100000 (irq = 44) is a zs (ESCC)
Console: ttyS0 (SunZilog zs0)
ffd60050: ttyS1 at MMIO 0xf1100004 (irq = 44) is a zs (ESCC)
ffd60130: Keyboard at MMIO 0xf1000000 (irq = 44) is a zs
ffd60130: Mouse at MMIO 0xf1000004 (irq = 44) is a zs

Cheers,
Martin Habets

	Ack-by: Martin Habets <errandir_news@mph.eclipse.co.uk>

On Sun, Apr 29, 2007 at 11:00:29PM +0100, Mark Fortescue wrote:
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
> 
> ---
> 
> Regards
> 	Mark Fortescue.

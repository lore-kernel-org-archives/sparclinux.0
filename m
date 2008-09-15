From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Mon, 15 Sep 2008 14:26:06 +0000
Subject: Re: Allow 8250 to work on sparc.
Message-Id: <Pine.LNX.4.61.0809151507250.23201@mtfhpc.demon.co.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <20080912.211854.102505246.davem@davemloft.net>
In-Reply-To: <20080912.211854.102505246.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, joy@entuzijast.net

On Fri, 12 Sep 2008, David Miller wrote:
> Working on this and testing it also uncovered another portability bug.
> The uart_port structure uses an "unsigned int" for the "ioport" member,
> but even I/O ports in PCI devices are 64-bit on sparc64, so the high
> bits were being chopped off when 8250 PCI cards were tested.  The fix
> is to use "unsigned long" for this type and that's what the first patch
> does.
>

In the long term, should a generic serial port minor number allocater be 
used by all serial ports?

At the user level, there is no difference between a sun zilog serial port, 
an 8250 serial port or a USB serial port so these should be allocated 
using the same allocation system.

Would this not remove many of the issues of portability that the current 
structure apears to have built into it?

For me, it would also simplify the issue of trying to work what devive to 
look for when I plug in a new USB serial port device. It would be the new 
/dev/ttyS<x> to appear in /dev.

For serial ports with additional functionality (SDLC, HDLC etc.) a 
seperate IOCTL could be provided to indicate the presense of this 
extra functionality to programs that require it or a separate device 
major/minor could be allocated for this extra functionality (this may 
have some comatibility/maintanence benifits over an IOCTL).

Regards
 	Mark Fortescue.

From: William Lee Irwin III <wli@holomorphy.com>
Date: Mon, 14 Feb 2005 14:40:50 +0000
Subject: Re: sparc32 SMP for 2.6
Message-Id: <20050214144050.GT13009@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <420F070B.8010000@mc.net>
In-Reply-To: <420F070B.8010000@mc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Feb 13, 2005 at 01:51:39AM -0600, Bob Breuer wrote:
> I've been poking at the sparc32 SMP code and I have it to the point
> where it will run a minimal userland.  It is still far from being
> stable though.
> For reference, I started with the SMP patch [0] that wli sent to
> the list last July.  To go along with the attached SMP patch, it
> needs the spinlock fix [1] from Art Haas, and the attached
> DEBUGSPINLOCK patch from Tom Callaway.
> Here's a list of problems I have seen with it so far:
> - the scsi driver must be compiled in or it has problems.
> - when I compiled with gcc 3.3.4, it drops back to the prom with
>     a level 15 interrupt.
> - from a serial console, init hangs
> - /proc/interrupts shows 0 interrupts for the 2nd cpu
> - sun4d still needs fixing
> Testing with gcc 3.2.2 and 2 150 MHz HyperSPARCs, if I compile
> in scsi and leave out all of the networking, I am able to pass
> "init=/bin/bash" and get a shell everytime.
> I am sure there are still areas of bitrot and neglect that remain,
> so if anyone has any ideas, feel free to share them.

Between networking and serial it sounds as if this is a partial
explanation as to why I'm having trouble here.


-- wli

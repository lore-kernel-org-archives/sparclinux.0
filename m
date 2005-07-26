From: "David S. Miller" <davem@davemloft.net>
Date: Tue, 26 Jul 2005 23:46:39 +0000
Subject: Re: fd0 not found
Message-Id: <20050726.164639.44958702.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <42E61753.8050502@cpttm.org.mo>
In-Reply-To: <42E61753.8050502@cpttm.org.mo>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Kumba <kumba@gentoo.org>
Date: Tue, 26 Jul 2005 19:33:52 -0400

> The Floppy drive on Sun Blade 100 has never worked.  I might be off
> on this, but I believe it hangs off of an ISA bus built into the
> system (or some bus), and no one's ever invested the time to detect
> it.

It's not a matter of detection, it's working around the brain damaged
design of this thing.

The floppy device wants to do ISA DMA, but on the ISA bus it is
illegal for other agents to issue ISA I/O port operations while a DMA
is in progress.  The ISA bus has a signal that the processor is
supposed to use to determine when DMA is in progress and thus I/O port
operations cannot be initiated, but there is no hookup for this to the
UltraSPARC chip in the SB100.

Thus the only way to handle this is to make the current thread of
execution sleep if it tries to do an I/O port access while a floppy
DMA is in progress, and since we can't sleep in interrupt handler
context there is no way to implement this awefully gross workaround
for hardware mis-design.

Just get a USB memory stick if you want small portable storage.
The floppy device on the SB100 is unlikely to ever be supported.

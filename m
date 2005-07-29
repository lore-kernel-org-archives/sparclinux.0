From: Kumba <kumba@gentoo.org>
Date: Fri, 29 Jul 2005 02:16:28 +0000
Subject: Re: fd0 not found
Message-Id: <42E9917C.3080000@gentoo.org>
List-Id: <sparclinux.vger.kernel.org>
References: <42E61753.8050502@cpttm.org.mo>
In-Reply-To: <42E61753.8050502@cpttm.org.mo>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David S. Miller wrote:
> 
> It's not a matter of detection, it's working around the brain damaged
> design of this thing.
> 
> The floppy device wants to do ISA DMA, but on the ISA bus it is
> illegal for other agents to issue ISA I/O port operations while a DMA
> is in progress.  The ISA bus has a signal that the processor is
> supposed to use to determine when DMA is in progress and thus I/O port
> operations cannot be initiated, but there is no hookup for this to the
> UltraSPARC chip in the SB100.
> 
> Thus the only way to handle this is to make the current thread of
> execution sleep if it tries to do an I/O port access while a floppy
> DMA is in progress, and since we can't sleep in interrupt handler
> context there is no way to implement this awefully gross workaround
> for hardware mis-design.
> 
> Just get a USB memory stick if you want small portable storage.
> The floppy device on the SB100 is unlikely to ever be supported.

I don't suppose any of the kludges found in OpenSolaris code are portable into 
linux sources to address some of the design flaws/oddities? (Portable meaning 
license friendly, etc..)


--Kumba

-- 
Gentoo/MIPS Team Lead
Gentoo Foundation Board of Trustees

"Such is oft the course of deeds that move the wheels of the world: small hands 
do them because they must, while the eyes of the great are elsewhere."  --Elrond

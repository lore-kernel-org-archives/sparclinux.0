From: David Miller <davem@davemloft.net>
Date: Sun, 27 May 2007 00:04:14 +0000
Subject: Re: [RFT] [SPARC] Emulate cmpxchg like parisc
Message-Id: <20070526.170414.41896634.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070525201143.GB14171@fattire.cabal.ca>
In-Reply-To: <20070525201143.GB14171@fattire.cabal.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Kyle McMartin <kyle@parisc-linux.org>
Date: Sat, 26 May 2007 19:41:34 -0400

> I don't see what the problem is? If we can't do it in userspace, we fall
> back to a heavyweight ioctl lock. This sounds sensible to me.
> 
> On parisc we implement userspace CAS with a lightweight syscall on our
> gateway page, likely something like this could be implemented if someone
> cared on sparc32 as well using a VDSO.

Indeed, a special syscall scheme would work on sparc32 too, but very
inefficiently for the case that matters the most.

I don't want to have to take the syscall if the 32-bit app is running
on a sparc64 kernel which has the cmpxchg instructions.

Sure I could do vsyscall pages and all that, but it won't happen any
time soon and penalizing the existing 32-bit userspace by always
taking the system call just for this DRM thing is a non-starter.

What we have right now works for all the systems that actually have
DRM capable cards, and ever will have such cards.

Building DRM on sparc32 is really pointless, there is no graphics
card that will ever be plugged into a sparc32 PCI system that can
support DRM, ever.



From: David Miller <davem@davemloft.net>
Date: Sat, 26 May 2007 05:00:36 +0000
Subject: Re: [RFT] [SPARC] Emulate cmpxchg like parisc
Message-Id: <20070525.220036.74747933.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070525201143.GB14171@fattire.cabal.ca>
In-Reply-To: <20070525201143.GB14171@fattire.cabal.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Sat, 26 May 2007 01:24:40 +0100

> Hi Kyle,
> 
> After some minor fixes this builds, and the DRM drivers also
> build again. I cannot test this since I do not have a machine with
> PCI or these cards.
> Removed your name in the comment, as that went out of fashion after
> we started using proper versioning systems.
> 
> I've got a ppc->sparc32 compiler if that would help...

So how in the world is something like this going to "work" with DRM?
Userland cannot disable interrupts and it can't take the magic lock
the kernel uses to provide mutual exclusion for the emulated
cmpxchg().

All userland can do is not try to use the atomic operations and always
go into the kernel, which defeats the entire point of the cmpxchg().

Unless something %100 inside of the kernel will be the only consumers
of this, I'd recommend not adding it.  You can't let anything part of
a userland API try to make use of it, and DRM definitely falls into
that category.

Sparc 32-bit barely has PCI let alone 3D graphics cards.

If it's a build issue, simply disallow DRM to be turned on for
SPARC32.

Thanks.

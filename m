From: Kyle McMartin <kyle@parisc-linux.org>
Date: Sat, 26 May 2007 14:45:09 +0000
Subject: Re: [RFT] [SPARC] Emulate cmpxchg like parisc
Message-Id: <20070526144509.GA4043@fattire.cabal.ca>
List-Id: <sparclinux.vger.kernel.org>
References: <20070525201143.GB14171@fattire.cabal.ca>
In-Reply-To: <20070525201143.GB14171@fattire.cabal.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, May 25, 2007 at 10:00:36PM -0700, David Miller wrote:
> > After some minor fixes this builds, and the DRM drivers also
> > build again. I cannot test this since I do not have a machine with
> > PCI or these cards.
> > Removed your name in the comment, as that went out of fashion after
> > we started using proper versioning systems.
> > 
> > I've got a ppc->sparc32 compiler if that would help...
> 
> So how in the world is something like this going to "work" with DRM?
> Userland cannot disable interrupts and it can't take the magic lock
> the kernel uses to provide mutual exclusion for the emulated
> cmpxchg().
> 

Hi David,

My knowledge of the DRM is weak, but as I understand it, the only time
it is used is by the ioctl handlers, and not by userspace. I've added
Dave Airlie to the CC list, hopefully he can enlighten us as to where
else cmpxchg is used.

> Unless something %100 inside of the kernel will be the only consumers
> of this, I'd recommend not adding it.  You can't let anything part of
> a userland API try to make use of it, and DRM definitely falls into
> that category.
> 

istr there was a contentious thread on linux-arch about using cmpxchg in
generic code a while ago. So it's possible architectures with crappy
atomic support will need some kind of hack like this to even be able to
use generic code in the future.

> Sparc 32-bit barely has PCI let alone 3D graphics cards.
> 
> If it's a build issue, simply disallow DRM to be turned on for
> SPARC32.
> 
> Thanks.
> 

Cheers,
	Kyle

From: Kyle McMartin <kyle@parisc-linux.org>
Date: Sat, 26 May 2007 23:41:34 +0000
Subject: Re: [RFT] [SPARC] Emulate cmpxchg like parisc
Message-Id: <20070526234134.GA7358@fattire.cabal.ca>
List-Id: <sparclinux.vger.kernel.org>
References: <20070525201143.GB14171@fattire.cabal.ca>
In-Reply-To: <20070525201143.GB14171@fattire.cabal.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, May 26, 2007 at 04:00:56PM -0700, David Miller wrote:
> From: Dave Airlie <airlied@linux.ie>
> Date: Sat, 26 May 2007 21:32:10 +0100 (IST)
> 
> > the DRM can use cmpxchg in userspace, to implement DRM_CAS, have a look in 
> > drm git libdrm/xf86drm.h we appear to have a sparc implementation, this 
> > gives us fast userspace locking, however if an arch doesn't implement 
> > DRM_CAS we fallback to the heavyweight in-kernel lock,
> 
> That instruction only works on sparc64 cpus, which includes
> 32-bit apps running a system with sparc64 cpus.
> 
> That's why I hard-code the opcode in that asm statement of
> the DRM sources.
> 

I don't see what the problem is? If we can't do it in userspace, we fall
back to a heavyweight ioctl lock. This sounds sensible to me.

On parisc we implement userspace CAS with a lightweight syscall on our
gateway page, likely something like this could be implemented if someone
cared on sparc32 as well using a VDSO.

Cheers,
	Kyle

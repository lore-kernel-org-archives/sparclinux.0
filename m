From: Russell King - ARM Linux <linux@armlinux.org.uk>
Date: Fri, 13 Apr 2018 17:54:08 +0000
Subject: Re: sparc/ppc/arm compat siginfo ABI regressions: sending SIGFPE via kill() returns wrong values in 
Message-Id: <20180413175407.GO16141@n2100.armlinux.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <20180412110314.GA28070@altlinux.org>
 <20180412121949.GD16141@n2100.armlinux.org.uk>
 <20180412124928.GA29458@altlinux.org>
 <20180412131404.GE16141@n2100.armlinux.org.uk>
 <CA+55aFxdg2bYHtbKXb4mT5UuP2GH_qjkc=WeZY-RYHWZFQ2Gng@mail.gmail.com>
 <20180412172051.GK16141@n2100.armlinux.org.uk>
 <CA+55aFwjZqd8J0=veki1g+quQg8amEG4NnMe-h7HFksn=F=x_Q@mail.gmail.com>
 <20180413094211.GN16141@n2100.armlinux.org.uk>
 <CA+55aFwoThxqUeAZSsMhf--ODyhGkmOENH5R6=4+CuaopFx9eA@mail.gmail.com>
 <20180413170827.GB16308@e103592.cambridge.arm.com>
In-Reply-To: <20180413170827.GB16308@e103592.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Apr 13, 2018 at 06:08:28PM +0100, Dave Martin wrote:
> On Fri, Apr 13, 2018 at 09:33:17AM -0700, Linus Torvalds wrote:
> > On Fri, Apr 13, 2018 at 2:42 AM, Russell King - ARM Linux
> > <linux@armlinux.org.uk> wrote:
> > >
> > > Yes, it does solve the problem at hand with strace - the exact patch I
> > > tested against 4.16 is below.
> > 
> > Ok, good.
> > 
> > > However, FPE_FLTUNK is not defined in older kernels, so while we can
> > > fix it this way for the current merge window, that doesn't help 4.16.
> > 
> > I wonder if we should even bother with FPE_FLTUNK.
> > 
> > I suspect we might as well use FPE_FLTINV, I suspect, and not have
> > this complexity at all. That case is not worth worrying about, since
> > it's a "this shouldn't happen anyway" and the *real* reason will be in
> > the kernel logs due to vfs_panic().
> > 
> > So it's not like this is something that the user should ever care
> > about the si_code about.
> 
> Ack, my intended meaning for FPE_FLTUNK is that the fp exception is
> either spurious or we can't tell easily (or possibly at all) which
> FPE_XXX should be returned.  It's up to userspace to figure it out
> if it really cares.  Previously we were accidentally returning SI_USER
> in si_code for arm64.
> 
> This case on arm looks like a more serious error for which FPE_FLTINV
> may be more appropriate anyway.

No.  The cases where we get to this point are:

1. A trap concerning a coprocessor register transfer instruction (iow, move
   between a VFP register and ARM register.)
2. A trap concerning a coprocessor register load or save instruction.

(In both of these, "concerning" means that the VFP hardware provides
such an instruction as the reason for the fault, *not* that it is the
faulting instruction.)

3. A combination of the exception bits (EX and DEX) on certain VFP
   implementations.

All of these can be summarised as "the hardware went wrong in some way"
rather than "the user program did something wrong."

FPE_FLTINV means "floating point invalid operation".  Does it really
cover the case where hardware has failed, or is it intended to cover
the case where userspace did something wrong and asked for an invalid
operation from the FP hardware?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up

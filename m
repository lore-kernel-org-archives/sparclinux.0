From: Dave Martin <Dave.Martin@arm.com>
Date: Fri, 13 Apr 2018 18:35:38 +0000
Subject: Re: sparc/ppc/arm compat siginfo ABI regressions: sending SIGFPE via kill() returns wrong values in 
Message-Id: <20180413183527.GC16308@e103592.cambridge.arm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20180412121949.GD16141@n2100.armlinux.org.uk>
 <20180412124928.GA29458@altlinux.org>
 <20180412131404.GE16141@n2100.armlinux.org.uk>
 <CA+55aFxdg2bYHtbKXb4mT5UuP2GH_qjkc=WeZY-RYHWZFQ2Gng@mail.gmail.com>
 <20180412172051.GK16141@n2100.armlinux.org.uk>
 <CA+55aFwjZqd8J0=veki1g+quQg8amEG4NnMe-h7HFksn=F=x_Q@mail.gmail.com>
 <20180413094211.GN16141@n2100.armlinux.org.uk>
 <CA+55aFwoThxqUeAZSsMhf--ODyhGkmOENH5R6=4+CuaopFx9eA@mail.gmail.com>
 <20180413170827.GB16308@e103592.cambridge.arm.com>
 <20180413175407.GO16141@n2100.armlinux.org.uk>
In-Reply-To: <20180413175407.GO16141@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Apr 13, 2018 at 06:54:08PM +0100, Russell King - ARM Linux wrote:
> On Fri, Apr 13, 2018 at 06:08:28PM +0100, Dave Martin wrote:
> > On Fri, Apr 13, 2018 at 09:33:17AM -0700, Linus Torvalds wrote:
> > > On Fri, Apr 13, 2018 at 2:42 AM, Russell King - ARM Linux
> > > <linux@armlinux.org.uk> wrote:
> > > >
> > > > Yes, it does solve the problem at hand with strace - the exact patch I
> > > > tested against 4.16 is below.
> > > 
> > > Ok, good.
> > > 
> > > > However, FPE_FLTUNK is not defined in older kernels, so while we can
> > > > fix it this way for the current merge window, that doesn't help 4.16.
> > > 
> > > I wonder if we should even bother with FPE_FLTUNK.
> > > 
> > > I suspect we might as well use FPE_FLTINV, I suspect, and not have
> > > this complexity at all. That case is not worth worrying about, since
> > > it's a "this shouldn't happen anyway" and the *real* reason will be in
> > > the kernel logs due to vfs_panic().
> > > 
> > > So it's not like this is something that the user should ever care
> > > about the si_code about.
> > 
> > Ack, my intended meaning for FPE_FLTUNK is that the fp exception is
> > either spurious or we can't tell easily (or possibly at all) which
> > FPE_XXX should be returned.  It's up to userspace to figure it out
> > if it really cares.  Previously we were accidentally returning SI_USER
> > in si_code for arm64.
> > 
> > This case on arm looks like a more serious error for which FPE_FLTINV
> > may be more appropriate anyway.
> 
> No.  The cases where we get to this point are:
> 
> 1. A trap concerning a coprocessor register transfer instruction (iow, move
>    between a VFP register and ARM register.)
> 2. A trap concerning a coprocessor register load or save instruction.
> 
> (In both of these, "concerning" means that the VFP hardware provides
> such an instruction as the reason for the fault, *not* that it is the
> faulting instruction.)
> 
> 3. A combination of the exception bits (EX and DEX) on certain VFP
>    implementations.
> 
> All of these can be summarised as "the hardware went wrong in some way"
> rather than "the user program did something wrong."

Although my understanding of VFP bounces is a bit hazy, I think this is
broadly in line with my assumptions.

> FPE_FLTINV means "floating point invalid operation".  Does it really
> cover the case where hardware has failed, or is it intended to cover
> the case where userspace did something wrong and asked for an invalid
> operation from the FP hardware?

So, there's an argument that FPE_FLTINV is not really correct.  My
rationale was that there is nothing correct that we can return, and
FPE_FLTINV may be no worse than the alternatives.

If we can only hit this case as the result of a hardware failure
or kernel bug though, should this be delivered as SIGKILL instead?

That's the approach I eventually followed for various exceptions
on arm64 that were theoretically delivered to userspace with si_code=0,
but really should be impossible unless and kernel and/or hardware
is buggy.

If that's the case though, I don't see how a userspace testsuite is
hitting this code path.  Maybe I've misunderstood the context of this
thread.

Cheers
---Dave

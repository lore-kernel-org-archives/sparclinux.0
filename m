From: Thomas Gleixner <tglx@linutronix.de>
Date: Fri, 21 Mar 2008 13:50:01 +0000
Subject: Re: [PATCH 6/8] ptrace: arch_ptrace -ENOSYS return
Message-Id: <alpine.LFD.1.00.0803211441180.3781@apollo.tec.linutronix.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20080319211714.8B14226F995@magilla.localdomain> <20080319212024.EA03126F995@magilla.localdomain> <alpine.LFD.1.00.0803191935080.3020@woody.linux-foundation.org> <20080320081658.0B23826F995@magilla.localdomain>
In-Reply-To: <20080320081658.0B23826F995-nL1rrgvulkcB9AHHLWeGtNQXobZC6xk2@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Roland McGrath <roland-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>, David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, Richard Henderson <rth-hL46jP5Bxq7R7s880joybQ@public.gmane.org>, tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Thu, 20 Mar 2008, Roland McGrath wrote:
> > Wouldn't it be nicer to just let "arch_ptrace()" return a flag saying 
> > whether it handled things or not?
> 
> It would certainly be nicer.  I would prefer:
> 
> extern int arch_ptrace(struct task_struct *child, long request,
>        	    	       long addr, long data, long *retval);
> 
> where it returns an error code or it returns 0 and *retval is the value
> or it returns 1 and it didn't do anything.
>
> So this ugliness seemed like a better bet than waiting for 20 more
> arch sign-offs before any of it could go in.  You are certainly in a
> position to just change the generic signature and make every arch do
> the update (or fix your typos if you just tweak them all blind), and
> let them grumble.  I did not presume to do so.

What about adding a CONFIG_ARCH_HAS_PTRACE2, which is set by the archs
which are converted. For those which are not you add a fallback
implementation:

#ifndef CONFIG_ARCH_HAS_PTRACE2
static int arch_ptrace2(whatever your favourite interface)
{
	ret = arch_ptrace();
	return do_ugly_fixups(ret);
}
#endif

That way you introduce the new interface and convert one or two archs
initialy without breaking the other 22.

At the same time you mark arch_ptrace() deprecated so it will get the
attention of the arch maintainers pretty fast. Once all archs are
converted we can remove the config flag and the fallback quirk.

Thanks,
	tglx

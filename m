From: Russell King - ARM Linux <linux@armlinux.org.uk>
Date: Fri, 13 Apr 2018 18:50:17 +0000
Subject: Re: sparc/ppc/arm compat siginfo ABI regressions: sending SIGFPE via kill() returns wrong values in 
Message-Id: <20180413185016.GP16141@n2100.armlinux.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <20180412124928.GA29458@altlinux.org>
 <20180412131404.GE16141@n2100.armlinux.org.uk>
 <CA+55aFxdg2bYHtbKXb4mT5UuP2GH_qjkc=WeZY-RYHWZFQ2Gng@mail.gmail.com>
 <20180412172051.GK16141@n2100.armlinux.org.uk>
 <CA+55aFwjZqd8J0=veki1g+quQg8amEG4NnMe-h7HFksn=F=x_Q@mail.gmail.com>
 <20180413094211.GN16141@n2100.armlinux.org.uk>
 <CA+55aFwoThxqUeAZSsMhf--ODyhGkmOENH5R6=4+CuaopFx9eA@mail.gmail.com>
 <20180413170827.GB16308@e103592.cambridge.arm.com>
 <20180413175407.GO16141@n2100.armlinux.org.uk>
 <20180413183527.GC16308@e103592.cambridge.arm.com>
In-Reply-To: <20180413183527.GC16308@e103592.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Apr 13, 2018 at 07:35:38PM +0100, Dave Martin wrote:
> If that's the case though, I don't see how a userspace testsuite is
> hitting this code path.  Maybe I've misunderstood the context of this
> thread.

It isn't hitting this exact case.

The userspace testsuite is hitting an entirely different case:

	kill(getpid(), SIGFPE);

As one expects, this generates a SIGFPE to the current process, which
then inspects the siginfo structure.  Being a userspace generated
signal, si_code is set to SI_USER, which has the value 0.

With FPE_FIXME defined to zero, as Eric has done:

enum siginfo_layout siginfo_layout(int sig, int si_code)
{
        enum siginfo_layout layout = SIL_KILL;
        if ((si_code > SI_USER) && (si_code < SI_KERNEL)) {
...
        } else {
...
#ifdef FPE_FIXME
                if ((sig = SIGFPE) && (si_code = FPE_FIXME))
                        layout = SIL_FAULT;
#endif
        }
        return layout;
}

This causes siginfo_layout() to return SIL_FAULT for this userspace
generated signal, rather than the correct SIL_KILL.

This affects which fields we copy to userspace.

SI_USER is defined to pass si_pid and si_uid to the userspace process,
which on ARM are the first two consecutive 32-bit quantities in the
union, which is done when siginfo_layout() returns SIL_KILL.  However,
when SIL_FAULT is returned, we only copy si_addr in the union, which
on ARM is just one 32-bit quantity.

Consequently, userspace sees a correct value for si_pid, and si_uid
remains set to whatever was there in userspace.  In the case of the
strace program, that's zero.  This means if you run the strace
testsuite as root, the problem doesn't appear, but if you run it as
a non-root user, it will.

So, the testsuite case has little to do with the behaviour of the VFP
handling - it's to do with the behaviour of the kernel's signal handling.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up

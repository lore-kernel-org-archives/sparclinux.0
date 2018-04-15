From: Russell King - ARM Linux <linux@armlinux.org.uk>
Date: Sun, 15 Apr 2018 13:12:06 +0000
Subject: Re: sparc/ppc/arm compat siginfo ABI regressions: sending SIGFPE via kill() returns wrong values in 
Message-Id: <20180415131206.GR16141@n2100.armlinux.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <CA+55aFxdg2bYHtbKXb4mT5UuP2GH_qjkc=WeZY-RYHWZFQ2Gng@mail.gmail.com>
 <20180412172051.GK16141@n2100.armlinux.org.uk>
 <CA+55aFwjZqd8J0=veki1g+quQg8amEG4NnMe-h7HFksn=F=x_Q@mail.gmail.com>
 <20180413094211.GN16141@n2100.armlinux.org.uk>
 <CA+55aFwoThxqUeAZSsMhf--ODyhGkmOENH5R6=4+CuaopFx9eA@mail.gmail.com>
 <20180413170827.GB16308@e103592.cambridge.arm.com>
 <20180413175407.GO16141@n2100.armlinux.org.uk>
 <CA+55aFyya6B9_aq8ZSrZT-S-BGbpbDgFvDff5z8upDirpcoiHA@mail.gmail.com>
 <20180413184522.GD16308@e103592.cambridge.arm.com>
 <CA+55aFwMUQbALx60b3JDrTcWVSBS7imS+zCYEMz8NOs=6rE6+A@mail.gmail.com>
In-Reply-To: <CA+55aFwMUQbALx60b3JDrTcWVSBS7imS+zCYEMz8NOs=6rE6+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Apr 13, 2018 at 12:53:49PM -0700, Linus Torvalds wrote:
> On Fri, Apr 13, 2018 at 11:45 AM, Dave Martin <Dave.Martin@arm.com> wrote:
> >
> > Most uses I've seen do nothing more than use the FPE_xyz value to
> > format diagnostic messages while dying.  I struggled to find code that
> > made a meaningful functional decision based on the value, though that's
> > not proof...
> 
> Yeah. I've seen code that cares about SIGFPE deeply, but it's almost
> invariably about some emulated environment (eg Java VM, or CPU
> emulation).
> 
> And the siginfo data is basically never good enough for those
> environments anyway on its own, so they will go and look at the actual
> instruction that caused the fault and the register state instead,
> because they need *all* the information.
> 
> The cases that use si_code are the ones that just trapped signals in
> order to give a more helpful abort message.
> 
> So I could certainly imagine that si_code is actually used by somebody
> who then decides to actuall act differently on it, but aside from
> perhaps printing out a different message, it sounds far-fetched.

Okay, in that case let's just use FPE_FLTINV.  That makes the patch
easily back-portable for stable kernels.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up

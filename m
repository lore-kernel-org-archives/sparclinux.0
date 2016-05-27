From: David Miller <davem@davemloft.net>
Date: Fri, 27 May 2016 22:51:37 +0000
Subject: Re: [4.1.x -- 4.6.x and probably HEAD] Reproducible unprivileged panic/TLB BUG on sparc via a stack-
Message-Id: <20160527.155137.1489438133864702237.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <87twhj3ag0.fsf@esperi.org.uk>
	<20160527.123731.2105286005500436503.davem@davemloft.net>
	<8760tz2n1j.fsf@esperi.org.uk>
In-Reply-To: <8760tz2n1j.fsf@esperi.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: nix@esperi.org.uk
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, fweimer@redhat.com

From: Nick Alcock <nix@esperi.org.uk>
Date: Fri, 27 May 2016 22:44:56 +0100

> Good move. Segfaulting the process is fine! :) Any process that does
> this sort of thing is clearly either terminally buggy, written by an
> idiot who doesn't know what he's doing (i.e. my original patch) or
> malicious. These all deserve SEGVs.
> 
> (I still don't understand why this leads to spurious TLB faults, though.
> Filling the userland CPU registers with garbage is bad, but should still
> be reasonably harmless to the kernel, surely?)

I'm trying to figure out the same thing myself.

Even the unaligned stack pointer should be gracefully handled by the
kernel, so I think it has to be some other element of the register
state restore sequence.

The one area that deserves auditing is %tstate.  This is a privileged
register which we treat partially as non-privileged.  Specifically we
allow the user to modify the condition codes and the %asi register
which is encoded into here.

But I just went over that a few times.  We are really careful to mask
and only change those specific fields.

I'll keep plugging away at this and also play with your patches to
reproduce the bug.

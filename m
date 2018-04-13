From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 13 Apr 2018 18:23:36 +0000
Subject: Re: sparc/ppc/arm compat siginfo ABI regressions: sending SIGFPE via kill() returns wrong values in 
Message-Id: <CA+55aFyya6B9_aq8ZSrZT-S-BGbpbDgFvDff5z8upDirpcoiHA@mail.gmail.com>
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
 <20180413175407.GO16141@n2100.armlinux.org.uk>
In-Reply-To: <20180413175407.GO16141@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Apr 13, 2018 at 10:54 AM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
>
> FPE_FLTINV means "floating point invalid operation".  Does it really
> cover the case where hardware has failed, or is it intended to cover
> the case where userspace did something wrong and asked for an invalid
> operation from the FP hardware?

Note that the number of people who actually look at the si_code is
approximately zero.

But the ones that _do_ check the si_code are certainly not going to
check it against a new code that they don't know about.

I suspect that if you start searching for FLT_xyz occurrences in code,
approximately 100% of them are from the kernel code that generates
them, not from any actual users.

So I'd be very surprised if you can find *anybody* who cares about
that exact value (with the possible exceptions of test-suites).

Sadly, google code-search is no more. It was useful for things like that.

                Linus

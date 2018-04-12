From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 12 Apr 2018 17:22:15 +0000
Subject: Re: sparc/ppc/arm compat siginfo ABI regressions: sending SIGFPE via kill() returns wrong values in 
Message-Id: <CA+55aFwjZqd8J0=veki1g+quQg8amEG4NnMe-h7HFksn=F=x_Q@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20180409152253.GD10489@altlinux.org>
 <20180412013435.GA21219@altlinux.org>
 <20180412095811.GC16141@n2100.armlinux.org.uk>
 <20180412110314.GA28070@altlinux.org>
 <20180412121949.GD16141@n2100.armlinux.org.uk>
 <20180412124928.GA29458@altlinux.org>
 <20180412131404.GE16141@n2100.armlinux.org.uk>
 <CA+55aFxdg2bYHtbKXb4mT5UuP2GH_qjkc=WeZY-RYHWZFQ2Gng@mail.gmail.com>
 <20180412172051.GK16141@n2100.armlinux.org.uk>
In-Reply-To: <20180412172051.GK16141@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Apr 12, 2018 at 10:20 AM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
>
> This file was created to contain FPE_FIXME, by the "signal/arm: Document
> conflicts with SI_USER and SIGFPE" commit so if we're removing it, it
> would be better to remove the whole file.

Fair enough. I'm not going to commit that anyway since I can't test
it, but yes, if it tests ok that sounds like the right thing to do.

                   Linus

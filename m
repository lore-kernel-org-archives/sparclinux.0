From: Thomas Gleixner <tglx@linutronix.de>
Date: Sat, 22 Mar 2014 22:03:49 +0000
Subject: Re: [RESEND][PATCH 1/2] lib/scatterlist: Make ARCH_HAS_SG_CHAIN an actual Kconfig
Message-Id: <alpine.DEB.2.02.1403222302510.18573@ionos.tec.linutronix.de>
List-Id: <sparclinux.vger.kernel.org>
References: <1395512032-20575-1-git-send-email-lauraa@codeaurora.org>
 <1395512032-20575-2-git-send-email-lauraa@codeaurora.org>
 <1395523881.2143.58.camel@dabdike.int.hansenpartnership.com>
In-Reply-To: <1395523881.2143.58.camel@dabdike.int.hansenpartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Sat, 22 Mar 2014, James Bottomley wrote:

> On Sat, 2014-03-22 at 11:13 -0700, Laura Abbott wrote:
> > Rather than have architectures #define ARCH_HAS_SG_CHAIN in an architecture
> > specific scatterlist.h, make it a proper Kconfig option and use that
> > instead. At same time, remove the header files are are now mostly
> > useless and just include asm-generic/scatterlist.h.
> 
> Well, the transformation looks fine.  Perhaps part of the reason for the
> lack of response is that there's no compelling reason in the change log
> above for doing this.  The usual reason for eliminating ARCH_HAS is that
> it's hiding something that would be better expressed a different way
> (that's actually intuitive to grep) or that it's expressing something
> that should be configurable.  Neither of these reasons apply in this
> case, because SG_CHAIN definitely is a property of the architecture not
> the config space and it's not really hiding anything.

Getting rid of pointless copied code is definitely a good enough
reason and the patch removes quite some of that.
 
Thanks,

	tglx

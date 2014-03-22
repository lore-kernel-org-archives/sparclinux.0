From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Sat, 22 Mar 2014 22:23:06 +0000
Subject: Re: [RESEND][PATCH 1/2] lib/scatterlist: Make ARCH_HAS_SG_CHAIN an actual Kconfig
Message-Id: <20140322222306.GM7528@n2100.arm.linux.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <1395512032-20575-1-git-send-email-lauraa@codeaurora.org>
 <1395512032-20575-2-git-send-email-lauraa@codeaurora.org>
 <1395523881.2143.58.camel@dabdike.int.hansenpartnership.com>
In-Reply-To: <1395523881.2143.58.camel@dabdike.int.hansenpartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Sat, Mar 22, 2014 at 02:31:21PM -0700, James Bottomley wrote:
> Perhaps now might be the time to ask which are the remaining
> architectures that cannot do SG chaining and then we can fix them and
> pull the whole thing out.

Not quite.  You're making the assumption that we can be sure that all
the scatterlist users on an architecture have been converted - that's
simply not true on ARM.  We have some which have, and some which still
have not been audited.

The cases that get us here would be old platform DMA code which walks
scatterlists handed to it from drivers - stuff like
arch/arm/mach-rpc/dma.c (which probably can cope), and drivers/scsi/arm/*
(which definitely can't because of their SCSI pointers save/restore
handling message.)  I know that's one case where SG_CHAIN definitely
isn't supported on ARM.

So, we had decided not to enable it, but this means that new stuff
isn't benefitting from this.  I've recently asked arm-soc to enable
it for the modern multi-platform builds, because modern stuff really
be written with correct SG chaining in mind.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.

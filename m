From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 07 May 2014 05:20:44 +0000
Subject: Re: [PATCH 02/34] sparc32: fix remaining sparse warnings in iommu.c + io-unit.c
Message-Id: <20140507052044.GA17994@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1399157559-19901-2-git-send-email-sam@ravnborg.org>
In-Reply-To: <1399157559-19901-2-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, May 07, 2014 at 12:42:20AM -0400, David Miller wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Sun,  4 May 2014 00:52:07 +0200
> 
> > +	control = sbus_readl(&iommu->regs->control);
> > +	impl = (control & IOMMU_CTRL_IMPL) >> 28;
> > +	vers = (control & IOMMU_CTRL_VERS) >> 24;
> > +	control &= ~(IOMMU_CTRL_RNGE);
> > +	control |= (IOMMU_RNGE_256MB | IOMMU_CTRL_ENAB);
> > +	sbus_writel(control, iommu->regs);
> 
> The register address in the sbus_writel() is wrong, it should
> be "&iommu->regs->control" not "iommu->regs".
Very good spot.
This I should have found myself :-(

> 
> Please audit your entire patch set of bugs of this nature, going from
> raw pointer derefs to I/O accessors is an extremely error prone
> transformation unless done with something automated like a semantic
> patching tool.
I will do so.

	Sam


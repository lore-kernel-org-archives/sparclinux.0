From: David Miller <davem@davemloft.net>
Date: Wed, 07 May 2014 04:42:20 +0000
Subject: Re: [PATCH 02/34] sparc32: fix remaining sparse warnings in iommu.c + io-unit.c
Message-Id: <20140507.004220.732393506055261055.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1399157559-19901-2-git-send-email-sam@ravnborg.org>
In-Reply-To: <1399157559-19901-2-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun,  4 May 2014 00:52:07 +0200

> +	control = sbus_readl(&iommu->regs->control);
> +	impl = (control & IOMMU_CTRL_IMPL) >> 28;
> +	vers = (control & IOMMU_CTRL_VERS) >> 24;
> +	control &= ~(IOMMU_CTRL_RNGE);
> +	control |= (IOMMU_RNGE_256MB | IOMMU_CTRL_ENAB);
> +	sbus_writel(control, iommu->regs);

The register address in the sbus_writel() is wrong, it should
be "&iommu->regs->control" not "iommu->regs".

Please audit your entire patch set of bugs of this nature, going from
raw pointer derefs to I/O accessors is an extremely error prone
transformation unless done with something automated like a semantic
patching tool.

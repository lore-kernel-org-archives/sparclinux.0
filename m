From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 02 Mar 2010 13:38:31 +0000
Subject: Re: [PATCH] sparc: use asm-generic/scatterlist.h
Message-Id: <201003021438.32144.arnd@arndb.de>
List-Id: <sparclinux.vger.kernel.org>
References: <201003011229.51399.arnd@arndb.de> <201003021303.26064.arnd@arndb.de> <20100302212513N.fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <20100302212513N.fujita.tomonori@lab.ntt.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: davem@davemloft.net, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday 02 March 2010, FUJITA Tomonori wrote:
> Yeah, but IIRC, Alpha, x86_64 GART, parisc, and IA64 don't have
> CONFIG_ option for IOMMU virtual merging. I prefer to avoid to adding
> something like CONFIG_HAVE_IOMMU_VMERGE for them. If we add
> CONFIG_HAVE_IOMMU_VMERGE to them, it's a bit strange not to add the
> feature to disable virtual merging for them (I guess GART already has
> the feature though).

While I think the runtime feature (actually a workaround for broken device
drivers) should be consistently used on all architectures, or removed
entirely, it's orthogonal to this discussion. I'm sure you'll come
up with a reasonable name for a new option if you introduce one.
CONFIG_HAVE_IOMMU_VMERGE and CONFIG_NEED_SG_DMA_LENGTH both seem ok
to me.

> Actually, I want to use dma_length on all the architectures (if nobody
> complains).

Fine with me as well. It wastes a small amount of memory but makes
the code more consistent.

	Arnd

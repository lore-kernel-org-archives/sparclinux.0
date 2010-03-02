From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Date: Tue, 02 Mar 2010 13:49:20 +0000
Subject: Re: [PATCH] sparc: use asm-generic/scatterlist.h
Message-Id: <20100302224858G.fujita.tomonori@lab.ntt.co.jp>
List-Id: <sparclinux.vger.kernel.org>
References: <201003021303.26064.arnd@arndb.de>
	<20100302212513N.fujita.tomonori@lab.ntt.co.jp>
	<201003021438.32144.arnd@arndb.de>
In-Reply-To: <201003021438.32144.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: arnd@arndb.de
Cc: fujita.tomonori@lab.ntt.co.jp, davem@davemloft.net, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 2 Mar 2010 14:38:31 +0100
Arnd Bergmann <arnd@arndb.de> wrote:

> On Tuesday 02 March 2010, FUJITA Tomonori wrote:
> > Yeah, but IIRC, Alpha, x86_64 GART, parisc, and IA64 don't have
> > CONFIG_ option for IOMMU virtual merging. I prefer to avoid to adding
> > something like CONFIG_HAVE_IOMMU_VMERGE for them. If we add
> > CONFIG_HAVE_IOMMU_VMERGE to them, it's a bit strange not to add the
> > feature to disable virtual merging for them (I guess GART already has
> > the feature though).
> 
> While I think the runtime feature (actually a workaround for broken device
> drivers)

What does "broken device drivers" mean here?

> should be consistently used on all architectures, or removed
> entirely, it's orthogonal to this discussion.

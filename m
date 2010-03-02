From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 02 Mar 2010 13:54:11 +0000
Subject: Re: [PATCH] sparc: use asm-generic/scatterlist.h
Message-Id: <201003021454.12125.arnd@arndb.de>
List-Id: <sparclinux.vger.kernel.org>
References: <201003021303.26064.arnd@arndb.de> <201003021438.32144.arnd@arndb.de> <20100302224858G.fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <20100302224858G.fujita.tomonori@lab.ntt.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: davem@davemloft.net, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday 02 March 2010, FUJITA Tomonori wrote:
> On Tue, 2 Mar 2010 14:38:31 +0100
> Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > On Tuesday 02 March 2010, FUJITA Tomonori wrote:
> > > Yeah, but IIRC, Alpha, x86_64 GART, parisc, and IA64 don't have
> > > CONFIG_ option for IOMMU virtual merging. I prefer to avoid to adding
> > > something like CONFIG_HAVE_IOMMU_VMERGE for them. If we add
> > > CONFIG_HAVE_IOMMU_VMERGE to them, it's a bit strange not to add the
> > > feature to disable virtual merging for them (I guess GART already has
> > > the feature though).
> > 
> > While I think the runtime feature (actually a workaround for broken device
> > drivers)
> 
> What does "broken device drivers" mean here?

Broken in the sense that arch/powerpc/Kconfig describes CONFIG_IOMMU_VMERGE:

       Cause IO segments sent to a device for DMA to be merged virtually
       by the IOMMU when they happen to have been allocated contiguously.
       This doesn't add pressure to the IOMMU allocator. However, some
       drivers don't support getting large merged segments coming back
       from *_map_sg().

       Most drivers don't have this problem; it is safe to say Y here.

I don't know if this comment still applies to any drivers in the mainline
kernel, but it's possible.

	Arnd

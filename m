From: David Miller <davem@davemloft.net>
Date: Tue, 02 Mar 2010 13:55:34 +0000
Subject: Re: [PATCH] sparc: use asm-generic/scatterlist.h
Message-Id: <20100302.055534.115500087.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <201003021438.32144.arnd@arndb.de>
	<20100302224858G.fujita.tomonori@lab.ntt.co.jp>
	<201003021454.12125.arnd@arndb.de>
In-Reply-To: <201003021454.12125.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: arnd@arndb.de
Cc: fujita.tomonori@lab.ntt.co.jp, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 2 Mar 2010 14:54:11 +0100

> Broken in the sense that arch/powerpc/Kconfig describes CONFIG_IOMMU_VMERGE:
> 
>        Cause IO segments sent to a device for DMA to be merged virtually
>        by the IOMMU when they happen to have been allocated contiguously.
>        This doesn't add pressure to the IOMMU allocator. However, some
>        drivers don't support getting large merged segments coming back
>        from *_map_sg().
> 
>        Most drivers don't have this problem; it is safe to say Y here.
> 
> I don't know if this comment still applies to any drivers in the mainline
> kernel, but it's possible.

That really has to be out of date these days.

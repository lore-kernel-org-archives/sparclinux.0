From: Christoph Hellwig <hch@lst.de>
Date: Tue, 24 Apr 2018 08:20:23 +0000
Subject: Re: [PATCH 22/22] parisc: use generic dma_noncoherent_ops
Message-Id: <20180424082023.GA19725@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20180420080313.18796-1-hch@lst.de> <20180420080313.18796-23-hch@lst.de> <1524346967.3335.9.camel@HansenPartnership.com>
In-Reply-To: <1524346967.3335.9.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org

On Sat, Apr 21, 2018 at 10:42:47PM +0100, James Bottomley wrote:
> Well, this is wrong: you just made every 32 bit parisc system
> unnecessarily use non-coherent.  We actually only have a small small
> set of non-coherent systems.  The pxcs and pcxt systems (which are
> about 99% of the user base) can use coherent dma ops.  The problem
> seems to be in your new world you only have one dma_noncoherent_ops
> pointer ... we definitely need two on parisc, so whether
> arch_dma_cache_sync is present or not needs to be dynamic not config
> defined.

The changelog explicitly mentions merging the two noncoherent
implementations, they only differ in the alloc and free callsbacks,
and we now runtime switch between them.  Before the pcxs and pcxt
cases used pcx_dma_ops, and pcxl and pxcl2 used pcxl_dma_ops, now
all four use dma_noncoherent_ops and arch_dma_alloc/arch_dma_free
branch out to different behavior.

Both pcx_dma_ops and pcxl_dma_ops do define the cache_sync
method in the existing code, so that isn't the issue.

I'll take a deeper look at what sort of behavior change might have
been introduced.

> 
> James
---end quoted text---

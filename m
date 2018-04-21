From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Sat, 21 Apr 2018 21:52:17 +0000
Subject: Re: [PATCH 22/22] parisc: use generic dma_noncoherent_ops
Message-Id: <1524347537.3335.12.camel@HansenPartnership.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20180420080313.18796-1-hch@lst.de>
         <20180420080313.18796-23-hch@lst.de>
         <e0b4f3be-68b9-c3af-e432-fd20419e2d70@gmx.de>
In-Reply-To: <e0b4f3be-68b9-c3af-e432-fd20419e2d70@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Helge Deller <deller@gmx.de>, Christoph Hellwig <hch@lst.de>
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, 2018-04-21 at 19:43 +0200, Helge Deller wrote:
> On 20.04.2018 10:03, Christoph Hellwig wrote:
> > Switch to the generic noncoherent direct mapping implementation.
> > 
> > Parisc previously had two different non-coherent dma ops
> > implementation that just different in the way coherent allocations
> > were handled or not handled.  The different behavior is not
> > selected at runtime in the arch_dma_alloc and arch_dma_free
> > routines.  The non-coherent allocation in the pcx cases now uses
> > the dma_direct helpers that are a little more sophisticated and
> > used by a lot of other architectures.
> > 
> > Fix sync_single_for_cpu to do skip the cache flush unless the
> > transfer is to the device to match the more tested unmap_single
> > path which should have the same cache coherency implications.
> > 
> > This also now consistenly uses flush_kernel_dcache_range for cache
> > flushing while previously some of the SG based operations used
> > flush_kernel_vmap_range instead.
> 
> 
> This patch breaks a 32bit kernel on a B160L machine (PA7300LC CPU,
> "pcxl2"). After applying this patch series the lasi82956 network
> driver works unreliable.  NIC gets IP, but ping doesn't work.
> See drivers/net/ethernet/i825xx/lasi_82596.c, it uses dma*sync()
> functions.

That's actually a weird result.  The 32 bit machines have two cases:
those that can make uncached memory by setting the U bit (and thus
don't need the sync operations in the lasi and D700 drivers) and those
that can't.  The latter is basically only the old 700 series.  The B180
is in the class of can set pages to uncached, so it sounds like
something in our uncached memory allocation for dma areas is failing
after this patch set.

I still have an old 700 in my box of curiosities, so I can try to dust
it off and plug it back in when I get home to see what it makes of the
series when it gets fixed.

James

James


From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 14 May 2012 06:11:45 +0000
Subject: Re: [PATCH] sparc32: Move cache and TLB flushes over to method ops.
Message-Id: <20120514061145.GA22507@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20120513.235611.828382132525916634.davem@davemloft.net>
In-Reply-To: <20120513.235611.828382132525916634.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, May 13, 2012 at 11:56:11PM -0400, David Miller wrote:
> 
> This eliminated most of the remaining users of btfixup.
> 
> There are some complications because of the special cases we
> have for sun4d, leon, and some flavors of viking.
> 
> It was found that there are no cases where a flush_page_for_dma
> method was not hooked up to something, so the "noflush" iommu
> methods were removed.
> 
> Add some documentation to the viking_sun4d_smp_ops to describe exactly
> the hardware bug which causes us to need special TLB flushing on
> sun4d.
> 
> Signed-off-by: David S. Miller <davem@davemloft.net>
> ---
> 
> Sam, I don't want to push this out until someone at least smoke
> tests a sun4m boot on at least one piece of hardware.  Can you
> do a quick test boot for me?

UP builds and boots.
SMP builds and boots.

Kjetil said (in private mail) that he would try to get his SS1000
operational and test later this week.
So this will also cover at least one viking variant.

> We're really close to killing off btfixup after this one.
:-)

> I think
> for things like the hard_smp_processor_id() thing I'll use a
> special ELF section of insn patchups as I do on sparc64.
load_current looks like it requires some special treatment too.

> The rest can be ops, maybe we need three sets: smp_ipi_ops, clk_ops,
> and irq_ops.  Something like that.
The cachetlb stuff was the most complicated, the remaining should
be trivial compared to this.
I will look into one or some of the _ops cases later this week.

Looking through the patch all looks good.
I like how LEON becomes more in sync with the other platforms
with this change too.

	Sam

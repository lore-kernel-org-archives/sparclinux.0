From: Ingo Molnar <mingo@elte.hu>
Date: Thu, 13 Aug 2009 07:04:02 +0000
Subject: Re: [PATCH resend 0/8] sparc: use asm-generic/dma-mapping-common.h
Message-Id: <20090813070402.GE12143@elte.hu>
List-Id: <sparclinux.vger.kernel.org>
References: <1249872797-1314-1-git-send-email-fujita.tomonori@lab.ntt.co.jp> <20090812.163427.161326946.davem@davemloft.net>
In-Reply-To: <20090812.163427.161326946.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: fujita.tomonori@lab.ntt.co.jp, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, tony.luck@intel.com, fenghua.yu@intel.com


* David Miller <davem@davemloft.net> wrote:

> From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
> Date: Mon, 10 Aug 2009 11:53:09 +0900
> 
> > This is the repost of the patchset (as Ingo asked me offline) :
> > 
> > http://lkml.org/lkml/2009/7/13/20
> > 
> > There is no functional change. I just added David's ack to #3-8
> > patches and Robert's Tested-by to #8 patch.
> > 
> > I confirmed that it can be applied cleanly to mainline, -next, and
> > -tip trees.
> > 
> > The git tree is also available:
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/tomo/linux-2.6-misc.git 
> > sparc
> 
> I just made a quick build test on sparc32 and sparc64, as well as 
> a non-debug execution test on sparc64 and it all looks fine.
> 
> Thanks for doing this work!
> 
> I assume Ingo or someone else is going to merge this stuff?

Yeah, it's in the tip:core/iommu tree:

451d740: sparc: Add CONFIG_DMA_API_DEBUG support
ee664a9: sparc: Use asm-generic/pci-dma-compat
c2c07db: sparc: Replace sbus_map_single and sbus_unmap_single with sbus_map_page and sbus_unmap_page
595cc85: sparc: Remove no-op dma_4v_sync_single_for_cpu and dma_4v_sync_sg_for_cpu
02f7a18: sparc: Use asm-generic/dma-mapping-common.h
bc0a14f: sparc: Use dma_map_ops struct

and pushed out to linux-next as well and present there as well.

I did a cross-build test of Sparc before i pushed it out, but it 
would be nice if you could check the end result linux-next as well 
... just in case. (whenever you get around to do it - there's no 
urgency.)

	Ingo

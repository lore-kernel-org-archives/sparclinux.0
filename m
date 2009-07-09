From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Date: Thu, 09 Jul 2009 09:55:30 +0000
Subject: Re: [PATCH 2/5] sparc: use asm-generic/dma-mapping-common.h
Message-Id: <20090709185505X.fujita.tomonori@lab.ntt.co.jp>
List-Id: <sparclinux.vger.kernel.org>
References: <1246860820-20629-3-git-send-email-fujita.tomonori@lab.ntt.co.jp>
	<200907061026.28878.arnd@arndb.de>
	<20090706.181131.92078657.davem@davemloft.net>
In-Reply-To: <20090706.181131.92078657.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net
Cc: arnd@arndb.de, fujita.tomonori@lab.ntt.co.jp, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, reif@earthlink.net

On Mon, 06 Jul 2009 18:11:31 -0700 (PDT)
David Miller <davem@davemloft.net> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> Date: Mon, 6 Jul 2009 10:26:28 +0200
> 
> > On Monday 06 July 2009, FUJITA Tomonori wrote:
> >> +static inline struct dma_map_ops *get_dma_ops(struct device *dev)
> >> +{
> >> +       return dma_ops;
> >> +}
> >> +
> >> +#define flush_write_buffers()
> >> +
> >> +#include <asm-generic/dma-mapping-common.h>
> > 
> > I still think the flush_write_buffers() x86-ism should not be required
> > to use dma-mapping-common.h and only be used in arch/x86/kernel/pci-nommu.c
> > so you don't have to add dummy definitions to all architectures.
> > 
> > See http://lkml.org/lkml/2009/6/30/134
> > 
> > Otherwise, your series looks good!
> 
> Since we have until the 2.6.32 merge window to merge this, why
> don't we take care of this flush_write_buffers() thing first?
>
> I'm completely fine with these changes otherwise, thanks!

The logic to move flush_write_buffers() from dma-mapping-common.h to
arch/x86/kernel/pci-nommu.c makes sense and it doesn't break anything.
However, I'd like to see the confirmation from a person who added
flush_write_buffers() long ago. I thought that we might overlook
something subtle.

I'll put Arnd's patch in the next submission if you like.


btw, Robert asked me about the dma-debug feature so I uploaded the new
version (I also found and fixed one bug wrt dma_{alloc|free}_coherent
for pci devices on SPARC32):

git://git.kernel.org/pub/scm/linux/kernel/git/tomo/linux-2.6-misc.git sparc

From: David Miller <davem@davemloft.net>
Date: Tue, 07 Jul 2009 01:11:31 +0000
Subject: Re: [PATCH 2/5] sparc: use asm-generic/dma-mapping-common.h
Message-Id: <20090706.181131.92078657.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1246860820-20629-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
	<1246860820-20629-3-git-send-email-fujita.tomonori@lab.ntt.co.jp>
	<200907061026.28878.arnd@arndb.de>
In-Reply-To: <200907061026.28878.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: arnd@arndb.de
Cc: fujita.tomonori@lab.ntt.co.jp, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, reif@earthlink.net

From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 6 Jul 2009 10:26:28 +0200

> On Monday 06 July 2009, FUJITA Tomonori wrote:
>> +static inline struct dma_map_ops *get_dma_ops(struct device *dev)
>> +{
>> +       return dma_ops;
>> +}
>> +
>> +#define flush_write_buffers()
>> +
>> +#include <asm-generic/dma-mapping-common.h>
> 
> I still think the flush_write_buffers() x86-ism should not be required
> to use dma-mapping-common.h and only be used in arch/x86/kernel/pci-nommu.c
> so you don't have to add dummy definitions to all architectures.
> 
> See http://lkml.org/lkml/2009/6/30/134
> 
> Otherwise, your series looks good!

Since we have until the 2.6.32 merge window to merge this, why
don't we take care of this flush_write_buffers() thing first?

I'm completely fine with these changes otherwise, thanks!

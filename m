From: David Miller <davem@davemloft.net>
Date: Tue, 18 May 2010 19:34:35 +0000
Subject: Re: sun4v_data_access_exception during access to hardware
Message-Id: <20100518.123435.223498021.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100513.042552.242119562.davem@davemloft.net>
In-Reply-To: <20100513.042552.242119562.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Alex Mach" <alexvm12e@mail.ru>
Date: Tue, 18 May 2010 17:41:06 +0400

> 
>> This driver is terribly non-portable and needs some work before you'll
>> be able to use it on sparc64.
> 
> Could you call any driver that was succesfully ported on Sparc and
> which use access to physical IO space, please?

Only drivers/net/niu.c does, it does the physical address handling
by hand.

You can't use the DMA interfaces because dma_addr_t is 32-bits and
there is no reason to bloat up the kernel by making it 64-bits
just for one or two drivers that want to work with real physical
addresses instead of DMA addresses.

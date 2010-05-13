From: David Miller <davem@davemloft.net>
Date: Thu, 13 May 2010 11:43:10 +0000
Subject: Re: sun4v_data_access_exception during access to hardware
Message-Id: <20100513.044310.200349868.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100513.042552.242119562.davem@davemloft.net>
In-Reply-To: <20100513.042552.242119562.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Alex Mach <alexvm12e@mail.ru>
Date: Thu, 13 May 2010 15:38:37 +0400

> 
>> It's trying to call the dma_*() APIs with a NULL pointer.
>> 
>> That isn't supported.
> 
> 
> If I use buffer memory with dma access I have messages
> 
> [   28.164095] Unable to handle kernel NULL pointer dereference

The device doesn't have the proper backing information for the DMA
layer on sparc64 requires, it needs an IOMMU struct pointer and other
bits in the arch level device area setup properly.  And for non-PCI
devices this isn't going to happen.

This isn't going to get fixed by simple changes, I'm sorry to inform
you :-)

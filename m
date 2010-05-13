From: David Miller <davem@davemloft.net>
Date: Thu, 13 May 2010 11:28:47 +0000
Subject: Re: sun4v_data_access_exception during access to hardware
Message-Id: <20100513.042847.116397139.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100513.042552.242119562.davem@davemloft.net>
In-Reply-To: <20100513.042552.242119562.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Thu, 13 May 2010 04:25:52 -0700 (PDT)

> From: Alex Mach <alexvm12e@mail.ru>
> Date: Thu, 13 May 2010 14:18:58 +0400
> 
>> Hello,
>> 
>> I'd like use ethoc driver for OpenCores MAC under Linux (2.6.33). I'm using OpenSparc T1 on FPGA. I have hardware device (OpenCores MAC) at address 0xFFF0C2C100. So I added device to platform bus with IORESOURCE_MEM (io memory space) at 0xFFF0C2C100. 
>> 
>> devm_ioremap_nocache() return OK but during ethoc driver initialization I have following messages:
> 
> It's trying to call the dma_*() APIs with a NULL pointer.
> 
> That isn't supported.

And even if we made that work, this driver assumes that it can run
virt_to_phys() on pointers returned from both with DMA allocation and
ioremap().

This driver is terribly non-portable and needs some work before you'll
be able to use it on sparc64.

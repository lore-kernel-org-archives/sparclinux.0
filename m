From: David Miller <davem@davemloft.net>
Date: Thu, 26 Sep 2013 04:23:04 +0000
Subject: Re: SILO always tells it loaded kernel version 3.6.0
Message-Id: <20130926.002304.2121420558807412031.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1309260234380.22367@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1309260234380.22367@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Thu, 26 Sep 2013 02:36:59 +0300 (EEST)

> Just a curious thing I noticed: in the past, SILO told what version of 
> kernel it loaded. Nowadays with newer kernels, it always tells
> Loaded kernel version 3.6.0
> asi it would be stuck in 3.6.0. Is it something silo does strangely or 
> do we put bad magic number into kernel image nowadays?

Works fine here:

SILO Version 1.4.14
boot: linux.311
Allocated 64 Megs of memory at 0x40000000 for kernel
Loaded kernel version 3.11.0

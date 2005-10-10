From: "David S. Miller" <davem@davemloft.net>
Date: Mon, 10 Oct 2005 18:15:08 +0000
Subject: Re: Yesterdays git does not boot on U5
Message-Id: <20051010.111508.39801009.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0510101057330.28936@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0510101057330.28936@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Mon, 10 Oct 2005 10:58:49 +0300 (EEST)

> did my daily git sparc64 kernel build on my Ultra 5 and this time it 
> does not boot at all. SILO tells
> Allocated 8 Megs of memory at 0x40000000 for kernel
> Uncompressing image...
> Loaded kernel version 2.6.14
> 
> Remapping the kernel... done.
> 
> and hangs there.

Always retry boot failures with the "-p" flag specified on the kernel
command line so you can report the maximum amount of kernel log
information.

Thanks.

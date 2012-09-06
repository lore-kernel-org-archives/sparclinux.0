From: David Miller <davem@davemloft.net>
Date: Thu, 06 Sep 2012 18:08:24 +0000
Subject: Re: PCI Radeon RV100 detection hang on sparc64
Message-Id: <20120906.140824.949264941378150416.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1209061032360.371@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1209061032360.371@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mroos@linux.ee
Cc: sparclinux@vger.kernel.org, dri-devel@lists.freedesktop.org

From: Meelis Roos <mroos@linux.ee>
Date: Thu, 6 Sep 2012 17:41:13 +0300 (EEST)

> And here the machine hangs. Debugging printk-s reveal that it does not 
> find any active I/O port resources and then continues into initializing 
> the card. Down in igp_read_bios_from_vram() it successfully ioremaps 
> memory region 0 (vram_basef08000000 and size@000) and tries to read 
> 2 bytes from there and hangs on reading bios[0].

Mappings obtained from ioremap() may not be derefenced directly.

What you get back from ioremap() isn't a pointer.  It's an opaque
__iomem cookie, which must only be used via readl() et al.

On sparc64 ioremap() happens to return a physical address, that's why
this non-portable code crashes.

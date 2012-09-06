From: David Miller <davem@davemloft.net>
Date: Thu, 06 Sep 2012 18:15:43 +0000
Subject: Re: PCI Radeon RV100 detection hang on sparc64
Message-Id: <20120906.141543.827356968030216963.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1209061032360.371@math.ut.ee>
	<1346950277.3912.152.camel@atropine>
In-Reply-To: <1346950277.3912.152.camel@atropine>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ajax@redhat.com
Cc: mroos@linux.ee, sparclinux@vger.kernel.org, dri-devel@lists.freedesktop.org

From: Adam Jackson <ajax@redhat.com>
Date: Thu, 06 Sep 2012 12:51:17 -0400

> On Thu, 2012-09-06 at 17:41 +0300, Meelis Roos wrote:
> 
>> And here the machine hangs. Debugging printk-s reveal that it does not 
>> find any active I/O port resources and then continues into initializing 
>> the card. Down in igp_read_bios_from_vram() it successfully ioremaps 
>> memory region 0 (vram_basef08000000 and size@000) and tries to read 
>> 2 bytes from there and hangs on reading bios[0].
> 
> This is probably because...

I think the real issue is that the VRAM bios reading code is buggy, see
my other email.  It deferences ioremap()'d memory, and that's not allowed.

One must use the proper __iomem pointer accessors, such as readl(), readb(),
etc.

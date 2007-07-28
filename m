From: Meelis Roos <mroos@linux.ee>
Date: Sat, 28 Jul 2007 08:55:13 +0000
Subject: Re: new parport_pc BUG
Message-Id: <Pine.SOC.4.64.0707281148140.13153@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0707272224450.1678@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0707272224450.1678@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> This patch is big, but this transformation has been pending for
> a long time, and I tested that parport_pc works on my ultra5.
> 
> Can you test it for me?

Floppy does not compile, seems to depend on some PCI header?

  CC      drivers/block/floppy.o
In file included from drivers/block/floppy.c:241:
include/asm/floppy.h: In function 'sun_pci_fd_enable_dma':
include/asm/floppy.h:383: error: implicit declaration of function 'pci_map_single'
include/asm/floppy.h: In function 'sun_pci_fd_disable_dma':
include/asm/floppy.h:400: error: implicit declaration of function 'pci_unmap_single'
include/asm/floppy.h: In function 'sun_pci_fd_set_dma_mode':
include/asm/floppy.h:410: error: 'PCI_DMA_TODEVICE' undeclared (first use in this function)
include/asm/floppy.h:410: error: (Each undeclared identifier is reported only once
include/asm/floppy.h:410: error: for each function it appears in.)
include/asm/floppy.h:412: error: 'PCI_DMA_FROMDEVICE' undeclared (first use in this function)
make[2]: *** [drivers/block/floppy.o] Error 1


-- 
Meelis Roos (mroos@linux.ee)

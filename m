From: "David S. Miller" <davem@davemloft.net>
Date: Thu, 10 Mar 2005 19:40:51 +0000
Subject: Re: ebus & ioremap?
Message-Id: <20050310114051.0b99ef10.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0503101440500.12047@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0503101440500.12047@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, 10 Mar 2005 14:42:56 +0200 (EET)
Meelis Roos <mroos@linux.ee> wrote:

> While trying to see if I can cleanly fix the iomem warnings for sparc 
> floppy, I came to stop ath this code at asm/floppy.5:653
> 
>                  /* XXX ioremap */
>                  sun_pci_fd_ebus_dma.regs = edev->resource[1].start;
> 
> I can understand why someone did put a XXX there but why does it work 
> this way?

On sparc64, we store the physical I/O address in the resources,
and that is what the I/O accessor routines take as well.

Therefore ioremap() just pass the address through unchanged, they
are just a NOP.

From: Eric Brower <ebrower@gmail.com>
Date: Fri, 11 Mar 2005 18:47:10 +0000
Subject: Re: ebus & ioremap?
Message-Id: <ec7cefb05031110473741aae6@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0503101440500.12047@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0503101440500.12047@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From asm/io.h:

/* On sparc64 we have the whole physical IO address space accessible
 * using physically addressed loads and stores, so this does nothing.
 */
static inline void __iomem *ioremap(unsigned long offset, unsigned long size)
{
    return (void __iomem *)offset;
}

It is nice to use ioremap to remain idiomatic with other
architectures, though, esp. in drivers and the like.

E



On Thu, 10 Mar 2005 14:42:56 +0200 (EET), Meelis Roos <mroos@linux.ee> wrote:
> While trying to see if I can cleanly fix the iomem warnings for sparc
> floppy, I came to stop ath this code at asm/floppy.5:653
> 
>                  /* XXX ioremap */
>                  sun_pci_fd_ebus_dma.regs = edev->resource[1].start;
> 
> I can understand why someone did put a XXX there but why does it work
> this way?
> 
> --
> Meelis Roos (mroos@linux.ee)
> -
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
E

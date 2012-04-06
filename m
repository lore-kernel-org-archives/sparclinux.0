From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 06 Apr 2012 20:13:55 +0000
Subject: Re: sparc32 paging fault which I cannot explain
Message-Id: <20120406201355.GA8403@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20120406152619.GA17138@merkur.ravnborg.org>
In-Reply-To: <20120406152619.GA17138@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Apr 06, 2012 at 12:38:07PM -0400, David Miller wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Fri, 6 Apr 2012 17:26:19 +0200
> 
> > What I think happens is that the MMU is not setup to handle virtual addresses
> > in this area - as this is a much higher address than what we would have seen
> > with the old bootmem allocator. memblock allocates top-down, where bootmem
> > allocates bottom-up.
> 
> The first 16MB at KERNBASE is mapped by the head.S code, the rest is
> mapped by arch/sparc/srmmu.c:map_kernel() and similar.

Thanks - it helped me further.

In reality I got page-fault if I tried to access anything at
PAGE_OFFSET + 0xa00000 or above.

So the limit is less than 16 MB.

I found out using a loop like this:

	unsigned long paddr;
        for (paddr = 0x781000; paddr < 0x1fa0fff; paddr += 0x1000)
        {
                int tmp;

                tmp = *(int *)(PAGE_OFFSET + paddr);
                printk(KERN_ERR "paddr=0x%lx (%d)\n", paddr, tmp);
        }

And at 0xa00000 is faulted. But at 0x9ff000 it was OK.
So I just introduced a limit of 0xa00000 for __alloc_bootmem_low().

I found no evidence that 0xa00000 will work in general.
So testing is required here :-(

	Sam
